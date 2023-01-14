Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115BE66A81F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjANBT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjANBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:19:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73AD8BAAE;
        Fri, 13 Jan 2023 17:19:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x40so1354585lfu.12;
        Fri, 13 Jan 2023 17:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6Nb5m59yqglWarTpIWBsMtluzB3GAv0iVhqzRthZkw=;
        b=odcuyC3Oj+RheC1ROv3uSXzK2A+S4NC1M1qQA5dyP7STuyhiptCmC0KaTBlbg1MDCu
         9ImWVpN9UIqKfHWZLKLgJXjMgRB8iHEtgMzAePR8OHQIqysVtnSrhWAdTr5P9uq12CT5
         d0nBOjhn2rI+BGQFeEBKWNYeGPu7N7eqxtMJ07GboBHsRa1hBLCXi9JpiV4eY1fZNo0w
         Phd5gUwEzORmezPRrcmXf9DLdkPJCRt2XnhA4O8VXxd/ILeko5me6tNX0ILOeUmRnt5x
         RAOPKdgCi0ZUnI1NXLzmrzUzggaAArgj+XcGI5xLoh8SBQEWpEwbNH2LiX7cNfeY3Yly
         9Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6Nb5m59yqglWarTpIWBsMtluzB3GAv0iVhqzRthZkw=;
        b=Q8RMpa5WEf1R4SsvXwdcULqkKArPoKSYdHhrV9edAlQHSxHfL6iLVTMkEHUNW833ck
         uY1CZz8NQkfnRuJ8GWs0O7WDYX+6MLZE6fTNglkU4s5f3idsgxVrzskw0yO1LCijfXB0
         Ai4Vhlx0WLM9Kv8JKNbMUj3X9Owqmj4hxXMt25gDm7ZQ6Zb4kazVOCHzjuAmLhBHGNZw
         yd8T+BPXsA2Hehg3wEhrFkZeixvp8dNFOoaSrFcsTxOyCMdWo4Fivpb8fc3xJTXWMjCq
         Fih31Q2qfmj+jABLHoT3ALPJdzOeFHb0dIdDnqAezZ9AkdvBiMjkg6CB84iIirEeedSX
         i53w==
X-Gm-Message-State: AFqh2krD8+15cKUtNA8+yyYDP6R9P+JAaw0Qsep7f7hXE+L67uvOzoi0
        M3tLl2Y9OMu0/X+sDi0+icf4U1rhFdNeikiUlYqMozms+18=
X-Google-Smtp-Source: AMrXdXsUVEyEPjacI1DRBTfcvbbgZSf4IsGFqObU5kQRiuJObNxt+r/tzDslzhDo2cprtEGzetNmTRnzK+Gk6eTfIlw=
X-Received: by 2002:a05:6512:14d:b0:4cb:3a2f:26d1 with SMTP id
 m13-20020a056512014d00b004cb3a2f26d1mr2053745lfo.303.1673659160883; Fri, 13
 Jan 2023 17:19:20 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 13 Jan 2023 19:19:09 -0600
Message-ID: <CAH2r5mvwNTHEfbr2DNW8HCx=pdJxNCG5vSO+qk8qxv6Hbcy9rQ@mail.gmail.com>
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
b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc3-smb3-client-fixes

for you to fetch changes up to a152d05ae4a71d802d50cf9177dba34e8bb09f68:

  cifs: Fix uninitialized memory read for smb311 posix symlink create
(2023-01-12 09:51:48 -0600)

----------------------------------------------------------------
7 smb3 client fixes, most also for stable
- memory leak and double free fix
- two symlink fixes
- minor cleanup fix
- two smb1 fixes

----------------------------------------------------------------
Colin Ian King (1):
      cifs: remove redundant assignment to the variable match

Paulo Alcantara (5):
      cifs: fix file info setting in cifs_query_path_info()
      cifs: fix file info setting in cifs_open_file()
      cifs: fix double free on failed kerberos auth
      cifs: do not query ifaces on smb1 mounts
      cifs: fix potential memory leaks in session setup

Volker Lendecke (1):
      cifs: Fix uninitialized memory read for smb311 posix symlink create

 fs/cifs/cifsencrypt.c |  1 +
 fs/cifs/connect.c     |  9 +++++---
 fs/cifs/dfs_cache.c   |  1 -
 fs/cifs/link.c        |  1 +
 fs/cifs/sess.c        |  2 ++
 fs/cifs/smb1ops.c     | 63 +++++++++++++++++++++++++++------------------------
 fs/cifs/smb2pdu.c     |  6 ++++-
 7 files changed, 49 insertions(+), 34 deletions(-)


-- 
Thanks,

Steve
