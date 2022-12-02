Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6889663FDCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiLBBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiLBBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:44:57 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFBD3A30
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:44:56 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fp23so3112232qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bLTeJ6YrAnPFThGmSk8KJr4jyMAp7UgMPl4HksAp44=;
        b=aYnKhSCrjGtm4vsnysotoMASKnP3QdutT10q95EHppyvQSaq+DReRl5xi3hLy8/BhZ
         rtgSvW4+3qLgaDKOKDzuUNLjCAAcxbIno2CMQqCHj7lOHHwp0cus7lB3/XjLNsKwieIK
         XkVO85CkwFx+bOAPmUjNBTzjtOfY1+t3ZLy+ujcXOaIKoqfvIZTbL+dIcZAoA+qVcbUI
         70B1MKIjbkLSsROBp1SBUCPXupuCCMx0TOHUzvKTMLfjBQDrCR0Qk9OkdAP2UTWJswU3
         EWBRoo8GV8xra9RLb9YtgwXY/sF4I4DYChHlYweI7Eb0QBRbtHi7m/OQVNQ0mQbJdGgn
         GBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bLTeJ6YrAnPFThGmSk8KJr4jyMAp7UgMPl4HksAp44=;
        b=B46Rjuo6KcVWVTIfSuQyg81EUfXYlPagLWqqW2P1p7lErfceLXLZUcH8sO7bsdcht/
         13FKli6tRC9UpFRhKcztwoeM27EWeDek3ixXCsLEwYKKA5cIcTsi3XG0xF4u/n4vxral
         b0pPsrVNHvxiFs1/N9Ie8iGfo20mZDPnpiF3NRoAfAEpa3Evv+K75/sbUaJwX0ydVFLI
         BznYBhFJD4AqKKM/y/XGhARAaVrblQX+aOuu3QcOLeuwQ/M/EfClJHmurEXPW8Rchuxg
         xuUm2dzBsEcQ1M3Yn2HSeWkhHIfJpY2M0HaN9H6ke3hc1Czjf7Tivg+mCnTDFMKn0VIA
         X3VA==
X-Gm-Message-State: ANoB5pmHn+jn+95szU4GIqiOUObXcKuBmLS9UwoHq4DXwPuI3yd+3DLP
        HKicpkKgzrC8y7Fg3LGE8bNSuXKRxr2Lb94E073pPRKY448=
X-Google-Smtp-Source: AA0mqf7/5LFh9irixKD6uvk05eIdlWzoStuesK1CKS2LvZB029c9+SxpcPE39deP4kMGA+0L0RS0akdEqi50xaJdd7g=
X-Received: by 2002:ae9:d846:0:b0:6ec:5332:6ebd with SMTP id
 u67-20020ae9d846000000b006ec53326ebdmr62506616qkf.0.1669945495063; Thu, 01
 Dec 2022 17:44:55 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 2 Dec 2022 11:44:43 +1000
Message-ID: <CAPM=9tzKpUGHMEw3aN43b+P3+WwAtZGia190JktnB163TvVjCw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.1-rc8
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

Things do seem to have finally settled down, just 4 i915 and one
amdgpu this week. Probably won't have much for next week if you do
push rc8 out.

Dave.

drm-fixes-2022-12-02:
drm fixes for 6.1-rc8

i915:
- Fix dram info readout
- Remove non-existent pipes from bigjoiner pipe mask
- Fix negative value passed as remaining time
- Never return 0 if not all requests retired

amdgpu:
- VCN fix for vangogh
The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d=
:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-02

for you to fetch changes up to c082fbd687ad70a92e0a8be486a7555a66f03079:

  Merge tag 'amd-drm-fixes-6.1-2022-12-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-12-02
09:12:46 +1000)

----------------------------------------------------------------
drm fixes for 6.1-rc8

i915:
- Fix dram info readout
- Remove non-existent pipes from bigjoiner pipe mask
- Fix negative value passed as remaining time
- Never return 0 if not all requests retired

amdgpu:
- VCN fix for vangogh

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2022-12-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-6.1-2022-12-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Janusz Krzysztofik (2):
      drm/i915: Fix negative value passed as remaining time
      drm/i915: Never return 0 if not all requests retired

Leo Liu (1):
      drm/amdgpu: enable Vangogh VCN indirect sram mode

Radhakrishna Sripada (1):
      drm/i915/mtl: Fix dram info readout

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Remove non-existent pipes from bigjoiner pipe mask

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c      |  3 +++
 drivers/gpu/drm/i915/display/intel_display.c | 10 +++++++---
 drivers/gpu/drm/i915/gt/intel_gt.c           |  9 +++++++--
 drivers/gpu/drm/i915/gt/intel_gt_requests.c  |  2 +-
 drivers/gpu/drm/i915/intel_dram.c            |  3 +--
 5 files changed, 19 insertions(+), 8 deletions(-)
