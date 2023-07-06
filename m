Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877EE749F37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjGFOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjGFOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCED173F;
        Thu,  6 Jul 2023 07:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC0361984;
        Thu,  6 Jul 2023 14:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF70C433C8;
        Thu,  6 Jul 2023 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688654487;
        bh=SSj2jL7JgcDOVRuXRYICBKor3PuPJrHSGUslhat/an8=;
        h=From:To:Cc:Subject:Date:From;
        b=MZASUC7xBWQpjVmnNV9hb7rEn3O15lzfmVov7OGMPITHEOa/1yfZjFw6LvA3Uz2oC
         gd1c+YzHxzGD4DrJnUsXqb/P3AZvxdmVHeSjGggNmiuVlhv2YCqmgoLDHC67gzU7Zu
         3l+KE3/srcEYvVR96khUTzwml1oxbO+C08Qzz8hwj5qQ4d8J9RV1WjDmyYno7UgawE
         PqfekW8FDuRO0RWmsLS+0IlLJ32GNw8BG2eLplrRw0l6RrnJREUoEI5PcWwyvKEm4k
         KiwLUrLbovCsabjuctkacYiIMR4exatISxBSCC3/5UuFMtts953EmG+gFpCC6bNPZr
         o4MXKEmWhu00g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.5-merge-window
Date:   Thu, 06 Jul 2023 15:41:15 +0100
Message-Id: <20230706144126.DFF70C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e884a133340a470070b2c59833c9ff87aa6517ba:

  spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible (2023-06-24 12:25:34 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-merge-window

for you to fetch changes up to 879a879c216a41f5403d8d3dbc204a48501912bf:

  spi: bcm{63xx,bca}-hsspi: update my email address (2023-07-04 13:54:19 +0100)

----------------------------------------------------------------
spi: Fixes for v6.5

A few mostly minor fixes that came in during the merge window, plus one
administrative update for Jonas' e-mail address.  The spi-geni-qcom fix
is more major than the others, fixing the newly added DMA support for
large reads which trigger DMA.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode

Geert Uytterhoeven (1):
      spi: rzv2m-csi: Fix SoC product name

Jonas Gorski (2):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      spi: bcm{63xx,bca}-hsspi: update my email address

 drivers/spi/Kconfig             |  2 +-
 drivers/spi/spi-bcm-qspi.c      | 10 +++-------
 drivers/spi/spi-bcm63xx-hsspi.c |  2 +-
 drivers/spi/spi-bcmbca-hsspi.c  |  2 +-
 drivers/spi/spi-geni-qcom.c     |  6 ++++++
 5 files changed, 12 insertions(+), 10 deletions(-)
