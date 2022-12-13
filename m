Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97F64B3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiLMLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiLMLJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:09:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8651AD98
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:06:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so15205908wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPBAXEgT7BYe8iHEGhBQuztd0ZEIXq+Coot2R2eqOek=;
        b=WMCfDaW5CffnsikYaRJbxrrgYTAATPPCNrXZNUJ13ZUEKk8povj6UbODHTnDdnIE0d
         2cdTmOXhq9c5V3vcXSEd5AxbSBiOFN95PCko6Xx0vakayVhX9Jw3kuE3qHcPm0Svh6uP
         kyocSH7xeGqWU2VNpB25c9xyeUf35HoRBe/gZSa1GP6YchcciVKMkUhk9AZsnTXN8N83
         s/ET0kjV71ivTwS9JxM5h3oKtnAkMsF1p6HRCOXMPoj9k2h+T+eHhJbOT6fLmXwfTS98
         6LS+xt4dvcbqe1MFYS1Cx8zPbUBC9/Nk4n1F1DyJL3Ft+NMXuApOnN9hlA/M6NABCSMB
         QLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPBAXEgT7BYe8iHEGhBQuztd0ZEIXq+Coot2R2eqOek=;
        b=wE7/YRU90dXHDyGP+xCwwTM65NJ6GtiDJaayEJljoJI7TrTlFuss43ChuaZi7ND+pt
         4oDMw0ZhXwScweHjDoyb3vQEauLR3dlPtwmJaeKr8spZEf8tINMV2E0WeGE27OoCY1nY
         N3jF3kPxpgJvqVEDTPEfA/ewn0CmvHaKrmy1OLibwYY50gmoahW9rZ7HuBHETJrqCfBv
         DBq0i7pjzh5zj5eNrgG+IzF6hiyI4LWX+7Tpftgd9b+V2jT90viKdVkUYWHxHCZQAe/0
         sC0FTKWxgJmXC5JIdffAy1qAnEhO0ocmQLOjKKqi5i74AuDcEA7veJXnC2vungV7cEF6
         vALg==
X-Gm-Message-State: ANoB5pkN+GhFb7QdYACsCnGAODFzOqli+UvA0ybBG7UppBYvUB4EScdx
        2MM30FaL0QJs7Eko5UOK+dCj66khT8xxcY9ag76Jhw==
X-Google-Smtp-Source: AA0mqf5dkjy7PBXka60IMDdtPb8xRoBP5tqe3rSXozP1kTtm95dmCRWWaozIjGOIL/6nMwER2uRpIlmbiNwUti1NyLI=
X-Received: by 2002:a5d:4e11:0:b0:242:b6e:1744 with SMTP id
 p17-20020a5d4e11000000b002420b6e1744mr34973277wrt.413.1670929593059; Tue, 13
 Dec 2022 03:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20221211002908.2210-1-hdanton@sina.com> <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com> <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com> <20221213014716.3347-1-hdanton@sina.com>
 <Y5fzN9ZWgXFyT+fU@ZenIV> <20221213041225.3461-1-hdanton@sina.com>
In-Reply-To: <20221213041225.3461-1-hdanton@sina.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 13 Dec 2022 12:05:52 +0100
Message-ID: <CAG_fn=VbTqF8CrBXC=F7jwy=Yr=ExGQcGvSzMsixmF=2vu285A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
To:     Hillf Danton <hdanton@sina.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 13, 2022 at 5:12 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On 13 Dec 2022 03:36:23 +0000 Al Viro <viro@zeniv.linux.org.uk>
> > On Tue, Dec 13, 2022 at 09:47:16AM +0800, Hillf Danton wrote:
> >
> > > > maintainer time is expensive.  So by not improving syzbot in a way
> > > > that really shouldn't be all that difficult, the syzbot maintainers=
 is
> > > > disrespectiving the time of the upstream maintainers.
> > >
> > > Are upstream maintainers prefering to spend weeks and months creating
> > > ext4 beatles for example over taking a couple of hours scanning the
> > > syzbot reports like this one? Why does the bot kick you if you have a
> > > clean butt? Why are usb people irrelevant in this case?
> >
> > And to continue with the rethorical questions: has anyone bothered to
> > inform you that you are an obnoxious cunt?
>
> When did cunt go in to your mind? And How?
> >
> > *plonk*


I think it's time to take a step back now and try to keep the
discussion constructive.
It's really about bots and automation, no need to engage in personalities.

I myself am not involved in improving syzbot, but as a bystander let
me assure you that the folks do take the feedback seriously and
actually have interest in improving the experience for the upstream
maintainers.



> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20221213041225.3461-1-hdanton%40sina.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
