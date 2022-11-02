Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB66160F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKBKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKBKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:36:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0028E33;
        Wed,  2 Nov 2022 03:36:28 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2AUphw002079;
        Wed, 2 Nov 2022 10:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ie5KzKJo/ajHkmu/VtVwEvX2vNvYq8bpWqpdz/AmU4c=;
 b=dxBKdosiSbVbcM6AugYyKSj01mgovXba6h8GZzaGo/GN7wVqu5dYiz7p3N+A7zLkan/e
 YdcXFfYCk/5htn5zBK0wCaqEqmGHsqpxMkIelfNYhmeFTO1tD2agj2FOG0gSnUPX+cZU
 qPoggg6xCP8aFi0ahJujUC3f625ismZ/ucXN6wwW0cs0O9gz3BuBWGIC8c+Fva0PSX1L
 4VO0be5Xj6yws6AcuHuXkcIe5UW7GVcq/WOl8TuWKXa3ynQ+Jfv2sf1b7GFGReaVl1G6
 AqpsJojmxt9fDdqx9BO5rkXgUTXdxOxFbm00AqRk+1DNGH/6bekGHyNvL5Cgt9T3osWV hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj88rjux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:23 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaMgY004603;
        Wed, 2 Nov 2022 10:36:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3khdkxd5ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:22 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaLhM004598;
        Wed, 2 Nov 2022 10:36:22 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 2A2AaLBS004596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:21 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 03:36:18 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        "Johan Hovold" <johan@kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: qcom: Document additional sa8540p device
Date:   Wed, 2 Nov 2022 16:05:51 +0530
Message-ID: <20221102103552.29388-2-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102103552.29388-1-quic_ppareek@quicinc.com>
References: <20221102103552.29388-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e4wgBV535PDZv0iD_9mRoq3ftj49FmMp
X-Proofpoint-ORIG-GUID: e4wgBV535PDZv0iD_9mRoq3ftj49FmMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qdrive3 ride device to the valid device compatibles found on the
sa8540p platform.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..f12b1ff19337 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -687,6 +687,7 @@ properties:
       - items:
           - enum:
               - qcom,sa8295p-adp
+              - qcom,sa8540p-ride
           - const: qcom,sa8540p
 
       - items:
-- 
2.17.1

