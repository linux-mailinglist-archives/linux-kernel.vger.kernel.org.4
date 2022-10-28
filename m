Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57361170F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJ1QIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJ1QGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:06:54 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FC81DEC06;
        Fri, 28 Oct 2022 09:06:15 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D8F31BF203;
        Fri, 28 Oct 2022 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666973174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=x2LoHTbLw4b1WUG8uBbzEtQl0fL2ZudLx5bMlc3slsc=;
        b=TifAVR66UAYkjs/2X2ueBv0MxezvaRCO5wXIyLJp07lN5IB1FW2PtKYE+0w3yO4zv/Asdv
        AlweFaTVTSOG7w6h/FD0n9J1e5SNI5z6XgVPHChsInfPmQyrsdXcwd3miRWW8jD7UsjFaU
        X2R56ppT9T7hB8uqGeRplb3fG5AlpGOX2hDVsOYry6P4ZIEtjruu6b5VlGZR11Ngj7qhoJ
        HISnRyaMU6bIR9OBArJ8pXJDI+PTRhIMiQ8IvGFmOou9t++D/htqqX7YDLFfgKtzUazLE0
        HwrmLUl8GlLfElApx075AnsFQjdP/qYM8RuQ01V4FMt5o5cwalQgS8DEoTiD+A==
Date:   Fri, 28 Oct 2022 18:06:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC fixes for 6.1
Message-ID: <Y1v99D722uI1nu1M@mail.local>
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

Linus,

Here are fixes for the RTC subsystem for 6.1. They fix wakeup support
that broke on multiple platforms.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.1-fixes

for you to fetch changes up to db4e955ae333567dea02822624106c0b96a2f84f:

  rtc: cmos: fix build on non-ACPI platforms (2022-10-18 22:36:54 +0200)

----------------------------------------------------------------
RTC fixes for 6.1

Drivers:
 - cmos: fix wakeup support

----------------------------------------------------------------
Alexandre Belloni (1):
      rtc: cmos: fix build on non-ACPI platforms

Rafael J. Wysocki (1):
      rtc: cmos: Fix wake alarm breakage

 drivers/rtc/rtc-cmos.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
