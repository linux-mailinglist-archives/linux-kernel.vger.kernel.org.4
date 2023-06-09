Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6F72A28D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjFISta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFISt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:49:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618435BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:49:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so2113649276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686336566; x=1688928566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47hM/v+QZxvnVK74bWWvbJeOQ2E4i6wacwL5YIkMLEg=;
        b=UcINZCYlQn9jT6iQbpolxaGdnCWj60OH8RAFAQZXvGk42wLQRPLqLmQObUawLwoC3R
         qZilc087POIhw1xtrqqJ9qwowoAXGDE1uuTGJP0G8b2CihJXgxcp/ZmpGDL0KINbFCeA
         G/y9yD+TzK/Vt+3Ieak5cMhVoZHAVU+SmHJcbe+bHpp8j5JH3G7cQteocwiJcWHrmEaT
         ya4bYcnTmiW782CXDI/g1DF8zcWJHokNAsZzVFp503O9unslh75RD7kALCFIqdLy2RmB
         qP4gfA0ffBNfZqROzi107ne6nCi+Rcjr2ye/jNDbo15fN7lW1g1qqOIX07RjWxYIi09b
         N9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336566; x=1688928566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47hM/v+QZxvnVK74bWWvbJeOQ2E4i6wacwL5YIkMLEg=;
        b=YUD25p55bPJO1oF/Dwe6CCPMhOQ0/mD48RrMKV9EJ8p2V/geo/1zX+En5mmfv2vj4Q
         n7jXo2LbkZlj1S1XqKe03XC+OsXqhgx9v38KTKwbjViNrEcAOxCDKgWD6liI5iAAjZHO
         q/UQejGQ0N7a8bU8tl2hC0/hkuXse8tb1N1Z4wTKRaaDH0LpfrKaNam93J5fDApPINaa
         jj5pNrEciskgkXzpxUepErph68lFjoKDx76FQT358AB4nj+/xPRVAlOOVwb6bQ7YDI4e
         jbOnPcrxtWKvHxesNdHRH/ILCNeUjeyBd6r7aYt4Hv8WfyWJk7fUZL5i5UN5pKXMION5
         pp/w==
X-Gm-Message-State: AC+VfDxyVfkfOHuJu5n9nNMuKQe6UuwRi47o81yZN1yzDsvqBgClAiXX
        8S1dWNsJvMJu/wMGsZ2kWzfsSxX/SUR/LjUe6SO/lw==
X-Google-Smtp-Source: ACHHUZ7WhhAFE/R8XFcrZUcmY3jg9V9be+MwvSLJ+D6K1ydexQxR6GT4BFG+SiObVqSHLnQlGwnr7OoNBRi2vDIUOIU=
X-Received: by 2002:a25:d341:0:b0:bb3:91a7:950a with SMTP id
 e62-20020a25d341000000b00bb391a7950amr65519ybf.10.1686336565721; Fri, 09 Jun
 2023 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-6-surenb@google.com>
 <ZIM/O54Q0waFq/tx@casper.infradead.org>
In-Reply-To: <ZIM/O54Q0waFq/tx@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 11:49:14 -0700
Message-ID: <CAJuCfpE4VYz-Z4_aS3d9-8FGtQ-F4f7adYcJqRk3P3Ks7WPgQA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Jun 08, 2023 at 05:51:57PM -0700, Suren Baghdasaryan wrote:
> >  static inline bool folio_lock_or_retry(struct folio *folio,
> > -             struct mm_struct *mm, unsigned int flags)
> > +             struct vm_area_struct *vma, unsigned int flags,
> > +             bool *lock_dropped)
>
> I hate these double-return-value functions.
>
> How about this for an API:
>
> vm_fault_t folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
> {
>         might_sleep();
>         if (folio_trylock(folio))
>                 return 0;
>         return __folio_lock_fault(folio, vmf);
> }
>
> Then the users look like ...
>
> > @@ -3580,8 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(=
struct vm_fault *vmf)
> >       if (!folio_try_get(folio))
> >               return 0;
> >
> > -     if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
> > +     if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) =
{
> >               folio_put(folio);
> > +             if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +                     return VM_FAULT_VMA_UNLOCKED | VM_FAULT_RETRY;
> >               return VM_FAULT_RETRY;
> >       }
>
>         ret =3D folio_lock_fault(folio, vmf);
>         if (ret)
>                 return ret;
>
> > @@ -3837,9 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               goto out_release;
> >       }
> >
> > -     locked =3D folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
> > -
> > -     if (!locked) {
> > +     if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) =
{
> > +             if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +                     ret |=3D VM_FAULT_VMA_UNLOCKED;
> >               ret |=3D VM_FAULT_RETRY;
> >               goto out_release;
> >       }
>
>         ret |=3D folio_lock_fault(folio, vmf);
>         if (ret & VM_FAULT_RETRY)
>                 goto out_release;
>
> ie instead of trying to reconstruct what __folio_lock_fault() did from
> its outputs, we just let folio_lock_fault() tell us what it did.

Thanks for taking a look!
Ok, I think what you are suggesting is to have a new set of
folio_lock_fault()/__folio_lock_fault() functions which return
vm_fault_t directly, __folio_lock_fault() will use
__folio_lock_or_retry() internally and will adjust its return value
based on __folio_lock_or_retry()'s return and the lock releasing rules
described in the comments for __folio_lock_or_retry(). Is my
understanding correct?
