Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7237673B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjASONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjASOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:12:36 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251E4ED12;
        Thu, 19 Jan 2023 06:11:15 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pIVdE-0008Lb-1h;
        Thu, 19 Jan 2023 15:11:08 +0100
Date:   Thu, 19 Jan 2023 14:11:01 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH 0/2] add support for clocks on MT7981 SoC
Message-ID: <cover.1674137304.git.daniel@makrotopia.org>
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

The MediaTek MT7981 SoC is quite similar to its big sibling, the
MT7986. Hence most drivers can be reused and not much is missing the
get also this SoC working on mainline Linux.

Start with a cleaned-up version of the clock drivers, based on what can
also be found in MediaTek's SDK[1].

[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/target/linux/mediatek/files-5.4/drivers/clk/mediatek/clk-mt7981.c

Daniel Golle (2):
  dt-bindings: clock: add some compatible strings for MT7981
  clk: mediatek: add MT7981 clock support

 .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
 .../bindings/clock/mediatek,topckgen.yaml     |   1 +
 drivers/clk/mediatek/Kconfig                  |  17 +
 drivers/clk/mediatek/Makefile                 |   4 +
 drivers/clk/mediatek/clk-mt7981-apmixed.c     | 103 +++++
 drivers/clk/mediatek/clk-mt7981-eth.c         | 138 ++++++
 drivers/clk/mediatek/clk-mt7981-infracfg.c    | 236 ++++++++++
 drivers/clk/mediatek/clk-mt7981-topckgen.c    | 431 ++++++++++++++++++
 include/dt-bindings/clock/mt7981-clk.h        | 215 +++++++++
 9 files changed, 1146 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
 create mode 100644 include/dt-bindings/clock/mt7981-clk.h


base-commit: aa5c49149a823599764e6953229b028e4bf6e9cc
-- 
2.39.1

