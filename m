Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D960E6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiJZSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiJZSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415C8321E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF78E62020
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB62DC433D6;
        Wed, 26 Oct 2022 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666807650;
        bh=enLmCax9xea4wAn4oPqtGPe6DLfKjscG5nCv+BzQ+Xc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GWErYE+Ydc6G3qp3+3ESgysdF2O0GYYTe7pdXRU371gmOPP28XaK44q1O91kR0gNM
         7yOgWDW453SARlkAzNoop68G0psc63VAWZbiRYwLp3TuOkzDGJgN7ZhLQumx9sMeeQ
         ny+ZcZk9UQGLQRVEjB9jsnmURbjLRkR9rfcWPy5Eas6LumasFtYu5+TqIgUCQbB1Rg
         ZZKTol8rgjrpmoXPsQT7Tfd4zkke0BSOTWk+mkw1imqgZelASKdAz2IYE3/Uc3EtSE
         3x1Pz7FAbTtWV+MaP8pn3N+r8NsGD1pmu9J4UnV8cN58LC7fOL4cqGJdpTBxjAi2Xd
         KG00H5wEZyPgQ==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Paul Cercueil <paul@crapouillou.net>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20221025150149.113129-1-paul@crapouillou.net>
References: <20221025150149.113129-1-paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: dapm: Don't use prefix for regulator name
Message-Id: <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
Date:   Wed, 26 Oct 2022 19:07:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 16:01:49 +0100, Paul Cercueil wrote:
> When a component has a prefix, and uses a SND_SOC_DAPM_REGULATOR_SUPPLY,
> the name of the regulator should not use the prefix, otherwise it won't
> be properly matched in the DT/ACPI.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: Don't use prefix for regulator name
      commit: 1683d3282f240336a2b4b6b541d435facfe8bbb6

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
