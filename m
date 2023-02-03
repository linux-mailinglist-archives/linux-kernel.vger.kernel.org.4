Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC8689C50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBCO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjBCO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A046B7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:56:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A8761F6B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A618FC4339B;
        Fri,  3 Feb 2023 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436171;
        bh=0esXNRdz1LITyce3Po30mtH5bicSbH0BxNc5ZfhkZlI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LFVrAEnVB/id308L965VYGcEQITfC2CyM8wtYN+3D1j+G+AEDHA9+nig6TTGRDKNM
         EFhd7Sl5WumjD6bzNO2mdjhqvDOrcYm/ZkZsIgDIenXBpk0k/1T8AAveGiy8098Wmx
         ME1iRksR/FvHcLtFCazp02X0bc4MvC7tcyG7XtafaylZBQM1FPq4ikCuZfLItZn0ia
         o2kg+R57/Oa4YXeL4qr70hOSnyfvf/DmvPc1x/ZOxhXJmSGH4UNLXiMw9C0SFx6tab
         WcBz2SLHLS0od9HSO19QSZr4Bsi1jM0QXTM0WDZ3cIt6Hg12zwmLc0XUFASaUmkbZu
         xlNMxEHLdvwtw==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230202102247.806749-1-arnd@kernel.org>
References: <20230202102247.806749-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: fix intel-soundwire link failure
Message-Id: <167543616838.928818.16684996806941827936.b4-ty@kernel.org>
Date:   Fri, 03 Feb 2023 14:56:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 11:22:30 +0100, Arnd Bergmann wrote:
> My randconfig build setup ran into a rare build failure with
> 
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
> CONFIG_SOUNDWIRE=y
> CONFIG_SOUNDWIRE_INTEL=m
> CONFIG_SND_SOC_SOF_HDA=y
> CONFIG_SND_SOC_SOF_INTEL_TGL=y
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: fix intel-soundwire link failure
      commit: c5a61db9bf897494fb0657eeb24dfdcb1aab1fc4

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

