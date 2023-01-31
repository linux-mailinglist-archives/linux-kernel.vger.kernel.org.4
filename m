Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273E682F52
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAaOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjAaOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:32:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62A1CAC3;
        Tue, 31 Jan 2023 06:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3980ECE1ECD;
        Tue, 31 Jan 2023 14:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D977C4339C;
        Tue, 31 Jan 2023 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175557;
        bh=2uYCh2/FOYcNFdrQcKG7GGaUjzJYkNSFsVUKdKLj194=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hhw12d43bmcKC3lLIMV8Cnp2IVPybOeJGG081nDliunlXO0F4LoNzW8KWdlu+SO2V
         ZLMc+mDK/re8jyw1p5cLjbuIza/gKeinnd73nh9cR1WK3GKcG+1n1u7Uld4Lef+DjZ
         JGw8C8QIcNGacaFgtn8bIdzgaIe2Bppig/E8OlYJTmEy4tRPK6bC2QEZyJDvsO1uiG
         c6dXDjpYUCWvxiRpZQ/+5AkgdBoAv0chtw3ouSIv7wPJlvl5Au7Lt7fEBJIZYUVcR+
         LNEXYiRnCe2cnSfbRoP5jct70R0Dnfytk1NOv69fDW6JKA8Ke17wRUFx/ITuV7Fo5R
         h1RYvJoQns0Fw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, jonathan.albrieux@gmail.com,
        povik+lin@cutebit.org, 13691752556@139.com, shumingf@realtek.com,
        ryan.lee.analog@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweidong.a@awinic.com
Cc:     liweilei@awinic.com, yijiangtao@awinic.com, zhaolei@awinic.com
In-Reply-To: <20230113055301.189541-1-wangweidong.a@awinic.com>
References: <20230113055301.189541-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V10 0/5] ASoC: codecs: Add Awinic AW88395 audio
 amplifier driver
Message-Id: <167517555317.691025.7198905748945109915.b4-ty@kernel.org>
Date:   Tue, 31 Jan 2023 14:32:33 +0000
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

On Fri, 13 Jan 2023 13:52:56 +0800, wangweidong.a@awinic.com wrote:
> The Awinic AW88395 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert
> 
> Add a DT schema for describing Awinic AW88395 audio amplifiers. They are
> controlled using I2C
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: codecs: Add i2c and codec registration for aw88395 and their associated operation functions
      commit: 62fc25fbab5f416372b2890de313e38bec75b61d
[2/5] ASoC: codecs: ACF bin parsing and check library file for aw88395
      commit: 4345865b003be60fed335efbed5aee61aac86da0
[3/5] ASoC: codecs: Aw88395 function for ALSA Audio Driver
      commit: 06d2fe9cb42354e9910b1305ec984d0de7225f3e
[4/5] ASoC: codecs: Aw88395 chip register file, data type file and Kconfig Makefile
      commit: 14bd857286115bab1e7860ab6e30016b0cae8233
[5/5] ASoC: dt-bindings: Add schema for "awinic,aw88395"
      commit: f88b6c0c070ea9b1fcf9d042d77ce8af62a020cd

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

