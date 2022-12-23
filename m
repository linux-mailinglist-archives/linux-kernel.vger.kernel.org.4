Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E565E6554CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 22:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLWVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWVlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 16:41:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED71CFCD;
        Fri, 23 Dec 2022 13:41:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5555161E96;
        Fri, 23 Dec 2022 21:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A71C433EF;
        Fri, 23 Dec 2022 21:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671831703;
        bh=GZXP1Zdh2AD/eyhw0mrs+o5gMLuOEUq2/3ABEdlUuzw=;
        h=From:To:Cc:Subject:Date:From;
        b=Xb6kE26Zu6Znz/L5fTEZb6LEUa358jLi4rCkjI8EiKJSKPr5a32cS3u/36s0+HfkH
         g2LWP2NWooF/qHH+vz0umGO55KdDbDAuXO2GynG8XKIeyErx3FQ9Ebn3jmedCwkylk
         Yr7k855LD9eukWTE85q3nM2VwjUM+1vvMqUaimiTKZnPbu9Pl6FN37BbQfpcCDfoFx
         afaeNVgBL406sNqyM4nl7QbDohYbd1TFl2weyRQe6+RWysxeAprU8Kl6hOKAyF6UKX
         G0IPAz0ZukZbmYu/xYNr4Lnl4nZKOULqAktw6UG9ljYl2ZbQm2GCMeYbI5JqvkcVJ4
         0U1SsKHYWxc6g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.2-rc1
Date:   Fri, 23 Dec 2022 21:41:31 +0000
Message-Id: <20221223214143.30A71C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cf241c3d56ff19f5192cb42a025bc6582b6e8fa:

  spi: dt-bindings: Convert Synquacer SPI to DT schema (2022-12-09 17:39:08 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc1

for you to fetch changes up to 3b553e0041a65e499fa4e25ee146f01f4ec4e617:

  spi: fsl_spi: Don't change speed while chipselect is active (2022-12-14 14:24:51 +0000)

----------------------------------------------------------------
spi: Fix for v6.2

One driver specific change here which handles the case where a SPI
device for some reason tries to change the bus speed during a message on
fsl_spi hardware, this should be very unusual.

----------------------------------------------------------------
Christophe Leroy (1):
      spi: fsl_spi: Don't change speed while chipselect is active

 drivers/spi/spi-fsl-spi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)
