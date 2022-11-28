Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F071763A84E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiK1M2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiK1M2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:28:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070CDF81
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so16543883wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRbycICMlh6MzVLeROs9V0fuaWLhFxskewtEQHYdgC0=;
        b=BkXhnII9LnGEO0cfog3xYqFDi3Ly3wHmI0Q4i0q/24bvvi+yHNky1EuVYJQ42m1dgL
         AqESCAuBWGFFwznAXx1QT+MrPpLZk12Pd0a7HGP4ph5Fl13BU70ix+uYxjGmXrQfsP8K
         JnsFXpWFPumJ6GAsVi2RcfRc7eaMQjd0Ny0+ZlAT8viqdHUe2qi8D8NxWvHCcqd0SUa6
         o3Zn7gaZWwS8O4fRp8ME1UgbDQWcFmX5YduYxynjy2mL5kx8hyh+DfIXFICf7ZJ4jkT8
         dTCeDmBFphrYw9KBpcyNf5qjY8rk0fF6ay0kXs+/stGJQgyyyH4TEOEZ/DXmLsrQU+4l
         FE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRbycICMlh6MzVLeROs9V0fuaWLhFxskewtEQHYdgC0=;
        b=eeNI7G10rSEvYXe9rsHwLjFJuQnW9I/J5J8R5giXh2p7QERMF69IDZPslPJQYjIGy5
         89N7GHWC7z03TRKr27mFwEGGAM1me+lUtb67muFJ3nKNdcsQ4d54VcZg5X417qmStxak
         10P2V8z5aIveHQoYLV2HNxYBw6YVCagxe3frE7WArUgqBhEFS6OOeQVHYWa7mdoxXB8N
         StsRbhPad7XQmqvVM8l/IL3YNUJS9gqo+4DGTkNxomossA+QmBfhwCBOL69zIGr+LJe+
         hd4is9JhMouky4YJzFXPWMmg4xHfPO1DqGmg/QNfzrQlv5JxW5YEgiioy23uCc1Np8Gt
         eshw==
X-Gm-Message-State: ANoB5pmzNGhmosCQv/+5oB/BODgLAXKj61/ahiDBSFqAPREoHDG3Ucd7
        ZN4Zsfep4Ai/NMUTQqUEF1uiiA==
X-Google-Smtp-Source: AA0mqf6o7O86dAX13xPVwmED8xdJy3JfoN8fCDfnBTFvip/GNTKkDrrvXF0lZcqbunQbi3zxCqFPSw==
X-Received: by 2002:a5d:5d0f:0:b0:236:6f6f:8dd7 with SMTP id ch15-20020a5d5d0f000000b002366f6f8dd7mr21003296wrb.4.1669638513509;
        Mon, 28 Nov 2022 04:28:33 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002421db5f279sm598405wrm.78.2022.11.28.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:28:33 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 0/9] clk: qcom: Add support for SM8550
Date:   Mon, 28 Nov 2022 14:28:11 +0200
Message-Id: <20221128122820.798610-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for the Qualcomm SM8550 SoC,
It adds support for the new type of PLL, the TCSR clock controller
driver, support for configurable poll timeout, the RPMh clocks
and the bindings.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (9):
  dt-bindings: clock: Add SM8550 GCC clocks
  dt-bindings: clock: Add SM8550 TCSR CC clocks
  clk: qcom: gdsc: Add configurable poll timeout
  clk: qcom: Add LUCID_OLE PLL type for SM8550
  clk: qcom: Add GCC driver for SM8550
  dt-bindings: clock: Add RPMHCC for SM8550
  dt-bindings: clock: qcom,rpmh: Add CXO PAD clock IDs
  clk: qcom: rpmh: Add support for SM8550 rpmh clocks
  clk: qcom: Add TCSR clock driver for SM8550

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm8550-gcc.yaml       |   62 +
 .../bindings/clock/qcom,sm8550-tcsrcc.yaml    |   45 +
 drivers/clk/qcom/Kconfig                      |   15 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/clk-alpha-pll.c              |   16 +
 drivers/clk/qcom/clk-alpha-pll.h              |    5 +
 drivers/clk/qcom/clk-rpmh.c                   |  110 +-
 drivers/clk/qcom/gcc-sm8550.c                 | 3396 +++++++++++++++++
 drivers/clk/qcom/gdsc.c                       |    5 +-
 drivers/clk/qcom/gdsc.h                       |    1 +
 drivers/clk/qcom/tcsrcc-sm8550.c              |  193 +
 include/dt-bindings/clock/qcom,rpmh.h         |    2 +
 include/dt-bindings/clock/qcom,sm8550-gcc.h   |  231 ++
 .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    |   18 +
 15 files changed, 4081 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm8550.c
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h

-- 
2.34.1

