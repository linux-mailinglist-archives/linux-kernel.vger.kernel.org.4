Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E96656A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiL0L6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiL0L5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36AAA19A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5F06106C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A6C433D2;
        Tue, 27 Dec 2022 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142252;
        bh=AC5FnV+us56kX2g+J2arHCm2TIeoiHguvwSTxqc9Vr0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rGOEDUYtzgB1k2pa8t6TaBvOPnKjFzXecnh32jRu46OKU6kpcfyFjVXOo9aooVaSz
         NthmSNLKpCYNb+Hyk6hyTaNpA88x5wilSD34rcbpJSbT+chUTT9kckzSYdrv92Kygi
         sQW2Np86FkO3abvijBO+69aZro7eIDqcvMbTUDZuTFKtuk8EHzAtDYb5NaoXSr0cOP
         lPbR+Mb6RSpd862KXBgCWj8F2j1EHTWnRUHwbmFn7wE7ie5xLsrNGUxTb4bbQ6SPLt
         c7GUJNbYs070yGOM429wK6UgtBQun82/5PrW/Uty0pewwBnRZgh/6e78iriI+px5Ng
         txO6nJpAOWxqg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
References: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp device config
Message-Id: <167214225052.82924.1961233191499199699.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022 22:58:48 +0530, Vijendar Mukunda wrote:
> Implement API to retrieve acp device config and calculate platform
> device count and dev mask for platform device node creation.
> 
> Currently for DMIC configuration, mask and dev count are calculated.
> Same api will be used to extend support for different ACP device
> configurations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: amd: ps: implement api to retrieve acp device config
      commit: 2cdabbde0c24bb76978d57856cba958b85584c32
[2/4] ASoC: amd: ps: refactor platform device creation logic
      commit: 1d325cdaf7a2747df42b43eed8b3de2e2d6c69bb
[3/4] ASoC: amd: ps: update dev index value in irq handler
      commit: 9d327a4443bffe8d48acc6a31c0198f251fca08b
[4/4] ASoC: amd: ps: move irq handler registration
      commit: 966ef755d3b66853be4f15c698f5210115c15d23

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
