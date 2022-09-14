Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B35B86FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiINLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiINLFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:05:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20582EF1F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85BC7B819DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD86C433D6;
        Wed, 14 Sep 2022 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663153541;
        bh=gsGR7uK+L91dwepl01aajzxbTPAj28CNr4QvBuBbOZc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b9ZZcpIBGW+YRWtWA6iJZw/yJM9Pdf5dyjp8rj0g9HUACJikOfGtjb671ufB7eMEU
         bEO2bzcHnPfsreK5gugUEs7XD+vNyMD5F8ziE6IcvVTtsRR8b0sEikKFC2F69wQX5h
         0viMgSglWioQrHmgYxj5VE02hcsPhjj7PXNz+9wh+DS8aRSngA7a+xzKCByx472+rt
         2xHTcrCLo++71bfBiQTBOBOJOiS17kgPOft3ei88tBzqnTUgwiWMjl1em3CpFr91OA
         u1E0T4EwgavnwRB0M3B8gELOpNKQJsKHef1L4BDy8WGIp+b6FLa/atluvHNJJWCVOC
         Faf+HySCxIOuA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220914031234.2250298-1-judyhsiao@chromium.org>
References: <20220914031234.2250298-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v2] ASoC: rockchip: i2s: use regmap_read_poll_timeout to poll I2S_CLR
Message-Id: <166315353882.340317.4308348397044706944.b4-ty@kernel.org>
Date:   Wed, 14 Sep 2022 12:05:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 03:12:34 +0000, Judy Hsiao wrote:
> Use regmap_read_poll_timeout to poll I2S_CLR.
> It also fixes the 'rockchip-i2s ff070000.i2s; fail to clear' when
> the read of I2S_CLR exceeds the retry limit.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: use regmap_read_poll_timeout to poll I2S_CLR
      commit: fbb0ec656ee5ee43b4b3022fd8290707265c52df

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
