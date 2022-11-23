Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C6635FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiKWNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiKWNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:30:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3F8C0B1;
        Wed, 23 Nov 2022 05:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB11B81FDF;
        Wed, 23 Nov 2022 13:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F3FC433D6;
        Wed, 23 Nov 2022 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669209090;
        bh=Pmimk6P6al4IzF3uS/yD4sA/hKmZqcQ3viaO89EoanQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZrUI/t5mVj7g/IwF947jY7DEP46UTmCGwZm1yrfeZj8sJpE/0UsmGkHz1oufRXJJT
         VOoyod3pAfIt0tEPQ6mCEfbNTvdMImsLCgXoOXxN93nxZ3VQ9vEkBWU8/oaCgNo4+W
         k4KDT+73KAx2I71qfX7xPMecXaE1GHnkrllRaM2dbqwB0souBB3OxSpKGHeHAVB5U+
         WxRLzI4nKX6m4gcIwcosJQ5DhFHeZpPB7hyiwa3yGPbQIxb+Y+y430e8cbuxJ/Sysh
         Zd+HS13Y8PBubLg5c1lya7GG/ae0Y6SAnCLQmUcQjytq+uokYlVfTowmBOtEXYDroi
         iuz03vebUOwIg==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linus.walleij@linaro.org, maz@kernel.org, tglx@linutronix.de,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 00/12] Add support for the Cirrus Logic CS48L32 audio codecs
Message-Id: <166920908765.125457.5735851922084989509.b4-ty@kernel.org>
Date:   Wed, 23 Nov 2022 13:11:27 +0000
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

On Wed, 9 Nov 2022 16:53:19 +0000, Richard Fitzgerald wrote:
> The CS48L32 is a high-performance low-power audio DSP for smartphones
> and other portable audio devices. It has various digital audio I/O,
> a programmable Halo Core DSP, fixed-function audio processors,
> configurable GPIO and microphone bias regulators.
> 
> The CS48L31 and CS48L33 were derivatives of the CS48L32.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[10/12] ASoC: wm_adsp: Allow client to hook into pre_run callback
        commit: fe07130870c8540bc0cddbaa8d4521ecdba6b560

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
