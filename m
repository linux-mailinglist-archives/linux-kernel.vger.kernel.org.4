Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE36BE261
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCQIAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjCQH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:59:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D84A6EA5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:59:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so17067017ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679039989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTwMRJdhGe31kDjhW7XpFyQAnvk9BcM+HYPahuAYzpw=;
        b=CpddVoc4qxRqizv0MtPjAU+tLyAkFhG+UmKNPemgnvtUQ/Tj7NhlNeW8pVj45N8JD1
         vkyHvf0nVhFoLBon79BIqpUmjSDmR1rbT5aCaSdc2Cgvf/utZ9nlETaeOP56cD1BbiTr
         xgFznm5L7EKZsKD+lc7er/ELzyeOzDff1wnYAIyrHfJjyPiiJxusnk1ekuTjYno645WO
         h5kLwrgdlcVC2xRnTtSu1qrKVtBXRo7VYkNYpssWt1KE9XsN6k982N3TW2IyioGKy6rB
         Luib+iK01V47nTS48bukjGt/EgHKw6FosdSne+bLtU/cOlqad3ChB4sIyhPtpPpjcps3
         GPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679039989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTwMRJdhGe31kDjhW7XpFyQAnvk9BcM+HYPahuAYzpw=;
        b=ZCggXt5/UQf6xd6Xts/gUftCOKJClmkA2SV09r8sUHvokUu4xcZ0Tc4okh9Ke4pNY7
         D+1kPgGyHyxb6FuQPtxzW/EULuEEQetdFQTUeor/Y3+lhCe6FlNW9e+OR9Je4tvpEZp3
         864hjV6D+D4LldoywbNWJQiCtn5wcsVVhymATHqJUsKeSYAPAXZZ/faUSzuVgfYdIBBF
         cSm15+oszbBCbFLH+VS4/SYzzEV4L3fDCM1PWfMaP/x0fCyimf7t6Vwh0LybLjJpcndv
         V8dHlsoFfszCVXKtzvJmiIBkMbsJ2i7VyW+e40kTgPJN0NpagbaNPYDviTaTavKyg1Vq
         UGvg==
X-Gm-Message-State: AO0yUKXHWat7iIwFpU9pMyTymInrt6yzSoFKDvDiLWE9q3DmzwO2vaj5
        Zzhh5SWRKFOaHShMXeSZrtzU39zxIkXQGUn50wk=
X-Google-Smtp-Source: AK7set8eUYgBKOXK0K8GBMsN88AugxBPsb8Aihun02pYPY4cagVbaRcAWM2I439XvlJFFcH69I4QhKXQmjn990UTkts=
X-Received: by 2002:a17:907:d13:b0:8e6:266c:c75e with SMTP id
 gn19-20020a1709070d1300b008e6266cc75emr6846449ejc.14.1679039988708; Fri, 17
 Mar 2023 00:59:48 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Mar 2023 17:59:36 +1000
Message-ID: <CAPM=9tyVZZgr8S+Bfx6cyF2ied2btog7Y6FkDoteF+JFv__rgw@mail.gmail.com>
Subject: [git pull] drm fixes for v6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Seems like a pretty regular rc3, i915 and amdgpu with the usual
selection of fixes, then a scattering of fixes across misc drivers and
other areas.

Dave.

drm-fixes-2023-03-17:
drm fixes for v6.3-rc3

accel:
- build fix for accel

edid:
- fix info leak in edid

ttm:
- fix NULL ptr deref
- reference counting fix

i915:
- Fix hwmon PL1 power limit enabling
- Fix audio ELD handling for DP MST
- Fix PSR io and wake line calculations
- Fix DG2 HDMI modes with 267.30 and 319.89 MHz pixel clocks
- Fix SSEU subslice out-of-bounds access
- Fix misuse of non-idle barriers as fence trackers

amdgpu:
- SMU 13 update
- RDNA2 suspend/resume fix when overclocking is enabled
- SRIOV VCN fixes
- HDCP suspend/resume fix
- Fix drm polling splat regression
- Fix dirty rectangle tracking for PSR
- Fix vangogh regression on certain BIOSes
- Misc display fixes
- Suspend/resume IOMMU regression fix

amdkfd:
- Fix BO offset for multi-VMA page migration
- Fix a possible double free
- Fix potential use after free
- Fix process cleanup on module exit

bridge:
- fix returned array size name documentation

fbdev:
- ref-counting fix for fbdev deferred I/O

virtio:
- dma sync fix

shmem-helper:
- error path fix

msm:
- shrinker blocking fix

panfrost:
- shrinker rpm fix

chipsfb:
- fix error code

meson:
- fix 1px pink line
- fix regulator interaction

sun4i:
- fix missing component unbind

     * driver fixes
The following changes since commit eeac8ede17557680855031c6f305ece2378af326=
:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-17

for you to fetch changes up to c00133a9e87ea5324d0b883d801eb6656f26739b:

  drm/ttm: drop extra ttm_bo_put in ttm_bo_cleanup_refs (2023-03-17
16:06:58 +1000)

----------------------------------------------------------------
drm fixes for v6.3-rc3

accel:
- build fix for accel

edid:
- fix info leak in edid

ttm:
- fix NULL ptr deref
- reference counting fix

i915:
- Fix hwmon PL1 power limit enabling
- Fix audio ELD handling for DP MST
- Fix PSR io and wake line calculations
- Fix DG2 HDMI modes with 267.30 and 319.89 MHz pixel clocks
- Fix SSEU subslice out-of-bounds access
- Fix misuse of non-idle barriers as fence trackers

