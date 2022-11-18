Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301EA62FC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiKRSHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiKRSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:07:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675087AF44
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:07:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA2662691
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8A0C433D6;
        Fri, 18 Nov 2022 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668794853;
        bh=YKezUL7rdlqTM5mMiRBYXJ4nNl15Ylq+dzyu9cNREjo=;
        h=Date:From:To:Cc:Subject:From;
        b=Hw+KJNpR3Oc/tgyt8+oXuT4o13R0qHGZykjYV572abW5aKOB46U8Jw73CU7YARQxI
         gA3PwC7OVPu9Pq/dswHcyGwOAvdmaCklFMiLyX7sz0RPW68olmbVx7H5YbRZQQ/y0U
         /y4R+fombBYnR3bkuMHthThcD1vvLEGhIYrZN++w=
Date:   Fri, 18 Nov 2022 19:07:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 6.1-rc6
Message-ID: <Y3fJ4o2sEO7Kef0y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc6

for you to fetch changes up to 937ec9f7d5f2625d60077bb7824fee35dc447c6e:

  staging: rtl8192e: remove bogus ssid character sign test (2022-10-25 19:13:48 +0200)

----------------------------------------------------------------
Staging driver fix for 6.1-rc6

Here is a single staging driver fix for 6.1-rc6.

It resolves a bogus signed character test as pointed out, and fixed by,
Jason in the rtl8192e driver

It has been in linux-next for a few weeks now with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jason A. Donenfeld (1):
      staging: rtl8192e: remove bogus ssid character sign test

 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
