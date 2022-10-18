Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC05602C09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJRMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJRMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655F72945;
        Tue, 18 Oct 2022 05:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B3961539;
        Tue, 18 Oct 2022 12:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F5BC433D6;
        Tue, 18 Oct 2022 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097126;
        bh=PSPwRfSOvvr8DnOP03iTih3cMwWsqZecmSWzS6DwR3w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pAiTI4eO+pubK4zW5itvpEfp2cpyuH+M0ZM5wa+e+n6J32opE7In7J8scptOOT0k9
         gxG2bH3ItXobCkAF7yPAajJKCE/Yudz786xm/OeNENF61AAhllLcUVf0vy9Nxk6vrP
         CdIh6SIgANMUnAl4z5LmLGS0spdYifnYfabe9ynJQky5oZqPCQ+Jj7pwEp4tSdjKXQ
         xto0adW94EY/g3wpJ5RyYessP6P3C2R50obIEiBPwcaR2EnQSkJ5SonBCG2tvo1n6J
         pWGAo2UsNzSLDni9YWqIy1ZnJMGa90O99mpNv8yEZIR1ixhYlLtt7nHY0gEx9U8Wdy
         2ZR0rqsfmUQHg==
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
Subject: Re: (subset) [PATCH v2 SPI for-next 0/2] spi: microchip: pci1xxxx: Load SPI driver for SPI endpoint of PCI1XXXX switch
Message-Id: <166609712567.385867.7300778836137490468.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 13:45:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
      commit: 1cc0cbea7167af524a7f7b2d0d2f19f7a324e807

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
