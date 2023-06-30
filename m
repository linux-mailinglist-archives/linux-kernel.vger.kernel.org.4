Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E65744052
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjF3Q6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjF3Q6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:58:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654E3C01
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e23d0a28so2499497f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144316; x=1690736316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcJVpZgsLmrXO6R6gbSb0Esg3xW+s2OxZQwgSrlzOI4=;
        b=bmpj1QwFDiJjXYDFX+GcnbAhwD9vj3tix/zCMIrizJ9MPf5UNAxQ9v/cRw6OUxt2KW
         KE3zf+2Pw7jthWTNZbprNCFqfFA+JS0W8jtQ65vZmpabGpdxDsw21KGdysW5Rgu8kg0B
         PyGJRoYvj0LevhwgFxldljpw5mn5iYALAxticdMiFKM6XyW/5qXe/04qRO6TW0fLgXzr
         aOfLaexfdvAPQ8s412PTcruvT5l9WfXM0yu7CPdJlryQ5/9gdmNvJJYUEPeAf8gw/fpM
         QPW3nEPTqE0MbjRP8zn5uMkqrqVueY9X0mScX1gQmEmP8ReqesJYgPzBGkVVqLUu7t2U
         LhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144316; x=1690736316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcJVpZgsLmrXO6R6gbSb0Esg3xW+s2OxZQwgSrlzOI4=;
        b=hup7bCh9pKkwZ2Z//T+DW3pVBFgD8jEWlVVKqSEYKHrQofPLMoQe4mOW0rvXjlbSog
         Kcwldytgg8lqhsYgLLQXifE/l7M1sivTlX4/MfrkuMBxGXmGi/b3yrLZkyJiGavuQoCz
         LVmgoiEZYfU4onvHwu1sVWfK0gw7AzpxitgTAj99m6Woq6J+9JSl8UJOROUQs/NLZw3B
         ZivAeXFrE2yW7Ns1kIiMJDKAhnDrtoQXGgZhRA9OCeVp9Y2+3+waof1d4zLB1eAwgr0H
         0f1FPxSuTPQ9O6jH4eS6ArlqaQNZ8IlrlZ2IAWchI/NYIzw4nUpdG/rZOtL6AEzfaipT
         f25Q==
X-Gm-Message-State: ABy/qLbwOx1XnbLIffGFIo44sUqgoPKKWDDwNjhj3U+UAI60EWFLZBZg
        i8e6w8KjRV88LC9YeK8Fr/bBIA==
X-Google-Smtp-Source: APBJJlHhcFD79JEamztLfiWhkMMHToukfW0Lq0jmpkL1lmL0roIp7ChdAMevzDbwRlyav8HVHBrvBg==
X-Received: by 2002:adf:f992:0:b0:314:1e87:f5d3 with SMTP id f18-20020adff992000000b003141e87f5d3mr4003549wrr.29.1688144316184;
        Fri, 30 Jun 2023 09:58:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/15] ARM: oxnas support removal
Date:   Fri, 30 Jun 2023 18:58:25 +0200
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEJn2QC/42OQQ6DIBBFr2JYdxrBaGpXvUfjAmXQSRTMgMTGe
 PdST9Dle4v//iECMmEQz+IQjIkCeZdB3QoxTNqNCGQyC1WqqqwqCdGvNIDfnQ6wrSEy6gUYF58
 QdKOwNW1jEVHkhV4HhJ61G6a84bZ5znJltLRfyXeXeaIQPX+uB0n+7H+xJKGEujf1wxppjLSvm
 Zxmf/c8iu48zy/Cf3Jp3AAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4190;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=C4rej9R1KAWJBjlpvKevYXZln3FvwK8ckfIdYSWc8hc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwmzV/0VBUuZ5VLF3VM024I/LCO+HhW4mBonGzT7
 p0UWKQeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JswAKCRB33NvayMhJ0bEoD/
 92fTad2/jmG1/xFHGsOAAbus0mtr1yygYjXJIbrhRPE9uUwLGWjQRwdCZK+9uTzPlNOnFf8VfsSAWK
 SsXzf6TJekC8afg4EWtpdlBUi5qaFI0ytw+1Rj94MZRLVKfQ8JXnxjZv8SkSvkLyueoV7rmfCHYFdK
 cnD7CB/+wSgnvcnUp/fF6Fbf1O9oGZfdLiWaglf1yqZQOptaAYEl3EawwxrGx+a7PVtbr5Q3DY7YkJ
 0hvdHTEFmFGN8YmWLTDPN5NsnwjyS4XME/j+X1VZDa9DoXkYV/55BSUROfYSjLj8gpDDaUyJlCDU3J
 RUnNef36xCarwAsdmyvK8NEU1X+I1SuFr8mz0patK77hcSogi3n9OKKg/+abu7mNekCipcgyevIxai
 L+nkDsZd1QiGImw/Q9p5qRe1agynKMLlyZwvKpFLPiWW8aNfnLrTJZuSJshOCDe90CpalL/RF4zcZ1
 X6Ol4UHFHd20V16aPz2SD8pkCdqwQfDl28ZzZFp8WC0j3BSgKHLGgzcIB1b4n9tuBzppZn35Xo3Amc
 bEFUCVh90Fm/F3vcOFjRcWdWXsZ1trY99dp1K3wekKlmXaS3QGiLdWMI3qkpl9M2bl62QT8ESQp0Hk
 jBmn6aCNV42zkSGc8Jm7jyROXzkjRH/Yz95icnWmMYEVF8Z5VLRJ9+hEOWow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With [1] removing MPCore SMP support, this makes the OX820 barely usable,
