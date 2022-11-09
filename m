Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C2622392
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKIFwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKIFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:52:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587381E3F4;
        Tue,  8 Nov 2022 21:52:07 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A95ZZYw000324;
        Wed, 9 Nov 2022 05:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=XVXevSW52ryd86FBGsq+1//zlPGXc/p+U7PiHaLfysI=;
 b=mqANZIbQl1EaA9fB2KGxb+Dns9wiaeg3F32t01nvQN6bGWcCzMZNPKU9lQvMWLo4HPyC
 Nkhe3G0IKhZhrdGqqE0tpg2f5MyKt+5bsL3+p+HoRYslkpav4tvPpGyqMajurMn55xvY
 hOMec5AybSYqAtMxa5RWYNcHiQRM/TG/66sq6JdxTxl5TmiHjwnC/3A9IZsm7/nNSoJy
 NbVhmiwclTWi/Tmbg7j/rq+RRXsOMTkRn4rzmHv2adMi2gKjm1K/CEWwnFVG3NCURirT
 lCBfS19CCd+bRhz6VvYAVFQwAWkC6j6Xv+9MnZfz8bG8XwGMvxnLQbkA8+eWeP249Jwj hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr664r0w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 05:51:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A95pt2G000939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 05:51:55 GMT
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 21:51:51 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <dianders@chromium.org>,
        <jinghung.chen3@hotmail.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm reference boards as LTE
Date:   Wed, 9 Nov 2022 11:21:31 +0530
Message-ID: <20221109055132.609-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kd2AOktYyLr99lwufBzBH3XprGWhdPPF
X-Proofpoint-ORIG-GUID: Kd2AOktYyLr99lwufBzBH3XprGWhdPPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=683
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the modem node was re-located to a separate LTE source file
"sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
weren't marked appropriately. Fix this by marking all Qualcomm
reference devices as LTE.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
 * Fix incorrect tag usage [Krzysztof]

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4884647a8a95..ca09367abb6c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -13,6 +13,7 @@
 #include "pmk8350.dtsi"
 
 #include "sc7280-chrome-common.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	aliases {
-- 
2.17.1

