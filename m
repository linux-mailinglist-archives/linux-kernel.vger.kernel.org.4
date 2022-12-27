Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132B656A24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiL0L5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiL0L5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7E9FD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:57:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E617B80F9E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E1C433F0;
        Tue, 27 Dec 2022 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142228;
        bh=9yRIVQ65k8q4rK77nuqyCqsGjJFDzWQnam3WVa2/TQ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e7nCMJ2aesGgwFOSYVCAPwx6emOAW3+srdwf/DTfNrKVPHYDV0qlXaabeJEJKnGmN
         TfBntyP9pZu9i+SheVqUs9I06XmPcyilMmYJ9mELp/VBmRNVa70YwacXRCLO+eqQ52
         dtigi30WgXPpJ45r/5lxZVYzsF2WUa4523P2yH/cPknVLv9wvvilKu+CDRweNxFmkQ
         xwd04f/xVA1+zzWpLsH3vQ0Orr1L+vzULhkRspBTNTk71CGem9swjs8pwFEt/a5Ppd
         ziw8Q3Q5aTsWxxENkgbsyNuwNA5IEPycWcNCAKj6fq4RqI041BzjNoPHx46TJzR9FG
         M0V+fSM85U88A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Lukasz Majewski <lukma@denx.de>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221214123743.3713843-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
Subject: Re: (subset) [PATCH 0/4] ASoC: Fixes for WM8940 codec
Message-Id: <167214222620.82924.12796043478765095977.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:06 +0000
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

On Wed, 14 Dec 2022 13:37:39 +0100, Lukasz Majewski wrote:
> This patch series provides fixes for WM8940 codec.
> 
> The most notable change is the clock rewrite, so this driver now
> can either generate proper clock frequency by itself or use one
> provided from the clock subsystem of the SoC.
> 
> Lukasz Majewski (4):
>   ASoC: wm8940: Remove warning when no plat data present
>   ASoC: wm8940: Rewrite code to set proper clocks
>   ASoC: wm8940: Mute also the speaker output
>   ASoC: wm8940: Read chip ID when wm8940 codec probing
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: wm8940: Remove warning when no plat data present
      commit: 5dc5e76b4c41fc8cdd9ed77653b2ce453974fb30
[4/4] ASoC: wm8940: Read chip ID when wm8940 codec probing
      commit: a5c26ee572d94337baf9c944b7b4881a2db62d37

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
