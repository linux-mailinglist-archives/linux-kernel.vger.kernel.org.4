Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F46706B97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjEQOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjEQOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7C40C0;
        Wed, 17 May 2023 07:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B29A36481A;
        Wed, 17 May 2023 14:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEF2C433EF;
        Wed, 17 May 2023 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684335052;
        bh=8I67luAksBCL72+meHCMN8MBL7RhGxwexXQRG0RpqDQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qUWfDk+i2yXv7J9MhJbZBLjKRMGgL6whFTdU7YNAeRKAslCwfkZ0uu36FniV0PGoD
         2LKSjRxPljASyj1bfOozDGNrgsmGFwvlyb+oNv+iS70fjlEQpU5bHGYPhFnCGYyhLi
         4kPl91ugCsgauLB+ix/5ci9SbDnPcBlIWgpkRFH2fLouplPEw/XHzzF2JrbR6wHZJ9
         pOsDGy28GRzma75ffQTQgY/6M40lmW3vDnbWlNhIwgDq1tQkZaqIWJ2X0vLbWZgUdq
         2mgFU/rPyj0yOY9sL5N7JTrNmMqzNGIPq1NI/0JMI3axFH6bqQb8ZI1VyM6xHzvKQq
         hHxS0voC+lQRw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230516223700.185569-1-minhuadotchen@gmail.com>
References: <20230516223700.185569-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: tegra210_adx: fix snd_pcm_format_t type
Message-Id: <168433504910.453649.10010887587375335670.b4-ty@kernel.org>
Date:   Wed, 17 May 2023 23:50:49 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 06:36:59 +0800, Min-Hua Chen wrote:
> use snd_pcm_format_t instead of unsigned int to fix
> the following sparse warnings:
> 
> sound/soc/tegra/tegra210_adx.c:125:14: sparse: warning: restricted snd_pcm_format_t degrades to integer
> sound/soc/tegra/tegra210_adx.c:128:14: sparse: warning: restricted snd_pcm_format_t degrades to integer
> sound/soc/tegra/tegra210_adx.c:131:14: sparse: warning: restricted snd_pcm_format_t degrades to integer
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: tegra210_adx: fix snd_pcm_format_t type
      commit: 35f8a9d87ca4f920526e6063df570490b41295fc

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

