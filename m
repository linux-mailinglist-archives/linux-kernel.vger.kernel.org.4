Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F66F7993
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjEDXFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEDXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:05:02 -0400
X-Greylist: delayed 3682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 16:04:57 PDT
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0B12E87
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 16:04:57 -0700 (PDT)
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Lw3fS011081
        for <linux-kernel@vger.kernel.org>; Thu, 4 May 2023 18:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=myC7ZoJ7k6DjnStvOQ5FAoWwORpoOfaq/9mQbYsPmmQ=;
 b=I9HNJFrJnApxLp+dPTjh9988ylpFKelzOsPGpT5ieb0L3di7rQOyqySQNfRO4aH43Apg
 WhzcMLr6tutXtaniqGYEE4Zk0gfxcGNBMdmWd5PKc1VSxO+W5C1ZW/CzMp3qONJgsXTc
 vczhdV1vFWn9awmTSD9k3ZZ0y7Uqcrgv1o5WUwCiYz0mE5HcR6O9dqFiZzLa5EPb0QZ0
 Rmmbc3WzEWPMgL4gY+WG4hsU2p198YCOvW+YTNt5tjwlgL4xTF8mas6FA+rUaZj5j18Q
 9HgOmWDPMpPjsoaq6uIShXvxMXQulgGoACuymumHEaOZhfwzs3FJJJ4XAFNo6/y3vB83 CA== 
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3qcn39g1ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 18:03:34 -0400
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61b5f526a79so15814156d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237814; x=1685829814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myC7ZoJ7k6DjnStvOQ5FAoWwORpoOfaq/9mQbYsPmmQ=;
        b=hlFGxXy+Mtdgln5pzI62JwkKpkhUXwW33lEH66PnllbZaqTJFhI0tUuNK0G30vTEoA
         D0q4NcRk/DmovDe48HehAag9mkTC6KekybJIQUG8b10dsM65gzXQaqrjurQ1xKK87iP0
         MUwKox0nVpky/66LTcbYZ8/Ad6bnPBzYpVcXAzAspJg0Z1hzl7wLjBCdbtEesSmGiuZt
         iSl+7LQF2UzZYYHQXOZJN9RzHIYrA2i3xtCx/CoafPJ++yZo4XZq81DiqedGstHwsNqJ
         3nDOS0G6aDApoNs/hAhSGH0AGKBFcKSFsbXDbRD1H1Tg68/RNWE+7/qgEdLBZ7pUQ/sS
         hKVQ==
X-Gm-Message-State: AC+VfDzOVIV5HUWbxCgpYBZJK9dSlhtdnF+SZrXg74ZZVLK0sCLWKacm
        48c0ybp19H92yQW97NfPfLUhgBLeoA/rAPyIrsFEMVf8rSg8sBOsBju1JH/Wr1ioBTIA7LzdtMk
        8/syyGMME5kGAr8CuzI5soqGoXwnxmV96WA==
X-Received: by 2002:a05:6214:2521:b0:61c:c8d0:ebad with SMTP id gg1-20020a056214252100b0061cc8d0ebadmr5090900qvb.1.1683237813849;
        Thu, 04 May 2023 15:03:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jSnEkTbraPrQwsJWtnGEyrxB7g2PmIatdThbI9VXcYENQCPTZzR+85CsbQqfQLrIqXxVOjw==
X-Received: by 2002:a05:6214:2521:b0:61c:c8d0:ebad with SMTP id gg1-20020a056214252100b0061cc8d0ebadmr5090858qvb.1.1683237813478;
        Thu, 04 May 2023 15:03:33 -0700 (PDT)
Received: from nyu-lexis.net.nyu.edu (216-165-95-149.natpool.nyu.edu. [216.165.95.149])
        by smtp.gmail.com with ESMTPSA id y9-20020a0c9a89000000b0061b58b07130sm53261qvd.137.2023.05.04.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:03:33 -0700 (PDT)
From:   Jinli Xiao <jinli.xiao@nyu.edu>
Cc:     irogers@google.com, Jinli Xiao <jinli.xiao@nyu.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2] perf python: Set error messages on call failure
Date:   Thu,  4 May 2023 18:02:48 -0400
Message-Id: <20230504220254.54468-1-jinli.xiao@nyu.edu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zs9hgBWnurT8cdBHeaDPqDJQ_5jMrM03
X-Proofpoint-GUID: zs9hgBWnurT8cdBHeaDPqDJQ_5jMrM03
X-Orig-IP: 209.85.219.72
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040178
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the perf python binding to provide more informative error
messages to the user when there is a call failure. The changes include
setting error messages on several different scenarios when the package
needs to return -1 or NULL.

Resolves the FIXME in evsel__init, which previously raises segmentation
fault on failure. Now it could end more gracefully.

