Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF4745F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGCPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGCPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ECCEE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 995B360F95
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B86DC433C7;
        Mon,  3 Jul 2023 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397291;
        bh=PLvNuEteQNzOZzBeGfr+Rrqy6OPYhROvqa4+UpbkGxY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=noMGficfSsyvDeFCUC1T4QBfqgzvnp9kulEe1CGdq93kNkIBQRQoiRzbeiUIevdhS
         xt8bWqqdEp/HdZKNH4gWdux70xgXBII8BfvlvBt0oNLL8Az3bIS+gXJ7DKhArZU15h
         8Y2myGEZXZYHdW8uk29tC4c5hpzA5hASlDFQT+UpRYMLTAZ6MuSfcETxkoPPmxDT4o
         6Gb0wMhTQo4+nXK27nMF04b7gsnqTwkhG6R9psGjn0AGfZ6/eualGEr3l7J1AE2BeP
         Jwi3X31xA0E7d7XWcvFZ+2Y+VJpZuMCGHpWdRbTlya3IrCWQ177MDN1nvv0GJY+EGH
         /TJ5a+1DMCZTg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: codecs: wcd938x/wcd934x: loglevel fix and
 cleanups
Message-Id: <168839728919.111324.17012721479110142993.b4-ty@kernel.org>
Date:   Mon, 03 Jul 2023 16:14:49 +0100
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

On Fri, 30 Jun 2023 16:27:12 +0200, Johan Hovold wrote:
> When investigating a race in the wcd938x driver I noticed that the MBHC
> impedance measurements where printed at error loglevel which is clearly
> wrong.
> 
> Fix that, and clean up the logging somewhat by using dev_printk() and
> addressing some style issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: codecs: wcd938x: fix mbhc impedance loglevel
      commit: e5ce198bd5c6923b6a51e1493b1401f84c24b26d
[2/5] ASoC: codecs: wcd938x: drop inline keywords
      commit: 5db9fe9562aaefca3c972401a9e3d6454707b1d5
[3/5] ASoC: codecs: wcd938x: use dev_printk() for impedance logging
      commit: 17d59d9ed832742f9572fe5e77ed3a66f5ae404d
[4/5] ASoC: codecs: wcd934x: demote impedance printk
      commit: cb7d60ab98cfe12fdd6052142176d42682f78540
[5/5] ASoC: codecs: wcd934x: drop inline keywords
      commit: c93723ada378a63929b3135b4f30483383e88e05

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

