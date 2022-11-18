Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7F62FEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKRUgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKRUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:36:01 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3840127CE9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:36:00 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c15so3900965qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/PS8PtMZv09FUYyVTH41uxwQ4vAsmTgZ8Noijjjw7uo=;
        b=Y6coz2ghHbFbSxA9lCIf81JCATs3DIgKOBJK89QKl06hQQ4rTushchsfYQv7/x4rNe
         nrqhVBM9Mx2q60OqtgmH/47Yo2olf97oEPIsaA5i0FZuujpxqbVRAcRHxOFQ4uPCgoXt
         NbG8CVfBW7/5xlN3s3JmmYZ9JIQHa8a+LZ1BriFCmkCMa3pBwtU5w4PO7k2pQE7MjfdH
         MP4MDbe1ZKgYW5QZZMlGJSyj4HTyQrxF/kofTkjbLFthMwoW4IpqpMcCdLVRaCsD8vNw
         NAnTBM1KXpSdOu8WwMIHqMj0uq1qG+VCm7hkpXqHgtjyBb6nsYN6Sy8ev4u0/a2NSIRQ
         ngGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PS8PtMZv09FUYyVTH41uxwQ4vAsmTgZ8Noijjjw7uo=;
        b=jXcMc3/gvFeNrAwbmBPq4gAM1fVGjfDA7rlY6Rv3dN6oP2mkP3Sf79ti4DE4h3ocyL
         AbapMcKubqCov1zB+pX26AR/bl5z/Xk+2dvcOzmA2LcqmY8xnt+1j4G9nMtlWecBoaPq
         DPCVLhulHim8rzJ5EZAFoLlf3HP0/7ChgdxwDxhNjfNxXmCicOQv/7ZZ0j2G56Z+LF5S
         lyOsvm64ktEn7FbL1OMKDSncJIR/lzjrBQArhqYvryDOD6QaQwJ10SPGKpWTgHvFVEFy
         WUay9/+ImVqJivPf0tDEvdEkbD84/jgMKFgtefZ1bN4P7Inl3RmrykHkxzX9PYLykkpo
         omWg==
X-Gm-Message-State: ANoB5plVmYkq2clcuozh8b7shjHqRfTVfv61VsRLw7XfD48PXHR/veV3
        VjnBnpoGR/T9z1d1iE7Ju4R0qam8won6aQOAm7HbrN9Zom4=
X-Google-Smtp-Source: AA0mqf6WCtp0olKAxkzVD61/rSgoyPpZOW3byCDhvxL8KyxeXLLOhzzBorwaDL0TvqkQQvqEqQst/avgPJ2od0QcwKw=
X-Received: by 2002:ac8:5501:0:b0:3a5:cb82:109b with SMTP id
 j1-20020ac85501000000b003a5cb82109bmr8368799qtq.61.1668803759221; Fri, 18 Nov
 2022 12:35:59 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 19 Nov 2022 06:35:47 +1000
Message-ID: <CAPM=9tynM8qvm96FV9Z7+EO1u6p8zMiqG9JyaDqqPtzowx3nfA@mail.gmail.com>
Subject: [git pull] drm fixes for v6.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

I guess the main question is are things settling down, and I'd say
kinda, these are all pretty small fixes, nothing big stands out
really, just seems to be quite a few of them.

Mostly amdgpu and core fixes, with some i915, tegra, vc4, panel bits.

Dave.

drm-fixes-2022-11-19:
drm fixes for 6.1-rc6

core:
- Fix potential memory leak in drm_dev_init()
- Fix potential null-ptr-deref in drm_vblank_destroy_worker()
- Revert hiding unregistered connectors from userspace, as it breaks on DP-=
MST.
- Add workaround for DP++ dual mode adaptors that don't support
  i2c subaddressing.

i915:
- Fix uaf with lmem_userfault_list handling

amdgpu:
- gang submit fixes
- Fix a possible memory leak in ganng submit error path
- DP tunneling fixes
- DCN 3.1 page flip fix
- DCN 3.2.x fixes
- DCN 3.1.4 fixes
- Don't expose degamma on hardware that doesn't support it
- BACO fixes for SMU 11.x
- BACO fixes for SMU 13.x
- Virtual display fix for devices with no display hardware

amdkfd:
- Memory limit regression fix

tegra:
- tegra20 GART fix

vc4:
- Fix error handling in vc4_atomic_commit_tail()

lima:
- Set lima's clkname corrrectly when regulator is missing.

panel:
- Set bpc for logictechno panels.
The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa=
:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-19

for you to fetch changes up to b1010b93fe9074f965ebf86e0e382a8a7a71500d:

  Merge tag 'drm/tegra/for-6.1-rc6' of
https://gitlab.freedesktop.org/drm/tegra into drm-fixes (2022-11-19
06:15:37 +1000)

----------------------------------------------------------------
drm fixes for 6.1-rc6

