Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B664C052
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiLMXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiLMXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:13:38 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9667538B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:13:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2777940008;
        Tue, 13 Dec 2022 23:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670973213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Yzl88HJxHY2bEmr3PLutFWx2niCMU+kN3n1YfPEotFs=;
        b=EnpAdq012TQNFFcYnJZb6SEuol82N0i2fj1ujk7afvtkpnuaiIjB9nt8RS1oBESAbbUelZ
        qy6eChfUDp8nuXseVs9fsk6E6FWDmS65X//QEBh0V1o1EEw+v8btg1/sAhi6y+0WqJGGXO
        UX1uJwa6qXQQBPgYFcbRzqOHUGE3xQqpYpIErtjJU1orIX5URXpKgnCMBRerHj3i/Kye2/
        3gEOMxRJuZqi9e5QrhAeP1zaoinYtlEfOzxeoE1v8g3jsYnLvmNGjv8A3VXNRXz+fRbIX6
        To2z+tT+i4+1Eqcgh8lk3HH6b38MWijqTSzZOT6Is3+0/pcI0tiJOjjQWY+OMA==
Date:   Wed, 14 Dec 2022 00:13:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.2
Message-ID: <Y5kHHAOgXCz3zQzi@mail.local>
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

Here is the i3c subsytem pull request for 6.2. There is a non urgent fix
and SETDASA is now exported to drivers.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.2

for you to fetch changes up to 08dcf0732cb4d97b85493d9f60470e48eebf87fe:

  MAINTAINERS: mark I3C DRIVER FOR SYNOPSYS DESIGNWARE orphan (2022-12-11 22:04:58 +0100)

----------------------------------------------------------------
I3C for 6.2

Subsystem:
 - API changes

----------------------------------------------------------------
Alexandre Belloni (1):
      MAINTAINERS: mark I3C DRIVER FOR SYNOPSYS DESIGNWARE orphan

Jack Chen (1):
      i3c: export SETDASA method

Naveen Krishna Chatradhi (1):
      i3c: Correct the macro module_i3c_i2c_driver

 MAINTAINERS                |  3 +--
 drivers/i3c/device.c       | 20 ++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 19 +++++++++++++++++++
 include/linux/i3c/device.h |  5 ++++-
 5 files changed, 45 insertions(+), 3 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
