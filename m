Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C961065B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiJ0XZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ0XZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:25:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470137F9D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:25:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z192so4343461yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Byo6DTMlo6Jt8yL6f7ACFRU3q1j3diDDzmPUKHU5k=;
        b=E/+fYpPFt183h3xeXmVGJHzY/XkJfR5adPubVtmrTnRjKdl6blRarOiXfSvnoJVMWO
         e5rpaYh5594QcsiV1+RDiL2HzBs413Q6R1sG5U2xpob0TyOlNfeqOmcTDLdl52EUrK42
         3t9ufy0Lglh2L8nyGnnslh6Ur35XG9VMj6u1qs9XSObn5ZBaGhdkS7neLztuLfQZF/ol
         svSETPZICFFDZhfxP/b4hIkbL8FMpwiYF8wGyiBii4k0iEsMRGhEWFi+rSWMIotWfMfe
         i7Qu4UOfN8pBY1tGPXDK0rMZbbaSSoBsUt6RLOCrTQw3sSU6nTvasy3NQozyRbJKBkgs
         BPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Byo6DTMlo6Jt8yL6f7ACFRU3q1j3diDDzmPUKHU5k=;
        b=LQ1uRnqB7BEO+cj3Tpxz0duRiVd0W1CPlRwk+3onu+JBYmGAGRCceHkkJDh+B8k+O9
         Ce4kkkNXRwoIQy6jDoEnsJmLwVWDWvfqWKosLzlq98Oe8iKNfj56c6fkJoi+wPiujMRw
         4juZfMBHIWOn8tsXfwt13sf3Ai4kPc8OP6CYZQ0yqsqzz5NG3kahwIFhQ/YwdhGT7eXz
         5mLmyDorOyCde8+UmeNMZsd0lDLXxwY7YAJzgwNIBmcnD7EwrhKwof1QTrOIBE2W7SLz
         vV0qWOkd+ysBuD4U7X25N5yICF9588QK95q+osGPVqVAg10L96X+HR5RWk2FGDI+90S9
         7jFw==
X-Gm-Message-State: ACrzQf0NhmvTJN8abfmGOr+toRA2+gP78NoOLV6pPN3H5djKzKrZgd/c
        gC8wq4w8NFcQGcrTEt7uK59tt3hg/HpTXh5ajH6XhA==
X-Google-Smtp-Source: AMsMyM6GLtSYbTHSUfM6xVMU0IYuYtA1g9ueGfmppuuROyJL0q9lHQot+gix8SB49FhnNhQJWnJ1xbgbZlTY7SowUZ8=
X-Received: by 2002:a25:9b43:0:b0:6b3:9cc2:a651 with SMTP id
 u3-20020a259b43000000b006b39cc2a651mr45710151ybo.485.1666913131361; Thu, 27
 Oct 2022 16:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221025221755.3810809-1-glider@google.com> <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
 <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com>
 <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net> <CAG_fn=XESk1PPqbAVDqMdGbRwyvLvLQrm2hybr2cXaaYjfZEKA@mail.gmail.com>
 <202210271155.33956B1@keescook>
In-Reply-To: <202210271155.33956B1@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Oct 2022 16:24:55 -0700
Message-ID: <CAG_fn=XX2exsGcD3ZR4LGw4Tqy_ietYe46WEOKt7a_nt9Gf=Cw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
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

On Thu, Oct 27, 2022 at 11:58 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 27, 2022 at 11:26:50AM -0700, Alexander Potapenko wrote:
> > On Thu, Oct 27, 2022 at 1:05 AM Peter Zijlstra <peterz@infradead.org> w=
rote:
> > >
> > > On Wed, Oct 26, 2022 at 11:38:53AM -0700, Alexander Potapenko wrote:
> > > > A bigger issue from the NMI perspective is probably
> > > > having __msan_poison_alloca() inserted in every non-noinstr kernel
> > > > function, because that hook may acquire the stackdepot lock.
> > >
> > > *urgghhh* that's broken, that must not be. There is a *TON* of NMI
> > > functions that are non-noinstr.
> >
> > __msan_poison_alloca() is guarded by kmsan_in_runtime(), which is
> > currently implemented as:
> >
> >   static __always_inline bool kmsan_in_runtime(void)
> >   {
> >           if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
> >                   return true;
> >           return kmsan_get_context()->kmsan_in_runtime;
> >   }
> >
> > I think the easiest way to fix the NMI situation would be adding "if
> > in_nmi() return true"?
>
> It might help to look through these threads:
>
> https://lore.kernel.org/lkml/20220916135953.1320601-1-keescook@chromium.o=
rg/
> https://lore.kernel.org/all/20220919201648.2250764-1-keescook@chromium.or=
g/

Sorry, I missed that letter, should have responded earlier.

> I wandered around attempting to deal with in_nmi(), etc. And in
> the end just drop the attempt to cover it. It's worth noting that
> copy_from_user_nmi() exists on 1 architecture and has exactly 1
> call-site...

It doesn't really matter for KASAN, because a missing addressability
check is a matter of missing some (possibly rare) bugs.
For KMSAN a missing initialization will result in false positives, and
we already started seeing them: show_opcodes() copies data to a local
and prints it, but without a call to kmsan_unpoison_memory() it will
result in error reports about opcodes[] being uninitialized.

So for this particular case I want to ensure kmsan_unpoison_memory()
can be called from NMI context (by removing the kmsan_in_runtime()
check from it), but to be on the safe side we'll also have to do
nothing in __msan_poison_alloca() under in_nmi().


> --
> Kees Cook


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
