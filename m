Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B46E156E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDMTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:51:59 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836A8A42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:51:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bh10so10752796oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681415509; x=1684007509;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59xyDC9ZSWXV341Wu5FNueXR+XJowtVJP0DizkPdfFs=;
        b=h9jPzG/dcUSmvNi2dPyu84iaDmvWbVQHQVlXKglMJlv167YBUDEm3FpOtlXxt9EaCd
         MtzpzGHTAMLorPU0WONEv6DOwGEIIK0J3mCMAxcLoel7xd3QYAhD9PMqpqrg9lWKXrHu
         lhSlWQq/SS+sv66P1t6xdTedXwVFW5r7jmweA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681415509; x=1684007509;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59xyDC9ZSWXV341Wu5FNueXR+XJowtVJP0DizkPdfFs=;
        b=eYzmHRZm40xLVfV4mUlOzWBw8sjI7bz/nD2MD89087h5RhESwoV4YOM239e0JMELwO
         +oFqk4e72UKSnOxtdWE40sVsCrF8aHyKTq6GwvpCagje7dXkpR6QMRu1P+FdBNF1yOEt
         tkaCct2AF7XOBKELzXIcDCmLdw3cZgCyQNnJWN5+6PlmmyPx0iSzzrNqEPCT6ugkSnUn
         GxFft4U0zaMoPUMYNJk89ZrBoVowEmWADyxoM8iiPldicPwBPXvQBiOZqgTEszewipFd
         795XoPvTX7sFGVWu2WHrOkgpLzGwTRo4RWNxc+8KjlZ5K4XmtWgWYAPuqD9NqbzOe6V1
         OOVA==
X-Gm-Message-State: AAQBX9dSDc80NYIfGtDvQP5NDpQ40JXfxj95DK3UsUim3XYsbm84GCLT
        CQcxk6ro/nvNEFy0/I3Q6f3sAjOzK1B0mjWH695MKg==
X-Google-Smtp-Source: AKy350YRwloX6wrMPpX0c5vx9aI9nT3Rkz9UU+Qv6sNaS8uYAcGc+/V8sEso/1ex7VLILj3PMw+fF58bqdYPBRFPhxU=
X-Received: by 2002:aca:120c:0:b0:38b:f7fa:40ac with SMTP id
 12-20020aca120c000000b0038bf7fa40acmr785143ois.8.1681415509145; Thu, 13 Apr
 2023 12:51:49 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 13 Apr 2023 21:51:38 +0200
Message-ID: <CAKMK7uHy7FMdpEZLu2TTzgnGOrntBcQi_B0c=X+oT_fyUhcTDw@mail.gmail.com>
Subject: [PULL] drm-fixes for 6.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

People seem back, still not much.
-Daniel

drm-fixes-2023-04-13:
drm-fixes for -rc7

- two fbcon regressions
- amdgpu: dp mst, smu13
- i915: dual link dsi for tgl+
- armada, nouveau, drm/sched, fbmem

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-13

for you to fetch changes up to cab2932213c5cd72a9e04e5e82002e81b946592b:

  Merge tag 'drm-misc-fixes-2023-04-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-04-13
20:47:58 +0200)

----------------------------------------------------------------
drm-fixes for -rc7

- two fbcon regressions
- amdgpu: dp mst, smu13
- i915: dual link dsi for tgl+
- armada, nouveau, drm/sched, fbmem

----------------------------------------------------------------
Asahi Lina (1):
      drm/scheduler: Fix UAF race in drm_sched_entity_push_job()

Christophe JAILLET (1):
      drm/armada: Fix a potential double free in an error handling path

Daniel Vetter (6):
      fbmem: Reject FB_ACTIVATE_KD_TEXT from userspace
      Merge tag 'amd-drm-fixes-6.3-2023-04-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2023-04-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      fbcon: Fix error paths in set_con2fb_map
      fbcon: set_con2fb_map needs to set con2fb_map!
      Merge tag 'drm-misc-fixes-2023-04-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Evan Quan (1):
      drm/amd/pm: correct the pcie link state check for SMU13

Horatio Zhang (2):
      drm/amd/pm: correct SMU13.0.7 pstate profiling clock settings
      drm/amd/pm: correct SMU13.0.7 max shader clock reporting

Jani Nikula (1):
      drm/i915/dsi: fix DSS CTL register offsets for TGL+

Karol Herbst (1):
      drm/nouveau/fb: add missing sysmen flush callbacks

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Wayne Lin (1):
      drm/amd/display: Pass the right info to drm_dp_remove_payload

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 57 ++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  6 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 87 +++++++++++++++++++---
 drivers/gpu/drm/armada/armada_drv.c                |  1 -
 drivers/gpu/drm/i915/display/icl_dsi.c             | 20 ++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c     |  1 +
 drivers/gpu/drm/scheduler/sched_entity.c           | 11 ++-
 drivers/video/fbdev/core/fbcon.c                   | 18 ++---
 drivers/video/fbdev/core/fbmem.c                   |  2 +
 13 files changed, 175 insertions(+), 35 deletions(-)

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
