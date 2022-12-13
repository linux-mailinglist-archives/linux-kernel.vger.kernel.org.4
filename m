Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9ED64BF81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiLMWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiLMWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:43:21 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7094621834;
        Tue, 13 Dec 2022 14:43:19 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="143229812"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 07:43:18 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C83C40F34F4;
        Wed, 14 Dec 2022 07:43:13 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 0/5] Driver support for RZ/V2M PWC
Date:   Tue, 13 Dec 2022 22:43:05 +0000
Message-Id: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWC IP found in the RZ/V2M family of chips fits the Multi-Function
Device (MFD) model quite well, and comes with the below capabilities:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

This series introduces a driver to address GPIO support, and a driver
to address power off support, alongside the corresponding dt-bindings.

Thanks,
Fab

Fabrizio Castro (5):
  dt-bindings: gpio: Add RZ/V2M PWC GPIO driver bindings
  dt-bindings: power: reset: Add RZ/V2M PWC Power OFF bindings
  dt-bindings: mfd: Add RZ/V2M PWC global registers bindings
  gpio: Add support for Renesas RZ/V2M PWC
  power: reset: Add new driver for RZ/V2M PWC poweroff

 .../bindings/gpio/renesas,rzv2m-pwc-gpio.yaml |  62 +++++++++
 .../bindings/mfd/renesas,rzv2m-pwc.yaml       |  70 ++++++++++
 .../reset/renesas,rzv2m-pwc-poweroff.yaml     |  48 +++++++
 drivers/gpio/Kconfig                          |   8 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rzv2m-pwc.c                 | 123 ++++++++++++++++++
 drivers/power/reset/Kconfig                   |  10 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/rzv2m-pwc-poweroff.c      |  81 ++++++++++++
 9 files changed, 404 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
 create mode 100644 drivers/gpio/gpio-rzv2m-pwc.c
 create mode 100644 drivers/power/reset/rzv2m-pwc-poweroff.c

-- 
2.34.1

