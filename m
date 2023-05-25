Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A8E7119F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjEYWEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjEYWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:04:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FF12F;
        Thu, 25 May 2023 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685052229; i=deller@gmx.de;
        bh=SsAf7b4y97Nz6toWCyih9XFzTB1HYHiHYEbgFoAyUPk=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Bdx9dcbCONDzwGU4nOK+CaJil/UE3UaeONhSCU1g6l3u9fAjOyYzBU3TMgytD0n7J
         ijH6ghisvLmEglri4UIjU5Mh2D83MPt4AJlj6YXqQvUM7gCOrzRqYh8/KEunWWr169
         5+WdqgSeJHzHZZpEF87TbOt+gfqWWWXzgjd5KmAICcF8nZNk+JWNduRJuCaPjBlitZ
         fKwrGfr07xsSot+kFWLhBcIphpGkfpnnGiDKEYiXg/vRhcAbGUA+EHg9CxabAgi33U
         LwxroKKKbH3WI77LuCqFiVmEF1pg9WY1rEDE2vMDk9vEEmBcaMGJ3cvfZDUvRv6NUU
         4xcHeMrNnQlaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.157.173]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1prcME1dyB-00Ajjz; Fri, 26
 May 2023 00:03:49 +0200
Date:   Fri, 26 May 2023 00:03:47 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.4-rc4
Message-ID: <ZG/bQ/x4YOSPEdu0@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:u93dmrWybYRZofkjdl4pOv+k5JFuIVkbyH5ibcKnt57lxOcIlXJ
 HlFsMn0mtMrxbc+3Yx7QFFw7OzvullndTJRKaalydcJUI34uoikdvYV3SB6PVlJHmLnq6/Y
 fPq5hbD5xpA3MP5VZTXDIlUAKJxSLw4sfFwBjjPqyz4gtoieuYWDaHdEhbmnp+WCauNTRUN
 ytp3r9e0rS+9kZgJf+OaA==
UI-OutboundReport: notjunk:1;M01:P0:5AAdnsqmMXU=;P30GigKAyB7oFVY2bQXGiZleJ14
 Du4p4hLeEp6TIZ9PkTsMSLBqEq1hnreUye2xtrZtNWcjsguEuySguDOEIMRyQCZnnaptwpCt+
 sdsfcc1Ll4NcGJmp3Fq0KFDJmRtc+x8LfuSDB+SOrbFF6A0CHs3lwQY1GuMpD23qA83aiDntW
 KjlsUC8/YiE9awTVLkmoyPJumudKRhjFkz19oZItqA7DbzSrVdUm21dmklfeqH2E4/TcDqSdP
 W2y7/dpkat9kfdpOCvXBZVol5uSXexZU+bTEeIvgH2cp5f8FwsmE97WaKvkR0yB8vnc2dYAqQ
 L5DtEvXgJu8rcpiwt/sWzNZ4Zq6YRJvl7kix7j3SpJXehPBSXzHIhjDMyGDXwZEYl9Q5n5TBN
 RfQCPFNUV5GPF2sJRo3dUO6Df/5qhy0ln6XEBjXHzE8p72DuHgBDohxQwu3FFoXxHGyLgkr8V
 W+2329u0GyV4bC7F8Oc/C8Z94jS6pv0U0eO1TFte77aCUsu0yZE/3Q6PstJzf0hNqFvdfwDMh
 NJeXiBJIQ8pkWsolq3CgtBPy/ubiJIMtXbOSZRhalfBVXe2vGlLe1w2705XJuXIvr97OyfPW7
 hPpbCZKkXglYgfQCMf0jWVBDfnq8F4Zxg650kxrdU4Y1mOXNO1JMlhDS00i6eN7MQ0aQ6xaFc
 xxd+SNPX6GsUFQ5Q6F9UCACytstBUtWRnjh85Un5UU145FSNTMcSWsjhvNr7zk9bV+7tYj2cL
 F73hNc0kf45BCjznUt5kc0VLON1YZX9td5BTvqvJQkVTPFJaMYKaGFepIdBh03N5VhyJmLXCB
 w5fhgGfNyFG+3eYcN3w69Um7Y1MWDFtydGfZxhZF7KE4s21+3d/j/V3s5x0bmqFrtluzYLDEy
 k0TKQcymmYbYAcvzQdkWJ/j1LNxMDnJGNtNZGgWEDPx7oFbiyCbFhHI+vbof0ldlJCrAXJ+KL
 dC4L0eMSqGaaZj2xsyWtwQtJDRg=
Content-Transfer-Encoding: quoted-printable
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

please pull the parisc architecture fixes and updates for 6.4-rc4:

Quite a bunch of real bugfixes in here and most of them are tagged for
backporting: A fix for cache flushing from irq context, a kprobes & kgdb
breakpoint handling fix, and a fix in the alternative code patching
function to take care of CPU hotplugging.

parisc now provides LOCKDEP support and comes with a lightweight spinlock
check. Both features helped me to find the cache flush bug.

Additionally writing the AGP gatt has been fixed, the machine allows the
user to reboot after a system halt and arch_sync_dma_for_cpu() has been
optimized for PCXL PCUs.

Thanks,
Helge

=2D--
The following changes since commit 44c026a73be8038f03dbdeef028b642880cf151=
1:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git ta=
gs/parisc-for-6.4-3

for you to fetch changes up to 61e150fb310729c98227a5edf6e4a3619edc3702:

  parisc: Fix flush_dcache_page() for usage from irq context (2023-05-24 1=
9:03:49 +0200)

=2D---------------------------------------------------------------
parisc architecture fixes for kernel v6.4-rc4:

- Fix flush_dcache_page() for usage from irq context
- Handle kprobes breakpoints only in kernel context
- Handle kgdb breakpoints only in kernel context
- Use num_present_cpus() in alternative patching code
- Enable LOCKDEP support
- Add lightweight spinlock checks
- Flush AGP gatt writes and adjust gatt mask in parisc_agp_mask_memory()
- Allow to reboot machine after system halt
- Improve cache flushing for PCXL in arch_sync_dma_for_cpu()

=2D---------------------------------------------------------------
Helge Deller (9):
      parisc: Improve cache flushing for PCXL in arch_sync_dma_for_cpu()
      parisc: Flush gatt writes and adjust gatt mask in parisc_agp_mask_me=
mory()
      parisc: Use num_present_cpus() in alternative patching code
      parisc: Add lightweight spinlock checks
      parisc: Enable LOCKDEP support
      parisc: Allow to reboot machine after system halt
      parisc: Handle kprobes breakpoints only in kernel context
      parisc: Handle kgdb breakpoints only in kernel context
      parisc: Fix flush_dcache_page() for usage from irq context

 arch/parisc/Kconfig                      |  4 ++++
 arch/parisc/Kconfig.debug                | 11 +++++++++
 arch/parisc/include/asm/cacheflush.h     |  4 ++++
 arch/parisc/include/asm/spinlock.h       | 39 +++++++++++++++++++++++++++=
+----
 arch/parisc/include/asm/spinlock_types.h |  8 +++++--
 arch/parisc/kernel/alternative.c         |  2 +-
 arch/parisc/kernel/cache.c               |  5 ++--
 arch/parisc/kernel/pci-dma.c             | 18 ++++++++++++++-
 arch/parisc/kernel/process.c             | 11 ++++++---
 arch/parisc/kernel/traps.c               | 18 +++++++++++----
 drivers/char/agp/parisc-agp.c            | 15 +++++++++++-
 11 files changed, 116 insertions(+), 19 deletions(-)
