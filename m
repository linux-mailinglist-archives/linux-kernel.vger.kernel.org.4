Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D764539C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGFyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGFyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:22 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA88758BC8;
        Tue,  6 Dec 2022 21:54:20 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:19 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9DD1E2058B4F;
        Wed,  7 Dec 2022 14:54:19 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:19 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 698081DA5;
        Wed,  7 Dec 2022 14:54:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 00/16] dt-bindings: soc: Introduce UniPhier miscellaneous register blocks and fix examples
Date:   Wed,  7 Dec 2022 14:53:49 +0900
Message-Id: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
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

Changes since v1:
- Fix examples in  the existing dt-bindings (Add PATCH 1-7)
- Add dt-bindings for SoC-glue logic debug part (Add PATCH 10)
- Drop generic and ld6b compatible strings
- Change "usb-controller" node in soc-glue to "usb-hub"
- Change "usb-controller" node in USB glue layer example to "usb"
- Add negation of child properties by compatible string

Kunihiko Hayashi (16):
  dt-bindings: clock: Fix node descriptions in uniphier-clock example
  dt-bindings: reset: Fix node descriptions in uniphier-reset example
  dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl
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

 .../clock/socionext,uniphier-clock.yaml       |  21 ++--
 .../nvmem/socionext,uniphier-efuse.yaml       |   6 +-
 .../phy/socionext,uniphier-ahci-phy.yaml      |   1 +
 .../phy/socionext,uniphier-usb2-phy.yaml      |   4 +-
 .../phy/socionext,uniphier-usb3hs-phy.yaml    |   5 +-
 .../phy/socionext,uniphier-usb3ss-phy.yaml    |   5 +-
 .../pinctrl/socionext,uniphier-pinctrl.yaml   |   2 +-
 .../reset/socionext,uniphier-glue-reset.yaml  |   7 +-
 .../reset/socionext,uniphier-reset.yaml       |  28 +++--
 .../socionext/socionext,uniphier-adamv.yaml   |  51 ++++++++
 .../socionext,uniphier-ahci-glue.yaml         |  78 ++++++++++++
 .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++
 .../socionext/socionext,uniphier-mioctrl.yaml |  66 ++++++++++
 .../socionext,uniphier-perictrl.yaml          |  65 ++++++++++
 .../socionext/socionext,uniphier-sdctrl.yaml  |  62 ++++++++++
 .../socionext,uniphier-soc-glue-debug.yaml    |  73 +++++++++++
 .../socionext,uniphier-soc-glue.yaml          | 113 ++++++++++++++++++
 .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++
 .../thermal/socionext,uniphier-thermal.yaml   |   4 +-
 .../watchdog/socionext,uniphier-wdt.yaml      |   2 +-
 MAINTAINERS                                   |   1 +
 21 files changed, 769 insertions(+), 36 deletions(-)
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

