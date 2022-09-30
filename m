Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65FB5F107F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiI3RFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiI3RFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:05:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8BD29806
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 009CEB82953
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2712BC433D6;
        Fri, 30 Sep 2022 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664557507;
        bh=KRPWFdHDwy6jFjizRpKLHPb3QET+jaDIqMKXoYQyKBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MwCBBA/YaOR0syu3zILaysBKPSt8hQiWGabe9TKQAW//NoSEWKIKMKQ7/H73joLnZ
         HSNOSUcKDEVSp8igks8pS2T31xC5nVF/vUH+7c/qzJZMV7MRlgVMUfS7kAWxhrK6LD
         IhMOtaaTqGigxYl/xfEihI/BoWxvoePNMvcKK8hozK/iqDkedZQiaFS9Y4OmEUV5I2
         n6nB0cXc5ID0Frde0a8QxXOAJjQw17kdF1nT0mUcY/Hp7Z1mRRls6m7mYIUEQ9YdvW
         MQTmeJlVsvXluDzJnfp6A/75nFlcyIB8svRIO+Tew5w2jK3KHObaxVnT3cdJmer0Pi
         1K2HqFtEguXiw==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-rockchip@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220930151546.2017667-1-judyhsiao@chromium.org>
References: <20220930151546.2017667-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v1] ASoC: rockchip: i2s: use regmap_read_poll_timeout_atomic to poll I2S_CLR
Message-Id: <166455750485.778075.7092122068963727383.b4-ty@kernel.org>
Date:   Fri, 30 Sep 2022 18:05:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 15:15:46 +0000, Judy Hsiao wrote:
> 1. Uses regmap_read_poll_timeout_atomic to poll I2S_CLR as it is called
>    within a spin lock.
> 
> 2. Fixes the typo of break condition in regmap_read_poll_timeout_atomic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: use regmap_read_poll_timeout_atomic to poll I2S_CLR
      commit: f0c8d7468af0001b80b0c86802ee28063f800987

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
