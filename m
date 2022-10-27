Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE461002E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiJ0S16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiJ0S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:27:29 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F156C96C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:27:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o70so3244214yba.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkJRbeGgCZ6+aMV/WWBwtp3wD8MemKx2tm5yGavxfGs=;
        b=exIXHtdRfzzsFRcp4FGWpq1DR6KLkeXjaQaTyKUdQ4f4sosd+iXNOq3j73Dg0cZoxM
         p1t1ekHRKjr4sh7Gp9G4Mz92tFIq/yhByogz5OMhL+iVMwuLX4SgyN69cOBEaAZxW//j
         BlmyS40kXaXJvZPeoQCJ/u5DN/r0U+45qYkz+IZItOKKW8S/Y07ooZYpzl5XkItHYIRZ
         9LygTaawMypWQf4GJbhWp6I8vrPk44YaSBDUwlkildjWblqyXVSSKMSj7kOqV1ZUBqKt
         Bo83E8OzkmVACCE5OSD87R76OnrgmasUeZL74EEHgW68EhmQIudY3vNdqy5a8vYEg26K
         yN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkJRbeGgCZ6+aMV/WWBwtp3wD8MemKx2tm5yGavxfGs=;
        b=g4/O3hcLk/FIdHvwCWSk/U6AOOefFQQydxi2wn9JSH6lJIIiIggpBVd8LzaoLrITln
         dzEAEjYdJJk5yXmLP+ywmNK2ZXCUj9LHAe5tlkeN7SzdVIKfzpw+vWJW1VKF9zOy+4TB
         Qlc4HezzGqaxdWXqlwM+kTjoXQWMb5aUbA/PoEvQUjs9LB32MDtf5RKWTSgrUXocX3I1
         H29erJFnGXdHao5BOtKUz4RV+cjCWK672B09ZV8htv+qcH00/bgZGiBWVnUa6Ru7Sloy
         MfafZ319nTroKGo1fwnJMv1FcP5ZKnhwn1m3lMIFNAg0gKDCaYz+VWDKbPxBm/8wM+UR
         2I3w==
X-Gm-Message-State: ACrzQf1dd94imTSgwDEu4FUrChStXGT3JCSQBqxlng6V4F7W9mvglrLs
        dgon+pW8y/21hOzUbIHkJegQUt7gi/ttRLW4Am6Ynw==
X-Google-Smtp-Source: AMsMyM6O+LHzKzlgQsz+mKKGATNtn6T0dtBZB5DMyNFEPw8k9BzX0+L51VgYG8H7AWbW2yhNb/EIaj2sX5Kkc0PfnvA=
X-Received: by 2002:a25:e80d:0:b0:6cb:a59c:541b with SMTP id
 k13-20020a25e80d000000b006cba59c541bmr8461132ybd.388.1666895246845; Thu, 27
 Oct 2022 11:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221025221755.3810809-1-glider@google.com> <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
 <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com> <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Oct 2022 11:26:50 -0700
Message-ID: <CAG_fn=XESk1PPqbAVDqMdGbRwyvLvLQrm2hybr2cXaaYjfZEKA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
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

On Thu, Oct 27, 2022 at 1:05 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Wed, Oct 26, 2022 at 11:38:53AM -0700, Alexander Potapenko wrote:
> > A bigger issue from the NMI perspective is probably
> > having __msan_poison_alloca() inserted in every non-noinstr kernel
> > function, because that hook may acquire the stackdepot lock.
>
> *urgghhh* that's broken, that must not be. There is a *TON* of NMI
> functions that are non-noinstr.

__msan_poison_alloca() is guarded by kmsan_in_runtime(), which is
currently implemented as:

  static __always_inline bool kmsan_in_runtime(void)
  {
          if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
                  return true;
          return kmsan_get_context()->kmsan_in_runtime;
  }

I think the easiest way to fix the NMI situation would be adding "if
in_nmi() return true"?

Currently that will render kmsan_unpoison_memory() useless in NMI
context, but I think we don't need a check for kmsan_in_runtime()
there, because unpoisoning is self-contained and normally does not
recurse (guess we can tolerate a pr_err() on the rare assertion
violation path?)

> What's worse, it seems to do a memory allocation as well, and that's out
> the window with PREEMPT_RT where you can't do even GFP_ATOMIC from
> regular IRQ context.

Yes, there's a lazy call to alloc_pages() in lib/stackdepot.c that is
done when we run out of storage space.
It would be a pity to ignore everything that is happening inside
regular IRQs (by making kmsan_in_runtime() bail out on in_irq()) - I
think we occasionally see errors from there, e.g.
https://syzkaller.appspot.com/bug?id=3D233563e79a8e00f86412eb3d2fb4eb1f425e=
70c3
We could make stackdepot avoid allocating memory in IRQs/NMIs and hope
that calls to __msan_poison_alloca() from regular contexts keep up
with draining the storage from interrupts.
Another option would be to preallocate a very big chunk of memory for
stackdepot and never do allocations again.

These tricks won't however save us from acquiring depot_lock from
lib/stackdepot.c every time we want to create a new origin.
But that should not be a problem by itself, because we always do
kmsan_enter_runtime() before accessing the stack depot - i.e. it won't
be taken recursively.

Given that PREEMPT_RT is not the default at the moment, shall we make
KMSAN incompatible with it for the time being?

> That function is wholly unacceptable to be added to every kernel
> function.
>



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
