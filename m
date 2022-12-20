Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57965288D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiLTVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLTVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:49:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BDE183BA;
        Tue, 20 Dec 2022 13:49:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n6so8147844ljj.11;
        Tue, 20 Dec 2022 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkPYCUNmqr17+v9yQOtJ3j6rSJ6OzQvmePXcoXtefxU=;
        b=YhRmV+cQr0S5aEgLYIJ5wmhkmbgtxYA/7VQ9rfLKgbsAyUGJ4yND5VIi7BaITRtt3M
         7cvgFUpYTAtna9D4FpZ4XenmvL4tS0dNo+zM+/xpPqyxg9m2WnPDx/FkCAHhXy4pYjDq
         QRb25dA7lVhrBD3xSlPpe0J+j4GJmw/dXAomyNM8j/GcXM4CD3LSuMKtZXHOsQ6/KtgG
         oXsHPdXPlQt7BYpU17t9hNxCS/HYdN6uYAUw38yfYKwsBpgu5YyZEqERAhUzt6GzJT8N
         zWOB32ijHONVdF+GxyimnKbLTJmB8WztOlcGg/8wU0GXoP3o0i3oIl/USJt5t2Eb8+c6
         G/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkPYCUNmqr17+v9yQOtJ3j6rSJ6OzQvmePXcoXtefxU=;
        b=oQm8JyvYBFxI/WzKSZnLpZJ4e6aDRnV08EGkzjVegcAFdI76I7XZRb7TSN50Xw/LVn
         orT6NNSgZJuUsYhaMAveVm+o5KPes5l2zPqR67erKTQhYT6BLvkCUps4fF/A8VRBwJRN
         CK5EnkI4JaFgdWxebWPmAwRCPT1mVB198XLzx4jOszIepCDTsMgueOBj/p8QIeldaA3F
         dbnE/5kYYLIXP2AXA5fSAmgqqRAqk9atyG/vtahBl6/lekVgYQj+ez93tiUmbEajT5ck
         cMw9MuB53Ftem529qGNCUhRGK6Km7rWYcmkZkzZvlEDLyHxf+eVTiOzEs+L5a3jBLHjU
         JZTA==
X-Gm-Message-State: ANoB5pkeGjNBAfSKhCvsRNQMYuFyaJC1eFvjWqav5T4H3/jvk5auLq+k
        S53K98oZtlcTtXgh3GErD5IudWvn+YsJbMAXwhR/9bf29/8=
X-Google-Smtp-Source: AA0mqf4qaMwHUwzKUCLFUSUMVawRvw+CVhG089UVjSLGrCQru5urUdpljLjdC0v30UJkFXLVKr72WM9esD3sV+QIyhQ=
X-Received: by 2002:a2e:86d2:0:b0:279:df97:e895 with SMTP id
 n18-20020a2e86d2000000b00279df97e895mr9636825ljj.226.1671572991812; Tue, 20
 Dec 2022 13:49:51 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 20 Dec 2022 15:49:40 -0600
Message-ID: <CAH2r5mupDphsriFvcC_Hh0dWaDWdyAKNk1xKwEts7mfm3K5ESw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paulo Alcantara <pc@cjr.nz>, CIFS <linux-cifs@vger.kernel.org>,
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

Please pull the following changes since commit
851f657a86421dded42b6175c6ea0f4f5e86af97:

  Merge tag '6.2-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2022-12-15 14:53:14 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part2

for you to fetch changes up to aacfc939cc42293fbcfe113040b4e8abaef68429:

  cifs: update internal module number (2022-12-19 08:04:50 -0600)

As mentioned in the earlier smb3 client P/R, last week we were still
testing various additional important fixes: a series of DFS and reconnect
fixes from Paulo, which are now included in this P/R
----------------------------------------------------------------
20 cifs/smb3 client fixes, mostly related to reconnect and/or DFS

- two important reconnect fixes: cases where status of recently connected IPCs
and shares were not being updated leaving them in an incorrect state
- fix for older Windows servers that would return STATUS_OBJECT_NAME_INVALID
to query info requests on DFS links in a namespace that contained non-ASCII
characters, reducing number of wasted roundtrips.
- fix for leaked -ENOMEM to userspace when cifs.ko couldn't perform I/O due
to a disconnected server, expired or deleted session.
- removal of all unneeded DFS related mount option string parsing (now using
fs_context for automounts)
-improve clarity/readability, moving various DFS related functions out
of fs/cifs/connect.c
(which was getting too big to be readable) to new file.
- Fix problem when large number of DFS connections.  Allow sharing of DFS
connections and fix how the referral paths are matched
- Referral caching fix: Instead of looking up ipc connections to
refresh cached referrals,
store direct dfs root server's IPC pointer in new sessions so can
simply access it to
either refresh or create a new referral that such connections belong to.
- Fix to allow dfs root server's connections to also failover
- Optimized reconnect of nested DFS links
- Set correct status of IPC connections marked for reconnect
----------------------------------------------------------------
Paulo Alcantara (19):
      cifs: set correct tcon status after initial tree connect
      cifs: set correct ipc status after initial tree connect
      cifs: reduce roundtrips on create/qinfo requests
      cifs: use fs_context for automounts
      cifs: get rid of mount options string parsing
      cifs: remove unused smb3_fs_context::mount_options
      cifs: set resolved ip in sockaddr
      cifs: split out ses and tcon retrieval from mount_get_conns()
      cifs: share dfs connections and supers
      cifs: don't refresh cached referrals from unactive mounts
      cifs: fix refresh of cached referrals
      cifs: refresh root referrals
      cifs: don't block in dfs_cache_noreq_update_tgthint()
      cifs: fix confusing debug message
      cifs: fix source pathname comparison of dfs supers
      cifs: optimize reconnect of nested links
      cifs: set correct status of tcon ipc when reconnecting
      cifs: use origin fullpath for automounts
      cifs: don't leak -ENOMEM in smb2_open_file()

Steve French (1):
      cifs: update internal module number

 fs/cifs/Makefile       |   2 +-
 fs/cifs/cifs_debug.c   |   8 +
 fs/cifs/cifs_dfs_ref.c | 255 +++++++-------------------------
 fs/cifs/cifsfs.c       |   6 -
 fs/cifs/cifsfs.h       |   4 +-
 fs/cifs/cifsglob.h     |  18 ++-
 fs/cifs/cifsproto.h    |  14 +-
 fs/cifs/connect.c      | 899
++++++++++++++++++---------------------------------------------------------------------------------------------
 fs/cifs/dfs.c          | 544
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/dfs.h          |  46 ++++++
 fs/cifs/dfs_cache.c    | 276 +++++++---------------------------
 fs/cifs/dfs_cache.h    |   2 +-
 fs/cifs/dir.c          |  21 ++-
 fs/cifs/dns_resolve.c  |  49 +++---
 fs/cifs/dns_resolve.h  |   4 +-
 fs/cifs/fs_context.c   |  13 +-
 fs/cifs/fs_context.h   |   3 +-
 fs/cifs/inode.c        |   6 -
 fs/cifs/misc.c         |  81 ++--------
 fs/cifs/smb2file.c     |   4 +-
 fs/cifs/smb2inode.c    |  46 ++++--
 fs/cifs/smb2ops.c      |  28 +++-
 22 files changed, 991 insertions(+), 1338 deletions(-)
 create mode 100644 fs/cifs/dfs.c
 create mode 100644 fs/cifs/dfs.h


-- 
Thanks,

Steve
