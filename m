Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815FB5FFCC0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 02:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJPAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJPAdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 20:33:20 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DD3C171;
        Sat, 15 Oct 2022 17:33:19 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id j6so3199159uaa.10;
        Sat, 15 Oct 2022 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDacUmmZ7HxWAj/1LVMZcfDqYikzx/CSXHqsj+KHPVE=;
        b=ngQx/7ePtLMoj/u1KOM/dqo0atMEUjEQWawWTtHCT6VN2bFcek7EXbXZFZQiLA4lSh
         UK6HQeUH6o12dNoQFp8kOIhjvrZmBVa8oksueWT8MzFJl2/C0wC4QYUrQchmsD1SfgzX
         xxGcOy/scXwgw8VNwIoAeuXZPcs22g9QOUtIFRCrhjCuJ+cAm15IkBxF0FySWRU//s5B
         8XHD5t8pBAVhhHba63OFBdA60X2TQ/6osZnmwpQhdQJc2ZlKgwvExTuoBJFNyNS8VAn3
         QtLSrEUH0DUal3BSnN1wK3EhVqOBoFzTrPJ4iwYpA9G4qGmdmg6xVUZTnahpwIj31twS
         yY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDacUmmZ7HxWAj/1LVMZcfDqYikzx/CSXHqsj+KHPVE=;
        b=AUgyVCHyvjuRmqtqGDStbZUCK2VH6YoUWPCvgF8ZjIzI50+DQ9RdDd0lQVbHxui87q
         W4aHr++D6rXm/qCH2FIhmKVauhPGibDngy/SXFHzo7mLWvYw+DAzR3JHQdA01rcvBXFo
         HaEvL/UoaPEnlxbr2vEwk56xLC4cNb881Ojy3+c+dJ0aQngbXuW8fzqjEfNa45gHZJm+
         6xD7jsgZypZQ1lmbBYDVr64AdgJZMyoYlz4gX57tFD0Q+sARTlMzTy1+3sn74rc4hI5w
         BGo2ziVeV8y3DfFunHRYx5Un3q8MrnbSARxkxrOaoC6sMaQl5CdHD1yfXG+o8CcC0OOh
         o3Gw==
X-Gm-Message-State: ACrzQf0dRXcyo9S/DPd1LE/XpbpdUrhoFe4z1IUqbbmxVfJhXWpVVoJ4
        tlhNrp075bfT66JxQ+SQhnBKolRdwmO37MY8hHFDhshGhuY=
X-Google-Smtp-Source: AMsMyM6L5LAp9jpA9ZHMsAqdnhx23KnjFyO5ZXE49e98haLJAiJxt76TcNKcvPXVP8FDf8vJqnMaXPFtvV4agYjspgQ=
X-Received: by 2002:ab0:6f93:0:b0:3d7:b9af:39d4 with SMTP id
 f19-20020ab06f93000000b003d7b9af39d4mr1856092uav.84.1665880398635; Sat, 15
 Oct 2022 17:33:18 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 Oct 2022 19:33:08 -0500
Message-ID: <CAH2r5mu+WTsmhrmJpGWqj4Wn9J2TQnEaqZv+pHLsLd91g=8wdA@mail.gmail.com>
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
ac1e8c6c95bf805c699656046aef0a05205edfbd:

  Merge tag '6.1-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2022-10-10 20:04:22 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part2

for you to fetch changes up to e3e9463414f610e91528f2b920b8cb655f4bae33:

  smb3: improve SMB3 change notification support (2022-10-15 10:05:53 -0500)

----------------------------------------------------------------
15 cifs/smb3 fixes including 2 for stable
- fix a regression in guest mounts to old servers
- improvements to directory leasing (caching directory entries safely
beyond the root directory)
- symlink improvement (reducing roundtrips needed to process symlinks)
- an lseek fix (to problem where some dir entries could be skipped)
- improved ioctl for returning more detailed information on directory
change notifications
- clarify multichannel interface query warning
- cleanup fix (for better aligning buffers using ALIGN and round_up)
- a compounding fix
- fix some uninitialized variable bugs found by Coverity and the
kernel test robot
----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: use ALIGN() and round_up() macros

Paulo Alcantara (5):
      cifs: improve symlink handling for smb2+
      cifs: fix uninitialised var in smb2_compound_op()
      cifs: prevent copying past input buffer boundaries
      cifs: fix static checker warning
      cifs: fix double-fault crash during ntlmssp

Ronnie Sahlberg (4):
      cifs: fix skipping to incorrect offset in emit_cached_dirents
      cifs: fix regression in very old smb1 mounts
      cifs: enable caching of directories for which a lease is held
      cifs: find and use the dentry for cached non-root directories also

Steve French (5):
      smb3: clarify multichannel warning
      smb3: must initialize two ACL struct fields to zero
      cifs: lease key is uninitialized in smb1 paths
      cifs: lease key is uninitialized in two additional functions when smb1
      smb3: improve SMB3 change notification support

 fs/cifs/cached_dir.c | 469
++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 fs/cifs/cached_dir.h |  20 ++--
 fs/cifs/cifs_ioctl.h |   8 ++
 fs/cifs/cifsfs.c     |   9 +-
 fs/cifs/cifsglob.h   |  48 +++++++---
 fs/cifs/cifsproto.h  |  13 ++-
 fs/cifs/cifssmb.c    |   2 +-
 fs/cifs/connect.c    |  22 +++--
 fs/cifs/dir.c        |  32 +++----
 fs/cifs/file.c       |  45 ++++-----
 fs/cifs/inode.c      | 176 +++++++++++++++++++++--------------
 fs/cifs/ioctl.c      |  25 ++++-
 fs/cifs/link.c       | 107 +--------------------
 fs/cifs/readdir.c    |  31 +++++--
 fs/cifs/sess.c       |  34 +++----
 fs/cifs/smb1ops.c    |  56 ++++++-----
 fs/cifs/smb2file.c   | 127 ++++++++++++++++++++-----
 fs/cifs/smb2inode.c  | 170 +++++++++++++++++----------------
 fs/cifs/smb2misc.c   |   2 +-
 fs/cifs/smb2ops.c    | 149 +++++++++++------------------
 fs/cifs/smb2pdu.c    |  75 +++++++++------
 fs/cifs/smb2pdu.h    |   3 +
 fs/cifs/smb2proto.h  |  25 +++--
 23 files changed, 922 insertions(+), 726 deletions(-)


-- 
Thanks,

Steve
