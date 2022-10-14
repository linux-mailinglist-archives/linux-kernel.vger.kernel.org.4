Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C915FF607
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJNWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJNWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:10:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B86FAE66;
        Fri, 14 Oct 2022 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665785442; x=1697321442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P3QMyKLfirC1SWV0s4npdIwk7ADO33QXeooooDPohT0=;
  b=pp21dJaT00y2e8s+mxG25Eb8VvR7M5zuigk7DgjCQTYmY8NzfaFudJWm
   FShny/33ayH9wyLK8YUpW78xc6whEPErv9u5sbd9/AjJ1YqTcSXfVztbD
   pbPuc4OoKNkXk6+4w8S74l89X3QL6ytl3lwHdO9iXATlz7SrsVN1U57hj
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Oct 2022 15:10:38 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 15:10:37 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:10:22 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 0/6] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Fri, 14 Oct 2022 15:10:05 -0700
Message-ID: <20221014221011.7360-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the GCC, RPMh, and PDC clock support required for the
QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

This patchset is based on the YAML conversion patch [1] submitted already.

[1] https://lore.kernel.org/r/20220103074348.6039-1-luca.weiss@fairphone.com

Imran Shaik (1):
  clk: qcom: branch: Add BRANCH_HALT_INVERT flag support for branch
    clocks

Melody Olvera (4):
  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
  dt-bindings: clock: Add RPMHCC bindings for QDU1000 and QRU1000
  clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
  dt-bindings: qcom,pdc: Introduce pdc bindings for QDU1000 and QRU1000

Taniya Das (1):
  clk: qcom: Add QDU1000 and QRU1000 GCC support

 .../bindings/clock/qcom,gcc-qdu1000.yaml      |   70 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    2 +
 .../interrupt-controller/qcom,pdc.yaml        |    2 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-branch.c                 |    5 +
 drivers/clk/qcom/clk-branch.h                 |    2 +
 drivers/clk/qcom/clk-rpmh.c                   |   14 +
 drivers/clk/qcom/gcc-qdu1000.c                | 2644 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qdu1000.h  |  170 ++
 10 files changed, 2918 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
 create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h


base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
-- 
2.38.0

