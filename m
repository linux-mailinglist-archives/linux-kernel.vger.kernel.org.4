Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8E656A23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiL0L5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiL0L5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F22191
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB8761013
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF1BC433EF;
        Tue, 27 Dec 2022 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142233;
        bh=bCAcB9VxW/LzWbP5DjX8js9d6sLw1besip2FONIFpYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L5+FGEm8voYU29vY9fNgabZEJCVEFWuAVbyyadYJx/0C0ixtpvvUrDOuOIsGVD6n4
         ARG8MURgpIYGwC1fA+PXvBum+3XonMwKShNWTorz22KLDx6Fjb5+SnFuNVl9RCW6OX
         Ps35YyQbw4xIVyZku7WJ7CdNQq3Jf7zK+FRPaxAuAgBuVLfpVRLpC5F1Gd/VoOVkbL
         iCxt5w42d0LTW+lQTwATR6eFlst64hg9HLyVRtYj6DBUuALrFj7+w2lrHKOU1rnyGJ
         dtNfGXCM77vE9MteDh853qntWiaNmPXIS7ap6ee9UoQqutTpYIpiH9WdOGon4nwAEW
         olL8Lf5DjavGg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, piotr.wojtaszczyk@timesys.com,
        David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
References: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width
 to 32 when possible
Message-Id: <167214223069.82924.15530796438471486612.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 04:40:58 +0000, David Rau wrote:
> This adds the DAI mono mode support and set the frame width to 32
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: da7213: Add support for mono, set frame width to 32 when possible
      commit: c89e652e84f636354213aae42490c7f77a0eadde

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
