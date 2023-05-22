Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2D70C1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjEVPCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEVPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C5E45;
        Mon, 22 May 2023 08:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 348E1611B3;
        Mon, 22 May 2023 15:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7272EC4339C;
        Mon, 22 May 2023 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767700;
        bh=Xc3OzCNv/9TsT3QJ9kDtnyKbwIPScbTEJXYBLdYZLys=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ONMvJ9D+/l0QVG5Uozejv8p60mPpGJhdxa8xu+Gh8p0e/FWKitYy2iuWAEt0L8umB
         ux7+I6x2OheOxqVawzF4bgGzBj5i0Yp+wPIHS96lYxYXg97d53V1d8wrEvWK06mB6V
         Nq+PN0SPH+7g9OveZuabFAGRMzLOYUKYT05AyYDQFLsl4Q4t286q8C+gcWe9E9ggv/
         +cb48l97874K/01+bqAQXjkNWyrjdfGzjRJZTJkBMJMKTEmTzSyV8hN5mXpZOMGmyx
         XRpT4xm0r5y7QH/IrH/p6FEhNnYU9J0F/Qmd2kkbgKLbCsPqwDwbsensiwAFx0NeB7
         4T+TK+ZV+9L2g==
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <9b39a59f5829d200d7d1fac4e993dbf8ce05836d.1684578051.git.christophe.jaillet@wanadoo.fr>
References: <9b39a59f5829d200d7d1fac4e993dbf8ce05836d.1684578051.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: atmel: sam9g20_wm8731: Remove the unneeded
 include <linux/i2c.h>
Message-Id: <168476769819.849172.14698657660498994803.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 16:01:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 12:21:58 +0200, Christophe JAILLET wrote:
> This driver does not use i2c, so there is no point in including
> <linux/i2c.h>
> 
> Remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: sam9g20_wm8731: Remove the unneeded include <linux/i2c.h>
      commit: 8c03fd5fbd3e5a534675dffd5647166e919e1fc2

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

