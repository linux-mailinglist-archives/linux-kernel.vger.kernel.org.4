Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7310688E54
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjBCD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBCD7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:59:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A5197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:59:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qw12so12045190ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 19:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/HlJLIJB30yl57RTUgClv87FLJ7IQRamzOi8wxBgdAI=;
        b=XPqUtAefxI0KO9zPTYhfKzcbKWw256bX3U6D1BYH12PyaKUSgkDYUo+pIleRZA9swh
         8+jNh0xrBRa+2dW/rWwzEQ0zTU7aoTqw4ELFyHA3KIR6zLzL8mv7RP3dkRqQtEY/x/yH
         ljSv+aYpODsc9E8Wi5UqpoHRbKapy9WJvaXlblU03mAx4jVnS5WxCc/oo/+28rr8W5Tp
         X8DTnwX2D3KwHyfj20wSRl5Lz0Av5CGYr/mhFw29q6yLHozQpJTgrOa9GbnmbIV0W3qt
         vr/fYsfjaJeckNaF4eIADhmCIlUz/KeSgRlm29IdlK1EoKnc/EjwKzFI7vmGdh2ujvDl
         S4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HlJLIJB30yl57RTUgClv87FLJ7IQRamzOi8wxBgdAI=;
        b=F0spS7/5vElcc722tRtKrkIf6GpWkc6fIWamxIcNirzWkPsH0snPzB1JnswBEIPODF
         v6JG8ECqPyjPlw3XywEN6NLT3biyzTEosMU0oKdfHqd034kojm+b7BopHJ0kpvpeLNDN
         NCjbrp0qHt3q3zkiqbZtck4VgRk8XNfzXvClr5BRywlmejOwCaORj/Q2GtUuHLJQkCM4
         jS08+Sg39IDsDlxQaHEYBMGKqVVP1vZzKM+S//hR4yJuYARL/2gbU4AS5g/tzmcNo2WX
         bXJ9K6xOToczLcrfizNn5ibsSl7UW51gLgFhEZJ4wkXD9YKnS+0f+rfcZsEWHtVWovIW
         XrgQ==
X-Gm-Message-State: AO0yUKVnn8+bAuoaa/P4O7OvN1/JioTBRyMLxw7PAms7VaipakwEKvIt
        ITs+MSCvKfolWYQFSns0AaHS9ifl0P1dUXaYrKCWfJjUwtI=
X-Google-Smtp-Source: AK7set8X5pDJ/58JaxwRicSoZopP5EMD99JTuUxmpsKkcGgbIyONsiO6x3PNA4TpDD/0SusQBSZdE3QhQ/iN+sH7mhY=
X-Received: by 2002:a17:907:bb99:b0:888:2d04:2c36 with SMTP id
 xo25-20020a170907bb9900b008882d042c36mr2124289ejc.278.1675396770728; Thu, 02
 Feb 2023 19:59:30 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Feb 2023 13:59:18 +1000
Message-ID: <CAPM=9tyO4mgZr-r-sSJnNUOzVV53RSeC0BGSULwD=ebJ4WTYZg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.2-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

A few more fixes this week, a bit more spread out though. We have a
bunch of nouveau regression and stabilisation fixes, along with usual
amdgpu, and i915. Otherwise just some minor misc ones.

Dave.

drm-fixes-2023-02-03:
drm fixes for 6.2-rc7

dma-fence:
- fix signaling bit for private fences

panel:
- boe-tv101wum-nl6 disable fix

nouveau:
- gm20b acr regression fix
- tu102 scrub status fix
- tu102 wait for firmware fix

i915:
- Fixes for potential use-after-free and double-free
- GuC locking and refcount fixes
- Display's reference clock value fix

amdgpu:
- GC11 fixes
- DCN 3.1.4 fixes
- NBIO 4.3 fix
- DCN 3.2 fixes
- Properly handle additional cases where DCN is not supported
- SMU13 fixes

vc4:
- fix CEC adapter names

ssd130x:
- fix display init regression
The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-03

