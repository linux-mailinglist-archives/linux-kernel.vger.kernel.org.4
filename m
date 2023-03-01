Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAE6A6D23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCANia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCANiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:38:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E732CD5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C1F6121F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C467EC433D2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677677898;
        bh=I87h7ETny0tLZvE2H5MvVi3ThxSYnB3UYA46KZvxVtc=;
        h=From:Date:Subject:To:Cc:From;
        b=WflKnS67ITboWuVNfiIwDFuoWgdUmn+ZFcI3l8FuZNOO2CeWFfUnLBZjzJNWvYqeW
         q64RLUU5SN4z0vxm9VsM1wJqUQLH8ETrFAfBwZRTT14/I5rycP73PgaJWLSyhkj/h/
         INZLujHQ/RfC92oBtVGhMoYZtoHazbEocX50DnrHFbPI1npgecZF0HKG75wf6PFGPn
         +X5LOfBnOK5Hm99WW44n/aeqND7n7ZX68ssvOdg4ESUyvkUAJFr0D6CvhiDoY4X+J5
         ozuDuhw23UP0FL6dnptH2csD2wiWAxcvS2877pUacFI6c3C+FAHEJYWS/Ygq+OqdXy
         wCx26+D95J5IA==
Received: by mail-oi1-f179.google.com with SMTP id r40so9717814oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:38:18 -0800 (PST)
X-Gm-Message-State: AO0yUKVIbZMA7fC79RPj3h4jDYvDsXpkl1wkKK/Ngdm7ClSPuFiIt5j3
        NS2Tvp9Ny06H1TKGjR+ZxcJRMPBJLZSx8yqbD1U=
X-Google-Smtp-Source: AK7set/TVXGCY+F4oTtezpQDhaG5mQB8h/dW4PKpIT3jea0YhbjdT5IHnY5Xj61V31lszOtle1nVKeOeb4a/X27oHQE=
X-Received: by 2002:aca:1004:0:b0:384:33df:4dfc with SMTP id
 4-20020aca1004000000b0038433df4dfcmr2146036oiq.11.1677677897896; Wed, 01 Mar
 2023 05:38:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Wed, 1 Mar 2023
 05:38:17 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 1 Mar 2023 22:38:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_kAWqDdDHo+eM1MiT5tJEtvfdkiAD=WBD3sP+AUR03tg@mail.gmail.com>
Message-ID: <CAKYAXd_kAWqDdDHo+eM1MiT5tJEtvfdkiAD=WBD3sP+AUR03tg@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v6.3-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.3-rc1

for you to fetch changes up to d5c514b6a0c0b77ed7e5ef2484e8b20eb09c5f27:

  exfat: fix the newly allocated clusters are not freed in error
handling (2023-02-28 20:01:40 +0900)

----------------------------------------------------------------
Description for this pull request:
- Handle vendor extension and allocation entries as unrecognized
benign secondary entries.
- Fix wrong ->i_blocks on devices with non-512 byte sector.
- Add the check to avoid returning -EIO from exfat_readdir() at
current position exceeding the directory size.
- Fix a bug that reach the end of the directory stream at a position
not aligned with the dentry size.
- Redefine DIR_DELETED as 0xFFFFFFF7, the bad cluster number.
- Two cleanup fixes and fix cluster leakage in error handling.

----------------------------------------------------------------
Namjae Jeon (1):
      exfat: handle unreconized benign secondary entries

Sungjong Seo (1):
      exfat: redefine DIR_DELETED as the bad cluster number

Yuezhang Mo (6):
      exfat: fix unexpected EOF while reading dir
      exfat: fix reporting fs error when reading dir beyond EOF
      exfat: fix inode->i_blocks for non-512 byte sector size device
      exfat: remove unneeded code from exfat_alloc_cluster()
      exfat: don't print error log in normal case
      exfat: fix the newly allocated clusters are not freed in error handling

 fs/exfat/dir.c       | 90 ++++++++++++++++++++++++++++++++++------------------
 fs/exfat/exfat_fs.h  |  4 ++-
 fs/exfat/exfat_raw.h | 21 ++++++++++++
 fs/exfat/fatent.c    | 32 +++++++------------
 fs/exfat/file.c      |  3 +-
 fs/exfat/inode.c     |  6 ++--
 fs/exfat/namei.c     |  2 +-
 fs/exfat/super.c     |  3 +-
 8 files changed, 101 insertions(+), 60 deletions(-)
