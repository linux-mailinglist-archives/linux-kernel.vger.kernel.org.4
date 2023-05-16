Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C55704579
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjEPGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEPGtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:49:25 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8C3A87;
        Mon, 15 May 2023 23:48:46 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 16 May 2023
 14:48:34 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V8 RESEND 0/4] Add S4 SoC PLL and Peripheral clock
Date:   Tue, 16 May 2023 14:47:32 +0800
Message-ID: <20230516064736.10270-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add S4 SoC PLL and Peripheral clock controller dt-bindings.
2. Add PLL and Peripheral clock controller driver for S4 SOC.

Yu Tu (4):
  dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
  dt-bindings: clock: document Amlogic S4 SoC peripherals clock
    controller
  clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
  clk: meson: s4: add support for Amlogic S4 SoC peripheral clock
    controller

V7 -> V8:
1. Change patch 0001/0002 dt-bindings title description, remove "meson".
Suggested by Dmitry, Neil.
2. Change patch 0003/0004 clocks comment, format and clock flags suggested by
Dmitry, Neil, Jerome.

V6 -> V7: Change send patch series as well change format and clock flags
suggested by Jerome. Change dt-bindings suggested by Krzysztof.
V5 -> V6: Change send patch series, as well change format and clock flags.
V4 -> V5: change format and clock flags and adjust the patch series
as suggested by Jerome.
V3 -> V4: change format and clock flags.
V2 -> V3: Use two clock controller.
V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/all/20230417065005.24967-1-yu.tu@amlogic.com/

 .../clock/amlogic,s4-peripherals-clkc.yaml    |   97 +
 .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   50 +
 MAINTAINERS                                   |    1 +
 drivers/clk/meson/Kconfig                     |   25 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/s4-peripherals.c            | 3830 +++++++++++++++++
 drivers/clk/meson/s4-peripherals.h            |  217 +
 drivers/clk/meson/s4-pll.c                    |  907 ++++
 drivers/clk/meson/s4-pll.h                    |   87 +
 .../clock/amlogic,s4-peripherals-clkc.h       |  131 +
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   30 +
 11 files changed, 5377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/s4-peripherals.c
 create mode 100644 drivers/clk/meson/s4-peripherals.h
 create mode 100644 drivers/clk/meson/s4-pll.c
 create mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.33.1

