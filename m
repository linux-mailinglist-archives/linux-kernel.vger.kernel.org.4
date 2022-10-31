Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA561342C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJaLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJaLH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:07:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286862CF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:07:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13c569e5ff5so12666546fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMlKM22/vBjYG6XqmR4GF/IFfdYTzBgjEp3g+APsfwk=;
        b=mWkrrb+U58/aLUgoZbnCvf+7PUeEpgFmzXTIE3ZeDRp4An6IcGTQmNRWTB83Y30Eri
         rTXYdP4rlXt57vBoGvr/5R541P75FYw6l8H3P+fZ9kqvH3u3LiXysiWr8aN9+3zU0N5X
         DJ6qF0MpXic2BxobXvP3eMdkjftnOtOp+DXhXOnNR2gRqq/vn72snijzHCv0ym7/pE0o
         AecgDw4P/dezc1b4sWKjDKY44W25sXZpRuGUA26wvwBDnZlNGIYYS1x+WQ4tI+1jDNZz
         OM8svpGeIXkCZZxmEJUmDRU5ziUBShV8UL+8FABoIoFLEdGaA1siE/lj+VHICkNjJP6u
         BVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMlKM22/vBjYG6XqmR4GF/IFfdYTzBgjEp3g+APsfwk=;
        b=tZZD0QMJcVBPlCzxsLwjmzqvs3fldESovDvdIgZyWmCVZ3NqGHdX7Xz0X65hw9Vfpn
         BiSsOaTEHJoEZi8RPc22LfczTMe3tkMjCaT2oZuazYuvtzHaHUN9le4Ll1nheAb8ZOYl
         H8thzXiLG8LU2v4fLahcNA1zTOmNX8M5MtzZfZZUwgjqCxtU02HrrWdjpstUOO281RG0
         MZdvkUQeOuF0fxXslnbpnjHfgwtuzKvVgXcPLjQOnPPQGyP935fcCm1GTZXUkUlK6K3m
         04HXzH0Tm5lFOFIR7Fdw4dr05G808qzvddE8pzX9JGal5jNKUOA9stcE3gY+ErReLBNw
         EbWQ==
X-Gm-Message-State: ACrzQf3PEc66eMB6guLxqKkSk1Oym7iNf5yXtNu/8RjbwXESnLHTvYKd
        WlMpkBxu2nT7qouh/XokaUVdOEZJPtKHFVHK35dzhdGkRl73zrA=
X-Google-Smtp-Source: AMsMyM5SA4t8hi5LI9GwWyXVbUdkcZASUgHIE5ZRzkQ5+LQJfLcAOUXyKPGPcywgeSdkWVlOHd1I4kjBylr5HBCJMUs=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr17158926oac.51.1667214446436; Mon, 31
 Oct 2022 04:07:26 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Oct 2022 07:07:15 -0400
Message-ID: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A single patch to the capabilities code to fix a potential memory leak
in the xattr allocation error handling.  Please apply for v6.1-rcX.

Thanks,
-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221031

for you to fetch changes up to 8cf0a1bc12870d148ae830a4ba88cfdf0e879cee:

 capabilities: fix potential memleak on error path from vfs_getxattr_alloc()
   (2022-10-28 06:44:33 -0400)

----------------------------------------------------------------
lsm/stable-6.1 PR 20221031

----------------------------------------------------------------
Gaosheng Cui (1):
     capabilities: fix potential memleak on error path from
                   vfs_getxattr_alloc()

security/commoncap.c | 6 ++++--
1 file changed, 4 insertions(+), 2 deletions(-)

-- 
paul-moore.com
