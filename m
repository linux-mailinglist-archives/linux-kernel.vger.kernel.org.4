Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947B8728394
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjFHPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbjFHPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A72D5F;
        Thu,  8 Jun 2023 08:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B8060FAB;
        Thu,  8 Jun 2023 15:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D19EC433D2;
        Thu,  8 Jun 2023 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686237530;
        bh=/A54Gy0vU98edPnbqK2o8zydJ92zi9Oi8moAunyOrJE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RdrtpfvpzdGY8WkZ0yvWsGoaLstSARmD7jyc/8yluqGlgzTEUiib2fkv88fsFTwzt
         VI0ugZcV7T46reJCxWdJP49kC98i6KrF1VDSRTrx0a8YXLvXBwYBpHShvV2XcfjwuC
         PBtIASy0kct7WqQaV3CBy9zDKSY1CVdiUuNP7ht1SvF597BP95UxTyx71Rht2IrZ1i
         xvrSIVjcj191w/VV5jb43kVBKMoj3fBHHc/RRaivw8TN7XrcYhSGWYA32hSIoqSFuM
         Qtulm4/YMMgaxMJ61jE5WU8vConoEvRAd4bnIwBPUxbOZizfKzBfwCWVlbTFSTIqcG
         TyTU0X4THN/vw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
In-Reply-To: <53f928290f08f50ff43031e17fe1d88443c2c441.1686202022.git.christophe.jaillet@wanadoo.fr>
References: <53f928290f08f50ff43031e17fe1d88443c2c441.1686202022.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: tegra: Simplify code around clk_get_rate()
 handling
Message-Id: <168623752796.1002486.3534848547952230494.b4-ty@kernel.org>
Date:   Thu, 08 Jun 2023 16:18:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 07:27:22 +0200, Christophe JAILLET wrote:
> clk_get_rate() returns an unsigned long, so there is no point in storing it
> in a long, and test for negative values.
> 
> So, turn 'parent_rate' into an unsigned long, simplify the sanity check,
> the error message and the return value, in case of error (i.e. 0).
> 
> Doing so also turns 'i' and 'valid_rates' into unsigned long, but it is
> fine and harmless.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Simplify code around clk_get_rate() handling
      commit: 41a343cd6b7f8d0f70dd90c236086ccf8a84a7de

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

