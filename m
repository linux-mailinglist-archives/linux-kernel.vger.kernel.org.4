Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EEF6E463C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDQLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDQLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:18:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB722693
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:17:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c9so24257848ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681730220; x=1684322220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NTB4Q0z/IhAD+EcoZ3Xz1MiJAWYaim+Egf+Tm9hjRU=;
        b=VTcCqdXzZD0E4aIFk6a1Blohsoee33GNiEMcLpBxUOoxLtRwSGxGse6lCugl5/FJcQ
         RfXXotM/Vnyd8/x00XEf5j3W7bXKUZFQxuqooxR1dyrDktZ/82yKzSiA2ZPb1CPDpf7k
         0ogGGXwaCOqtY5CqeRqQSrYGrvgtARf3nxCNx+nuyUP1HUtiog6b0/7e7F/F1ew5K0P4
         ltDQ5is6aQiYfMo6hnkYK4Cv1dK31scI+5l75ZWlsBUleWL68H8QeBwP2wnQAG6MX6xH
         7XKEYv3jWB+pvYOct1GCAyqRyY/3I/vLTyTdQeltraE5T7+oVFIQ9PjXhgmyxBB9p9yk
         dgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730220; x=1684322220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NTB4Q0z/IhAD+EcoZ3Xz1MiJAWYaim+Egf+Tm9hjRU=;
        b=ZIv2wcpGJjz84hul5kV/SHd9xi6l8BpMZItgP/4JO49DFZJUNLlmAD7vrE+XHe40dJ
         kWF8VZ+Hrmj5bzxxgheRr46jcIfE6TV7JvyOx8gsFfL/SL2dYSoXDthP4rmbsf4AmK7o
         aGX/yx07AAl4MBTdmv1bczijPFwsEcVRL39esPqYVYpKPPZtp2yh902z/U8AtWzmiee5
         ZcYJ2wJaNkMLNPRqweq/WOMwHs4aOKD20i6q/yKmUhY8rinuKUHPPechQrTjgIHstB5s
         EMxTzNxUnwTASjMok62VOCS1IlxQdN0onELLjwMAzDyvthjTOGs8DipYcE1qXx3h5/3t
         rQsA==
X-Gm-Message-State: AAQBX9dthSwhFBw1uSNfAyDGrcKIAJcEiNIhi1T4I0ErlRlMJRbWaYU3
        wxsZH4SCfW1DuaMlXcRZZml0PzK9CNWxt+6VweOH3mClqfv6NW7e6uw=
X-Google-Smtp-Source: AKy350bHhucG0xli/fxrhyI487NvtKlgQbsw+bN8A8XItaZEy2DhoMlJsKdncP5V8EbnRNNTLP+3AZuJSYznK9ErTqA=
X-Received: by 2002:a17:906:7b52:b0:94a:597f:30ee with SMTP id
 n18-20020a1709067b5200b0094a597f30eemr2946656ejo.15.1681730220495; Mon, 17
 Apr 2023 04:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com> <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com> <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
 <20230417035232.GM25053@google.com> <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
 <20230417111243.GN25053@google.com>
In-Reply-To: <20230417111243.GN25053@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 04:16:24 -0700
Message-ID: <CAJD7tkah9kx2kAcTY47J2R5p7NYS+b+3A9S_R-hSv9z8OSzzqA@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 4:12=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/17 01:29), Yosry Ahmed wrote:
> > > @@ -2239,8 +2241,8 @@ static unsigned long __zs_compact(struct zs_poo=
l *pool,
> > >                 if (fg =3D=3D ZS_INUSE_RATIO_0) {
> > >                         free_zspage(pool, class, src_zspage);
> > >                         pages_freed +=3D class->pages_per_zspage;
> > > -                       src_zspage =3D NULL;
> > >                 }
> > > +               src_zspage =3D NULL;
> > >
> > >                 if (get_fullness_group(class, dst_zspage) =3D=3D ZS_I=
NUSE_RATIO_100
> > >                     || spin_is_contended(&pool->lock)) {
> >
> > For my own education, how can this result in the "next is NULL" debug
> > error Yu Zhao is seeing?
> >
> > IIUC if we do not set src_zspage to NULL properly after putback, then
> > we will attempt to putback again after the main loop in some cases.
> > This can result in a zspage being present more than once in the
> > per-class fullness list, right?
> >
> > I am not sure how this can lead to "next is NULL", which sounds like a
> > corrupted list_head, because the next ptr should never be NULL as far
> > as I can tell. I feel like I am missing something.
>
> That's a good question to which I don't have an answer. We can list_add()
> the same zspage twice, unlocking the pool after first list_add() so that
> another process (including another zs_compact()) can do something to that
> zspage. The answer is somewhere between these lines, I guess.

But the first list_add() is (in this case) the correct add, so we
expect other processes to be able to access the zspage after the first
list_add() anyway, right?

>
> I can see how, for example, another DEBUG_LIST check can be triggered:
> "list_add double add", because we basically can do
>
>         list_add(page, list)
>         list_add(page, list)
>
> I can also see how lockdep can be unhappy with us doing
>
>         write_unlock(&zspage->lock);
>         write_unlock(&zspage->lock);
>
> But I don't think I see how "next is NULL" happens (I haven't observed
> it).

Yeah I reached the same conclusion. Couldn't figure out how we can
reach the NULL scenario.
