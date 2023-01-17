Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0041C66DA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjAQJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjAQJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:37:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633333449;
        Tue, 17 Jan 2023 01:35:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7OLJK008832;
        Tue, 17 Jan 2023 09:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=a3uCGNyveDE2VOg9aSlVRu17hXbzIyfZyjCVbxTfAdU=;
 b=QRNPkIIJHwE4M13MgaBGMKNHI4dZaH2a9AJ6Ew/A3m/+8NENgsBjTtkwcABN4KbEQ7zh
 fm2Er0YHX3EhZ46WUNbDRGJy0PjdEqDJ4dfeXjpn8zfSVdjjKG4v/Mndy9bLGbbnag8x
 NXDy5EQPwA/VPMnpUSaL1dvRLq/CqKDRaBPxLigfAh9DrkxYqYFBtKj98H0GFJHhASXi
 hnIFgGJyHwlGUDvTn5uR7VySIFbeIG5G4g4Ok5K+Pwzwsg8/AoaK9wMNUCup+UxoF/7b
 YfBYCODeqkBbtxBPrJj6ZBy3fNbhSBoc7EJooey5/E3P1IiHw8OQhXPsXdv4DilZvYBu dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5b1897d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:35:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H9Zjih009293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:35:45 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 01:35:43 -0800
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sm8550: fix xo clock source in cpufreq-hw node
Date:   Tue, 17 Jan 2023 15:05:33 +0530
Message-ID: <20230117093533.3710000-1-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117091446.GA3704192@hu-pkondeti-hyd.qualcomm.com>
References: <20230117091446.GA3704192@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6ka9jqzARrwNqWyfPHgmAzREZT8yFDMT
X-Proofpoint-ORIG-GUID: 6ka9jqzARrwNqWyfPHgmAzREZT8yFDMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=959 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170080
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, available frequencies for all CPUs are appearing as 2x
of the actual frequencies. Use xo clock source as bi_tcxo in the
cpufreq-hw node to fix this.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 59756ec11564..a551ded31ddf 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2522,7 +2522,7 @@ cpufreq_hw: cpufreq@17d91000 {
 			      <0 0x17d92000 0 0x1000>,
 			      <0 0x17d93000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clocks = <&bi_tcxo_div2>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1

