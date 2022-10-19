Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A1604B22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJSPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiJSPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:21:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120816EA3F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EAD6DCE20F4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30C8C433C1;
        Wed, 19 Oct 2022 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192114;
        bh=rM4ihlMZEz7jlcwFH6NvhSrb6DAtLdGVREDYqsgOkLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCT0t7tvprdK7zo6svNHgNTnSX1/KyaKyT+me2OTatE/jtZ8ikR12LnKP+1QhJczQ
         ito+QZQ0OrFGnrfdb+itbPTFS+w9r0q0lGSEs4yw183c1GnRKJ2rvPob3JNCZxYaZz
         yE/ldLK4QdB+OkY0XB8o4cKY+PnwqOjnvaDY1d0ZkN0qucJOLkIGgTG+WDzed/suHK
         E4z2QzIKUnzGC9fy4mOs7sOGG8OW+np7F/ffFFJSvskFc9+RwImxkmLkSG5BuZ5v+c
         Iv8TU8zZrOGJXnSIWK6MXPIv79rL6BYowrVAVPEKgAuhiwMg3kerIkwTweEJTuQDQ3
         EdqSfuBc3KJUA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@iki.fi>,
        Ryan Mallon <rmallon@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 05/17] ASoC: remove unused ep93xx files
Date:   Wed, 19 Oct 2022 17:03:27 +0200
Message-Id: <20221019150410.3851944-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A couple of ep93xx board files were unused and got removed, so
the corresponding ASoC support can also be removed.

Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/cirrus/Kconfig       |  23 --
 sound/soc/cirrus/Makefile      |   6 -
 sound/soc/cirrus/ep93xx-ac97.c | 446 ---------------------------------
 sound/soc/cirrus/simone.c      |  86 -------
 sound/soc/cirrus/snappercl15.c | 134 ----------
 5 files changed, 695 deletions(-)
 delete mode 100644 sound/soc/cirrus/ep93xx-ac97.c
 delete mode 100644 sound/soc/cirrus/simone.c
 delete mode 100644 sound/soc/cirrus/snappercl15.c

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 8039a8febefa..34870c2d0cba 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -27,29 +27,6 @@ config SND_EP93XX_SOC_I2S_WATCHDOG
 
 endif # if SND_EP93XX_SOC_I2S
 
-config SND_EP93XX_SOC_AC97
-	tristate
-	select AC97_BUS
-	select SND_SOC_AC97_BUS
-
-config SND_EP93XX_SOC_SNAPPERCL15
-	tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
-	depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15 && I2C
-	select SND_EP93XX_SOC_I2S
-	select SND_SOC_TLV320AIC23_I2C
-	help
-	  Say Y or M here if you want to add support for I2S audio on the
-	  Bluewater Systems Snapper CL15 module.
-
-config SND_EP93XX_SOC_SIMONE
-	tristate "SoC Audio support for Simplemachines Sim.One board"
-	depends on SND_EP93XX_SOC && MACH_SIM_ONE
-	select SND_EP93XX_SOC_AC97
-	select SND_SOC_AC97_CODEC
-	help
-	  Say Y or M here if you want to add support for AC97 audio on the
-	  Simplemachines Sim.One board.
-
 config SND_EP93XX_SOC_EDB93XX
 	tristate "SoC Audio support for Cirrus Logic EDB93xx boards"
 	depends on SND_EP93XX_SOC && (MACH_EDB9301 || MACH_EDB9302 || MACH_EDB9302A || MACH_EDB9307A || MACH_EDB9315A)
diff --git a/sound/soc/cirrus/Makefile b/sound/soc/cirrus/Makefile
index bfb8dc409f53..19a86daad660 100644
--- a/sound/soc/cirrus/Makefile
+++ b/sound/soc/cirrus/Makefile
@@ -2,17 +2,11 @@
 # EP93xx Platform Support
 snd-soc-ep93xx-objs				:= ep93xx-pcm.o
 snd-soc-ep93xx-i2s-objs	 			:= ep93xx-i2s.o
-snd-soc-ep93xx-ac97-objs 			:= ep93xx-ac97.o
 
 obj-$(CONFIG_SND_EP93XX_SOC)			+= snd-soc-ep93xx.o
 obj-$(CONFIG_SND_EP93XX_SOC_I2S)		+= snd-soc-ep93xx-i2s.o
