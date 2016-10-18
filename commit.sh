#!/bin/bash

##
# Copyright 2016 Fabian Damken
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##



set -o errexit
set -o nounset

date="$1"
courses=""
git add --all
for module in $(git status | grep tex | awk '{ print $3 }'); do
	dir="$(dirname "$module")"
	texfile="$(basename "$module")"

	cd "$dir"

	pdflatex "$texfile"
	pdflatex "$texfile"
	pdflatex "$texfile"
	pdflatex "$texfile"
	pdflatex "$texfile"

	if [[ "$courses" == "" ]]; then
		courses="$(cat module_name)"
	else
		courses="$courses, $(cat module_name)"
	fi
done
git add --all
git commit -m "Datum: $date; Vorlesungen: $courses"
