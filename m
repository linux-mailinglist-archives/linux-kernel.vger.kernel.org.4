Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D37722DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjFERbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjFERah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D2115;
        Mon,  5 Jun 2023 10:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCE4628B0;
        Mon,  5 Jun 2023 17:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35EAC433EF;
        Mon,  5 Jun 2023 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685986234;
        bh=WdV07oy/o91QEHR/yUMXPJbDhkHpn84JHUxwqIBH/a4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WV4/J8LxaHbnn83o/tFnncB95q1CEMouX8J6cEuJJ8BqIw+HxGKjSw4SggwJCclmh
         bnjh16AvaQ+oXOk/C2vdQJGn1GFxuKQmc1VpkASsn8yAii3JkrBkBAuCWx+ctWSvGu
         gt0Wog/LH9xfYCD5PsdFl3k5fIzFI5ZR7PIZw5mSkX+yMxSo5wUOHvGk3ZiCs2m7YD
         sONooxx9S7MoWNN43+spGjmJwv+bC+aRgusr/ZmSoHbfAPAs7p1qAj2D86ugm2indf
         wV3HvFI+N8Kt4VB73e7JiGcVPHCJYokX7vCk8UclcXKmq2AqPB5BMdTqAucGNrMvPq
         Y6nAGTf53zMbg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     amergnat@baylibre.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230526093150.22923-1-trevor.wu@mediatek.com>
References: <20230526093150.22923-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v3 0/7] ASoC: mt8188: add new board support
Message-Id: <168598623165.103672.7353425800916087713.b4-ty@kernel.org>
Date:   Mon, 05 Jun 2023 18:30:31 +0100
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

On Fri, 26 May 2023 17:31:43 +0800, Trevor Wu wrote:
> In the series, we extend the capability of mt8188-mt6359 driver.
> 
> The following changes are included.
> 1. Divide ADDA BE dai into two dais for SOF.
> 2. Register hdmi/dp jack pins.
> 3. dai_fmt can be configured from device tree.
> 4. Add some I2S codecs support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: mediatek: mt8188: separate ADDA playback dai from capture dai
      commit: 2a7a1ae95c84d4199736872bfbc39d01f4b6b0ab
[2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove ADDA_BE from link-name
      commit: 9fba0d3ec0a074d1a7c094b2cb722f135215fab0
[3/7] ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack pins
      commit: 73cf2b3f2b45fa4c231e8e84ae5d8cc80947d799
[4/7] ASoC: mediatek: common: soundcard driver add dai_fmt support
      commit: c0e7390e6d3f42b9a15a0e72add21facb8e17790
[5/7] ASoC: soc-dapm.c: clean up debugfs for freed widget
      commit: 8ad13cdc92f66333ae475251ae7722313f84e496
[6/7] ASoC: mediatek: mt8188-mt6359: support new board with nau88255
      commit: 9f08dcbddeb307793bbfff036db213d2cdf03a50
[7/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: add NAU8825 support
      commit: ee02b869dcad7ba3772b58e93dd90ab4f932fac5

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

