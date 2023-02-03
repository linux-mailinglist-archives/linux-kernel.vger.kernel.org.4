Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6D689C53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjBCO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjBCO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C83D080
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5B43B82AE9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E09C433EF;
        Fri,  3 Feb 2023 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436168;
        bh=1KMtwbnXdWhNLG3cfZylZhMYnvmgO9XpgLmbJY/5rx4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RgQMKp+AVUBdWOoxiOjPwpnJ2AkIN+rLkjy6eaLdjp2GJtkbSEbg2lodoCxzBToEz
         zBEQrgC6F/jmBfo7GfTE3v6jUWabDRgg/O1GLv9NwvauEJAd0YHEzIGkLvq3NnJLGG
         kCcMizhUALyml2sBIJlF0wWCyHK1Ld6xvwvokT4BUtSKDsIukh8VHjKIjz8WrF/76Z
         SZM17GKpoFnaYw8ycOg6BMKjxeNdfGD8WthWObpOOT8PqbIs1zS3bnkuOxmDwdMK/r
         sKoKz6AJmsT+MSsScP8KIiasQjlgiyPAd5DFx1uMjQyV3loveg5akixk6tQIWTC2e9
         2Lzu4Frt7XXyg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Basavaraj.Hiregoudar@amd.com, Sunilkumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230201165626.3169041-1-Vijendar.Mukunda@amd.com>
References: <20230201165626.3169041-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: update ps platform acp header file
Message-Id: <167543616571.928818.6092818579559496073.b4-ty@kernel.org>
Date:   Fri, 03 Feb 2023 14:56:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2023 22:26:25 +0530, Vijendar Mukunda wrote:
> Rename Audio buffer and soundwire manager instance registers.
> Remove scratch registers as these registers can be accessed
> using ACP_SCRATCH_REG_0 register relative offset.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: update ps platform acp header file
      commit: 96ebccb2356da5f28726746e53719c5f494e08a7

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

