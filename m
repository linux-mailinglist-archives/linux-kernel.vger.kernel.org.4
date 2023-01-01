Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79C065AA0D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjAAM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:57:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB538E
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 04:57:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so23963322wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WjNoY5IEvjPDMwxYOjVr5XNJFzUvkwo/1gPfAgJB4E=;
        b=DrgbVEQWkHJ03XjgEctC2zPckZT+MASF608kCD+Vp1xLbX2ED4+fcuAk+FfvqcuRYX
         nC6bmfBnM1IZgrsHkt9Nb0L0htIxO49GpsG13w9tcbjXYocCwsf9indzKDZC6a1DfDc/
         Wcqv7szwb2FOk/im0eVEUxhWPCf6lv573+rbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WjNoY5IEvjPDMwxYOjVr5XNJFzUvkwo/1gPfAgJB4E=;
        b=kbfQZhwVUweKOfCdFvM5Erq/cP4z3VI8GiofXmyHAuxRvpiC9isjWtjacxixq+oljN
         y5aeqBeDNyRHOBEgNSx8iFz6e75Bz4m0CRjMomjHD8MDMnpkOZmsLFjJtbdDU9r0jsmw
         7cCzDQeMzmyMxDPa3pvG7bNgppkCfjonvOdfcoj3SpvAwIaGFlMmXoRtsSn9hWsLdwbz
         li4GAH3Q6awgldWhLyT2NNMZCO+1NZgyX5mDwKQhQvNwTW3J28L52HnRvm9O3mp4Ym3q
         uZQsQx6oUk7W+4sJ8pb3LkcSphYgvrNLe6aSD78WcQG+tz/pjjIKpwFhcTZdOtZW9/7i
         jxiA==
X-Gm-Message-State: AFqh2krS+Doae7SPp3B9c5kAJe4Fa8kwDJDW++ZTD9CeWboaL+hcguOS
        SMpNOevx7UdDuCG5c1dCz7ppDQ==
X-Google-Smtp-Source: AMrXdXt1E3ETMbDctbRzRx440fhfbrWCKkb7RItk0UiOw+sLyqbmBqJ7Nh/P50kfa6iIzKQuaNHopA==
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id m13-20020a5d624d000000b002424d707882mr23439872wrv.15.1672577829594;
        Sun, 01 Jan 2023 04:57:09 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b00282194eaf7bsm15732516wrq.71.2023.01.01.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 04:57:08 -0800 (PST)
Date:   Sun, 1 Jan 2023 13:57:06 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PULL] drm-fixes for -rc2 if I'm not too late :-)
Message-ID: <Y7GDIi18rJ/YgbYn@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm just back from the mountains, and Dave is out at the beach and should
be back in a week again. Just i915 fixes and since Rodrigo bothered to
make the pull last week I figured I should warm up gpg and forward this in
a nice signed tag as a new years present! Hopefully still in time for
-rc2.

I'm expecting there will be more for -rc3 when I do the usual -fixes pull
on Fri or so.

Happy new year!
-Daniel

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-01

for you to fetch changes up to a9f5a752e86f1897c3b377b6b861576a4c1a2ff0:

  Merge tag 'drm-intel-fixes-2022-12-30' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2023-01-01 11:52:11 +0100)

----------------------------------------------------------------
drm-fixes for 6.2-rc2

- i915 fixes for newer platforms
- i915 locking rework to not give up in vm eviction fallback path too
  early

----------------------------------------------------------------
Andrzej Hajda (1):
      drm/i915: fix TLB invalidation for Gen12.50 video and compute engines

Daniel Vetter (1):
      Merge tag 'drm-intel-fixes-2022-12-30' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jani Nikula (2):
      drm/i915/dsi: add support for ICL+ native MIPI GPIO sequence
      drm/i915/dsi: fix MIPI_BKLT_EN_1 native GPIO index

John Harrison (1):
      drm/i915/uc: Fix two issues with over-size firmware files

Lucas De Marchi (1):
      drm/i915: Remove __maybe_unused from mtl_info

Matthew Auld (1):
      drm/i915: improve the catch-all evict to handle lock contention

 drivers/gpu/drm/i915/display/intel_dsi_vbt.c    | 94 ++++++++++++++++++++++++-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c  | 59 +++++++++++++---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c        |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c              |  8 ++-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c        | 42 +++++++----
 drivers/gpu/drm/i915/i915_gem_evict.c           | 37 +++++++---
 drivers/gpu/drm/i915/i915_gem_evict.h           |  4 +-
 drivers/gpu/drm/i915/i915_irq.c                 |  3 +
 drivers/gpu/drm/i915/i915_pci.c                 |  1 -
 drivers/gpu/drm/i915/i915_reg.h                 |  1 +
 drivers/gpu/drm/i915/i915_vma.c                 |  2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c |  4 +-
 12 files changed, 212 insertions(+), 45 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
