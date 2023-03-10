Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACF6B35B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCJEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:44:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA07103BDB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:44:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id da10so15753660edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 20:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678423486;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APGAiUlIJpJRbYAIZ5nOkr0hb7mWXQrPffrcm6b20tU=;
        b=TXuOteR1nB594M1W2K9ahWNO5scYh2QRDv2zkmHCQBvkqn3pkbWyAmRF9QyT9UgXyC
         W7TsMrRrmgVdxppiFCgPz3IO+fK9d2rmkN3+d8wqd/BBrDcsf29/JdgaR70CEHPswAIw
         WGleQ3ex3JWMebDv/s9EoQprvJ2ejuz0J709uVA/YzdCMSvG0tSjxVfgHN54XmIoi7LW
         8cSYTOCrQCmZmvxa5QQJsTAMdkVzMb26buBXoUAxrEgM4pXHDIdg8Zr7+JI+5pf2knBZ
         ctUlAU4PltbSCHICndar9dKCRZbTDeNOVoaEMH6BUuPR9n/O+uDCJEu0wUBtpDdJbTOt
         /KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678423486;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APGAiUlIJpJRbYAIZ5nOkr0hb7mWXQrPffrcm6b20tU=;
        b=N79Uno2/AZFJlNx00M7DiJlk3d9ubVEdJtoHZQjw9h/zbC9YRaapG5yPIayDSlyN28
         yI0u1uLStCcDBSoMISOQI52T/h811woyCkNXkwCMIjbJFYGgG9kUyvR9FyLzr5RsWus4
         KwMceNLVuEcn9rQ6vt/KulueIr2NANgyuYbQOgpQgNaRM4uoa7x8hraRScZYc9gYzOVa
         E0q22GTBGr7PNGso1CyD2SXGRysSi3ge2kqkGM7pJvexiwyCNFG35asNh64dB0sw+qmP
         T6TB+Rts+hkpWClHvpbLc1NEvkpB/Qjy5IW5MqD5SUDgbqlNflUOElMfy+0EEDqk5v2/
         Ge5w==
X-Gm-Message-State: AO0yUKV0ZCZmy7eQG5EAgvVK204T9AiubZBvEnEaBkQ2BC07Ep8JNDn/
        2vKiS4SujhmBtuXNstgLB07IQkoHBTx1ZJ3CIkU=
X-Google-Smtp-Source: AK7set9yoa4QwF4rkrjxDH7pV8iyy+fdFGuFgU9IA0gRWkBHTEs8N7wextGh/oXfUpFzo7kZaIkQ+EXAkqfRMBzhpjI=
X-Received: by 2002:a17:906:a14:b0:8b1:38d6:9853 with SMTP id
 w20-20020a1709060a1400b008b138d69853mr11495105ejf.2.1678423485737; Thu, 09
 Mar 2023 20:44:45 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 10 Mar 2023 14:44:33 +1000
Message-ID: <CAPM=9tw4eFsBCha-h2FvM_ofXMcEJAEsoT_HqxZc9gWe20J+yA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Weekly fixes, msm and amdgpu are the vast majority of these, otherwise
some straggler misc from last week for nouveau and cirrus and a
mailmap update for a drm developer.

Regards,
Dave.

drm-fixes-2023-03-10:
drm fixes for 6.3-rc2

mailmap
- add an entry

nouveau:
- fix system shutdown regression
- build warning fix

cirrus:
- NULL ptr deref fix

msm:
- fix invalid ptr free in syncobj cleanup
- sync GMU removal in teardown
- a5xx preemption fixes
- fix runpm imbalance
- DPU hw fixes
- stack corruption fix
- clear DSPP reservation

amdgpu:
- Misc display fixes
- UMC 8.10 fixes
- Driver unload fixes
- NBIO 7.3.0 fix
- Error checking fixes for soc15, nv, soc21 read register interface
- Fix video cap query for VCN 4.0.4

amdkfd:
- Fix return check in doorbell handling
The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-10

for you to fetch changes up to 519b23310aa100073f0b58c39df120a486ed7f8e:

  Merge tag 'amd-drm-fixes-6.3-2023-03-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-03-10
14:17:35 +1000)

----------------------------------------------------------------
drm fixes for 6.3-rc2

mailmap
- add an entry

nouveau:
- fix system shutdown regression
- build warning fix

cirrus:
- NULL ptr deref fix

msm:
- fix invalid ptr free in syncobj cleanup
- sync GMU removal in teardown
- a5xx preemption fixes
- fix runpm imbalance
- DPU hw fixes
- stack corruption fix
- clear DSPP reservation

