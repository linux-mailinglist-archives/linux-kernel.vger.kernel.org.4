Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76126AC042
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCFNF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCFNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:05:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF22BF35;
        Mon,  6 Mar 2023 05:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84CCEB80E01;
        Mon,  6 Mar 2023 13:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D76C4339C;
        Mon,  6 Mar 2023 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107908;
        bh=OghyAkHZ8D9HZmMpoa0v/9iX86xt6+klLkfBOwrcJG0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NR8vZXkdjdOp9dD1NudUo0rD4s0c8EnY7pPxWhaERNjkusKmebYO7UuvVZjIwFvrd
         ML8D15uVMB3I0z5Gin48a+d8IOfvZFf2fb+6trqXppEbjnCX7C/CjeCQM0VZFZPELT
         Y6YfjvNLgD0flQyWwVCgNpLgNaPfx1pcKBKnsPkf3O7HDGaermuZliTZ2ylR08/8KS
         RN2lGJzn8TBB/aNKaLzUzkIam6FMl7BJHRgwL9Z1tiBzrGAs2SzFMsqsjRs1W4Oncz
         Cba2NC61xuLuNLhDrvADySk0bmEl8mB5YAmoS560zSBu9hm4sWpyg6yQsCeP1ibzQy
         2Phjd8LjOs77Q==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Lizhe <sensor1010@163.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230226063334.7489-1-sensor1010@163.com>
References: <20230226063334.7489-1-sensor1010@163.com>
Subject: Re: [PATCH v1] drivers/spi-rockchip.c : Remove redundant variable
 slave
Message-Id: <167810790680.67440.3385806296650040534.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:05:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 14:33:34 +0800, Lizhe wrote:
> variable slave in spi_alloc_master() or spi_alloc_slave()
> has been assigned. it is not necessary to be assigned again
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers/spi-rockchip.c : Remove redundant variable slave
      commit: 8c220e6c6da9c2f70a78ba8b3121893b3634a54c

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

