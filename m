Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216CA5FDD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJMPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B9710F8A1;
        Thu, 13 Oct 2022 08:22:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78E626602366;
        Thu, 13 Oct 2022 16:22:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674539;
        bh=DM9dp4q0ZBB9kwxv9JwDMM/0XtGc6/2vq44258xzabo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZgRRH8FHMlEkPlzeZV9XV9OOigpZgq/LZPrWhdZAh7y5j3XtwFUjKX/bsy0oMA9x/
         cbJyRFPkx9ppVUt1gcLN+pur7cHmNxVKaN1tARC5ZIHGHASwhXqo8UO5if6zHQex2F
         SbH0o8dBl2hE47bBjSaZJs5xZ72O2L5jj78m4b/B7abjLwRA2hgXKIPOpxl/lvyg6W
         4b6Pgkkm6vZpbxJZNo8odrnQvrcBFtw6SHSGPydEexGIGeC/N8R4MZ4KT5/ybozsiK
         9N7Xa+XbzA/ixaXWOYz8BTlK6Wed/vkEOi27JxSA8/JRv62v9zD2QQRIfHqku0B6Zh
         0/eiTxG6qFjTQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        chunfeng.yun@mediatek.com, fparent@baylibre.com,
        mars.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/8] ARM64 MediaTek devicetree fixes - Part 1
Date:   Thu, 13 Oct 2022 17:22:04 +0200
Message-Id: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes devicetree warnings for some MediaTek DTs.

Since there's a lot to be done and since not all fixes are trivial,
I decided to do this in more than one step, as to ease work for
reviewers, maintainers and for .. me.
This being part 1 means that there's more to come... a bit later :-)

AngeloGioacchino Del Regno (8):
  arm64: dts: mt7896a: Fix unit_address_vs_reg warning for oscillator
  arm64: dts: mt6779: Fix devicetree build warnings
  arm64: dts: mt2712e: Fix unit_address_vs_reg warning for oscillators
  arm64: dts: mt2712e: Fix unit address for pinctrl node
  arm64: dts: mt2712-evb: Fix vproc fixed regulators unit names
  arm64: dts: mt2712-evb: Fix usb vbus regulators unit names
  arm64: dts: mediatek: pumpkin-common: Fix devicetree warnings
  arm64: dts: mediatek: mt6797: Fix 26M oscillator unit name

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts   | 12 +++++-----
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     | 22 +++++++++----------
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |  8 +++----
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |  2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  2 +-
 .../boot/dts/mediatek/pumpkin-common.dtsi     |  6 ++---
 6 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.37.2