core:
- Fix potential memory leak in drm_dev_init()
- Fix potential null-ptr-deref in drm_vblank_destroy_worker()
- Revert hiding unregistered connectors from userspace, as it breaks on DP-=
MST.
- Add workaround for DP++ dual mode adaptors that don't support
  i2c subaddressing.

i915:
- Fix uaf with lmem_userfault_list handling

amdgpu:
- gang submit fixes
- Fix a possible memory leak in ganng submit error path
- DP tunneling fixes
- DCN 3.1 page flip fix
- DCN 3.2.x fixes
- DCN 3.1.4 fixes
- Don't expose degamma on hardware that doesn't support it
- BACO fixes for SMU 11.x
- BACO fixes for SMU 13.x
- Virtual display fix for devices with no display hardware

amdkfd:
- Memory limit regression fix

tegra:
- tegra20 GART fix

vc4:
- Fix error handling in vc4_atomic_commit_tail()

lima:
- Set lima's clkname corrrectly when regulator is missing.

panel:
- Set bpc for logictechno panels.

----------------------------------------------------------------
Aishwarya Kothari (1):
      drm/panel: simple: set bpc field for logic technologies displays

Alex Deucher (1):
      drm/amdgpu: there is no vbios fb on devices with no display hw (v2)

Candice Li (1):
      drm/amdgpu: Add psp_13_0_10_ta firmware to modinfo

Christian K=C3=B6nig (1):
      drm/amdgpu: use the last IB as gang leader v2

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2022-11-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-11-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.1-2022-11-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm/tegra/for-6.1-rc6' of
https://gitlab.freedesktop.org/drm/tegra into drm-fixes

Dillon Varone (3):
      drm/amd/display: Fix prefetch calculations for dcn32
      drm/amd/display: use uclk pstate latency for fw assisted mclk
validation dcn32
      drm/amd/display: Set max for prefetch lines on dcn32

Dong Chenchen (1):
      drm/amdgpu: Fix memory leak in amdgpu_cs_pass1

Eric Huang (1):
      drm/amdkfd: Fix a memory limit issue

Erico Nunes (1):
      drm/lima: Fix opp clkname setting in case of missing regulator

Evan Quan (3):
      drm/amd/pm: enable runpm support over BACO for SMU13.0.0
      drm/amd/pm: enable runpm support over BACO for SMU13.0.7
      drm/amd/pm: fix SMU13 runpm hang due to unintentional workaround

Gaosheng Cui (1):
      drm/vc4: kms: Fix IS_ERR() vs NULL check for vc4_kms

George Shen (2):
      drm/amd/display: Support parsing VRAM info v3.0 from VBIOS
      drm/amd/display: Fix calculation for cursor CAB allocation

Guchun Chen (1):
      drm/amdgpu: disable BACO support on more cards

Matthew Auld (1):
      drm/i915/ttm: fix uaf with lmem_userfault_list handling

Melissa Wen (1):
      drm/amd/display: don't enable DRM CRTC degamma property for DCE

Robin Murphy (1):
      gpu: host1x: Avoid trying to use GART on Tegra20

Rodrigo Siqueira (1):
      drm/amd/display: Add HUBP surface flip interrupt handler

Roman Li (1):
      drm/amd/display: Fix optc2_configure warning on dcn314

Shang XiaoJing (2):
      drm/drv: Fix potential memory leak in drm_dev_init()
      drm: Fix potential null-ptr-deref in drm_vblank_destroy_worker()

Simon Rettberg (1):
      drm/display: Don't assume dual mode adaptors support i2c sub-addressi=
ng

Simon Ser (1):
      Revert "drm: hide unregistered connectors from GETCONNECTOR IOCTL"

Stylon Wang (2):
      drm/amd/display: Fix access timeout to DPIA AUX at boot time
      drm/amd/display: Fix invalid DPIA AUX reply causing system hang

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 29 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 41 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 32 +++++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  6 ---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 ++++-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 30 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_optc.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 14 +++---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 16 ++++++-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |  2 +
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |  2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |  7 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 23 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  8 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       | 10 +----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       | 11 ++---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  4 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  9 ++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 30 ++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 30 ++++++++++++-
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c  | 51 ++++++++++++------=
----
 drivers/gpu/drm/drm_drv.c                          |  2 +-
 drivers/gpu/drm/drm_internal.h                     |  3 +-
 drivers/gpu/drm/drm_mode_config.c                  |  3 --
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  6 +--
 drivers/gpu/drm/lima/lima_devfreq.c                | 15 ++++---
 drivers/gpu/drm/panel/panel-simple.c               |  2 +
 drivers/gpu/drm/tegra/drm.c                        |  4 ++
 drivers/gpu/drm/vc4/vc4_kms.c                      |  8 ++--
 drivers/gpu/host1x/dev.c                           |  4 ++
 37 files changed, 310 insertions(+), 116 deletions(-)
