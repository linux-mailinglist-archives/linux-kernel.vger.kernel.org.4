Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA425750688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGLLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjGLLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9FF1984
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6726161796
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125CC433C7;
        Wed, 12 Jul 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162396;
        bh=JfAJmko1aJRSaP7TINdHFWcUEpNZeyWnoLSyFMLbQ1s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fwbpSHkSXzwXLCUhn047ZFcWSacGcEuAI3FDal2kLkvEmN39lD+7PDhxfYRCXZrHH
         w0HOqNOcH20Y0qrmGnVy2eLJut+lLO9XHdDcw/uiBcETj1UyzgmgLT5RBa6Fpnp4c+
         2yR8H4TXW2u4+NjQG97ywb7kWsOFqAHG4ZdmOue0c5hPmzgOpJrfD8Ria0HuuPxI61
         bO3Vq2w0tqvVG8XEHoPx3R8yTfYqWV4s1nRyX+l001yhhhjcyu/uGf0vaH3PG/G+oe
         DmDC4SMntNDHHCfk4a256P/5VOV8lXOEYxw5CdxODFv1Ef+XlOsZPzaMP3HPdthIsW
         FOo8jn/OD1JUA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230622200031.120168-1-fido_max@inbox.ru>
References: <20230622200031.120168-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] ASoC: dwc: Add TDM mode support
Message-Id: <168916239498.46574.17040114171305737838.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:46:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 23:00:29 +0300, Maxim Kochetkov wrote:
> Depending on hardware implementaion of DWC I2S controller may support
> TDM mode if enabled in SoC at design time.
> Unfortunately there is no way to detect TDM capability for DWC by
> reading registers. Anyway, if such capability enabled, TDM mode
> can be enabled and configured by dai-tdm-slot-* DT options.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Add TDM mode support
      commit: 221acc16aee16eb246bad32a6b9014021218b7cd

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

