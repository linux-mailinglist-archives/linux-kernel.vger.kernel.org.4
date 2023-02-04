Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1668AC9F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBDVie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBDVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:38:33 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7823873;
        Sat,  4 Feb 2023 13:38:31 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3CA5A1C0002;
        Sat,  4 Feb 2023 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675546709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+X1UUpODhtxBsw4qPPiP+D5D+5Py/2t1z5ftYczg/D8=;
        b=Yz7kR8oMIoDi0Kj8ThKPSmRsAvajZSYQCyxPtEXSt8WYXBF116n/+sSurd0pHfQHPgVVHI
        MexUY8zSoFJGotKhhsT3V9yD5gnflhdpkldJHpi7wiKsUjiMInPQVm9WWdgHQnXwZHNTn3
        Hzt7/o5V9nJNzOLa7e0BY6OjwopSwGhir90u8teQMtifMMDfAmMqjbamYPBSewWG+yO0fc
        GZiKLXmVUM4jZg1Kvg/J2F5p43RWASWcQjnKSofWe/AeuvkYN9jqZri6u74sT7Xz9Ht8SE
        YDMCaxdY+cKoP9CYjj+hXYEgq++dsC0cOM6FVo+5+AY1XITxw6wsGrbMsh9WZw==
Date:   Sat, 4 Feb 2023 22:38:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 6.2
Message-ID: <Y97QU2E8/VO/ZIjt@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here are a few fixes for 6.2. The EFI one is the most important as it
allows some RTCs to actually work. The other two are warnings that are
worth fixing. I was hoping I would get one more fix but that one is
going to wait for 6.3.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2-fixes

for you to fetch changes up to 08279468a294d8c996a657ecc9e51bd5c084c75d:

  rtc: sunplus: fix format string for printing resource (2023-01-23 23:33:47 +0100)

----------------------------------------------------------------
RTC fixes for 6.2

Drivers:
 - efi: make WAKEUP services optional
 - sunplus: fix format string warning

----------------------------------------------------------------
Arnd Bergmann (1):
      rtc: sunplus: fix format string for printing resource

Johan Hovold (1):
      dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property

Shanker Donthineni (1):
      rtc: efi: Enable SET/GET WAKEUP services as optional

 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  2 +
 drivers/rtc/rtc-efi.c                              | 48 ++++++++++++----------
 drivers/rtc/rtc-sunplus.c                          |  4 +-
 include/linux/efi.h                                |  3 +-
 4 files changed, 33 insertions(+), 24 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
