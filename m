Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD196D2530
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjCaQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjCaQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490221A96
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61DE562A47
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398CBC4339E;
        Fri, 31 Mar 2023 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680279099;
        bh=omNYTiGtaA5+RsB1YZBSAFXbTd/JgH+adgauevBv5sI=;
        h=From:To:Cc:Subject:Date:From;
        b=k1F6nnkoNbGDLuRLJ8qaLJghX/kkQvVSmvwLq7SDRTvXzD48A7PAQL3FkN5DWy64o
         V8RCLJZ1NKA058Y1xar7Z5AmQ0mjaSXQar3HT2pYw5FjFI4Bwyook/LE7wpTk4sac5
         IIxW8lq8NVan0aEw9d8cnIo830eJMrviZfZ0w8FxRxq9/Hw+GNM24ZeYEhwA26EP5n
         e1O4uQfeWNUcn+BFYLDxHFeIVONZGXf6VGqos6VK8AAdxH0jZKEkmHMrpokJwN864s
         0vXXly7H8S95B0MjWwyk9XnnZUI0239LGfFX4G0NMMHfO+rm2R8is+jQNXSUmHDxsD
         S1bwz99KdNwFw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.3-rc4
Date:   Fri, 31 Mar 2023 17:11:21 +0100
Message-Id: <20230331161139.398CBC4339E@smtp.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc4

for you to fetch changes up to 02bcba0b9f9da706d5bd1e8cbeb83493863e17b5:

  regulator: Handle deferred clk (2023-03-27 01:42:01 +0100)

----------------------------------------------------------------
regulator: Deferred probe fix for v6.3

This fixes a rarely triggered issue where we would treat probe
deferral for clocks as a fatal error in the fixed regulator,
causing it to fail to retry when it should.

----------------------------------------------------------------
Christophe JAILLET (1):
      regulator: Handle deferred clk

 drivers/regulator/fixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
