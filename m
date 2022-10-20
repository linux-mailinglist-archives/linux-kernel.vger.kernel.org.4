Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D7606431
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiJTPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJTPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:20:57 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FBC63878
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:20:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f205so13874869yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYUwx9AXAxDG20sYfr7hKVXI1VbVXzou7obOOp8onp8=;
        b=WiGPTWCGYwX8f8SzDcsA9Kdlw67nvMpM8MpRjR3rU/ZkY7hcm0usk+B/ltYnnlVlxc
         ZvdC29ayU64TWGzkCRI4Yp7s/+yvd/UX44ugg0u9wCOc4nmetKPQI4PSHK2r7Atndg5o
         iM4GbnDcr035neabM2A+NVxzd28/vESR4x7dhA6gtaFvfdU3f1/ZT7bXIj77mJMJSweg
         +ysNJoAQB6wTMyp9lDnV8xDQ+mL+rcPBf0mGhZd8/6wrYH2gkXhqjPtinJup3EscuDcL
         PWsqg4g66tKDwB8RyQOKN5svEnqZXpVZdGodC51851SgEaH1EGetaKIH1WOJqVRRATIl
         xSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYUwx9AXAxDG20sYfr7hKVXI1VbVXzou7obOOp8onp8=;
        b=jYtM7OxsjK4s14HM/GakR8MuoehAWsieZGHBxnNaOlFdbPEYhOYFQbtqyHOnUrelmD
         eSSj7cjrwBykF0nFzT6do3jlf52NgdEhQP/Ov8ItB00P0UObqTSA03YF9UmKRWalXytf
         EN1GeoE8i+bg72XBv77A22ycN43yy2U1Dl50RBstV69TmzUXTW2dsm5jU7HAZhyggC5m
         8VlAvYLUcv5ukyYwXPufT7pGOC6rd0OfBphLAcmGodk822Ht0VAYekixHlbX4IsnYnTt
         Xq7E4Qi0vGdIZXqebtLFiNM6ZyVK5PAgK/qZFoPPQuEkPFBVtN0UwiXlYf2f24Ju9cXE
         BtfA==
X-Gm-Message-State: ACrzQf3uauIt4PB6QC4TK8o+fwSZQQoC085plFj7rzHeajprhpuhVsK5
        lUHTb06dKMC2c5bTKQhD4DnXs2mL1iTaWpSAYkRm
X-Google-Smtp-Source: AMsMyM6xfDCwoV3AvDAeKK8J5VQLV5nF9Bo12pK9302x4ErUVdKzZZrQKaUpkLrNOT9SgahFOhsdXqdSfitZjK+OmTI=
X-Received: by 2002:a25:9a88:0:b0:6b9:c29a:2f4b with SMTP id
 s8-20020a259a88000000b006b9c29a2f4bmr12094852ybo.236.1666279242056; Thu, 20
 Oct 2022 08:20:42 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:20:07 -0400
Message-ID: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small SELinux fix for v6.1 to fix a GFP_KERNEL allocation while a
spinlock is held.  The patch, while still fairly small, is a bit
larger than one might expect from a simple s/GFP_KERNEL/GFP_ATOMIC/
conversion because we added support for the function to be called with
different gfp flags depending on the context, preserving GFP_KERNEL
for those cases that can safely sleep.

Please merge for v6.1-rcX.
-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20221020

for you to fetch changes up to abe3c631447dcd1ba7af972fe6f054bee6f136fa:

 selinux: enable use of both GFP_KERNEL and GFP_ATOMIC in convert_context()
   (2022-10-19 09:55:53 -0400)

----------------------------------------------------------------
selinux/stable-6.1 PR 20221020

----------------------------------------------------------------
GONG, Ruiqi (1):
     selinux: enable use of both GFP_KERNEL and GFP_ATOMIC in convert_context()

security/selinux/ss/services.c | 5 +++--
security/selinux/ss/sidtab.c   | 4 ++--
security/selinux/ss/sidtab.h   | 2 +-
3 files changed, 6 insertions(+), 5 deletions(-)

-- 
paul-moore.com
