Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE167D8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjAZW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjAZW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:56:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E752DE7F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:56:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D1561977
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418FAC4339B;
        Thu, 26 Jan 2023 22:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674773761;
        bh=qfldkDJmgn8vOuHq7v2bCTrIuy1CxDE4Iarz21xaH6Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BKdbrxpUufkzeGg6jzq8xY8GiE0oDAeZu6u8EUnAd0C65AwfgU63WgymQ244cEggh
         5eKthtI0iBnTnRp78Tdt1P0Wg2+Do419IEu0wBsAlYJjwiZF1zzx0z8YTQsqa64lm0
         OISNwauKTsOH+z0GlPZTYZ5raNdcSuCh14iBnfgWPzQQFCau295T27hMqJnSXQaoas
         +CmS+KKsbKCorjSLK72Tq+pdA4Mksy//121/joEQaRPk9IgTHw3BjQykUTad8i19E+
         hmZORYywe/OhJ/J64tPPEV1ag5cVsCKjpY3xp+N4NlREkLuemO1ZBE6ykcxX2LyooK
         lBqumV/FMpXNw==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Zheyu Ma <zheyuma97@gmail.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230126162203.2986339-1-arnd@kernel.org>
References: <20230126162203.2986339-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: cs42l56: fix DT probe
Message-Id: <167477375787.524795.5320623623703804107.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 22:55:57 +0000
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

On Thu, 26 Jan 2023 17:21:24 +0100, Arnd Bergmann wrote:
> While looking through legacy platform data users, I noticed that
> the DT probing never uses data from the DT properties, as the
> platform_data structure gets overwritten directly after it
> is initialized.
> 
> There have never been any boards defining the platform_data in
> the mainline kernel either, so this driver so far only worked
> with patched kernels or with the default values.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l56: fix DT probe
      commit: e18c6da62edc780e4f4f3c9ce07bdacd69505182

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

