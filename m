Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966AA625013
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiKKCSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKKCSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:18:35 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB1FDB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:18:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id cg5so2056014qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/IOZ+XX08H0bYe5onrCpzQpg6HHQ7pbRNUyh4Eb5zI=;
        b=RQY8NMNahT7O7942tO8jvI0THFPkCqCFIzKmRclNv7TvRBDevZKnW6ER8AjOcdmYPS
         49a0av1z9ABEy91+v2DproGn7rAssH16TSD7CVlrtNnmborUC+OVPD0Mc/rd/s/RYnD3
         eduse0dA+NcI7ah0kHRYUsopdrvimRrP0lzog1OlYp/sW+xmslxNhkaYW3ILeJgvxKuP
         6Jw3mSaNmW9if8zg7FZoacvwLlGATMs0S6znZVD5vVe9TqAn67vMc52PmK626gA5V5GP
         NIsLrfSue3IiMbxwkpe12CBpxet0B6jtRVl5tQiPGkMkHNWmNeGG4aKzzGjZsgAl/t+s
         p/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/IOZ+XX08H0bYe5onrCpzQpg6HHQ7pbRNUyh4Eb5zI=;
        b=o3qJ+6FCRZjva9OS3SZfxi/pSSKQJGJNsUzV1QdXaz0YsFcWoG5P16HOxuRZjVt5x4
         TB8YGibbtyr/dj9HzYetYNaNveT5as8BRS+4j+DwtcnGNLbdK9a18SB8OPlp2SOTaQdi
         mrbGBn3iwzIeNrXKHhz1Vaqlre17twvlNn3zx7J45envy6tzJ5XkavfyWoxIa993CUZ7
         9TVWIf6tccnVPC7HWwJV7OTUgkL0IDQKhKdCZd9VSsB9bCWpQe1pZ5aNsVxIITI5YSNP
         8UD0PcTWk9fEC977aXMxrJM2lumgjghWGxRyH8JtnqiwLPLFywAsAJLnsCNY1UGqYqoZ
         MqrQ==
X-Gm-Message-State: ACrzQf25DLezUQjinD39VOF6cxFAXHLSnpMKILqJKg3BPXvK8usQ/UTz
        F8q9uwtegZb/arDQQ/otCFYlBVU9Xdnjxpz4I097TAOG0Jg=
X-Google-Smtp-Source: AMsMyM6/Db1PYAGoUHGhFFSewBrf6UZ/CS1/KYNylbx9IraQ2Bh5kNN90FwIQ9uuTkTfidS1xOPhE7lAMu13C2Ycldw=
X-Received: by 2002:a05:622a:8cd:b0:3a5:75dc:ed0a with SMTP id
 i13-20020a05622a08cd00b003a575dced0amr2407683qte.329.1668133113378; Thu, 10
 Nov 2022 18:18:33 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Nov 2022 12:18:21 +1000
Message-ID: <CAPM=9tz0wieno61nXib1N+P2KKERh6HO947d6rEYiBZMccr4Lg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.1-rc5
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

Weekly pull request for graphics, mostly amdgpu and i915, with a
couple of fixes for vc4 and panfrost, panel quirks and a kconfig
change for rcar-du. Nothing seems to be too strange at this stage.

drm-fixes-2022-11-11:
drm fixes for 6.1-rc5

amdgpu:
- Fix s/r in amdgpu_vram_mgr_new
- SMU 13.0.4 update
- GPUVM TLB race fix
- DCN 3.1.4 fixes
- DCN 3.2.x fixes
- Vega10 fan fix
- BACO fix for Beige Goby board
- PSR fix
- GPU VM PT locking fixes

amdkfd:
- CRIU fixes

vc4:
- HDMI fixes to vc4.

panfrost:
- Make panfrost's uapi header compile with C++.
- Handle 1 gb boundary correctly in panfrost mmu code.

panel:
- Add rotation quirks for 2 panels.

rcar-du:
- DSI Kconfig fix

i915:
- Fix sg_table handling in map_dma_buf
- Send PSR update also on invalidate
- Do not set cache_dirty for DGFX
- Restore userptr probe_range behaviour
The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc=
:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-11

for you to fetch changes up to b7ffd9d9ee13de2c5ad88046a5149de4cfb2a74b:

  Merge tag 'drm-intel-fixes-2022-11-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-11-11
10:20:11 +1000)

----------------------------------------------------------------
drm fixes for 6.1-rc5

amdgpu:
- Fix s/r in amdgpu_vram_mgr_new
- SMU 13.0.4 update
- GPUVM TLB race fix
- DCN 3.1.4 fixes
- DCN 3.2.x fixes
- Vega10 fan fix
- BACO fix for Beige Goby board
- PSR fix
- GPU VM PT locking fixes

