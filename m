Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EFF7384DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjFUNXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFUNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EE1985
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D66614D7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDCBC433C8;
        Wed, 21 Jun 2023 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353800;
        bh=19V7WrlpMawbxiZNmi71JjpJQl2gX2m7P8xAd9K9uLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sJiIRnzN7bUpHfBk4FuUt02twyYjXfID7rz/lPRAluw4rjZdJrIUBP2k0g4gDyKn8
         ToixKTH2Xa60utm5C+uH6I4J3qiThKVctcs6LmSpxiFaIV0LxdUHYewImB2wiNvArc
         Fz3nk8j34Iiz1bGEwHKSXp7Xoa+v09ZMHpnpmCvVofLu4EACRhY08PK2v/j7CDCKCU
         26oVaSQ6A6K9jQaxGxR1Gk8nSEnFyNjrmhjZ8itZ+KDlGP1P3bkq3SS936gckKWaB/
         fMaVyIP5tCrzf8IkRDKCxgGLMoKCKcNUSQiP719PzQaUDc8dqqJd8sMmp9usZLQS1N
         vQ87fvI53Z9xA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.4-rc7
Date:   Wed, 21 Jun 2023 14:23:16 +0100
Message-Id: <20230621132320.1DDCBC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b00de0000a69579f4d730077fe3ea8ca31404255:

  regulator: qcom-rpmh: Fix regulators for PM8550 (2023-06-07 14:20:04 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc7

for you to fetch changes up to 7257d930aadcd62d1c7971ab14f3b1126356abdc:

  regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK (2023-06-19 15:13:17 +0100)

----------------------------------------------------------------
regulator: Fix for v6.4

One simple fix for v6.4, some incorrectly specified bitfield masks in
the PCA9450 driver.

----------------------------------------------------------------
Teresa Remmet (1):
      regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK

 include/linux/regulator/pca9450.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
