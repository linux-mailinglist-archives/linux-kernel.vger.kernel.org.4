Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C009E700AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbjELPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbjELPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:04:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16676A6;
        Fri, 12 May 2023 08:04:41 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDJomA006467;
        Fri, 12 May 2023 15:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=NCeAupFipwrt8mD4aFJWb678AM5yOEw1p39DaJCb9g4=;
 b=EdTDwTx6jaBZSROgztMHfMydriRyo6Utb90xO8qtlGBHP39uvjd4TT2QJ/FV/Cz2bbD7
 B/8M97whEL/SPEGywDZbkmwZCSvIIB6tyFzHTRuylVlPKuYPEf0LFSDW8YwpIYGpYH//
 1uSR8vDz4lxhPY1Eg69py66rMIAUlw3eC/7iAit3cQDh+pHG/Mj1wNNBHwq2+8izfqoD
 62UfXoQ2FSvMjRg6kyU4w8XcyEfiXNVdu916hJulIfQqw+cZVbIWdcmAPh0s+H/696+9
 grEB/xto5YWYZYy0kg+VRINYCl7UE/qYcug3jmaLuZEeeSSNV++WZeT5Q2ar6I/Qkp8J 8w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh390xfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 15:04:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CF4UCa004240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 15:04:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 08:04:30 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Date:   Fri, 12 May 2023 08:04:25 -0700
Message-ID: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TUEEDQSV5vg-O2UHV8zcMAP2RPpwr321
X-Proofpoint-ORIG-GUID: TUEEDQSV5vg-O2UHV8zcMAP2RPpwr321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8fa9fbfe5d00..5c68f2182c2f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
 			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
 			label = "apps_rsc";
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
-- 
2.25.1

