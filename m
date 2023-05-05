Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992526F7B64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEEDLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEEDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:10:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2643A11DAB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:10:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-95f4c5cb755so218243266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683256241; x=1685848241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKMozI807IPWJdstmfrYOGjPCh80Dper2iFXWcBE+TM=;
        b=YOOWwpH3HnHGZncsX/nlTVAZBIzFoxrFv19BUWHU8vrx2TqL0eOS3UQ/6l62uV6jdd
         ISpwphxVKHLkCgdtQQqMtFlYcGjBmPDBm4ura5sBfO+LFqZJa4Ac05r/3uw5659ljppu
         uEzHs2QG7rK/G+DuiIjQT0muVHi9ba5gCXcV0IMGYGYhoftR3oz37WXyYOt4ixFt0flm
         En0g1nbRaPrsY+S9uhLQNENptvHrHkcsF0kg7lJrhUWHPH0urmo24iqVhGr1gRvtJwR4
         fRqwGIcahNmT0sp7y1PiMcfCghcObsAl3gKksAqySX+tUHJVex8wab9w440AEXjNkJh1
         EZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256241; x=1685848241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKMozI807IPWJdstmfrYOGjPCh80Dper2iFXWcBE+TM=;
        b=Pgi3/k/g9M8DHQB+NRWrwMeDiA7lEOj8hgrlbX6w6ctSkbfgmxV+iBzgiTzc4CnJ0R
         fIEgrPL/ymy+0DjhrMdCn4UMZg2GcmGQmRyXC7FHy+aFMbMzFE+tlgqmm6BTSHyaPcV6
         DtYW+TFlNc2qB78Wu/i0FSjeqQ9Ne7mYG8N9N5QZaPR3Jk8yB8qadx+6DhupOhsbtHWh
         9Y77f/9tCurH92DOf97J9I2tsor9c5pU7NvJ7/jL5/XZq9EzSKWRIRQb63ZMkv5AYnhK
         kEdgsTvXs9HS8pSZlGywWvDns5Pr5+9V+iB8bOmQ1TabdzhBRJ4cukCRrXEGesNrwphi
         QpLQ==
X-Gm-Message-State: AC+VfDwzPmJDppwJ8Stpni6JTqAepvZMB0DtvnjsvovfdL2ZKy8Y9CdQ
        rXeTb/9tY8pp+0XM3dQbIq84mFt146XjmOZVFkzek/z7ooTgvA==
X-Google-Smtp-Source: ACHHUZ40FPFPn/Lm0qN7eY0CpLIzUlFrh3KCATeVR5APhWaHH8TDIZMGCZCsX1zG22w29hOS4GCu3BS/Y8IKV0GEbkU=
X-Received: by 2002:a17:907:6d09:b0:94e:4c8f:758 with SMTP id
 sa9-20020a1709076d0900b0094e4c8f0758mr771227ejc.76.1683256241305; Thu, 04 May
 2023 20:10:41 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 May 2023 13:10:28 +1000
Message-ID: <CAPM=9tx4RUsYmOH4vLcXQ4dyTxkBDO5WeEXabWX4hdDbUp3ghA@mail.gmail.com>
Subject: [git pull] drm fixes part 2 for 6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the fixes for the last couple of weeks for i915 and last 3
weeks for amdgpu, lots of them but pretty scattered around and all
pretty small.

Dave.

drm-next-2023-05-05:
drm fixes part 2 for 6.4-rc1

amdgpu:
- SR-IOV fixes
- DCN 3.2 fixes
- DC mclk handling fixes
- eDP fixes
- SubVP fixes
- HDCP regression fix
- DSC fixes
- DC FP fixes
- DCN 3.x fixes
- Display flickering fix when switching between vram and gtt
- Z8 power saving fix
- Fix hang when skipping modeset
- GPU reset fixes
- Doorbell fix when resizing BARs
- Fix spurious warnings in gmc
- Locking fix for AMDGPU_SCHED IOCTL
- SR-IOV fix
- DCN 3.1.4 fix
- DCN 3.2 fix
- Fix job cleanup when CS is aborted

i915:
- skl pipe source size check
- mtl transcoder mask fix
- DSI power on sequence fix
- GuC versioning corner case fix
The following changes since commit cf03e2956af307dc25e8c41fd4cffe44482a6ec1=
:

  Merge tag 'drm-misc-next-fixes-2023-04-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2023-04-27
11:29:34 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-05-05

for you to fetch changes up to 1bef84af084e981550d9ecc3359baa22533d7b99:

  Merge tag 'drm-intel-next-fixes-2023-05-04-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-05-05
11:27:26 +1000)

----------------------------------------------------------------
drm fixes part 2 for 6.4-rc1

amdgpu:
- SR-IOV fixes
- DCN 3.2 fixes
- DC mclk handling fixes
- eDP fixes
- SubVP fixes
- HDCP regression fix
- DSC fixes
- DC FP fixes
- DCN 3.x fixes
- Display flickering fix when switching between vram and gtt
- Z8 power saving fix
- Fix hang when skipping modeset
- GPU reset fixes
- Doorbell fix when resizing BARs
- Fix spurious warnings in gmc
- Locking fix for AMDGPU_SCHED IOCTL
- SR-IOV fix
- DCN 3.1.4 fix
- DCN 3.2 fix
- Fix job cleanup when CS is aborted

