Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EE6325C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKUO23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:28:27 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6857B6A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:28:26 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3691e040abaso114797007b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml7jgOyvlBn4iSYeLdAwzaahcSUgGBA94Nj4aGxXq3o=;
        b=OTTOGYUYD4wuOxRUU7z6Ke584qbVU9dfkTVjHkFbxLgHHEslljt/xFVqRbJxrlGEkW
         p30poAR0xRFJskqEUOUpN48j2GCSs2HbjiETTsKifs14EvBU1flWFmupm88vh1TCyx+B
         juNeGKVcrUjyBAdTplky6JwZ8KBwB8DChcevrLzFkwlvAh89zENMzhAbOgT12jWDuu7D
         YDk8fh9uO3Xxkg7Kz9IvYX45CmWHTShZfGfcEX8o7p9HEf5Vv+v5vn4lSP+sh7CN/Bb7
         kqkVA8qu5bVm6xlGt0j+7c9B+MGuhnC+iO2gjgeK8JYHy0dm1bwpaG+bVNCEFEfN4CC1
         rNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml7jgOyvlBn4iSYeLdAwzaahcSUgGBA94Nj4aGxXq3o=;
        b=c1N/hpHlPTNYpxbwS8qm41zlmgamVaxb6AUa/JAjl9SbjdFZzs2Wec8cRB59XGEdcz
         Q577jmd7XE4kRXNI+bSgVV01JK5SiAhKMFcF3FeHWgJueUbV2h5H/NzpRI+gvbZGVxmT
         4FsonYJm5Npx9bC75jsI5JEwQXS7Ckvnf44K/PCzmODAEdtygH9QRndm9vRv/s1eOAXV
         V08hZCnSogbKtz3zbPsE7FRFsIOPx5uUKmuq73nXNgOG1/1z79ZknkzINMHshKkiPaEs
         1RAjU8lIy+gu1W8BnTHHgpfd1Cr2wDXxr5z4PvAwW6n6xc47USkUHworJbTCZfw5adpK
         CfxA==
X-Gm-Message-State: ANoB5plntvf8f0C73PPtRyBWM93miRzlIH1SWL6lq8AYCMSXKRk0I4nL
        n9YdlnVbVOobXKIXUOXoGwcH8IJBEJafNHW0jNKkpQ==
X-Google-Smtp-Source: AA0mqf5eVw+u26Pk/PlKIJz2JFqcTC+8GGo2kfHcz/RiLNie8W4PHW4Br8HeLQLSzAymdyXRfzuQNqO6OdLz7PAXpKs=
X-Received: by 2002:a81:a18e:0:b0:368:b923:b500 with SMTP id
 y136-20020a81a18e000000b00368b923b500mr1620172ywg.10.1669040905366; Mon, 21
 Nov 2022 06:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20221118172305.3321253-1-glider@google.com> <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
 <CAG_fn=Wpy8KA0cLBHapd7BdtnPHsRTpYip+z9TjfB1aUHUGH3g@mail.gmail.com> <Y3tjJPtzyi9PD9VD@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3tjJPtzyi9PD9VD@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Nov 2022 15:27:49 +0100
Message-ID: <CAG_fn=WMivfVzE35=LH5y1OeO=_FvnfRkybvE15EaOL2yH0y0g@mail.gmail.com>
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
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

On Mon, Nov 21, 2022 at 12:38 PM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Mon, Nov 21, 2022 at 11:28:39AM +0100, Alexander Potapenko wrote:
>
> > > > +__no_kmsan_checks
> > > >  static inline int arch_within_stack_frames(const void * const stac=
k,
> > > >                                          const void * const stacken=
d,
> > > >                                          const void *obj, unsigned =
long len)
> > >
> > > Seems OK; but now I'm confused as to the exact distinction between
> > > __no_sanitize_memory and __no_kmsan_checks.
> > >
> > > The comments there about seem to suggest __no_sanitize_memory ensures=
 no
> > > instrumentation at all, and __no_kmsan_checks some instrumentation bu=
t
> > > doesn't actually check anything -- so what's left then?
> >
> > __no_sanitize_memory prohibits all instrumentation whatsoever, whereas
> > __no_kmsan_checks adds instrumentation that suppresses potential false
> > positives around this function.
> >
> > Quoting include/linux/compiler-clang.h:
> >
> > /*
> >  * The __no_kmsan_checks attribute ensures that a function does not pro=
duce
> >  * false positive reports by:
> >  *  - initializing all local variables and memory stores in this functi=
on;
> >  *  - skipping all shadow checks;
> >  *  - passing initialized arguments to this function's callees.
> >  */
> >
> > Does this answer your question?
>
> So I read that comment; and it didn't click. So you're explicitly
> initializing variables/arguments and explicitly not checking shadow
> state vs, not doing explicit initialization and checking shadow state?
>
> That is, it doesn't do the normal checks and adds explicit
> initialization to avoid triggering discontent in surrounding functions?
>
Correct

In other words, for normal instrumentation:
 - locals are explicitly marked as uninitialized;
 - shadow values are calculated for arithmetic operations based on their in=
puts;
 - shadow values are checked for branches, pointer dereferences, and
before passing them as function arguments;
 - memory stores update shadow for affected variables.

For __no_kmsan_checks:
 - locals are explicitly marked as initialized;
 - no instrumentation is added for arithmetic operations, branches,
pointer dereferences;
 - all function arguments are marked as initialized;
 - stores always mark memory as initialized.

For __no_sanitize_memory:
 - no instrumentation for locals (they may end up being initialized or
uninitialized - doesn't matter, because their shadow values are never
used);
 - no instrumentation for arithmetic operations, branches, pointer derefere=
nces;
 - no instrumentation for function calls (an instrumented function
will receive garbage shadow values from a non-instrumented one);
 - no instrumentation for stores (initialization done in these
functions is invisible).

In all the cases explicit calls to
kmsan_poison_memory()/kmsan_unpoison_memory()/kmsan_check_memory()
behave the same way and can be used to tell the tool what is going on
in the absence of instrumentation.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
