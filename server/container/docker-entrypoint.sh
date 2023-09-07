#!/bin/bash

exec supervisord

exec "$@"