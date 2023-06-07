Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E91725CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbjFGLGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjFGLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:06:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3D1FC9;
        Wed,  7 Jun 2023 04:06:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578SfO5018455;
        Wed, 7 Jun 2023 10:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h/Z3kYGkDTBXCDKdv1xzlrHQa0H8tqoUDfgCh6Icutc=;
 b=gI3XdLAtmV93drngSWVQPhDal0FXz6V2B6DYkRaKvsWMgQu0P+Xk/wuUT2VmKH/56vwH
 EX9kvj9a4xBCdyyPh7+cIiQBT/pRnBQ1CMN/NHRgzChlMcMGgC2wxwg8seCsu7XfqISC
 VWj6MNdyHii2aEnd3Cd7OY9YyyaP5OEzNDG6HT/HWpn0RlWhPuO1d2Zy1MsxxVM4NAdF
 SldB/oJShNdDeJFaVRxS4CrBIxE+k/kr4h6XHgD25U6io+13e8JGnmqzpjke84gdCdCI
 KNrgUF4RLxb6guzBmpN80DkdsPV2oRBMhXCrzk1zpIgSm31h6iO/dQ6BQeYm0vt8X+oh tg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719npf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:57:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357AvnXp008162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:57:49 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:57:40 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 9/9] arm64: defconfig: Enable QCOM M31 USB phy driver
Date:   Wed, 7 Jun 2023 16:26:13 +0530
Message-ID: <55f51785b36b9725fe5283a58230aee4e89b4d6f.1686126439.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686126439.git.quic_varada@quicinc.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eQVskgy5X7OuKVbtsfpGaf2gwxyTA-t5
X-Proofpoint-ORIG-GUID: eQVskgy5X7OuKVbtsfpGaf2gwxyTA-t5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=489 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QCOM M31 USB phy driver present in IPQ5332

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index afb63e3..f1e8669 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1362,6 +1362,7 @@ CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
 CONFIG_PHY_QCOM_USB_SS=m
+CONFIG_PHY_QCOM_M31_USB=m
 CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.7.4

