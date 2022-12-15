Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB764E4CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOXuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOXuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:50:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9F18E16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4BC0B81CD6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8AAC433F0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671148248;
        bh=vhCk/jhWC29QkFTD80pz8AUTv2gvIAgPXs3xG9XzqsY=;
        h=From:Date:Subject:To:Cc:From;
        b=rNzRps6YMK0Gx4A0olYMuEBsYKksk09heDrxKrnscXrgoc/icB7vPUyKUjA6imA1R
         7GJ8VvmIQhoYE1KqfXpsyUcgSVWNXAJJtoJw95ecaz8vGfpQwz1/eEOEusUpZIxOg6
         9x0iaplivhOWMaVXgZz18dskOk1EXZAoKzPlG7fAXNI5KqpDt8KLd+NPJGtZcPI1L3
         0uMiwL7tLlRFy0weIKKcwuhE+KBAGi3Bkj5oxp54nfDMtioCISYcPVcTbgWPSshMtD
         d8/zljK4k6QLaC2RVmcrfg1BqtfBVCHt++bucnBlDtOOxye72PaRCSS5g6Krveajwa
         QFopFNeyvHPkA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1447c7aa004so1356988fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:50:48 -0800 (PST)
X-Gm-Message-State: ANoB5pmILbFOXCJ3VObI//IP0bVP87z+4rUxv8hKVjFkMSbkJ/ztlVi3
        zJ0xrS3VNUTyFWzPhcToUW3z6rPH7yKFHHfr7wA=
X-Google-Smtp-Source: AMrXdXu+FfGhdkvcL10YfRfzKztz7LtWrKjXC2PCfClnCGWyBR1RbYuQqUpS36B4S+J+am+FvhORLoFU8r5o7kyUZv4=
X-Received: by 2002:a05:6871:420d:b0:141:828c:12b5 with SMTP id
 li13-20020a056871420d00b00141828c12b5mr386793oab.8.1671148247628; Thu, 15 Dec
 2022 15:50:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Thu, 15 Dec 2022 15:50:47
 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 16 Dec 2022 08:50:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9T3NxeotP7qmJvcF+abqu0yJGnfCySefnUPbKVCYZ_Wg@mail.gmail.com>
Message-ID: <CAKYAXd9T3NxeotP7qmJvcF+abqu0yJGnfCySefnUPbKVCYZ_Wg@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v6.2-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.2-rc1

for you to fetch changes up to 36955d368dc101be885ad2c71618e3c3a93cd8ee:

  exfat: reuse exfat_find_location() to simplify
exfat_get_dentry_set() (2022-12-13 20:17:16 +0900)

----------------------------------------------------------------
Description for this pull request:
- simplify and remove some redundant codes handing directory entries
- optimize the size of exfat_entry_set_cache and its allocation policy
- improve the performance for creating files and directories

----------------------------------------------------------------
Yuezhang Mo (14):
      exfat: simplify empty entry hint
      exfat: hint the empty entry which at the end of cluster chain
      exfat: reduce the size of exfat_entry_set_cache
      exfat: support dynamic allocate bh for exfat_entry_set_cache
      exfat: move exfat_entry_set_cache from heap to stack
      exfat: rename exfat_free_dentry_set() to exfat_put_dentry_set()
      exfat: replace magic numbers with Macros
      exfat: remove call ilog2() from exfat_readdir()
      exfat: remove unneeded codes from __exfat_rename()
      exfat: remove unnecessary arguments from exfat_find_dir_entry()
      exfat: remove argument 'size' from exfat_truncate()
      exfat: remove i_size_write() from __exfat_truncate()
      exfat: fix overflow in sector and cluster conversion
      exfat: reuse exfat_find_location() to simplify exfat_get_dentry_set()

 fs/exfat/dir.c      | 184 +++++++++++++++++++++++++++++-----------------------
 fs/exfat/exfat_fs.h |  56 +++++++++++-----
 fs/exfat/file.c     |  12 ++--
 fs/exfat/inode.c    |  17 +++--
 fs/exfat/namei.c    |  63 +++++++++---------
 5 files changed, 187 insertions(+), 145 deletions(-)
