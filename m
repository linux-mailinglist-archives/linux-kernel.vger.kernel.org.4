Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9645F8985
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 07:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJIFuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJIFur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 01:50:47 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6242E9C9;
        Sat,  8 Oct 2022 22:50:45 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id a66so1370033vkc.3;
        Sat, 08 Oct 2022 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1eiS68Fna3XVtle3ljC6ptDGXbn5f8WPlsRS8C/bwU=;
        b=pedmXNz53LmeXcJq514EG22VILLTADVPAl7yYDUSNFZcQ/2MqYeggAIPQDHE/QJfU1
         +ZtYlXn/4aIJ9V8W2DthebXAs+quxLZFv+zf8yEtYv61iIS6Ylcdr5zynSGhDZxGrpMq
         fulY84ebwnatZBR8qPvaOjfH79CbdDDC7r/IfITWaIvsltU1c9KLxVe59xM/HIXIFicb
         H6MewrduUB91mCDj++i5Sv27NPmXVZaSjCXetwaPafhIRY1XT4CRI6hETHwoWZjkToIx
         mpUCvH30AnVXTTm3CXVhW+A6wMxEgt6d1mp6iB3yFBQbla1neI70clsV7wOJfgk6dnRm
         uhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1eiS68Fna3XVtle3ljC6ptDGXbn5f8WPlsRS8C/bwU=;
        b=Pklpx+YKWVZxaJu3TuoV9wSz1AgxvXYnRofBcIAerUbu31dHoIna7up2Z4ESxvOD5G
         lXSo1agRSkYclsGXGauUJgyfAXidm9P18ZVFzZda+NyMYNTB8dgGXPkeCVb3U2q9dHo8
         IySteh3K0dnDd8IDV+1pqNlYMaUp4p5zLrcLG0TpGw7MWja+gK7LlSOd1Npg57bHcfRa
         tks7vMpDMhs1VT5zPKPcIyUB4ggxeM093lTfVRWzuCo1dCmqzAUT1i0Te5LYdnhOTjtX
         5TBMzHPiChkW9yNSiJreVmZBHdjewrcon2eVsrmvQxBhyves7yCD+R0GNP47xIyMCvEe
         /1Sg==
X-Gm-Message-State: ACrzQf0F1i7b0hrRJwZ1kSPIjEBXm6ZAb5+aLzBDQOcKTtQX8nxK8+La
        ZLbJODtjpVQ0BHIkcxFtT8EV8saVwLCPKYKl2N3UAL04ARo=
X-Google-Smtp-Source: AMsMyM49N55i8Gu1+pXkvUTtaFi7lZuK7rZI5SAB/frAmC6Rbg2hwZJ1zXJJv7Y6JVSLMI+7FHzm8AtpdLZXIWNaTWM=
X-Received: by 2002:ac5:c7b0:0:b0:3ab:2056:3bad with SMTP id
 d16-20020ac5c7b0000000b003ab20563badmr6007614vkn.24.1665294644309; Sat, 08
 Oct 2022 22:50:44 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 9 Oct 2022 00:50:33 -0500
Message-ID: <CAH2r5muHt_9eBuE7GOHNvV+9zHH8X=+sVmK3Qj1R8uEWNydn_Q@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
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
f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc-smb3-client-fixes-part1

for you to fetch changes up to 958553d13478ad0e35fa09fecad3ce73277ccaf5:

  smb3: fix oops in calculating shash_setkey (2022-10-07 23:08:41 -0500)

----------------------------------------------------------------
21 cifs/smb3 fixes, including 4 for stable
- data corruption fix when cache disabled
- four RDMA (smbdirect) improvements, including enabling support for SoftiWARP
- four signing improvements
- three directory lease improvements
- four cleanup fixes
- minor security fix
- two debugging improvements

Additional security improvements including enabling GMAC signing, and
patches to extend use of directory leases (improved safe metadata and
directory entry caching) and improvements to symlink handling are
still being tested and are not included in this P/R.
----------------------------------------------------------------
Enzo Matsumiya (4):
      cifs: return correct error in ->calc_signature()
      cifs: replace kfree() with kfree_sensitive() for sensitive data
      smb3: rename encryption/decryption TFMs
      cifs: secmech: use shash_desc directly, remove sdesc

Gustavo A. R. Silva (1):
      cifs: Replace a couple of one-element arrays with flexible-array members

Jiangshan Yi (1):
      cifs: misc: fix spelling typo in comment

Muhammad Usama Anjum (1):
      cifs: remove initialization value

Ronnie Sahlberg (4):
      cifs: destage dirty pages before re-reading them for cache=none
      cifs: Make tcon contain a wrapper structure cached_fids instead
of cached_fid
      cifs: improve handlecaching
      cifs: store a pointer to a fid in the cfid structure instead of the struct

Steve French (5):
      MAINTAINERS: Add Tom Talpey as cifs.ko reviewer
      smb3: add dynamic trace points for tree disconnect
      smb3: define missing create contexts
      smb3: do not log confusing message when server returns no
network interfaces
      smb3: fix oops in calculating shash_setkey

Tom Talpey (4):
      Decrease the number of SMB3 smbdirect client SGEs
      Reduce client smbdirect max receive segment size
      Handle variable number of SGEs in client smbdirect send.
      Fix formatting of client smbdirect RDMA logging

Zhang Xiaoxu (1):
      cifs: Fix the error length of VALIDATE_NEGOTIATE_INFO message

 MAINTAINERS               |   1 +
 fs/cifs/cached_dir.c      |  92 ++++++++++++++++++++++++++++---------
 fs/cifs/cached_dir.h      |  10 ++++-
 fs/cifs/cifs_debug.c      |   4 +-
 fs/cifs/cifs_debug.h      |   6 +--
 fs/cifs/cifs_swn.c        |  12 ++---
 fs/cifs/cifsencrypt.c     | 100 ++++++++++++++---------------------------
 fs/cifs/cifsglob.h        |  30 +++++--------
 fs/cifs/cifspdu.h         |   7 +--
 fs/cifs/cifsproto.h       |   7 ++-
 fs/cifs/cifssmb.c         |   2 +-
 fs/cifs/connect.c         |  21 ++++-----
 fs/cifs/dfs_cache.c       |   2 +-
 fs/cifs/dir.c             |   8 ++--
 fs/cifs/file.c            |   9 ++++
 fs/cifs/fs_context.c      |  12 ++++-
 fs/cifs/fscache.c         |   2 +-
 fs/cifs/inode.c           |   2 +-
 fs/cifs/link.c            |  13 +++---
 fs/cifs/misc.c            |  63 +++++++++++++-------------
 fs/cifs/sess.c            |  24 ++++++----
 fs/cifs/smb2inode.c       |   2 +-
 fs/cifs/smb2misc.c        |  13 +++---
 fs/cifs/smb2ops.c         |  38 ++++++++++------
 fs/cifs/smb2pdu.c         |  41 +++++++++++------
 fs/cifs/smb2transport.c   |  98 +++++++++++++++++-----------------------
 fs/cifs/smbdirect.c       | 227
+++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
 fs/cifs/smbdirect.h       |  14 +++---
 fs/cifs/trace.h           |   3 ++
 fs/smbfs_common/smb2pdu.h |   6 ++-
 30 files changed, 445 insertions(+), 424 deletions(-)


-- 
Thanks,

Steve
