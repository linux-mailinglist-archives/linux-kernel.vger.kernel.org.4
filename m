Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F9742406
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjF2Kdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjF2Kdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C6131
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E394614B3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DE4C433C8;
        Thu, 29 Jun 2023 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688034814;
        bh=wB0pel8YeGeZm2dbmOAccjhsLOMAiGiZ5vSzz1dazFE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qbLMjZHtlQkF57ZP0el9eJmJDkZ36wuYmCGqrxWftEYkcfxDYqAHCBnVena5PVmCS
         VL4jKxsVZdcSNK7TOZ4ctzwBTkgb6JCa3NU5mhbzK1GsqU7QvbqybXxT39Iuwk3dTm
         5EOpezJHy7WZuUQDQYjx8EIt2xhlcH3N5vkWAwQMvIEVb8MNUG4h80kUn/rQ3Mln2E
         pTFLDdcphPRxAmc2BO92siabf59G+1g4Pap/5NDN4Rc+FEk/6xlCdARKNzZhPQQAhK
         UWIYopRm7MxVVpgtWTvi2gCNvB6VC/B200MJDNakyuJmayqwS6tCRMPgFnjoAzy2iP
         h1iWmwY2UfAeQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>
Cc:     Dom Cobley <popcornmix@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230624165232.5751-1-hias@horus.com>
References: <20230624165232.5751-1-hias@horus.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: fix channel info for compressed
 formats
Message-Id: <168803481324.25247.5593448279992144349.b4-ty@kernel.org>
Date:   Thu, 29 Jun 2023 11:33:33 +0100
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

On Sat, 24 Jun 2023 18:52:32 +0200, Matthias Reichl wrote:
> According to CTA 861 the channel/speaker allocation info in the
> audio infoframe only applies to uncompressed (PCM) audio streams.
> 
> The channel count info should indicate the number of channels
> in the transmitted audio, which usually won't match the number of
> channels used to transmit the compressed bitstream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: fix channel info for compressed formats
      commit: 7b5162080174ae50e8288574379d339b0fcd1760

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

