Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992E26382D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYDrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:47:16 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B42A727
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:47:14 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e15so1943909qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9NwyYJGTST+adt/mtrpqqW4d1ie/BbqvDNLWrxadpI=;
        b=Zrf6EXdxDNyOpH6XKy0gfGWjLcKgY3+Ve6JPX3RA5FKJXduEQ9E6F0DmfUsWX2iTcg
         7ngtKXSg+FIlbE3jIM8VnKPtMTBSV7ttdtTjv2Tpst2QgBVDWvb8+kp5d+OAdimqJA4Y
         Vcmm9uvU6JJ4hqqmqV4X1XrR7eyg/knVbC3qRrotdESvnSRWduZK4Q4fsmMmkMp1j+6a
         AazMhqq6DKwlkUPMvjd+rOPplyFHPLJ0t9RSvZOa5Dqeh2SNUoIsWLoYSf6ZglS0XP+5
         pfzNROXMCtYBYBkWyd0djwiwe689ovhqMMqk+V5cLGfIkL0m2ox1LCGLzoG1Nz+2CzLJ
         JoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9NwyYJGTST+adt/mtrpqqW4d1ie/BbqvDNLWrxadpI=;
        b=TuzRWr7NWixvFXSjNBc4u0DI6tKpMQWVl7gIPs6jPU0hkh9v4QPDZl8EXrle0EdORs
         oyA4W0JR3gW/sUMJAi5Tjp2kO8i1sLOaBj5HcHAAWWcmk2q28vD74oXXkX2xc8l23+dH
         nuhiT/WnFfCh/opL8o+sDeLCtT8JZjR5bkinVnGpOEt7UebUdHd3ZyTRs6m9hbT9Vi55
         X6WwJCIgIucGBlTAJc32Iimuyf+z7FEkSMgrz2cY8ogfqT/Bx9SLELP0Obb5MVlEJVfu
         xeTNvhrlJqSLYYaunRrgUfYjY5MmOO3UOeUXxmNASYST50UrdcaTS/TKE1mV4y5JddIQ
         Vgaw==
X-Gm-Message-State: ANoB5pmDyk/6fcZnHwSw8vGA+lS30ZExsihound8Do7aUHhwmfFo5+Pg
        KduCBhenHvE7i7FfXtQtAkfmv/W3HBGp7dEqPJWZtojksjY=
X-Google-Smtp-Source: AA0mqf4Zm6V5IOGUrLEQK6Qo5hd1oSjWnZBOwvpHGoC6L246q0GV1BjU62uEWuS+wDJqIuFl48D1ZYKVKa9S4eY/JCQ=
X-Received: by 2002:ac8:7cbb:0:b0:399:83a8:c28b with SMTP id
 z27-20020ac87cbb000000b0039983a8c28bmr21732081qtv.447.1669348033793; Thu, 24
 Nov 2022 19:47:13 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Nov 2022 13:47:02 +1000
Message-ID: <CAPM=9tw-YJEmJFE0FaOa0SvjsPj=TW4rqD1RJBgsw_JzWu1vZw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.1-rc7
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

Weekly fixes, amdgpu has not quite settled down. Most of the changes
are small, and the non-amdgpu ones are all fine. There are a bunch of
DP MST DSC fixes that fix some issues introduced in a previous larger
MST rework.

The biggest one is mainly propagating some error values properly
instead of bool returns, and I think it just looks large but doesn't
really change anything too much, except propagating errors that are
required to avoid deadlocks. I've gone over it and a few others and
they've had some decent testing over the last few weeks, but let me
know if you think it's too problematic.

Dave.


drm-fixes-2022-11-25:
drm fixes for 6.1-rc7

amdgpu:
- amdgpu gang submit fix.
- DCN 3.1.4 fixes
- DP MST DSC deadlock fixes
- HMM userptr fixes
- Fix Aldebaran CU occupancy reporting
- GFX11 fixes
- PSP suspend/resume fix
- DCE12 KASAN fix
- DCN 3.2.x fixes
- Rotated cursor fix
- SMU 13.x fix
- DELL platform suspend/resume fixes
- VCN4 SR-IOV fix
- Display regression fix for polled connectors

i915:
- Fix GVT KVM reference count handling
- Never purge busy TTM objects
- Fix warn in intel_display_power_*_domain() functions

dma-buf:
- Use dma_fence_unwrap_for_each when importing sync files.
- Fix race in dma_heap_add().

fbcon:
- Fix use of uninitialized memory in logo.
The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8=
:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-25

