Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2E6FFB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbjEKVAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjEKVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:00:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE686BE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:00:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so13609535a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683838810; x=1686430810;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywkMCGzn15vnf+8s0S2vOXsf00/J+8eyw+KPM/QR1L4=;
        b=rPk5vVIAUjK+2gjva/rvVZuNEytHA3ME2JGO2PGVbva/MsvnK3d1NLtf9BRLFa/cc4
         FWdgR3rZg/1G/OFBJmvWJo8J6Z6Xket2J3s857wlJccC5FDOQGWFKjugJlRJ7Jqpr6kg
         d7H6997ufT8bBVdEcAxOTqUfBt6+vVBoOfcBXKIsuVquw9Ru/6S3PwrSMFPIj2VTeBSa
         fdRB4qpE1d6/4l9AQSS+jgJeOYunSElXyq8rnKUBeLKlg5hi8yod1mRh8VRGixCf4NnH
         b4W73R8QF5jeEdQtuyGQPOKpBpGwdTLMVQ5zJIbbgnMQFTKGsFJ/DtL6JsqlkxLSAnP5
         W7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838810; x=1686430810;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywkMCGzn15vnf+8s0S2vOXsf00/J+8eyw+KPM/QR1L4=;
        b=knpL9N6aD3ibJa2rHOaqVH5aYMXJR5GNmbjIR48IOhu9pradk8C8nh/lv65KnVvolV
         xQ/DS1lAHXZqth63b+ibuoEoeJoev7IkxTFbD4b7/JPgLKRC+3W/VPoGYj1M1SzdNomQ
         Hw9I1creWB6LxW5EVTRaNpFvJ/heTRPoUeX3P9F94HuDYpyBNC6jXugce4EIrOd0g19t
         GKhWmO4lGsZ1/UVEWgDSh3CJRFOrGGSDJIjiqPz6uVFEUb9d64A9HojiXNkGTpRw+DY6
         czjPyE6boInd6EpwwphUzmIfvGHDmzUwVnmY0bimXVUOdxol+f40oia+T67gO8ZAQv2Y
         tA6g==
X-Gm-Message-State: AC+VfDxGaoHoUyQ5SYbjzd6XlF02TSXj2aR5WCA7lUJrnSLVf2Gq8P/U
        mC8rMcKxxzCbF7PQWiIb7wruiO2ZckTY8Q8lemGDsIVI5UlFjw==
X-Google-Smtp-Source: ACHHUZ46bz3Fb16HDe+LwgfEB80D4V2qja4oTwLKX5Itf9iJNLEyAneWLCq6Vvi1guDGWgQZn+1Nn6q2jyv9N0QVLPQ=
X-Received: by 2002:a17:907:8a07:b0:968:c2c2:3a21 with SMTP id
 sc7-20020a1709078a0700b00968c2c23a21mr13644234ejc.12.1683838809082; Thu, 11
 May 2023 14:00:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 May 2023 06:59:57 +1000
Message-ID: <CAPM=9tzcHVOZNJf__haKP-=f+tZ2_=AokYjWUikF02yv46XuAg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.4-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

About the usual for this stage, bunch of amdgpu, a few i915 and a
scattering of fixes across the board,

Regards,
Dave.

drm-fixes-2023-05-12:
drm fixes for 6.4-rc2

dsc:
- macro fixes

simplefb:
- fix VESA format

scheduler:
- Scheduler timeout handling fix.

fbdev:
- Prohibit potential out-of-bounds access in generic fbdev emulation.

ast:
- Improve AST2500+ compat on ARM.

mipi-dsi:
- Small mipi-dsi fix.

amdgpu:
- VCN3 fixes
- APUs always support PCI atomics
- Legacy power management fixes
- DCN 3.1.4 fix
- DCFCLK fix
- Fix several RAS irq refcount mismatches
- GPU Reset fix
- GFX 11.0.4 fix

