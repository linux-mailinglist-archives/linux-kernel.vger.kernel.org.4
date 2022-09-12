Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4D5B5527
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiILHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiILHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:16:39 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D622FFD9;
        Mon, 12 Sep 2022 00:15:58 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Sep 2022 16:15:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id A08F820584CE;
        Mon, 12 Sep 2022 16:15:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 12 Sep 2022 16:15:57 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 57951B62A4;
        Mon, 12 Sep 2022 16:15:57 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/9] Update UniPhier armv8 devicetree
Date:   Mon, 12 Sep 2022 16:15:45 +0900
Message-Id: <20220912071554.1480-1-hayashi.kunihiko@socionext.com>
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

Changes since v1:
- Exclue usb fixed patch (already applied)
- Describe the reason why removing generic pcie compatible
- Add L2 cache node patch

Kunihiko Hayashi (9):
  arm64: dts: uniphier: Rename pvtctl node to thermal-sensor
  arm64: dts: uniphier: Rename usb-phy node to usb-glue
  arm64: dts: uniphier: Rename gpio-hog nodes
  arm64: dts: uniphier: Use GIC interrupt definitions
  arm64: dts: uniphier: Add ahci controller and glue layer nodes for
    PXs3
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
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  80 ++++++----
 .../socionext/uniphier-pxs3-ref-gadget0.dts   |  41 +++++
 .../socionext/uniphier-pxs3-ref-gadget1.dts   |  40 +++++
 .../boot/dts/socionext/uniphier-pxs3-ref.dts  |  14 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 148 ++++++++++++++----
 11 files changed, 313 insertions(+), 101 deletions(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget0.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref-gadget1.dts

-- 
2.25.1

