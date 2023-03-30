Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233AC6D0F42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjC3Trq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjC3Tro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:47:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEB3FF19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:47:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so14048632wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680205654;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ewJOGtXglM8Jvbu49ZgJaaMn69sCGGn1tvCVxSIRDU=;
        b=ECZu2oSQdW2V52K0BGJL4j4CgFMdB+VtEWzIUR1aZGgOd61sK7G3C9g9yxHH69HDm5
         x0MI6G/so7TUfg3jGp0yw6N/eJKtDqtn0nGJ46z/2AnYn26WQNF47NBfdu+Aw5a5daBv
         ACR0PKW7xM/UX9Ij0mKCVs8IZavwuNvdJ+YKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205654;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ewJOGtXglM8Jvbu49ZgJaaMn69sCGGn1tvCVxSIRDU=;
        b=JCnmT2T8lNmDtcaB6EJyHZkbkz/bMjfwv6hf4XEawazIIszFnz9Hszo0d0XQVZsS1U
         FyNrFb4WVgWXArK9g5S60gABz4h5h0c490LK7drXnenFngRL+Kmdge6/03movMB6uynJ
         6u5zpX9pY2t6g14PUbocwsuzGrHmfhl6dIGkke/ngBE77O7nelemtVufqYYjkE7P+NQv
         yg63WYoQmjjx1js/TVUoBCMOyAFJA87uMbPljIq/gvXoueReyPzq+trmNVzha6wKA2IW
         VowlCnJMNr01FQd7xanP1YslvgHm7/WtOdL06Ftn2DYjV8LLs7kPOe9rB40OF5eD9LDw
         7npQ==
X-Gm-Message-State: AAQBX9dRBlJnc1u22kQd+sMHJ5ccIeKghBU57IwSyunOxF6ung0CR1Qb
        Q9JJ06lyAQfNwurdCKLiKgaUwx5i59bX8QHwbd8=
X-Google-Smtp-Source: AKy350ZTD2RzN3Xp6/Cr+LJ6KXdcii7BjnTmtq183be4/On6yl6OM1PDQcDP5OaDrrPXzGFdY9fEAA==
X-Received: by 2002:a05:600c:1c83:b0:3ed:ebcb:e2c6 with SMTP id k3-20020a05600c1c8300b003edebcbe2c6mr2828450wms.3.1680205654607;
        Thu, 30 Mar 2023 12:47:34 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm7292817wmo.26.2023.03.30.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:47:34 -0700 (PDT)
Date:   Thu, 30 Mar 2023 21:47:32 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PULL] drm-fixes for 6.3-rc5
Message-ID: <ZCXnVLzzdzt4xX7E@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 6.1.0-6-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Next week's pull probably on Wed already because easter w/e. Two
regression fixes in here, otherwise just the usual stuff.

drm-fixes-2023-03-30:
drm-fixes for 6.3-rc5

- i915 fixes for color mgmt, psr, lmem flush, hibernate oops, and more
- amdgpu: dp mst and hibernate regression fix
- etnaviv: revert fdinfo support (incl drm/sched revert), leak fix
- misc ivpu fixes, nouveau backlight, drm buddy allocator 32bit fixes

Cheers, Daniel

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-30

for you to fetch changes up to 7af63e079a7d6d45a3796a7ba625e2ec131f62be:

  Merge branch 'etnaviv/fixes' of https://git.pengutronix.de/git/lst/linux into drm-fixes (2023-03-30 20:15:07 +0200)

----------------------------------------------------------------
drm-fixes for 6.3-rc5

- i915 fixes for color mgmt, psr, lmem flush, hibernate oops, and more
- amdgpu: dp mst and hibernate regression fix
- etnaviv: revert fdinfo support (incl drm/sched revert), leak fix
- misc ivpu fixes, nouveau backlight, drm buddy allocator 32bit fixes

----------------------------------------------------------------
Andrzej Kacprowski (1):
      accel/ivpu: Fix IPC buffer header status field value

Ashutosh Dixit (1):
      drm/i915/pmu: Use functions common with sysfs to read actual freq

Chris Wilson (2):
      drm/i915/gem: Flush lmem contents after construction
      drm/i915/perf: Drop wakeref on GuC RC error

Daniel Vetter (5):
      Merge tag 'drm-intel-fixes-2023-03-30' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.3-2023-03-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2023-03-30' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-6.3-2023-03-30' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge branch 'etnaviv/fixes' of https://git.pengutronix.de/git/lst/linux into drm-fixes

David Gow (2):
      drm: buddy_allocator: Fix buddy allocator init on 32-bit systems
      drm: test: Fix 32-bit issue in drm_buddy_test

Fangzhi Zuo (2):
      drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub
      drm/amd/display: Take FEC Overhead into Timeslot Calculation

Hans de Goede (1):
      drm/nouveau/kms: Fix backlight registration

Imre Deak (1):
      drm/i915/tc: Fix the ICL PHY ownership check in TC-cold state

Lucas Stach (3):
      drm/etnaviv: fix reference leak when mmaping imported buffer
      Revert "drm/etnaviv: export client GPU usage statistics via fdinfo"
      Revert "drm/scheduler: track GPU active time per entity"

Stanislaw Gruszka (7):
      accel/ivpu: Do not access HW registers after unbind
      accel/ivpu: Cancel recovery work
      accel/ivpu: Do not use SSID 1
      accel/ivpu: Fix power down sequence
      accel/ivpu: Disable buttress on device removal
      accel/ivpu: Remove support for 1 tile SKUs
      accel/ivpu: Fix VPU clock calculation

Tim Huang (1):
      drm/amdgpu: allow more APUs to do mode2 reset when go to S4

Ville Syrjälä (6):
      drm/i915: Split icl_color_commit_noarm() from skl_color_commit_noarm()
      drm/i915: Move CSC load back into .color_commit_arm() when PSR is enabled on skl/glk
      drm/i915: Add a .color_post_update() hook
      drm/i915: Workaround ICL CSC_MODE sticky arming
      drm/i915: Disable DC states for all commits
      drm/i915/dpt: Treat the DPT BO as a framebuffer

 drivers/accel/ivpu/ivpu_drv.c                      |  18 +++-
 drivers/accel/ivpu/ivpu_drv.h                      |   7 +-
 drivers/accel/ivpu/ivpu_hw_mtl.c                   | 113 +++++++--------------
 drivers/accel/ivpu/ivpu_ipc.h                      |   2 +-
 drivers/accel/ivpu/ivpu_job.c                      |  11 +-
 drivers/accel/ivpu/ivpu_pm.c                       |  17 +++-
 drivers/accel/ivpu/ivpu_pm.h                       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  51 ++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  15 +++
 drivers/gpu/drm/drm_buddy.c                        |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  43 +-------
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |  10 +-
 drivers/gpu/drm/i915/display/intel_color.c         | 101 +++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_color.h         |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |  31 +++++-
 drivers/gpu/drm/i915/display/intel_dpt.c           |   2 +
 drivers/gpu/drm/i915/display/intel_tc.c            |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c           |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   3 +
 drivers/gpu/drm/i915/gt/intel_rps.c                |  38 +++----
 drivers/gpu/drm/i915/gt/intel_rps.h                |   4 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  14 ++-
 drivers/gpu/drm/i915/i915_perf_types.h             |   6 ++
 drivers/gpu/drm/i915/i915_pmu.c                    |  10 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |   7 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   6 --
 drivers/gpu/drm/tests/drm_buddy_test.c             |   3 +-
 include/drm/gpu_scheduler.h                        |   7 --
 30 files changed, 341 insertions(+), 200 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
