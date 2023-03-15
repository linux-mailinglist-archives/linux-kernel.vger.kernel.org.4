Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF26BBE83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCOVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjCOVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:07:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EA880E0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:06:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z11so12561925pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678914399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKYYaPT5Is0MJH9ud4+ebRYb/vJAs/FQRvpTFpyZc7Y=;
        b=Sq9sDYEUQPSqrreoT3iByu/xaaOclmqRZ4BZ8oTI6ZByIhmIYt4vvpr3yoyLDGEc+r
         Bh7IOxubKomnUk8OzozZQ84IitmdmnZsQeNtAJ2lXdUfFP5DQx6IFVUgsMIU0OOS1GEn
         FPbbthhFVHIMmx00Vm13rQJVZc3/Tal/GJLmF/rZjejSfB8bOAV2lIodf7JJX20QYHOw
         oHJtOJ+pfoeWsKBvIT/NfdUjCQ3mzBBmv9Ws33pREk6tO+zc12OhPo1kd21gxUjbIAol
         x925KwtHGn+x9bOAvOVy1icbNxQtwwmZ7JOZ9cim3RJ/aCQaSCjIUzPhfsYvQs0gad5O
         8z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKYYaPT5Is0MJH9ud4+ebRYb/vJAs/FQRvpTFpyZc7Y=;
        b=w1cVhKa+m9y1BsMK2Te2RRCMBi8HrcYy34Nzdzpl4f8HIfP8/NtC85SgIYbYi1UACA
         PT1ATgBm0cTu3SGBWGqkJ2MShKCQsIPBj+wy+s25XCEVYhFBthKM9HP+OhnaO+hBjqSa
         fz0zaU8w8VErEx8KifJJ7yn1HHASxlK8XdrVhYRhBLn0fODIeJCD3MGOPqAE5DBE65W4
         b42cCHTVBTO+MzATJQfqcyrxx/DD7jVG0EQQ+ihmmoaD5Nowr81yV72Pi7V6bT75GVcs
         hpjym7IuzA9G3jL0QFFrUVrOC7CsaxCai5U3OBVbwIYcf2BUfox/LCo9ql/0jDmXBkA6
         yqeQ==
X-Gm-Message-State: AO0yUKVAa+xtcTr80HMgVF4xycRbinCxpCBsugXoEEwyvj22qY+bUgS9
        HIyjNVXid0IQGVterWwfzGq5HZBc3oTMwAaZCmj7tdd2
X-Google-Smtp-Source: AK7set/vin/gH7uqM0zKWCc7qnMyrIM4uNDSSRFlUr2NYSPDlXh+VQAl1j6lpXoUOiTtYyPA3BhG/uIwYAg/RIHJzP4=
X-Received: by 2002:a05:6a00:2d0e:b0:625:dc5b:9d1d with SMTP id
 fa14-20020a056a002d0e00b00625dc5b9d1dmr550388pfb.0.1678914399119; Wed, 15 Mar
 2023 14:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230315171642.1244625-1-peterx@redhat.com>
In-Reply-To: <20230315171642.1244625-1-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Mar 2023 14:06:27 -0700
Message-ID: <CAHbLzkrUMztboKPKsbDjiiJDRuY6bTmix64Te_cXezE-ugxvog@mail.gmail.com>
Subject: Re: [PATCH] mm/thp: Rename TRANSPARENT_HUGEPAGE_NEVER_DAX to _UNSUPPORTED
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:16=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> TRANSPARENT_HUGEPAGE_NEVER_DAX has nothing to do with DAX.  It's set when
> has_transparent_hugepage() returns false, checked in hugepage_vma_check()
> and will disable THP completely if false.  Rename it to reflect its real
> purpose.

Makes sense to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/huge_mm.h | 2 +-
>  mm/huge_memory.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 70bd867eba94..9a3a3af2dd80 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -79,7 +79,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_f=
ault *vmf, pfn_t pfn,
>  }
>
>  enum transparent_hugepage_flag {
> -       TRANSPARENT_HUGEPAGE_NEVER_DAX,
> +       TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>         TRANSPARENT_HUGEPAGE_FLAG,
>         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b0ab247939e0..913e7dc32869 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -88,7 +88,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, uns=
igned long vm_flags,
>         /*
>          * If the hardware/firmware marked hugepage support disabled.
>          */
> -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER=
_DAX))
> +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUP=
PORTED))
>                 return false;
>
>         /* khugepaged doesn't collapse DAX vma, but page fault is fine. *=
/
> @@ -464,7 +464,7 @@ static int __init hugepage_init(void)
>                  * Hardware doesn't support hugepages, hence disable
>                  * DAX PMD support.
>                  */
> -               transparent_hugepage_flags =3D 1 << TRANSPARENT_HUGEPAGE_=
NEVER_DAX;
> +               transparent_hugepage_flags =3D 1 << TRANSPARENT_HUGEPAGE_=
UNSUPPORTED;
>                 return -EINVAL;
>         }
>
> --
> 2.39.1
>
