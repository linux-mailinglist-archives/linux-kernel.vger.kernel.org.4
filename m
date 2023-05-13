Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C0701ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjEMXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:32:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF61707;
        Sat, 13 May 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684020733; i=deller@gmx.de;
        bh=SRmDwUFqGUcQmCnmVWdS3FEsmlpLAJuYjqZvx9svZa0=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=MUZDoRyghQbYkqc71wT+L6/Ve/TGOn4h9Mc4mA5SfVN7mElJ/9MrnjlrhtayJNtRP
         N2hWtlaEs0npo2zGrsQahuItDrWusbnP2iCEPEm3DUg1x5oh5DPJ7fjLiXTOUfoWqx
         TfDbKF2A8vGLj1aFQr6nVN73pUNuXksZUKcilibSw1FJ5fPSSXIt6NHkSsKTvYmDUx
         bIt/7Pl1lKAPQzxvUmR3zm0N8bHYewQJtK9no3aAOUhnJbccdbHxMtMyolaeeO4Z7R
         Xp+ZEwW4b1bG9JEh9/W+F6WIUaQS+3k88Mv8B55cmt+B4LBXc6cXVTn4RK3SV7PuBl
         P0D40rVZNrfxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([94.134.158.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1prxMl1MFu-00BfUo; Sun, 14
 May 2023 01:32:13 +0200
Date:   Sun, 14 May 2023 01:32:11 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.4-rc2
Message-ID: <ZGAd+wWXxlA+zvSs@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:e5kq1JmyenAeohlC4uy0CW15Z5i3kYHetAUwTdkjat9XA5IclU5
 IadjSQLKnhJNFA2V+rmGhlCt6w8+QDXJyVCuHnkZX/VEwIqOc6cKNXa7I44NLuybB0xt8+P
 xCGFufl47siRAn9dX9OEJ0I7qUyHc9wrwUgXJaHWtq9v3uHQozWa5sRxFHxrhIW1eQGokig
 +cH358Q7Cx9txsXUIAAHA==
UI-OutboundReport: notjunk:1;M01:P0:NS4rebfBi/8=;M6/vgmVt1dUOUVYXMhgXDFl6FXN
 KGFO6Vj85QYSRloEdVkgZCfbwBXXcVi4boSxTrBEgEtYjxectLEGhAlSRZNZ8bLu+GUN+B9iO
 3AfLP7Qi3++gkY3otYCWPI+JRHUPLwWmR+kts2FdKnHJTXfr3cmZOcvInqB4o4qxpcmGSJTbL
 4U9oGg08Ysnj6fsiTppYm/ZIjxsZWFRy0+Ds2vDfAE90QKJ9B+CbtCuED31MAJiMR2hylaFRh
 qCXvOczMiLvPxOjFautZixb8puyWTIPg7FFn/y6RvHbv2cV5JJmynCVX4kcsmHvcy1jB2RkU4
 z9dBOQxyaTs2sHwiavWS5tozlwik/KizTntJeqL1mfUsouhlA6mDLd7dErsWOmoOMQYliWHYY
 vbRS19D/LHURO0vamn9bD43CKS8SJnKWZ19kS4O7hM63kUj9+KYdexrGZqQz5KiWEAN6l+IPg
 mWPeayRfvgDKRhGasVCbVJd9VP3NGoCsy0+UZcSy2aI7kRuD8iZdepFvcIxw44SnqGtVog1ji
 Vbi9bQ/9X9Dq8Mv1tQG2239X0j78gLl7CJTdmbPDdGpG8dFIeLIEDh8uVnyN8omGlU6mlP4rX
 YvymRGqBmrAaIWrTcLAu4vIBa8ysF1ss+f6CeeuAWPAAR+DdZkYFz+fjl547Z/t68R0PlUVqI
 PCg5qAyX7YUKacU0KxaWC5ufOLaMqux2iRjMn/LBSPQbjT37dxedFl44qT7hepHchJx/+YtPh
 YSUBCLjmAxz3xponeg0q/8apTNYKaAxqoTXQoE1rIO/66ybxbT1DFBmPaCJ/xykRnXa2FcKpP
 QHWUqwyFGKnnR8+H71tXkxcHtz8guExGq68ffs/mm2SBU748R5DeKtKofTTuiqLGDPl1h7Pft
 WJE0bAA5eUVJpnt1g4Ow7e+11TiH6GQlc9f0aJ40U96TKwMhUWHT/fi8amaDmFPhghfsDBokH
 THy1Sw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc2

for you to fetch changes up to 0bdf1ad8d10bd4e50a8b1a2c53d15984165f7fea:

  fbdev: stifb: Fix info entry in sti_struct on error path (2023-05-12 11:50:33 +0200)

----------------------------------------------------------------
fbdev fixes and updates for kernel 6.4-rc2:

- use after free fix in imsttfb (Zheng Wang)
- fix error handling in arcfb (Zongjie Li)
- lots of whitespace cleanups (Thomas Zimmermann)
- add 1920x1080 modedb entry (me)

----------------------------------------------------------------
Helge Deller (2):
      fbdev: modedb: Add 1920x1080 at 60 Hz video mode
      fbdev: stifb: Fix info entry in sti_struct on error path

Thomas Zimmermann (15):
      fbdev: 68328fb: Remove trailing whitespaces
      fbdev: atmel_lcdfb: Remove trailing whitespaces
      fbdev: cg14: Remove trailing whitespaces
      fbdev: controlfb: Remove trailing whitespaces
      fbdev: g364fb: Remove trailing whitespaces
      fbdev: hgafb: Remove trailing whitespaces
      fbdev: hpfb: Remove trailing whitespaces
      fbdev: macfb: Remove trailing whitespaces
      fbdev: maxinefb: Remove trailing whitespaces
      fbdev: p9100: Remove trailing whitespaces
      fbdev: platinumfb: Remove trailing whitespaces
      fbdev: sa1100fb: Remove trailing whitespaces
      fbdev: stifb: Remove trailing whitespaces
      fbdev: valkyriefb: Remove trailing whitespaces
      fbdev: vfb: Remove trailing whitespaces

Zheng Wang (1):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Zongjie Li (1):
      fbdev: arcfb: Fix error handling in arcfb_probe()

 drivers/video/fbdev/68328fb.c     |  12 +--
 drivers/video/fbdev/arcfb.c       |  15 ++--
 drivers/video/fbdev/atmel_lcdfb.c |   2 +-
 drivers/video/fbdev/cg14.c        |   2 +-
 drivers/video/fbdev/controlfb.c   |  34 ++++-----
 drivers/video/fbdev/core/modedb.c |   5 ++
 drivers/video/fbdev/g364fb.c      |   6 +-
 drivers/video/fbdev/hgafb.c       |  36 ++++-----
 drivers/video/fbdev/hpfb.c        |   8 +-
 drivers/video/fbdev/imsttfb.c     |  15 ++--
 drivers/video/fbdev/macfb.c       |  10 +--
 drivers/video/fbdev/maxinefb.c    |   2 +-
 drivers/video/fbdev/p9100.c       |   4 +-
 drivers/video/fbdev/platinumfb.c  |  30 ++++----
 drivers/video/fbdev/sa1100fb.c    |  32 ++++----
 drivers/video/fbdev/stifb.c       | 157 +++++++++++++++++++-------------------
 drivers/video/fbdev/valkyriefb.c  |  14 ++--
 drivers/video/fbdev/vfb.c         |  10 +--
 18 files changed, 202 insertions(+), 192 deletions(-)
