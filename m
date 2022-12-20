Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C101651D23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiLTJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLTJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:20:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F812C;
        Tue, 20 Dec 2022 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671528031; bh=adfkfewkwjQteurWnKEPbrhw+//bwdG2TBvIgRmXXIc=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=sXTwYNNQaWfS8wz7ifn1zQC7vj2PBvNiL1CcFIWjBM9uTw8j0qbcnu47cKJ1pMhr2
         rxYkidBtOpi8W7aZNfeTNnnccUxWyED8hC5ZxjCUHxcplzBfKda9VpDSGC+N1XotOZ
         A+3DIgZERIuHOlbn85t8LL+reFtr2hfA95lGqt2ppsT48rvMvrj3jJmpjpdh7zLbiX
         2/FVewJw7ZBKpVXb4MoMe9OIpznF3e99YjzkKa+cWEJUQfIwx2CCrMwcplv/KmL0tr
         BrBcmrc3c8rKlc1JhglIV7FdW6ShPBcKughTO+GLy5Os2Vcr8Ydcnx8kgOrAbby5+i
         Ih7kmS6+zmVyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([92.116.174.3]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1oUb5J0jGU-00nC2s; Tue, 20
 Dec 2022 10:20:31 +0100
Date:   Tue, 20 Dec 2022 10:20:29 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.2-rc1
Message-ID: <Y6F+XbLE2B7oPY6J@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:wwV8PcFNUkUX7RtNR0GPK4yFeK8WX1kYZVYQkrC0FKe0jkId2dG
 X3+nvs0Yz+AVaW0DpPU1C091pFZHrHJ5Ph3mhzglTBhDWkaOD+jG4EYC26pVEZ2u9zwYst6
 7jwbBAYPtUBqBdIh1AUbXchWFP5zc537gYqbmmsbqwEXUy8l8SGZSCXACETaDTEW8sqbGJG
 tcOQ7cl0/mnyfIYP27+zQ==
UI-OutboundReport: notjunk:1;M01:P0:BISQ6QrfUFA=;kOXpr4vDyNoJsuBGEeXUlSDwJWC
 N+lfuuMFhaLVTD8KywVAm2ZHzh7QTqjP0S37DWsLOWStOH8eCrSR4ZCAN2rfQZKIJ65DOmXA4
 ZhpfhckyL4xBe1VGQ1caA0s2pYAm5CksyvLWPchndiYgIBNJz2E0IEDr62EK3+o4eESz9OPRI
 ZnyqhhBb/Hw956FSQWDXmnFG7IYouMktSV85pe7bhV80/2NADmaYFE0xGzoImMCk1du71ziSb
 cO2eH031jjWrXJ9ywrJXf90MOoFTcXK7x4J4I/X9n3nD25qPiU1v8t/id0rUzr1cKtXSs9zjh
 HZzK6+X5N8lu2qMbjWWgeTqbYOlrMymgVbdZKLSPBDLoe1fyifGTw4ivDr9chbhadSYvonkvG
 BM1wPE9k3lmkXG2COnLHvMB8BKGoY9lxabBENXUFxZDiibU41baxFZpp+MbdjxxhQe0vHnbzv
 qpjSvFVO7VAZ6nume9WMLR1McqxdVAtS4zsegxzu3gU+6pOQ32JBvwTrQYbjNsRrxugsqSqE/
 9ELBp+usw1FlyvXNN+0xgwIa6axuPWnQaou1pux3oCR+Xu6g5/0nRQ3KlQ/7fEV8iJPecYUSv
 UtuITMISGVipjO0iNrlJw31zrrivt8z9ASbr+fVCJcQc/BC+9vRVz9pAwlvXO07MhELH4HUnM
 PLLvk2ghhCysz7hNPcBjnktlOeTtrt9wMqYsRz7bSwk3FKe81/8asSRjCadzfmhwDSkdiZVqt
 WdQzor7n6bKMi8JH3Ry3+Y7+NyW5fyq5Tk5R+i4xrfO78+KRv+HR2VcDDMTnzKXkxMxE8KMrU
 LjZfAl+MwLC8PJf+eySaor37+jp0HAAHFxscrHVpxba/Gm9R+SnYXhf5MkXHh7tOfmb6UYueI
 PuvEbDkK2jKbgkpM5U8hcN9vOMru1D6YYTOwQkbjJjYs7Ile3O4Pf9vM0ZJT9Up0bzC9O30TL
 3CfGU31w1sP2zapbC8W5Cf+51oM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest updates and fixes for the parisc architecture.

There is one noteable patch, which allows the parisc kernel to use the sam=
e
MADV_xxx constants as the other architectures going forward.  With that ch=
ange
only alpha has one entry left (MADV_DONTNEED is 6 vs 4 on others) which is
different.  To prevent an ABI breakage, a wrapper is included which transl=
ates
old MADV values to the new ones, so existing userspace isn't affected.
Reason for that patch is, that some applications wrongly used the standard
MADV_xxx values even on some non-x86 platforms and as such those
programs failed to run correctly on parisc (examples are qemu-user, tor
browser and boringssl).

Then the kgdb console and the LED code received some fixes, and some
0-day warnings are now gone.  Finally, the very last compile warning
which was visible during a kernel build is now fixed too (in the vDSO
code).

The majority of the patches are tagged for stable series and in summary
this patchset is quite small and drops more code than it adds.

Thanks!
Helge

=2D---------------------------------------------------------------
The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa247=
6:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git ta=
gs/parisc-for-6.2-1

for you to fetch changes up to 4934fbfb3ff09b8500f63d4624ed8b41647bb822:

  parisc: Show MPE/iX model string at bootup (2022-12-19 16:08:52 +0100)

=2D---------------------------------------------------------------
parisc architecture fixes for kernel v6.2-rc1:

Fixes:
- Fix potential null-ptr-deref in start_task()
- Fix kgdb console on serial port
- Add missing FORCE prerequisites in Makefile
- Drop PMD_SHIFT from calculation in pgtable.h

Enhancements:
- Implement a wrapper to align madvise() MADV_* constants with other
  architectures
- If machine supports running MPE/XL, show the MPE model string

Cleanups:
- Drop duplicate kgdb console code
- Indenting fixes in setup_cmdline()

=2D---------------------------------------------------------------
Helge Deller (9):
      parisc: Fix inconsistent indenting in setup_cmdline()
      parisc: Align parisc MADV_XXX constants with all other architectures
      parisc: Drop PMD_SHIFT from calculation in pgtable.h
      parisc: Fix locking in pdc_iodc_print() firmware call
      parisc: Drop duplicate kgdb_pdc console
      parisc: Drop locking in pdc console code
      parisc: Move pdc_result struct to firmware.c
      parisc: Add missing FORCE prerequisites in Makefile
      parisc: Show MPE/iX model string at bootup

Shang XiaoJing (1):
      parisc: led: Fix potential null-ptr-deref in start_task()

 arch/parisc/include/asm/pdc.h             |  2 +-
 arch/parisc/include/asm/pgtable.h         |  4 ++--
 arch/parisc/include/uapi/asm/mman.h       | 29 ++++++++++++++------------=
--
 arch/parisc/kernel/firmware.c             | 32 ++++++++++++++++----------=
-----
 arch/parisc/kernel/kgdb.c                 | 20 -------------------
 arch/parisc/kernel/pdc_cons.c             | 16 +++-------------
 arch/parisc/kernel/processor.c            |  9 +++++++--
 arch/parisc/kernel/real2.S                | 17 ++--------------
 arch/parisc/kernel/setup.c                | 26 ++++++++++++-------------
 arch/parisc/kernel/sys_parisc.c           | 28 ++++++++++++++++++++++++++=
+
 arch/parisc/kernel/syscalls/syscall.tbl   |  2 +-
 arch/parisc/kernel/vdso32/Makefile        |  4 ++--
 arch/parisc/kernel/vdso64/Makefile        |  4 ++--
 drivers/parisc/led.c                      |  3 +++
 tools/arch/parisc/include/uapi/asm/mman.h | 12 ++++++------
 tools/perf/bench/bench.h                  | 12 ------------
 16 files changed, 100 insertions(+), 120 deletions(-)
