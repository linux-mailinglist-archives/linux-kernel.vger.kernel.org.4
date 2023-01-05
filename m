Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5E65E687
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjAEIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjAEIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:14:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512158320;
        Thu,  5 Jan 2023 00:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672906437; bh=CGzT08iim77SF3hU99ejpjFf5EG6Rl2ItIprKmEgLtY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Ehs/8wo9Gks5PCvbWS3s9SW7nONzx6a38cyKKITH/xm+UQ4SBGl9zo98iW7+GqUPx
         yqX7sbOfwqXzV15gXzQZ5s5KW7mThPtfWJ5J/Lird24hj8nkwS/OZeZTqbdaNTxycQ
         FT1ilMhlDe+yv/o5JV2TQzRQs2CG91NgIdtadUrFT/+SjGVdyh/GZZkCJQRZ/cnXAr
         q5Xem7yR2E7coOcnkwk1WvvKoFpqe+1iE3Y9pb6w+L7LicgSKUpuHLnEitDdFsO8yd
         iH8dK1roQHprsdmtDh29TDeZEXCecPZ7Ko8ehQXu4RYCYviafVOYEzGX6JxCUBwdcD
         ycJAPQ3CkAkxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([92.116.173.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1okjjJ1BSC-016MjW; Thu, 05
 Jan 2023 09:13:57 +0100
Date:   Thu, 5 Jan 2023 09:13:55 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v6.2-rc3
Message-ID: <Y7aGw/irynC61O85@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:e6ixn9x3qrMQjq5CqimdU7JpgjsjVfDoNyoLBcb4EczLrtrNX2U
 ixFxDAtD48kLgFDrPNFAtl3EjKeMmGGy+mNWLbC368qglH80q7IJQc42I90nVdO3HoJWC5p
 LJR0PbX5gc/GC9llc6V6Sc3hKaoe0/xTDqY1wERRsxd/nqE+eftxoEKY5i1wUk3oZiFxrfi
 85AumXIc2Kq4aQ9JPAIEQ==
UI-OutboundReport: notjunk:1;M01:P0:OZlzwYr2Qw0=;IDBYe5yVimYZIWzoGw/RJniwNZo
 0uolB61iaJtJ7/PD9C8a1Mc1v4VCpRbKCogcoHML5XQ2mFzrOYEQkDeTUw4hUmgFTCd5ua5zV
 05yftmCaW0llhRpSSAEBGSnm/5uIwtkh0mVJU1A2jmPsJpvyw0ejaxm5+BemLXRoCjQgV18tZ
 W8AqN0RHL2+7Jg87Jagu3lDvhM7nm0FVbM/CKscnID5Rc6neheP9c/Pf1EsE+cezW5Ezjn624
 Gs50PmkbMsA3CEOFv/G6SsrtTFLj6L8zDyD4b1165OME9skmYdaQc+ZEUn91dJcFmc+xyeMvN
 QjemPbGRllKACic6Gk3r/nfzhse3i84yuz7KX0rpbgI4i5PE/+TfG/prDCvdzFfvSLLhPPYkp
 AtlJFY8dsu8CJC/otOnchry7zuhKwlbvlA3pW4piTvRJu6+Bzpj1Edzys095c3cXk372RB6Ry
 nDhRWbFyRI2Sbdlluw4rqC7UyDlopBM019uw3ZIa/eh0WeTrDtwxZEv+y7VH2HCyK8mTH4NlN
 4Tx+Bylc8wO4deDHuCw/O6vTw338HCS6qkiwN0/4aI5qqoQpP0VRCY+MuPNlTaaEAbXPNkRRF
 XTQy1F0/hPsySkLhTkfYJTmYoDfezsEDvxOTSha5oazarOm/TlNrEO17Wm1mFriZqkkeZ8Q2c
 xJo73OXF0d/JwVE9obNoUiZacFhq9UZlWRgSaPdBDA2j+CQreds5Hj8ODyFSldamrI3RflYsp
 0VP6q9r3r0GwVLkAniB+qakskzYqPbl6NrsBIyXLND33LtsniMtAldQLHs7WTAlTeJf9wNFIw
 Wvs5Xr2fBAKfskFRMlLux5bgl36+d7kLRlk99kVnwIiUtiFCU9yTZ4EsldIZPr+aBQnc/ME51
 4PF3Hdv5TYS7n7XPFC/Qj9+n1XrT8VYOK29zPFStjj1Jx6GshEosyjOUBB7o6dMQISFT/CiwS
 sT9Ygw==
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

please pull the fbdev driver updates for 6.2-rc3, to receive
fixes for matroxfb, offb, omapfb and fbmem.

Thanks,
Helge

----

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3

for you to fetch changes up to 764043cccd7232a783753a612d628fc0cb7854be:

  fbdev: omapfb: avoid stack overflow warning (2023-01-04 19:09:40 +0100)

----------------------------------------------------------------
fbdev updates for kernel 6.2-rc3:

- Fix Matrox G200eW initialization failure
- Fix build failure of offb driver when built as module
- Optimize stack usage in omapfb
- Prevent use-after-free in fbmem

----------------------------------------------------------------
Arnd Bergmann (1):
      fbdev: omapfb: avoid stack overflow warning

Hang Zhang (1):
      fbdev: fbmem: prevent potential use-after-free issues with console_lock()

Paul Menzel (1):
      fbdev: matroxfb: G200eW: Increase max memory from 1 MB to 16 MB

Randy Dunlap (1):
      fbdev: make offb driver tristate

Xu Panda (2):
      fbdev: omapfb: use strscpy() to instead of strncpy()
      fbdev: atyfb: use strscpy() to instead of strncpy()

 drivers/video/fbdev/Kconfig                |  4 ++--
 drivers/video/fbdev/aty/atyfb_base.c       |  3 +--
 drivers/video/fbdev/core/fbmem.c           |  2 ++
 drivers/video/fbdev/matrox/matroxfb_base.c |  4 ++--
 drivers/video/fbdev/omap/omapfb_main.c     |  5 ++---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++++++----------
 6 files changed, 27 insertions(+), 19 deletions(-)
