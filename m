Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9464B103
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiLMIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiLMIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:06 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E4B013D0A;
        Tue, 13 Dec 2022 00:25:05 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:03 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7C8642058B4F;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:03 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 15EBAA855C;
        Tue, 13 Dec 2022 17:25:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier miscellaneous register blocks and fix examples
Date:   Tue, 13 Dec 2022 17:24:32 +0900
Message-Id: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces dt-bindings documents for miscellaneous register
blocks implemented in Socionext UniPhier SoCs.

These are previously defined in the devicetree and used in the examples
of subnodes' dt-bindings, however, not documented.

These include two types of the blocks

* independent block including miscellaneous registers and functions for
  the whole SoC (system controller and SoC-glue logic)

* sideband logic including control registers in the component (others)

And prior to adding these dt-bindings, fix examples in the existing
dt-bindings.

This series is part of the previous series shown below:
https://lore.kernel.org/linux-arm-kernel/20221107103410.3443-2-hayashi.kunihiko@socionext.com

Changes since v2:
- Drop redundant nodes in examples (clock, reset, soc-glue-debug)
- Drop parent node in examples
- Add more properties to examples for pinctrl
- Add a patch for regulator change
- Use consistent quotes
- Drop unit address patterns of patternProperties
- Mandatory unit address pattern for efuse (soc-glue-debug)
- Fix additionalProperties (ahci-glue)

Changes since v1:
- Fix examples in the existing dt-bindings (Add PATCH 1-7)
- Add dt-bindings for SoC-glue logic debug part (Add PATCH 10)
- Drop generic and ld6b compatible strings
- Change "usb-controller" node in soc-glue to "usb-hub"
- Change "usb-controller" node in USB glue layer example to "usb"
- Add negation of child properties by compatible string

Kunihiko Hayashi (17):
  dt-bindings: clock: Fix node descriptions in uniphier-clock example
  dt-bindings: reset: Fix node descriptions in uniphier-reset example
  dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl
    example
  dt-bindings: regulator: Fix node descriptions in uniphier-regulator
    example
  dt-bindings: watchdog: Fix node descriptions in uniphier-wdt example
  dt-bindings: thermal: Fix node descriptions in uniphier-thermal
    example
  dt-bindings: phy: Fix node descriptions in uniphier-phy example
  dt-bindings: nvmem: Fix node descriptions in uniphier-efuse example
  dt-bindings: soc: socionext: Add UniPhier system controller
  dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
  dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
  dt-bindings: soc: socionext: Add UniPhier peripheral block
  dt-bindings: soc: socionext: Add UniPhier media I/O block
  dt-bindings: soc: socionext: Add UniPhier SD interface block
  dt-bindings: soc: socionext: Add UniPhier ADAMV block
  dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
  dt-bindings: soc: socionext: Add UniPhier AHCI glue layer

 .../clock/socionext,uniphier-clock.yaml       |  39 +-----
 .../nvmem/socionext,uniphier-efuse.yaml       | 101 +++++++--------
 .../phy/socionext,uniphier-ahci-phy.yaml      |  24 ++--
 .../phy/socionext,uniphier-usb2-phy.yaml      |  41 +++----
 .../phy/socionext,uniphier-usb3hs-phy.yaml    |  29 ++---
 .../phy/socionext,uniphier-usb3ss-phy.yaml    |  26 ++--
 .../pinctrl/socionext,uniphier-pinctrl.yaml   |  17 ++-
 .../socionext,uniphier-regulator.yaml         |  21 ++--
 .../reset/socionext,uniphier-glue-reset.yaml  |  23 ++--
 .../reset/socionext,uniphier-reset.yaml       |  52 +-------
 .../socionext/socionext,uniphier-adamv.yaml   |  50 ++++++++
 .../socionext,uniphier-ahci-glue.yaml         |  77 ++++++++++++
 .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++
 .../socionext/socionext,uniphier-mioctrl.yaml |  65 ++++++++++
 .../socionext,uniphier-perictrl.yaml          |  64 ++++++++++
 .../socionext/socionext,uniphier-sdctrl.yaml  |  61 ++++++++++
 .../socionext,uniphier-soc-glue-debug.yaml    |  68 +++++++++++
 .../socionext,uniphier-soc-glue.yaml          | 115 ++++++++++++++++++
 .../socionext/socionext,uniphier-sysctrl.yaml | 104 ++++++++++++++++
 .../thermal/socionext,uniphier-thermal.yaml   |  15 +--
 .../watchdog/socionext,uniphier-wdt.yaml      |  10 +-
 MAINTAINERS                                   |   1 +
 22 files changed, 843 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml

-- 
2.25.1

