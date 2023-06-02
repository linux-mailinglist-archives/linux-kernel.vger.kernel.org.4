Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D271F928
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjFBENQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:13:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788997
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:13:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f5d651170so617117466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685679191; x=1688271191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIR8w9cgDXzXi7+1iKlCaAfcvOlfkoacHFLlw4+WQ2A=;
        b=LEHsExU4DVP+TUT5BXfeNgTtpxcaJOulSTjhhLWA8N3BT/YoGXKt86L7/Y+8jzGzkE
         bht0W80Ci1f9uuPcd7UjPpy2D0kb2M5ccCT6JNAr+8oCusxgQXb/4y60NKkp37asEown
         78msb8alKOlX7uzUgxri7VILKrTMLJ3VgJTs3XcBnH4lrHy802UsqXIFWXRg/N2PQSCi
         UG2zO7fd3Uh7GRxqqOUg5t8uUmXsGfXtw455gm9567fYiQNpoepuV8wDjif0wQOVnK8+
         AAkwtN3UzDxkByCAY+cgOzQRNeEs7znMCqAK8xV7lvb9NifZ0YWXLDQrCMGiQnD4r7H5
         05lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679191; x=1688271191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIR8w9cgDXzXi7+1iKlCaAfcvOlfkoacHFLlw4+WQ2A=;
        b=atehH6UBs3+JycKsLc5xVaxJjxbC8n+OatKaZBIv2CBYtrlRZpWxldxMPgU/KAnhra
         zfYHuO6Q82jLOk0qgqZxFicr9MKUQKQNv82/I3eAW6uImPKxJz/xq4p0Ispq/1JXzNDj
         eykR/AQONGzAdgkPdyqa0raSB2xDRGGlMn592hDo+70Z/m8IvxJD0Ey+EIPjT6l/fvih
         9N7disNbXCtlEpARSgELk5h1njKOG7cMrTSx5cbhIXn2u+b9XfQdk5L2pTsj8q0JC2KO
         b6RUGZIRDJVsUaaMSZi84PtsD77+tzTeFX/LcY213CHJvweyi6UVvObX5C9PSaU0xTYA
         OEFg==
X-Gm-Message-State: AC+VfDwP7Gy4CK8HdTbuPlCYevbiKLO8ksfM66eTDy2sr9VeHIZIRFBK
        kY8pVPXP6QhAdRC2burz/wZkU3sg7h6J+r6bxv0sQmt4wkz4sg==
X-Google-Smtp-Source: ACHHUZ4rbz+JEdNRv4AU0sSdE8gqFvZJ4o6EWuNPRzcMgNzr0FUIlsrkJgw32WWDPPsFL8l6CDbOh7NVAvDfdeGCypI=
X-Received: by 2002:a17:907:6e8e:b0:96f:b40a:c85f with SMTP id
 sh14-20020a1709076e8e00b0096fb40ac85fmr4132435ejc.23.1685679191267; Thu, 01
 Jun 2023 21:13:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 2 Jun 2023 14:12:59 +1000
Message-ID: <CAPM=9tyD7t3pBvY9PN5g8M3KN-y7i-cNHwtoR3x5-f=-U+fAEw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.4-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Quiet enough week, though the misc fixes tree didn't get to me when I
was sending this, so maybe it'll be a bit bigger next week, just one
i915 fix and some scattered amdgpu fixes.

Dave.

drm-fixes-2023-06-02:
drm fixes for v6.4-rc5

amdgpu:
- Fix mclk and fclk output ordering on some APUs
- Fix display regression with 5K VRR
- VCN, JPEG spurious interrupt warning fixes
- Fix SI DPM on some ARM64 platforms
- Fix missing TMZ enablement on GC 11.0.1

i915:
- Fix for OA reporting to allow detecting non-power-of-two reports
The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4=
:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-02

for you to fetch changes up to b6ccf213d95e9373ac1f7fbcb5de3b52eec0ddb3:

  Merge tag 'drm-intel-fixes-2023-06-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-06-02
10:33:29 +1000)

----------------------------------------------------------------
drm fixes for v6.4-rc5

amdgpu:
- Fix mclk and fclk output ordering on some APUs
- Fix display regression with 5K VRR
- VCN, JPEG spurious interrupt warning fixes
- Fix SI DPM on some ARM64 platforms
- Fix missing TMZ enablement on GC 11.0.1

i915:
- Fix for OA reporting to allow detecting non-power-of-two reports

----------------------------------------------------------------
Ashutosh Dixit (1):
      drm/i915/perf: Clear out entire reports after reading if not
power of 2 size

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-6.4-2023-05-31' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2023-06-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Guchun Chen (1):
      drm/amd/pm: resolve reboot exception for si oland

Horatio Zhang (6):
      drm/amdgpu: separate ras irq from vcn instance irq for UVD_POISON
      drm/amdgpu: add RAS POISON interrupt funcs for vcn_v2_6
      drm/amdgpu: add RAS POISON interrupt funcs for vcn_v4_0
      drm/amdgpu: separate ras irq from jpeg instance irq for UVD_POISON
      drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v2_6
      drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v4_0

Ikshwaku Chauhan (1):
      drm/amdgpu: enable tmz by default for GC 11.0.1

Michel D=C3=A4nzer (2):
      Revert "drm/amd/display: Block optimize on consecutive FAMS enables"
      Revert "drm/amd/display: Do not set drr on pipe commit"

Tim Huang (5):
      drm/amd/pm: reverse mclk and fclk clocks levels for SMU v13.0.4
      drm/amd/pm: reverse mclk clocks levels for SMU v13.0.5
      drm/amd/pm: reverse mclk and fclk clocks levels for yellow carp
      drm/amd/pm: reverse mclk and fclk clocks levels for vangogh
      drm/amd/pm: reverse mclk and fclk clocks levels for renoir

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           | 27 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 27 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             | 28 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             | 28 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              | 25 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              | 36 ++++++++++++++++++=
----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  9 ------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 25 +--------------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         | 29 -----------------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 10 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  5 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  5 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |  5 +--
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |  5 +--
 drivers/gpu/drm/i915/i915_perf.c                   | 17 ++++++----
 18 files changed, 184 insertions(+), 106 deletions(-)