for you to fetch changes up to e57702069b26b8601a33fdc0c9bbe40c6bb9c72f:

  Merge tag 'amd-drm-fixes-6.1-2022-11-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-11-25
10:55:23 +1000)

----------------------------------------------------------------
drm fixes for 6.1-rc7

amdgpu:
- amdgpu gang submit fix.
- DCN 3.1.4 fixes
- DP MST DSC deadlock fixes
- HMM userptr fixes
- Fix Aldebaran CU occupancy reporting
- GFX11 fixes
- PSP suspend/resume fix
- DCE12 KASAN fix
- DCN 3.2.x fixes
- Rotated cursor fix
- SMU 13.x fix
- DELL platform suspend/resume fixes
- VCN4 SR-IOV fix
- Display regression fix for polled connectors

i915:
- Fix GVT KVM reference count handling
- Never purge busy TTM objects
- Fix warn in intel_display_power_*_domain() functions

dma-buf:
- Use dma_fence_unwrap_for_each when importing sync files.
- Fix race in dma_heap_add().

fbcon:
- Fix use of uninitialized memory in logo.

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/psp: don't free PSP buffers on suspend
      drm/amdgpu: Partially revert "drm/amdgpu: update
drm_display_info correctly when the edid is read"

Christian K=C3=B6nig (3):
      drm/amdgpu: handle gang submit before VMID
      drm/amdgpu: always register an MMU notifier for userptr
      drm/amdgpu: fix userptr HMM range handling v2

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2022-11-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-11-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.1-2022-11-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Galiffi (1):
      drm/amd/display: Fix rotated cursor offset calculation

Dawei Li (1):
      dma-buf: fix racing conflict of dma_heap_add()

Dillon Varone (3):
      drm/amd/display: Update soc bounding box for dcn32/dcn321
      drm/amd/display: Use viewport height for subvp mall allocation size
      drm/amd/display: Use new num clk levels struct for max mclk index

Imre Deak (1):
      drm/i915: Fix warn in intel_display_power_*_domain() functions

Jack Xiao (1):
      drm/amd/amdgpu: reserve vm invalidation engine for firmware

Jane Jian (1):
      drm/amdgpu/vcn: re-use original vcn0 doorbell value

Jason Ekstrand (1):
      dma-buf: Use dma_fence_unwrap_for_each when importing fences

Lyude Paul (6):
      drm/amdgpu/mst: Stop ignoring error codes and deadlocking
      drm/display/dp_mst: Fix drm_dp_mst_add_affected_dsc_crtcs() return co=
de
      drm/amdgpu/dm/mst: Use the correct topology mgr pointer in
amdgpu_dm_connector
      drm/amdgpu/dm/dp_mst: Don't grab mst_mgr->lock when computing DSC sta=
te
      drm/amdgpu/dm/mst: Fix uninitialized var in
pre_compute_mst_dsc_configs_for_state()
      drm/amd/dc/dce120: Fix audio register mapping, stop triggering KASAN

Matthew Auld (1):
      drm/i915/ttm: never purge busy objects

Ramesh Errabolu (1):
      drm/amdgpu: Enable Aldebaran devices to report CU Occupancy

Roman Li (1):
      drm/amd/display: Align dcn314_smu logging with other DCNs

Sean Christopherson (2):
      drm/i915/gvt: Get reference to KVM iff attachment to VM is successful
      drm/i915/gvt: Unconditionally put reference to KVM when detaching vGP=
U

Stanley.Yang (1):
      drm/amdgpu: fix use-after-free during gpu recovery

Taimur Hassan (1):
      drm/amd/display: Avoid setting pixel rate divider to N/A

Tetsuo Handa (1):
      fbcon: Use kzalloc() in fbcon_prepare_logo()

Tsung-hua Lin (1):
      drm/amd/display: No display after resume from WB/CB

Tvrtko Ursulin (1):
      Merge tag 'gvt-fixes-2022-11-11' of
https://github.com/intel/gvt-linux into drm-intel-fixes

lyndonli (1):
      drm/amd/pm: update driver if header for smu_13_0_7

 drivers/dma-buf/dma-buf.c                          |  23 +-
 drivers/dma-buf/dma-heap.c                         |  28 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  53 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  55 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 254 +++++++++++------=
----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  12 +-
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c |  11 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |  34 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |  28 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  32 ++-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c    |   7 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |   4 +-
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |   8 +-
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |   8 +-
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 117 +++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |   4 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   8 +-
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 38 files changed, 487 insertions(+), 326 deletions(-)
