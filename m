Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4816A0C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjBWOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:54:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED48F52DE6;
        Thu, 23 Feb 2023 06:54:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED7576602215;
        Thu, 23 Feb 2023 14:54:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677164074;
        bh=LLTzPuRFN+0pSbDG6Kkh/Csyc+/dUcma135aklDWzWc=;
        h=From:To:Cc:Subject:Date:From;
        b=D4PyWZAI957HM5iZBYJ1CROMDtLSIR6aaKLhErvyJyooR/gDUhX48SnoHuSKzwkXI
         098Ahdc8nPAE0XlmOLnjM8OfT5KGKOAfBMTMli2Rj4CQtG3iI0jn3+q6uFMNFMMVCC
         3ze3KspldXTeQQdjTmvbV4CcaoeWWx3+4xFV2e0dkptgAABcFWiRa5XseQBa3HYQBn
         ChiUT76MHJ55wF6lycrmAtW1r1B0FkpFTm0xh1l8X9OrZC57ddD9zA13pDyMjZpYXW
         khn8/Sn7QLk/vDANu/gB9NngBEgAUhH37GF+Op6KsVm7cCPdS0fMgflTgYVl8ezAiw
         CNaVRZHm7+k+g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 0/4] MT8195 Cherry: Enable PCIe/WiFi, add PWMs
Date:   Thu, 23 Feb 2023 15:54:22 +0100
Message-Id: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

This series enables PCI-Express on MT8195 Cherry Tomato Chromebooks,
making it possible to use the MT7921E WiFi card on PCIe bus.

While at it, I've also added the missing hardware PWM nodes for
MT8195 and relevant nodes to get backlight support in all Cherry
devices for the internal display.

!! Please Note !!

This series applies on top of [1], [2] and [3], even though it does not
have any real dependencies on them.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230209105628.50294-6-bchihi@baylibre.com/
[2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230209105628.50294-7-bchihi@baylibre.com/
[3]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=724363

AngeloGioacchino Del Regno (4):
  arm64: dts: mediatek: cherry: Add platform thermal configuration
  arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
  arm64: dts: mediatek: mt8195: Add display pwm nodes
  arm64: dts: mediatek: cherry: Add configuration for display backlight

 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |   7 +
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 173 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  23 +++
 3 files changed, 203 insertions(+)

-- 
2.39.2

