Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD164975E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 01:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiLLA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 19:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiLLA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:27:15 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44762BC31
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OMnVCX+zT3f6s6cxYBXOSrXCBkwEzpCmzyDS1+OY2f4=; b=V9/99ITM/q9hZQfuAEECd4WIXj
        BTfX7aM6g06W6kp+vD/YXLmJXaGgE6+KLGeRmwUFjDd7Zz4SJEI5/p28rh5zV8KR7F7Mi0+XUCDya
        toh3zvb8gHqwzV70/kk9oUgs1x7YYr3OOecBrRI9VbHn6E0vc9k9ahTp2eArZean2TbpVdPy8xvYF
        PryPwy09zDFFKDkH1UeYltJxtBcI0T2HfxvXVbhFCvztjp76yxqwo0OD0PsuRFlZIruKfLrjZLdv+
        i0z+OsuJtzqs+F/0EO5wDksFOm3rg6lQ12hgJIpAdmrAzm89/2jbgd1V+qMw1rsKU41Wfmvxze6HT
        NGq4YbVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Wf3-00B80n-1s;
        Mon, 12 Dec 2022 00:27:13 +0000
Date:   Mon, 12 Dec 2022 00:27:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git alpha pile
Message-ID: <Y5Z1YcCcrCGs/CIk@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-alpha

for you to fetch changes up to fa6a3bf7ff3734ff13764d1b9e36c48f93eb3677:

  alpha: ret_from_fork can go straight to ret_to_user (2022-10-29 23:31:16 -0400)

----------------------------------------------------------------
alpha cleanups and fixes; one thing *not* included is lazy FPU
switching stuff - this pile is just the straightforward stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (6):
      alpha: fix TIF_NOTIFY_SIGNAL handling
      alpha: _TIF_ALLWORK_MASK is unused
      alpha: fix syscall entry in !AUDUT_SYSCALL case
      alpha: fix handling of a3 on straced syscalls
      alpha: syscall exit cleanup
      alpha: ret_from_fork can go straight to ret_to_user

 arch/alpha/include/asm/thread_info.h |  6 +-----
 arch/alpha/kernel/entry.S            | 14 ++++++--------
 2 files changed, 7 insertions(+), 13 deletions(-)
