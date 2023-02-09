Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D2691061
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBISgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBISgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7E68AE4;
        Thu,  9 Feb 2023 10:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29859B8227D;
        Thu,  9 Feb 2023 18:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141E7C433EF;
        Thu,  9 Feb 2023 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967791;
        bh=KJFYdKEwIQ4c63KYJlEOv6bHkZ40qvZiPlbsQ4nPPMc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=keTcFSJDyJWxI188DJ9zkzk0OZOjkllBpCgxCYXP73ogRTdu2nl3DdKqYia3nQoj1
         66Hhmjr+RDnThjZW8oTuchniDteXnuiZ2HAxTdcU0Ex64GI5l5aYN9zzVPSWM8Du3n
         4RAeh+wrzhMCpCJZ/3ecw9TDOVrB0KjvKJRK/xigHzuJSv3gd4V+RsCfuseVEz6Blc
         qDToSqGR6x43J9rowSP6GW5Mw8HnILSWWZMNsFV4eqISMo/SN9R3JI6cdAUVERZSv4
         BhgUlCEl7SbxJQPmH6yFuERuSohBPngTSmBvOD4NABczjtlatlbL7JdhcywdPNb/wa
         YYeoCgfOoYc0w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Herve Codina <herve.codina@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20230206144904.91078-1-herve.codina@bootlin.com>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
Subject: Re: [PATCH 0/3] Add the Infineon PEB2466 codec support
Message-Id: <167596778880.879652.18301706233837933352.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 18:36:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 15:49:01 +0100, Herve Codina wrote:
> The Infineon PEB2466 codec is a programmable DSP-based four channels
> codec with filters capabilities.
> It also provides signals as GPIOs.
> 
> Best regards,
> Herve Codina
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: sound: Add the Infineon PEB2466 codec
      commit: 4c03e952ad8688a28aed9b72fc48291240707c7d
[2/3] ASoC: codecs: Add support for the Infineon PEB2466 codec
      commit: 227f609c7c0e44f2103a8406ff9379ee1de3bc28
[3/3] MAINTAINERS: add the Infineon PEB2466 codec entry
      commit: 564972dbf85c0900521e6273b772fd7f0b720dd7

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

