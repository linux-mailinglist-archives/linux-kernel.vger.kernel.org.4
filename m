Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D4708BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjERWwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjERWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:52:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1955E69
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:52:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso3024a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684450335; x=1687042335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWnUteL7v7/EAzuWn1drf3iWgiZd3P6BMPM7r3CRrU4=;
        b=p1QNWoXOV1xgKiAp3Uawa5ywP62PFwgqLlo1IX/Z7lbukYiaO8h726vLk1ksYI/7qK
         SMove0r+bWiZcvsiSYWZVvJStA74wecehJFZuXtuZYpVjAd5Xlsi2RjcYi7IHBrmOv7i
         yzKLfoDu7FGmybhsjsdzoQ8+9IPnyeexOugE2vYPc8H+CF77m1kr5AMWA0qoQIpVvUeK
         sftIpAXu/jlLnagqS/IEHrCGZFL3YaUrmtF/yOHMwzEYlCPnOXXqpTnBBR/ORpDE38EB
         3+IEJL2Q7VHbtlApuj2xkqYqRwVdFB0cMzSDD/LVhIzYEr1abR+8elMLu/GsxPG1m3us
         Utsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684450335; x=1687042335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWnUteL7v7/EAzuWn1drf3iWgiZd3P6BMPM7r3CRrU4=;
        b=eeBgGMEU5jsS8+yc7Be5benmZrfgh6wJtEjooW3xGDch2BbjcjSJHBRrsbszytDVs7
         aBB71+0FB2ZZxyTd6yfKyNGv2h0hA50LtnnZe3jZg37a3xFo7M73VdRuLE+PI4LMCBYA
         Nx/vHIOgUZr3IVHnVbGtTFY9uuVXhcsh8vXwXooLx5KLTmfvlS17u0V/5KDUbawvXQIJ
         4SKFnmQ4hp52Beroi1pM0FyYmcyza5w9yKK87o9z3Jna9EAkmK9QgGarvjeCC7Jl/yKC
         Ce8bR7TPvhF9aDgRcVoU1zqo83nlKS0l4wsTwiTkVmPsxivuYJVEozXqZTzC7l6Hueoi
         piGg==
X-Gm-Message-State: AC+VfDzzZk+knNUq6tKzpt6juNnkDuDF+6SSM2zErYm/+1WSmil3cWAq
        agN7MNnJX/RU5ITtMh40t/16T30wwxBEO3r5CSxyBw==
X-Google-Smtp-Source: ACHHUZ58Y4oMqMeXjqbXsW1ohvNxVWhDEQwCHRAmPCAwpg14J9f/4DWK5igsACs1JEnPwKg/pJtqoSJ6YjSrESVBaLo=
X-Received: by 2002:a50:aac5:0:b0:502:2af:7b1d with SMTP id
 r5-20020a50aac5000000b0050202af7b1dmr18114edc.3.1684450334862; Thu, 18 May
 2023 15:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-3-jeffxu@chromium.org>
 <6dbbc3da-78c9-8101-d52a-0be47da9d67e@intel.com>
In-Reply-To: <6dbbc3da-78c9-8101-d52a-0be47da9d67e@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 18 May 2023 15:51:38 -0700
Message-ID: <CALmYWFtu-WzOTEs2aWU3zMW=KZUjaaL7OTE7hQtHjfwQfQNyEA@mail.gmail.com>
Subject: Re: [PATCH 2/6] PKEY: Add arch_check_pkey_enforce_api()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
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

On Thu, May 18, 2023 at 2:43=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > +static inline int __arch_check_vma_pkey_for_write(struct vm_area_struc=
t *vma)
> > +{
> > +     int pkey =3D vma_pkey(vma);
> > +
> > +     if (mm_pkey_enforce_api(vma->vm_mm, pkey)) {
> > +             if (!__pkru_allows_write(read_pkru(), pkey))
> > +                     return -EACCES;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Please think very carefully about what I'm about to say:
>
> What connects vma->vm_mm to read_pkru() here?
>
> Now think about what happens when we have kthread_use_mm() or a ptrace()
> doing get_task_mm() and working on another process's mm or VMA.
>
> Look at arch_vma_access_permitted() and notice how it avoids read_pkru()
> for 'foreign' aka. 'remote' accesses:
>
> > static inline bool arch_vma_access_permitted(struct vm_area_struct *vma=
,
> >                 bool write, bool execute, bool foreign)
> > {
> ...
> >         if (foreign || vma_is_foreign(vma))
> >                 return true;
> >         return // check read_pkru()
> > }
>
> In other words, it lets all remote accesses right through.  That's
> because there is *NOTHING* that fundamentally and tightly connects the
> PKRU value in this context to the VMA or the context that initiated this
> operation.
>
> If your security model depends on PKRU protection, this 'remote'
> disconnection is problematic.  The PKRU enforcement inside the kernel is
> best-effort.  That usually doesn't map into the security space very well.
>
> Do you have a solid handle on all call paths that will reach
> __arch_check_vma_pkey_for_write() and can you ensure they are all
> non-remote?

Is this about the attack scenario where the attacker uses ptrace()
into the chrome process ? if so it is not in our threat model, and
that is more related to sandboxing on the host.

Or is this about io_uring? Yes, io_uring kernel thread breaks our
expectations of PKRU & user space threads, however I thought the break
is not just for this - any syscall involved in memory operation will
break after into io_uring ?

Other than those, yes, I try to ensure the check is only used at the
beginning of syscall entry in all cases, which should be non-remote I
hope.

Thanks
-Jeff
