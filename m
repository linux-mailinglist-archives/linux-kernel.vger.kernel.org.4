Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9A6E82A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjDSUZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDSUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70321718;
        Wed, 19 Apr 2023 13:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F356426C;
        Wed, 19 Apr 2023 20:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA19C433AE;
        Wed, 19 Apr 2023 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681935899;
        bh=8P4CPN9OqFnaiBi4G6pIKfKJWl0J8d1dnTf3yGFKnTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tT5KwaHi2wzE10RuzKch5ikIFRKtw7donx2ZaglNaf9hsH94eCzGlHuwqzKTYRXkL
         hm7IOHmikOHvkqDwxiVsroQvPw4rotX3YJs72I+7GLUgtv1U086UCJ1ah38BtrbVAc
         sXDfZMILf2zjS0KM64t00BL6Pl5x3m44x4RXS7/Cq6OP3f7BbEihiutZQq6TOxVYPE
         swdBBI/AawTnRylNfXzWK8B8MbZ6qr4dMPTb7VK3Qk+dSP/HzmdhZ/xArsMWydTlHs
         m9J0NGs25IpdPQij6JgKY8FqLuhB1EeeatL+s5MBzf+PduDfhN1P5vS40MJr6lnY2l
         al/9YgBZwBZSg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.3-rc7
Date:   Wed, 19 Apr 2023 21:24:47 +0100
Message-Id: <20230419202458.ECA19C433AE@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3-rc7

for you to fetch changes up to 359f5b0d4e26b7a7bcc574d6148b31a17cefe47d:

  spi: spi-rockchip: Fix missing unwind goto in rockchip_sfc_probe() (2023-04-19 13:42:59 +0100)

----------------------------------------------------------------
spi: One small fix for v6.3

A small fix in the error handling for the rockchip driver, ensuring we
don't leak clock enables if we fail to request the interrupt for the
device.

----------------------------------------------------------------
Li Lanzhe (1):
      spi: spi-rockchip: Fix missing unwind goto in rockchip_sfc_probe()

 drivers/spi/spi-rockchip-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
