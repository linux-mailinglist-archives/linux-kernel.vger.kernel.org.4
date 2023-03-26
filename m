Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A66C9217
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 04:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCZCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 22:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZCC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 22:02:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB20AF00;
        Sat, 25 Mar 2023 19:02:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c29so7048869lfv.3;
        Sat, 25 Mar 2023 19:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679796146;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ljNHWZRnKz6ATPTwqjJD8QWbvuQUIYN0j1hqEm3CfLI=;
        b=axu9cW3DWerrxsjDuSSmD1plby7DL7NkJ9Im4TMF7XG6gM/WFLTSkxl5MJerrMjUvU
         D0M7xo0RKI3rJKaDcttWjYNP+HmEwjgEf0JAsbQwKUMB/92ej6o/TSZLP92yLkPvSKhV
         EPBZU8nRbYurXRY/3cIiMYT7+s6YiEUpLTbFNdCfucOZaUdFzsvY8rAt8bgxopAZnlKv
         Mr85LBCZBbtz1MNp9vhL0rG536YYwI3ioQV+0cOCxNmO8VO+TKeWX47pygy9ETKr6l0y
         GMHPwNlpK9UFqwcZ9JNOXUElYNA7tPaiUXh32frGFv5Z/QFu+vPC9PKh0Cpz8KiH2z3P
         yIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679796146;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljNHWZRnKz6ATPTwqjJD8QWbvuQUIYN0j1hqEm3CfLI=;
        b=GcgP3VuDhhFMENRnBkUXrP+SWSA+mSQnR+6+Hwyf9VHfdWl0+IhEfidqHFDeFyLviY
         IudA40vOcbPcyBeci55tg1axdbaaj9dcViKa8O7oek3LIA47UdQQSHdovO33H0FZAymm
         b5BirWttEEXITwwvLchc5SXi+gqN0ELOc2sT1U9yREVQqCY2iY4/U5lxCjzDEgIXQOyo
         /1xIrwBOs8rKus/V2gnbHNgE0+IOBE5EglekgqRyVzpwj3LvP0u7223ve/oTtFNcJ1ff
         gSqmdsN93VI6KPlNRFkbNAVyZ2gYFrwUnVmp9VCwn5Bf/nOdhWfR/5s/xwumMN4Aq5zS
         FCsw==
X-Gm-Message-State: AAQBX9c0YgZlehK5gmCV0G7GkcaaO3i2rfqftKG/XZuCKADL0K1h2n7c
        MZuiVhJxiOGis/1UJjNyV/ahxb7CLkW8jgqRaGvo+CEEI+g=
X-Google-Smtp-Source: AKy350b4YZspahc3nPzaItpREGIh+XpvxAetPoKyvO9wZsKRJUm0cjREFLdlHJDecCEhWrPglsdbUjyjErkE9wgf0Sc=
X-Received: by 2002:ac2:4434:0:b0:4dc:807a:d140 with SMTP id
 w20-20020ac24434000000b004dc807ad140mr2058028lfl.10.1679796145926; Sat, 25
 Mar 2023 19:02:25 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 25 Mar 2023 21:02:14 -0500
Message-ID: <CAH2r5ms5shbVGfACT5bXkp4Fo52GXoVHPVeNsRyRd4PAKHbaRw@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
38e04b3e4240a6d8fb43129ebad41608db64bc6f:

  Merge tag '6.3-rc2-smb3-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2023-03-16 15:06:16 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/smb3-client-fixes-6.3-rc3

for you to fetch changes up to 491eafce1a51c457701351a4bf40733799745314:

  smb3: fix unusable share after force unmount failure (2023-03-24
14:37:12 -0500)

----------------------------------------------------------------
Twelve cifs/smb3 client fixes (most also for stable)
- forced umount fix
- Fix for two perf regressions
- three reconnect fixes
- three small debugging improvements
- three multichannel fixes

This does not include an important lease break fix which is still being tested.
----------------------------------------------------------------
Paulo Alcantara (2):
      cifs: fix missing unload_nls() in smb2_reconnect()
      cifs: fix dentry lookups in directory handle cache

Shyam Prasad N (8):
      cifs: check only tcon status on tcon related functions
      cifs: lock chan_lock outside match_session
      cifs: do not poll server interfaces too regularly
      cifs: empty interface list when server doesn't support query interfaces
      cifs: dump pending mids for all channels in DebugData
      cifs: print session id while listing open files
      cifs: append path to open_enter trace event
      cifs: avoid race conditions with parallel reconnects

Steve French (2):
      smb3: lower default deferred close timeout to address perf regression
      smb3: fix unusable share after force unmount failure

 fs/cifs/cached_dir.c    | 37 +++++++++++++++++++++++--
 fs/cifs/cifs_debug.c    | 46 ++++++++++++++++++++-----------
 fs/cifs/cifsfs.c        |  9 ++++---
 fs/cifs/cifssmb.c       |  6 ++---
 fs/cifs/connect.c       | 72 ++++++++++++++++++++++++++++++++++---------------
 fs/cifs/dfs.c           | 10 ++++---
 fs/cifs/dfs_cache.c     |  2 +-
 fs/cifs/file.c          |  8 +++---
 fs/cifs/fs_context.h    |  2 +-
 fs/cifs/link.c          |  2 ++
 fs/cifs/smb2inode.c     |  1 +
 fs/cifs/smb2ops.c       | 27 ++++++++++++++++++-
 fs/cifs/smb2pdu.c       | 62 ++++++++++++++++++++++--------------------
 fs/cifs/smb2transport.c | 17 +++++++++---
 fs/cifs/trace.h         | 12 ++++++---
 15 files changed, 221 insertions(+), 92 deletions(-)


-- 
Thanks,

Steve
