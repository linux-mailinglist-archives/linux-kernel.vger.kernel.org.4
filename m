Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5CA699A14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBPQdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBPQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:33:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DC497CF;
        Thu, 16 Feb 2023 08:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B212B828EE;
        Thu, 16 Feb 2023 16:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26DEC4339C;
        Thu, 16 Feb 2023 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676565193;
        bh=nMVHmIqfaHt08Slvr0nYctMoK6XHgT9o9PCB3tkVwMM=;
        h=From:To:Cc:Subject:Date:From;
        b=tRHuxIl2U6ktQg70qCgMQu7QRzybFUQFlAz6fRrdN4HLZlfgQwRNiKw5QJR1OZ9Yu
         CiY4DEAy+A5xcCYaNDgiDOJ8J7EGTQp6ZDhqWLv1lqUlLMm5ZnFlZYFmu+HIYvjmBG
         CLS/0J6okaldrafpDdKA9oSBJhJ7Wkm+LX3tFcY3pzA7FAfjPGe5rQZQ05Igj6bs7a
         qaQSTrJi7hVoh8FoEpQiu56xOxPamXtBe4zhb2DjnN6ABZIbkzBNOCVX5IIhQm6ps/
         rJfvbSR4HID+1RtVRLsqr10IcSfO2QTI4/MIb4M37H6Cibu6iXjdo0Z2+A8YOeXxIZ
         AdG75UPF3zCyg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.2-rc8-abi
Date:   Thu, 16 Feb 2023 16:33:04 +0000
Message-Id: <20230216163312.A26DEC4339C@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e0fe6a31cac84735939c29d1e05055d58325c6c0:

  spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns (2023-01-05 16:07:09 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi

for you to fetch changes up to f276aacf5d2f7fb57e400db44c807ea3b9525fd6:

  spi: Use a 32-bit DT property for spi-cs-setup-delay-ns (2023-01-13 12:31:49 +0000)

----------------------------------------------------------------
spi: Update for v6.2

One more last minute patch for v6.2 updating the parsing of the
newly added spi-cs-setup-delay-ns - it's been pointed out that
due to the way DT parsing works the change in property size is
ABI visible so let's not let a release go out without it being
fixed.  The change got split from some earlier ABI related fixes
to the property since the first version sent had a build error.

----------------------------------------------------------------
Janne Grunau (1):
      spi: Use a 32-bit DT property for spi-cs-setup-delay-ns

 drivers/spi/spi.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)
