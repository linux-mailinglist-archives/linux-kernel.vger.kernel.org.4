Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1367C1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjAZAeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjAZAeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:34:07 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B8646B8;
        Wed, 25 Jan 2023 16:34:05 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pKqDJ-000393-1D;
        Thu, 26 Jan 2023 01:34:01 +0100
Date:   Thu, 26 Jan 2023 00:33:54 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH v2 0/2] add pinctrl driver for MT7981 SoC
Message-ID: <cover.1674693008.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT7981 SoC is the smaller sibbling of the MT7986 SoC.
While MT7986 is already fully supported in vanilla Linux, only few things
are missing to support also MT7981.

Add pinctrl driver including devicetree bindings for MediaTek MT7981
which together with the added clock drivers[1] completes support for the
most basic features of this SoC.

A complete work-in-progress tree based on linux-next for testing is
available via Github[2]:

[1]: https://patchwork.kernel.org/project/linux-clk/list/?series=714497
[2]: https://github.com/dangowrt/linux

Changes since v1:
 * cleaned up YAML bindings according to comments of Rob Herring
 * sync with pinctrl-mt7986.c to get pu/pd bias working

Daniel Golle (2):
  dt-bindings: pinctrl: add bindings for MT7981 SoC
  pinctrl: add mt7981 pinctrl driver

 .../pinctrl/mediatek,mt7981-pinctrl.yaml      |  475 ++++++++
 drivers/pinctrl/mediatek/Kconfig              |    5 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt7981.c     | 1048 +++++++++++++++++
 4 files changed, 1529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7981.c


base-commit: 9fbee811e479aca2f3523787cae1f46553141b40
-- 
2.39.1

