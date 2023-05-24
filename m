Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209570F4C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjEXLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjEXLEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C5139;
        Wed, 24 May 2023 04:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6C463BB4;
        Wed, 24 May 2023 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59352C4339C;
        Wed, 24 May 2023 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684926280;
        bh=GfEdRggy70yOYOmTVWXCzkNUIVN0jEnSSB4Wfj2XyoQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OxKluKiYtrKaPA3O6OyE8thgwPRPxDjUj8bTJIp/03oQnnX/UswXhKhhfisFcWRlz
         4rqCqUhOEh34tVyhci9nj/oqED6sLLTxw5XOEJei5pZNycrCR0PpEx54I1cQIhmhOP
         9LRfJ6xVFSO0jvMu8cJIGNLrqCdLQm8CSR1Q2LVDc9VRIAlH4s6gEjfs4TaGYRuqiR
         1sz+yqUwI4iZ1tg2Jqy0PZe2kmic8AZfajyQ3zyb4UDEB3SgBFg+X1DCF3UixwDTsw
         12nDlQpybc8qUZGtgj6/qtdLPVFd4pM/qpEcvVXjHle5L3mKmdOk/FZKYJopbPv4hI
         VXVxv3rz+gC+w==
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
References: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Message-Id: <168492627908.37394.4174459869855337737.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:04:39 +0100
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

On Fri, 05 May 2023 14:35:57 +0800, Clark Wang wrote:
> When all bits of IER are set to 0, we still can observe the lpspi irq events
> when using DMA mode to transfer data.
> 
> So disable irq to avoid the too much irq events.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: disable lpspi module irq in DMA mode
      commit: 9728fb3ce11729aa8c276825ddf504edeb00611d

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

