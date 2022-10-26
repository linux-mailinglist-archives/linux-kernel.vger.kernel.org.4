Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F9260E9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiJZUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiJZUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:04:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3FC123464;
        Wed, 26 Oct 2022 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666814681; x=1698350681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xjqZcX/w60yx5/h99rH2JbvNNgZ5iiv92T8VqJf6IA8=;
  b=ewJyBph/It005533Ml95Cf0VSu4ehcRJMfDhvKquje2Qp8HLbfo8Lb4X
   yyEaJ5MaEH+HtL9GCTtsXV1T6AWkXzG+sOQNJZ3fYgv1zGm602qd8Fcfi
   4Cx5+Yy4uoR/KTLwIdIBhFOy0fjTzjDkDJ6iNJ/xJgk0z1g9AXfE1F1OI
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Oct 2022 13:04:40 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:04:40 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 13:04:40 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 0/4] Add base device tree files for QDU1000/QRU1000
Date:   Wed, 26 Oct 2022 13:04:25 -0700
Message-ID: <20221026200429.162212-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the base device tree files and DTS support for the
Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
regulators, mmc, interconnects, cpufreq, and qup. 

This patchset is based off of [1] which adds support for the PMIC arb used
on these SoCs. It also requires the dt-bindings from [2], [3], [4], [5],
and [6].

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/all/20220914165212.3705892-3-vkoul@kernel.org/
[2] https://lore.kernel.org/all/20221026190441.4002212-1-quic_molvera@quicinc.com/
[3] https://lore.kernel.org/all/20221026190457.4003037-1-quic_molvera@quicinc.com/
[4] https://lore.kernel.org/all/20221026190520.4004264-1-quic_molvera@quicinc.com/
[5] https://lore.kernel.org/all/20221026190534.4004945-1-quic_molvera@quicinc.com/
[6] https://lore.kernel.org/all/20221026190549.4005703-1-quic_molvera@quicinc.com/

Changes from v2:
- Revised device nodes to match updated dt-bindings
- Revised rpmh-rsc bindings to allow for generic regulator nodes
- Updated soc ordering
- Moved clock node to DTS files
- Updated regulator nodes to be generic
- Removed some unnecessary whitespace

Melody Olvera (4):
  dt-bindings: soc: qcom,rpmh-rsc: Update to allow for generic nodes
  dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
  arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
  arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs

 .../devicetree/bindings/arm/qcom.yaml         |   16 +
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |    2 +-
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      |  245 +++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 1406 +++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts      |  245 +++
 arch/arm64/boot/dts/qcom/qru1000.dtsi         |   27 +
 7 files changed, 1942 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: 60eac8672b5b6061ec07499c0f1b79f6d94311ce
prerequisite-patch-id: 01437f10d7e0ca6365e82de7d3097110e5f5015b
prerequisite-patch-id: 2b59bb9d152bd8f3094e2a4e16d62191a40da67f
prerequisite-patch-id: c39bef976384eacd3ff0c28168bca355e3c1609d
prerequisite-patch-id: 116279180e6d97fbbdcc6738627daad393680a58
prerequisite-patch-id: 58dc60e65b348ec703dba9327f51656d4ac81717
prerequisite-patch-id: b67d749c7d2e3f6639c547f7908911c5dfb92ba4
prerequisite-patch-id: 93c63c6cdcc2acb525ea4a958b1c6443e6fe3580
prerequisite-patch-id: bc93c707c0fdbd6b25b0c595e6e121038ab89af4
prerequisite-patch-id: 5e7a02607aecd3f5346a2f450982601cf6935e54
-- 
2.25.1

