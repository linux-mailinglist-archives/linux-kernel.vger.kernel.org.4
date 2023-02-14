Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B6697223
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBNXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBNXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:53:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA37183F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F510B80D11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19901C433EF;
        Tue, 14 Feb 2023 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676418826;
        bh=4WoUrY6Uc2gfAUUAiirWjgNGe99aw9SA4Mtwq7niZ8Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hAQwWbbEXwqIrFrk1LzpQ8yncH41PYW0Vl5UU4NskAVwziw3nipP82lbzG8YwVS93
         ck9VwDWpwuKSOpLaHRStoftRyIpxZ/N96rkJ8cXyXqjCiC0N/Rb6GG+bZjmmvhq+1O
         wVgv9OoAJUVtvs40rauAttiqoXxqo8lMuhg29mPyQHmu2eR1yVbB+R0U/9Eq9XT9VU
         kDu6l+TE7adBGDrFNmaHZIYE8eo+HfcpqLrxAoI1Ezmkawj90NauG76q94nadKZr/t
         Zomj62SsrgfsODieUYq7BhkwM1Ax/Hyfl0+ryxponk2cCc3Cdh/nzibwd0QuEJNtIt
         9l2RgJPbuJ85w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230213161713.1450-1-andriy.shevchenko@linux.intel.com>
References: <20230213161713.1450-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-ac97: Convert to agnostic GPIO API
Message-Id: <167641882377.3290120.11896431193482772013.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 23:53:43 +0000
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

On Mon, 13 Feb 2023 18:17:13 +0200, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-ac97: Convert to agnostic GPIO API
      commit: 3ee0d39c50dca18c76941f46a6c57dc9cd2bfb9d

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

