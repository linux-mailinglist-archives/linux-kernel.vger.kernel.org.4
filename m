Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3907A722CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjFEQa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjFEQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:29:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D53CD;
        Mon,  5 Jun 2023 09:29:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355FsagK004361;
        Mon, 5 Jun 2023 16:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vL6D0As9ECdahRNEPut0utmGQpSV82VRmuPgQ0w6HiU=;
 b=k1bmnUIXRzVBx8zsfRJABLi83+C4m8vPap6pYLMvNtjQx9fNp2eaQ7O2m69OycyB255s
 i8ZJZftkwDSsEItwc4ahxJ9h/AnL0I/vhK7tp3RnpcTjB5yMQmThXrCJf5S0Paf6SNhi
 0eSre1RhTidyKohhybRD1+SdhLf3pzAtPzjrvmC2IyByXh7A0VKw2k9HOgQfelbwQlE5
 AAOZ1m85LnM8DyzgV7A1D4q08res9u0VyXRhLIcemCsPPp2JxE0ujmr7HkDxzuh9ISiA
 V9OnxvjKKnOCscI+ilAdPPkYO5wx2cDsWodAhkbTD+FGMfEzkiLUSb6LkJR42WomNurW HQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1arnsf2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 16:29:23 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 355GTJlQ030307;
        Mon, 5 Jun 2023 16:29:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkkq41b-1;
        Mon, 05 Jun 2023 16:29:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355GTI4v030293;
        Mon, 5 Jun 2023 16:29:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 355GTIau030291;
        Mon, 05 Jun 2023 16:29:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id D1CFA5F03; Mon,  5 Jun 2023 21:59:17 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
        robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 00/10] Add devicetree support for SDX75 Modem and IDP
Date:   Mon,  5 Jun 2023 21:59:07 +0530
Message-Id: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FIyRgPkSvHuPpeP1VKL5Wjd0GmoV2R8z
X-Proofpoint-GUID: FIyRgPkSvHuPpeP1VKL5Wjd0GmoV2R8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=641
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050141
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Added the CPUFreq support patch.
 - Collected the Acked by tags.
 - Addressed some minor comments from Konrad.

This series adds devicetree support for Qualcomm SDX75 platform and IDP
board. This series functionally depends on GCC and RPMh Clock support
series [1], and pinctrl support for SDX75 [2] which are under review.

With this current devicetree support, the IDP can boot into initramfsshell.

[1] https://lore.kernel.org/lkml/20230419133013.2563-3-quic_tdas@quicinc.com/
[2] https://lore.kernel.org/all/1684409015-25196-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Imran Shaik (1):
  arm64: dts: qcom: Add support for GCC and RPMHCC for SDX75

Rohit Agarwal (9):
  dt-bindings: arm: qcom: Document SDX75 platform and boards
  dt-bindings: firmware: scm: Add compatible for SDX75
  dt-bindings: interrupt-controller: Add SDX75 PDC compatible
  dt-bindings: arm-smmu: Add SDX75 SMMU compatible
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75 compatible
  arm64: dts: qcom: Add SDX75 platform and IDP board support
  arm64: dts: qcom: Add QUPv3 UART console node for SDX75
  arm64: dts: qcom: Enable the QUPv3 UART console for SDX75
  arm64: dts: qcom: Add the support of cpufreq on SDX75

 Documentation/devicetree/bindings/arm/qcom.yaml    |   7 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdx75-idp.dts             |  33 ++
 arch/arm64/boot/dts/qcom/sdx75.dtsi                | 647 +++++++++++++++++++++
 8 files changed, 692 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi

-- 
2.7.4

