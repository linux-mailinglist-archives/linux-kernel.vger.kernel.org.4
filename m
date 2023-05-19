Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742CE7092BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjESJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjESJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:09:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCC10D2;
        Fri, 19 May 2023 02:09:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J812nh004592;
        Fri, 19 May 2023 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kfZ4hq/pQMHtUBjomjlWSSBL8Bp5tezRu4RsePmo6OQ=;
 b=D09az571j8RQsilwV2ZMvi9ytJyIDg5cdrp2//iLBd3o6JGzE7XyRByp1LS6KFrdfCOG
 m59wT8VcRYGwbS+cNKHxtrTrk8xJlnu73qWfoXOVn3aNauXlEwZ3tDndTXN3kYv8pYv5
 NV25JPjzpj34cDDKCIc5PrOiE/blvC/DkiTMozUBpDNhfAoRggs5RUK7J84OUJ9KdhAX
 MH4ypmWAX55jBNFI3dWdZmOOr5r6553cjtwLVXnmcYxVGNXtju3flq0Kok+JbntKoVbU
 n00eefJ4un0lPGOIao1oqE5RlBtht7+yX2Kds1kEtd01Ax8JNEHivVrlGSBAEHXJYL8P 2g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp57y03ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J98CEB030916;
        Fri, 19 May 2023 09:09:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm558c-1;
        Fri, 19 May 2023 09:09:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99C4K031624;
        Fri, 19 May 2023 09:09:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99CdN031617;
        Fri, 19 May 2023 09:09:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0735A5EC0; Fri, 19 May 2023 14:39:12 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/8] dt-bindings: firmware: scm: Add compatible for SDX75
Date:   Fri, 19 May 2023 14:39:04 +0530
Message-Id: <1684487350-30476-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9lpX6mrOMLLc09z_SR4j7tblunN3B67G
X-Proofpoint-ORIG-GUID: 9lpX6mrOMLLc09z_SR4j7tblunN3B67G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=969 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190076
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree compatible for SCM present in SDX75 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 367d04a..09073e1 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -51,6 +51,7 @@ properties:
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
+          - qcom,scm-sdx75
           - qcom,scm-sm6115
           - qcom,scm-sm6125
           - qcom,scm-sm6350
-- 
2.7.4