-obj-$(CONFIG_SND_EP93XX_SOC_AC97)		+= snd-soc-ep93xx-ac97.o
 
 # EP93XX Machine Support
-snd-soc-snappercl15-objs			:= snappercl15.o
-snd-soc-simone-objs				:= simone.o
 snd-soc-edb93xx-objs				:= edb93xx.o
 
-obj-$(CONFIG_SND_EP93XX_SOC_SNAPPERCL15)	+= snd-soc-snappercl15.o
-obj-$(CONFIG_SND_EP93XX_SOC_SIMONE)		+= snd-soc-simone.o
 obj-$(CONFIG_SND_EP93XX_SOC_EDB93XX)		+= snd-soc-edb93xx.o
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
deleted file mode 100644
index 37593abe6053..000000000000
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ /dev/null
@@ -1,446 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ASoC driver for Cirrus Logic EP93xx AC97 controller.
- *
- * Copyright (c) 2010 Mika Westerberg
- *
- * Based on s3c-ac97 ASoC driver by Jaswinder Singh.
- */
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include <sound/core.h>
-#include <sound/dmaengine_pcm.h>
-#include <sound/ac97_codec.h>
-#include <sound/soc.h>
-
-#include <linux/platform_data/dma-ep93xx.h>
-#include <linux/soc/cirrus/ep93xx.h>
-
-#include "ep93xx-pcm.h"
-
-/*
- * Per channel (1-4) registers.
- */
-#define AC97CH(n)		(((n) - 1) * 0x20)
-
-#define AC97DR(n)		(AC97CH(n) + 0x0000)
-
-#define AC97RXCR(n)		(AC97CH(n) + 0x0004)
-#define AC97RXCR_REN		BIT(0)
-#define AC97RXCR_RX3		BIT(3)
-#define AC97RXCR_RX4		BIT(4)
-#define AC97RXCR_CM		BIT(15)
-
-#define AC97TXCR(n)		(AC97CH(n) + 0x0008)
-#define AC97TXCR_TEN		BIT(0)
-#define AC97TXCR_TX3		BIT(3)
-#define AC97TXCR_TX4		BIT(4)
-#define AC97TXCR_CM		BIT(15)
-
-#define AC97SR(n)		(AC97CH(n) + 0x000c)
-#define AC97SR_TXFE		BIT(1)
-#define AC97SR_TXUE		BIT(6)
-
-#define AC97RISR(n)		(AC97CH(n) + 0x0010)
-#define AC97ISR(n)		(AC97CH(n) + 0x0014)
-#define AC97IE(n)		(AC97CH(n) + 0x0018)
-
-/*
- * Global AC97 controller registers.
- */
-#define AC97S1DATA		0x0080
-#define AC97S2DATA		0x0084
-#define AC97S12DATA		0x0088
-
-#define AC97RGIS		0x008c
-#define AC97GIS			0x0090
-#define AC97IM			0x0094
-/*
- * Common bits for RGIS, GIS and IM registers.
- */
-#define AC97_SLOT2RXVALID	BIT(1)
-#define AC97_CODECREADY		BIT(5)
-#define AC97_SLOT2TXCOMPLETE	BIT(6)
-
-#define AC97EOI			0x0098
-#define AC97EOI_WINT		BIT(0)
-#define AC97EOI_CODECREADY	BIT(1)
-
-#define AC97GCR			0x009c
-#define AC97GCR_AC97IFE		BIT(0)
-
-#define AC97RESET		0x00a0
-#define AC97RESET_TIMEDRESET	BIT(0)
-
-#define AC97SYNC		0x00a4
-#define AC97SYNC_TIMEDSYNC	BIT(0)
-
-#define AC97_TIMEOUT		msecs_to_jiffies(5)
-
-/**
- * struct ep93xx_ac97_info - EP93xx AC97 controller info structure
- * @lock: mutex serializing access to the bus (slot 1 & 2 ops)
- * @dev: pointer to the platform device dev structure
- * @regs: mapped AC97 controller registers
- * @done: bus ops wait here for an interrupt
- */
-struct ep93xx_ac97_info {
-	struct mutex		lock;
-	struct device		*dev;
-	void __iomem		*regs;
-	struct completion	done;
-	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct snd_dmaengine_dai_dma_data dma_params_tx;
-};
-
-/* currently ALSA only supports a single AC97 device */
-static struct ep93xx_ac97_info *ep93xx_ac97_info;
-
-static struct ep93xx_dma_data ep93xx_ac97_pcm_out = {
-	.name		= "ac97-pcm-out",
-	.port		= EP93XX_DMA_AAC1,
-	.direction	= DMA_MEM_TO_DEV,
-};
-
-static struct ep93xx_dma_data ep93xx_ac97_pcm_in = {
-	.name		= "ac97-pcm-in",
-	.port		= EP93XX_DMA_AAC1,
-	.direction	= DMA_DEV_TO_MEM,
-};
-
-static inline unsigned ep93xx_ac97_read_reg(struct ep93xx_ac97_info *info,
-					    unsigned reg)
-{
-	return __raw_readl(info->regs + reg);
-}
-
-static inline void ep93xx_ac97_write_reg(struct ep93xx_ac97_info *info,
-					 unsigned reg, unsigned val)
-{
-	__raw_writel(val, info->regs + reg);
-}
-
-static unsigned short ep93xx_ac97_read(struct snd_ac97 *ac97,
-				       unsigned short reg)
-{
-	struct ep93xx_ac97_info *info = ep93xx_ac97_info;
-	unsigned short val;
-
-	mutex_lock(&info->lock);
-
-	ep93xx_ac97_write_reg(info, AC97S1DATA, reg);
-	ep93xx_ac97_write_reg(info, AC97IM, AC97_SLOT2RXVALID);
-	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT)) {
-		dev_warn(info->dev, "timeout reading register %x\n", reg);
-		mutex_unlock(&info->lock);
-		return -ETIMEDOUT;
-	}
-	val = (unsigned short)ep93xx_ac97_read_reg(info, AC97S2DATA);
-
-	mutex_unlock(&info->lock);
-	return val;
-}
-
-static void ep93xx_ac97_write(struct snd_ac97 *ac97,
-			      unsigned short reg,
-			      unsigned short val)
-{
-	struct ep93xx_ac97_info *info = ep93xx_ac97_info;
-
-	mutex_lock(&info->lock);
-
-	/*
-	 * Writes to the codec need to be done so that slot 2 is filled in
-	 * before slot 1.
-	 */
-	ep93xx_ac97_write_reg(info, AC97S2DATA, val);
-	ep93xx_ac97_write_reg(info, AC97S1DATA, reg);
-
-	ep93xx_ac97_write_reg(info, AC97IM, AC97_SLOT2TXCOMPLETE);
-	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT))
-		dev_warn(info->dev, "timeout writing register %x\n", reg);
-
-	mutex_unlock(&info->lock);
-}
-
-static void ep93xx_ac97_warm_reset(struct snd_ac97 *ac97)
-{
-	struct ep93xx_ac97_info *info = ep93xx_ac97_info;
-
-	mutex_lock(&info->lock);
-
-	/*
-	 * We are assuming that before this functions gets called, the codec
-	 * BIT_CLK is stopped by forcing the codec into powerdown mode. We can
-	 * control the SYNC signal directly via AC97SYNC register. Using
-	 * TIMEDSYNC the controller will keep the SYNC high > 1us.
-	 */
-	ep93xx_ac97_write_reg(info, AC97SYNC, AC97SYNC_TIMEDSYNC);
-	ep93xx_ac97_write_reg(info, AC97IM, AC97_CODECREADY);
-	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT))
-		dev_warn(info->dev, "codec warm reset timeout\n");
-
-	mutex_unlock(&info->lock);
-}
-
-static void ep93xx_ac97_cold_reset(struct snd_ac97 *ac97)
-{
-	struct ep93xx_ac97_info *info = ep93xx_ac97_info;
-
-	mutex_lock(&info->lock);
-
-	/*
-	 * For doing cold reset, we disable the AC97 controller interface, clear
-	 * WINT and CODECREADY bits, and finally enable the interface again.
-	 */
-	ep93xx_ac97_write_reg(info, AC97GCR, 0);
-	ep93xx_ac97_write_reg(info, AC97EOI, AC97EOI_CODECREADY | AC97EOI_WINT);
-	ep93xx_ac97_write_reg(info, AC97GCR, AC97GCR_AC97IFE);
-
-	/*
-	 * Now, assert the reset and wait for the codec to become ready.
-	 */
-	ep93xx_ac97_write_reg(info, AC97RESET, AC97RESET_TIMEDRESET);
-	ep93xx_ac97_write_reg(info, AC97IM, AC97_CODECREADY);
-	if (!wait_for_completion_timeout(&info->done, AC97_TIMEOUT))
-		dev_warn(info->dev, "codec cold reset timeout\n");
-
-	/*
-	 * Give the codec some time to come fully out from the reset. This way
-	 * we ensure that the subsequent reads/writes will work.
-	 */
-	usleep_range(15000, 20000);
-
-	mutex_unlock(&info->lock);
-}
-
-static irqreturn_t ep93xx_ac97_interrupt(int irq, void *dev_id)
-{
-	struct ep93xx_ac97_info *info = dev_id;
-	unsigned status, mask;
-
-	/*
-	 * Just mask out the interrupt and wake up the waiting thread.
-	 * Interrupts are cleared via reading/writing to slot 1 & 2 registers by
-	 * the waiting thread.
-	 */
-	status = ep93xx_ac97_read_reg(info, AC97GIS);
-	mask = ep93xx_ac97_read_reg(info, AC97IM);
-	mask &= ~status;
-	ep93xx_ac97_write_reg(info, AC97IM, mask);
-
-	complete(&info->done);
-	return IRQ_HANDLED;
-}
-
-static struct snd_ac97_bus_ops ep93xx_ac97_ops = {
-	.read		= ep93xx_ac97_read,
-	.write		= ep93xx_ac97_write,
-	.reset		= ep93xx_ac97_cold_reset,
-	.warm_reset	= ep93xx_ac97_warm_reset,
-};
-
-static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
-			       int cmd, struct snd_soc_dai *dai)
-{
-	struct ep93xx_ac97_info *info = snd_soc_dai_get_drvdata(dai);
-	unsigned v = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			/*
-			 * Enable compact mode, TX slots 3 & 4, and the TX FIFO
-			 * itself.
-			 */
-			v |= AC97TXCR_CM;
-			v |= AC97TXCR_TX3 | AC97TXCR_TX4;
-			v |= AC97TXCR_TEN;
-			ep93xx_ac97_write_reg(info, AC97TXCR(1), v);
-		} else {
-			/*
-			 * Enable compact mode, RX slots 3 & 4, and the RX FIFO
-			 * itself.
-			 */
-			v |= AC97RXCR_CM;
-			v |= AC97RXCR_RX3 | AC97RXCR_RX4;
-			v |= AC97RXCR_REN;
-			ep93xx_ac97_write_reg(info, AC97RXCR(1), v);
-		}
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			/*
-			 * As per Cirrus EP93xx errata described below:
-			 *
-			 * https://www.cirrus.com/en/pubs/errata/ER667E2B.pdf
-			 *
-			 * we will wait for the TX FIFO to be empty before
-			 * clearing the TEN bit.
-			 */
-			unsigned long timeout = jiffies + AC97_TIMEOUT;
-
-			do {
-				v = ep93xx_ac97_read_reg(info, AC97SR(1));
-				if (time_after(jiffies, timeout)) {
-					dev_warn(info->dev, "TX timeout\n");
-					break;
-				}
-			} while (!(v & (AC97SR_TXFE | AC97SR_TXUE)));
-
-			/* disable the TX FIFO */
-			ep93xx_ac97_write_reg(info, AC97TXCR(1), 0);
-		} else {
-			/* disable the RX FIFO */
-			ep93xx_ac97_write_reg(info, AC97RXCR(1), 0);
-		}
-		break;
-
-	default:
-		dev_warn(info->dev, "unknown command %d\n", cmd);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int ep93xx_ac97_dai_probe(struct snd_soc_dai *dai)
-{
-	struct ep93xx_ac97_info *info = snd_soc_dai_get_drvdata(dai);
-
-	info->dma_params_tx.filter_data = &ep93xx_ac97_pcm_out;
-	info->dma_params_rx.filter_data = &ep93xx_ac97_pcm_in;
-
-	dai->playback_dma_data = &info->dma_params_tx;
-	dai->capture_dma_data = &info->dma_params_rx;
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops ep93xx_ac97_dai_ops = {
-	.trigger	= ep93xx_ac97_trigger,
-};
-
-static struct snd_soc_dai_driver ep93xx_ac97_dai = {
-	.name		= "ep93xx-ac97",
-	.id		= 0,
-	.probe		= ep93xx_ac97_dai_probe,
-	.playback	= {
-		.stream_name	= "AC97 Playback",
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_48000,
-		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.capture	= {
-		.stream_name	= "AC97 Capture",
-		.channels_min	= 2,
-		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_48000,
-		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	.ops			= &ep93xx_ac97_dai_ops,
-};
-
-static const struct snd_soc_component_driver ep93xx_ac97_component = {
-	.name			= "ep93xx-ac97",
-	.legacy_dai_naming	= 1,
-};
-
-static int ep93xx_ac97_probe(struct platform_device *pdev)
-{
-	struct ep93xx_ac97_info *info;
-	int irq;
-	int ret;
-
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(info->regs))
-		return PTR_ERR(info->regs);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq < 0 ? irq : -ENODEV;
-
-	ret = devm_request_irq(&pdev->dev, irq, ep93xx_ac97_interrupt,
-			       IRQF_TRIGGER_HIGH, pdev->name, info);
-	if (ret)
-		goto fail;
-
-	dev_set_drvdata(&pdev->dev, info);
-
-	mutex_init(&info->lock);
-	init_completion(&info->done);
-	info->dev = &pdev->dev;
-
-	ep93xx_ac97_info = info;
-	platform_set_drvdata(pdev, info);
-
-	ret = snd_soc_set_ac97_ops(&ep93xx_ac97_ops);
-	if (ret)
-		goto fail;
-
-	ret = snd_soc_register_component(&pdev->dev, &ep93xx_ac97_component,
-					 &ep93xx_ac97_dai, 1);
-	if (ret)
-		goto fail;
-
-	ret = devm_ep93xx_pcm_platform_register(&pdev->dev);
-	if (ret)
-		goto fail_unregister;
-
-	return 0;
-
-fail_unregister:
-	snd_soc_unregister_component(&pdev->dev);
-fail:
-	ep93xx_ac97_info = NULL;
-	snd_soc_set_ac97_ops(NULL);
-	return ret;
-}
-
-static int ep93xx_ac97_remove(struct platform_device *pdev)
-{
-	struct ep93xx_ac97_info	*info = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_component(&pdev->dev);
-
-	/* disable the AC97 controller */
-	ep93xx_ac97_write_reg(info, AC97GCR, 0);
-
-	ep93xx_ac97_info = NULL;
-
-	snd_soc_set_ac97_ops(NULL);
-
-	return 0;
-}
-
-static struct platform_driver ep93xx_ac97_driver = {
-	.probe	= ep93xx_ac97_probe,
-	.remove	= ep93xx_ac97_remove,
-	.driver = {
-		.name = "ep93xx-ac97",
-	},
-};
-
-module_platform_driver(ep93xx_ac97_driver);
-
-MODULE_DESCRIPTION("EP93xx AC97 ASoC Driver");
-MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ep93xx-ac97");
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
deleted file mode 100644
index 801c90877d77..000000000000
--- a/sound/soc/cirrus/simone.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * simone.c -- ASoC audio for Simplemachines Sim.One board
- *
- * Copyright (c) 2010 Mika Westerberg
- *
- * Based on snappercl15 machine driver by Ryan Mallon.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/soc/cirrus/ep93xx.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-
-SND_SOC_DAILINK_DEFS(hifi,
-	DAILINK_COMP_ARRAY(COMP_CPU("ep93xx-ac97")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("ac97-codec", "ac97-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("ep93xx-ac97")));
-
-static struct snd_soc_dai_link simone_dai = {
-	.name		= "AC97",
-	.stream_name	= "AC97 HiFi",
-	SND_SOC_DAILINK_REG(hifi),
-};
-
-static struct snd_soc_card snd_soc_simone = {
-	.name		= "Sim.One",
-	.owner		= THIS_MODULE,
-	.dai_link	= &simone_dai,
-	.num_links	= 1,
-};
-
-static struct platform_device *simone_snd_ac97_device;
-
-static int simone_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &snd_soc_simone;
-	int ret;
-
-	simone_snd_ac97_device = platform_device_register_simple("ac97-codec",
-								 -1, NULL, 0);
-	if (IS_ERR(simone_snd_ac97_device))
-		return PTR_ERR(simone_snd_ac97_device);
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-		platform_device_unregister(simone_snd_ac97_device);
-	}
-
-	return ret;
-}
-
-static int simone_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	platform_device_unregister(simone_snd_ac97_device);
-
-	return 0;
-}
-
-static struct platform_driver simone_driver = {
-	.driver		= {
-		.name	= "simone-audio",
-	},
-	.probe		= simone_probe,
-	.remove		= simone_remove,
-};
-
-module_platform_driver(simone_driver);
-
-MODULE_DESCRIPTION("ALSA SoC Simplemachines Sim.One");
-MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:simone-audio");
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
deleted file mode 100644
index a286f5beeaeb..000000000000
--- a/sound/soc/cirrus/snappercl15.c
+++ /dev/null
@@ -1,134 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * snappercl15.c -- SoC audio for Bluewater Systems Snapper CL15 module
- *
- * Copyright (C) 2008 Bluewater Systems Ltd
- * Author: Ryan Mallon
- */
-
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/soc/cirrus/ep93xx.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-
-#include "../codecs/tlv320aic23.h"
-
-#define CODEC_CLOCK 5644800
-
-static int snappercl15_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-	int err;
-
-	err = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, 
-				     SND_SOC_CLOCK_IN);
-	if (err)
-		return err;
-
-	err = snd_soc_dai_set_sysclk(cpu_dai, 0, CODEC_CLOCK, 
-				     SND_SOC_CLOCK_OUT);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static const struct snd_soc_ops snappercl15_ops = {
-	.hw_params	= snappercl15_hw_params,
-};
-
-static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-	SND_SOC_DAPM_MIC("Mic Jack", NULL),
-};
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	{"Headphone Jack", NULL, "LHPOUT"},
-	{"Headphone Jack", NULL, "RHPOUT"},
-
-	{"LLINEIN", NULL, "Line In"},
-	{"RLINEIN", NULL, "Line In"},
-
-	{"MICIN", NULL, "Mic Jack"},
-};
-
-SND_SOC_DAILINK_DEFS(aic23,
-	DAILINK_COMP_ARRAY(COMP_CPU("ep93xx-i2s")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic23-codec.0-001a",
-				      "tlv320aic23-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("ep93xx-i2s")));
-
-static struct snd_soc_dai_link snappercl15_dai = {
-	.name		= "tlv320aic23",
-	.stream_name	= "AIC23",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			  SND_SOC_DAIFMT_CBC_CFC,
-	.ops		= &snappercl15_ops,
-	SND_SOC_DAILINK_REG(aic23),
-};
-
-static struct snd_soc_card snd_soc_snappercl15 = {
-	.name		= "Snapper CL15",
-	.owner		= THIS_MODULE,
-	.dai_link	= &snappercl15_dai,
-	.num_links	= 1,
-
-	.dapm_widgets		= tlv320aic23_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(tlv320aic23_dapm_widgets),
-	.dapm_routes		= audio_map,
-	.num_dapm_routes	= ARRAY_SIZE(audio_map),
-};
-
-static int snappercl15_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &snd_soc_snappercl15;
-	int ret;
-
-	ret = ep93xx_i2s_acquire();
-	if (ret)
-		return ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-		ep93xx_i2s_release();
-	}
-
-	return ret;
-}
-
-static int snappercl15_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	ep93xx_i2s_release();
-
-	return 0;
-}
-
-static struct platform_driver snappercl15_driver = {
-	.driver		= {
-		.name	= "snappercl15-audio",
-	},
-	.probe		= snappercl15_probe,
-	.remove		= snappercl15_remove,
-};
-
-module_platform_driver(snappercl15_driver);
-
-MODULE_AUTHOR("Ryan Mallon");
-MODULE_DESCRIPTION("ALSA SoC Snapper CL15");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:snappercl15-audio");
-- 
2.29.2

