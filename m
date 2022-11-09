Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF916623294
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKISf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKISfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:35:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BE60D0;
        Wed,  9 Nov 2022 10:35:16 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9I8hTP001655;
        Wed, 9 Nov 2022 18:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QHA3HKkapf3qwQPOp9Hozv9SWtVrrQ3kkeqQm8zCLqg=;
 b=C/awPhapk6cM1kzV75za66q95B7ODcoH2QBfP+6cjc8+KYKVnnqqR9gWapIZhHwmMwRZ
 uvMSvQ0PgvMzLnEI1IKa9HJ//kmaOfr/nrSzrjB4EcYbrFy0fOSYdgrhfMzhcjTHpkr/
 e4H7G6w7jB1e+vcPaTmaxWdpF22eXFAAIXzEKYXxdXn746c2PaJgWM+/9Qgo+GpefZRk
 SPtust+TQYdSFs598zrFcA/eKPHM+KldqIh6rd4iKB6jqZvMCt19N8sOnuomUsS+wkIC
 DiZK6tYqJCf2KcZFx0QsmCFh/ckzXoPRMRY+e2i8829M0WJLE5lKDIYLmCkbhvf7/uIA qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krgbr0bsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 18:35:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9IZ8bW009165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 18:35:09 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 10:35:08 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: qcom: Add link-frequencies property to specify the max link rate allowed
Date:   Wed, 9 Nov 2022 10:34:54 -0800
Message-ID: <1668018895-29023-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1668018895-29023-1-git-send-email-quic_khsieh@quicinc.com>
References: <1668018895-29023-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j1BrFnRbtmjU0jdnnZjQM9iDJDwEBSDe
X-Proofpoint-ORIG-GUID: j1BrFnRbtmjU0jdnnZjQM9iDJDwEBSDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=871 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add link-frequencies property to allow each platform to specify its
DP max link rate.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 93e39fc..7e5d755 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -441,6 +441,7 @@ ap_i2c_tpm: &i2c14 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
 	data-lanes = <0 1>;
+        link-frequencies = <810000>;
 };
 
 &mdss_mdp {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

