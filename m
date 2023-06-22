Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D580573ABC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFVVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjFVVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89091FF7;
        Thu, 22 Jun 2023 14:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3985261900;
        Thu, 22 Jun 2023 21:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BE4C433C8;
        Thu, 22 Jun 2023 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470163;
        bh=j4qdFD+3+0PlgZp4aqw3U1mbhAvnjpBSujOcrKlPPV0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G5Avg96C/LwZWDpHLbHhYU74l5o1Wn722C2jiT/+AFtJ8qM0Ge/5h7UZGpom7xeUP
         LTQ1eY4N8EMAG/9mW5UXZc4kMIDvJMr/p9/A8cH0bi41peetFT8MZfpsl8jUhWA/UE
         I/rCgpRd2/uMmH5C7BFY/1TL4/KcE3M+Kj4hg/venSyTxiN+Rbt2SKoV0N0UwypJOj
         tWOVDncVKSpvIXOy2AmJ2sBB2Tyta6ERzuieHL/WzqEnoUCgmzJvRgveYQAjalNqJ0
         ujYiWgRPrb5Je61dMZoYjpCmTb+fDEEWSljVKMyuD8yz79ZK3Cvee4Xmaj3vJtb7Zi
         j5P3fJ3y9Vftg==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20230622082435.7873-1-johan+linaro@kernel.org>
References: <20230622082435.7873-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe
 failure
Message-Id: <168747016057.308826.7806530657100324752.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 22:42:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 10:24:35 +0200, Johan Hovold wrote:
> Make sure that the device is not runtime suspended before explicitly
> disabling the clocks on probe failure and on driver unbind to avoid a
> clock enable-count imbalance.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynqmp-gqspi: fix clock imbalance on probe failure
      commit: 1527b076ae2cb6a9c590a02725ed39399fcad1cf

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

