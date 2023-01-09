Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5C662BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjAIQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjAIQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1413E2C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15987B80E83
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A1EC433D2;
        Mon,  9 Jan 2023 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282967;
        bh=rPvp+nyVFAXbsnYKzM13/h6MAT7PR0HaVYfLYnxO7B8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mGERPPgzm5FKlfcj3PUXg2Hi05Chrv72wUywZipivsUZr2+ldG81HBTmkLYno5zvU
         WO+vZhs3uBsuAtg/dZ3ohFVxyL0ZquvYtaRyDCV5+rfja1fMy4a5rTNW7+tvuv/eUl
         GWpXiCkX4zGiPvC2odL/bvZ6FseA0zWlI772bYOuLsN6k/DB4mjI/t7z9KitNxcIHD
         AXu3iyW1nywpr1bDQ1eQy5unm3diACzLw/lWz2WO7FpDYUS+QclPAPYkowFw9rRG/S
         ASw2iuNLya9+R+sBCji5iFcxAB5mDt+bbMCd9vKHp2RnjdLlXQ2s1zZpAoDCh/dlx+
         ZY22tIkyOoOzw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Terry Cheong <htcheong@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ryan Lee <ryan.lee.analog@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Patches Robot 
        <linux-patches-robot@chromeos-missing-patches.google.com.iam.gserviceaccount.com>,
        amadeuszx.slawinski@linux.intel.com, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230108114351.539786-1-ajye_huang@compal.corp-partner.google.com>
References: <20230108114351.539786-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1] ASoC: nau8315: remove dependency on GPIOLIB
Message-Id: <167328296387.323147.13503501873673996744.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 16:49:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2023 19:43:51 +0800, Ajye Huang wrote:
> commit dcc2c012c7691 ("ASoC: Fix gpiolib dependencies") removed a
> series of unnecessary dependencies on GPIOLIB when the gpio was
> optional.
> 
> A similar simplification seems valid for nau8315, so remove the
> dependency as well. This will avoid the following warning
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8315: remove dependency on GPIOLIB
      commit: 523ba3b70fc572f69673d8bd88af00df0e716529

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
