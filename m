Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36B6DDD92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDKOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDKOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5F44A5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A13062755
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A317DC433EF;
        Tue, 11 Apr 2023 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681222747;
        bh=kdQTUFDrppcbll+bPRUoyQi03XX3nEL9SdpO7pnbEXI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dV245lNUy0cQvqED7MKhuvvzB3zVQtzgeaVo7iXHTIrj2atMR0iXdikGaWwam4Vfn
         5fTiIUQeSOWdHCa/k5olVclSC5hvqy3ArmsnVfzrJKnn0ecFWd4VGDrkYdbPmKo1IZ
         RCMm4Kpsnx0kggTgoRGRSitW/ifkySNFmHa1qhvXDu7/2y22cCJ2WYtMNtLKAS8kT4
         OWOmhKQPEitikXq4wBg720qbqNngqC1EG8eHHvI3zmdFQLdwn3yj5NBl4pP8ODz7pA
         XhFB/409eui8GI1XM944voar0tCq6fXK3lCeJVBPi2k7svYydNhl8i+YSyfg2tlps0
         Sxd8TFcKTHPWg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: ep93xx: Prepare for DT transition
Message-Id: <168122274438.54453.12909974766938645863.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 15:19:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 00:38:59 +0200, Alexander Sverdlin wrote:
> This is a preparatory series for EP93xx transition to DT. This patchset is
> a pre-requisite and has been tested with the full DT patchset [1].
> 
> [1]. git://git.maquefel.me/linux.git branch ep93xx/6.2-rc4-v0
> 
> Alexander Sverdlin (3):
>   ASoC: ep93xx: i2s: move enable call to startup callback
>   ASoC: cs4271: flat regcache, trivial simplifications
>   ASoC: ep93xx: i2s: Make it individually selectable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: ep93xx: i2s: move enable call to startup callback
      commit: 80f47122538d40b1a6a2c1a3c2d37b6e51b74224
[2/3] ASoC: cs4271: flat regcache, trivial simplifications
      commit: 2e9688c81cfc48b210af6f313cb04589b7943e86
[3/3] ASoC: ep93xx: i2s: Make it individually selectable
      commit: 24f934becf60598fdec9c9f2e06437c831ffa374

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