i915:
- Fix to taint kernel when force_probe is used
- Null deref and div-by-zero fixes for display
- GuC error capture fix for Xe devices
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-05-12

for you to fetch changes up to d8843eebbbd15b78c6a7745717b3705eca923b0f:

  Merge tag 'amd-drm-fixes-6.4-2023-05-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-05-12
06:46:34 +1000)

----------------------------------------------------------------
drm fixes for 6.4-rc2

dsc:
- macro fixes

simplefb:
- fix VESA format

scheduler:
- Scheduler timeout handling fix.

fbdev:
- Prohibit potential out-of-bounds access in generic fbdev emulation.

ast:
- Improve AST2500+ compat on ARM.

mipi-dsi:
- Small mipi-dsi fix.

amdgpu:
- VCN3 fixes
- APUs always support PCI atomics
- Legacy power management fixes
- DCN 3.1.4 fix
- DCFCLK fix
- Fix several RAS irq refcount mismatches
- GPU Reset fix
- GFX 11.0.4 fix

i915:
- Fix to taint kernel when force_probe is used
- Null deref and div-by-zero fixes for display
- GuC error capture fix for Xe devices

----------------------------------------------------------------
Alvin Lee (1):
      drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2023-05-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-05-11-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.4-2023-05-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Guchun Chen (4):
      drm/amd/pm: parse pp_handle under appropriate conditions
      drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend
      drm/amd/pm: avoid potential UBSAN issue on legacy asics
      drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling
legacy gfx ras

Horatio Zhang (1):
      drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs

Jammy Huang (1):
      drm/ast: Fix ARM compatibility

Jani Nikula (3):
      drm/dsc: fix drm_edp_dsc_sink_output_bpp() DPCD high byte usage
      drm/dsc: fix DP_DSC_MAX_BPP_DELTA_* macro values
      drm/i915: taint kernel when force probing unsupported devices

John Harrison (1):
      drm/i915/guc: Don't capture Gen8 regs on Xe devices

Kees Cook (1):
      drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes

Leo Chen (1):
      drm/amd/display: Add symclk workaround during disable link output

Lin.Cao (1):
      drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)

Nikita Zhandarovich (1):
      drm/i915/dp: prevent potential div-by-zero

Pierre Asselin (1):
      firmware/sysfb: Fix VESA format selection

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: Remove harvest checking for JPEG3

Saravana Kannan (1):
      drm/mipi-dsi: Set the fwnode for mipi_dsi_device

Stanislav Lisovskiy (1):
      drm/i915: Fix NULL ptr deref by checking new_crtc_state

Sui Jingfeng (1):
      drm/fbdev-generic: prohibit potential out-of-bounds access

Thong Thai (1):
      drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

Vitaly Prosyak (1):
      drm/sched: Check scheduler work queue before calling timeout handling

Yifan Zhang (2):
      drm/amdgpu: set gfx9 onwards APU atomics support to be true
      drm/amdgpu: change gfx 11.0.4 external_id range

 drivers/firmware/sysfb_simplefb.c                  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  8 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 46 ---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    | 22 ++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  8 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   | 65 ++++++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h   |  2 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |  2 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |  5 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 25 ++++++---
 drivers/gpu/drm/ast/ast_main.c                     |  9 +--
 drivers/gpu/drm/drm_fb_helper.c                    | 16 ++++--
 drivers/gpu/drm/drm_mipi_dsi.c                     |  2 +-
 drivers/gpu/drm/i915/Kconfig                       | 12 ++--
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |  4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  5 ++
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c     |  7 ++-
 drivers/gpu/drm/i915/i915_pci.c                    |  6 ++
 drivers/gpu/drm/nouveau/include/nvif/if0012.h      |  4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |  3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c             |  2 +-
 include/drm/display/drm_dp.h                       |  5 +-
 include/drm/display/drm_dp_helper.h                |  5 +-
 29 files changed, 188 insertions(+), 100 deletions(-)
