Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3D621104
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiKHMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiKHMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:40:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8351C16;
        Tue,  8 Nov 2022 04:40:03 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8CdsdM018417;
        Tue, 8 Nov 2022 12:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZwPKgIDlrk/kgyGrRemT13oBTOociSXK2qUEbiDhIh8=;
 b=oIROAI+leTcyq3dLs1vCqvBqEzky0Q91gPeB8atJJmE0341nnl+ymnlBCu1Ft2wtyKPV
 rBra7+wHUH/l/t6+n3wynhDTJ6hKA1HYuprAgmgQvbIAIX7WXzJke1h4UzynQm9T3jG2
 x6NvBUAauxPsN3VV9JdlQgzOEgThz1An95+ujBsijYyJvMcGmIJbNf5T7vwItuNd12xz
 cVExxfu6O2G1FlOHbqSppCRxtYhpIYudluR6HjeuCfK7OeKu0++3MQvYYgOR2hQyNzxa
 MraRWP9gPNAyG1P/xljfi98QqsCyMNPwQAsB7Ig/5+z0r5zZ/HD7Am5ff2bJAHQiEqh9 vA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhktrvx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:39:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8CdrZ7030744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 12:39:53 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 04:39:47 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Ratna Deepthi Kudaravalli" <quic_rkudarav@quicinc.com>
Subject: [PATCH v5 2/4] arm64: dts: qcom: sm8250: Remove redundant soundwire property
Date:   Tue, 8 Nov 2022 18:09:14 +0530
Message-ID: <1667911156-19238-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eSkKsJWjJ3OfnoLG-Dy2ycJi9kCH4QqL
X-Proofpoint-ORIG-GUID: eSkKsJWjJ3OfnoLG-Dy2ycJi9kCH4QqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=711 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant and undocumented property qcom,port-offset in
soundwire controller nodes.
This patch is required to avoid dtbs_check errors with
qcom,soundwie.yaml

Fixes: 24f52ef0c4bf ("arm64: dts: qcom: sm8250: Add nodes for tx and rx macros with soundwire masters")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index eb5a10c..0f430ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2360,7 +2360,6 @@
 			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
 			qcom,ports-lane-control =	/bits/ 8 <0xFF 0x00 0x01 0x00 0x01>;
-			qcom,port-offset = <1>;
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <0>;
-- 
2.7.4

