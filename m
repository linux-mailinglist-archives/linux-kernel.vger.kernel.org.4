Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87341734704
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFRQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFRQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F0BE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B16B6122D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 16:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2C7C433C0;
        Sun, 18 Jun 2023 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687106158;
        bh=qTqUWKII5AmQOvLnfaDpO/pVMQJmeB28A6ZIlr7KH4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Nq2e42OcM8S/X5BaaknoccOgVqugLu1az0mQ9UoIRz1rFhJ09gvX/VyeNVKn06RNE
         QaJiOxOtDYDa5nG4K4/lRtwlh9eOhhp1IUHMGpJoAbeh1Ug6H+mKOsUz5K+aXcPFDX
         z1onkl6wpQgxrazfDHzbOqIUPC4bzMCnKaQuIisogG8OUUIW2s2gXwXEalowwpPlLJ
         SoyEwWloelOET90+CNqOa5poj903EkIwgFBkLw4RwRyxVMqMMF1svyri9XE7p10xDa
         inpXQ6xbqKFJmuPkWVGCSxHlXxeEUUbddYq29q9+3sLXs9de43ylrOqxjRiBP05p3H
         wYMwr0wyj0JoA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for 6.5
Date:   Sun, 18 Jun 2023 18:35:17 +0200
Message-ID: <20230618163542.1090462-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A cleanup for auxdisplay, which has been in linux-next for 2 weeks.

No conflicts expected.

Please pull for v6.5 -- thanks!

Cheers,
Miguel


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-6.5

for you to fetch changes up to def85dce1451ec276b8047da2010b6e6a159c2b6:

  auxdisplay: Switch i2c drivers back to use .probe() (2023-06-02 13:23:32 +0200)

----------------------------------------------------------------
auxdisplay for 6.5

A single cleanup for i2c drivers to switch them back
to use '.probe()'.

----------------------------------------------------------------
Uwe Kleine-König (1):
      auxdisplay: Switch i2c drivers back to use .probe()

 drivers/auxdisplay/ht16k33.c | 2 +-
 drivers/auxdisplay/lcd2s.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
