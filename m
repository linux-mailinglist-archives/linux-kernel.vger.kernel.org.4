Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9166A46E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjB0QXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjB0QXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:23:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260005269
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:23:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ec43so28062764edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFR4tLzU09oPdFCdK8fx8YknXRfN/zDcEZwuvmhL1BA=;
        b=VbaiOZLX1Bg4n5ZQb3SBvby6nX//Y2ZKzBgmRJmh6gTUuH3/QtNmyyX7kOw+C1jIEa
         QkCkI57rKxsOgL37Os0SN+EntqnIxU4NK6FqaGF0TVRnoHhHjNRil3vLGtza0/kgAxhq
         0FPL5HNtqzPYjPMULPqS1S8x50Uu3NBVjyuFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFR4tLzU09oPdFCdK8fx8YknXRfN/zDcEZwuvmhL1BA=;
        b=0OGd0pVIfX4yCAIO+o6GEiV89gxY4DQN013GCJlYjFcV1xFYc/yihFTAznpDmtepP0
         iA0Y/CcCZbk8NA8+HGdAKAm5jaFruEvWx2LnW9B7WBwZEFgG1C7sjwUAmeNjRj01/Oks
         Y0+KD3WR9A3oheFgU/w8vCiL458xQd5uH2kcP5MymeSADnBfhLxgUoxX2ISaGhgyaxxG
         flhDAK3QxJwKKQQ4askvqrnhOT7ZnWaHOBofeLNchHO3e438qF27AqrtcWVH6GU2YS0C
         Rtk7ETglvnvVt1x+TbBPDG18bQ6stxSCD8myuzDBU0cVdepNSNPyUs/8qpamJ38gFI94
         rY5g==
X-Gm-Message-State: AO0yUKVl8LeJq93BKEKLN82yrWbvGENYUs3PKNRZfG2PcNrp1IMQ+M/m
        rJf2UfWDUbz91dRO2wNvv7oQ8Q==
X-Google-Smtp-Source: AK7set8MmGZpi2A29kYf3EdaoDWaJ7iO2C6l7g8xQqGEBfJ9UCgJk/1Bhmou+fSDZs/nHW/FNyzSUQ==
X-Received: by 2002:a17:906:99d3:b0:8ef:fd8:9d04 with SMTP id s19-20020a17090699d300b008ef0fd89d04mr17295247ejn.27.1677514990668;
        Mon, 27 Feb 2023 08:23:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-82-183-158.pool.digikabel.hu. [91.82.183.158])
        by smtp.gmail.com with ESMTPSA id lc8-20020a170906f90800b008d57e796dcbsm3375610ejb.25.2023.02.27.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:23:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:23:04 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 6.3
Message-ID: <Y/zYyN7NeLKusmSj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.3

 - Fix regression in fileattr permission checking

 - Fix possible hang during PID namespace destruction

 - Add generic support for request extensions

 - Add supplementary group list extension

 - Add limited support for supplying supplementary groups in create
   requests

 - Documentation fixes

Thanks,
Miklos

---
Alexander Mikhalitsyn (1):
      fuse: add inode/permission checks to fileattr_get/fileattr_set

Eric W. Biederman (1):
      fuse: in fuse_flush only wait if someone wants the return code

Miklos Szeredi (2):
      fuse: add request extension
      fuse: optional supplementary group in create requests

Randy Dunlap (1):
      fuse: fix all W=1 kernel-doc warnings

---
 fs/fuse/cuse.c            |   2 +-
 fs/fuse/dev.c             |   4 +-
 fs/fuse/dir.c             | 126 +++++++++++++++++++++++++++++++++++-----------
 fs/fuse/file.c            |  91 +++++++++++++++++++++++----------
 fs/fuse/fuse_i.h          |   9 +++-
 fs/fuse/inode.c           |   4 +-
 fs/fuse/ioctl.c           |   6 +++
 include/uapi/linux/fuse.h |  45 ++++++++++++++++-
 8 files changed, 225 insertions(+), 62 deletions(-)
