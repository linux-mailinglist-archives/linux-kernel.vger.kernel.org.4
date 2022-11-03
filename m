Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E476184DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiKCQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiKCQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:38:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27031E3EB;
        Thu,  3 Nov 2022 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AA61CE280D;
        Thu,  3 Nov 2022 16:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568BDC433D6;
        Thu,  3 Nov 2022 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667493302;
        bh=q7ZuiBfSSK/3SLO4Cuts6IhYxMrMmlbIl+qPVok+e/Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HMSLyNQ49eAar+p/pcxJIZGJtnqqPSY673uhjS8DEIGGcmmyUXu+oA44VnmZSFgEy
         7/z6DMNGBFQYlVfMjsojvvvkXyKXJ0uYSd6Hv7Rk+aBtH5rIzZbbFZ7lnsWonKE6fG
         5Fxx7FVIFS5E1mX9Ut6TvTPchOgD9jQWSlZXNiKz7f9PW4NNt7vZ8/4eKXhWS3uAE1
         9JcvdygOjjw5FouuxIMvLLAPgHDA3yXnL2Zrfdz7+GCQ/vnpI6G5H7hoGyi4Vhg6YL
         HyuFZFR4PlDz28UTBnwGCwddSdj2VWPSCxz7F8pn8YCLwZr1INrR8KbyBI5PMy165r
         //pQjW9yL+bog==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
References: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] arm: omap2: n8x0: stop instantiating codec platform data
Message-Id: <166749330105.480833.6115792719551136444.b4-ty@kernel.org>
Date:   Thu, 03 Nov 2022 16:35:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 16:20:02 -0700, Dmitry Torokhov wrote:
> As of 0426370b58b2 ("ARM: dts: omap2420-n810: Correct the audio codec
> (tlv320aic33) node") the DTS properly specifies reset GPIO, and the
> device name in auxdata lookup table does not even match the one in
> device tree anymore, so stop instantiating it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] arm: omap2: n8x0: stop instantiating codec platform data
      commit: faf3b5cb59f84e4056bd84f115a958bc99c61e65
[2/3] ASoC: tlv320aic3x: remove support for platform data
      commit: 426c7bf45f207ac7a962e012dd482f7aaa3a3d5f
[3/3] ASoC: tlv320aic3x: switch to using gpiod API
      commit: a984d8332d90afd2989e10b095ffdb2875d4bac8

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
