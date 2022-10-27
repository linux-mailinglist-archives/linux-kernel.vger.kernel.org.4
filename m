Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981860F417
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiJ0JzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiJ0JzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:55:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95E4DB0C;
        Thu, 27 Oct 2022 02:55:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16B8C6602549;
        Thu, 27 Oct 2022 10:55:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864513;
        bh=E41IAV6f0YFdwiPzJRKjlleB+gic/fg4oOMysY+X1RI=;
        h=From:To:Cc:Subject:Date:From;
        b=KRWPu4lQEtR2fjCvGAakP8NjFXEMXxOMxnSVv9jbGasPU61c4xBuBAFXxmu3Oxqxv
         uxfKaqCPdVmNVlXqBJ9oxGsCKjE4cPKDFgrQUirNQ2zKEEr4aGoN8loirPtKhT8DVk
         3V8hcpdYQFCkaQRglxgL+N6LY3BsEGU+mRnTjBDyWZayOtvFgelM7gOQBoaGxkE+1k
         Jy7qwBRc9q4poRAEbeuLqfA7jKp7SXaPVmZy4znrKG3cO/uOgxnGOqT7TeyeZTdg3i
         sz3vpcSUbZkiya4rjWjUDIEoLOaK1R8Jc5EPsLhSodQWRmfk/psgvqvXk8/6Bq/nhK
         Lh9eIhbhATh1g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sam.shih@mediatek.com, andrew@lunn.ch, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/6] MT6795 Devicetrees and Sony Xperia M5
Date:   Thu, 27 Oct 2022 11:54:58 +0200
Message-Id: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
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

This series brings some more support for the MT6795 SoC, as it
adds support for basic clock controllers (and resets) and all
of the mtk-sd mmc controllers.

While at it, since now it's possible to get the "first signs of
life" out of a MT6795 smartphone platform, add a basic devicetree
for the Sony Xperia M5 (codename "Holly") device as to start
preparing the ground for a gradual bringup.

This series depends on [1] my mt6795 clocks series.

P.S.: Thumbs up for the first MediaTek-powered ARM64 smartphone
      going upstream! :-) :-) :-)

Changes in v2:
 - Rebased over next-20221026
 - Removed "mediatek,mt8173-mmc" from mmc compatible strings
 - Added clock and reset dt-bindings headers inclusions

AngeloGioacchino Del Regno (6):
  arm64: dts: mediatek: mt6795: Add topckgen, infra, peri clocks/resets
  arm64: dts: mediatek: mt6795: Replace UART dummy clocks with pericfg
  arm64: dts: mediatek: mt6795: Add support for APDMA and wire up UART
    DMAs
  arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO controllers
  dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia M5
  arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartphone

 .../devicetree/bindings/arm/mediatek.yaml     |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    |  88 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt6795.dtsi      | 109 +++++++++++++++++-
 4 files changed, 195 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts

-- 
2.37.2

