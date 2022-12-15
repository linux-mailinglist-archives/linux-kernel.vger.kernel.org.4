Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6833F64E3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLOWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:40:58 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C3C5437C;
        Thu, 15 Dec 2022 14:40:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b13so740892lfo.3;
        Thu, 15 Dec 2022 14:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgTp2YMfj45HVIaWgO/3U9fXjxNFtfARcTcwYW7TX6w=;
        b=iKKRxha24pjspYjsH5AGgHhkCxORLjjOlpcNWzOFTb0Z5ixM1rucXQk6rlDYRrapWz
         GXiIrLFRviozB6BvKENOOHCqjKrD6IbhA9xyqpsiNWEAt48V2HBBvOMTsDeWBQySsb6u
         BXieXzFzu+RI1WQDzNgD10L2Efqk7Jui2Ut1rI9uqD1UHx1UTBI1EzlC00z87ZVXLcQy
         xWsB0NSVYHsPZWowdoH+NJPswOmIU9SUii1F4Msr9GORUkn/Ita6dfsF0AnBIyfDgGYp
         LHZwrIEfbGP4bl7rPd4RhIPHxr4630oX1uJYZkKf0qA2qusVtQ2PT7aGN3gzKJANz7T9
         tEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgTp2YMfj45HVIaWgO/3U9fXjxNFtfARcTcwYW7TX6w=;
        b=FOwk9t1uiFqQjpC7rgGLKO1eK+WpwaRs8JJ3VFclG9IKcaEdB6Qj9bUoxa2aRmyQrm
         UB0mNcmD8dq3++h0i1fkGioJTUzQXIBYlLfUmHcHqyWN/dQdIgaCOJ9JNQSX3unMjppv
         4/RZnPyTsAAllzZ/BeWMkEh8R+s54uE7Qb5uaRHrasIDESovVs7k6R3FaHdGc9f32esq
         GIsZRJxlU/qM/PfDdB5lSoBiEZA6EAs3O9T/ZDmWiWfHSdLR9VBNyT6gDDX1eJtRrzgA
         GU+bIUNHqN5D1jbX2uuLLW+LQ6x3epADGuuG/zxZWQpLCobvwzWmJcz1/PQ9JuTkM3Ru
         9Jtw==
X-Gm-Message-State: ANoB5pkZOQn70h6aULZHxBvQye/o3kqUJ1mxfQROmPycAL982woz+O41
        8rMXfiCKx0gV8G4pUX/Z3UUjUXTA663bIuDY1F/zhEGnFBQ=
X-Google-Smtp-Source: AA0mqf7M3637RBpE5UF/Kb2RQo5/grILhO6tmbSi/Zd5U8sV3EBYni/PjBfY8wOJAEwVZEwuBazdFN7OXDsnIC0PIzw=
X-Received: by 2002:a19:5219:0:b0:4b5:9125:1432 with SMTP id
 m25-20020a195219000000b004b591251432mr3727068lfb.204.1671144055594; Thu, 15
 Dec 2022 14:40:55 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 15 Dec 2022 16:40:44 -0600
Message-ID: <CAH2r5mve4N+szjwBM2qebKwVdC_fybKEaG8JeeMLk-S_D0dckw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part1

for you to fetch changes up to d74f4a3f6d88a2416564bc6bf937e423a4ae8f8e:

  cifs: Remove duplicated include in cifsglob.h (2022-12-13 22:54:40 -0600)

There is a slightly larger set of fixes being tested, which is not
included in this
P/R since need to be tested a bit more: e.g. 12 patches from Paulo
(mostly DFS related fixes) and also two performance fixes and a
security (password expired) fix, but I wanted to at least get these
easier ones in that have been in for-next for longer.
----------------------------------------------------------------
13 cifs/smb3 client fixes
- 2 SMB3.1.1 POSIX Extensions fixes
- 3 patches to remove cifs_writepages
- 2 memory management fixes
- 2 mount parm parsing fixes
- 4 minor cleanup fixes
----------------------------------------------------------------
Christoph Hellwig (3):
      cifs: wire up >migrate_folio
      cifs: stop using generic_writepages
      cifs: remove ->writepage

Paulo Alcantara (2):
      cifs: skip alloc when request has no pages
      cifs: fix oops during encryption

Steve French (4):
      cifs: minor cleanup of some headers
      cifs: fix various whitespace errors in headers
      cifs: fix missing display of three mount options
      cifs: print warning when conflicting soft vs. hard mount options specified

Volker Lendecke (3):
      Fix path in cifs/usage.rst
      cifs: Add "extbuf" and "extbuflen" args to smb2_compound_op()
      cifs: Parse owner/group for stat in smb311 posix extensions

Yang Li (1):
      cifs: Remove duplicated include in cifsglob.h

 Documentation/admin-guide/cifs/usage.rst |   2 +-
 fs/cifs/cifs_ioctl.h                     |   2 +-
 fs/cifs/cifsfs.c                         |   8 ++++-
 fs/cifs/cifsfs.h                         |   4 +--
 fs/cifs/cifsglob.h                       |  76
++++++++++++++++++++++++++++++++++++++++++--
 fs/cifs/cifspdu.h                        |  50 ++++++++++++-----------------
 fs/cifs/cifsproto.h                      |   6 ++--
 fs/cifs/file.c                           |  36 +++++++++++++--------
 fs/cifs/fs_context.c                     |  11 +++++--
 fs/cifs/inode.c                          |  13 +++++---
 fs/cifs/misc.c                           |   4 +--
 fs/cifs/smb2inode.c                      |  68
++++++++++++++++++++++++++++++++-------
 fs/cifs/smb2ops.c                        | 179
+++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------
 fs/cifs/smb2proto.h                      |   5 ++-
 14 files changed, 298 insertions(+), 166 deletions(-)


-- 
Thanks,

Steve