associated with a clear lack of maintainance, development and migration to
dt-schema it's clear that Linux support for OX810 and OX820 should be removed.

In addition, the OX810 hasn't been booted for years and isn't even present
in an ARM config file.

For the OX820, lack of USB and SATA support makes the platform not usable
in the current Linux support and relies on off-tree drivers hacked from the
vendor (defunct for years) sources.

The last users are in the OpenWRT distribution, and today's removal means
support will still be in stable 6.1 LTS kernel until end of 2026.

If someone wants to take over the development even with lack of SMP, I'll
be happy to hand off maintainance.

It has been a fun time adding support for this architecture, but it's time
to get over!

Now arch/arm parts are removed, now it's time to remove the remaining stuff.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- s/maintainance/maintenance/
- added acked/review tags
- dropped already applied patches
- drop RFC
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (15):
      clk: oxnas: remove obsolete clock driver
      dt-bindings: clk: oxnas: remove obsolete bindings
      clksource: timer-oxnas-rps: remove obsolete timer driver
      dt-bindings: timer: oxsemi,rps-timer: remove obsolete bindings
      nand: oxnas_nand: remove obsolete raw nand driver
      dt-bindings: mtd: oxnas-nand: remove obsolete bindings
      net: stmmac: dwmac-oxnas: remove obsolete dwmac glue driver
      dt-bindings: net: oxnas-dwmac: remove obsolete bindings
      pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
      dt-bindings: pinctrl: oxnas,pinctrl: remove obsolete bindings
      dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
      power: reset: oxnas-restart: remove obsolete restart driver
      irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
      dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark oxnas compatible as deprecated
      MAINTAINERS: remove OXNAS entry

 .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 -
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 -
 .../arm,versatile-fpga-irq.txt                     |    4 +-
 .../devicetree/bindings/mtd/oxnas-nand.txt         |   41 -
 .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 -
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 -
 .../devicetree/bindings/timer/oxsemi,rps-timer.txt |   17 -
 MAINTAINERS                                        |   10 -
 drivers/clk/Kconfig                                |    7 -
 drivers/clk/Makefile                               |    1 -
 drivers/clk/clk-oxnas.c                            |  251 ----
 drivers/clocksource/Kconfig                        |    7 -
 drivers/clocksource/Makefile                       |    1 -
 drivers/clocksource/timer-oxnas-rps.c              |  288 -----
 drivers/irqchip/irq-versatile-fpga.c               |    1 -
 drivers/mtd/nand/raw/Kconfig                       |    7 -
 drivers/mtd/nand/raw/Makefile                      |    1 -
 drivers/mtd/nand/raw/oxnas_nand.c                  |  209 ----
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 -
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c  |  245 ----
 drivers/pinctrl/Kconfig                            |   11 -
 drivers/pinctrl/Makefile                           |    1 -
 drivers/pinctrl/pinctrl-oxnas.c                    | 1292 --------------------
 drivers/power/reset/Kconfig                        |    7 -
 drivers/power/reset/Makefile                       |    1 -
 drivers/power/reset/oxnas-restart.c                |  233 ----
 27 files changed, 3 insertions(+), 2816 deletions(-)
---
base-commit: 5c875096d59010cee4e00da1f9c7bdb07a025dc2
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

