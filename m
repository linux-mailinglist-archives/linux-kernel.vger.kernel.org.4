Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9A750664
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjGLLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGLLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:40:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C2E19BC;
        Wed, 12 Jul 2023 04:40:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8cb9I003950;
        Wed, 12 Jul 2023 11:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=naxU+m/X6BWT4Ppq8p46MPOyw5VGSp+2XgsgQpgrn5w=;
 b=MIt+fkCvPGipD+4zQeqjd0fyo7CqHS4n63bJEz4o9/lGfc6dJSKUjjMIfIg6dhZkVLrQ
 UgInykyU/r2ohkX5zDwl0MjqRMnl08ID+HRZuJI32iamBs/2e/9f6lbiTPgljDrrQJO/
 K2++CSBLZZ3+lpJfmF7A1RLykIVi091ikt0TERI8dw/LQRWZjYRrcEseVeyzHhHOT9vl
 b+ghjzemIZoQKKjKwtIOXliCxGJ9HeAJvETh6MmoDEuV4sFhIoogH9zIhbFLcFZqZlNh
 PH6exyv4R+JHjkaspVaMAWQ9Xke9C9MADvO8IfQ9VlfsK6tCmegrnuL8MRo2Gqiy1thC qA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgd395sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:39:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBdUtR021827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:39:30 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:39:23 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 5/6] arm64: dts: qcom: ipq5332: Enable USB
Date:   Wed, 12 Jul 2023 17:08:22 +0530
Message-ID: <69e64cb77ffc505edcf825f924006df690193305.1689160067.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1689160067.git.quic_varada@quicinc.com>
References: <cover.1689160067.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ykcHmkRpVpxhFAzM5mSIZakmLMX5DxA5
X-Proofpoint-GUID: ykcHmkRpVpxhFAzM5mSIZakmLMX5DxA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=480 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB2 in host mode.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v1:
	Enable usb-phy node
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
index f96b0c8..f5dea16 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
@@ -79,3 +79,15 @@
 		bias-pull-up;
 	};
 };
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&usb2_0_dwc {
+	dr_mode = "host";
+};
-- 
2.7.4

