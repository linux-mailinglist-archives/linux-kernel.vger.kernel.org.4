Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C497762FC58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiKRSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiKRSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:18:41 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43966585F;
        Fri, 18 Nov 2022 10:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1668795520; x=1700331520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dPGyuEzi6IpkYwLZ1+n3YwrQbzkmn/uaQZax93HDYzA=;
  b=dPJBwqDoHEDs4yGyN++6oriurFZS+ryvSviZDErXVW2U/nlgQEYmDhIO
   0vNJxs2NYvhPMb62e3HCsA0GCqea48r1JxJabcBxGUdxlJl9EqFcAzYbN
   RfUTAIpzF2Fykq/UKMTProDg6S/6Mfs4qz/Mo/VYEEaiyaZrEhWl9Zc/y
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Nov 2022 10:18:37 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:18:37 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 10:18:37 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v4 0/2] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoC
Date:   Fri, 18 Nov 2022 10:18:24 -0800
Message-ID: <20221118181826.28269-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
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

This series adds the GCC, RPMh, and PDC clock support required for the
QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

Changes from v3:
- added example sources for PCIE and USB clocks
- added index enum in GCC clock driver
- fixed some style issues
- removed pdc patches from set

Changes from v2:
- Revised dt-bindings
- Removed qru compat strings
- Updated some clocks to use clk_branch ops instead of clk_branch2 and HALT_ENABLE

Melody Olvera (1):
  dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks

Taniya Das (1):
  clk: qcom: Add QDU1000 and QRU1000 GCC support

 .../bindings/clock/qcom,gcc-qdu1000.yaml      |   70 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-qdu1000.c                | 2653 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qdu1000.h  |  170 ++
 5 files changed, 2902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
 create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h


base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
-- 
2.38.1

