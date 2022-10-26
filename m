Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5E60E85B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJZTHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiJZTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B42CE36;
        Wed, 26 Oct 2022 12:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D5B062033;
        Wed, 26 Oct 2022 19:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2740C433D6;
        Wed, 26 Oct 2022 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666811075;
        bh=U+R8INu9G+SgFDxjAisYOYC9BdZ7qdOXy8lBhXyOEwE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rI4nDtKHjUysmmUGj09yG6xS8huuOsMAGRr1z4i7boXV2jOUSegFC8c0jzlnnklBh
         QZghP+s7yItJfFxeBtKdiDnojkqHThYxwjwpUt3SVs++c8/ZG+1I6PzLSZ5+xuIycQ
         X8FPkkip5XZyWzrtQaZbTrucYseGGhEeyyOHt3pWuL92WyBxIed6Jx/2+0uY2jUiKT
         AI/0YlNxPWu/pleo0PxcyuhgVSONw2Q9l1auUZVo3Z7fyrBzqjGhQKHfx+iminrKCL
         5HoJKBhWNXVAV3Mf4CiFoJJcFyau3SH6zwcDzuCoijKASZpM1Jt2KAgha7K3h7FE6j
         9rpimXL2LU/qQ==
From:   Mark Brown <broonie@kernel.org>
To:     paul@crapouillou.net, lgirdwood@gmail.com, tiwai@suse.com,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        zhouyu@wanyeetech.com, linux-mips@vger.kernel.org
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v6 0/9] ASoC: cleanups and improvements for jz4740-i2s
Message-Id: <166681107350.960840.12779879137607542680.b4-ty@kernel.org>
Date:   Wed, 26 Oct 2022 20:04:33 +0100
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

On Sun, 23 Oct 2022 15:33:19 +0100, Aidan MacDonald wrote:
> This series is a preparatory cleanup of the jz4740-i2s driver before
> adding support for a new SoC. The two improvements are lifting
> unnecessary restrictions on sample rates and formats -- the existing
> ones appear to be derived from the limitations of the JZ4740's internal
> codec and don't reflect the actual capabilities of the I2S controller.
> 
> I'm unable to test the series on any JZ47xx SoCs, but I have tested
> on an X1000 (which is the SoC I'll be adding in a followup series).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: jz4740-i2s: Handle independent FIFO flush bits
      commit: 8b3a9ad86239f80ed569e23c3954a311f66481d6
[2/9] ASoC: jz4740-i2s: Convert to regmap API
      commit: cf375e693252f4e8ecb6256af631ff381381a3dd
[3/9] ASoC: jz4740-i2s: Simplify using regmap fields
      commit: 0fddb4bce669fd255f6ffade6905da5c8ed3e254
[4/9] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
      commit: b355ebebb17c438b90c3d339f38a79559f7259df
[5/9] ASoC: jz4740-i2s: Align macro values and sort includes
      commit: dacc06b812f46e0d4cfdda98134a8b5d64375341
[6/9] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
      commit: 7abd01cfc5428581b21099eb629d88e76a47b67a
[7/9] ASoC: jz4740-i2s: Support continuous sample rate
      commit: 84a914349ba2634e8db6b0815f100697d878d033
[8/9] ASoC: jz4740-i2s: Move component functions near the component driver
      commit: 165afe6b66aafaafc95484ac2f0f09f78d62386b
[9/9] ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
      commit: 4e02fd6207474ef2d882b8620f4c3db9a02d4ddd

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
