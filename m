Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55274EBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGKKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGKKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:40:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753651A2;
        Tue, 11 Jul 2023 03:40:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAQvTB007755;
        Tue, 11 Jul 2023 10:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=wz/c7LCVr71XpNiEk8lSRfuaqQwPsMz6br/H0UTYKSk=;
 b=hYzeoJuTsLXZbZUO7ncwKpCXfl7q5ZA8vwHNuz3bNUX2rs41kFJt+dUlw0Or/ZiEyXn6
 JB7EvjF2b1c7KI3haJlzeTJGmGZ0eaRFEc012N4JRYfgcPyhRPxVKhZm3D68PtnrUAqY
 E2JxM1s2hAOQvuLEDXu+QoC4wAq5Km00bBybVo6WUFag2M9PiyhOTv+wWsaBJWCuMFhN
 /F/pIMr14/EpIdXgTjKmE4UcbKJ0oviOtR1aoPmmube+zRjAudXYcCXaT10yqj9WADwD
 mMRv6795bBjUl2FziXjoyfW1gs9G1hquSzfwmGCRTBwVnkWyHub/ePnIGULURs4QCJj+ 1g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs3vh866v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:40:17 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36BAeCwb021490;
        Tue, 11 Jul 2023 10:40:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkm64b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 10:40:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BAeCxO021485;
        Tue, 11 Jul 2023 10:40:12 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36BAeCNq021482;
        Tue, 11 Jul 2023 10:40:12 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 7D7CD5000AA; Tue, 11 Jul 2023 16:10:11 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, linux-arm-msm@vger.kernel.org,
        quic_ziqichen@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V1] scsi: ufs: ufs-qcom: Update UFS devfreq Parameters
Date:   Tue, 11 Jul 2023 16:10:06 +0530
Message-Id: <20230711104006.15872-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJ7Y_BAWWPbSWNj90E_0Y0dohvJHr415
X-Proofpoint-ORIG-GUID: UJ7Y_BAWWPbSWNj90E_0Y0dohvJHr415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=931
 clxscore=1011 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the periodic polling mode without stop
caused by CPU idle state, enable delayed timer
as default instead of deferrable timer for
qualcomm platforms.
And change UFS devfreq downdifferential threshold to 65
for less aggresive downscaling.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 82d02e7f3b4f..a15815c951ca 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1388,8 +1388,9 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 					struct devfreq_simple_ondemand_data *d)
 {
 	p->polling_ms = 60;
+	p->timer = DEVFREQ_TIMER_DELAYED;
 	d->upthreshold = 70;
-	d->downdifferential = 5;
+	d->downdifferential = 65;
 }
 #else
 static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
--
2.17.1

