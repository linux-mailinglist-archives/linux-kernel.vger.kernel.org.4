Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC57370F53D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEXL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEXL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A5B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3051B61A90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB3C433D2;
        Wed, 24 May 2023 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684927694;
        bh=7Q2toi92kbc3u6MrXrJck4rE1II3ijn0ylZFuZ8InwA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iUKGc7rr6VMrE0d3hPc03v/qzZocxq2fzPdwFK+cQZZlL6vsLPB6vvS4XJ1rAsdCc
         eIFYUXwuH4OPNnhX4/GbLa1y7WMm2r1+WkOX7PjoL7g9ejW8AfVSWfbesHF9cjlbfq
         P/mXAhxwTiIQQ8O8IbIfgI7IZM5Qc+wkXkq3k64nRXqsrONojUxnfRHLfaMpTSnDkE
         KruzlueoqeUh2ApIbLR6tWGZnfB06z2JsuyF3UHMuSRH0bA1Akl+N4ar/mKtjVcHPs
         pKhNLiFy+aRjwEZdRo0bj3r2JwIOJcys2CWVT3myYx6rixCJAQshHYLOR+HT9neG8g
         ppJFxrzaf4BNA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230523165414.14560-1-srinivas.kandagatla@linaro.org>
References: <20230523165414.14560-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x-sdw: do not set can_multi_write
 flag
Message-Id: <168492769255.49784.5898976665110689198.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:28:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 23 May 2023 17:54:14 +0100, Srinivas Kandagatla wrote:
> regmap-sdw does not support multi register writes, so there is
> no point in setting this flag. This also leads to incorrect
> programming of WSA codecs with regmap_multi_reg_write() call.
> 
> This invalid configuration should have been rejected by regmap-sdw.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag
      commit: 2d7c2f9272de6347a9cec0fc07708913692c0ae3

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

