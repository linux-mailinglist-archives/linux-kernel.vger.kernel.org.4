Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51BD6DFBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDLQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA47D93;
        Wed, 12 Apr 2023 09:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23AD62B3B;
        Wed, 12 Apr 2023 16:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3332FC433EF;
        Wed, 12 Apr 2023 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317964;
        bh=Tohg6s7+JjvB3RiYG35J6zVdNVihgjXUMfV960KM7zY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RoxFdwwymHwpM5F/yy8FcECFTt38OY35+nCUKEkic6RVp4F/8dvwH8RVR5q7bNrbz
         Zn7y45cJp3bMx3XKB/Of7m0BU/YxfPslsgJZngg/gJaMjBV7Lzsmun3tc7uIaNbPye
         jDmvYbPTdqjL//GkagcIptAXWe0iBURxin4R+rNruCTKRM1ztL1FX2t0il6/RnpYa1
         z8aGGCmLg8/wCLJZ8vhVXtu461twbp9DmZ1aQJ8rmzphqZS2oX1SGs7nhQQoUxNIAc
         lrszc0T0lhr93eCVgxvTUK26ext8O7leHDQvKHsMlRCKlw69o5EVZYXTn0YMp7offi
         AtNXzKs87kuIw==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
In-Reply-To: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
References: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: ep93xx: Add I2S description
Message-Id: <168131796075.93781.2447305389436776199.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:46:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 00:29:57 +0200, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
> controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: ep93xx: Add I2S description
      (no commit info)
[2/2] ASoC: ep93xx: Add OF support
      commit: b599a4d7d905a8e8cf5c36ccae0b3dd97c956075

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

