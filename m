Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73273323D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbjFPNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbjFPNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02212D76
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F0F61561
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B0C433C8;
        Fri, 16 Jun 2023 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686922417;
        bh=jTckaueZrxgJ1DD3YunCDn+t65tK68rxJs+GFNqQcG4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sovXjuNVFvEPPUA5cv/kzpBuNTYZW8XWNcjwl0ATGbNeC/lqPYwnTGbbepTHDUZVj
         UHjSbQ/YURSCTK2jeUyGx652HZEd0271ZicqgSs/b01MRfGc7lhBSCjsKpRH7UQKwq
         R5eArQ6B9b5IIVHZKBQtODJKVA/48AGZot5ParQPbWdga3/CmEI8tDYlLjbUKNH5yO
         NcqFs71kanSlh1x2Z3S8+aUOZFxavWcJNGHkfnJe6/z2/+jL4SDAbH3N6EQE8F8gTd
         AmwJqGCBMVGMDXX8yjAqbBuPN90kmN6EfV/PB1VVKtROKcbMTd/V1rw6GK4dq9Xxg8
         8OU9dejrIfKHA==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ryan Lee <ryans.lee@analog.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230616090156.2347850-1-arnd@kernel.org>
References: <20230616090156.2347850-1-arnd@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: max98388: fix unused function warnings
Message-Id: <168692241593.238476.5254935542511452470.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 14:33:35 +0100
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

On Fri, 16 Jun 2023 11:00:37 +0200, Arnd Bergmann wrote:
> The PM functions are never referenced when CONFIG_PM_SLEEP is
> disabled:
> 
> sound/soc/codecs/max98388.c:854:12: error: unused function 'max98388_suspend' [-Werror,-Wunused-function]
> static int max98388_suspend(struct device *dev)
>            ^
> sound/soc/codecs/max98388.c:864:12: error: unused function 'max98388_resume' [-Werror,-Wunused-function]
> static int max98388_resume(struct device *dev)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: max98388: fix unused function warnings
      commit: 0c340ba05fda0fbf5a54207452728911c6388330
[2/4] ASoC: loongson: fix unused PM function warning
      commit: 041c5a1d065e5882299475326655f573e2a2a580
[3/4] ASoC: loongson: add PCI dependency
      commit: 08432e59c7d9a958e69cf6b7a03777ba4f26f10b
[4/4] ASoC: loongson: fix compile testing on 32-bit
      commit: 928314eb06709e3861ce3e2c7e9ef3f83ba8691b

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

