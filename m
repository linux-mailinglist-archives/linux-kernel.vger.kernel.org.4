Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD43D624C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKJUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiKJUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:39:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705E57B63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFCCBB82334
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF5C43470;
        Thu, 10 Nov 2022 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668112736;
        bh=LqQpNnC8EIb8uvwzTz8/j3iKA35fIXtLnObuNjhhYoM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mctM7IX5Sbi/HpL+27A/Y6GoN5p0NYZ4hdRPQhCIw/T3UflewcUIy709l30+PgPvm
         QQlTdr2HvicKiJreKHZLiQVu6Y8hEn20oT8EuoG8PHgxk4Txf4Lm92v2WZm4K14/bH
         CRKy8s3W9mlCrNgUsUN8L+HD1axcZnfS7XI2NFsT5FoHOy85RfwhK5yGHMqtNYNBQa
         wiVc7NRNMxMsF8QeM/UzGUAPvhYeZ2mAYvRom4YeixPUbWiodGIyxxYJ69cos5QA+G
         3RLF1iZsunqZCVxMTCXehGiUZVugND5nlRtUSeDcjCCGeHu1xqQByqNTxdbqKTsUkS
         KGjHw342rorgg==
From:   Mark Brown <broonie@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "moderated list:NXP SGTL5000 DRIVER" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20221110190612.1341469-1-detlev.casanova@collabora.com>
References: <20221110190612.1341469-1-detlev.casanova@collabora.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove
Message-Id: <166811273486.1046320.8327753211481113364.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 20:38:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 14:06:12 -0500, Detlev Casanova wrote:
> Since commit bf2aebccddef ("ASoC: sgtl5000: Fix noise on shutdown/remove"),
> the device power control registers are reset when the driver is
> removed/shutdown.
> 
> This is an issue when the device is configured to use the PLL clock. The
> device will stop responding if it is still configured to use the PLL
> clock but the PLL clock is powered down.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove
      commit: 0bb8e9b36b5b7f2e77892981ff6c27ee831d8026

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
