Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF645FF64C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJNWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJNWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:12:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F511DC085;
        Fri, 14 Oct 2022 15:12:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ELnb2i008467;
        Fri, 14 Oct 2022 22:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FaNts6LMPIAAACVivPFfp/fmMgw5qh34tkZdPKo4RL0=;
 b=d7vKW/VPcSH3Li9c6YMUUEC/5i3aGufUxPeS/cWx9haHglCCWdMRoc+2wl+bxRHio2zN
 R2O3uEKmXKeB/qa6V3go61xvSMHZh5G9oTW7eAl34uUAIukiajCLQmJw0r1XN7XAvKhc
 FWy7lvnZy10fUVKsEbhgj88JT3ZRqtWlt5i2iYd3xtCxp9SWRCKEyNfHaPLbMO0et/d7
 VuACFq/CXaJ0j/1zkmRW+gWCiO4bQqTSSKWARIDpAHeMS+ugK77pZQbVt6f0PV7FiAXE
 EtgSZGO2TFglvwgXaXdbKkCIjUBgWBsjnQP+yJPBoWeg5W9sFt4aX/UaErH1w5DyBnLI Jg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k7g14r202-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:12:15 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMCEDY007461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:12:14 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:55 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 0/3] Add base device tree files for QDU1000/QRU1000
Date:   Fri, 14 Oct 2022 15:11:35 -0700
Message-ID: <20221014221138.7552-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wo9KFlWK6YbqiZalJqhCCVW471gCJoqT
X-Proofpoint-GUID: wo9KFlWK6YbqiZalJqhCCVW471gCJoqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=686 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the base device tree files and DTS support for the
Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
regulators, mmc, interconnects, cpufreq, and qup. 

This patchset is based off of [1] which adds support for the PMIC arb used
on these SoCs.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/all/20220914165212.3705892-3-vkoul@kernel.org/

Melody Olvera (3):
  dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
  arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
  arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs

 .../devicetree/bindings/arm/qcom.yaml         |   16 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      |  230 +++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 1646 +++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts      |  230 +++
 arch/arm64/boot/dts/qcom/qru1000.dtsi         |   27 +
 6 files changed, 2151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
prerequisite-patch-id: 5e7a02607aecd3f5346a2f450982601cf6935e54
-- 
2.38.0

