Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDD664D584
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLODSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLODS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:18:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCD2C674;
        Wed, 14 Dec 2022 19:18:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c1so13642116lfi.7;
        Wed, 14 Dec 2022 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dioFLbEOGxQ1WnnPJFiBEKHGM2mIWuscar3MU6PY/Qc=;
        b=YK/UjZC/8oLSXcDlx9PRbvxoLHvIo7kfSpSp05f9bl6ZgAYf+S+bTzzVMDmJkuQLgq
         I/L9aj+abPTM5wdNO5YpO6Y2p3Jagtt2N4iOlbxTFuyoz9m7MpH+LxSmHkpKbvRznERG
         qr1f22XsZhu4t2hfPEWARsboeAccKGDk7RquereIirSJurxLYeBiLrSV9Gn/IgD/hy/V
         lH4QZWKbuQ/UWRJrf7JuQUlXtz7y/AWFT0/AYrzQ15m5bdyO0c5ya7kj+4uiKkNUlzl/
         JFotnApLUuOvmTwCbybnPLslpG/NQGuaL8LWiB2lKBxLyfLbTBMgDI4Oaik8cZ9REWB0
         RW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dioFLbEOGxQ1WnnPJFiBEKHGM2mIWuscar3MU6PY/Qc=;
        b=dcF4XmdRf4315/+dTAPS3XYgz4+u0JovfXzDZ1gn3fGVLkzcJw+JgRYXsawYi3EqUm
         61edjhDheKeOagQDV9rfHBFLU6SnJlJo4Hi5ZFrsKbddVquPE1o52hdIDSvDXz2oRtFS
         B+3REPp3OicBp8HLwVnwABZ4OrZMe2uEt8gdr23gGgi3tBc5/tO9ZNIiE4i2HomR47fq
         ZHX9p72Cmh3UjOAjcuOusAGdv9PQyoGX23/O6MLlNzN6f13+bUu2ztbhf+DJMoRlnk0q
         fF/mKLr1V1UDIyZiG4ZhMrL40TeExoh16go+9/kOFWhEqbrk7Qpw8G+oWJ4eelob9Hd7
         uEXw==
X-Gm-Message-State: ANoB5pmd13z/CBD0SIeyoayqRQtBt7NFiyNzQEOW8IRFRYjOzbTyCx/q
        y+iPORWZgPc3hFNcTQCjnyPkDTSG17njk4g6tnliSVin06g=
X-Google-Smtp-Source: AA0mqf5lpAMDlviE6CswnkABPszt6HgcWcLpVGlUcDEmIavh1Qly7bEhY4J3efY5ExEB5SxIv/yeFTw3r8Gi8XwqKBQ=
X-Received: by 2002:a19:5f03:0:b0:4a2:67ea:a06 with SMTP id
 t3-20020a195f03000000b004a267ea0a06mr31870920lfb.580.1671074305968; Wed, 14
 Dec 2022 19:18:25 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 14 Dec 2022 21:18:14 -0600
Message-ID: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
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
76dcd734eca23168cb008912c0f69ff408905235:

  Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.2-rc-ksmbd-server-fixes

for you to fetch changes up to 72ee45fd46d0d3578c4e6046f66fae3218543ce3:

  ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs (2022-12-11
08:33:32 -0600)

Note that this P/R includes one commit ("ksmbd: replace
one-element arrays with flexible-array members") which you just merged
from a different unrelated P/R a few days ago.  Let me know if you
want me to rebase the ksmbd tree and resend the server P/R.

I can also send the client (cifs.ko) P/R tomorrow if it is easier but
have been working on testing some important fixes which are not in
linux-next yet, so not sure if it is easier to send the client fixes
as two P/Rs, or wait and send the client fixes all together as one
P/R later in the merge window.

----------------------------------------------------------------
six ksmbd server fixes:
- two resource leak fixes
- two cleanup
- a file unlock fix
- a fix for configuring packet encryption properly

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ksmbd: replace one-element arrays with flexible-array members

Jeff Layton (1):
      ksmbd: use F_SETLK when unlocking a file

Marios Makassikis (1):
      ksmbd: Fix resource leak in smb2_lock()

Namjae Jeon (1):
      ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data
encryption for this share

Xiu Jianfeng (1):
      ksmbd: Fix resource leak in ksmbd_session_rpc_open()

ye xingchen (1):
      ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs

 fs/ksmbd/ksmbd_netlink.h     |  1 +
 fs/ksmbd/mgmt/user_session.c |  8 +++++---
 fs/ksmbd/server.c            | 20 ++++++--------------
 fs/ksmbd/smb2ops.c           | 10 ++++++++--
 fs/ksmbd/smb2pdu.c           | 20 +++++++++++++-------
 fs/ksmbd/smb2pdu.h           |  2 +-
 fs/ksmbd/smb_common.h        | 12 ++++++------
 7 files changed, 40 insertions(+), 33 deletions(-)

-- 
Thanks,

Steve
