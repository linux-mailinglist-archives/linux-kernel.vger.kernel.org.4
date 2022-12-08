Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB722647091
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLHNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:14:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575E6F0DF;
        Thu,  8 Dec 2022 05:14:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3B661F15;
        Thu,  8 Dec 2022 13:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD5C433B5;
        Thu,  8 Dec 2022 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670505267;
        bh=Eyjqsy/poZbmtld0z1O67wMazI0L2vkuP340AZ0o2T0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bg4ZOmKdgdzm0qRkMh/rwiOdVa7vvHVEDjaNGvZNDiDOJHgI4PMFmo2jO1VnvvAce
         GmtpJ3IPqCuXTyUNJ+CIHIprcByqFuQqfvMTb6DmdX1Yjf561CLQb7qZwwHrr4Iyw2
         ZuASbbC6FzUfFsU8b82yK0PHcTdSiWd+d3NbNbkjtUkEeEEGRORdi48g3ywDSZuhLK
         d9QeJca8mnkKW5v/bfbjO5lvklOJBRzaBa3a4uPEadUikLAMr73RKgGPGL4w0BlpBA
         6c31Eb/cnYTmYR7j6trwTTHCgQr0XK3eZdkg9g4N62orY7uJA4mvvHc7hKTQacR6ga
         4O/++nRI6tHmA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org, mark@embeddedTS.com
In-Reply-To: <20221207230853.6174-1-kris@embeddedTS.com>
References: <20221207230853.6174-1-kris@embeddedTS.com>
Subject: Re: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE mode
Message-Id: <167050526663.166799.12502400746209838565.b4-ty@kernel.org>
Date:   Thu, 08 Dec 2022 13:14:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022 15:08:53 -0800, Kris Bahnsen wrote:
> The addition of 3WIRE support would affect MOSI direction even
> when still in standard (4 wire) mode. This can lead to MOSI being
> at an invalid logic level when a device driver sets an SPI
> message with a NULL tx_buf.
> 
> spi.h states that if tx_buf is NULL then "zeros will be shifted
> out ... " If MOSI is tristated then the data shifted out is subject
> to pull resistors, keepers, or in the absence of those, noise.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE mode
      commit: 3a6f994f848a69deb2bf3cd9d130dd0c09730e55

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
