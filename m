Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9A6AC049
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCFNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCFNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:05:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927042CC79;
        Mon,  6 Mar 2023 05:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2676BB80E12;
        Mon,  6 Mar 2023 13:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1632C433D2;
        Mon,  6 Mar 2023 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107909;
        bh=L07RTJbrKjWuJzJM7jAJ2AmwxHqo6yPoUKpEiAg0F1E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=isuTMRMgyL9/JV1o1R3OBQxrwRF29OQnnPRQLKpVPMeTk2hcZw6v7oS0WIb+fYllB
         pNwQLr93t/04mo5GMVcmKuyOQv8L6JeleH5Ib9ncNaBXwnPXUx/3ikjikFmJoKwqkU
         XciogeznuDfv16r27XYIM7vuDW2sJY7lBKSJ1ilHlYlgr4VmHrkICxPl0Y8VPxJ3Xj
         ZUwmG7jcscQrXdq62qGxjMhXt/UJsmdO0SPhWos/gY9LqM5Wx3zAUVjTaPY2gnI8tr
         Y//FnD9Dch0FK9Yr4VtE+2EZuBEY/K2PzZ7tBvZMiPuztdRfPfCYBB3yiRP87NDQxj
         gJ5uNLl206/Jg==
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230228023243.118429-1-jiapeng.chong@linux.alibaba.com>
References: <20230228023243.118429-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] spi/bcm63xx: Remove the unused function
 bcm_spi_readw()
Message-Id: <167810790851.67440.1294335535578166435.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:05:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 10:32:43 +0800, Jiapeng Chong wrote:
> The function bcm_spi_readw is defined in the spi-bcm63xx.c file, but
> not called elsewhere, so remove this unused function.
> 
> drivers/spi/spi-bcm63xx.c:160:19: warning: unused function 'bcm_spi_readw'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi/bcm63xx: Remove the unused function bcm_spi_readw()
      commit: f58ab0fa7a23e5e1f55c0c1df266bb0daf1c19cc

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

