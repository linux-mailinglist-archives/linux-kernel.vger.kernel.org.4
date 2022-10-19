Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9A604412
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiJSL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiJSLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:55:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796650531
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:34:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J9LiWs000405;
        Wed, 19 Oct 2022 09:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=xVdMnr7Dez865sQjEHGnSfJDMoAThoZpm0ul2tW6EQo=;
 b=iQECIsPat2/UnKbraM6n+wAU58ofH5cOJuQBLjkjr51mJiER0qNpyO/hEQCkmU4csA3/
 2SfC7M40AXCr/j/kLnzgFZWSimAZJ/EraL7FGDOddZdhYkDPASyRQkdfm1JlyK8UfgYF
 tD9Rp0fEudW+ZK5pLISidAVxDw3zBQpYjNV0eHze+0/XfTBChgB1r51AyuoOXkdj7MaT
 ZLhsqkhkfkrYzK9BW38A3eLCRq6h5IT3lEl9UFQ331JOldu8fCT9XiE4npEugfMfAmQd
 kW2TFA79QhqPoaWDu9NM+DADIFrHuuUauhhzHny197+xkMjmMqfzaZn/jbvSmQkP2j96 pQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaehmgt2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:45:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J9b9iB024865;
        Wed, 19 Oct 2022 09:45:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jpu40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:45:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29J9jDdK35914092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 09:45:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D0C211C04A;
        Wed, 19 Oct 2022 09:45:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FBE111C050;
        Wed, 19 Oct 2022 09:45:11 +0000 (GMT)
Received: from localhost (unknown [9.43.12.146])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 09:45:11 +0000 (GMT)
Date:   Wed, 19 Oct 2022 15:15:09 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Akanksha J N <akanksha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
        <20221017105103.540a87c7@gandalf.local.home>
        <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
        <20221018112224.372a3484@gandalf.local.home>
In-Reply-To: <20221018112224.372a3484@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1666172148.1jppmgndx2.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4pzgCnL15RZnuupyVDDu4b7ROGBvK3UE
X-Proofpoint-GUID: 4pzgCnL15RZnuupyVDDu4b7ROGBvK3UE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_05,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 19 Oct 2022 00:19:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>=20
>> > You need to make sure that the "pause-on-trace" option is set or traci=
ng_on
>> > is set to 0 (disabled). Otherwise, if the tracing is still active, the=
n the
>> > reading of the trace file could potentially never end. =20
>>=20
>> initialize_ftrace() does this setting. So it must be set.
>> If you run the ftracetest on old kernel, this feature is not there and
>> it may cause a trouble. Naveen, can you clarify it?

Yes, the change to not pause on opening the trace file looks to be the=20
problem.

>=20
> But for old kernels that do not have "pause-on-trace" it should be the
> default. The "pause-on-trace" was added when the default was changed to n=
ot
> pause the trace while reading it.

It looks like the kernel patch was picked up, but Masami's patch for the=20
selftest wasn't backported. I have requested a test with that applied.

Separately, before I saw your response, I came up with the below patch=20
to update the selftests to disable tracing before reading the trace=20
file. I have also requested this to be tested.


- Naveen

---
 .../selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc     | 4 +++-
 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc | 2 ++
 .../selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc | 3 ++-
 .../testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc | 3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-sta=
ck.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index cf3ea42b12b09f..7e74df1ef928f9 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -39,6 +39,7 @@ disable_tracing
 clear_trace
 enable_tracing
 sleep 1
+disable_tracing
=20
 count=3D`cat trace | grep '()' | grep -v schedule | wc -l`
=20
@@ -54,8 +55,9 @@ fi
=20
 echo 0 > /proc/sys/kernel/stack_tracer_enabled
 clear_trace
+enable_tracing
 sleep 1
-
+disable_tracing
=20
 count=3D`cat trace | grep '()' | grep -v schedule | wc -l`
=20
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc =
b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index b3ccdaec2a61ba..7e65a115054127 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -24,6 +24,8 @@ fi
 echo function_graph > current_tracer
 enable_tracing
 sleep 1
+disable_tracing
+
 # search for functions (has "()" on the line), and make sure
 # that only the schedule function was found
 count=3D`cat trace | grep '()' | grep -v schedule | wc -l`
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notra=
ce-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrac=
e-pid.tc
index 80541964b9270b..9fb0511b5d2eeb 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.=
tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.=
tc
@@ -51,6 +51,7 @@ do_test() {
=20
     enable_tracing
     yield
+    disable_tracing
=20
     count_pid=3D`cat trace | grep -v ^# | grep $PID | wc -l`
     count_other=3D`cat trace | grep -v ^# | grep -v $PID | wc -l`
@@ -60,7 +61,6 @@ do_test() {
 	fail "PID filtering not working? traced task =3D $count_pid; other tasks =
=3D $count_other "
     fi
=20
-    disable_tracing
     clear_trace
=20
     if [ $do_function_fork -eq 0 ]; then
@@ -77,6 +77,7 @@ do_test() {
=20
     enable_tracing
     yield
+    disable_tracing
=20
     count_pid=3D`cat trace | grep -v ^# | grep $PID | wc -l`
     count_other=3D`cat trace | grep -v ^# | grep -v $PID | wc -l`
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.t=
c b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 2f7211254529ba..c55bcf2fe1966f 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -51,6 +51,7 @@ do_test() {
=20
     enable_tracing
     yield
+    disable_tracing
=20
     count_pid=3D`cat trace | grep -v ^# | grep $PID | wc -l`
     count_other=3D`cat trace | grep -v ^# | grep -v $PID | wc -l`
@@ -60,7 +61,6 @@ do_test() {
 	fail "PID filtering not working?"
     fi
=20
-    disable_tracing
     clear_trace
=20
     if [ $do_function_fork -eq 0 ]; then
@@ -72,6 +72,7 @@ do_test() {
=20
     enable_tracing
     yield
+    disable_tracing
=20
     count_pid=3D`cat trace | grep -v ^# | grep $PID | wc -l`
     count_other=3D`cat trace | grep -v ^# | grep -v $PID | wc -l`

