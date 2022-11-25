Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E5639112
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKYV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKYV2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:28:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0E53EC5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EBD4B82C38
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C1FC4347C;
        Fri, 25 Nov 2022 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411714;
        bh=UE91ckGCJzG7DYhHpRX4sNBnIkoKdtx0Ogz/pz5XkVk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CyR/geYX99NErL68x+WfVB+XVm3KFijEOOkn9ZPC+bOFRN6EIfovl9TXHoKAZETBV
         bHzUPE6X13Q4BTBhJsYkkuE68Mhm7jtiKjCF1Q+CFR1Qj98iwDWMpYy23XB18SD0sX
         tUlLCqbBXO6V8s8Cv9J7zzQreQExArHSUUHAMs9EGwhMzT3JFb+oSUyDG/gjVIzIOt
         KffctQ4XTy+/vWngmaNNpS3SG3kh6z8LLuqmySYC9k7IC/EtXlF5TZx11IE7MhE+WU
         0s4c6YtArAp7yyTbmWuTUiDFY7DlV8RInmzpzJRo0ZG4YpqAbSClSgf/wYoS/igrAA
         ASh2B5tkr24lw==
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20221028152626.109603-1-maarten.zanders@mind.be>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
Subject: Re: [PATCH 0/3] ASoC: adau1372: fixes after debugging custom board
Message-Id: <166941171393.2089698.14716103883721303046.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:28:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 17:26:22 +0200, Maarten Zanders wrote:
> Maarten Zanders (3):
>   ASoC: adau1372: fix mclk
>   ASoC: adau1372: add support for S24_LE mode
>   ASoC: adau1372: correct PGA enable & mute bit
> 
>  sound/soc/codecs/adau1372.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: adau1372: fix mclk
      commit: 27b6fa6145215c5f49d93e322a16144b928ecd3e
[2/3] ASoC: adau1372: add support for S24_LE mode
      commit: cd887a7ba74c8378ae8b52afa04adb0d49cdf13d
[3/3] ASoC: adau1372: correct PGA enable & mute bit
      commit: dffa0df699d7c20f447e6bd797666366c6bae4b3

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
