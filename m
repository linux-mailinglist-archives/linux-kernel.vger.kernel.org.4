Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA54763F053
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLAMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLAMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:20:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87034AB00D;
        Thu,  1 Dec 2022 04:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D738B811A6;
        Thu,  1 Dec 2022 12:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB57C433D6;
        Thu,  1 Dec 2022 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669897225;
        bh=F7zqOw0jJ/Nulpp5bHFkrjmu9lFcyY+4CTQDaz3Zncc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iUv6h29IqmpsP8xuOOP3PP+owvdFwfHn3EXUS63B6TiisnVK/mjjrLeJrxhzHi+IE
         auPC9SsSuessmasy0yV+xaW5IKUkA8MRFZpZBasrHFFCcLZVaWOJ2V889dUbUzRV22
         /cYExrNHX1Y7/gWps5iforXK+oou6Ynv6pfplavAWWsnHfo2yJ9KtsEAAfy/Fls+t6
         8SAaBKe7ktNz2WQXJSFi9aFeeQKFHgZEc5pGLsfm2eZ5s8Ojr7JVP0YLktICt+X0bK
         AJEV5WDWMIDqQ70Xm2VA+cHAbYBgUeuoCvYbOhbZgOWzVBJpD/0yslt5sLEKdbILdl
         g0LgA0EriK4gg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
In-Reply-To: <20221130162927.539512-1-alexander.sverdlin@siemens.com>
References: <20221130162927.539512-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Message-Id: <166989722460.51770.10306865955745986625.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 12:20:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 17:29:27 +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> has changed the user-space interface so that bogus SPI_CS_HIGH started
> to appear in the mask returned by SPI_IOC_RD_MODE even for active-low CS
> pins. Commit 138c9c32f090
> ("spi: spidev: Fix CS polarity if GPIO descriptors are used") fixed only
> SPI_IOC_WR_MODE part of the problem. Let's fix SPI_IOC_RD_MODE
> symmetrically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
      commit: 7dbfa445ff7393d1c4c066c1727c9e0af1251958

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
