Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8779063C6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiK2SCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiK2SCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F346B39F;
        Tue, 29 Nov 2022 10:02:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E8761889;
        Tue, 29 Nov 2022 18:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727F2C433C1;
        Tue, 29 Nov 2022 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744942;
        bh=qKd9ymqAdWLp6B0pPm4UgjxLqG9aPy3nEPRIKquv6Gs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nRj829xdRrmMfjKBaa0SYOXHIVMI+fnAVfSA5NhPp4KXn9mqzM02mgqXRD3qwU0KY
         YwGRQN2jtNdWGPUIOlKTeNAaOr+qW/dGtH82XLFYO/u9GplHJy//dI0UndiCHueVrP
         N+D0EAL4YjXg5L4TVA7rWD3OeXpgoOmP0eFdvkF2WXXNOWOZ+y9pg+HFPDuDXGDQ7O
         sqkPCT5SRvA6q4K4Oh3i/k8AoRlOOjG+ya0f6COsyizgQb6vZZSfKDtUXhVic2+uLv
         vQr4ke8wRRq93Um7lGA/o9p9Fxo936PhNmSoUUJwIrZPhtyXq0t2zibeN64pW1Z8XD
         CQHu9QlNzZskQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
In-Reply-To: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v2 SPI for-next 0/2] spi: microchip: pci1xxxx: Load SPI driver for SPI endpoint of PCI1XXXX switch
Message-Id: <166974494118.343760.736502969260374198.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 18:02:21 +0000
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

On Thu, 6 Oct 2022 10:35:12 +0530, Tharun Kumar P wrote:
> Microchip PCI1XXXX is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch has multiple
> downstream ports. One of the switch's downstream ports is a multifunction
> endpoint; one of those functions supports SPI functionality. This series
> of patches provides the SPI controller driver for the SPI function of the
> multifunction PCIe endpoint of the switch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch
      (no commit info)
[2/2] spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX SPI driver
      commit: 7ba63521a1e9d8ca6fb55ead19e6e2b850b8fd80

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
