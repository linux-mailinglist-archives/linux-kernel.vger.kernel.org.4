Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8229C682F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjAaOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:32:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DE14E8F;
        Tue, 31 Jan 2023 06:32:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 299EEB81D1A;
        Tue, 31 Jan 2023 14:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2DC4339B;
        Tue, 31 Jan 2023 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175552;
        bh=64JB2TqJHzbLRcbZWFRXHWsvB96LNMCT5mLL4Q289KM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HdOdDy41bNSQS0D13xoGvq2nqSCY58YUlYwSBwkqpU5VesgzTW02x4/oVKsRqZA29
         ZF0KpYVcSzC7zEqj/rIukYg6cKMQW/vvnCE5W6Mefi3hZ+6ldLimiV19BA9BWN3kyu
         IVMJwGwG/kXJ5u0noasMfcfV5KO//nwJL62AsGAOaUFI+iTmQw9K+0t6Zs/empjRqB
         r22fg4OcfhLMZJFb5AZoJAWpF9c8vKzCbRkfbQKPtUTnfGi06axPUwuwnbgF2LK5Z9
         c+CdJg2pzje64YtAQwfAcOQ4eaHdIVNh5Y8kQtLtHhX2Oy8XRRPcawMx90TCP+4drh
         9mzl+Rugp5Wqg==
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
In-Reply-To: <20230126085137.375814-1-herve.codina@bootlin.com>
References: <20230126085137.375814-1-herve.codina@bootlin.com>
Subject: Re: [PATCH v3 0/3] Add the Renesas IDT821034 codec support
Message-Id: <167517554994.691025.8617744298241053162.b4-ty@kernel.org>
Date:   Tue, 31 Jan 2023 14:32:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 09:51:34 +0100, Herve Codina wrote:
> The Renesas IDT821034 codec is four channel PCM codec with on-chip
> filters and programmable gain setting.
> It also provides SLIC (Subscriber Line Interface Circuit) signals as
> GPIOs.
> 
> Based on previous iteration,
>   https://lore.kernel.org/linux-kernel/20230120095036.514639-1-herve.codina@bootlin.com/
> this v3 series mainly:
>   - Fixes _put() methods
>   - Introduces and uses idt821034_2x8bit_write()
>   - Removes the '#if IS_ENABLED(CONFIG_GPIOLIB)' conditional
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: sound: Add Renesas IDT821034 codec
      commit: 545679837eef1819aee3868fbb9dfced9a56de02
[2/3] ASoC: codecs: Add support for the Renesas IDT821034 codec
      commit: e51166990e81754d2cd30593558c3ff47fa49f15
[3/3] MAINTAINERS: add the Renesas IDT821034 codec entry
      commit: e60259f77c46a6b4733b20f1fb44547d67302c67

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

