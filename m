Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59F35FF62B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJNWMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJNWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:12:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7B1DC4CB;
        Fri, 14 Oct 2022 15:11:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EIEB8H010260;
        Fri, 14 Oct 2022 22:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cLbR5wfAwfwHKb62tJT74DF/f2ENW7hVMPV0Lb/qiB4=;
 b=A/D6SxFWseRveUUq2JKPn0EbE4I2Ni/XB62pJb0/4pEEW7lPUT2Qu7ZzBcTwCc+E4e0J
 tepzcDK457H6edQliLpu0G4saNfWgaoIqzg8el4QwrB+9E+IFCNeNAGlVYnS9OI7O0xa
 mkInLD/2Kfmd7OxyfgVAxT7qskFj3UbkxCEJ35Nh7cWWtHK9OQVLt8/+1k3PyqAZsO64
 gAk5Gagu+imt6HL/cKcbEWZKltJsWdzsldTlts1oM4sZVfegBjMocGvZ9mhvtKwdjOxj
 sZSL+L1m7jhgsDYZ5iY0E/y4Ny7XD/V6ULKfkMOgR5E/eLX4TC1JbKFB5JbNCC+r9L0A 4Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k73h6kaub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:11:13 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMBCiF005979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:11:12 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:01 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
Date:   Fri, 14 Oct 2022 15:10:50 -0700
Message-ID: <20221014221051.7434-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221051.7434-1-quic_molvera@quicinc.com>
References: <20221014221051.7434-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zK6Sr78aDVqJbrumiz0TdkQi7_OCd9wP
X-Proofpoint-GUID: zK6Sr78aDVqJbrumiz0TdkQi7_OCd9wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=749
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..ae314436eddb 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -34,6 +34,8 @@ properties:
         items:
           - enum:
               - qcom,qcm2290-smmu-500
+              - qcom,qdu1000-smmu-500
+              - qcom,qru1000-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
-- 
2.38.0

