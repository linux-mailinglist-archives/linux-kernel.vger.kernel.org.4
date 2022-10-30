Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22456126E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ3Ckx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Ckn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:40:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBB2FC35;
        Sat, 29 Oct 2022 19:40:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s24so12886793ljs.11;
        Sat, 29 Oct 2022 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6fUYIdcwT2xWMYpbCE7d7yg88TozpwgmASlzkyxkfUA=;
        b=SDJWiDGbjKV38imSTUJsS6USGnKv/j8IQpf6Bgg41FYvso64oCz8/F09uViIX8SvAJ
         A8hJPOHage2nC5FDTfX+O1gy2FbsHmsGFy9FQb4ePDurrCLTk+2cva0rNnL8e3qaHokN
         f7X7pfRm2nLI+pqeMoJ1MJp0Kp8jSRcKHxvEDO3sB1eaLNzv5HJzm9yKBTPq9CnCphLn
         tUoCL1WRXoR2VIoaUJkl7Y1DIl+uoXYqDNjjryrgvbiahxF2U1di2nWWOuKXLZQRIP8m
         Sfast3Mo0NRbaXwYVgPreSW7bUW3stC1+AYmdPlX+m/Xys2cMFnVC1ckbfYp+JZVtknb
         OAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fUYIdcwT2xWMYpbCE7d7yg88TozpwgmASlzkyxkfUA=;
        b=lKILSSKNK+0E46rI0h/TnhJibvyeFVGNVOWyMdae5rKiviBTIoQmW0y+kO2lLQFc4+
         RtF25DuGkQ9FqL5BG21RhRknn/upvhoP0dH5aI//nHF5YaZR2hH6M5/EeDq3+i5v7fKY
         FWOAjSDhIOPID7affl5ea3HIxRLXdIV7LS0qswvGL7ExpP9oiG4vgBfXoW4G3Zhe7UEE
         m9ZHDxY/A27pkhbqj4JzGUbpotgpSJcP9OZEqXAauTCjW7kusBk4ii5yNdgZY4HBU7QE
         8X5N38j2hh6S+/mCHKfwEH8PLmqW9WXZbP3Z//hHqnLokamZ1tom4cA9o5TIeG6XQLKZ
         pfpA==
X-Gm-Message-State: ACrzQf1LR2mNmSIHot8lEKwdzvMr7ZBcd6BeS1X26yX1j6edmvvDXCwP
        PmGLhQf8vexf2CFevOV+diyMadcX9mtCINTeiQ8=
X-Google-Smtp-Source: AMsMyM7RiR4YHrARQkliY6bEiFI1MwPRWYHXCiLvC+HVPny86wNgNk4ObeOWGzfyftJ2mopdrAbX0ai8JjqNt6V1B/A=
X-Received: by 2002:a2e:be23:0:b0:26f:de10:4d08 with SMTP id
 z35-20020a2ebe23000000b0026fde104d08mr2804109ljq.155.1667097640636; Sat, 29
 Oct 2022 19:40:40 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 29 Oct 2022 21:40:29 -0500
Message-ID: <CAH2r5mu1Ha1DUq8T77hf-_2njaNLUKPa=yqkZurEtzFGrEoCVg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Zeng Heng <zengheng4@huawei.com>
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
247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc2-smb3-fixes

for you to fetch changes up to 153695d36ead0ccc4d0256953c751cabf673e621:

  cifs: fix use-after-free caused by invalid pointer `hostname`
(2022-10-27 23:59:13 -0500)

----------------------------------------------------------------
3 cifs/smb3 fixes (also for stable)
- use after free fix for reconnect race
- two memory leak fixes

A broader fix for reconnect races (killing the cifsd thread earlier),
and an important for for multichannel oplock breaks are not included
in this P/R since still being tested.
----------------------------------------------------------------
Zeng Heng (1):
      cifs: fix use-after-free caused by invalid pointer `hostname`

Zhang Xiaoxu (2):
      cifs: Fix pages array leak when writedata alloc failed in
cifs_writedata_alloc()
      cifs: Fix pages leak when writedata alloc failed in cifs_write_from_iter()

 fs/cifs/connect.c |  1 +
 fs/cifs/file.c    | 13 ++++++++++---


-- 
Thanks,

Steve
