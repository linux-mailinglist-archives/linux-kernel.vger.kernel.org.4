Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959F750697
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjGLLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGLLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CF1BE9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1820B617A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFABC433C8;
        Wed, 12 Jul 2023 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162429;
        bh=MrD10ypRydCEI5x7llBX60wzJIoyt566JqIz24flJbI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UrclTGnl1R0Z+MjkfclmgIwW+o44bCtTx/pbsEej3kKcmnBEiREyGu3D8OQZbEREV
         igvMYLhBRCVvBLsjHKDSZJX8npW1uBTzsD7feS761uTcIYMcZoFfy1RmZRqHDA2Pd4
         XTjYdVrSVq/IEcmV9VzgGBy5dRWp94S0DVOCO9gGfZFTgJjo/1kHk3LfU/GXgsWKC0
         Yr4M4ZpEBwV/OwJP/7hbMAl2a7LN+1xXLateipXzBFsMv0ZdxQBCcL31Ny4Jj3+t+W
         cW2FJfZK9doWmMnwXNu4O9gCxxPF+8DlsAKGsU2qV15JUlRdaS+DCdBRXJTxqHUFsy
         ykwrcjhhAQJww==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20230701044836.18789-1-rdunlap@infradead.org>
References: <20230701044836.18789-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] ASoC: stac9766: fix build errors with REGMAP_AC97
Message-Id: <168916242817.46574.1012924701910516434.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:08 +0100
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

On Fri, 30 Jun 2023 21:48:36 -0700, Randy Dunlap wrote:
> Select REGMAP_AC97 to fix these build errors:
> 
> ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stac9766: fix build errors with REGMAP_AC97
      commit: c70064b96f509daa78f57992aeabcf274fb2fed4

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

