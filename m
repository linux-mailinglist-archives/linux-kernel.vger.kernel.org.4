Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2866DA832
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 06:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjDGEQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 00:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjDGEQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 00:16:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25855B83;
        Thu,  6 Apr 2023 21:16:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g19so40070559lfr.9;
        Thu, 06 Apr 2023 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680841009; x=1683433009;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VuHizS7zH+ZMih1S8QStNJ1DoB7dvTOcMrQct9meOak=;
        b=Ash4y/U6xqht05MVKr8Xx6Uo4YB3NFOyXfWs9Krih/t9nh59xRkg4wvDt+e7so2RjM
         eXV/9tljzYFtJrU1J+HjFx6JGCw7BRyzsaiSTHHZCzIvQtw9BtusBAxhE48jkTYcwY08
         cWDpfzKZN6l9PO2mdeCRfmKJp1utWgNZSB56k3lLQdw5dyH0/9dlYQPF8tPqWz2wvPxi
         UfQKGeHNhloU8wOoIAoGCh2Umd1apf/9HufOfsoCFyKqjrAsdstxUkAhUfByjtFxCoPO
         /9O8nIqAVvqb/lhtg0bQRyQTjMJNP1bW8fMldAPuKL6skFMtilEXStpInPxfVTNGrCGe
         03Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680841009; x=1683433009;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuHizS7zH+ZMih1S8QStNJ1DoB7dvTOcMrQct9meOak=;
        b=zVwXBF7LX8EJbdsck9QHnorW6ya7gGKq5cj5EuElu+RU+Ou82b0b3XMgVKjPPI0HEN
         ZeFiA90gsDXH0sUvT32DRn454T428fv7hREu0XbwKpmdI7M+Iz6s4GL0Wzuo/8s1F1l7
         QFGfM18yjdzY3q1CpDRL7mffZ5b5UpBuaiay1jICewEpEJ6CZNiQXhzstRXE8YHThnSB
         /arcRFBHazQYqxRdJoL01a+3VDniyhGOVbEgMXE4k5pgM7AV09cujM9n+9P+fnCgI+aT
         5TCJNlDs7vmqTB3x7uNedddEtTvN1vIlrd1lAeWHYVcq7qM1KcAl8FySRZlkW8xgTGo7
         sw0w==
X-Gm-Message-State: AAQBX9dPOsSUuno8cYf5SOSTL5jxJzRcByPJ1lumysxBYkyV6YpSAOJr
        wymndtIm1ypmkVLi4GGAK481AZ8NBKGwb65zAeO9JCiMc0Y=
X-Google-Smtp-Source: AKy350ZBD/D+rQLDe9CzAYMO7+EWxdxbe2OKl/Kp/uCsntdt0m1dFYQ5764Moq91zt1WIoRqf7Qdlz1fXhaWLw9QTW0=
X-Received: by 2002:ac2:54ad:0:b0:4eb:1606:48d5 with SMTP id
 w13-20020ac254ad000000b004eb160648d5mr384818lfk.7.1680841008736; Thu, 06 Apr
 2023 21:16:48 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 6 Apr 2023 23:16:37 -0500
Message-ID: <CAH2r5muJ_pjqS7pqDOLWiqcwjR1eHB91dX5XeoM8TVL-Lng-eg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
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
90c8ce31dbe93f277fc1157e34740e841094c254:

  Merge tag '6.3-rc3-ksmbd-smb3-server-fixes' of
git://git.samba.org/ksmbd (2023-03-24 17:59:00 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.3-rc5-ksmbd-server-fixes

for you to fetch changes up to dc8289f912387c3bcfbc5d2db29c8947fa207c11:

  ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr (2023-04-02 23:08:56 -0500)

----------------------------------------------------------------
four ksmbd server fixes, including three for stable
- slab out of bounds fix
- lock cancellation fix
- minor cleanup to address clang warning
- fix for xfstest 551 (wrong parms passed to kvmalloc)
----------------------------------------------------------------
Marios Makassikis (1):
      ksmbd: do not call kvmalloc() with __GFP_NORETRY | __GFP_NO_WARN

Namjae Jeon (2):
      ksmbd: delete asynchronous work from list
      ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr

Tom Rix (1):
      ksmbd: remove unused is_char_allowed function

 fs/ksmbd/connection.c |  17 ++++-------
 fs/ksmbd/ksmbd_work.h |   2 +-
 fs/ksmbd/server.c     |   5 +---
 fs/ksmbd/smb2pdu.c    |  36 ++++++++++++++----------
 fs/ksmbd/smb2pdu.h    |   1 +
 fs/ksmbd/smb_common.c | 138
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 fs/ksmbd/smb_common.h |   2 +-
 fs/ksmbd/unicode.c    |  18 ------------
 8 files changed, 140 insertions(+), 79 deletions(-)

-- 
Thanks,

Steve
