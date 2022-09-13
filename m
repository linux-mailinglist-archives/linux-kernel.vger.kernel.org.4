Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96D5B66E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiIME13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIME1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:27:02 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73C9858B49;
        Mon, 12 Sep 2022 21:23:36 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:23:28 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 8371A20584CE;
        Tue, 13 Sep 2022 13:23:28 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:23:28 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1D004B62A4;
        Tue, 13 Sep 2022 13:23:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 00/10] Update UniPhier armv8 devicetree
Date:   Tue, 13 Sep 2022 13:23:11 +0900
Message-Id: <20220913042321.4817-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update devicetree sources for UniPhier armv8 SoCs to remove dtschema
warnings, add support existing features that haven't yet been
described, and replace constants with macros.

Changes since v2:
- Rename the nodes for usb external controller to "usb-controller"
- Fix the node names for sata

Changes since v1:
- Exclude usb fixed patch (already applied)
- Describe the reason why removing generic pcie compatible
- Add L2 cache node patch

Kunihiko Hayashi (10):
  arm64: dts: uniphier: Rename pvtctl node to thermal-sensor
  arm64: dts: uniphier: Rename usb-phy node for USB2 to usb-controller
  arm64: dts: uniphier: Rename usb-glue node for USB3 to usb-controller
  arm64: dts: uniphier: Rename gpio-hog nodes
  arm64: dts: uniphier: Use GIC interrupt definitions
  arm64: dts: uniphier: Add ahci controller nodes for PXs3
  arm64: dts: uniphier: Add USB-device support for PXs3 reference board
  arm64: dts: uniphier: Fix opp-table node name for LD20
  arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie node
  arm64: dts: uniphier: Add L2 cache node

 arch/arm/boot/dts/uniphier-pinctrl.dtsi       |  10 ++
 arch/arm64/boot/dts/socionext/Makefile        |   4 +-
 .../boot/dts/socionext/uniphier-ld11-ref.dts  |   6 +-
 .../boot/dts/socionext/uniphier-ld11.dtsi     |  59 ++++---
 .../dts/socionext/uniphier-ld20-akebi96.dts   |   6 +-
 .../boot/dts/socionext/uniphier-ld20-ref.dts  |   6 +-
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  82 ++++++----
 .../socionext/uniphier-pxs3-ref-gadget0.dts   |  41 +++++
 .../socionext/uniphier-pxs3-ref-gadget1.dts   |  40 +++++
 .../boot/dts/socionext/uniphier-pxs3-ref.dts  |  14 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 152 ++++++++++++++----
 11 files changed, 316 insertions(+), 104 deletions(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts

-- 
2.25.1

