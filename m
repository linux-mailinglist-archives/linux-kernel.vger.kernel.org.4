Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002377243B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbjFFNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjFFNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BC1728;
        Tue,  6 Jun 2023 06:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07F5632CC;
        Tue,  6 Jun 2023 13:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB60C433D2;
        Tue,  6 Jun 2023 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686056802;
        bh=Of7kuM6rwHgcdNEnTPw4TSCttG8x0dqdHftUZ4BZnaE=;
        h=From:To:Cc:Subject:Date:From;
        b=V8KFe2g8NEeJs1ujHbRUJWxphr2zce5G2CGnYMUHXBl8QgnVG5sV98aZd/cRx4PN7
         0ZpxVVnE2ozNSnwafwQR758kNBpFyBSfa1NqzQD3LNrVkidbo3kPmpo2O2f0/DRjhG
         55nTfCH1jdsc9f3Oh+rq7RzmQIUYveZnNG9FRUtW+N4yAMDkSr81ZySeRXBCx/0xm5
         VWx8XDI1PqGpz3lZIUS57u3rXCdVndDKc31qUDlonsj/nEAWo1KLrrNTIUANf3Qx+2
         XlXl32CodNBzbejj/YxTt96oeiIqaIxJh0WFZ7PWVdkRmFK8Vb9z934UO2KqxR3iQN
         zPmLBJZfAX6tQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.4-rc5
Date:   Tue, 06 Jun 2023 14:06:29 +0100
Message-Id: <20230606130641.AAB60C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6afe2ae8dc48e643cb9f52e86494b96942440bc6:

  spi: spi-cadence: Interleave write of TX and read of RX FIFO (2023-05-22 11:41:05 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc5

for you to fetch changes up to 0c331fd1dccfba657129380ee084b95c1cedfbef:

  spi: qup: Request DMA before enabling clocks (2023-05-30 13:43:31 +0100)

----------------------------------------------------------------
spi: Fixes for v6.4

A small collection of driver specific fixes, none of them particularly
remarkable or severe.

----------------------------------------------------------------
Clark Wang (1):
      spi: lpspi: disable lpspi module irq in DMA mode

Daniel Golle (1):
      spi: mt65xx: make sure operations completed before unloading

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

 drivers/spi/spi-fsl-lpspi.c |  7 ++++++-
 drivers/spi/spi-mt65xx.c    |  3 +++
 drivers/spi/spi-qup.c       | 37 ++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 20 deletions(-)
