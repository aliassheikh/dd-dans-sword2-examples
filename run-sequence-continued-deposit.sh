#!/usr/bin/env bash
#
# Copyright (C) 2022 DANS - Data Archiving and Networked Services (info@dans.knaw.nl)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEBUG_PORT=8000
SUSPEND=n
if [[ "$1" == "--suspend" ]]; then
 SUSPEND=y
 shift 1
fi

MAIN_CLASS="nl.knaw.dans.sword2examples.SequenceContinuedDeposit"
ARGS=$@

JARFILE=$(ls -1 target/*SNAPSHOT.jar)

CP_SEP=":"
# If windows use ";" as path separator
if [[ "$OSTYPE" == "msys" ]]; then
  CP_SEP=";"
fi

mvn dependency:copy-dependencies
java -agentlib:jdwp=transport=dt_socket,server=y,address=$DEBUG_PORT,suspend=$SUSPEND -cp "target/dependency/*$CP_SEP$JARFILE" $MAIN_CLASS $ARGS
