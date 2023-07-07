Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706D74BA28
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGGXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGGXxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:53:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51B2114;
        Fri,  7 Jul 2023 16:53:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367MIGE3032639;
        Fri, 7 Jul 2023 23:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=55d8wxJHD2skusoB0AWCsKRiDOr/r6uKT7GO26qxChw=;
 b=gM8rSBI7C9hyDfUqgcJW6RXXxwabZuYRW2Ndblu4C2KistsCP5TCIdmD301/WI5wTxgO
 WJHrL22hcki8yBDnsPYSkQkToWGC0G63ncgp8KAdyFQzryq03Vics5Fob/Enkq5v6Cco
 ZOUcZiICUoy8wxxvTEPPg+Gl/BafvIz1Il9SgFDckn5FjRcgV9subDI9xJhPQPLO81vR
 q8J86VVDvWkG1cN6n5AcKbi86ePuoMqqa8J94YUEL5ZqyOHjDG0eaosKTud67eOTaTnD
 OlcGCu7EPbzS6u9IgnZkR63/K4zhMXD0ZELX41aYXAoivXGIKzQC8Qa0H/wUbW612Rl2 4w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpfyw9tqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 23:52:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367NqsG4008802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 23:52:54 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 16:52:54 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/5] drm/msm/dp: delete EV_HPD_INIT_SETUP
Date:   Fri, 7 Jul 2023 16:52:21 -0700
Message-ID: <1688773943-3887-4-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oAtebzOVZ2foSUlDRxXU_LTI0GByz4lO
X-Proofpoint-ORIG-GUID: oAtebzOVZ2foSUlDRxXU_LTI0GByz4lO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
DP host controller. Since external DP host controller initialization had
been incorporated into pm_runtime_resume(), this flag become obsolete.
Lets get rid of it.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2c5706a..44580c2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -55,7 +55,6 @@ enum {
 enum {
 	EV_NO_EVENT,
 	/* hpd events */
-	EV_HPD_INIT_SETUP,
 	EV_HPD_PLUG_INT,
 	EV_IRQ_HPD_INT,
 	EV_HPD_UNPLUG_INT,
@@ -1119,9 +1118,6 @@ static int hpd_event_thread(void *data)
 		spin_unlock_irqrestore(&dp_priv->event_lock, flag);
 
 		switch (todo->event_id) {
-		case EV_HPD_INIT_SETUP:
-			dp_display_host_init(dp_priv);
-			break;
 		case EV_HPD_PLUG_INT:
 			dp_hpd_plug_handle(dp_priv, todo->data);
 			break;
@@ -1483,15 +1479,7 @@ void __exit msm_dp_unregister(void)
 
 void msm_dp_irq_postinstall(struct msm_dp *dp_display)
 {
-	struct dp_display_private *dp;
-
-	if (!dp_display)
-		return;
-
-	dp = container_of(dp_display, struct dp_display_private, dp_display);
 
-	if (!dp_display->is_edp)
-		dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
 }
 
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
-- 
2.7.4

