Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6CC5F8ABF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJIKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJIKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:49:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEF28715;
        Sun,  9 Oct 2022 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665312548;
        bh=9tw62jkaAE/5DMhlb+Rw7nroAjqsuNfhkDb8JdXGWvE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=iHk0Ob5tM1qvUvtSlCKiOCwNSC3E86rsM1kbhVEcoKADKjr1VIay3F1F08WAiRpoT
         wDY9e14ESxt+gBZNNcC2sk7R9oPIERl70Mu6aRqy+hNBW4XR8ODOyFLJNcUQQvQx6+
         qNeEVwijjsF8mfbl9YUKsFWKmjx0TvPKxwIUaLGc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.161.163]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1ow23a3qQn-00EaM9; Sun, 09
 Oct 2022 12:49:08 +0200
Date:   Sun, 9 Oct 2022 12:49:05 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v6.1-rc1
Message-ID: <Y0KnIfLe8WxtXc5c@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:kcrKBWACIMSXc8WglLRPxZtDvjATmQ7cjs3+tSAEoE2QImM2Y+6
 afhnoNl4jlBUZnz0ZNZFy6P6PdrWenJyNhNs+Ftrq/WTrz8FbFEKNWB3wdk0jZqKm8cbsyV
 HN59fKCj4KSFRAdJ7rEDkbf+1JRXdoyb+vsOIulugU81NlfLZf8P29C9/yOn2EFl7vrityo
 t760sa4DV6bTHkwoTVPKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g3nhewARNMg=:VhaddTOXN1ntXfBhvCxPI2
 nmPLLtH3/s+TkMmOQoy7QDH7DEzhGso2RUF2/R3WoEOIIsvVhKpVCR/e/jNT6IwxDwbes4y7D
 xJ6nXhnpwG+TCt0y4Dr5e++41cNL39EotY5V9TmcvJZTOa+t35+XgwnxZDi22iNYuPUCtD7R1
 B6UVtZeAP3ORciJiNL6zl5dPpKCTdebqwVQSCT/z4Fx2DZ3M5H72d2l7wMS5lwrhNgbzdrSIs
 LuqkOjyU2oGcFm9JnUea0sA5x/G3N1p/wlM4OGcG20zdgKNb10l3fWRgcZ3EK+siQqprPs85E
 T2cl/aA51pcMmQNfAhig5RBsnfRZbBGIcTXnPm3IkpeQvuZpA8HzB13tD1IfsKuBKtydiLRmr
 QM8Hkok2s0awjTZsxnbCzGHa3ceDlZwRgRz3WA62fkdOmbNZrIMTb/e3wy+V4Kn6ojq7NxqC0
 Je54H6zGsf9I/I5sRtAbr9r5KDXdiW5XIPH2apbYGwMCNciNK+dZksiugKXqI84R8snFqzF7v
 yCZG5YlCU/GCPCZnyUBVyqgj+g/00bk+FrX1pSLgsOEFNQTDQezyONJ1AFY/mQUCe0v/sXFPM
 gD3horUZk+sfycHIViBEPQfV9w0H9w3uVd+KU7U8JDmfxJPsWaNCWyyzjItsTJw2yxjW+3K9q
 b60/PXwgJlPFHhTztN2+tucLSjI6dk4tkrk8osPKjy2DLC4h0GDn8BAgVC0NYh+cDt9ZV8RDx
 5bVx9zdTpO8wox+3sLueMqggSKmiF12M5K8PGqJRyoldiOlXfwa9TK3pQleAX04dxSQ0znOt6
 Hiew0qzhDYKVyut2hulQUTdsXPFDrVRlEvdQryRLnWhwbUUwP2UQ5JbTh5wSb8sgJe/immNmO
 gNx6iSAua16rOLD9/4QXtKnxLbY4nTwVqVJc9Y8SxoZbJFt3HEwb6lzvZDFsCAixNQoI2H58n
 FcIoF4jPYcqAcGi4qrL3nf5NZ2foqomFjvdAAi2uihHP5AamEaTM68ocNebdWYYgGSWowkSaL
 D9Q/ccPUPC4ry9T93hrxgdYn700cByFkHXCkn4ul71lIaHglgEQuG7s/KjmJFCRKpml/l0Y52
 4GztVET2XX2msz7K9gspAvPG08kEAsAYIyoY+pJGm0qaCXYA6h7SbIhALRuavasb0ZRiJGVpc
 3SHFw0bSZgHbdHso09XPq2mDSQg3AaeXhKVLpIqFjB5NULl/286d1qc/DFbRKqnII6q9T1OCI
 6+QPxUelzivrDnrt6DijkM6HYd1K3jzxPz33Zdz2KaLl/TwJjrtRoQx2sp+O1VCNSBm2DYNRZ
 JYoP4tx8gBgBpds1ygcErpLEc2s1QMIKArqCimANBbzJoCnUUroW6AMFxyeHDDjpUDflzfLIK
 drSO4a9sDk8t/o+SAkTuUBr59dlYx7WFRVvKQpFGPoLV2HZCWpukNJR/dpldQUZWCuKoNrtXD
 hB3VNNFHbSuEg0op5lXH9d2MyJqzNKIVEvIAPVi1LcnIlWZ+hwrUuZULwUo+38BETneov3mDn
 brV01I6wWRN/4hPKS/mr9AU212Twjo7mRXaCNmVNKrTkv
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the fbdev fixes and updates for kernel 6.1-rc1.

