Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AA70B927
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjEVJgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjEVJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:36:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A0102;
        Mon, 22 May 2023 02:36:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8C6vR015569;
        Mon, 22 May 2023 09:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=bbs9PbHLbX6NgmkHPlMIeAa/LwFPGSAqnUkjU3wZYts=;
 b=FR2hA4CrKIlH2g7+BZWRzBW+NORLji/AEbCkGZRXWUfo4XZkThY3JEMS7cBMpAiwIJsv
 ekje6ZZVnoRdNUKaxAvh6KHD4dFr0fHIPNxjyFGHNhJQbq6Wy8I7UfM5bpgJJtLpkHR4
 UwUWJpPJ8kdmjCGjwGiWO78B5nALJCBYMNwi00JI8RTUdsVNJ5v+oEdy62562cw6uyGv
 aOm/S6vAKNzMGyjdSGxHjAyct5S6ugK7OARhFm5L16Fc9jeqOLp/OIgqySDFcYp/LMTD
 ZKjxRtZUwEaIWwJCgDI8+x/JUWrO/Yf0qpVWuNu6DtkLRnKY4g7IvZCHvR+tdoap6T1T Ig== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypb702-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:36:32 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M9aT9u026286;
        Mon, 22 May 2023 09:36:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qpq9kn8fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 09:36:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M9aN9S026210;
        Mon, 22 May 2023 09:36:29 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34M9aTgl026277;
        Mon, 22 May 2023 09:36:29 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 4BB935001C2; Mon, 22 May 2023 15:06:28 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
Date:   Mon, 22 May 2023 15:06:20 +0530
Message-Id: <20230522093620.3568-5-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RdWInpg6GSLjYcB3B-kfJK2gJqPlOAyx
X-Proofpoint-GUID: RdWInpg6GSLjYcB3B-kfJK2gJqPlOAyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=749 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220081
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhci node for emmc in qdu1000-idp.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index 9e9fd4b8023e..61d8446a2d55 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -451,3 +451,26 @@
 &uart7 {
 	status = "okay";
 };
+
+&sdhc_1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on_state>;
+	pinctrl-1 = <&sdc1_off_state>;
+
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+
+	non-removable;
+	no-sd;
+	no-sdio;
+
+	supports-cqe;
+
+	vmmc-supply = <&vreg_l10a_2p95>;
+	vqmmc-supply = <&vreg_l7a_1p8>;
+
+	status = "okay";
+};
-- 
2.17.1

