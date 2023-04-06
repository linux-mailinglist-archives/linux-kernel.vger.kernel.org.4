Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A06D935C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjDFJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbjDFJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:55:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0903BA256
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:53:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso100525e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680774797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6fWnpIlBWWjYRDsZu104r+XDlVAJ1QKjavndHr6pPA=;
        b=Lqx4wPi81PbB1Yc/S8nC4ITr8iNStGnWlrhyuQywc4aPBjDNdZHireqYIWUssHWRKZ
         pjNBqiYz1bOw0NfUBMRPuZy8WiXcgqgSMYl5ThGNiWmF1m1PHQDtu0KdLQmY+pG6APbG
         nmPiUMgJ+491f2nB2cfr77kXFG1HGW0adM+ZEmxvAbHu0G8aLMmnveVjpZ8m9wQ5STDa
         RVDh0DEGusKrJ0qRMqotdlvUQCR2M9uOSQGuAGH+iNnEsVnVWUWfvMv+8O5uMinvBdph
         /izsYojH4gy6mOTRecFWEzRqV1IC5gwLdyMyS3IwW5C/b5q7vjVSbZJ1Dfxp8c1iMTNn
         l3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6fWnpIlBWWjYRDsZu104r+XDlVAJ1QKjavndHr6pPA=;
        b=pGEqWbe5ziPw4dnCtecsqP9Lm3ZbCZT36W6DoTjc7hyZEBzvF443maQA5qbJFzE+e4
         1KNjQk0I5hkgOjR6OHbEGCTy9fqVm9tDQmbS3/KZWbZ7q3t5N33rC+BocbCVaSjZdkdy
         tsyYBDRGXiYuT1NxaEuHwjQgnod3yVLYarmJPAIYhjYyBFRZMXeQTz2P9DA5PSp7Aptp
         Hyf1zDLVGWrrp0Lnr0nxevatG2kOzLHpr2WEP0Lp66PofYim7sfvppHIF5ZXwX/HDEXQ
         bY6cl9NqrPTtox7h1OtraU+A4n9Z8PUDNxF55jPHtjhSTPNSZvG1ssQkUjmyC1lGpm30
         yxOQ==
X-Gm-Message-State: AAQBX9cPZnF125qCyXEIXgXvd5yUgLngf+t38ZBgBLMw3RUrN61qWT7e
        lhHAipHrxmjt492ETEblOoxYGvYo7kRo2/enebWWrw==
X-Google-Smtp-Source: AKy350bshHE2Wk7p4fh6dTdesXCWQbzTrumh8diUAnIaHDVjhEw8KoI1+Xd2C276dzDVEEdXXRHJhQyU/6irJkE41bQ=
X-Received: by 2002:a05:600c:3b8d:b0:3ef:79cc:61ce with SMTP id
 n13-20020a05600c3b8d00b003ef79cc61cemr157125wms.4.1680774797633; Thu, 06 Apr
 2023 02:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032660805f8337db1@google.com> <4e345a16-bdc9-6f1e-9bb9-0ba35fa69e3e@bytedance.com>
In-Reply-To: <4e345a16-bdc9-6f1e-9bb9-0ba35fa69e3e@bytedance.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 6 Apr 2023 11:53:06 +0200
Message-ID: <CANp29Y6uoTbfQArtcR=K-i_9TT=74PSZqV-kxr1kRZLdGfiedQ@mail.gmail.com>
Subject: Re: [syzbot] Monthly mm report
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     syzkaller@googlegroups.com,
        syzbot+listf2f28c8e4d5809654f88@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 11:38=E2=80=AFAM 'Gang Li' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Hi, syzbot engineers.

Hi!

>
> As far as I know, syzkaller provides a reproduction code for each error.
> However, I couldn't find the code in the website[1]. Did I miss
> something? How can I get the reproduction code?
>
> I want to help fix some bugs.

That's really great!

Yes, for most bugs syzbot succeeds in finding a C reproducer. If a
repro is found, we alway give a link to the reproducer in email bug
reports.

To find it on the web dashboard, you first need to go to the specific
bug page (click on one of the bug titles in [1]). E.g.
https://syzkaller.appspot.com/bug?id=3D4ecce7e55e02002f794e28cbac1682346d42=
3737

At the bottom of such a bug page, there will be a list of crashes. And
in that table, there's a "C repro" column with links to C reproducers
that have been found for the bug.

--
Aleksandr

>
> Thanks!
>
> [1] https://syzkaller.appspot.com/upstream/s/mm
>
> On 2023/3/31 23:01, syzbot wrote:
> > Hello mm maintainers/developers,
> >
> > This is a 30-day syzbot report for the mm subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/mm
> >
> > During the period, 15 new issues were detected and 2 were fixed.
> > In total, 120 issues are still open and 197 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Crashes Repro Title
> > 1899    Yes   WARNING in split_huge_page_to_list (2)
> >                https://syzkaller.appspot.com/bug?extid=3D07a218429c8d19=
b1fb25
> > 176     Yes   INFO: task hung in do_read_cache_folio
> >                https://syzkaller.appspot.com/bug?extid=3Dbe946efe33b2d9=
664348
> > 92      Yes   INFO: task hung in __filemap_get_folio
> >                https://syzkaller.appspot.com/bug?extid=3D0e9dc403e57033=
a74b1d
> > 52      Yes   INFO: task hung in __lru_add_drain_all
> >                https://syzkaller.appspot.com/bug?extid=3Da9b681dcbc06eb=
2bca04
> > 38      Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
> >                https://syzkaller.appspot.com/bug?extid=3Da68ef3b1f46bc3=
aced5c
> > 18      Yes   kernel BUG in folio_end_writeback
> >                https://syzkaller.appspot.com/bug?extid=3D7e5cf1d80677ec=
185e63
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
>
