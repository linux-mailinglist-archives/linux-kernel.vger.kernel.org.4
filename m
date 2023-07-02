Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DA7452E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjGBWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:04:59 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDB100
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 15:04:56 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688335495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mCmHPHG1J3nq8ze0eYLgFLp9DhOovj9KVVg4dWBDahQ=;
        b=aG4MAU5ULXZFoaoBIQQuB9f9ST7XDJe2fICB6YcNOdvNfDk9waw77dmxibZwNB7jIUYIay
        LfPlf7dP0kquujRayPg92PIG+xRFeC07KiL1bCPr6WOFkbFrjJkYjKFSnq94rXU1ZuoMJe
        s05DfOYNcI892A4hF4OdOmai+SFnsrSIBg0+tXYcRKEbPs5pq+5fVckCZG2OhC4HNE2orX
        BbtXmtVZIXZw2rTi1KJFndljVwDZoUzqxayeGhN6Dvhyo5sKuw30+PXutds3cQeD5wLH5B
        Matl3YDcSbWYcVHBX9/lQUheVXZZR/Q+VntIt6637sdG0+F5kUjkVN2kUV5BpA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6A491BF203;
        Sun,  2 Jul 2023 22:04:54 +0000 (UTC)
Date:   Mon, 3 Jul 2023 00:04:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.5
Message-ID: <202307022204546baff5fd@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsytem pull request for 6.5. These are non-urgent
fixes for the svc driver.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.5

for you to fetch changes up to 49b472ebc61de3d4aa7cc57539246bb39f6c5128:

  i3c: master: svc: add NACK check after start byte sent (2023-06-05 00:50:51 +0200)

----------------------------------------------------------------
I3C for 6.5

Drivers:
 - svc: fix suspend/resume on some platforms, fix locking issues

----------------------------------------------------------------
Clark Wang (3):
      i3c: master: svc: fix i3c suspend/resume issue
      i3c: master: svc: fix cpu schedule in spin lock
      i3c: master: svc: add NACK check after start byte sent

 drivers/i3c/master/svc-i3c-master.c | 51 ++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
