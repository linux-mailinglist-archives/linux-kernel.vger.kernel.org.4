Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84B6F4BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEBVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEBVKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:10:04 -0400
X-Greylist: delayed 2266 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 14:10:02 PDT
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7110E3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:10:02 -0700 (PDT)
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342I6FI2005656
        for <linux-kernel@vger.kernel.org>; Tue, 2 May 2023 16:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=wp9qLLSPZ5o0mSKK6LhGAR9ze3MtsABv/8Wd7xrHKBA=;
 b=bIt/V3ZOdnrAEUAWttjS4IT3KxBalchsQRLXczHmu2JAnlGYJjbnN/72ZY4gMvGgR/py
 KvgoYKGmf9v/lublovxzse2V90kVYyXUgiv21OSmy53mypY80wPHXj/zIkbgQ0DPZYJg
 1XrDtqGWjc1WJZkMAT4Z2KAhiTwj03WvVlecnWzg8QH0sdBexjMwQjBoJyzrL1Tplgju
 wMQul/gicohM20r15EEvUEavux2G9UEsC7id2EpJ6sZDrepKx3LIUOEb64GkX8zkmW4x
 Nh1EcJ/q2/lMhJyafX3bdcm2UEQMyfwuFxY1XJ6H/+bXitBY+pyHAl29HUkzNk+757qZ VQ== 
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q8uv0n7nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 16:32:15 -0400
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61a66010dd7so16767026d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059516; x=1685651516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wp9qLLSPZ5o0mSKK6LhGAR9ze3MtsABv/8Wd7xrHKBA=;
        b=gc6GWsmGh4ZmknYsdxbVNQINBfVzmuTYUi8Hrpba+TNpaEgvNQdrjvswkY2Eax8z5T
         Krt605cPV0pXw5Nxi1J9ZYdEz/DcHzT91vaxRpI8hJ6ANslVnnk2/pqDcspSN0kZu7Md
         SsiLwBTSZJtj1G4HUPMQn19cqsKYQojpOyDKKBNUKorg4RlFQ/E1di0CrhQLgQDeDG6r
         /+hwciW1TCLGcAjVVqAV89dqr8o80JANTcs5yohzHkdNG/CAl7momYPt8exGtyuw/pSg
         OFVAggAlrTWeVYSr/rlMOMJGPQYBGJtCUZkkabsNQc8JIB6UjmJgNWjvkW484E463QQQ
         tG1Q==
X-Gm-Message-State: AC+VfDw4o7Tc6X9WysHA4UP+QcFqjL4DPfp229zllZDEiHwL0GtDUrBc
        QhVfkO+obXN9KjhY3cFDXAPExT+wmELk1aqB92thoCFAMczsyNE7VvcR81+3Hz239YcARx2lpQ9
        L0Q2FjeJQGb1iNpkazFL4b43i6QW93OT3CA==
X-Received: by 2002:a05:6214:21ef:b0:5f0:f0c3:59a8 with SMTP id p15-20020a05621421ef00b005f0f0c359a8mr6152934qvj.22.1683059515865;
        Tue, 02 May 2023 13:31:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4e/aybbIYFMxDsNzm9j7Q5eDJsxYucYe8IAC0y/ZHiMjLyKfkyZyEvwMLSSAn4kotNVtvY1Q==
X-Received: by 2002:a05:6214:21ef:b0:5f0:f0c3:59a8 with SMTP id p15-20020a05621421ef00b005f0f0c359a8mr6152906qvj.22.1683059515556;
        Tue, 02 May 2023 13:31:55 -0700 (PDT)
Received: from nyu-lexis.net.nyu.edu (216-165-95-191.natpool.nyu.edu. [216.165.95.191])
        by smtp.gmail.com with ESMTPSA id w12-20020ac857cc000000b003f20ec69b1asm3359380qta.17.2023.05.02.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:31:55 -0700 (PDT)
From:   Jinli Xiao <jinli.xiao@nyu.edu>
Cc:     Jinli Xiao <jinli.xiao@nyu.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf python: Set error messages on call failure
Date:   Tue,  2 May 2023 16:31:34 -0400
Message-Id: <20230502203135.24794-1-jinli.xiao@nyu.edu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0zRBl_J8tOzcHYZO_y7bImm0MuMHTWHh
X-Proofpoint-ORIG-GUID: 0zRBl_J8tOzcHYZO_y7bImm0MuMHTWHh
X-Orig-IP: 209.85.219.72
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 clxscore=1011
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305020175
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Jinli Xiao <jinli.xiao@nyu.edu>
---
 tools/perf/util/python.c | 61 ++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 42e8b813d010..7e6b12e87744 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -635,12 +635,16 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
 	char *cpustr = NULL;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|s",
