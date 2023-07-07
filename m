Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BE74B79B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGGUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:03:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8C1FE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:03:25 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c6833e6e326so2563819276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688760204; x=1691352204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiYXPeVVhPYiIi5FqOxRE62I4iZJmKF5ifkdaBLEcDA=;
        b=0aTqwR/dpi0vpYuL7RdUssVpIH0lUmB7Xo91oQVnf+ilkQDF98MAWO0vCOgJKJskml
         HDbMD8n4sTjxGTKqIrLBS+zpYcFfkT7M5RxXAUFaZ4RiffjjlN1JI7lYDC6Z1wUBEOyE
         bCstYIYNMrmLVmCEvJmDg8oJyJ4pE/rRVwfx3rgVXQIWDsf1LC+nuTul0LXi2F/5rl9F
         Fh2d5JBeZfwz0TT+GS7rDI07SGX5MnjlPhfVvpjOQzlp/ww+KftyoZX1hxmwuomie533
         6qez7jIIBW0ZBqRpRUT/ZMWM47LVk+VMAnvg3VAlbRS46l6F//g2kgJFK6uV8Qskg84V
         5zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688760204; x=1691352204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiYXPeVVhPYiIi5FqOxRE62I4iZJmKF5ifkdaBLEcDA=;
        b=FWh1g+oMGHQQzIhSMaRMCZENdyHQaf+O2tfe6Xp8VqBiQ6T81SyB9U25MihiAlEtpX
         shS4SiPbnK3EUtIYjFbY886F1DFgj8tD1kv9U3A+CvxrUzLWH5iosonAgjQ7EEJK4jsy
         8BbWAaR6xxemid5pii20rqtmB7yCRAmEiLeHOaIt7edQxdQgp7R2vHOWmnTxjIcTW1Mv
         Vhdl6R9yf2jF41RgX6QWHNUT2fofZUo84PYckspd8xr7sPLC1AoAG9xwuLt3ew28btaY
         daQuwX3iBIYRmSVoUqVtmahN3Yt2eTPjKYMbq6rgIJhQj/hpfUeK/7trF0v6As36z7xS
         z8XQ==
X-Gm-Message-State: ABy/qLaTkGZmkYFfUL5epPqBIvzd4yEPrvTRirabv2riS6e3BWcZ8vo/
        wU5xT5p9TND8Sa9Hs0XOg5InKOq+Op2LH+F+MKEU7g==
X-Google-Smtp-Source: APBJJlGW6vzwmyM80moGDJZ2wgLQhm/Wo3bCA3iZE7mjjt+A012sDA18VUZL6P8nzQcPyYNuTqQi5GzZBXcfIV+8ic8=
X-Received: by 2002:a5b:44a:0:b0:c0b:7483:5cf0 with SMTP id
 s10-20020a5b044a000000b00c0b74835cf0mr4783782ybp.65.1688760204437; Fri, 07
 Jul 2023 13:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230707043211.3682710-1-surenb@google.com> <20230707122750.f7cd77fe19b625cff37423ed@linux-foundation.org>
In-Reply-To: <20230707122750.f7cd77fe19b625cff37423ed@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Jul 2023 20:03:13 +0000
Message-ID: <CAJuCfpEjMQfcPRLdCtFbDWr5jYKOwo5wwaVkHLYz7fRGmsne9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: lock a vma before stack expansion
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com
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

On Fri, Jul 7, 2023 at 7:27=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  6 Jul 2023 21:32:10 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > With recent changes necessitating mmap_lock to be held for write while
> > expanding a stack, per-VMA locks should follow the same rules and be
> > write-locked to prevent page faults into the VMA being expanded. Add
> > the necessary locking.
>
> What are the possible runtime effects of this change?

During the stack expansion concurrent page faults would have to wait
and visa versa (stack expansion would have to wait if there are
ongoing page faults). I think it's the same runtime effects as the
recent similar change requiring mmap_lock to be write lock before
stack expansion.

>
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1977,6 +1977,8 @@ static int expand_upwards(struct vm_area_struct *=
vma, unsigned long address)
> >               return -ENOMEM;
> >       }
> >
> > +     /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > +     vma_start_write(vma);
> >       /*
> >        * vma->vm_start/vm_end cannot change under us because the caller
> >        * is required to hold the mmap_lock in read mode.  We need the
> > @@ -2064,6 +2066,8 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >               return -ENOMEM;
> >       }
> >
> > +     /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > +     vma_start_write(vma);
> >       /*
> >        * vma->vm_start/vm_end cannot change under us because the caller
> >        * is required to hold the mmap_lock in read mode.  We need the
> > --
> > 2.41.0.255.g8b1d071c50-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
