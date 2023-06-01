Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1987191B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFAEV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFAEVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:21:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E26718F;
        Wed, 31 May 2023 21:21:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3512THVG014264;
        Thu, 1 Jun 2023 04:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=QHM/WHCJDISRydD6S6QXRiWn068wj1AI1qf3+4/twIU=;
 b=FVYjl86VI5wFCMvYP7ifcoSgEA+f8kwLWKNwKseLniPsMVbawZ8FPHV57vJLbSSf/yJu
 4lMi08SAlBvVxW6PuRLFt3Y4r6OCiMmbBpAwQYb/530Ogiep7QFSNchnXM82kgbr1zmp
 H9QggxZ70wU++iPf1b1vTH7Z8ZA6YKQ9wuK+wQl0aN6IekTMToDf+TKUIONw30v8u11Q
 DBs0RbzzTdzrqYloQ+9/qEWqdtmRhSYvdxEbsHFMg8hOBK2P8t9TE6RgEjH40okRg+u2
 cpYInDtLt3mEj29rjJHVCydrss4de0NVw5PlmU+uXE/1gBzRVyxRYgyNvo6Am27fBj9c xQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx5pxhxs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 04:21:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3514LBH0013322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 04:21:11 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 21:21:08 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH RESEND 0/4] Add initial support for RDP474 of IPQ5332 family
Date:   Thu, 1 Jun 2023 09:50:50 +0530
Message-ID: <20230601042054.29075-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 76rKpWMqCggwYXE9aD6MlbP7JDmYoxZK
X-Proofpoint-ORIG-GUID: 76rKpWMqCggwYXE9aD6MlbP7JDmYoxZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_02,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=938
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 474 based on IPQ5332 family of SoC. This patch carries
the support for Console UART, eMMC, I2C and GPIO based buttons.

Most of the features of RDP474 is similar to RDP441, except that the
QDSP will not be used in RDP474, whereas it will be used in the RDP441.

RDP474 comes with the SoC IPQ5300, so add the SoC info support for the
same.

Corrected the RDP number in the subject, so resending it.

Kathiravan T (4):
  dt-bindings: arm: qcom,ids: add SoC ID for IPQ5300
  soc: qcom: socinfo: Add Soc ID for IPQ5300
  dt-bindings: arm: qcom: document MI01.9 board based on IPQ5332 family
  arm64: dts: qcom: ipq5332: add support for the RDP474 variant

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts   | 112 ++++++++++++++++++
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 5 files changed, 117 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts

-- 
2.17.1

