Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB9676724
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjAUP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAUP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:29:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9342C64D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6703960B40
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 15:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2EFC433D2;
        Sat, 21 Jan 2023 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674314975;
        bh=+21d136c+CDoJ+jjaA9CrZwr2YrFn6bIJwlOkuXzTLE=;
        h=Date:From:To:Cc:Subject:From;
        b=HxhM/4MzQKzUIGesBvxdyFDIBEg9RhtNhCk/meXWZOYDhfCFeX+vrbnnxayAgtQCS
         pJI+vPSXISI0Jn4Er9hC4R7QuNDczDm25tcyM82FdUy48GLDs3I5g5+MiJ3ou7tpCW
         91LaCm2Yt0JMR0JK953MK3VNquo8ZcEg2oDPdtzQ=
Date:   Sat, 21 Jan 2023 16:29:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 6.2-rc5
Message-ID: <Y8wE3Tu3muhrYchq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc5

for you to fetch changes up to 7d83299351fe7c812c529f5e39fe63b5312e4233:

  staging: vchiq_arm: fix enum vchiq_status return types (2023-01-17 19:23:36 +0100)

----------------------------------------------------------------
Staging driver fix for 6.2-rc5

Here is a single staging driver fix for 6.2-rc5.  It resolves a build
issue reported and Fixed by Arnd in the vc04_services driver.  It's been
in linux-next this week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: vchiq_arm: fix enum vchiq_status return types

 drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
