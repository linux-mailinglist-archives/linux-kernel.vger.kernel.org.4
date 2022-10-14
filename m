Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F85FF51B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJNVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJNVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:14:33 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82A1DC4C7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:14:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B709320003;
        Fri, 14 Oct 2022 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665782070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/00/5EjmbZweflj6nvJbu5mVDoLduCn7sIQC2QPJABE=;
        b=V8+JLwa2ex5Lm/zpNdzFLveVoxTpm8D4oVrH1FnFbEEvj3iGjm87aF+dLuJCIfPhG6OU1H
        KlavFWLjIBhq+NY7M7pOTi5F2+8qpH1gVgqs3+NAhjh4KgIy5nzHoewE+acN+UblzpCeMr
        zi0+AH6zyahNXAqWgxktLTS1ACcGIhjYGx3mkxl0R7COlYhGHhRAmgXU1/wtzXGL4hHe/Y
        kcf5NM0L5Fz1qNsmN0aeSAudYeQUWaGWLzY2UDcNjNxwMulUfunUNrqt34O4JotEDVYk6o
        EyQdiOyXRIfkP0lR/nSQDwlHLpIPDaA/Wn8mep3caoALdZQ2iU8irFNDAfe7kQ==
Date:   Fri, 14 Oct 2022 23:14:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.1
Message-ID: <Y0nRNcKLvFzqVZeP@mail.local>
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

Here is the i3c subsystem pull request. Not much this cycle, only two
fixes for a rare event.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.1

for you to fetch changes up to 90f4a09a15239f4a819b2e90a7a0b92a75060655:

  i3c: master: Remove the wrong place of reattach. (2022-10-12 23:45:29 +0200)

----------------------------------------------------------------
I3C for 6.1

Subsystem:
 - fix device reattach issues

----------------------------------------------------------------
Billy Tsai (2):
      i3c: master: Free the old_dyn_addr when reattach.
      i3c: master: Remove the wrong place of reattach.

 drivers/i3c/master.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