The shell tests provided also includes the import test, previously
written in c (https://marc.info/?l=linux-kernel&m=135911158512404). In
order to run the test, python3 and setting PYTHONPATH (to include the
perf python package) is needed.

Signed-off-by: Jinli Xiao <jinli.xiao@nyu.edu>
---
 tools/perf/tests/shell/test_python_binding.sh | 113 ++++++++++++++++++
 tools/perf/util/python.c                      |  35 ++++--
 2 files changed, 141 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_python_binding.sh

diff --git a/tools/perf/tests/shell/test_python_binding.sh b/tools/perf/tests/shell/test_python_binding.sh
new file mode 100755
index 000000000000..99d0033ff4c5
--- /dev/null
+++ b/tools/perf/tests/shell/test_python_binding.sh
@@ -0,0 +1,113 @@
+#!/bin/bash
+# perf python binding test
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+set -e
+
+if [ "x$PYTHON" == "x" ]
+then
+	if which python3 > /dev/null
+	then
+		PYTHON=python3
+	elif which python > /dev/null
+	then
+		PYTHON=python
+	else
+		echo Skipping test, python not detected please set environment variable PYTHON.
+		exit 2
+	fi
+fi
+
+if [ "x$PYTHONPATH" == "x" ]
+then
+    echo Skipping test, PYTHONPATH not set.
+    exit 2
+fi
+
+test_python_import()
+{
+    echo -n "Checking python binding: import perf "
+    $PYTHON -c "import perf"
+    echo "[Success]"
+}
+
+test_thread_map_exception_handling()
+{
+    echo -n "Checking python binding: thread map exception handling "
+    MAX_PID=$(cat /proc/sys/kernel/pid_max)
+    INVALID_PID=$((MAX_PID + 1))
+    $PYTHON -c "
+import perf
+try:
+    perf.thread_map($INVALID_PID)
+    raise
+except FileNotFoundError as e:
+    pass
+"
+    echo "[Success]"
+}
+
+test_cpu_map_exception_handling()
+{
+    echo -n "Checking python binding: cpu map exception handling "
+    MAX_CPU=$(lscpu | awk '/^CPU\(s\)/ {print $2}')
+    INVALID_CPU_ID="$((MAX_CPU + 1))"
+    $PYTHON -c "
+import perf
+try:
+    perf.cpu_map('$INVALID_CPU_ID')
+    raise
+except RuntimeError as e:
+    pass
+"
+    echo "[Success]"
+}
+
+test_evsel_exception_handling()
+{
+    echo -n "Checking python binding: evsel exception handling "
+    $PYTHON -c "
+import perf
+
+perf.evsel()
+
+try:
+    perf.evsel(a=1) # invalid args
+    raise
+except TypeError as e:
+    pass
+
+try:
+    perf.evsel(sample_freq=1, sample_period=1)
+except ValueError as e:
+    pass
+"
+    echo "[Success]"
+}
+
+test_evlist_read_on_cpu_exception_handling()
+{
+    echo -n "Checking python binding: evlist read_on_cpu exception handling "
+    $PYTHON -c "
+import perf
+
+cpus = perf.cpu_map()
+threads = perf.thread_map(-1)
+evlist = perf.evlist(cpus, threads)
+
+try:
+    evlist.read_on_cpu(0)
+    raise
+except RuntimeError as e:
+    pass
+"
+    echo "[Success]"
+}
+
+test_python_import
+test_thread_map_exception_handling
+test_cpu_map_exception_handling
+test_evsel_exception_handling
+test_evlist_read_on_cpu_exception_handling
+
+exit 0
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 42e8b813d010..2d01a03fa40a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -639,8 +639,13 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
 		return -1;
 
 	pcpus->cpus = perf_cpu_map__new(cpustr);
-	if (pcpus->cpus == NULL)
+	if (pcpus->cpus == NULL) {
+		if (errno)
+			PyErr_SetFromErrno(PyExc_OSError);
+		else
+			PyErr_SetString(PyExc_ValueError, "perf: invalid cpu string");
 		return -1;
+	}
 	return 0;
 }
 
@@ -708,8 +713,13 @@ static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
 		return -1;
 
 	pthreads->threads = thread_map__new(pid, tid, uid);
-	if (pthreads->threads == NULL)
+	if (pthreads->threads == NULL) {
+		if (errno)
+			PyErr_SetFromErrno(PyExc_OSError);
+		else
+			PyErr_SetString(PyExc_ValueError, "perf: fails to create thread map");
 		return -1;
+	}
 	return 0;
 }
 
@@ -763,6 +773,7 @@ static int pyrf_thread_map__setup_types(void)
 struct pyrf_evsel {
 	PyObject_HEAD
 
+	bool initialized;
 	struct evsel evsel;
 };
 
@@ -839,13 +850,19 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 					 &enable_on_exec, &task, &watermark,
 					 &precise_ip, &mmap_data, &sample_id_all,
 					 &attr.wakeup_events, &attr.bp_type,
-					 &attr.bp_addr, &attr.bp_len, &idx))
+					 &attr.bp_addr, &attr.bp_len, &idx)) {
+		pevsel->initialized = false;
 		return -1;
+	}
 
 	/* union... */
 	if (sample_period != 0) {
-		if (attr.sample_freq != 0)
-			return -1; /* FIXME: throw right exception */
+		if (attr.sample_freq != 0) {
+			pevsel->initialized = false;
+			PyErr_SetString(PyExc_ValueError,
+					"perf: sample_freq and sample_period are mutually exclusive");
+			return -1;
+		}
 		attr.sample_period = sample_period;
 	}
 
@@ -872,12 +889,14 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.size	    = sizeof(attr);
 
 	evsel__init(&pevsel->evsel, &attr, idx);
+	pevsel->initialized = true;
 	return 0;
 }
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	evsel__exit(&pevsel->evsel);
+	if (pevsel->initialized)
+		evsel__exit(&pevsel->evsel);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
@@ -1098,7 +1117,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 	md = get_md(evlist, cpu);
 	if (!md)
-		return NULL;
+		return PyErr_Format(PyExc_RuntimeError, "perf: no mmap for cpu %d", cpu);
 
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
@@ -1324,6 +1343,8 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
 #ifndef HAVE_LIBTRACEEVENT
+	PyErr_SetString(PyExc_OSError,
+			"perf: tracepoint support not compiled in");
 	return NULL;
 #else
 	struct tep_event *tp_format;
-- 
2.39.2

