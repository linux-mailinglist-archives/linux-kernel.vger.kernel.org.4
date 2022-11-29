Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296763C8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiK2TvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiK2TvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:51:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF1C48;
        Tue, 29 Nov 2022 11:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2FA8618C5;
        Tue, 29 Nov 2022 19:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4961FC433D6;
        Tue, 29 Nov 2022 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669751479;
        bh=Zh5WynhP+o4Gea28pjoNeKDMumUYpiocGMUapD80TLA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M6BMX69MohUyLJH7EKV6t1XgGJnmdjJFZ9e8eWCe84FLtqYFQ2db8tZRD4atpkyCq
         FgX5OYIEjQeGmdW3ACW4hzN3U86knKobYnP6VcWVkjyKTgSZGnkmdT6fhsp47ephvp
         Gi8pzDM/yWDZGpb2hy8Ro5ZwOgwWdQUZxUm2xHeRk6cL+tpdmkMPfv40cFxXqeQswv
         ys7FMmK/YchvQLNbhvRm480jL+FfyeuJGhOZ+1h7HcG0PEYeAlHeeqkPm/0wxwVTS6
         dPj9eRpxlnXFJiWQzQUg+pRoPxCm8dX98qR6rwAOh/J0ScZXedNJ5ggiWVEMbd0tCf
         VKiAlXSKf5yng==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20221128164147.158441-1-nathan.morrison@timesys.com>
References: <20221128164147.158441-1-nathan.morrison@timesys.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Add minimum operable clock rate warning to baudrate divisor calculation
Message-Id: <166975147801.395913.7712035443734225881.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 19:51:18 +0000
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

On Mon, 28 Nov 2022 11:41:47 -0500, Nathan Barrett-Morrison wrote:
> This Cadence QSPI IP has a 4-bit clock divisor field
> for baud rate division.  For example:
> 
> 0b0000 = /2
> 0b0001 = /4
> 0b0010 = /6
> ...
> 0b1111 = /32
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Add minimum operable clock rate warning to baudrate divisor calculation
      commit: f8fc65e50ad71c139a12a96e64eeba5005e491d5

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
