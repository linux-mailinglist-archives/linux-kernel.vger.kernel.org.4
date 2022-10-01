Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5B5F1945
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiJADKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiJADHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2227B23;
        Fri, 30 Sep 2022 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593632; x=1696129632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KFP69rsxvRs18jOTbko7p9ZvY6qXsRDIw93NWHFtV+M=;
  b=NEdonhxLD+F/h4xlNwYni6GubZoVgPlhRZghDdv2Ff38MfJlhSRh7yRM
   m3O3i9EeJSIdI/bIftghMGslmsytdnZcF5RXsbUReTbcyEb0mjtHKQcXT
   Ejk8K8r1Dcbn4f56fmsW9U7BtnZeyC0H2XHraEn2HRZQKVR4qjabUWix9
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2022 20:07:12 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:12 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:12 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 00/19] Add base device tree files for QDU1000/QRU1000
Date:   Fri, 30 Sep 2022 20:06:37 -0700
Message-ID: <20221001030656.29365-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Melody Olvera (19):
  arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
  arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
  arm64: dts: qcom: qdru1000: Add tlmm nodes
  arm64: dts: qcom: qdu1000: Add reserved memory nodes
  arm64: dts: qcom: qru1000: Add reserved memory nodes
  arm64: dts: qcom: qdru1000: Add smmu nodes
  arm64: dts: qcom: qdu1000-idp: Add RPMH regulators nodes
  arm64: dts: qcom: qru1000-idp: Add RPMH regulators nodes
  arm64: dts: qcom: qdru1000: Add interconnect nodes
  arm64: dts: qcom: qdru1000: Add rpmhpd node
  arm64: dts: qcom: qdru1000: Add spmi node
  arm64: dts: qcom: qdu1000-idp: Include pmic file
  arm64: dts: qcom: qru1000-idp: Include pmic file
  arm64: dts: qcom: qdru1000: Add cpufreq support
  arm64: dts: qcom: qdru1000: Add additional QUP nodes
  arm64: dts: qcom: qdru1000: Add gpi_dma nodes
  arm64: dts: qcom: qdru1000: Add I2C nodes for QUP
  arm64: dts: qcom: qdru1000: Add SPI devices to QUP nodes
  arm64: dts: qcom: qdru1000: Add additional UART instances

 arch/arm64/boot/dts/qcom/Makefile        |    2 +
 arch/arm64/boot/dts/qcom/qdru1000.dtsi   | 1499 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  231 ++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    |  160 +++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  231 ++++
 arch/arm64/boot/dts/qcom/qru1000.dtsi    |  155 +++
 6 files changed, 2278 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdru1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
prerequisite-patch-id: 79eb132c9ff1a0feb653bef87e3e93f6841f81ee
prerequisite-patch-id: e25ad91d89a9d4a24f1081e5c03cb20678c6e94b
prerequisite-patch-id: e882ee6dbd8d55069a313e9c2b10a1ea7f6b80fb
prerequisite-patch-id: 85c1f1845b2e69ef50e7e8391426e6cab6c66381
prerequisite-patch-id: 5fd7e4f92a95a7dedc49fd39fdffd5e02c838190
prerequisite-patch-id: c8d9475d6bb2d24102e5bfee65f74d2c0365db68
prerequisite-patch-id: a03c3288ed927cbab6a42d3ad49df4347cfc9722
prerequisite-patch-id: aa7ddf85d2a1c02e4d649632425910e44f73a567
prerequisite-patch-id: 5e7a02607aecd3f5346a2f450982601cf6935e54
-- 
2.37.3

