Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29462639128
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKYVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:40:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CF56EF6;
        Fri, 25 Nov 2022 13:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3381260F52;
        Fri, 25 Nov 2022 21:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43494C433C1;
        Fri, 25 Nov 2022 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669412404;
        bh=60OYuwERXmeJ082oTHm4vNOnTl4qAPQKBRpMhBKDRrg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nGITamugCR2YRPeV8yeGPa7FCVN/G1LQAcnkE0xX1oDb80dSSVO4nvB4RaCNHXE/V
         YTmyxm6GKwkWIX8Id7rvTSUFXJ9BsgyTZ7YZgPkB24z5m0YoW4tXACGf5StxLGE7Dy
         cF5YYi5g9SQ1uPq2PzrNSnDhosH0UxSXRKhLQ36yFHb6Sp5SUmOHHmPw9j9yGNjUW6
         V666PpdDk5lOvaAhcwSFq0i236E7+Nx375A7TimVo1GuK6dNS85OEONtV2yPyIWWJb
         B6FxMooDqFCL3s3PtlP2jsBP1SMugXeN0WKK+4wnxJEhDiSal8PyFe8zLKpa3XG8xj
         nDgWfrj8KVsxg==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH 0/4] RK3588 Audio Support
Message-Id: <166941240197.2098666.9516708665413168178.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:40:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 14:41:28 +0200, Nicolas Frattaroli wrote:
> This patchset refactors the Rockchip I2S/TDM driver in order to
> support the RK3588 SoC, and then adds the necessary compatible
> string to load the driver for it.
> 
> Patch 1 rectifies a problem with the bindings where we were too
> strict about requiring the rockchip,grf property. Most features
> of this audio device don't need access to the GRF to function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: rockchip: i2s-tdm: Make grf property optional
      commit: 1024a5b29e90a18530588b3f161e81cf3fae7dcf
[2/4] ASoC: rockchip: i2s_tdm: Make the grf property optional
      commit: d980004e349049a3fcbffc6096d14896f6a122ed
[3/4] ASoC: dt-bindings: rockchip: i2s-tdm: Add RK3588 compatible
      commit: 0643fd3669f5c33bab5b05a813459a2d00a83465
[4/4] ASoC: rockchip: i2s_tdm: Add support for RK3588
      commit: c619bd4268ff9895760dab303b4eb15ed3d0f7e9

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
