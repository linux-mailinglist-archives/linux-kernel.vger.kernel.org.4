Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C660522F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJSVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJSVpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:45:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752228BB8B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:45:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i127so11693958ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ghDToPdvK1mpXEhLmg0q2dWGU3wc/xDHdpsX0rO9Q0=;
        b=liH6o19VQfWD4VzG180UgTjOTNjj3pN+Q69t9YU2F4a0B6Ovi2tSdXbkE4icogNBhx
         IGRxnqVwcfKeYpCKMW3ewQyejWlo3qILdFroj3k1PU9bZo4QidKPe2p1njsPDwzPQF+M
         6HloV4kS1HXPLKqyaFpJwhpHQyoxdmj/XS7h6KsxCfKu+Ez6bWF1dNEhhWkcrphy0TpU
         +JQ1xvbKLnLoDP+1g6Dp43xT7qgEf3P1hPkYU0B8lAus8SZZXmbNNXxn2XacIDzJSkiI
         11bRHozSI3pxA9asADO1vRs9sAKiBozx6QYOi4Xxf/HRMv4bW1O+3J4W3QokbxisBroB
         zspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ghDToPdvK1mpXEhLmg0q2dWGU3wc/xDHdpsX0rO9Q0=;
        b=XGtkHMUD7CmGl0znQ8DgIKp3Ru4X/7dZROjxooc5gKMAL9spHYIcEkPv5dXvqOsWpL
         a4Gn4mR/Y/q8/g4RhDmHtEKJE42zf3AWspnS7/vte4Qz1x/HUwjlEdlnozSfjj0ITaKi
         cJxHRwLxRHF94nFftZkEHl1Ly1R6L5KgSwxwKoTAQGJN/mjEX+AgkZjFU+GpZjC2i2o5
         +Sm27SPY4DCQsOwryzJlnQnvBHyP5RXosB6IkA9G9uSUk8z07gi3E5OXE2osWKWoCF83
         dgyv92lVGW4PtDH3m7T5UffxFDLFjAD+4v0wgVIg0Q3hp7MZ8fDfn1kQwoF+16tIdytU
         Sadg==
X-Gm-Message-State: ACrzQf3CsLkA97q7SRS7NpqJ72aYeZdBrZLvImELelPofactre1YBUES
        hu6dCztidHRhYYEctfIwi4/uZdn+M286LHtqs4E79A==
X-Google-Smtp-Source: AMsMyM5JbXSwUg/uvL89WwlxwF0CJMWmPiwanb96onTIl9HJDW5/mJv4AJRmoOLhbb0bZ3Mqt+lNh4peUtXJOcqCSdc=
X-Received: by 2002:a05:6902:1369:b0:6c4:8ae:7b14 with SMTP id
 bt9-20020a056902136900b006c408ae7b14mr8299284ybb.549.1666215906319; Wed, 19
 Oct 2022 14:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
In-Reply-To: <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 19 Oct 2022 14:44:28 -0700
Message-ID: <CAG_fn=WF1i+JL_E-7wWEpgtxRNssm_vZx+hqGh_pYDuX1WGPVQ@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     youling 257 <youling257@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 19, 2022 at 1:07 PM youling 257 <youling257@gmail.com> wrote:
>
> That is i did,i already test, remove "u64 __tmp=E2=80=A6kmsan_unpoison_me=
mory", no help.
> i only remove kmsan_copy_to_user, fix my issue.

Do you have any profiling results that can help pinpoint functions
that are affected by this change?
Also, am I getting it right you are building x86 Android?


> 2022-10-20 4:00 GMT+08:00, Marco Elver <elver@google.com>:
> > On Thu, Oct 20, 2022 at 03:29AM +0800, youling 257 wrote:
> > [...]
> >> > What arch?
> >> > If x86, can you try to revert only the change to
> >> > instrument_get_user()? (I wonder if the u64 conversion is causing
> >> > issues.)
> >> >
> >> arch x86, this's my revert,
> >> https://github.com/youling257/android-mainline/commit/401cbfa61cbfc20c=
87a5be8e2dda68ac5702389f
> >> i tried different revert, have to remove kmsan_copy_to_user.
> >
> > There you reverted only instrument_put_user() - does it fix the issue?
> >
> > If not, can you try only something like this (only revert
> > instrument_get_user()):
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.=
h
> > index 501fa8486749..dbe3ec38d0e6 100644
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -167,9 +167,6 @@ instrument_copy_from_user_after(const void *to, con=
st
> > void __user *from,
> >   */
> >  #define instrument_get_user(to)                              \
> >  ({                                                   \
> > -     u64 __tmp =3D (u64)(to);                          \
> > -     kmsan_unpoison_memory(&__tmp, sizeof(__tmp));   \
> > -     to =3D __tmp;                                     \
> >  })
> >
> >
> > Once we know which one of these is the issue, we can figure out a prope=
r
> > fix.
> >
> > Thanks,
> >
> > -- Marco
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/CAOzgRdY6KSxDMRJ%2Bq2BWHs4hRQc5y-PZ2NYG%2B%2B-AMcUrO8YOgA%40mai=
l.gmail.com.



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
