Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12DF6FFF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjELET1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbjELETX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9A59C5;
        Thu, 11 May 2023 21:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D0B64F9C;
        Fri, 12 May 2023 04:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BF5C433EF;
        Fri, 12 May 2023 04:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683865161;
        bh=pOZbnJl8r8gHWfa3pqqiUm1S+B7OMakCGn2d4dZvCoU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pE24LKm/33zgEmXHsp5jR2W1CupiN4PRPoY2nWbhJm8qsSrYjFf4h5CSmbHAuzEcw
         ta098JtkQMfGRHaiHCy4Fp4GfqnrQ46icDTYeEYWdAsLEi1XuSgfZc7T67tNLfpixD
         YSKejsY0XiAuynBqGMsKfAP5veBsTZOq5RoTtgR7Cz307iXzxDtBOqhMpX9jnkwhfk
         Yi/pPpy60eaAHb32jcyjyeZoZNNj7i2B9kNTVZEimZ9GzCbtBpPOMWQrJY0qjkAmPY
         Hz3xXXfgVgvHMteN9NA+mCnZ/9mjYm9dn2jGBrVb8AY5Nd78iH2Ps0IOooVDeLr4PS
         4ts9s538/cvnw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org
In-Reply-To: <20230508113037.137627-1-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
Subject: Re: (subset) [PATCH v2 0/7] Add Chameleon v3 ASoC audio
Message-Id: <168386515687.352974.4085648718798860469.b4-ty@kernel.org>
Date:   Fri, 12 May 2023 13:19:16 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 May 2023 13:30:30 +0200, Paweł Anikiel wrote:
> The Google Chameleon v3 is a device made for testing audio and video
> paths of other devices. This patchset adds support for ASoC audio on
> this device. It has two audio sources: HDMI audio from the it68051 chip
> (RX only), and analog audio from the ssm2603 chip (RX and TX).
> 
> The patchset adds the ASoC platform and codec drivers, as well as some
> changes to the existing ssm2602 codec driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[7/7] ASoC: ssm2602: Add workaround for playback distortions
      commit: f63550e2b165208a2f382afcaf5551df9569e1d4

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

