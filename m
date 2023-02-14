Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C362696FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBNVcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjBNVci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:32:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427240FF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:32:11 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EHLlIk027227;
        Tue, 14 Feb 2023 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=jdadcMHUEHEz3wESNyYCqEqZE1xiSFm7gjLwEXCHUq4=;
 b=onAw/Ed1Rds4wArHiFBeJntOEqNg5p3PqBvyUh6+M+MtRv8Jh0kvC6waD+qY2BBAZDjJ
 JfNSKdQQEJjFmMbGFa0EBbVuhLAH0HMdSLl9GyYd3gjazEZ9b78V/qfeoHvNKf2IkN07
 P0eJM9p3sh7SSA9wtmqR0NDpqDxIcv6Xg68ANEzv6ky4vcLjJLNnOQ7r0wjS4OSNO+WT
 SREsyWc3lilplPKQEEe8D+Ncz2Ba4oSoCTTopsz/P47twra/NfFNrKAYMJP9t6FadVId
 hOp5/0eZ3AfjHx+EHRQjszmcLGEQp1bQ1IPlAucGlIrwcIsw0SfcaSTWBLi6U/CvKE4t 3Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygtu5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:31:32 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31ELVRmY013297;
        Tue, 14 Feb 2023 21:31:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3np43kjtbk-1;
        Tue, 14 Feb 2023 21:31:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31ELVRKm013292;
        Tue, 14 Feb 2023 21:31:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-c-spathi-hyd.qualcomm.com [10.213.108.59])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 31ELVQ2F013291;
        Tue, 14 Feb 2023 21:31:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 1DA434801; Wed, 15 Feb 2023 03:01:26 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, quic_c_spathi@quicinc.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1] um: Fix compilation warnings
Date:   Wed, 15 Feb 2023 03:00:43 +0530
Message-Id: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o9J2jh1-t8dYIgz2zYsGdSgbsy5oOMaz
X-Proofpoint-GUID: o9J2jh1-t8dYIgz2zYsGdSgbsy5oOMaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=360 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dynamic allocation in sig_handler_common() and in
timer_real_alarm_handler() to fix below warnings and build
failures where CONFIG_WERROR is enabled.

arch/um/os-Linux/signal.c: In function ‘sig_handler_common’:
arch/um/os-Linux/signal.c:51:1: error: the frame size of 2960 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
 }
 ^
arch/um/os-Linux/signal.c: In function ‘timer_real_alarm_handler’:
arch/um/os-Linux/signal.c:95:1: error: the frame size of 2960 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
 }

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
 arch/um/os-Linux/signal.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 24a403a..9de8826 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -32,23 +32,25 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
-	struct uml_pt_regs r;
+	struct uml_pt_regs *r;
 	int save_errno = errno;
 
-	r.is_user = 0;
+	r = malloc(sizeof(struct uml_pt_regs));
+	r->is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
-		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
+		get_regs_from_mc(r, mc);
+		GET_FAULTINFO_FROM_MC(r->faultinfo, mc);
 	}
 
 	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH))
 		unblock_signals_trace();
 
-	(*sig_info[sig])(sig, si, &r);
+	(*sig_info[sig])(sig, si, r);
 
 	errno = save_errno;
+	free(r);
 }
 
 /*
@@ -99,13 +101,15 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 
 static void timer_real_alarm_handler(mcontext_t *mc)
 {
-	struct uml_pt_regs regs;
+	struct uml_pt_regs *regs;
 
+	regs = malloc(sizeof(struct uml_pt_regs));
 	if (mc != NULL)
-		get_regs_from_mc(&regs, mc);
+		get_regs_from_mc(regs, mc);
 	else
-		memset(&regs, 0, sizeof(regs));
-	timer_handler(SIGALRM, NULL, &regs);
+		memset(regs, 0, sizeof(struct uml_pt_regs));
+	timer_handler(SIGALRM, NULL, regs);
+	free(regs);
 }
 
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
-- 
2.7.4

