Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707AE60B037
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiJXQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiJXQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:01:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99D115409
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A18B6B81B8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C74DC433D6;
        Mon, 24 Oct 2022 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666620120;
        bh=pNwuaU1Ukcpu+2WY7FOqGXayA5lGqbb30IfbM7hnsHo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EmVx/iDvv3b0A31uPTIJbXEwiPmYCrMxxgvtk0/N6LcykmG/6kiO3KW7rJjoITGDX
         jEJbUqjCWOr87OiQeqv+TORr/zhDoRuCo3tXQ1w5fUmIgEKSqG9QqWDzgSFoqAHLNR
         p0WP+MxEfpoO33CA8XLZ62Lpn41EoS6XiTtQh6LC+xR5wvv2ravMbo3WnVvd4vn3ho
         uB4B5JsjrjRShNYreRERf9V2MLlBxhZsZZLWgy8sBjepfb+5o/DtI0IB+Xty6z7Qh2
         T3xIH/jDfvoIKsldCuYQ21KEg4HBW69CAU3tcezG80QP8xDDgThmz+qiCiJLoPZBOz
         Sya0su8WFyROA==
From:   Mark Brown <broonie@kernel.org>
To:     samuel@sholland.org, lgirdwood@gmail.com,
        Ban Tao <fengzheng923@gmail.com>, perex@perex.cz,
        jernej.skrabec@gmail.com, tiwai@suse.com, wens@csie.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
References: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
Subject: Re: [PATCH v2] ASoC: sun50i-dmic: avoid unused variable warning for sun50i_dmic_of_match
Message-Id: <166662011789.251784.4030037448307420483.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 15:01:57 +0100
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

On Sun, 23 Oct 2022 00:44:45 -0700, Ban Tao wrote:
> In configurations with CONFIG_OF=n, we get a harmless build warning:
> 
> sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
> 'sun50i_dmic_of_match' [-Wunused-const-variable]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sun50i-dmic: avoid unused variable warning for sun50i_dmic_of_match
      commit: 2cfcc1085d3b7b7c893be41034853d4c63a41092

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
