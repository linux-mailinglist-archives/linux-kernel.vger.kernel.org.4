Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC5C697880
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBOIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBOIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:53:08 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CE9EF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:53:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi36so26685368lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stHWbPbq3hb3twrp9QiiDUcd5sKMEp5Fy5ZP7f6jnj0=;
        b=dFzKL76xNxRGWQbx/Bjgfw0/wtcYZ5OUhoQk/CH516K1P3ps8B5jrESpZamMcnr1q2
         5mASv79Vyiyw0hHqfFMNK1ot0xvedYmPM6ot0DyU8YGFvTOIatCp9GklpQOeFZtoXKP+
         HZJtXtcaBhLyaFB6S2WMVJqCeLpjrbNMoIwmdC0Msd8LIWj2IoEF7b7rUx+gXBL2q7LH
         AbO0H6iApbfNjLr6FkxiGQ7xON1+T9ocaCfSJbKcyn0VRMh4i7mmNwT7f62x35b/m9iB
         5ZCiVCbUGRpMZJiii2JoYtKlLpcc1Zf5nZxSOLpkvzBBf61ooosAFRHm2ogHT5tANJDW
         t5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stHWbPbq3hb3twrp9QiiDUcd5sKMEp5Fy5ZP7f6jnj0=;
        b=hogvQU0KwYu2onRrLxa0+tjsmnc7MufwehkoMD5q6aqxFt5uDpDL30woQ4QlUaQAa6
         DgEdzcEX7ufSzQOffRxLHfRBVS6N7c+J0JSXQt1bq/zObgwac/8c5wkHP/Tmj1mPRgm0
         l8GCw6Sv8fsMn2ak79v0o7dmsAN351w84zjuCW/vt0bPRGHfGgghuMFL2HZuMSnlpHMC
         QXAT5FW63QNwfuzijQmroTMMwYSWKlZwmqoJ/WXIoFv5ZecEeDlP4NExDMVwf01izqRS
         LpAa6k045mSM7hPb1p6FzDFiModlKLc4sHIHWJ9o5kvAZL9e/qvhU0x5x4v5V9+ZcApM
         2WrA==
X-Gm-Message-State: AO0yUKXrKRgSER4Bgk0mZYHIgjK8vLQByuk8b+j/AjcRzD0z3zKvxhOk
        +sMuKSL9DSivoLeHAhLrhCVZAqlSAxr7ZX3lDwqOsD/cJ4NgPTYMxs0=
X-Google-Smtp-Source: AK7set/uILsKQKKQHwlnEaOP9Y4+QIsuW1pt/UJzYGnAhucdRmYQi7lomq3/eeWhODK/EMF7aGSQsgJVpQUOAhCgSfc=
X-Received: by 2002:ac2:4949:0:b0:4db:1a0d:f261 with SMTP id
 o9-20020ac24949000000b004db1a0df261mr303891lfi.3.1676451185197; Wed, 15 Feb
 2023 00:53:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004e1dfa05f4a48e6b@google.com> <20230215015231.3646-1-hdanton@sina.com>
 <CAOUHufYzJoh=Pvican+c8E5-5vyv_TuVaa27nDKXw3CLR=ca5A@mail.gmail.com>
In-Reply-To: <CAOUHufYzJoh=Pvican+c8E5-5vyv_TuVaa27nDKXw3CLR=ca5A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Feb 2023 09:52:51 +0100
Message-ID: <CACT4Y+bKBHus8oe5cMtSfdtG9mMGZGUywA1k_UYCSrwfXWv44A@mail.gmail.com>
Subject: Re: [syzbot] [nilfs2?] INFO: task hung in nilfs_segctor_thread
To:     Yu Zhao <yuzhao@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 07:02, Yu Zhao <yuzhao@google.com> wrote:
> > On Tue, 14 Feb 2023 00:14:42 -0800
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    f6feea56f66d Merge tag 'mm-hotfixes-stable-2023-02-13-13-5..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=165ee62b480000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4082ce5ebebdac63b
> > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba7207480000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fd30d0c80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/1ae0143f08d5/disk-f6feea56.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/18b8a23fa0cb/vmlinux-f6feea56.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/d915f4c5c8c0/bzImage-f6feea56.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/1acd3b288433/mount_0.gz
> > >
>
> > >  folio_mark_accessed+0x51c/0xf00 mm/swap.c:515
> >
> > Syzbot was launched without MGLRU enabled [1].
> > Dmitry could you turn it on by default?
>
> Thanks for the heads up!
>
> (I should have followed up with Dmitry earlier... doing it now.)

Here is configs change (speak up if you don't agree with something):
https://github.com/google/syzkaller/pull/3683/commits/e3c95b410e328b52fef013a8071e47c6c278b1ed