Included is a fix for the smscufx USB graphics card to prevent a kernel crash
if it's plugged in/out too fast.  The other patches are mostly small cleanups,
fixes in failure paths and code removal.

More details are in the commit tag.

Thanks,
Helge


The following changes since commit e8bc52cb8df80c31c73c726ab58ea9746e9ff734:

  Merge tag 'driver-core-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2022-10-07 17:04:10 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc1

for you to fetch changes up to 29926f1cd3535f565f200430d5b6a794543fe130:

  fbdev: mb862xx: Fix check of return value from irq_of_parse_and_map() (2022-10-08 15:20:09 +0200)

----------------------------------------------------------------
fbdev fixes and updates for kernel 6.1-rc1:

- fixes an use-after-free in smscufx USB graphics driver,
- adds missing pci_disable_device() in tridentfb failure paths,
- correctly handle irq detection failure in mb862xx driver,
- fixes resume code in omapfb/dss,
- drops unused code in controlfb, tridentfb, arkfb, imxfb and udlfb,
- converts uvesafb to use scnprintf() instead of snprintf(),
- converts gbefb to use dev_groups,
- adds MODULE_DEVICE_TABLE() entry to vga16fb

----------------------------------------------------------------
Christophe Leroy (1):
      fbdev: mb862xx: Fix check of return value from irq_of_parse_and_map()

Colin Ian King (1):
      fbdev: udlfb: Remove redundant initialization to variable identical

Hyunwoo Kim (1):
      fbdev: smscufx: Fix use-after-free in ufx_ops_open()

Jiapeng Chong (3):
      fbdev: controlfb: Remove the unused function VAR_MATCH()
      fbdev: tridentfb: Remove the unused function shadowmode_off()
      fbdev: arkfb: Remove the unused function dac_read_reg()

Jiasheng Jiang (1):
      fbdev: gbefb: Convert to use dev_groups

Jules Irenge (1):
      fbdev: uvesafb: Convert snprintf to scnprintf

Ruan Jinjie (1):
      fbdev: tridentfb: Fix missing pci_disable_device() in probe and remove

Shang XiaoJing (1):
      fbdev: imxfb: Remove redundant dev_err() call

Zeng Heng (1):
      fbdev: vga16fb: Add missing MODULE_DEVICE_TABLE() entry

Zhang Qilong (1):
      fbdev: omapfb/dss: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

 drivers/video/fbdev/arkfb.c                  |  8 --------
 drivers/video/fbdev/controlfb.c              |  7 -------
 drivers/video/fbdev/gbefb.c                  | 20 +++++++-------------
 drivers/video/fbdev/imxfb.c                  |  1 -
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c   |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/dss.c   |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/venc.c  |  6 ++----
 drivers/video/fbdev/smscufx.c                | 14 +++++++++++++-
 drivers/video/fbdev/tridentfb.c              | 11 +----------
 drivers/video/fbdev/udlfb.c                  |  2 +-
 drivers/video/fbdev/uvesafb.c                | 10 +++++-----
 drivers/video/fbdev/vga16fb.c                |  1 +
 16 files changed, 41 insertions(+), 71 deletions(-)
