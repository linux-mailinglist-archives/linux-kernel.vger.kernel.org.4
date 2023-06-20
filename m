Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C14736E98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjFTOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjFTOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED4A6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9774612A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DB1C433C0;
        Tue, 20 Jun 2023 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687271105;
        bh=7AACjipcxyYbzzXpVvwcOkRc2c/KPnsVgq3GUJOUrLA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QPy9eoBZO66EZaZR2ci8J4gHW45TNTHBp9HsPHgB9HofUJ1jyYTKhwZHnam7/ln3n
         Sqoh5Coqew8lnPY+oWoLR64ejPvwJZ1vRqFbpPvngFdl9QjVpCqO/46+xqhid42Gnp
         Bt6j6IyiDRqfHOsb/MpBxjLJ520uHyikNDnrukQeAmmBX7x8ErBu7AdgMhfLyalqaG
         oYguBhzyc2Ej/wrY+F+Ncnu5hU/uy5JZOnQ/QWU4PZoQbCLyHxXtIeP2Lsc0Gz9ByL
         aHJhK6gPKOHWQPqd1HW2q1ykYhzGxikImMFOzfEXUqg+R+L3GyZ5J7fq3ta/Enbc+b
         E5y0vlji8J29w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613191910.725049-1-fido_max@inbox.ru>
References: <20230613191910.725049-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] ASoC: dwc: add DMA handshake control
Message-Id: <168727110325.80037.2686606919165624157.b4-ty@kernel.org>
Date:   Tue, 20 Jun 2023 15:25:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 22:19:08 +0300, Maxim Kochetkov wrote:
> DMA mode uses hardware handshake signals. DMACR register is used to enable
> the DMA Controller interface operation. So add DMA enable/disable to
> i2s_start()/i2s_stop() functions if using DMA mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: add DMA handshake control
      commit: a42e988b6265dcd489feb1adab8551b40c988f43

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

