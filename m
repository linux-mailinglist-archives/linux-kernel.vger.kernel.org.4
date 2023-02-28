Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD116A63B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjB1XMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjB1XM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:12:28 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE71B32A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:12:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 595C8240004;
        Tue, 28 Feb 2023 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677625945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dOwfZ7Wusa6c4c2KZROuzohmibC4NdJ1VuXK4VA0VU8=;
        b=G6X9QqO9X5LsTM6A5hAzu6E1NfBT2TQ830DcxZ80a5RVw7H6V0APr0my5DyDFMMCFpYqf2
        xLXdpL67qs7nDVsl3t1cidqt+eNlrJKTv/+xg+zsKRbREbnweXJ+Wd5HFySHL12vROcJ2m
        wLAWWVH9xRRmv/T4ItfKe76Ok5KReugGiOlGzjQ1vmuq05pb6FPKBAoKs4700SJsJvwl5Y
        lEXAnBe3fmXyWdxOs4L7y4EofbnW8rtBHGfMzKjMwoIZPxeDoJnyUqBjdIl6w+XCsK2fN1
        W7xo5RV3wcDotjGIUrRLNAjXL5KyTx3EfVFZ9dvS//h5kM9lJUsNYDpqTzKipw==
Date:   Wed, 1 Mar 2023 00:12:25 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.3
Message-ID: <Y/6KWc1az70PQB+/@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsytem pull request for 6.3. There are two small
improvements for this cycle.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.3

for you to fetch changes up to 510d2358c466bf6588034f0d3b2266eed2bc0a51:

  i3c: master: dw: stop hardcoding initial speed (2023-02-28 23:54:49 +0100)

----------------------------------------------------------------
I3C for 6.3

Subsystem:
 - transfer pid from boardinfo to device info

Drivers:
 - dw-i3c-master: stop hardcoding initial speed

----------------------------------------------------------------
Jack Chen (2):
      i3c: transfer pid from boardinfo to device info
      i3c: master: dw: stop hardcoding initial speed

 drivers/i3c/master.c               | 1 +
 drivers/i3c/master/dw-i3c-master.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
