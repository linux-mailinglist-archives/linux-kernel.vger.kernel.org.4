Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ACF661CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjAIDuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjAIDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D5BC18;
        Sun,  8 Jan 2023 19:50:33 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093f8YO015657;
        Mon, 9 Jan 2023 03:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TtzhrWDRwjg0w5FI8htF2NIDvluIwrpgIxp64/8RXko=;
 b=iFrRinFf/sRbJ9D72fPoYcDb+3aJgPitU7SKlnHD2ncwn3vCvcVTkOGH+iawo6zDkFR0
 KydzW9STicAqc1PtIaaMIiev5CaaV5HGI2suyow/iylqAoHdUW/dpjJ5iN6cwE7PNv98
 STSj+Nt1UAvnAel2gIUEXHJEjrF6ZWwA0s0jPkXXno+IuAFKKbC4k20kgTCNDs9T3b1T
 vMODlbja5PR58D/pHJHNm+csVnt+wU5mxGgFsGYP8XWCnLe6QiO/S0EKhRR/YfKQW8FV
 xrUV8QTlNJH+MMNiZRfPgnDv02DD6s+AeANz0CcGNXU1GwYY2KD3681KQiA9IgAElDpo Lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxyq0abd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093oKVu027647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:20 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:15 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 03/11] dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
Date:   Mon, 9 Jan 2023 09:18:35 +0530
Message-ID: <20230109034843.23759-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230109034843.23759-1-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MVkzzBAKFdjDMIqmPUaHow0y7wPn51ke
X-Proofpoint-ORIG-GUID: MVkzzBAKFdjDMIqmPUaHow0y7wPn51ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=963 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090025
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic memory region used for metadata authentication would still
be a part of the kernel mapping and any access to this region  by the
application processor after assigning it to the remote Q6 will result
in a XPU violation. This is fixed by using a no-map carveout instead.
Update the bindings to reflect the addition of the new modem metadata
carveout on SC7180 SoC.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

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

