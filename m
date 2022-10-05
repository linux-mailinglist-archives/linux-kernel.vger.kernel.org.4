Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE305F53CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiJELkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJELjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:39:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5378598;
        Wed,  5 Oct 2022 04:37:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E89C966022F0;
        Wed,  5 Oct 2022 12:35:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664969735;
        bh=qULQP86b4+eOLbpwlAGXJqEihDLHn7C+UcPb7jg5t+g=;
        h=From:To:Cc:Subject:Date:From;
        b=Q0yhxJbk5tyqyqWjbgBIUzlzZjuBMrTyew3wuGl1794jdF37AkJhVurw7XNMad0N/
         N2kyyb6D74789UyOvdbRTl2YThKP8RFP5BH/id8MKWNxLRp7cI+eCMYTPlbTCTWuRo
         kiU1uNgDtx2pQUHgYsMT6mZbYr8S/n1ZJi/K6aKbzP7oOGrBCOXZZje822OolTTUve
         QjHUzodK7X+n0to/OZJ2TqgloJJkPN2wulPgBM1rt8kA8sUfbtAy2J7Q2BamxNNkvG
         JFMHuPpAKg2kOq0CQmsN1ADQhB4GZAd8TckSwQR1a+1nuIxdYU/NR8fpuGrUj1wysb
         E8dWCOA8ftrlw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com, tinghan.shen@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] MediaTek watchdog: MT6795 support and YAML conversion
Date:   Wed,  5 Oct 2022 13:35:12 +0200
Message-Id: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
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

This series converts mtk-wdt.txt to dt-schema, fixes watchdog compatibles
for MT8186 and MT8195, and adds support for the watchdog and toprgu reset
found on the MediaTek Helio X10 MT6795 SoC.

AngeloGioacchino Del Regno (5):
  arm64: dts: mediatek: mt8186: Fix watchdog compatible
  arm64: dts: mediatek: mt8195: Fix watchdog compatible
  dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
  dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795
  watchdog: mtk_wdt: Add support for MT6795 Helio X10 watchdog and
    toprgu

 .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +-
 drivers/watchdog/mtk_wdt.c                    |  6 ++
 5 files changed, 89 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

-- 
2.37.2

