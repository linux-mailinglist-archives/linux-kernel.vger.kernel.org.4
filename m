Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD59A6D7DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjDENno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbjDENnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42C4EDB;
        Wed,  5 Apr 2023 06:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7402E63934;
        Wed,  5 Apr 2023 13:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355C9C433EF;
        Wed,  5 Apr 2023 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702215;
        bh=a6D1/C9xh0GVKI3TzCX4vOSGQru+VCh8pQIGVOBsrfg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hzwpA2I5Sv0agBnsSI/SK73o88aZlgsD+l0NbVcRTynODk6QFFX/CbneA9p6J0W2c
         9gof54tk+0YlyoAJR29ec4fsH/vbaqMFDNqmoZccld+1dQsLFw1juq99qvSFCxdVIn
         GnZSn16yXjoqpygmdjX2nzZ7uV9asKl7sCwHysRScnOBuGpILFKb50yr+1EW+6m6sO
         MEvJtYBHCbtOZ0Q8QPNHj8ig++80SodDFIVd1F4d9APa7hpH7DO0JdR9LgRpxHYvxL
         St3js+Dxv3R5fZuEJtJPFEdjp+bc86v8gJpRdOl2KdGhP/tQYm1XsUCIeYQlRaBRqF
         KHipfroK712wA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
References: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH SPI for-next 0/3] spi: mchp-pci1xxxx: Fix minor bugs in
 spi-pci1xxxx driver
Message-Id: <168070221494.64941.1088443931679332208.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 14:43:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 22:46:10 +0530, Tharun Kumar P wrote:
> This patch series fixes the following bugs in spi-pci1xxxx driver:
> 1. Length of SPI transactions is improper
> 2. SPI transactions fail after suspend and resume
> 3. Incorrect implementation of pci1xxxx_spi_set_cs API
> 
> Tharun Kumar P (3):
>   spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in
>     driver
>   spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and
>     resume
>   spi: mchp-pci1xxxx: Fix improper implementation of disabling chip
>     select lines
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in driver
      commit: 35c8c5e503a82e0a4bf251d32096211eba8c2be6
[2/3] spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and resume
      commit: 4266d21669de62cf3fb6774f7d404c1eb95a5ab3
[3/3] spi: mchp-pci1xxxx: Fix improper implementation of disabling chip select lines
      commit: 45d2af82e0e6f662d0d0db20993b35cb1d8da646

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