for you to fetch changes up to f1a9e82a1203802df3c917dd7ab1b5a5ded55793:

  Merge tag 'amd-drm-fixes-6.2-2023-02-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2023-02-03
13:28:06 +1000)

----------------------------------------------------------------
drm fixes for 6.2-rc7

dma-fence:
- fix signaling bit for private fences

panel:
- boe-tv101wum-nl6 disable fix

nouveau:
- gm20b acr regression fix
- tu102 scrub status fix
- tu102 wait for firmware fix

i915:
- Fixes for potential use-after-free and double-free
- GuC locking and refcount fixes
- Display's reference clock value fix

amdgpu:
- GC11 fixes
- DCN 3.1.4 fixes
- NBIO 4.3 fix
- DCN 3.2 fixes
- Properly handle additional cases where DCN is not supported
- SMU13 fixes

vc4:
- fix CEC adapter names

ssd130x:
- fix display init regression

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: Properly handle additional cases where DCN is
not supported

Ben Skeggs (3):
      drm/nouveau/devinit/tu102-: wait for GFW_BOOT_PROGRESS == COMPLETED
      drm/nouveau/fb/tu102-: fix register used to determine scrub status
      drm/nouveau/acr/gm20b: regression fixes

Chaitanya Kumar Borah (1):
      drm/i915/adlp: Fix typo for reference clock

Daniel Miess (2):
      drm/amd/display: Add missing brackets in calculation
      drm/amd/display: Adjust downscaling limits for dcn314

Danilo Krummrich (1):
      dma-buf: actually set signaling bit for private stub fences

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2023-02-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2023-02-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.2-2023-02-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amdgpu: enable HDP SD for gfx 11.0.3

George Shen (1):
      drm/amd/display: Unassign does_plane_fit_in_mall function from dcn3.2

Graham Sider (1):
      drm/amdgpu: update wave data type to 3 for gfx11

Hans Verkuil (1):
      drm/vc4: hdmi: make CEC adapter name unique

Javier Martinez Canillas (1):
      drm/ssd130x: Init display before the SSD130X_DISPLAY_ON command

John Harrison (3):
      drm/i915/guc: Fix locking when searching for a hung request
      drm/i915: Fix request ref counting during error capture & debugfs dump
      drm/i915: Fix up locking around dumping requests lists

Mario Limonciello (1):
      drm/amd: Fix initialization for nbio 4.3.0

Nicholas Kazlauskas (1):
      drm/amd/display: Reset DMUB mailbox SW state after HW reset

Rob Clark (2):
      drm/i915: Avoid potential vm use-after-free
      drm/i915: Fix potential bit_17 double-free

Stephen Boyd (1):
      drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed during disable

Tim Huang (1):
      drm/amd/pm: drop unneeded dpm features disablement for SMU 13.0.4/11

Yiqing Yao (1):
      drm/amdgpu: Enable vclk dclk node for gc11.0.3

 drivers/dma-buf/dma-fence.c                        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |  8 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 ++++
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |  5 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c  |  2 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |  2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 12 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 14 ++++
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        | 14 +++-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |  9 +--
 drivers/gpu/drm/i915/gt/intel_context.c            |  4 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |  3 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |  4 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          | 74 ++++++++++++----------
 .../gpu/drm/i915/gt/intel_execlists_submission.c   | 27 ++++++++
 .../gpu/drm/i915/gt/intel_execlists_submission.h   |  4 ++
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  | 14 +++-
 drivers/gpu/drm/i915/i915_gpu_error.c              | 33 ++--------
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |  1 +
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       |  3 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 10 +--
 drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c        | 14 +++-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/tu102.c    | 23 +++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga102.c     |  8 +--
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |  5 --
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/tu102.c     | 55 ++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm20b.c    |  2 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     | 16 +++--
 drivers/gpu/drm/solomon/ssd130x.c                  | 18 ++----
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  3 +-
 36 files changed, 296 insertions(+), 122 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/tu102.c
