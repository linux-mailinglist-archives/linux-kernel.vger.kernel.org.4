Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2D731803
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjFOMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbjFOL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7DC46B5;
        Thu, 15 Jun 2023 04:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE39563BAA;
        Thu, 15 Jun 2023 11:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63DFC433C0;
        Thu, 15 Jun 2023 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829425;
        bh=5JvhsHdlFO6uqDaCCOGfTLYM66GpGTSOOML6ozcw+1k=;
        h=From:To:Cc:Subject:Date:From;
        b=r74O5qpXU2bmsetDnlwT+PfaTswOh98qvPI3QwQwbiNdQ6TgitGUd62/ATKoDezs2
         1jLlFQEiKnaCFI/igtRHXNHY8q53LSV4iMgQxU5XDFtjx3nh09mi1CxUAVyNMLAh1Y
         61UbdgomisBqlY8ToCfQty9Yl2Fkuz+NbEvmtb/qgzi0inSHXLpb3HWmji8FbJwwGP
         19XLZ2ZuHUx+G8LMHYtghKd69CjQA9zchPXkKlb4KhSBBMJpxrEzCXJUe2Divl5cPr
         0TQHXRHuxGr/8QFkvHcGIdCqxz9pPUFgc4mbe8ym9omUXjFYcxInfbsZLaE8jpRmKn
         vvosY+yf2zMxw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.4-rc6
Date:   Thu, 15 Jun 2023 12:43:36 +0100
Message-Id: <20230615114344.B63DFC433C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0c331fd1dccfba657129380ee084b95c1cedfbef:

  spi: qup: Request DMA before enabling clocks (2023-05-30 13:43:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc6

for you to fetch changes up to eee43699217504ba69cadefc85c6992df555e33f:

  spi: dw: Replace incorrect spi_get_chipselect with set (2023-06-13 20:19:26 +0100)

----------------------------------------------------------------
spi: Fixes for v6.4

A few more driver specific fixes, the DesignWare fix is for an issue
introduced by conversion to the chip select accessor functions and is
pretty important but the other two are less severe.

----------------------------------------------------------------
Abe Kohandel (1):
      spi: dw: Replace incorrect spi_get_chipselect with set

Jiasheng Jiang (1):
      spi: cadence-quadspi: Add missing check for dma_set_mask

Vladimir Oltean (1):
      spi: fsl-dspi: avoid SCK glitches with continuous transfers

 drivers/spi/spi-cadence-quadspi.c |  7 +++++--
 drivers/spi/spi-dw-mmio.c         |  2 +-
 drivers/spi/spi-fsl-dspi.c        | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)
