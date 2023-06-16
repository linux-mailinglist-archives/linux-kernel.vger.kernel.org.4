Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4DB733ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjFPU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjFPU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:29:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF235B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:29:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d55ac17bso164299966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686947384; x=1689539384;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lAJJYNFFc8IT/vHtC2ZjekUTu3gsWCsBhPsAUbzPFWA=;
        b=WvGfMjGQTQBc4JJ91CKVIaX/k58ocqaW26UdALAee0U7J6ETejHVniNgmOJW5yx/n/
         9nJaJ+Atq2a7ZbJStMKExIl8lxl7YTDVFYVO95J3KWRhTPh4xrJBI/0HShIQkR/bQFna
         RDAdXkK2QJbx5VlU0H4jGoEjIkobuIaMUh5lI/EMpPXmkbDyH/j0wi4rzJhv4Ztp140e
         b+xKkPcj5fYet2si5mczTPivZzPjKaHRUDYPbgPjmIVZz0FfI4PgyY5T943m6udCZrHX
         R2MDo9ydZP/G5sj/de7fARszLkvG9j1lcFtWXE7ti+Ngv5/UWc+pikE6RVMUAFrG3TeW
         Y4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947384; x=1689539384;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAJJYNFFc8IT/vHtC2ZjekUTu3gsWCsBhPsAUbzPFWA=;
        b=Zn4Xq5MkniEit/lNInq7pDNDQc4UmWAF5MVM90o68ab2cx3zxBcDhHTLaZ+BWnMEh6
         4U6uscvinN98X2qnZu0sig8/Ycmm+lUTT3wYG+wrYSV7tvNQWPDpfFiJgLFLFuEnb9CM
         o8sVzgu2PjxwlFt/Gs32mEZm6is4y6RZjfdE0phkzBrLeAbsAfD5ZZ6fESYCFMrrsSY/
         8AqwONo2r2wZYffRhN/fApzP5qMm0KJEBssLPrmZtFCDxz0uwRUVJ7SaghiOQ7eZTHL+
         DTAqGFaLe4CHn+LfiJu6BNlZvdl2QSX8aGQhllOw+BUp69taYhvIUwWsvxpYC2Qnwi+2
         tleQ==
X-Gm-Message-State: AC+VfDx9DUvBkaddp6n7hBFviOd0+BagwrBnyEjVMn3veRgwt7QttFA/
        EwO17LOtRjNcuKXpHmLMElr87z1rKymWonI5XMQ=
X-Google-Smtp-Source: ACHHUZ6mZ+wKwqXLlQHDwPWYNpOJslTTh49rtVaJrzkNfIXoGuZ6g04DxonTKWVfDs1N+/qeypFhIsBmNRHxs9c1bGM=
X-Received: by 2002:a17:907:320d:b0:974:1c90:b3d3 with SMTP id
 xg13-20020a170907320d00b009741c90b3d3mr2766774ejb.12.1686947383936; Fri, 16
 Jun 2023 13:29:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 17 Jun 2023 06:29:31 +1000
Message-ID: <CAPM=9txbkXVgrbDbqezqBVLVXdBx4+iwfJPTVWLzWuGtDsTT_w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.4-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Bunch of misc fixes across the board, amdgpu is the usual bulk with a
revert and other fixes, nouveau has a race fix that was causing a UAF
that was hard hanging systems, otherwise some qaic, bridge and radeon.

Dave.

drm-fixes-2023-06-17:
drm fixes for 6.4-rc7

amdgpu:
- GFX9 preemption fixes
- Add missing radeon secondary PCI ID
- vblflash fixes
- SMU 13 fix
- VCN 4.0 fix
- Re-enable TOPDOWN flag for large BAR systems to fix regression
- eDP fix
- PSR hang fix
- DPIA fix

radeon:
- fbdev client warning fix

qaic:
- leak fix
- null ptr deref fix

nouveau:
- use-after-free caused by fence race fix
- runtime pm fix
- NULL ptr checks

bridge:
- ti-sn65dsi86: Avoid possible buffer overflow
The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-17

for you to fetch changes up to 9930f518b6a82ff10a3d13e0cbde05cce04f5930:

  Merge tag 'drm-misc-fixes-2023-06-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-06-17
06:11:59 +1000)

----------------------------------------------------------------
drm fixes for 6.4-rc7

amdgpu:
- GFX9 preemption fixes
- Add missing radeon secondary PCI ID
- vblflash fixes
- SMU 13 fix
- VCN 4.0 fix
- Re-enable TOPDOWN flag for large BAR systems to fix regression
- eDP fix
- PSR hang fix
- DPIA fix

radeon:
- fbdev client warning fix

qaic:
- leak fix
- null ptr deref fix

nouveau:
- use-after-free caused by fence race fix
- runtime pm fix
- NULL ptr checks

bridge:
- ti-sn65dsi86: Avoid possible buffer overflow

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: add missing radeon secondary PCI ID

Arunpravin Paneer Selvam (1):
      Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM in
large bar system"

Carl Vanderlip (1):
      accel/qaic: Free user handle on interrupted mutex

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.4-2023-06-14' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      nouveau: fix client work fence deletion race
      Merge tag 'drm-misc-fixes-2023-06-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Hersen Wu (1):
      drm/amd/display: edp do not add non-edid timings

Jeffrey Hugo (1):
      accel/qaic: Fix NULL pointer deref in qaic_destroy_drm_device()

Jiadong Zhu (4):
      drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled
      drm/amdgpu: Program gds backup address as zero if no gds allocated
      drm/amdgpu: Modify indirect buffer packages for resubmission
      drm/amdgpu: Implement gfx9 patch functions for resubmission

Kenneth Feng (1):
      drm/amd/pm: workaround for compute workload type on some skus

Mario Limonciello (2):
      drm/amd: Make sure image is written to trigger VBIOS image update flow
      drm/amd: Tighten permissions on VBIOS flashing attributes

Natalia Petrova (2):
      drm/nouveau/dp: check for NULL nv_connector->native_mode
      drm/nouveau: add nv_encoder pointer check for NULL

Peichen Huang (1):
      drm/amd/display: limit DPIA link rate to HBR3

Ratchanan Srirattanamet (1):
      drm/nouveau: don't detect DSM for non-NVIDIA device

Sonny Jiang (1):
      drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1

Su Hui (1):
      drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow

Thomas Zimmermann (1):
      drm/radeon: Disable outputs when releasing fbdev client

Tom Chung (1):
      drm/amd/display: fix the system hang while disable PSR

 drivers/accel/qaic/qaic_drv.c                      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c       |  60 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h       |  15 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 101 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  18 +++-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   5 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  33 ++++++-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   4 +
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   7 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  14 ++-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |   1 +
 18 files changed, 281 insertions(+), 27 deletions(-)