amdgpu:
- SMU 13 update
- RDNA2 suspend/resume fix when overclocking is enabled
- SRIOV VCN fixes
- HDCP suspend/resume fix
- Fix drm polling splat regression
- Fix dirty rectangle tracking for PSR
- Fix vangogh regression on certain BIOSes
- Misc display fixes
- Suspend/resume IOMMU regression fix

amdkfd:
- Fix BO offset for multi-VMA page migration
- Fix a possible double free
- Fix potential use after free
- Fix process cleanup on module exit

bridge:
- fix returned array size name documentation

fbdev:
- ref-counting fix for fbdev deferred I/O

virtio:
- dma sync fix

shmem-helper:
- error path fix

msm:
- shrinker blocking fix

panfrost:
- shrinker rpm fix

chipsfb:
- fix error code

meson:
- fix 1px pink line
- fix regulator interaction

sun4i:
- fix missing component unbind

     * driver fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/nv: fix codec array for SR_IOV

Andrea Righi (1):
      drm/i915/sseu: fix max_subslices array-index-out-of-bounds access

Ankit Nautiyal (1):
      drm/i915/dg2: Add HDMI pixel clock frequencies 267.30 and 319.89 MHz

Ashutosh Dixit (1):
      drm/i915/hwmon: Enable PL1 power limit

Ayush Gupta (1):
      drm/amd/display: disconnect MPCC only on OTG change

Benjamin Cheng (1):
      drm/amd/display: Write to correct dirty_rect

Bhawanpreet Lakha (1):
      drm/amd/display: Fix HDCP failing to enable after suspend

B=C5=82a=C5=BCej Szczygie=C5=82 (1):
      drm/amd/pm: Fix sienna cichlid incorrect OD volage after resume

Chia-I Wu (2):
      drm/amdkfd: fix a potential double free in pqm_create_queue
      drm/amdkfd: fix potential kgd_mem UAFs

Christian Hewitt (1):
      drm/meson: fix 1px pink line on GXM when scaling video overlay

Christian K=C3=B6nig (1):
      drm/ttm: drop extra ttm_bo_put in ttm_bo_cleanup_refs

Cruise Hung (1):
      drm/amd/display: Fix DP MST sinks removal issue

Dan Carpenter (1):
      fbdev: chipsfb: Fix error codes in chipsfb_pci_init()

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2023-03-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-03-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.3-2023-03-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Belanger (1):
      drm/amdkfd: Fixed kfd_process cleanup on module exit.

Dmitry Osipenko (3):
      drm/shmem-helper: Remove another errant put in error path
      drm/msm/gem: Prevent blocking within shrinker loop
      drm/panfrost: Don't sync rpm suspension after mmu flushing

Felix Kuehling (1):
      drm/amdgpu: Don't resume IOMMU after incomplete init

Guchun Chen (1):
      drm/amdgpu: move poll enabled/disable into non DC path

Guilherme G. Piccoli (1):
      drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken BIOSes

Jane Jian (1):
      drm/amdgpu/vcn: custom video info caps for sriov

Janusz Krzysztofik (1):
      drm/i915/active: Fix misuse of non-idle barriers as fence trackers

Johan Hovold (2):
      drm/edid: fix info leak when failing to get panel id
      drm/sun4i: fix missing component unbind on bind errors

Jouni H=C3=B6gander (1):
      drm/i915/psr: Use calculated io and fast wake lines

Liu Ying (1):
      drm/bridge: Fix returned array size name for
atomic_get_input_bus_fmts kdoc

Marek Szyprowski (1):
      drm/meson: dw-hdmi: Fix devm_regulator_*get_enable*() conversion agai=
n

Oleksandr Tyshchenko (1):
      drm/virtio: Pass correct device to dma_sync_sgtable_for_device()

Saaem Rizvi (1):
      drm/amd/display: Remove OTG DIV register write for Virtual signals.

Stanislaw Gruszka (1):
      accel: Build sub-directories based on config options

Takashi Iwai (1):
      fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release=
()

Thomas Hellstr=C3=B6m (1):
      drm/ttm: Fix a NULL pointer dereference

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Tim Huang (1):
      drm/amd/pm: bump SMU 13.0.4 driver_if header version

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix audio ELD handling for DP MST

Wesley Chalmers (1):
      drm/amd/display: Do not set DRR on pipe Commit

Xiaogang Chen (2):
      drm/amdkfd: Fix BO offset for multi-VMA page migration
      drm/amdkfd: Get prange->offset after svm_range_vram_node_new

 drivers/accel/Makefile                             |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  19 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 | 103 +++++++++++++++++=
++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  16 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  11 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  33 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  67 ++++++++++++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   3 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   8 ++
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  43 +++++++--
 drivers/gpu/drm/drm_edid.c                         |   2 +-
 drivers/gpu/drm/drm_gem.c                          |   9 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   9 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  25 +++--
 drivers/gpu/drm/i915/display/intel_psr.c           |  78 ++++++++++++----
 drivers/gpu/drm/i915/display/intel_snps_phy.c      |  62 +++++++++++++
 drivers/gpu/drm/i915/gt/intel_sseu.h               |   2 +-
 drivers/gpu/drm/i915/i915_active.c                 |  25 ++---
 drivers/gpu/drm/i915/i915_hwmon.c                  |   5 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |   2 +-
 drivers/gpu/drm/meson/meson_vpp.c                  |   2 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |  11 ++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   6 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   2 -
 drivers/gpu/drm/ttm/ttm_device.c                   |   2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   4 +-
 drivers/video/fbdev/chipsfb.c                      |  14 ++-
 drivers/video/fbdev/core/fb_defio.c                |  17 +++-
 include/drm/drm_bridge.h                           |   4 +-
 include/drm/drm_gem.h                              |   4 +-
 include/linux/fb.h                                 |   1 +
 47 files changed, 507 insertions(+), 137 deletions(-)
