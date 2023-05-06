Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3086F8D23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjEFATS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:19:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83AF7;
        Fri,  5 May 2023 17:19:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso2696068e87.2;
        Fri, 05 May 2023 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683332352; x=1685924352;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zJbT9seqOr610GSQPlm/KBZDSeZR99v0XHRcyfZsL4=;
        b=Wy214gXS09ETUO442Xq6Q9xy8yO5zx3NwJ80gbhp9l8mJvTnqZxBYLtiZHkUg365E6
         iYJAHc/wr7eQ9n0HjOBlfCkA1xbNa/wFj0YLUFI5JgToiDLX/RNwAxvj3UZdE2Bm+d6C
         T6XehCFIFV/4yIjzAGwlzfU65fwf8Hmudt6KSOq81SDIDnzol1+NvK6vFjZIXgvBCy67
         uBHgt8HbyKp4whqMUjL2adkG42wVc0H1Dl9lzPL/Mvkz68YGaQvflSnGXBjdGSPZEmqe
         qK35OobtnpVC194sJGe6lImafdwLyMuakxRyngXqlkVeoMUy3wKgdoug+zxlK4GO4nZJ
         4kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683332352; x=1685924352;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zJbT9seqOr610GSQPlm/KBZDSeZR99v0XHRcyfZsL4=;
        b=CVo+/nvLQ1B3rXGMr8DMl2IvLzK+3190lpYm85puROhqtvI9k7J5oYSxG9nmLmN+Sc
         HSxVJUMt1fr2X2T1izNd1q+8aGrva3Xtyjw2Co9LysqtD3cmBAj4TkKOdfZiDd48dLRU
         /Z6k58JmRD/LRl4T1k96PIEy9tE4mCHok0eF6mJ278lB1Eu+BSBe2HwFhkWjSDIQYqFA
         TKd+/MM2MsJj3x0sFh8nrkUnFSP+IJFxNzgTQcwCI8KXtylew/pqPF3uDgnPLoQoQ583
         fZ6Cd8kl13hS3xwhfl7/qdf27twTv7NbPQktVVZ53D2llbHwQgmn2L9awzy4Xt/VBJxV
         dE4Q==
X-Gm-Message-State: AC+VfDyF20n7UFPvkAMLlLas4qksiJoKScsysv/5R6Z0pDnsuiiSS03r
        b3luWvVkiI/an9+eR1xopvCVOWCf6QdRNvSrhnPPQJImv8A=
X-Google-Smtp-Source: ACHHUZ4A99RCn0qy34YbIPZUTbTx4Fx64p6VPUhpMYdbTtJtj8dj4wJi/OLnFnebB3J35wBSRqKHObv+423QrsG+xLc=
X-Received: by 2002:a05:6512:3c2:b0:4b6:eca8:f6ca with SMTP id
 w2-20020a05651203c200b004b6eca8f6camr973158lfp.67.1683332352005; Fri, 05 May
 2023 17:19:12 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 5 May 2023 19:19:00 -0500
Message-ID: <CAH2r5msXNvALwEwtEyQuX_VjN=aNgfPZkvMbR74GeBHZyTDO_A@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
1ae78a14516b9372e4c90a89ac21b259339a3a3a:

  Merge tag '6.4-rc-ksmbd-server-fixes' of git://git.samba.org/ksmbd
(2023-04-29 11:10:39 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc-ksmbd-server-fixes-part2

for you to fetch changes up to eb307d09fe15844fdaebeb8cc8c9b9e925430aa5:

  ksmbd: call rcu_barrier() in ksmbd_server_exit() (2023-05-03 23:03:02 -0500)

----------------------------------------------------------------
Ten ksmbd server fixes, including some important security fixes
- Two use after free fixes
- Fix RCU callback race
- Deadlock fix
- Three patches to prevent session setup attacks
- Prevent guest users from establishing multichannel sessions
- Fix null pointer dereference in query FS info
- Memleak fix
----------------------------------------------------------------
Namjae Jeon (10):
      ksmbd: fix memleak in session setup
      ksmbd: fix NULL pointer dereference in smb2_get_info_filesystem()
      ksmbd: fix racy issue from session setup and logoff
      ksmbd: destroy expired sessions
      ksmbd: block asynchronous requests when making a delay on session setup
      ksmbd: fix deadlock in ksmbd_find_crypto_ctx()
      ksmbd: not allow guest user on multichannel
      ksmbd: fix racy issue from smb2 close and logoff with multichannel
      ksmbd: fix racy issue under cocurrent smb2 tree disconnect
      ksmbd: call rcu_barrier() in ksmbd_server_exit()

 fs/ksmbd/auth.c              |  19 +++++++++++--------
 fs/ksmbd/connection.c        |  68
++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 fs/ksmbd/connection.h        |  58
+++++++++++++++++++++++++++++++++++++++-------------------
 fs/ksmbd/mgmt/tree_connect.c |  13 ++++++++++++-
 fs/ksmbd/mgmt/tree_connect.h |   3 +++
 fs/ksmbd/mgmt/user_session.c |  81
++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 fs/ksmbd/mgmt/user_session.h |   1 +
 fs/ksmbd/server.c            |   4 +++-
 fs/ksmbd/smb2pdu.c           | 109
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 fs/ksmbd/smb2pdu.h           |   2 ++
 fs/ksmbd/transport_tcp.c     |   2 +-
 11 files changed, 250 insertions(+), 110 deletions(-)

-- 
Thanks,

Steve
