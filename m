Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ADB5BE441
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiITLQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiITLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:16:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92970E4C;
        Tue, 20 Sep 2022 04:16:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K80hH4012600;
        Tue, 20 Sep 2022 11:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=f9bQ2Pub38kjwx86yF3O38oDOzoP4fBrS6r2luF9pNU=;
 b=C1NrOjHxBAdVB1K88iRB4R3gsa7H7tF3/BLY7kFCox9/mIZe0B6lg923tO3Ru2dIM1O7
 sHZbS+UMwOAgHR+shHiLfVAYUXpn5pSd9W+wO6gi2N00FnaRwVmsEjFbgmrjWTFCokP/
 jThlXFEGGUECIFAagIWzI6wRpCOR9y9yPRzsn3mOhx3BGk3sQj5u4OMFKdgmPSdhrDCa
 inyM91Z2zSZmJpfbHRHb6P4icnw2APLVyai7JBVOAFYZ8SfKijEy4/x8/nN2iWUQ4Yn5
 YK5ovgyoSTz8tisPGObibtKFk+uqRSi8fZnb01ZKUAk2CW6dOox33p0UVvd7iwNjr7lD FQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq04y2b3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:15:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KBFtUc007692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:15:55 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 04:15:51 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb gdsc
Date:   Tue, 20 Sep 2022 16:45:16 +0530
Message-ID: <20220920111517.10407-2-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920111517.10407-1-quic_rjendra@quicinc.com>
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oYEWFkkhh4t9-3gxBRm_w6PPpDxX1NZM
X-Proofpoint-GUID: oYEWFkkhh4t9-3gxBRm_w6PPpDxX1NZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=980 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controller on sc7180 does not retain the state when
the system goes into low power state and the GDSC is
turned off. This results in the controller reinitializing and
re-enumerating all the connected devices (resulting in additional
delay while coming out of suspend)
Fix this by updating the .pwrsts for the USB GDSC so it only
transitions to retention state in low power.
Since sc7180 only supports cx (parent of usb gdsc) Retention, there
are no cxcs offsets mentioned in order to support the Retention
state.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
v3:
Updated the changelog

 drivers/clk/qcom/gcc-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index c2ea09945c47..2d3980251e78 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2224,7 +2224,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
-- 
2.17.1

