Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE46AB8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCFIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:53:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F2D93D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:53:27 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h9so8820820ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678092806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKGnj2LWVcfOTDaOSxybdZGGw5kYROUNKfFjgkTuOvg=;
        b=fDUyHbQQokUXfw+im+2/kj2w6w+GTsDUijcfvXUW0P/cPAe2YIdzvckqjEaTe4BMB0
         eHdgDcP9jaBX1w1Zw1sJhf4zgouT7mhUuB/Tj57teFxaiHvULcVMAoGIdT580BbXFCpg
         DhYTHBtbYTWwDvyOpO5EziVU+0jCVUE0POIiNbEKzuh8inhJAhXVze+DlJ16kZw7f0Re
         TgeGJk9sJR84rCkAUT80HfHB33+5cBcBfN1P3Y4dkS6PE2C/ycVljFKeFtugSHy14c26
         blj2igqllymVwwE9KrawC/aEgMNdsKJGK8JjANyXaNmexIk2I1OZsL2b7q8Cg5dVtx8u
         skyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKGnj2LWVcfOTDaOSxybdZGGw5kYROUNKfFjgkTuOvg=;
        b=QgbhW1ZuIjCGRP628j7U9NTsovXbKu5CYKZaFiQ2wjc3iY10sTFOBLs0XBBm3lwbVF
         b8fZ1zHGaFOQzcvqiq+EVlu42UhjgZ5HoTxRAh7Nq0zzRWdk4Phqqlfk0M4TulKoT1Vo
         zoPz5SumTlX/nRjeuChHPTwngGB9MVLe5q27wMJxXAeTClaviZdbssgdxgm+jvwtIuBL
         xE3SNL+Raq37r4ELHVcUxfjPsrQlMKEayjptMhNL7RGQys2UaUQvxfEWg/eS6qgiy+c5
         vxRqbet61VQjStawr9HxUpe5fXk2nkCfaa0UZ6bAwHDzWY6P+D4QjCg3+98Osd9VN73e
         GF9Q==
X-Gm-Message-State: AO0yUKWr8y2GDEo6iMXkyw9hDtuFlcuuf2+CO7lZHtdWeN6uO7diWkGA
        rmDV5m7q/9a0tkJgw7m1evV0rL4uo1ErOIFefrnEDw==
X-Google-Smtp-Source: AK7set+O61X6BiXVbsYSVxrx7gaMiIRRL1Nm9ZG3DeVEwCnJcHQwkiJtMmdxdB+y0fdGlkBY9XGFm85cu2UWqeEbxKI=
X-Received: by 2002:a05:651c:124e:b0:295:945d:b382 with SMTP id
 h14-20020a05651c124e00b00295945db382mr2985593ljh.4.1678092806079; Mon, 06 Mar
 2023 00:53:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674217480.git.linux@leemhuis.info> <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
 <20230301204602.5e9bf3c0@kernel.org> <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
 <20230301214023.610a9feb@kernel.org> <CACT4Y+bxUA1v14y0SGC887er5Nif3ZEanjO_m=K4WBwyNfmZHA@mail.gmail.com>
 <17fdf6f1-60ab-bfde-afc8-5afef6cc797b@leemhuis.info> <CACT4Y+Zm3d9jqK=R-E4xTihEUNdahagPyMPcinWowx8RABawrw@mail.gmail.com>
 <3275c17f-1a62-4e4a-4a5b-06b34098f8d2@leemhuis.info> <20230302181010.859456e24e8aaf0990b0dead@linux-foundation.org>
In-Reply-To: <20230302181010.859456e24e8aaf0990b0dead@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Mar 2023 09:53:13 +0100
Message-ID: <CACT4Y+brH-ygxHYzstC9dgFcQ=NnYgE48E4j+csE3JqH4FaM5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jakub Kicinski <kuba@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Fri, 3 Mar 2023 at 03:10, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > We can parse out our hash from any tag, but the problem is that the
> > > current email api we use, does not allow to specify Message-ID before
> > > sending, so we don't know it when generating the text.
> > > We don't even know it after sending, the API is super simple:
> > > https://pkg.go.dev/google.golang.org/appengine/mail
> > > So we don't know what the lore link will be...
> >
> > That's... unfortunate, as from my understanding of things that would be
> > the most important "Link:" to have in any patches that fix issues report
> > by syzbot. But well, that's how it is for now. In that case I'd vote for
> > this:
> >
> > Reported-by: syzbot@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/b/cafecafecaca0cafecafe
>
> As you previously mentioned, patch preparers should also include
> the lore link so any followup discussion is easily located.

If the link we need to include is to lore, then we don't need to
change the current syzbot Reported-by, right? Instead of asking 3
tags, we can ask only for:

Reported-by: syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/cafecafecaca0cafecafe@google.com/

But as I mentioned we can't provide the lore link at the moment, we
can only add a text to ask to include it.

This also means that checkpatch does not need special casing for syzbot.