-					 kwlist, &cpustr))
+					 kwlist, &cpustr)) {
+		PyErr_BadArgument();
 		return -1;
+	}
 
 	pcpus->cpus = perf_cpu_map__new(cpustr);
-	if (pcpus->cpus == NULL)
+	if (pcpus->cpus == NULL) {
+		PyErr_SetFromErrno(PyExc_OSError);
 		return -1;
+	}
 	return 0;
 }
 
@@ -704,12 +708,16 @@ static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
 	int pid = -1, tid = -1, uid = UINT_MAX;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|iii",
-					 kwlist, &pid, &tid, &uid))
+					 kwlist, &pid, &tid, &uid)) {
+		PyErr_BadArgument();
 		return -1;
+	}
 
 	pthreads->threads = thread_map__new(pid, tid, uid);
-	if (pthreads->threads == NULL)
+	if (pthreads->threads == NULL) {
+		PyErr_SetFromErrno(PyExc_OSError);
 		return -1;
+	}
 	return 0;
 }
 
@@ -839,13 +847,18 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 					 &enable_on_exec, &task, &watermark,
 					 &precise_ip, &mmap_data, &sample_id_all,
 					 &attr.wakeup_events, &attr.bp_type,
-					 &attr.bp_addr, &attr.bp_len, &idx))
+					 &attr.bp_addr, &attr.bp_len, &idx)) {
+		PyErr_BadArgument();
 		return -1;
+	}
 
 	/* union... */
 	if (sample_period != 0) {
-		if (attr.sample_freq != 0)
-			return -1; /* FIXME: throw right exception */
+		if (attr.sample_freq != 0) {
+			PyErr_SetString(PyExc_ValueError,
+					"perf: sample_freq and sample_period are mutually exclusive");
+			return -1;
+		}
 		attr.sample_period = sample_period;
 	}
 
@@ -892,8 +905,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	static char *kwlist[] = { "cpus", "threads", "group", "inherit", NULL };
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist,
-					 &pcpus, &pthreads, &group, &inherit))
+					 &pcpus, &pthreads, &group, &inherit)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	if (pthreads != NULL)
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
@@ -957,8 +972,10 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 
-	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
+	if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads)) {
+		PyErr_BadArgument();
 		return -1;
+	}
 
 	threads = ((struct pyrf_thread_map *)pthreads)->threads;
 	cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
@@ -980,8 +997,10 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 	int pages = 128, overwrite = false;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ii", kwlist,
-					 &pages, &overwrite))
+					 &pages, &overwrite)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	if (evlist__mmap(evlist, pages) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
@@ -999,8 +1018,10 @@ static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
 	static char *kwlist[] = { "timeout", NULL };
 	int timeout = -1, n;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &timeout))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|i", kwlist, &timeout)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	n = evlist__poll(evlist, timeout);
 	if (n < 0) {
@@ -1057,8 +1078,10 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 	PyObject *pevsel;
 	struct evsel *evsel;
 
-	if (!PyArg_ParseTuple(args, "O", &pevsel))
+	if (!PyArg_ParseTuple(args, "O", &pevsel)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	Py_INCREF(pevsel);
 	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
@@ -1093,12 +1116,16 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	int err;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
-					 &cpu, &sample_id_all))
+					 &cpu, &sample_id_all)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	md = get_md(evlist, cpu);
-	if (!md)
+	if (!md) {
+		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
+	}
 
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
@@ -1324,6 +1351,8 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
 #ifndef HAVE_LIBTRACEEVENT
+	PyErr_SetString(PyExc_OSError,
+			"perf: tracepoint support not compiled in");
 	return NULL;
 #else
 	struct tep_event *tp_format;
@@ -1332,8 +1361,10 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 	char *name = NULL;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ss", kwlist,
-					 &sys, &name))
+					 &sys, &name)) {
+		PyErr_BadArgument();
 		return NULL;
+	}
 
 	tp_format = trace_event__tp_format(sys, name);
 	if (IS_ERR(tp_format))
-- 
2.39.2

