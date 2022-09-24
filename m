Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C415E8A28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiIXI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiIXI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117DCD69CB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6559B80ECF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154B9C433C1;
        Sat, 24 Sep 2022 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664008017;
        bh=KhKsDHRJCXOGPcWAsb/coDY0+Y5o0fZeYaJnA75q144=;
        h=Date:From:To:Cc:Subject:From;
        b=BvUx7Wax9f2uiQdxvsCeBRW1/X3Emdgul3fjhj2cyxtqdDA/Plx5f4rAr5sKl41Fa
         w6aHUy+HsEEgGGpOfNiCr0mplujR4cEdcDkhEzG08D7bXayjc/z2waYTcvZ3tudzC9
         AajlDmEILFoS0DCj/uWiuA1e1HB7piPZi4KbxPQw=
Date:   Sat, 24 Sep 2022 10:26:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.0-rc7
Message-ID: <Yy6/TuLIZ60zb3ia@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc7

for you to fetch changes up to 2bc54aaa65d2126ae629919175708a28ce7ef06e:

  counter: 104-quad-8: Fix skipped IRQ lines during events configuration (2022-09-22 14:26:37 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.0-rc7

Here are 3 tiny driver fixes for 6.0-rc7.  They include:
	- phy driver reset bugfix
	- fpga memleak bugfix
	- counter irq config bugfix

The first 2 have been in linux-next for a while, the last one has only
been added to my tree in the past few days, but was in linux-next under
a different commit id.  I couldn't pull directly from the counter tree
due to some gpg key propagation issue, so I took the commit directly
from email instead.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      Merge tag 'phy-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-linus
      Merge tag 'fpga-for-6.0-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-linus

Pali Rohár (1):
      phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support

Russ Weight (1):
      fpga: m10bmc-sec: Fix possible memory leak of flash_buf

William Breathitt Gray (1):
      counter: 104-quad-8: Fix skipped IRQ lines during events configuration

 drivers/counter/104-quad-8.c                 |  6 +-
 drivers/fpga/intel-m10-bmc-sec-update.c      |  8 +--
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 87 ++++++----------------------
 3 files changed, 24 insertions(+), 77 deletions(-)
