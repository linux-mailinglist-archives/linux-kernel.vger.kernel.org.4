Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206646B0E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCHQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCHQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:25:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F91EA0F08
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C40E2B81D97
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F9C4339C;
        Wed,  8 Mar 2023 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678292755;
        bh=zrd9W9rrqmk0X8IEIh3UsVkQJ6XG3c+/DOw/cQvISbU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g5RoVasy5FlQq1/n7xP8JkTIWDlDXFXpbt8z+pJiUCs5iTzKt5n8cl4eW85uLqWrt
         uazXKyrrQowQRDuXOhj2CrgdPrVvPqb0uiUzpHWjzY6U+rRk5YS5Z5dN/MPugSigSR
         0Su5yPqy246khyAdgHg+bz4mBv4w773RM3I7FLtrf/OiqySar5GHqKmjHxvVSRc58x
         71Bea5XMnfdasm/0YBtPJLUa0JHMpEiD69/ttp6gpwq+hPQl221JptANvCd4vNop+n
         Yggw61Sb+r/9piCe4AKa6KB6yN7wdhaCRBPzhkBY3LJd1pALTn6/WsjPWPVYqpEWWh
         pECh53Y1iX5Fw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230308084509.1496256-2-Vsujithkumar.Reddy@amd.com>
References: <20230308084509.1496256-1-Vsujithkumar.Reddy@amd.com>
 <20230308084509.1496256-2-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: Add pcm pointer callback for amd
 platforms.
Message-Id: <167829275079.108660.16617668154120636936.b4-ty@kernel.org>
Date:   Wed, 08 Mar 2023 16:25:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 14:15:08 +0530, V sujith kumar Reddy wrote:
> Add pcm pointer callback for amd platforms to read host position
> update from stream box.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: Add pcm pointer callback for amd platforms.
      commit: df6380dca2727bca62efdf332eaadd2e225f7c4d
[2/2] ASoC: SOF: amd: Enable cont_update_posn variable in pcm hw_params.
      commit: b7f5c11761691a6f330411cb0490c6d0ee16c5f0

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

