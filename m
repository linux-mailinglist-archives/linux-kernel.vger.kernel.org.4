Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42326F3FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjEBJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:03:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DCA2D4A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:03:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3427kchj001574;
        Tue, 2 May 2023 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=eYQUmLC99szVAF3zHwOE1YAgtRpm9SqAl6mY2ZpeUMY=;
 b=fLnjDLx3Uf5tJ1w38wJop4CQFlr/IFBybrUDkfsw5AEgZ0E26OpdBTZgyY55wF1+s49f
 e5wdxYmNk4jymedAGuc66bSuWno8spdyNHOuTAlUxiQOf6i6KMmRS4ADUe3edufRaLEE
 d/O7z0JUUTNUAnrCswfz/hip1GE1lsNF06vhY1SG0VOApPniGq8Wgy/JZxOqMnON6PfV
 9ed9dfqHcagjjQjZQkHtjIez+NZkFrJWLbmEVnTGOQqBbtYRYN8AVhPi2Qq4NZLUZ3do
 V2vDHMTXdtNLwxPvgHWxYXLjYGJf8ZiscwzLqsbNVkXce+89z1nU+Wvo2oAt+5hKRk4H kQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qakdssbpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 09:02:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34292tkT009562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 09:02:55 GMT
Received: from hu-pbaronia-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 02:02:51 -0700
From:   Prathu Baronia <quic_pbaronia@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Prathu Baronia <quic_pbaronia@quicinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Zqiang <qiang1.zhang@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: fix spelling typo and grammar in comments
Date:   Tue, 2 May 2023 14:32:40 +0530
Message-ID: <20230502090242.3037194-1-quic_pbaronia@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fkaPjjJKDwvO59jTYou9diyZZQUiYUhB
X-Proofpoint-ORIG-GUID: fkaPjjJKDwvO59jTYou9diyZZQUiYUhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=869 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- `If present` -> `If present,'
- `reuturn` -> `return`
- `function exit safely` -> `function to exit safely`

Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>
---
 kernel/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7e6751b29101..d7fd133f63dd 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -311,10 +311,10 @@ void __noreturn kthread_exit(long result)
  * @comp: Completion to complete
  * @code: The integer value to return to kthread_stop().
  *
- * If present complete @comp and the reuturn code to kthread_stop().
+ * If present, complete @comp and then return code to kthread_stop().
  *
  * A kernel thread whose module may be removed after the completion of
- * @comp can use this function exit safely.
+ * @comp can use this function to exit safely.
  *
  * Does not return.
  */
-- 
2.25.1