i915:
- skl pipe source size check
- mtl transcoder mask fix
- DSI power on sequence fix
- GuC versioning corner case fix

----------------------------------------------------------------
Alex Hung (1):
      drm/amd/display: allow edp updates for virtual signal

Alvin Lee (1):
      drm/amd/display: Reduce SubVP + DRR stretch margin

Aurabindo Pillai (5):
      drm/amd/display: Fix hang when skipping modeset
      drm/amd/display: remove incorrect early return
      drm/amd/display: Fixes for dcn32_clk_mgr implementation
      drm/amd/display: Do not clear GPINT register when releasing DMUB
from reset
      drm/amd/display: Update bounding box values for DCN321

Chia-I Wu (1):
      drm/amdgpu: add a missing lock for AMDGPU_SCHED

Chong Li (1):
      drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init=
"

Cruise Hung (1):
      drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.4-2023-04-26' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2023-04-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'amd-drm-fixes-6.4-2023-05-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2023-05-04-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Guchun Chen (1):
      drm/amdgpu: drop redundant sched job cleanup when cs is aborted

Hamza Mahfooz (2):
      drm/amd/display: fix flickering caused by S/G mode
      drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()

Hans de Goede (1):
      drm/i915/dsi: Use unconditional msleep() instead of intel_dsi_msleep(=
)

Hersen Wu (3):
      drm/amd/display: fix memleak in aconnector->timing_requested
      drm/amd/display: fix access hdcp_workqueue assert
      drm/amd/display: Return error code on DSC atomic check failure

Horace Chen (1):
      drm/amdgpu: disable SDMA WPTR_POLL_ENABLE for SR-IOV

Horatio Zhang (2):
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini
      drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini

Igor Kravchenko (1):
      drm/amd/display: Set min_width and min_height capability for DCN30

Jane Jian (1):
      drm/amdgpu/vcn: fix mmsch ctx table size

Jasdeep Dhillon (1):
      drm/amd/display: Isolate remaining FPU code in DCN32

Jingwen Zhu (1):
      drm/amd/display: Improvement for handling edp link training fails

John Harrison (1):
      drm/i915/guc: Actually return an error if GuC version range check fai=
ls

Josip Pavic (1):
      drm/amd/display: copy dmub caps to dc on dcn31

Leo Chen (2):
      drm/amd/display: Lowering min Z8 residency time
      drm/amd/display: Change default Z8 watermark values

Michael Mityushkin (1):
      drm/amd/display: Apply correct panel mode when reinitializing hardwar=
e

Radhakrishna Sripada (1):
      drm/i915/mtl: Add the missing CPU transcoder mask in intel_device_inf=
o

Rodrigo Siqueira (8):
      drm/amd/display: Update bouding box values for DCN32
      drm/amd/display: Add missing mclk update
      drm/amd/display: Adjust code identation and other minor details
      drm/amd/display: Set maximum VStartup if is DCN201
      drm/amd/display: Set dp_rate to dm_dp_rate_na by default
      drm/amd/display: Remove wrong assignment of DP link rate
      drm/amd/display: Use pointer in the memcpy
      drm/amd/display: Add missing WA and MCLK validation

Samson Tam (1):
      drm/amd/display: filter out invalid bits in pipe_fuses

Shane Xiao (1):
      drm/amdgpu: Enable doorbell selfring after resize FB BAR

Tianci Yin (1):
      drm/amd/display: Disable migration to ensure consistency of
per-CPU variable

Tom Rix (2):
      drm/amd/pm: change pmfw_decoded_link_width, speed variables to global=
s
      drm/amd/display: set variable dccg314_init
storage-class-specifier to static

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Check pipe source size when using skl+ scalers

Wesley Chalmers (2):
      drm/amd/display: Do not set drr on pipe commit
      drm/amd/display: Block optimize on consecutive FAMS enables

lyndonli (2):
      drm/amdgpu: Fix mode2 reset for sienna cichlid
      drm/amdgpu: Use the default reset when loading or reloading the drive=
r

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  39 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  25 +--
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  23 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  34 +++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  17 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  19 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   9 ++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  25 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |   4 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c    |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  56 ++++---
 .../drm/amd/display/dc/dcn321/dcn321_resource.c    |  10 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 178 +++++++++++------=
----
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |  18 ++-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |   4 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  17 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h   |   2 +
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |  24 +--
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   5 +
 .../display/dc/link/protocols/link_dp_training.c   |   5 +-
 .../dc/link/protocols/link_edp_panel_control.c     |   1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  |   3 +-
 drivers/gpu/drm/amd/display/include/signal_types.h |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   3 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |   2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |  11 --
 drivers/gpu/drm/i915/display/intel_dsi_vbt.h       |   1 -
 drivers/gpu/drm/i915/display/skl_scaler.c          |  17 ++
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  22 +--
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |  20 ++-
 drivers/gpu/drm/i915/i915_pci.c                    |   2 +
 50 files changed, 415 insertions(+), 263 deletions(-)
