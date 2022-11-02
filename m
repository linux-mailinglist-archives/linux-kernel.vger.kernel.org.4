Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4378616D63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKBTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A0C00;
        Wed,  2 Nov 2022 12:06:23 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F340E6601671;
        Wed,  2 Nov 2022 19:06:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667415981;
        bh=FsgjrI9Qzo0bsrusMvSReHZ5iMayNntgVoZWPmOnknY=;
        h=From:To:Cc:Subject:Date:From;
        b=OmAeawVxpom2EF3ceUJLMDwjPvqchL+Rj2hlPhJoNgx9a6Jt67nmQE0uHt7/8TWID
         vKE8s8Ok1wHYv5xXNqdKJEeeh/eG3798k6bHNwR7bUXFwuxY28ezwcOVV2TV9im3O+
         ZqDKR7B2PJQWDB4dwU7LHglvCgcj2UIF/yYfkFKDBVhVhYHgqGw3WtJ8uAZQaqou6N
         1HGf86xS7whn3HRMsihb/IcJtGk+rhZ35Rh+lQaQupw+L3RIGG8zF+8mIx0oNz4lIt
         6B+crOXAL8/r1180F2Zl5oRSj6mcYwSDXPrmK30ctx9X/SZygIUeiuoxYITEcMPe6T
         TKD/m6o6FMUBA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/5] MT8192 Asurada devicetree - Part 2
Date:   Wed,  2 Nov 2022 15:06:06 -0400
Message-Id: <20221102190611.283546-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series improves some more the support for MT8192 Asurada-based
Chromebooks, by enabling some missing functionality, namely the internal
display and audio.

In addition to that, aliases are also added for the i2c and mmc nodes,
which should've been done while adding the devices in the previous
series.

Some notable components that are still missing support are:
- external display/HDMI audio (waiting for [1])
- GPU (waiting for [2])

As part of testing the audio, an UCM file was used, which has already
been submitted upstream [3].

This series depends on some missing dt-binding properties on rt5682,
which are added by another series [4].

[1] https://lore.kernel.org/all/20220622173605.1168416-1-pmalani@chromium.org/
[2] https://lore.kernel.org/all/20221006115816.66853-1-angelogioacchino.delregno@collabora.com
[3] https://github.com/alsa-project/alsa-ucm-conf/pull/217
[4] https://lore.kernel.org/all/20221102182002.255282-1-nfraprado@collabora.com

v2: https://lore.kernel.org/all/20221006212528.103790-1-nfraprado@collabora.com
v1: https://lore.kernel.org/all/20220908171153.670762-1-nfraprado@collabora.com/

Changes in v3:
- Moved codec and sound card compatibles to separate dtsi to prepare for
  headset codec differences in newer revisions
- Added new supplies for rt5682
- Removed i2c aliases for unused controllers

Changes in v2:
- Extended series to also include patches 4 and 5 enabling audio and
  adding aliases
- Adjusted display regulator hierarchy and voltages to reflect the
  hardware

Nícolas F. R. A. Prado (5):
  arm64: dts: mediatek: asurada: Add display regulators
  arm64: dts: mediatek: asurada: Add display backlight
  arm64: dts: mediatek: asurada: Enable internal display
  arm64: dts: mediatek: asurada: Enable audio support
  arm64: dts: mediatek: asurada: Add aliases for i2c and mmc

 .../mt8192-asurada-audio-rt1015p-rt5682.dtsi  |  19 +
 .../mt8192-asurada-audio-rt1015p.dtsi         |  26 +
 .../mediatek/mt8192-asurada-audio-rt5682.dtsi |  21 +
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |   1 +
 .../mediatek/mt8192-asurada-spherion-r0.dts   |   1 +
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 465 ++++++++++++++++++
 6 files changed, 533 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi

-- 
2.38.1

