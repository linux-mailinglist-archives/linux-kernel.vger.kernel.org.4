Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1046554C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 22:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiLWVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 16:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 16:31:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197691B9CF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 13:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1B0261EF2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9978C433D2;
        Fri, 23 Dec 2022 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671831063;
        bh=rd9KXCYYMD1NNv/jgh/mMGCyf++thjGVBFkIWmyx6Tc=;
        h=From:To:Cc:Subject:Date:From;
        b=KZjPALSonCMab785FhihFuWKmzvqLSFXXGesiyvlYZnA7do+qzM8dL+mO2M9etizs
         8pzBzU4VkcgtjMndfoN9KKHMVLvWOx20LRV9/Qs8WBcYoDR62Jm0yefwkQXhm4R9B7
         isLzxuOQ/KIY8NxmFc6n9hwIPjfj+j140F1GpIpJDj1lQn8piIwyu7Tb38h2qXQVol
         Y2sh+TmEQtPSJFGs4UBo0ZPnrHNejXB48HkjRkXDEW6CY46rR8C3hYz81oETmC1jaQ
         96mIQ953uMC501xmVesrFWhpFCtchzLmiKxScjT3sABzkkU+dI2FdQ98YOmsanfE+l
         KjfN/wmtUJN2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.2-rc1
Date:   Fri, 23 Dec 2022 21:30:51 +0000
Message-Id: <20221223213102.B9978C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3cbcd6b440032ebc7f7d48a1689dcc70a4eb98:

  regulator: core: Use different devices for resource allocation and DT lookup (2022-12-08 13:02:37 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc1

for you to fetch changes up to cb3543cff90a4448ed560ac86c98033ad5fecda9:

  regulator: core: fix deadlock on regulator enable (2022-12-15 11:56:26 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.2

Two core fixes here, one for a long standing race which some Qualcomm
systems have started triggering with their UFS driver and another fixing
a problem with supply lookup introduced by the fixes for devm related
use after free issues that were introduced in this merge window.

----------------------------------------------------------------
ChiYuan Huang (1):
      regulator: core: Fix resolve supply lookup issue

Johan Hovold (1):
      regulator: core: fix deadlock on regulator enable

 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
