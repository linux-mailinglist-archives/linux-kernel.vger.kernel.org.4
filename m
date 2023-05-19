Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6C70998E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjESOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjESOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:24:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F6137;
        Fri, 19 May 2023 07:24:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 600747C0;
        Fri, 19 May 2023 14:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 600747C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684506275; bh=6aRK6OydZnZ9Z+a8xZyr85+0qyCDrtwCbsOgLwI1juo=;
        h=From:To:Cc:Subject:Date:From;
        b=mRNyQR3tbRtAbr37HbwHmS3p1HlFzl3RrNzAQCLnp0g7Js49hjSslWzMXMQObaL4K
         cmlJ/FFi5QiGSZeoi0krDDOKTD2pCAf03v0R9kpzu8k8GDXgLnRal09IGKlJ1nTvsF
         l7vgzuIlpNyPZAYsEQYZYZ5P2f3G2PIEs9BKBWiS1zM9faNALBrL3JGv2ZDTQdpuIn
         zSZy4KkqWJfFH58/a9B7p4ILrOxDy/MMge6oSk15lZ0LWjaSAROl0ItoPoAzbiXzFx
         dwNTq053vukd8fHXm6NVhWqFSI7T+gIwZNa/OH89+mYLY/3BnV+yfGsKkbToq2Skgm
         O+gZ7okTP8THg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.4
Date:   Fri, 19 May 2023 08:24:34 -0600
Message-ID: <87wn14o0v1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.4-fixes

for you to fetch changes up to bd415b5c9552d44069d4e7c1e018b6d42f25af9e:

  Documentation/filesystems: ramfs-rootfs-initramfs: use :Author: (2023-05-16 12:55:35 -0600)

----------------------------------------------------------------
Four straightforward documentation fixes.

----------------------------------------------------------------
Randy Dunlap (3):
      Documentation: use capitalization for chapters and acronyms
      Documentation/filesystems: sharedsubtree: add section headings
      Documentation/filesystems: ramfs-rootfs-initramfs: use :Author:

Thorsten Leemhuis (1):
      docs: quickly-build-trimmed-linux: various small fixes and improvements

 .../admin-guide/quickly-build-trimmed-linux.rst    | 49 ++++++++++++----------
 Documentation/cdrom/index.rst                      |  6 +--
 .../filesystems/ramfs-rootfs-initramfs.rst         |  3 +-
 Documentation/filesystems/sharedsubtree.rst        |  4 ++
 Documentation/fpga/index.rst                       |  2 +-
 Documentation/locking/index.rst                    |  2 +-
 Documentation/pcmcia/index.rst                     |  2 +-
 Documentation/staging/crc32.rst                    |  2 +-
 Documentation/timers/index.rst                     |  2 +-
 9 files changed, 40 insertions(+), 32 deletions(-)
