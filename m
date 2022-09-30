Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0F5F15FB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiI3WTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiI3WTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:19:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5BDF6A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:19:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r18so11749009eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZavGJHJYFMAsec19Cc9RdLsMfmbDootkZBj5HKsaVSs=;
        b=aUj9EM6tATBQJx39c7lW+QqBrCyami+HdAC632LZHReQUVBp7ht1jjb6PDdhLVRLig
         Z2qtL2dmgTMjkDgQ8TovpBsgGw7FHV1PDZcLSOS5cMZDVQXYlTDndVK0jju91wLQkTJw
         OAyN2ovxTD95OXqR+SJXnaU5vEk3ZAxTbLeUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZavGJHJYFMAsec19Cc9RdLsMfmbDootkZBj5HKsaVSs=;
        b=jvpF1uFm2O4jVkkIU2uVrmscIe7RsMnIXf3A+xdZKL0nbQTnfnoOJtOJgkOGC2fmVO
         owmvHgnD+ryf3i5jvSdF7tWqTSlfQuqrB80+2YJsloQaRYmkgP7Zq/74+V1aDeCBNwLI
         z2q+HLlKSjJvQG0/mZuP3xtwgmJoi3Mgl9hqphbK2doG4cYT9KoNF4cvy5IkzJJJitxs
         4AEWZp8Pfv3WmW9WPEfnpvDA5EXcWLVPo9B7GER6eD8TWgFRySrSyVK0zOAVGH4IzUMu
         oEcP4pdpspGwJALFrB1A9RWyGuVZgcj7Xo+yrZD+5jW0P596vrqaXOkm80TpHOrmyX89
         +j5w==
X-Gm-Message-State: ACrzQf2XGPETGTx7WIpVdrgx+L+BqjzfRAoxu3ZhQg/ks6PSTC4pYp3T
        wYnzMyQUSlKHIghEtVvJnTJPp4Ip+o3YsA/Z
X-Google-Smtp-Source: AMsMyM7KOYwA7uXdv010xMUtk7T113BsV2k3hny0lM/eV9hTizxLOQI5ojARF+I4NKcTDIUv+YoaGA==
X-Received: by 2002:a17:906:11d:b0:712:abf:3210 with SMTP id 29-20020a170906011d00b007120abf3210mr7960867eje.292.1664576370916;
        Fri, 30 Sep 2022 15:19:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id rk14-20020a170907214e00b0078238c1c182sm1701561ejb.222.2022.09.30.15.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:19:30 -0700 (PDT)
Date:   Sat, 1 Oct 2022 00:19:28 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes
Message-ID: <YzdrcM2YAK4qyePP@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As Alex mentioned already, here's some last minute amd fixes that would be
nice to also include in the final release.

drm-fixes-2022-10-01:
amdgpu:

- VCN 4.x and GC 11.x fixes, mostly around fw

Cheers, Daniel

The following changes since commit 6643b3836f3908c4f77883b2fae72451e85cf3ca:

  Merge tag 'drm-intel-fixes-2022-09-29' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-09-30 09:28:58 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-01

for you to fetch changes up to 414208e48963fdb136240d7f59c15e627832d288:

  Merge tag 'amd-drm-fixes-6.0-2022-09-30-1' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-09-30 23:10:55 +0200)

----------------------------------------------------------------
amdgpu:

- VCN 4.x and GC 11.x fixes, mostly around fw

----------------------------------------------------------------
Daniel Vetter (1):
      Merge tag 'amd-drm-fixes-6.0-2022-09-30-1' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Hawking Zhang (8):
      drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
      drm/amdgpu: add helper to init rlc fw in header v2_0
      drm/amdgpu: add helper to init rlc fw in header v2_1
      drm/amdgpu: add helper to init rlc fw in header v2_2
      drm/amdgpu: add helper to init rlc fw in header v2_3
      drm/amdgpu: add helper to init rlc fw in header v2_4
      drm/amdgpu: add helper to init rlc firmware
      drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode

Sonny Jiang (2):
      drm/amdgpu: Enable VCN DPG for GC11_0_1
      drm/amdgpu: Enable sram on vcn_4_0_2

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c   | 264 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 151 +----------------
 drivers/gpu/drm/amd/amdgpu/soc21.c        |   1 +
 7 files changed, 281 insertions(+), 149 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
