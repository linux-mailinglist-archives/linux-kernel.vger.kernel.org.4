Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7666D904
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjAQJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjAQI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C3823845;
        Tue, 17 Jan 2023 00:59:27 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7PxGI012901;
        Tue, 17 Jan 2023 08:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=BXPVg+Na+B5aGYrdAD3tCTK1Yc3pV1RCygVsNKebH2I=;
 b=hut+ubN5OIEXb0MlSl6UwK4lcEUt94BA9dHISAJQZCtsiiHMcAsDhqeBj4PZgsGTt5uL
 f/itQjLcTU0DTh/6Ip49BNQkeXyCaIFBB5HXbLEqbgLvgjGSB6DGEUtmSz3uGmtr0W6t
 NSnVv8HsEzAR8IVhK+8t5O/ytm5y2ffu0+YTKj9eGfVNcJjaO4HEOO1b/kY+G/bLsFbo
 DTLnsZc+Hf4ZG+5eOKq8x8MZr4BKiTv9y8v1VUo+w7KKS67MY26rEjiSJJ1vty3Islcn
 qusqav0cBkljLwlcXaNf0v8ht6hJmDCZU1wSLgFc030L0u/nOdQL2ST9PM+MoFfyzFi9 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n55cx9rwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8xFvG031081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:15 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:59:10 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 03/11] dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
Date:   Tue, 17 Jan 2023 14:28:32 +0530
Message-ID: <20230117085840.32356-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2l286UWTwm2GNKNh2FwMpG9UiRLMt4Rv
X-Proofpoint-ORIG-GUID: 2l286UWTwm2GNKNh2FwMpG9UiRLMt4Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=979 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170074
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic memory region used for metadata authentication would still
be a part of the kernel mapping and any access to this region by the
application processor after assigning it to the remote Q6 will result
in a XPU violation. This is fixed by using a no-map carveout instead.
Update the bindings to reflect the addition of the new modem metadata
carveout on SC7180 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
 * remove double space [Krzysztof]
 * Pickup R-b

v2:
 * Pad commit message to explain bindings break [Krzysztof]
 * Split dt/bindings per SoC  [Krzysztof]

 .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
index e4a7da8020f4..b1402bef0ebe 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -95,6 +95,7 @@ properties:
     items:
       - description: MBA reserved region
       - description: modem reserved region
+      - description: metadata reserved region
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -223,7 +224,7 @@ examples:
                         <&rpmhpd SC7180_MSS>;
         power-domain-names = "cx", "mx", "mss";
 
-        memory-region = <&mba_mem>, <&mpss_mem>;
+        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
         qcom,qmp = <&aoss_qmp>;
 
-- 
2.17.1