amdgpu:
- Misc display fixes
- UMC 8.10 fixes
- Driver unload fixes
- NBIO 7.3.0 fix
- Error checking fixes for soc15, nv, soc21 read register interface
- Fix video cap query for VCN 4.0.4

amdkfd:
- Fix return check in doorbell handling

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for soc15
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for soc21
      drm/amdgpu: fix error checking in amdgpu_read_mm_registers for nv

Alexandr Sapozhnikov (1):
      drm/cirrus: NULL-check pipe->plane.state->fb in cirrus_pipe_update()

Ben Skeggs (1):
      drm/nouveau/fb/gp102-: cache scrubber binary on first load

Candice Li (2):
      drm/amdgpu: Support umc node harvest config on umc v8_10
      drm/amd/pm: Enable ecc_info table support for smu v13_0_10

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2023-02-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      mailmap: add mailmap entries for Faith.
      Merge tag 'drm-msm-fixes-2023-03-09' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-6.3-2023-03-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dmitry Baryshkov (18):
      drm/msm/a5xx: fix setting of the CP_PREEMPT_ENABLE_LOCAL register
      drm/msm/a5xx: fix highest bank bit for a530
      drm/msm/a5xx: fix the emptyness check in the preempt code
      drm/msm/a5xx: fix context faults during ring switch
      drm/msm/dpu: set DPU_MDP_PERIPH_0_REMOVED for sc8280xp
      drm/msm/dpu: disable features unsupported by QCM2290
      drm/msm/dpu: fix typo in in sm8550's dma_sblk_5
      drm/msm/dpu: fix len of sc7180 ctl blocks
      drm/msm/dpu: fix sm6115 and qcm2290 mixer width limits
      drm/msm/dpu: correct sm8550 scaler
      drm/msm/dpu: correct sc8280xp scaler
      drm/msm/dpu: correct sm8450 scaler
      drm/msm/dpu: correct sm8250 and sm8350 scaler
      drm/msm/dpu: correct sm6115 scaler
      drm/msm/dpu: drop DPU_DIM_LAYER from MIXER_MSM8998_MASK
      drm/msm/dpu: fix clocks settings for msm8998 SSPP blocks
      drm/msm/dpu: don't use DPU_CLK_CTRL_CURSORn for DMA SSPP clocks
      drm/msm/dpu: fix stack smashing in dpu_hw_ctl_setup_blendstage

Douglas Anderson (1):
      drm/msm/a6xx: Make GPU destroy a bit safer

Harry Wentland (2):
      drm/display: Don't block HDR_OUTPUT_METADATA on unknown EOTF
      drm/connector: print max_requested_bpc in state debugfs

Jiri Slaby (SUSE) (1):
      drm/nouveau/kms/nv50: fix nv50_wndw_new_ prototype

Johan Hovold (1):
      drm/msm/adreno: fix runtime PM imbalance at unbind

Kalyan Thota (1):
      drm/msm/dpu: clear DSPP reservations in rm release

Kuogee Hsieh (1):
      drm/msm/disp/dpu: fix sc7280_pp base offset

Mario Limonciello (1):
      drm/amd: Fix initialization mistake for NBIO 7.3.0

Randy Dunlap (1):
      drm/msm: DEVFREQ_GOV_SIMPLE_ONDEMAND is no longer needed

Rob Clark (2):
      Merge tag 'drm-msm-fixes-2023-01-16' into msm-fixes
      drm/msm: Fix potential invalid ptr free

Shashank Sharma (1):
      drm/amdgpu: fix return value check in kfd

Swapnil Patel (1):
      drm/amd/display: Update clock table to include highest clock setting

Thomas Zimmermann (1):
      drm/msm: Fix possible uninitialized access in fbdev

Veerabadhran Gopalakrishnan (1):
      drm/amdgpu/soc21: Add video cap query support for VCN_4_0_4

lyndonli (2):
      drm/amdgpu: Fix call trace warning and hang when removing amdgpu device
      drm/amdgpu: Fix the warning info when removing amdgpu device

 .mailmap                                           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |   7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c             |  14 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   7 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   5 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   8 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h             |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  19 ++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  75 ++++++++++
 drivers/gpu/drm/display/drm_hdmi_helper.c          |   6 +-
 drivers/gpu/drm/drm_atomic.c                       |   1 +
 drivers/gpu/drm/msm/Kconfig                        |   1 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 +
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 166 ++++++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   2 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |   5 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |   5 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |   3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c      |   8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga100.c     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga102.c     |  21 +--
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp102.c     |  41 ++---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |   4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/tu102.c     |   4 +-
 drivers/gpu/drm/tiny/cirrus.c                      |   2 +-
 37 files changed, 280 insertions(+), 191 deletions(-)
