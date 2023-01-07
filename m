Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F9661083
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjAGR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjAGR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:27:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AA197;
        Sat,  7 Jan 2023 09:27:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu8so6523705lfb.4;
        Sat, 07 Jan 2023 09:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GCJe9ke2QjQRcbjx6nWqRbP0VKN7ctT7Z85awWgZcM=;
        b=Sn/EhkKtJSd+QTIsyaesfiBepjAh4TjF8JT6tMmC7WdehJ+IFwpGyRlVHWXTE89Z8q
         Xn5/wELRlMOx1oj9/6w3QB2gJma2GFCJMQbmz96kN9Pzc3V7pS+scl3wm9WPLcA5281f
         qRsFprK7cGl4HFXNDjwq1ur7GsCMLddfWAMx4GRgUQTRW4t1+7o7gneQ9QE0CE5hFpD0
         llPeBOKZ6t2uWwQbXDm0ApN2SI28CaQ0WRdRl93dXDBVaqLBfY9RBdUZvC1N62geZa3+
         Zr9ZA05VnpuvM2X6lWstW79UQkduTEA7iUIYv7hq0UGmJenPP0VNR7HFEvhMsccoFXBq
         TSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GCJe9ke2QjQRcbjx6nWqRbP0VKN7ctT7Z85awWgZcM=;
        b=X8MRHm3IV2nQldvX9Y8lO/qm81M+BebnEsRZp6yMoa73+ZdhZfcSYm4qYxtZrAaQsd
         8MkCboIJqPAdMoyjBtte6m2nLMQCDtwo8eqXtnDvv9qfbIbsTplSNR08HXUWyXwPgwKm
         4vYxO/oRp9Hs4Ryvzifnea84fYoZFyoxGVTIpkviKrgEZJERy6U8Pv82SzIrqaEz4Q8c
         izkyMMNKJV76jvLkVzDMghM+3no/P//ZNM0HOzwQVOlXU/s8GBL3sucL2lGq/W6W4PL5
         0a1fZmEsTCEiJRqGN59zXzXST4dDwRotdd0hB+nQAOhPh+wWB8TyvnCWYsI9JFt4IuT7
         I+ww==
X-Gm-Message-State: AFqh2kpNhmUHxJaW9Tqp1iwsasUPEyMXHSnniNe2RkUZ435fvrjC7h4s
        8zfkBfkHDhInZCQ/dkVjd5Wy9od44uw2l/bCbDkSyMyxu6k=
X-Google-Smtp-Source: AMrXdXulGR01P3dcnO+LTUxocecMPbRySynADmih5p92Fs60dD42gSomJpDhl7mNhisdU26eOBOh3FC6rN9Snpuc5UI=
X-Received: by 2002:ac2:42ce:0:b0:4cc:5e97:d35b with SMTP id
 n14-20020ac242ce000000b004cc5e97d35bmr350613lfl.403.1673112458997; Sat, 07
 Jan 2023 09:27:38 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 7 Jan 2023 11:27:27 -0600
Message-ID: <CAH2r5muwatnq0rkQzeeWw9pYdd4fZJTMLAiW2j_44cfyMYs1ag@mail.gmail.com>
Subject: [GIT PULL] cifs/smb3 fixes
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
88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc2-smb3-client-fixes

for you to fetch changes up to cc7d79d4fad6a4eab3f88c4bb237de72be4478f1:

  cifs: fix interface count calculation during refresh (2023-01-04
23:18:07 -0600)

----------------------------------------------------------------
6 cifs/smb3 client fixes, 3 for stable
- 2 multichannel fixes
- 3 reconnect fixes
- unmap fix
----------------------------------------------------------------
Ira Weiny (1):
      cifs: Fix kmap_local_page() unmapping

Paulo Alcantara (3):
      cifs: ignore ipc reconnect failures during dfs failover
      cifs: fix race in assemble_neg_contexts()
      cifs: protect access of TCP_Server_Info::{dstaddr,hostname}

Shyam Prasad N (2):
      cifs: refcount only the selected iface during interface update
      cifs: fix interface count calculation during refresh

 fs/cifs/dfs.c     | 25 ++++++++++++-------------
 fs/cifs/misc.c    |  2 ++
 fs/cifs/sess.c    |  3 ++-
 fs/cifs/smb2ops.c | 12 ++++--------
 fs/cifs/smb2pdu.c | 11 +++++++----
 5 files changed, 27 insertions(+), 26 deletions(-)


-- 
Thanks,

Steve
