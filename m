Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8427384E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFUNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjFUNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C72191;
        Wed, 21 Jun 2023 06:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F671614C7;
        Wed, 21 Jun 2023 13:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CB1C433C9;
        Wed, 21 Jun 2023 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353845;
        bh=PK2Q9rLKjKer9YEWmryJ25tGPzX9SXDt3JrNu6UDuAA=;
        h=From:To:Cc:Subject:Date:From;
        b=hS4QEI5VFEbmFmiIYGKr3OHBWOYeFFqKiywdQmR9V9Rf2djX5cIbwBjmdG3VtaDnk
         jognR97OXw29YRpuwR3ES64aWWQ/rvlFAR/08SxCQUzMCf5/odi374WR4HEk5A5N8l
         BQ8VKM8eK0nrdi8OP5Gq5BJfhXnorjmPKRn8DPyjdw9C299MhTnZ6io6UVAefbYqdN
         vfKuD6hgNIlG0K17E8kff2fjMDsmKyqybX/aq2c+hVJ1w+o+fB0e5d4/OfNlPsvrvW
         /1bKJsznpyWUpyD0dwMrV+ixszRndZXslNbACWUSkkEZsTg01RmqlM4ty1yRQF8uHP
         z+cUQpV/b0JEg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.4-rc7
Date:   Wed, 21 Jun 2023 14:23:50 +0100
Message-Id: <20230621132404.E6CB1C433C9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eee43699217504ba69cadefc85c6992df555e33f:

  spi: dw: Replace incorrect spi_get_chipselect with set (2023-06-13 20:19:26 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc7

for you to fetch changes up to 9d7054fb3ac2e8d252aae1268f20623f244e644f:

  spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan() (2023-06-15 14:58:45 +0100)

----------------------------------------------------------------
spi: Fix for v6.4

One last fix for SPI, just a simple fix for incorrect handling of probe
deferral for DMA in the Qualcomm GENI driver.

----------------------------------------------------------------
Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)
