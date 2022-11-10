Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C462415E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKJL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:27:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFCE70577;
        Thu, 10 Nov 2022 03:27:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C0146142D;
        Thu, 10 Nov 2022 11:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57232C433C1;
        Thu, 10 Nov 2022 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668079639;
        bh=H7L8eU5xdL9u0Jd6RrhhVUB8QU6JlkkcKX42Z2x9pO0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qj/6/IDU7Y8snWCvvVIrp69nyF9vpSpTIkS5weVtw585GttL9CmVHQf3bFEGbRDyd
         FdPvLzWaKHQ9dqwxhmqXGMUsbUQkli6rb6RZXxjLKGQSrsXSrHzCZ0XWQ21wAvqpng
         bm7WNn7nJpxatkth4tsMj39nxQLiKWygWc4V4bFKlagSuBRQZMyEO9/Rf4rGf/43g5
         2KQxMH+qI19px1A4ao6jFh9z8ndykuYlVcIldx4kC4uUmY+nPJUAyUaws4qjW5H8Pe
         Xye1oDIJKgOOi6AOzy+xJ5W93ipwM3cw3GKj8vSTLULlfu8gVxIQK2+wM8d496g1B3
         e4vcL2GFsVmcg==
From:   Mark Brown <broonie@kernel.org>
To:     Zhichao Liu <zhichao.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221110072839.30961-1-zhichao.liu@mediatek.com>
References: <20221110072839.30961-1-zhichao.liu@mediatek.com>
Subject: Re: [PATCH] spi: mediatek: Fix DEVAPC Violation at KO Remove
Message-Id: <166807963802.164080.11001757867052909901.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 11:27:18 +0000
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

On Thu, 10 Nov 2022 15:28:39 +0800, Zhichao Liu wrote:
> A DEVAPC violation occurs when removing the module
> due to accessing HW registers without base clock.
> To fix this bug, the correct method is:
> 1. Call the runtime resume function to enable the
>    clock;
> 2. Operate the registers to reset the HW;
> 3. Turn off the clocks and disable the device
>    RPM mechanism.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: Fix DEVAPC Violation at KO Remove
      commit: 0d10e90cee9eb57882b0f7e19fd699033722e226

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
