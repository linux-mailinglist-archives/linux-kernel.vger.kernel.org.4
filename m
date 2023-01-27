Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B367DD11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjA0FXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjA0FWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:22:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BB61AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:22:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx13so10656671ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AIRfVPUF3auiDttQnKRgcplVNHSb6nAi9W3+CUN3MHM=;
        b=j00WlRSQife8DuJtHE5q7HP4Y//JBBd+69mmoVMrl1AhvaVKjU4i6FpEgtdo/YBoEK
         gel/toq2+8aa7f8V8Gdw9HMIdAz2Ncwp7r70pQEzZFNehSxgpKO04TBOuScKqFNT8BK5
         v6pMLBbB4b3RXnn5ZgznRRHRsGvHZJWV6IgKlzh7e6HJVypO6RpiqcR9WLqgY0qLZXhN
         yjVXcoox8S15sp+s469vaAW0JcEql3jDpAWOmwDEQhSGE60CV6P4Wimbn+gEzNrfGOM2
         COCRQaAdqfDDxdyj2AtLBxKnoc1jIzNImW/vFEvplqsG49iaavg0Rs8UHqqjAn+MrDHv
         Dn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIRfVPUF3auiDttQnKRgcplVNHSb6nAi9W3+CUN3MHM=;
        b=YBqCzyaKlvldm+o0/oaBXH2uKx7CCgTtE4zE/d3XGZJU5cjCM/XAYlLpAJcjrsmgXE
         cOWZE2f9U31CGx7m4IC4ewyrTKIlMLmEbCJKY06Nk6uZ0Og3RCwbc4zR3QxuJ5AIt/fq
         J+aKFnwv2+fe4UU7QmY2WkESlV/4eVdNmRrGEK44yZz4L5J3v55e1g2mQSQY2q1ReDVE
         7mdGu7sQwUoGmAoonTmp5q6Bmjiq4GHrQfbNqpZ285CE3sVj5XDF3oDKDRT+q3Il5agN
         AyNdYeDIQxCdUkZlA6q3/H3GL7gV7PqeFULNTCMQ43oll2cvubfIxEjyosmxmoZv7jPq
         Cy9A==
X-Gm-Message-State: AFqh2krIDkYz2r9+hpACtvY/YCBDcqL7hB6TYz7mnXT+UtNuC5mn7RIU
        1xOJVXy8Ls3M1z8OjBdNH7T2kg/96MxNGAT/aoc=
X-Google-Smtp-Source: AMrXdXvAowwBSdQmgQ0A5NBuv6/VJba6ElPGTtVatEOCnu9EPlZpvjksEqc5I0q3AwNkyPpr9tb9IYmBOVC8DnbNb94=
X-Received: by 2002:a17:906:13d4:b0:85f:68bf:265a with SMTP id
 g20-20020a17090613d400b0085f68bf265amr4246195ejc.278.1674796968294; Thu, 26
 Jan 2023 21:22:48 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Jan 2023 15:22:36 +1000
Message-ID: <CAPM=9tzuu4xnx6T5v7sKsK+A5HEaPOc1ieMyzNSYQZGztJ=6Qw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.2-rc6
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

Fairly small this week as well, i915 has a memory leak fix and some
minor changes, and amdgpu has some MST fixes, and some other minor
ones.

Dave.

drm-fixes-2023-01-27:
drm fixes for 6.2-rc6

drm:
- DP MST kref fix
- fb_helper: check return value

i915:
- Fix BSC default context for Meteor Lake
- Fix selftest-scheduler's modify_type
- memory leak fix

amdgpu:
- GC11.x fixes
- SMU13.0.0 fix
- Freesync video fix
- DP MST fixes
- build fix
The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-27

for you to fetch changes up to d23db89883962d9b4cb3ad03dfd02e525ed2cc03:

  Merge tag 'drm-misc-fixes-2023-01-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-01-27
12:31:09 +1000)

----------------------------------------------------------------
drm fixes for 6.2-rc6

drm:
- DP MST kref fix
- fb_helper: check return value

i915:
- Fix BSC default context for Meteor Lake
- Fix selftest-scheduler's modify_type
- memory leak fix

amdgpu:
- GC11.x fixes
- SMU13.0.0 fix
- Freesync video fix
- DP MST fixes
- build fix

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/i915/selftest: fix intel_selftest_modify_policy argument types

Aurabindo Pillai (1):
      drm/amd/display: Fix timing not changning when freesync video is enabled

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2023-01-26' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.2-2023-01-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      amdgpu: fix build on non-DCN platforms.
      Merge tag 'drm-misc-fixes-2023-01-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Evan Quan (1):
      drm/amd/pm: add missing AllowIHInterrupt message mapping for SMU13.0.0

Javier Martinez Canillas (2):
      drm/fb-helper: Check fb_deferred_io_init() return value
      drm/fb-helper: Use a per-driver FB deferred I/O handler

Jonathan Kim (1):
      drm/amdgpu: remove unconditional trap enable on add gfx11 queues

Li Ma (2):
      drm/amdgpu: enable imu firmware for GC 11.0.4
      drm/amdgpu: declare firmware for new MES 11.0.4

Lucas De Marchi (1):
      drm/i915/mtl: Fix bcs default context

Lyude Paul (1):
      drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count assignments

Nirmoy Das (2):
      drm/drm_vma_manager: Add drm_vma_node_allow_once()
      drm/i915: Fix a memory leak with reused mmap_offset

Wayne Lin (3):
      drm/amdgpu/display/mst: limit payload to be updated one by one
      drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD
      drm/display/dp_mst: Correct the kref of port.

 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 31 +++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 51 +++++++++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  5 --
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 14 +++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  1 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |  4 +-
 drivers/gpu/drm/drm_fbdev_generic.c                | 15 +++--
 drivers/gpu/drm/drm_vma_manager.c                  | 76 +++++++++++++++-------
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 37 +----------
 .../drm/i915/selftests/intel_scheduler_helpers.c   |  3 +-
 include/drm/drm_fb_helper.h                        | 12 ++++
 include/drm/drm_vma_manager.h                      |  1 +
 15 files changed, 167 insertions(+), 89 deletions(-)
