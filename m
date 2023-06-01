Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE0719AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjFALLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFALLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:11:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92B12C;
        Thu,  1 Jun 2023 04:11:45 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351AsUim024716;
        Thu, 1 Jun 2023 11:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=AuEGJUms4FpbMvBvn9+AyfmVDw66oMUAvRA7iYkVodw=;
 b=JkhC4nAU7VUtRAKy+UVmeBC+RGjPFHRULJEaqcWSvWRysHK8i9Z6j7O9o9ubex0M5fFY
 Jr4w8OG/U0zxHI4eNWi7TRlq+n9I5Hxh4KD2qCa56vIIBj2sSzV42sL41m29QofoKRq3
 /mFj6ZnonPQI83YYcRjkbi1LZBwICdXMuFTDwHIknj8uLRDA8y9cAW5iU4h1NkaG2aMU
 kA2f0wKnaS+q4j6leoGjYZmG42h+gBeFok0EwGaHOV6ajqVbvAQrNIHhv86iyJCwCH7A
 ypT0AvfHgBDfBt/VwwduJLj9c6eWq+izUu4o+9DjGGhATdeCXBv73Uod18rYmmcxk/Yt ng== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx81xae7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:11:36 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 351BBXkM010992;
        Thu, 1 Jun 2023 11:11:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3quaxm8j24-1;
        Thu, 01 Jun 2023 11:11:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351BBX1x010983;
        Thu, 1 Jun 2023 11:11:33 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 351BBWJm010978;
        Thu, 01 Jun 2023 11:11:33 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 3DF47529754; Thu,  1 Jun 2023 16:41:32 +0530 (+0530)
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
Subject: [PATCH v5 1/3] dt-bindings: mmc: sdhci-msm: Document the QDU1000/QRU1000 compatible
Date:   Thu,  1 Jun 2023 16:41:26 +0530
Message-Id: <20230601111128.19562-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230601111128.19562-1-quic_kbajaj@quicinc.com>
References: <20230601111128.19562-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fxoDagp3OmZfz90KG5DVOJniF3Pyi61U
X-Proofpoint-ORIG-GUID: fxoDagp3OmZfz90KG5DVOJniF3Pyi61U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=872 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010098
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 4f2d9e8127dd..af29d60ff0d6 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,ipq9574-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
+              - qcom,qdu1000-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci
               - qcom,sdm630-sdhci
--
2.17.1

