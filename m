Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0A750694
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjGLLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjGLLrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06E1FFA;
        Wed, 12 Jul 2023 04:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2D76179D;
        Wed, 12 Jul 2023 11:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF00C433CA;
        Wed, 12 Jul 2023 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162426;
        bh=TGhw0BOQLfLCUfvKyBi3wy+x2YHrjsCaDwvjVbjEVZw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m+a21ZBwBD0dLXB9dUo3vmJ1K4Ko4ztyANwi9/iMKKtwbXia2rmAGh9lzTvFfquBH
         bb6U6QwxZ8wz5c8QcOT52DKSEhGNA80SaZPpO1Cy3Rey2D0GydCcV3Io1jHm0wofH4
         LDMYsllnFWxuLIFlPTNfOA2pvow6mzET8nKCuPljaLd5i/rxCwdbF446poiMzF1jIt
         seC+a9Phb7jS92O2SlmY1cMWcicKAi1S7BXxs/8ylnfL0p7VRN8uBYJ7Q5acnQCluk
         HPvXdIfUlRYx4pJ8YCre+jpIqPhLiygd3TvUK6kRTcbZWaCtGTExNgw35IYUSG/LqY
         S5S5A1IJVXifQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230629074348.21670-1-trevor.wu@mediatek.com>
References: <20230629074348.21670-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mt8188: add memory-region support
Message-Id: <168916242315.46574.12917006493052835977.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 15:43:46 +0800, Trevor Wu wrote:
> This series introduces support for memory-region, allowing afe memif to
> utilize the region specified in dts.
> 
> Trevor Wu (2):
>   ASoC: mediatek: mt8188: add memory-region support
>   ASoC: dt-bindings: mediatek,mt8188-afe: add memory-region
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8188: add memory-region support
      commit: fd9965235099fc4cccd94f82a371192bf7645a3e
[2/2] ASoC: dt-bindings: mediatek,mt8188-afe: add memory-region
      commit: e3326e3bc4937622b4dc6e9721262483109b0f0c

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

