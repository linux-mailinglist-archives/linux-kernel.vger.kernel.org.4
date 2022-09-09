Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88F5B3C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIIP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIIP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:58:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F011B031
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:58:08 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11eab59db71so4945175fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=LforsK3uQj1bEdjt7oBoGTnSPQgzrR6nljtmC4TEjmQ=;
        b=UKwY3RMPigziYGOBVflT8cBm5XddnOAoNWLBbanvuNo7dQgQpQE6riib/ihg7jxeY2
         u53csEYP9faFhLQRix3BqsQcVYpxxzozTwOfLfq5Y/760GhDS+OehchyFlyFGSb5aeQy
         zP+W1GT75OfNUsEqXt6f/cGTDsf+z9gBr2bW7Ib/bS/bCjU9GsTuOeEdPvDrNxpVgjSF
         VH8SLCvPy4oilmiNmVLuRGHorimtSu7LK39lNqcJo7DtigIElPvDFiYJqMYT1SLyqV2L
         IGV9aFDLnQFzQs0NgosgBNTQuMDO6H95oknp/Kc0VMGIZv6qe6nUvY75FQqvMAnrZwF1
         4GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LforsK3uQj1bEdjt7oBoGTnSPQgzrR6nljtmC4TEjmQ=;
        b=izdTd5Gy5pELCwnwX0qIySOtCHsFpE8Zq0GDRPDQ8uezPG1DPtxhViLx9pdn/XR8aU
         oNL9QfBkJEu1V+gKty9p7dELjwJWdjm8kGyPgewxGetioJ81vPoNoFd4OnVpsjehShuq
         DdX8MBYAr/BwvanmIHOY4bXfgDX9xquOUXIr1O+suKb6Qhxu6XYMkq3biPKkiSejlQa+
         qLfyI3U3pbkePICxB0DjsjiYa3AQv861sfM4WBbHuT5dWeAVmVvvYfm3tgCwmb8s1SeM
         wEZLWqGwJYzDQeujkFprMe2L6joBrHCK7mJkaWVRrxeElO87/v7W+Fvv/kUxeUaWcyVp
         bqcw==
X-Gm-Message-State: ACgBeo2m+x5z9NSFNPDzNw1CR3/J7kPgj/9Khe7gvWFlsqmKx1hHv2da
        rFX/yl6ebeEVzORo//hXGiGp2v2h01D1iP3YXzbp3cEEhuJF7QuP
X-Google-Smtp-Source: AA6agR4qKH2lH2UfOozkO6mL3JZqYlPDOABlyN195mlfTkEyptW7D3JBJU0RKC962fy4lLFASnCFiTT6WNPGxkBVFFk=
X-Received: by 2002:a05:6870:2044:b0:116:d25d:a6d7 with SMTP id
 l4-20020a056870204400b00116d25da6d7mr5445469oad.132.1662739087393; Fri, 09
 Sep 2022 08:58:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 10 Sep 2022 01:57:22 +1000
Message-ID: <CAPM=9tydpsi2=fujRgT4B2CcOgY1EQ7WmVUNtcZ+1jUjoDbK9Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.0-rc5
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

From a train in the Irish countryside, regular drm fixes for 6.0-rc5.
This is mostly amdgpu/amdkfd and i915 fixes, then one panfrost, one
ttm and one edid fix. Nothing too major going on. Hopefully a quiet
week next week for LPC.

Dave.

drm-fixes-2022-09-10:
drm fixes for 6.0-rc5

edid:
- Fix EDID 1.4 range-descriptor parsing

ttm:
- Fix ghost-object bulk moves

i915:
- Fix MIPI sequence block copy from BIOS' table
- Fix PCODE min freq setup when GuC's SLPC is in use
- Implement Workaround for eDP
- Fix has_flat_ccs selection for DG1

amdgpu:
- Firmware header fix
- SMU 13.x fix
- Debugfs memory leak fix
- NBIO 7.7 fix
- Firmware memory leak fix

amdkfd:
- Debug output fix

panfrost:
- Fix devfreq OPP
The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179=
:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-10

for you to fetch changes up to 2edb79a5fb303dff577d6a0c7d571c3bab1d1455:

  Merge tag 'drm-intel-fixes-2022-09-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-09-10
01:42:47 +1000)

----------------------------------------------------------------
drm fixes for 6.0-rc5

edid:
- Fix EDID 1.4 range-descriptor parsing

ttm:
- Fix ghost-object bulk moves

i915:
- Fix MIPI sequence block copy from BIOS' table
- Fix PCODE min freq setup when GuC's SLPC is in use
- Implement Workaround for eDP
- Fix has_flat_ccs selection for DG1

amdgpu:
- Firmware header fix
- SMU 13.x fix
- Debugfs memory leak fix
- NBIO 7.7 fix
- Firmware memory leak fix

amdkfd:
- Debug output fix

panfrost:
- Fix devfreq OPP

----------------------------------------------------------------
Chengming Gui (1):
      drm/amd/amdgpu: add rlc_firmware_header_v2_4 to amdgpu_firmware_heade=
r

Christian K=C3=B6nig (1):
      drm/ttm: cleanup the resource of ghost objects after locking them

Cl=C3=A9ment P=C3=A9ron (1):
      drm/panfrost: devfreq: set opp to the recommended one to
configure regulator

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.0-2022-09-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-09-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-09-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/pm: add missing SetMGpuFanBoostLimitRpm mapping for SMU 13.0.=
7

Greg Kroah-Hartman (1):
      drm/amd/display: fix memory leak when using debugfs_lookup()

Guchun Chen (1):
      drm/amdgpu: prevent toc firmware memory leak

Matthew Auld (1):
      drm/i915: consider HAS_FLAT_CCS() in needs_ccs_pages

Rodrigo Vivi (1):
      drm/i915/slpc: Let's fix the PCODE min freq table setup for SLPC

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/edid: Handle EDID 1.4 range descriptor h/vfreq offsets
      drm/i915/bios: Copy the whole MIPI sequence block
      drm/i915: Implement WaEdpLinkRateDataReload

Yifan Zhang (2):
      drm/amdkfd: print address in hex format rather than decimal
      drm/amdgpu: correct doorbell range/size value for CSDMA_DOORBELL_RANG=
E

ZhenGuo Yin (1):
      drm/ttm: update bulk move object of ghost BO

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c             |  6 ---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  1 +
 drivers/gpu/drm/drm_debugfs.c                      |  4 +-
 drivers/gpu/drm/drm_edid.c                         | 24 ++++++++---
 drivers/gpu/drm/i915/display/intel_bios.c          |  7 +++
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 22 ++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  3 ++
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  2 +-
 drivers/gpu/drm/i915/gt/intel_llc.c                | 19 ++++----
 drivers/gpu/drm/i915/gt/intel_rps.c                | 50 ++++++++++++++++++=
++++
 drivers/gpu/drm/i915/gt/intel_rps.h                |  2 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        | 11 +++++
 drivers/gpu/drm/ttm/ttm_bo_util.c                  | 13 +++---
 include/drm/drm_connector.h                        |  4 +-
 include/drm/drm_edid.h                             |  5 +++
 19 files changed, 149 insertions(+), 35 deletions(-)
