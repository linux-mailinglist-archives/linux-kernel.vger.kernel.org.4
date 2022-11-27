Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFB639952
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 05:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiK0EpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 23:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0EpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 23:45:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD210B6B;
        Sat, 26 Nov 2022 20:45:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j2so6991914ljg.10;
        Sat, 26 Nov 2022 20:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OucNCRSl4pi5kBIecn6S4zUOMCht720/AR3PWhV8wUU=;
        b=fFgUWCbXeLOTQgs6IYaoJfimVe+mY8HuY2kbnnqe6Yz8KlAUXu/B5NLbuA3DeY5cGm
         Lsn30MSFJew9ggUVda8ZfkCkGO7nzgOFEprfFAax52nbgbbfktMo/gX/4VF0dMmOh+il
         TCB+jHHd6Q1ckjYMb5E+Y1rsjiisHn5b9WHkNcUZ37shVjKtItSQUpyM0Q4CaokZE1lv
         +n3uN1y0MMy48Vok5UeFW9yC7KsP8o0zSHjvNMmtuS5eZ+p2fwldLgKtsJM8XN0rYzQa
         4eRjmzPRHQ9zF8n+z9GVp1oIGTCh2N1OcOKv/x0XGjNZEkfRfFuu8QCZ28VB7FxtiOrl
         BGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OucNCRSl4pi5kBIecn6S4zUOMCht720/AR3PWhV8wUU=;
        b=XUe0LUfD1RivpYizjyepHEWPq0topYB+y/f2fkdMc1hqTvfqJZhK+zWg/54z1hjK2M
         abcQv89HfJ2EQ16d8meTyMLuKnXHBHJQH/T2DUImkExZuXGqq7phoqegB5j1L1jiXoXU
         XbDqScgjAM3XqCPm3lIboDPj9tJVtGwktZWCYDUibdG83nu4UPLqrPToHXCeTz0Fb32K
         N0tlXyHuJ3cMaP3tJT/bSH1LK0+xx+HAG4+Y5M6jYo212D6p9fL3wnFhjfWxHljjH7TE
         B7BLRTHvbbPrhjuBwNshocPZE3bBt1Hw0fW+nk8huyF7yPWWTO3Q7Q8h+D1bkQVN3Vai
         Ldzw==
X-Gm-Message-State: ANoB5pm+3gOKu3vv24TRE/z/GY2MuWdsAKDSt2Mo62EBj6b/U32sh22H
        0m+0wp9pPWK33klUXoTmq+37SVXgaJKCA2l4WFqpyL7gu58pMg==
X-Google-Smtp-Source: AA0mqf4LBcnC0GEHefQ/sY5Kppuzzcr7m/W3y3V5swEhM1BWILC09SGkg/Dc5Xo/81NQhwkvEtLNvUvHLMb14fQCML8=
X-Received: by 2002:a05:651c:2004:b0:277:9e5:6cc4 with SMTP id
 s4-20020a05651c200400b0027709e56cc4mr15608471ljo.137.1669524306749; Sat, 26
 Nov 2022 20:45:06 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 26 Nov 2022 22:44:50 -0600
Message-ID: <CAH2r5ms=XKgJ0sWmYaCG+MY3RHv4vDdGO3VAZAQ=XQLzBW1dzA@mail.gmail.com>
Subject: [GIT PULL] SMB3 client fixes
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
926028aaa3827554096d42ffb0c2973bc7f5e80f:

  Merge tag '6.1-rc5-smb3-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2022-11-19 08:58:58 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc6-smb3-fixes

for you to fetch changes up to 502487847743018c93d75b401eac2ea4c4973123:

  cifs: fix missing unlock in cifs_file_copychunk_range() (2022-11-21
10:27:03 -0600)

----------------------------------------------------------------
Two small cifs/smb3 client fixes:
- an unlock missing in an error path in copychunk_range found by xfstest 476
- a fix for a use after free in a debug code path
----------------------------------------------------------------
ChenXiaoSong (1):
      cifs: fix missing unlock in cifs_file_copychunk_range()

Dan Carpenter (1):
      cifs: Use after free in debug code

 fs/cifs/cifsfs.c | 4 +++-
 fs/cifs/sess.c   | 4 ++--


-- 
Thanks,

Steve
