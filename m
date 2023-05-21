Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3370AD79
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjEUK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjEUKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:08:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC2133;
        Sun, 21 May 2023 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684663700; i=deller@gmx.de;
        bh=7dOW0KNGBHjgNBej3yVcF5xElC1oRb0G/4mWcnYShDU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=HFvFdjvQMZV9SdTOKNDeTxzv6EJ1lNeyAM0VBV18cQvPb58rMVcSnJbej6ayTb5Dx
         DgfZVr3ZdgljxwmlBg3oQkZbB64ScmAl4gcog7ah2Tt4Za04z3E6A1Ps4uh7kQ32Rn
         bLYyB72EUV9m2Mw4u3/aqNujVLPjoZpnahK+CxOcSbSnX9msKKLAiwptMSiKlwv1+2
         60IcemkohzfNx4TQptL9/MEz93alXZMnRgbskv6mHZOth3Xmg2RM02/JYlj9Et2jV1
         5kcXjZ168ot2l3WlVaWCCtR4pavuzBlxXTzuEeHgRGw+GUlnEKngsCOD/Ny/ngpSLH
         qpw7Wu+mSoUKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([94.134.156.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1qd2XQ1fnY-00h3m1; Sun, 21
 May 2023 12:08:20 +0200
Date:   Sun, 21 May 2023 12:08:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v6.4-rc3
Message-ID: <ZGntkmg6v2G8Fnfn@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:cewIcdm73Z6sou7df0uOWE8D2JFRT9yHPtKirtyTKx5a8/KmcN6
 vEvjUGqTO+8bMqWgzPgSxgq5PVYQ2VnKiL5iykN+R1lfFD31h52w4z2woyzr6ASybLFYgW0
 MCVkqDilknQg38+K5iFttFuRd8nNoR2Vp/dEBEMVGoBbKCqJ3amiPao/LlIMQj0A/I8UmMj
 J50BCr+dc7Znv805+VeFg==
UI-OutboundReport: notjunk:1;M01:P0:DRN+2WeeLWw=;Xk6U3Qjx3DEbQ5fgZbhkUTX6onG
 UgANFf8sq8Zw/Rf6/ovVk5Ir15s/lj8wAjUfEC3UPx5VDS1ZPst8le/MmW3vMC8phCX9EEw19
 /3vJ+BaUpWJXK+oBgD1LLGozldLXcdXsveQq6djiGZaxDTMVP/rKHvy7SdwcWKtG6/o/it/l8
 TgZi6yrb9PLO8GXfFMSiIk4DrFgNivkM/LcJ0fXQyyjvm2y/g6gk4jv5FOCEx4gPANPQ6T568
 GZ6sW17Zw0FwGt3MsuXWuet+BMifAzcok8ukyHrxaT1KdmWGg/8x6wfBtEAtlp4QqMJIhUXWR
 dzajIOix478FFtnhp04zv6e2niAUA79xChFJMiZRVGOGwU5b7lm2SXypqZU9zsAwz4WnobM8m
 29IclP18AwZJEAVbNorDhjFus6c/WVgkNaffKrZhfGl/JNPk+LVsEQnzcQTkU3zxeJzUZjqZ0
 M0Yf+R6rrGpGQsLsG+PQzrq4KvKoSULRWUpgSKUuueDtdQ+5K9bNFp7XSC+LKITlVcVzdZEKf
 Wr38gQwxXXyvuvmRfKccaGL1IFGBcqZWqTdFLvnEZFCV4HSkWew8IU9kuJmVad+IAwfzugClR
 q6Vb2XRL3DHPvUnqNHrHwHrO/plN4dY1m81P8f3zOYLHvbvWLjGtUggNILQ8rsw8HryNodcfX
 K62+DRTyAc/HliTkztNDXnmLLH3Kntz3omY4ixPimvMo+PqoBhdlQdV1WzRKJdIXz0p/oZdXQ
 yo8dLLShOwGgN1aUy0ewrdwNZE8wde/yXwe+6sBixx1C8Th0RlGr4QZJgjbI/sB+vsEN5ZWUY
 sDFDyvxlRZadIn5vpZ5s1ftAh0ZsYxk8lG0+4V+tQn1c3tj7jUQ6FJpsUg4oy0/pZXfeC3feh
 9mdDCu3/C7NQSwVSX7/VkI7NRAcW+QvwpFAu6oYn5IWHQezbzAIGXBcDBgO3/LHGnkIvM7N0j
 JS8aHOrKnO2x9buBkMo1LvDYsxc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few small unspectacular fbdev fixes.

Thanks!
Helge

--------------
The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc3

for you to fetch changes up to d9a45969abeb641c5fb8cf3591f63f827f9932b5:

  fbdev: stifb: Whitespace cleanups (2023-05-20 22:48:46 +0200)

----------------------------------------------------------------
fbdev fixes for kernel 6.4-rc3:

- Fix for USB endpoint check in udlfb (found by syzbot fuzzer)
- Small fix in error code path in omapfb
- compiler warning fixes in fbmem & i810
- code removal and whitespace cleanups in stifb and atyfb

----------------------------------------------------------------
Alan Stern (1):
      fbdev: udlfb: Fix endpoint check

Arnd Bergmann (2):
      fbdev: fbmem: mark get_fb_unmapped_area() static
      fbdev: i810: include i810_main.h in i810_dvt.c

Dan Carpenter (1):
      fbdev: omapfb: panel-tpo-td043mtea1: fix error code in probe()

Helge Deller (2):
      fbdev: udlfb: Use usb_control_msg_send()
      fbdev: stifb: Whitespace cleanups

Niklas Schnelle (1):
      fbdev: atyfb: Remove unused clock determination

 drivers/video/fbdev/Kconfig                        |  2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |  5 ----
 drivers/video/fbdev/core/fbmem.c                   |  2 +-
 drivers/video/fbdev/i810/i810_dvt.c                |  3 ++-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  3 ++-
 drivers/video/fbdev/stifb.c                        |  6 ++---
 drivers/video/fbdev/udlfb.c                        | 27 +++++++++-------------
 7 files changed, 20 insertions(+), 28 deletions(-)
