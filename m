Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7E6B8AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCNGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCNGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:14:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3950D508;
        Mon, 13 Mar 2023 23:14:18 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3XRuH012899;
        Tue, 14 Mar 2023 06:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=APTbAy3Wo+FvL6/zgYOJPU6dR9Rl+NuwYkVLQDCFGyA=;
 b=RicLGQq3qpwxZJa5yjE8oprVP4GMkKfw1kR56/CHVHnG2+t+WvyuE9ENLpwP1QRUJC+L
 iroQMXiQzhZjzWFt/DI7JScdx+iep42LMJtp4TmLq3ifE567r+E0pFqMRTHG1SYVsVXM
 R442xnee5He8Kgn67jNQUKft8TXKNHNhF1mfWYIli9sohKJyv7OD07K3LfiCsjSgEgwO
 ZR0GCoopH7TqzT8fTiVr+yPNnUhaupkZMmHyaLJosoEUVwr7JXmbc9UxDPBWstC1RCj3
 7t23Fjr30GkhBFdfjcdbqtIXXz1mLZUrrOPNj0wvgMJGSS//PmpV3IeBRGflMVehCjsS /A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa6n31vq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:14:12 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E6EBKS017526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:14:11 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Mar 2023 23:14:08 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 0/2] socinfo support for IPQ9574 family of SoCs
Date:   Tue, 14 Mar 2023 11:43:32 +0530
Message-ID: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pSbf5OngVUw1n20WW_j4jSwb0rzrHtMh
X-Proofpoint-GUID: pSbf5OngVUw1n20WW_j4jSwb0rzrHtMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=654 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for qcom-socinfo for IPQ9574 family of SoCs.

Functionally this series needs SMEM support added in
https://lore.kernel.org/linux-arm-kernel/20230216120012.28357-1-quic_poovendh@quicinc.com/

Varadarajan Narayanan (2):
  dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and its variants
  soc: qcom: socinfo: Add IDs for IPQ9574 and its variants

 drivers/soc/qcom/socinfo.c         | 6 ++++++
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.7.4

