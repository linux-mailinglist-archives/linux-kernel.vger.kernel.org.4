Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949C747C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGEFkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGEFkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:40:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D69134;
        Tue,  4 Jul 2023 22:40:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655Renj022807;
        Wed, 5 Jul 2023 05:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=VM/FRiF8lVHCl9w9QVVVXLL6CnyVsswhOVz6Z6ptw8g=;
 b=J8qheoS/oFE2X6Hu9ybcArc09RsJCoR4eQTF1bvhmBfa1QeJ1h21Zv3tQ5K2WzNKZg5T
 ans+G4DB8BFgRPOAm5SmjW0UojoxkhbzdKn1p0wR34PIBm6Uh60qb+HRzMg580/HUhvT
 vujao4eqn8PMDDPT+z+OJFmaHDYuvg5qfAbG7KAXBHLkV3YqdUg8PAUgqyx92sihobE8
 IBXsHIlqIuXclg5LqrfSr9XRxWuvzs8GUQpbrennCQA/zbZFDiEARFmizlq09sfO2v4I
 M0+qULmFISd7Un5yFPGIdJ3740zvxuX8eozMKiP6CDQdn3keuXz7/7sJY2EALXcHiglC nA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxpn8ar7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 05:39:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3655dtaI013005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 05:39:55 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 22:39:52 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/2] arm64: dts: qcom: qdu1000: Update reserved memory region
Date:   Wed, 5 Jul 2023 11:09:12 +0530
Message-ID: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3TY6BavH9Lju8_4qK_OF7HXDLU-camkf
X-Proofpoint-GUID: 3TY6BavH9Lju8_4qK_OF7HXDLU-camkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=376
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update reserved memory region for QDU1000 and QRU1000 SoCs.

Komal Bajaj (2):
  arm64: dts: qcom: qdu1000-idp: Update reserved memory region
  arm64: dts: qcom: qru1000-idp: Update reserved memory region

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 16 +++++++++++++++
 2 files changed, 42 insertions(+)

-- 
2.40.1

