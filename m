Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DB72672E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFGRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjFGRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F372107;
        Wed,  7 Jun 2023 10:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7DFB63AC8;
        Wed,  7 Jun 2023 17:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46059C4339C;
        Wed,  7 Jun 2023 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158643;
        bh=cYyHhjd7PB7WUP/KYCYgStoS0XkCHcCe06gZhREDRKs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SlN5BX8koTm8zvZSbaFxw5ysu0owOydUNkknrYHn/0vtKYhMvz3XuuB/6X7p+o++m
         crxM1EUIYWyTs88YDmnS4lNb3iaKeSSv1GrRp8feUK9T7A7FfLnQ/Ou9T2ssm9AjK0
         Yzr1V8I7s2Jeaylq05uUNfpcKYZrkPjxnJIBIk8E8arpY7hhDWxkInQhmBsExwJBuH
         nEUg81dHELRCwJ92uQqO9O3pTEHSFsJVZ9rFH5lI0omvf7bF0itArdRHmHjVknUwo8
         KIP5u0tqGCVPwiPyGQqcFEjoYrVWL8hF9ViFAFmZXatcBLb7XQKCuoR8XkmbBm+bmK
         tFX0MyZq4OsFg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abe Kohandel <abe.kohandel@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230606231844.726272-1-abe.kohandel@intel.com>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-Id: <168615864200.61821.4077678656518358668.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 18:24:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 16:18:44 -0700, Abe Kohandel wrote:
> Remove a misleading comment about the DMA operations of the Intel Mount
> Evans SoC's SPI Controller as requested by Serge.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Remove misleading comment for Mount Evans SoC
      commit: 5b6d0b91f84cff3f28724076f93f6f9e2ef8d775

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

