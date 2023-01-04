Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4565CBD1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjADCPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADCPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:15:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4826BB7;
        Tue,  3 Jan 2023 18:15:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3040sKrK020285;
        Wed, 4 Jan 2023 02:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=hN6RbBK57yOPqsfkmxKFRunZ8afjbgtvj7w+YhUmxHw=;
 b=M2l4ps31cE4vvl332as1VQ+EgGpmgnPUpDuZqcRu/YDps6dXHDiB2dXPlNcpFAj3sJ0D
 gOuoPA6V3POe9q+WQSe6CGNU+Qmpoud9ATd15zv+UT+eRoFIZNBILYaGq6twMbv3rqJj
 axNTMm/MOzwDsLSimL98Rux/xM16Mf6zNqJvtHVnG5p7/MCD09CTGzEenBcz0CGql2vd
 eyf3zWdSNbLOF7cuUponwhMVAC3yyKECmLD0IW6Yruu8V4LSJK1zDNQeMEkSm4vhZNwp
 aQM19ANZdcxHypMH85lQdfbQ32VYExOdfoxeQXm1BvztszzCDfm6tx0/RY5AH0m4U2zE 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvegmj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 02:15:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3042FA7r025282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 02:15:10 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 3 Jan 2023 18:15:08 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <manivannan.sadhasivam@linaro.org>
CC:     <hemantk@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
Date:   Wed, 4 Jan 2023 10:14:45 +0800
Message-ID: <20230104021445.47484-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aKRbxkZPlTaC0FJLiLoYp7mQ8QbDcfxj
X-Proofpoint-ORIG-GUID: aKRbxkZPlTaC0FJLiLoYp7mQ8QbDcfxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_08,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=916 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently no log printed when SYS_ERR happens, this makes
debug quite hard, so change log level to make it noisy.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 2 +-
 drivers/bus/mhi/host/main.c | 6 +++---
 drivers/bus/mhi/host/pm.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 1c69feee1703..d8bceabcee63 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -102,7 +102,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 		goto error_exit_rddm;
 
 	if (ee != MHI_EE_RDDM) {
-		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
+		dev_info(dev, "Trigger device into RDDM mode using SYS ERR\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
 
 		dev_dbg(dev, "Waiting for device to enter RDDM\n");
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index df0fbfee7b78..54c948ed7f47 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -497,7 +497,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
 
 	if (state == MHI_STATE_SYS_ERR) {
-		dev_dbg(dev, "System error detected\n");
+		dev_err(dev, "System error detected\n");
 		pm_state = mhi_tryset_pm_state(mhi_cntrl,
 					       MHI_PM_SYS_ERR_DETECT);
 	}
@@ -871,7 +871,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			{
 				enum mhi_pm_state pm_state;
 
-				dev_dbg(dev, "System error detected\n");
+				dev_err(dev, "System error detected\n");
 				write_lock_irq(&mhi_cntrl->pm_lock);
 				pm_state = mhi_tryset_pm_state(mhi_cntrl,
 							MHI_PM_SYS_ERR_DETECT);
@@ -1085,7 +1085,7 @@ void mhi_ctrl_ev_task(unsigned long data)
 		write_lock_irq(&mhi_cntrl->pm_lock);
 		state = mhi_get_mhi_state(mhi_cntrl);
 		if (state == MHI_STATE_SYS_ERR) {
-			dev_dbg(dev, "System error detected\n");
+			dev_err(dev, "System error detected\n");
 			pm_state = mhi_tryset_pm_state(mhi_cntrl,
 						       MHI_PM_SYS_ERR_DETECT);
 		}
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 083459028a4b..570fdd4db442 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -1223,7 +1223,7 @@ int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
 	if (mhi_cntrl->ee == MHI_EE_RDDM)
 		return 0;
 
-	dev_dbg(dev, "Triggering SYS_ERR to force RDDM state\n");
+	dev_info(dev, "Triggering SYS_ERR to force RDDM state\n");
 	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
 
 	/* Wait for RDDM event */
-- 
2.25.1

