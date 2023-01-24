Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161B67A10C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjAXSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:17:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF27AB4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iYWbuhGp944F3TdBcB/ClLP8i2bPTgYrvwJPGPuMWAw=; b=P9lIZ7mNFfxXr0xNIcVvq5B3Hj
        FN0yTa106mvAoySEbnNd7rIyOtg+AyLrVN84mRgarY5GHW2EpOUxIM4t+hEHsj+hx2t+qRFP42HGo
        7syB43XgN1v/IO4a8e9TyNfxhYa78nIy7GEDyI89M+UQcU7mFqSoKtpFf+F3GU3htje1XdlcNDifG
        eDc0tSXgBK6Apg9f1Ft5iWC096wh/QDDi9yInNZMTKvDRAJETJPW1BgFx6pnPyFPMvqTNmJA1G33H
        uO0ry9Tit1ZFmMH9m+Sd7dBXYMSUaOZqHjXukDDvCITuvEe+5TL5DEKNs4mGNk7j5liZV8SayrcBE
        eIhTBizA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNrf-004vpH-11; Tue, 24 Jan 2023 18:17:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] ASoC: Kconfig: fix spelling of "up to"
Date:   Tue, 24 Jan 2023 10:17:46 -0800
Message-Id: <20230124181746.19028-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling in sound/soc/ Kconfig files:
s/upto/up to/
(reported by codespell)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
---
 sound/soc/rockchip/Kconfig |    2 +-
 sound/soc/tegra/Kconfig    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -13,7 +13,7 @@ config SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for I2S driver for
-	  Rockchip I2S device. The device supports upto maximum of
+	  Rockchip I2S device. The device supports up to maximum of
 	  8 channels each for play and record.
 
 config SND_SOC_ROCKCHIP_I2S_TDM
diff -- a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -144,7 +144,7 @@ config SND_SOC_TEGRA210_SFC
 	  Config to enable the Sampling Frequency Converter (SFC) which
 	  converts the sampling frequency of input signal to another
 	  frequency. It supports sampling frequency conversion of streams
-	  upto 2 channels (stereo).
+	  up to 2 channels (stereo).
 	  Say Y or M if you want to add support for Tegra210 SFC module.
 
 config SND_SOC_TEGRA210_AMX
@@ -171,7 +171,7 @@ config SND_SOC_TEGRA210_MIXER
 	tristate "Tegra210 Mixer module"
 	help
 	  Config to enable the Mixer module which can help to mix multiple
-	  audio streams. It supports mixing of upto 10 input streams,
+	  audio streams. It supports mixing of up to 10 input streams,
 	  where each stream can contain maximum of 8 channels. It supports
 	  5 output each of which can be a mix of any combination of 10
 	  input streams.
