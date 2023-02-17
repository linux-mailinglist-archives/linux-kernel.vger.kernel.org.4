Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25C69A3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBQCQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBQCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:16:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA54FC99
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:16:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a10so10095903edu.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fleu3eWQmq1EyyJbxNWRjiNo9YtMIm/LD1NXhbIpFI=;
        b=WzUDtfVQZCfZkov7p2aFlIp3CvIx/XJ6F9HK/Ke2SQKK4tGDA/M1at8A3Qw5xiRCNZ
         1yboXzdF3Y6YTwVgb52fCxEN70XT99MLMDBAew+R0uZJ84TMPHVZXno3SLgmXoV5pWlI
         Wx5Ba4jSWDx18xwjXqQpMOj37IBVz3ni1nUOIU5OPo94w5g/Jb0/yyfRrVtFzSlNI0mv
         kD1oZRT+oWpljE+XsUS1lhjx53N874DflBcduNYcgD27WBLO8tk5zJGXcAc8zieGyjHe
         TlyJs7/cwoQRoq+JBPHSBFgIRTBV28i+bWVM532emTgkPkSJ00KsdjOmp0ZYhbzXfQoY
         MKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fleu3eWQmq1EyyJbxNWRjiNo9YtMIm/LD1NXhbIpFI=;
        b=BMNjrHquTqSXvaAASD3VLZQSUSc981sZFIo//ahC6wG6KCBVPd9DqA0a0CupfiC3s6
         uyqP98LA3yq+oLYevPxwrEM+bz0bdv9OvcJAWElTpBvrfmnhaI/jbd0XvGFU7D/d7PZg
         3KozejA3zjE3jwB7DunGuFTlVhX0Hm1Qch8l8FR4uHawiwoM+0AiuFTNtn9RuTE7TwXV
         p//wub1lUSeMmCTUMKXlx+kwU9sjrbJQrObHAdsRjTGUNSVmHPFlsabmEx+zLWIkllmk
         Mk5SYN1abPb0Q+kmOMtg4q4/km3dQ/+AlkHiXrabip6i0NaMGm6TpadzgN+UsJaHlcLX
         Ldrg==
X-Gm-Message-State: AO0yUKV/Jbg2jgUVZlXIypt4vJHoNs5Z+DIXA+CrMxxBYohbZQ0OfEXc
        YjBWsLsEAq1tnkcGOgk5Y4/DM8aX8sp7RtoeVhtZDY2gdb5q9w==
X-Google-Smtp-Source: AK7set/bNjGZtw3xbyJD/URRlSVf+tyyUs/+md4k0sWA36DxWiPq1X8ItmEQ3pCbfxYpVn841dD1plqIS7faRsZmzsw=
X-Received: by 2002:a17:907:3d91:b0:8af:2e89:83df with SMTP id
 he17-20020a1709073d9100b008af2e8983dfmr3052167ejc.6.1676600207241; Thu, 16
 Feb 2023 18:16:47 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Feb 2023 12:16:34 +1000
Message-ID: <CAPM=9tyvvUJiuADGfPznEKCNBmwGzPEKE7Oob_9BduxE6Od4TQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.2 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just a final collection of misc fixes, the biggest disables the
recently added dynamic debugging support, it has a regression that
needs some bigger fixes. Otherwise a bunch of fixes across the board,
vc4, amdgpu and vmwgfx mostly, with some smaller i915 and ast fixes.

Dave.

drm-fixes-2023-02-17:
drm fixes for 6.2 final

drm:
- dynamic debug disable for now

fbdev:
- deferred i/o device close fix

amdgpu:
- Fix GC11.x suspend warning
- Fix display warning

vc4:
- YUV planes fix
- hdmi display fix
- crtc reduced blanking fix

ast:
- fix start address computation

vmwgfx:
- fix bo/handle races

i915:
- gen11 WA fix
The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a=
:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-17

for you to fetch changes up to f7597e3c58eeb9ce534993f53c982f2e91e6dd4d:

  Merge tag 'drm-intel-fixes-2023-02-16' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-02-17
09:50:06 +1000)

----------------------------------------------------------------
drm fixes for 6.2 final

drm:
- dynamic debug disable for now

fbdev:
- deferred i/o device close fix

amdgpu:
- Fix GC11.x suspend warning
- Fix display warning

vc4:
- YUV planes fix
- hdmi display fix
- crtc reduced blanking fix

ast:
- fix start address computation

vmwgfx:
- fix bo/handle races

i915:
- gen11 WA fix

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.2-2023-02-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2023-02-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-02-16' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dave Stevenson (1):
      drm/vc4: Fix YUV plane handling when planes are in different buffers

Dom Cobley (2):
      drm/vc4: hdmi: Always enable GCP with AVMUTE cleared
      drm/vc4: crtc: Increase setup cost in core clock calculation to
handle extreme reduced blanking

Jack Xiao (1):
      drm/amd/amdgpu: fix warning during suspend

Jocelyn Falempe (1):
      drm/ast: Fix start address computation

Leo Li (1):
      drm/amd/display: Fail atomic_check early on normalize_zpos error

Matt Roper (1):
      drm/i915/gen11: Wa_1408615072/Wa_1407596294 should be on GT list

Takashi Iwai (1):
      fbdev: Fix invalid page access after closing deferred I/O devices

Ville Syrj=C3=A4l=C3=A4 (1):
      drm: Disable dynamic debug as broken

Zack Rusin (2):
      drm/vmwgfx: Stop accessing buffer objects which failed init
      drm/vmwgfx: Do not drop the reference to the handle too soon

 drivers/gpu/drm/Kconfig                           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +++++-
 drivers/gpu/drm/ast/ast_mode.c                    |  4 ++--
 drivers/gpu/drm/i915/gt/intel_workarounds.c       | 14 +++++++-------
 drivers/gpu/drm/vc4/vc4_crtc.c                    |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                    | 18 +++++++++---------
 drivers/gpu/drm/vc4/vc4_plane.c                   |  6 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                | 12 ++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |  2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c               |  8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |  4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c           |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c            |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c           | 10 ++++++----
 drivers/video/fbdev/core/fb_defio.c               | 10 +++++++++-
 drivers/video/fbdev/core/fbmem.c                  |  4 ++++
 include/linux/fb.h                                |  1 +
 19 files changed, 73 insertions(+), 38 deletions(-)
