Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84196DF702
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjDLNXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjDLNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A442872AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:22:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id jg21so28456339ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681305768; x=1683897768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RltCn4YUT7RCxDnBevIyhwMQuU2SIbRp5f9zMV5Sv38=;
        b=oJwrggjQyBcBt2mLYzHpfAF7i+mxFiLq1Mpirouy+E/X0TAzG02bnlP4Xl+3otboYq
         rOW/j+zA6IIz8vD+403FKll3p0eLCMoo0s2zW2VkuKpHoky0B3Xbc4AVKe/dQEpFcm32
         PiaCE46mgpOZKyGsBTJoGPLMDFNnJ3PfrNDs0bVlMDDdvdcmpene550CpXpkQ89ZGkaN
         1saQFtKwQAKXOYq9kLn/ibQxy9BH081x2K6KWPjQNVc/YcdpaZ2jUh0w9ZqAA58ZFiKA
         GnEjw8t6NCM9eLRd2QmsILwV+ST9F1RrtR7+1hNVTpIY0CWt9mZMaHzKYVs1eb8V20V7
         xDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305768; x=1683897768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RltCn4YUT7RCxDnBevIyhwMQuU2SIbRp5f9zMV5Sv38=;
        b=fcP3WndDtB1xpzc/B42wySzHP9HIWVHgiKfTQxmzwgO2AhB6Zh1D7CEgo3RhK/8Alc
         MmGOlTh+RglSfoXYijrVaApEyfvm9jDYxoc/HHKci4GcUyiUHMilXvcREkhngg/Zympa
         IHHNXE6GdS+fc2sT/RRq1A+EZYcBeSGpiVomUhA9zJqgcFRt76q+0maU3WXfq8ysrjlm
         NU9AXGkoQxTQcbS6nT7jGeVuknA7x43QYNAD+3Ef8MltkFyL0vzX2zkmcj/2JdmIm/x/
         J5D5q6KL6upX8/4oHnsYOJX837IRgv0u2/QYdqHkA/b0+di9evUeal535Oi8+D1BzSoJ
         V2Rg==
X-Gm-Message-State: AAQBX9ecOfwepEMplNFoHfxPFMIAX+5FFcp0or2w6vyG92p3Ff7FYxyy
        RIckKjtqvVxeockmC8an2m4lTA==
X-Google-Smtp-Source: AKy350ZlPNmI2nk6q0LkOGaoiAINrP7ST/oN8cxvmAfyq2lpEbXEs7WyioeCtEeM99j5Z8R9hYZOkA==
X-Received: by 2002:a17:906:70cf:b0:939:e870:2b37 with SMTP id g15-20020a17090670cf00b00939e8702b37mr16048317ejk.70.1681305768583;
        Wed, 12 Apr 2023 06:22:48 -0700 (PDT)
Received: from localhost.localdomain ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id hp39-20020a1709073e2700b0094e621086c8sm648189ejc.106.2023.04.12.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:22:48 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.4
Date:   Wed, 12 Apr 2023 16:22:43 +0300
Message-Id: <20230412132243.3849779-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.4

for you to fetch changes up to 8a05f5cccdbe851265bf513643ada48c26b1267f:

  clk: imx: imx8ulp: update clk flag for system critical clock (2023-04-09 17:12:49 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.4

- Add clock generic devm_clk_hw_register_gate_parent_data.
- Add audiomix block control for i.MX8MP.
- Add support for determine_rate to composite-8m.
- Add new macro for composite-8m to allow custom flags.
- Let the LCDIF Pixel clock of i.MX8MM and i.MX8MN set parent rate.
- Provide clock name in error message for clk-gpr-mux on get parent
  failure.
- Drop duplicate imx_clk_mux_flags macro.
- Register the i.MX8MP Media Disp2 Pix clock as bus clock.
- Add Media LDB root clock to i.MX8MP.
- Make i.MX8MP nand_usdhc_bus clock as non-critical.
- Fix the rate table for fracn-gppll.
- Disable HW control for the fracn-gppll in order to be controlled by
  register write.
- Add support for interger PLL in fracn-gppll.
- Add mcore_booted module parameter to i.MX93 provider.
- Add NIC, A55 and ARM PLL clocks to i.MX93.
- Fix i.MX8ULP XBAR_DIVBUS and AD_SLOW clock parents.
- Use "divider closest" clock type for PLL4_PFD dividers on i.MX8ULP to
  get more accurate clock rates.
- Mark the MU0_Bi and TPM5 clocks on i.MX8ULP as critical.
- Update some of the critical clocks flags to allow glitchless
  on-the-fly rate change.

----------------------------------------------------------------
Adam Ford (4):
      clk: imx: composite-8m: Add support to determine_rate
      clk: imx: Add imx8m_clk_hw_composite_flags macro
      clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
      clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate

Haibo Chen (1):
      clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical

Jacky Bai (5):
      clk: imx: fracn-gppll: Add 300MHz freq support for imx9
      clk: imx: imx8ulp: Add divider closest support to get more accurate clock rate
      clk: imx: imx8ulp: keep MU0_B clock enabled always
      clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
      clk: imx: imx8ulp: update clk flag for system critical clock

Liu Ying (1):
      clk: imx: imx8mp: Add LDB root clock

Marek Vasut (3):
      clk: Introduce devm_clk_hw_register_gate_parent_data()
      clk: imx: imx8mp: Add audiomix block control
      dt-bindings: clock: imx8mp: Add audiomix block control

Peng Fan (10):
      clk: imx: drop duplicated macro
      clk: imx: imx8mp: correct DISP2 pixel clock type
      dt-bindings: clock: imx8mp: Add LDB clock entry
      clk: imx: fracn-gppll: fix the rate table
      clk: imx: fracn-gppll: disable hardware select control
      clk: imx: fracn-gppll: support integer pll
      clk: imx: imx93: add mcore_booted module paratemter
      dt-bindings: clock: imx93: add NIC, A55 and ARM PLL CLK
      clk: imx: imx93: Add nic and A55 clk
      clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents

Stefan Wahren (1):
      clk: imx: clk-gpr-mux: Provide clock name in error message

 .../devicetree/bindings/clock/imx8mp-audiomix.yaml |  79 ++++++
 drivers/clk/imx/Makefile                           |   2 +-
 drivers/clk/imx/clk-composite-8m.c                 |   7 +
 drivers/clk/imx/clk-composite-93.c                 |   8 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |  91 +++++--
 drivers/clk/imx/clk-gpr-mux.c                      |   3 +-
 drivers/clk/imx/clk-imx8mm.c                       |   2 +-
 drivers/clk/imx/clk-imx8mn.c                       |   2 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c              | 277 +++++++++++++++++++++
 drivers/clk/imx/clk-imx8mp.c                       |   5 +-
 drivers/clk/imx/clk-imx8ulp.c                      |  34 +--
 drivers/clk/imx/clk-imx93.c                        |  19 +-
 drivers/clk/imx/clk.h                              |  23 +-
 include/dt-bindings/clock/imx8mp-clock.h           |   4 +-
 include/dt-bindings/clock/imx93-clock.h            |   6 +-
 include/linux/clk-provider.h                       |  19 ++
 16 files changed, 535 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
 create mode 100644 drivers/clk/imx/clk-imx8mp-audiomix.c
