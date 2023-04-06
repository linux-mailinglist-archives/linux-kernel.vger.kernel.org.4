Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212E6D9E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjDFQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjDFQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:59:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156393C9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:59:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-947f54f67acso19163266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680800355; x=1683392355;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/G8f3W01YCqpjthYavhau9B1PGMpmkUV6eXNWY0zjI=;
        b=bDxIiCCZqgTUjnCeJuc0gA9XJBATxfxl1Ir5e6ciEYjrom4D2PDgDUc1NMlZka/Vei
         y9WsebyDlx12n8FCtiuO8cJR+Ls9mWEAUif9UB3nRmt9sKRb5caHKe/U0QhXRZ7ioTxI
         3O6iu7XH8onh8wKktzfXy1qaDsVl6ZKoJfd3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800355; x=1683392355;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/G8f3W01YCqpjthYavhau9B1PGMpmkUV6eXNWY0zjI=;
        b=b+3esT3pxD8xMV2ZqXqNvKgwnpmIUkq1N04NJ0CWusXNTGvjgOSl9lEWN49/vKZzQL
         x34RsusAaWzWThL5V0aTB8I9EcOAbZ1NY9O+ZhVKrGSIwBuFpougKERe8KZQreEFPTM2
         boDTYp7jbeMUIgeBNXXw0fTOervKgjX60/0xQQmc+Sl/fvIYc5FTG03/JRwUrIzFsbID
         0jnqKGKh7M6MP7EAlz1g86qRjXxuVFMRBgDelZZwWs48ZKciZnQMsD1ALdSWp1SrEAL1
         FDgzks3TTyXEnw9hatYROVWAJcMA97lMTFoOIYl6MgirbDpLEtvTtsSOYDV76ppoqfGA
         v5pg==
X-Gm-Message-State: AAQBX9eufmXu2mT3sJPPWDBCPFwLbuxPLM0WbciAWRe6zjSe2O2ox6BD
        3w4Ucz1yypMINE6wYwLQhdHTHMcFXZqLaF9hvS8=
X-Google-Smtp-Source: AKy350b0HKz4EmLwVKLDBtPtW14y5dXvgX1z2YmgKhB0or54fU64MTr5E5qHbU9WIzJJdDD1ltobeg==
X-Received: by 2002:a05:6402:1e8e:b0:501:ea97:5192 with SMTP id f14-20020a0564021e8e00b00501ea975192mr211588edf.4.1680800355329;
        Thu, 06 Apr 2023 09:59:15 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id h10-20020aa7de0a000000b005023ddb37eesm952574edv.8.2023.04.06.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:59:14 -0700 (PDT)
Date:   Thu, 6 Apr 2023 18:59:13 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes for -rc6
Message-ID: <ZC76YY3s8vi/3hgl@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As expected not much because a bunch of people are enjoying spring break
around easter. I'll be gone until Tue too.

Cheers, Daniel

drm-fixes-2023-04-06:
drm-fixes for 6.3-rc6

Mostly i915 fixes: dp mst for compression/dsc, perf ioctl uaf, ctx rpm
accounting, gt reset vs huc loading.

And a few individual driver fixes: ivpu dma fence&suspend, panfrost
mmap, nouveau color depth

Cheers, Daniel

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-06

for you to fetch changes up to 3dfa8926efa910d423844bfc0132f70cd07f76e2:

  Merge tag 'drm-misc-fixes-2023-04-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-04-05 21:06:28 +0200)

----------------------------------------------------------------
drm-fixes for 6.3-rc6

Mostly i915 fixes: dp mst for compression/dsc, perf ioctl uaf, ctx rpm
accounting, gt reset vs huc loading.

And a few individual driver fixes: ivpu dma fence&suspend, panfrost
mmap, nouveau color depth

----------------------------------------------------------------
Boris Brezillon (1):
      drm/panfrost: Fix the panfrost_mmu_map_fault_addr() error path

Daniel Vetter (2):
      Merge tag 'drm-intel-fixes-2023-04-05' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2023-04-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Daniele Ceraolo Spurio (1):
      drm/i915/huc: Cancel HuC delayed load timer on reset.

Jacek Lawrynowicz (1):
      accel/ivpu: Fix S3 system suspend when not idle

Karol Herbst (1):
      drm/nouveau/disp: Support more modes by checking with lower bpc

Karol Wachowski (1):
      accel/ivpu: Add dma fence to command buffers only

Matthew Auld (1):
      drm/i915/ttm: fix sparse warning

Min Li (1):
      drm/i915: fix race condition UAF in i915_perf_add_config_ioctl

Stanislav Lisovskiy (1):
      drm/i915: Use compressed bpp when calculating m/n value for DP MST DSC

Tvrtko Ursulin (1):
      drm/i915: Fix context runtime accounting

 drivers/accel/ivpu/ivpu_job.c                      | 18 +++++-------
 drivers/accel/ivpu/ivpu_pm.c                       | 26 ++++++++----------
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  5 ++--
 .../gpu/drm/i915/gt/intel_execlists_submission.c   | 12 ++++++--
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |  7 +++++
 drivers/gpu/drm/i915/gt/uc/intel_huc.h             |  7 +----
 drivers/gpu/drm/i915/i915_perf.c                   |  6 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 32 ++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_dp.c               |  8 ++++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  1 +
 11 files changed, 81 insertions(+), 43 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
