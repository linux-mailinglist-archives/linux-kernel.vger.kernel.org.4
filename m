Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59334747E13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGEHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjGEHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:17:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D99197;
        Wed,  5 Jul 2023 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688541463; x=1689146263; i=deller@gmx.de;
 bh=gxCS/qjG4pfAPqlmGcad4sNZR4U6vupp7BLBkYy1BhI=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=mQoWP8Xl7bwdayhytli6v/AEI9Tlia1g8T/RmLj0Ino2Wy9r835bCgZAeHSycIk0YPT2hiJ
 KKnXabvLNmlwa0XNzz/tpN/mbeAEVoe2Btl9uBsxgIjfJEAS+22E3HPjoWkzLvMJWszNuQwDh
 nO/j49qPmjkkTmIzSso/WNq8+iHYOQ/xylSHSEbkMiJwSjRu7ueKjQLnLMIO+e693ynQp1uZK
 wBP8AqCu5ki+GaZsaCaJqDG35HiAyMHd8ZcN3TBJgd3eS/Dhz0vxE7E1iE7ZVJYejOxFcig75
 bM5I84qoYWEoNmz2DUb6Z0oLXP5Stm1wnl+XQXCK+M/GWmDO6jDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.149.108]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1qG7xA1tXr-0021PS; Wed, 05
 Jul 2023 09:17:43 +0200
Date:   Wed, 5 Jul 2023 09:17:41 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] more parisc architecture fixes & updates for v6.5-rc1
Message-ID: <ZKUZFS4CGOHNJR1S@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:8+PlUoe/Yje2T3Q02Os2q9/eZ7ZzFc26qjtwjNIoFZ/FoDjDubm
 T1uE4aOyWYJRdZPpMqk+l/32T02PjI24/ailUJbPkfkME10fCrjv3r3V0ARsoCs8Pa6AVo6
 qUyvRHoSoWcanTob1Xj4A5SYZ6ZbrYBXCkkP79UXAM1brLOOvUF4eCwUoLYc1WORkU2nnLr
 nAvCKhn0vTtleOAzpGdMw==
UI-OutboundReport: notjunk:1;M01:P0:41VUbBoAXZ0=;cOp7eIEV118VyI0kls++jxczfYO
 i7C+5saycdVH/fteL+1WgBOHGhs9KvwUtRaRmB4hS41v2jLwRfk710ZSF/DXZwMXGlN1D0HEs
 LCb/U81uWZ9xKkcSclXcM/C6Rk10TRIoGtXA5K6ezkFRu2cPX7Fs0GwlPExEI3V8Ow18Z3zRI
 SI6cQGZ+JUAYaVhbAp0oQAMqiy31eldcmF2/dpsnZ6FIvoELCvlxlmTt1krB9xmUFlSE86Ea5
 5RZENHH8btSdK16g7Br+YJ1b7l5xdwqh7lJztCk/MNiWWDH+PlNFIjCCyfnYkCUzSskSO08p4
 15uqzDT5e+rF2AwZRF/1Q+uPudtX3Qb0bXMFt9O8KePBU0axUAKkYXugTZZlsOQO5pobSimrT
 rfOZGV9FHchvWCeQSZL5h64NVmptRXOU1wNEZdA3k1viSzR6lN3jXWlYwtFTH/o7QUS+Ugsmr
 qx5Sv95XkRt2i4h4etMkjXGZPWxMCtVIw+9STFKtrvpLBuQ6i7rgO6/AwNNyx7SMrpR7SwJ2D
 BnhCYVKRUqaSGR+3xFo5buUykmvwYKdzGVeW9kHduZndqjfKuNC4TSsug6iqk/erU+AQWNhl5
 tho9a7Rc44z8IcQW5r/cRTCMbuhlcl8/8yQvZdKzcytgGG4pAg90wxEiAsYfj6Ztz709lVtMB
 EwhPj2PMOBoP6iC30sMcXrvtR9XA/dfVd5dhvyczjy4l9o5/UQwQmKS5guS4nRyWFThXpVTYw
 b2BkYj9mTkB1EFyDzmz79DsU4OMQXvXIJhaf4iHZWgjcElRqweaQ43Yct1WmuHbcGKWg1XwPA
 Xp72LvVA9w17V+XSPP/Jy/hE9ut638cP65WXka9tOUy2ODaM9Zcjvtr/aDxmDHeipTnhmLQtQ
 7C25FBeYgQqM/4AwPL+uRVevo71s0+mT15rWYi+gW/soD7wSV1tysvL0274qprWPXAgw2RYPQ
 6T2JNltoAIhK+SWHedix9UnucTc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a second round of fixes for the parisc architecture for kernel 6.5-rc1.

This fixes all outstanding compiler warnings when compiled with W=1 in
the arch/parisc/ and drivers/parisc/ directories.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451:

  Merge tag 'iomap-6.5-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2023-07-02 11:14:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc1-2

for you to fetch changes up to f8a473bf5db7a6abaa7cad40303e395dff702819:

  parisc: syscalls: Avoid compiler warnings with W=1 (2023-07-03 18:56:03 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.5-rc1 (pt 2):

* Fix all compiler warnings in arch/parisc and drivers/parisc when
  compiled with W=1

----------------------------------------------------------------
Helge Deller (6):
      parisc: pdt: Get prototype for arch_report_meminfo()
      parisc: smp: Add declaration for start_cpu_itimer()
      parisc: unwind: Avoid missing prototype warning for handle_interruption()
      parisc: Raise minimal GCC version to 12.0.0
      parisc: math-emu: Avoid compiler warnings with W=1
      parisc: syscalls: Avoid compiler warnings with W=1

 arch/parisc/include/asm/processor.h | 2 ++
 arch/parisc/kernel/Makefile         | 3 +++
 arch/parisc/kernel/pdt.c            | 1 +
 arch/parisc/kernel/smp.c            | 2 --
 arch/parisc/kernel/unwind.c         | 5 +++--
 arch/parisc/math-emu/Makefile       | 3 ++-
 scripts/min-tool-version.sh         | 4 ++--
 7 files changed, 13 insertions(+), 7 deletions(-)
