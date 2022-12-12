Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0B64A9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiLLVxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiLLVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:52:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E919C00;
        Mon, 12 Dec 2022 13:52:22 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCLp0tH030712;
        Mon, 12 Dec 2022 21:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TQYGbDEFhLCbjWxlOohuzGRdNuGbfqLVksnUdKOgCh8=;
 b=inA/Mgc5Y1cIq8/5bg2b6RxijE9i3RkCU+3UD2/UVOnLFlPBXIyNPfYewgMUMF8dF9L9
 yM8oNeKD8p2r0ECADgDA91vNlx1J94hJUwl+BP3nbOzHrxGZ+aHw1LBspFhPq3whkcLs
 2IBXuAIj7xJRhT+ndRLPLP/VT70NiSKBd0cYpohuQH/eNSoyk0maSnpF7nfDRR07ZhY6
 ybeeaFS2h4fTLUbAxJksRI7M4LaP1Ihffo9gUXAoCn4EH7rDJFUoLvexC4t1OO5gSuaZ
 IwHJp5uOWS8wq08WlhXpqMtoxi7Bma236OIm8XXzsqZCP57/XRCDY9z5FJswhMxtrzEJ iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mchesdb8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:52:04 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCLq36P029425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 21:52:03 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 13:52:03 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <djakov@kernel.org>
Subject: [RFC v2 1/2] dt-bindings: iommu: Document iova-best-fit property for IOMMU masters
Date:   Mon, 12 Dec 2022 13:51:37 -0800
Message-ID: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CbRTyClcUuZobNapToqzg9XupM8ShjAi
X-Proofpoint-GUID: CbRTyClcUuZobNapToqzg9XupM8ShjAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=995 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "iova-best-fit" device-tree property, which is used to
describe that the iommu master is constrained on memory and the system
must put more effort when allocating IOVAs to avoid holes/gaps in
memory. This improves the memory utilization and helps with memory
fragmentation issues in some cases, but it could take longer to allocate
an IOVA compared with the default "first-fit" algorithm.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 26ba9e530f13..ca1b4813c5bf 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -88,6 +88,10 @@ prevent any driver from properly setting up the translations.
 
 Optional properties:
 --------------------
+- iova-best-fit: When present, the best-fit algorithm will be used, instead
+  of first-fit. This reduces memory fragmentation when allocating IOVAs in
+  some cases, but may also increase the time it takes to allocate an IOVA.
+
 - pasid-num-bits: Some masters support multiple address spaces for DMA, by
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
