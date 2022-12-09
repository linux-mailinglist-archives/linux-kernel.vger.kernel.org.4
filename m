Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082CD647AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLIAvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLIAvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:51:13 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65AA5056
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:51:12 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id u10so2169356qvp.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jVJi4dNSNacB4wvYYeR7Sa3OCix5As/EG22nKTSzXM=;
        b=I8zeUx2x3CS4rb+kRXP2PEPYVcUk+O4hFVowgJ2q5ScWVja0pjFhlFm1YHqaLkxp+u
         bKAjNTsFizODkd3ghcx9nOAhD170K/6gBDSioxC9C9IDw/LnpcasHkx6uf5F+ctmgZ+2
         GMjYld4im21q2tqXK53yFnD9dc4td6/qnIUPKv1jRUzoFiW6K0l4vl3oN7zfqnlahNbv
         JltQFr2h+FvFVmqnRw1SP9e0yKov962MMeVMDF1UfcglXgWh6zSnH89BwGA3BQPkrgZL
         8BWk19kC537bV12/akiKJyzmCx4FRj7TrcWcSU65uaoBddXxVEUwJBHeKbIxKqVTAyk4
         b+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jVJi4dNSNacB4wvYYeR7Sa3OCix5As/EG22nKTSzXM=;
        b=nCqFEnVwD+6saqX39B5pP2G9v00K8+bUjqQCnyRFvSzHNJCQ+J7qv27L9n+Jo15AZZ
         CmPvUoqsNdku5mQ1QhTqHKBD3raJ4FzLpGtjgiwwIpp/yeJ9CGLmXEwjjfcj4Y429VMf
         65sFGIFzqACv1KPceFz0Sbrc9T1NXjxrWbgsdlQzEuLkhDM1JUPl7RQ2ImdokjSX0AgG
         u/JOkaKhYxResF2DrqTYT3fQKLYaDs0TUbaFvHuP+QqwqW5rmdxDpbQpCagD3I+VxRlA
         LccUOcLxJ7VQQymrG8P1N7ICpYrh8JNgAYXxcR6X80+gUO5Jt4kb0kMRuyody4zCZPje
         E2bA==
X-Gm-Message-State: ANoB5pkd2bAw63uV7H04c9xkEnPoZI7LYjwoK9y37VR5gTIeLypkmD/e
        mno95TYk1dVU1OtfqcTNnoVvAVvPD11Pc7qcNv9y9ddQ/xw=
X-Google-Smtp-Source: AA0mqf6QNS8E2mJa//UOMpt7kUwEHAAbWqJprw1gVfmcRJqsq1eq+8IjnW9x6aSnNi61u4mFoOOeDBMI2quIQL31I9c=
X-Received: by 2002:ad4:50cc:0:b0:4c7:95b6:ed07 with SMTP id
 e12-20020ad450cc000000b004c795b6ed07mr4135332qvq.97.1670547072008; Thu, 08
 Dec 2022 16:51:12 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 9 Dec 2022 10:51:00 +1000
Message-ID: <CAPM=9tztpF=EZ04jLii6DFiLQdm6s0QhXvosFyggDHikfLLteg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.1 final
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

Last set of fixes for final, scattered bunch of fixes, two amdgpu, one
vmwgfx, and some misc others.

Dave.

drm-fixes-2022-12-09:
drm fixes for 6.1-rc9

amdgpu:
- S0ix fix
- DCN 3.2 array out of bounds fix

shmem:
- Fixes to shmem-helper error paths.

bridge:
- Fix polarity bug in bridge/ti-sn65dsi86.

dw-hdmi:
- Prefer 8-bit RGB fallback before any YUV mode in dw-hdmi, since some
  panels lie about YUV support.

vmwgfx:
- Stop using screen objects when SEV is active.
The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-09

for you to fetch changes up to c4252650a8c4770b669398fe7270ed8c94fc0eba:

  Merge tag 'drm-misc-fixes-2022-12-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2022-12-09
10:11:06 +1000)

----------------------------------------------------------------
drm fixes for 6.1-rc9

amdgpu:
- S0ix fix
- DCN 3.2 array out of bounds fix

shmem:
- Fixes to shmem-helper error paths.

bridge:
- Fix polarity bug in bridge/ti-sn65dsi86.

dw-hdmi:
- Prefer 8-bit RGB fallback before any YUV mode in dw-hdmi, since some
  panels lie about YUV support.

vmwgfx:
- Stop using screen objects when SEV is active.

----------------------------------------------------------------
Aurabindo Pillai (1):
      drm/amd/display: fix array index out of bound error in DCN32 DML

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-6.1-2022-12-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-12-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Dawei Li (1):
      drm/vmwgfx: Fix race issue calling pin_user_pages

Guillaume BRUN (1):
      drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420

Prike Liang (1):
      drm/amdgpu/sdma_v4_0: turn off SDMA ring buffer in the s2idle suspend

Qiqi Zhang (1):
      drm/bridge: ti-sn65dsi86: Fix output polarity setting bug

Rob Clark (2):
      drm/shmem-helper: Remove errant put in error path
      drm/shmem-helper: Avoid vm_open error paths

Zack Rusin (1):
      drm/vmwgfx: Don't use screen objects when SEV is active

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             | 24 ++++++++++++++--------
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  6 +++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  4 ++--
 drivers/gpu/drm/drm_gem_shmem_helper.c             | 18 ++++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |  6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  4 ++++
 7 files changed, 40 insertions(+), 24 deletions(-)
