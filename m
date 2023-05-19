Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A57092BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjESJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjESJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:09:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F2E42;
        Fri, 19 May 2023 02:09:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J82plo007302;
        Fri, 19 May 2023 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=RQPn8W3VgfKowBBmkWLf3n4+oqHqaPzIavttSWTD6fk=;
 b=b5zeFcORfU8wRMbbmoCXV3m1L1nrJaCKSJAc0ae3UXwkMrvMZKF8kGIJd+Xl/nAj9j4j
 jy3FcDBIbQv88bxhJIb76w2HwBrM+aCmqmiKNKJD4R0P4yjBdkszyMCW6mbYuu1aV6oA
 QLbR7gTPa4RxyT55b+wqUsCBNGm6rTmZhrjif/1S+F3W33jUOG2g06Bm1I5Ezo30hfWW
 xc18POLKaAQhqXjs+mwqXmB6YR1cKu3j5k1G2X+fJtScd6WX0pBy3DOyths8rlcG5quD
 C3aeXDA1ugOAZrxUu4F6GEv4C93rxXs7aUmyMRwWGLejj4bBtkjLSf65YzeGUlffWTOL 0A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqkcfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J96w0X030160;
        Fri, 19 May 2023 09:09:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm558g-1;
        Fri, 19 May 2023 09:09:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99D8p031635;
        Fri, 19 May 2023 09:09:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99CXC031627;
        Fri, 19 May 2023 09:09:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 4B5005EC7; Fri, 19 May 2023 14:39:12 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/8] dt-bindings: interrupt-controller: Add SDX75 PDC compatible
Date:   Fri, 19 May 2023 14:39:05 +0530
Message-Id: <1684487350-30476-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TlKU4iygdb-2nUcTykL-aePE0CPNIDCI
X-Proofpoint-GUID: TlKU4iygdb-2nUcTykL-aePE0CPNIDCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=670 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190076
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for PDC on SDX75 SOC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index a106ba6..24ec69a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sdm845-pdc
           - qcom,sdx55-pdc
           - qcom,sdx65-pdc
+          - qcom,sdx75-pdc
           - qcom,sm6350-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
-- 
2.7.4

