Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1826079CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJUOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJUOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:40:28 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566356A52D;
        Fri, 21 Oct 2022 07:40:19 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 128so1449280vsz.12;
        Fri, 21 Oct 2022 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tzT1c25RoKfBc8ntTciHpfUO5h//KgZAglB7BspiwMw=;
        b=P7v4RpkkWYxhLM9w+bS/amDjV8NSrzu+p2jF3zRrEYZGHg4eIqO0I0tKJ7WAJ+ST+C
         1VAJB6PCAq8FjGxklcd2g4cqRXoj1INza+L4A0WYNyrKS0jHKKleVvqQ+lcgEKsiKr/l
         Ijs8rtRPbSfAwHZJbU8FKdq0a4YvO8HWnCUjpcwOX+8P8biV5r/UrRGlf43kfLhIoUmC
         Y7Wt4+3HrfKXGtsOknWua9qrJ5tFHnXhCXTx0I98ObwR/NmdWh8qSoD6mHHvdsqaLmpF
         IqzolCvr8C66QoLOiVlQuE7sm1dk6/Ky4zB695FRCsnZiwmifpzwYhK8KKG+tzorI/AE
         MxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzT1c25RoKfBc8ntTciHpfUO5h//KgZAglB7BspiwMw=;
        b=iHGEJlmrZD+veKhzIK43XkbAuYFX5w+/zGweeutx4eYAbCL7m5TZZvPkr081h/RFIc
         kyHjx+fTcoYuVtIr0J/SFSulrNGE9sLz6ARpc4cPNNrRsQ+WxQe37prjLlF/f0jmw6ML
         Vfjg8+t6glkUJN/wbF9YcKST9SA3GerKVE6QfX53AGeQQM6waJ4A6US4j6sRyDVMaPjA
         FQ+czA1ll0lUn42jCC3bCelMS2u2a/s+Cp6i+rp4LEjkexoSjv4fC8/XnE71ei3rSzrP
         Y6q276hnzWWBbPknUDYU9h+igTt01q82sUx+FNpGbgb4H1dUWByMFGpYEQrmtqfKvD28
         3aUg==
X-Gm-Message-State: ACrzQf2INlAWS6UvjSGB9dCn/uOEdKsu6JtNe4nzLmlVlHTPRQWdhkDk
        5a1h7ExkG2ngaabtfJCtoron/Bplfz3qSV8D3Xlt4HI2
X-Google-Smtp-Source: AMsMyM4hGV1xVyZ+pKR/5uztm9opOFajadV7VupRkFxbzJ7GA4O0glyLbBWzdS/+omJuGMGB3AsGA8ONOMPhsp+MrKA=
X-Received: by 2002:a67:fc97:0:b0:3a6:d37e:e7a3 with SMTP id
 x23-20020a67fc97000000b003a6d37ee7a3mr12979874vsp.29.1666363218247; Fri, 21
 Oct 2022 07:40:18 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 21 Oct 2022 09:40:07 -0500
Message-ID: <CAH2r5mvjQ5cnR0dc0oSRpF0Ck7cMyQRX2mng56UXZjHJ=JhMmQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc1-smb3-fixes

for you to fetch changes up to 73b1b8d25e39a1478b3792a7075f43e053ee62c2:

  cifs: update internal module number (2022-10-19 17:57:51 -0500)

----------------------------------------------------------------
12 small cifs/smb3 fixes, half for stable
- two memory leak fixes
- two fixes for directory leases, including an important one which
fixes a problem noticed by git functional tests
- five fixes relating to missing free_xid calls (helpful for
tracing/debugging of entry/exit into cifs.ko)
- a multichannel fix
- a small cleanup fix (use of list_move instead of list_del/list_add)
----------------------------------------------------------------
Paulo Alcantara (1):
      cifs: fix memory leaks in session setup

Ronnie Sahlberg (2):
      cifs: set rc to -ENOENT if we can not get a dentry for the cached dir
      cifs: drop the lease for cached directories on rmdir or rename

Steve French (2):
      smb3: interface count displayed incorrectly
      cifs: update internal module number

Yang Yingliang (1):
      cifs: use LIST_HEAD() and list_move() to simplify code

Zhang Xiaoxu (6):
      cifs: Fix xid leak in cifs_create()
      cifs: Fix xid leak in cifs_copy_file_range()
      cifs: Fix xid leak in cifs_flock()
      cifs: Fix xid leak in cifs_ses_add_channel()
      cifs: Fix xid leak in cifs_get_file_info_unix()
      cifs: Fix memory leak when build ntlmssp negotiate blob failed

 fs/cifs/cached_dir.c | 39 +++++++++++++++++++++++++++++----------
 fs/cifs/cached_dir.h |  4 ++++
 fs/cifs/cifsfs.c     |  7 +++++--
 fs/cifs/cifsfs.h     |  4 ++--
 fs/cifs/dir.c        |  6 ++++--
 fs/cifs/file.c       | 11 +++++++----
 fs/cifs/inode.c      |  6 ++++--
 fs/cifs/sess.c       |  1 +
 fs/cifs/smb2inode.c  |  2 ++
 fs/cifs/smb2ops.c    |  3 ++-
 fs/cifs/smb2pdu.c    | 17 ++++++++---------
 11 files changed, 68 insertions(+), 32 deletions(-)


--
Thanks,

Steve