amdkfd:
- CRIU fixes

vc4:
- HDMI fixes to vc4.

panfrost:
- Make panfrost's uapi header compile with C++.
- Handle 1 gb boundary correctly in panfrost mmu code.

panel:
- Add rotation quirks for 2 panels.

rcar-du:
- DSI Kconfig fix

i915:
- Fix sg_table handling in map_dma_buf
- Send PSR update also on invalidate
- Do not set cache_dirty for DGFX
- Restore userptr probe_range behaviour

----------------------------------------------------------------
Asher Song (1):
      Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm
for vega10 properly""

Aurabindo Pillai (1):
      drm/amd/display: Zeromem mypipe heap struct before using it

Chaitanya Dhere (1):
      drm/amd/display: Fix FCLK deviation and tool compile issues

Christian K=C3=B6nig (1):
      drm/amdgpu: workaround for TLB seq race

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.1-2022-11-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-11-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-20221109' of
git://linuxtv.org/pinchartl/media into drm-fixes
      Merge tag 'drm-intel-fixes-2022-11-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dillon Varone (1):
      drm/amd/display: Enforce minimum prefetch time for low memclk on DCN3=
2

Felix Kuehling (2):
      drm/amdkfd: Fix error handling in kfd_criu_restore_events
      drm/amdkfd: Fix error handling in criu_checkpoint

Guchun Chen (1):
      drm/amdgpu: disable BACO on special BEIGE_GOBY card

Hamza Mahfooz (1):
      drm/amd/display: only fill dirty rectangles when PSR is enabled

Hans de Goede (2):
      drm: panel-orientation-quirks: Add quirk for Nanote UMPC-01
      drm: panel-orientation-quirks: Add quirk for Acer Switch V 10 (SW5-01=
7)

Jouni H=C3=B6gander (1):
      drm/i915/psr: Send update also on invalidate

Laurent Pinchart (1):
      drm: rcar-du: Fix Kconfig dependency between RCAR_DU and RCAR_MIPI_DS=
I

Ma Jun (1):
      drm/amdgpu: Fix the lpfn checking condition in drm buddy

Matthew Auld (2):
      drm/i915/dmabuf: fix sg_table handling in map_dma_buf
      drm/i915/userptr: restore probe_range behaviour

Nicholas Kazlauskas (2):
      drm/amd/display: Update SR watermarks for DCN314
      drm/amd/display: Fix reg timeout in enc314_enable_fifo

Niranjana Vishwanathapura (1):
      drm/i915: Do not set cache_dirty for DGFX

Philip Yang (2):
      drm/amdgpu: Unlock bo_list_mutex after error handling
      drm/amdgpu: Drop eviction lock when allocating PT BO

Robin Murphy (1):
      drm/panfrost: Split io-pgtable requests properly

Steve Su (1):
      drm/amd/display: Fix gpio port mapping issue

Steven Price (1):
      drm/panfrost: Remove type name from internal struct again

Tim Huang (1):
      drm/amd/pm: update SMU IP v13.0.4 msg interface header

Yuan Can (1):
      drm/vc4: Fix missing platform_unregister_drivers() call in
vc4_drm_register()

maxime@cerno.tech (3):
      drm/vc4: hdmi: Take our lock to reset the link
      drm/vc4: hdmi: Fix outdated function name in comment
      drm/vc4: hdmi: Fix HSM clock too low on Pi4

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 26 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             | 41 ++++++++++++++++++=
+
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 34 +++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  7 ++--
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 32 +++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 .../display/dc/dcn314/dcn314_dio_stream_encoder.c  | 24 ++++++++---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  1 +
 .../drm/amd/display/dc/dcn321/dcn321_resource.c    |  1 +
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  4 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  2 +
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |  5 +++
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |  3 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c        | 14 +++++--
 .../dc/dml/dcn32/display_mode_vba_util_32.h        |  3 +-
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |  2 +
 .../drm/amd/display/dc/dml/display_mode_structs.h  |  1 +
 .../amd/display/dc/gpio/dcn32/hw_factory_dcn32.c   | 14 +++++++
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |  9 +++--
 .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 25 ++++++------
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h   | 15 ++++---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  4 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     | 12 ++++++
 drivers/gpu/drm/i915/display/intel_psr.c           |  5 ++-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |  5 ++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            | 11 ++++-
 drivers/gpu/drm/rcar-du/Kconfig                    | 13 ++++--
 drivers/gpu/drm/vc4/vc4_drv.c                      |  7 +++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 47 +++++++++++++++++-=
----
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  1 +
 include/uapi/drm/panfrost_drm.h                    |  2 +-
 37 files changed, 258 insertions(+), 129 deletions(-)
