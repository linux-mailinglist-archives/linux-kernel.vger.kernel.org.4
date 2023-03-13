Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A26B7A54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCMO3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCMO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:29:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75F24134
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:29:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-540cb2fb5b9so140785057b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678717788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKWk2lA6kcgmQW/mPXhYLF0VgpMqFYUu2eJawxBUrc=;
        b=JsYGpUuuAx69bskMhPRqv35bAcYWS/hoIYaRo9DNZLzgl1Utp9qht4TTGAWdAQEbsf
         5UJxIBxJssi4Lqs01bKzAvX+MoGXit5rRaXgLxkVgnN7f1AED9uIfPAzCz/xZt8tAsm9
         mRZ3BawbmCm60zy91wZNRV3xPR1z6mLAakuqOfsEuT7clGpdo3KFgVwtliPaCU51V4qt
         EO4UrVB21S99Syng0gy+sj3NTmwckTm9oIL4bYv+iLzA4WqxAYRLZCYJvVO/6Ns3iG2P
         9OXop6CzXqYhlm1cmJ0ZBPc05a7i0r9lPDskicKJwOrW/LyFCtYmHaJrKqKjW0/HKsYp
         K7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UKWk2lA6kcgmQW/mPXhYLF0VgpMqFYUu2eJawxBUrc=;
        b=y6snmSWD9/r1JCXNnQtrsPllSg+KbvhjpUjzQ3lIb0T9Ihth+ofIgcEO8QPKUel9fO
         zW6xuDlzUk7PvIU9mzUEOFESVcUB9flToAxcWxEswB4w3Pr974RTgvtpXsqfNih6w3Hk
         1wss3SStN9O8n9ItSaskAuem3aFKGYZky9wXI0CJLBM4HkRq1jNp9KC07pN1coCh5Cem
         pL1wZDz8gij5eBierIIJKy3Y8Iw9kD0VQrue7xgSbr9khOhwtqYZbuu7Ld/3YRSR0IPN
         Kw1UwpgAfI22tyGGNFFPQfp0pppheGE45NaDvFEcnoyZTCxwjNoBHMBfBhHdwvOS1Qru
         +jxg==
X-Gm-Message-State: AO0yUKV/mq/qQlUtB8nyqqzPpkMU/0jPgApxOxz6hTDd/VAnGu6PwPG0
        OG5UE+Xd8DStkN4iwUZszJvlftyYL2pz8Rywk3xl+w==
X-Google-Smtp-Source: AK7set9+V74KeSz36D//IGW89NODCNRrVm8ctZWGiYSP3DdxCEfiOrL/e5qwPAaaztWcNGEAHyWBdw2UyDWyJW43tQ8=
X-Received: by 2002:a81:a989:0:b0:534:1d7:fcf0 with SMTP id
 g131-20020a81a989000000b0053401d7fcf0mr22797541ywh.1.1678717787629; Mon, 13
 Mar 2023 07:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
 <20230312175703.d8d8e0192387dfa9592ee8e5@linux-foundation.org> <CR55BD4YCDR1.22R5TLYJW6YS0@vincent-arch>
In-Reply-To: <CR55BD4YCDR1.22R5TLYJW6YS0@vincent-arch>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 13 Mar 2023 07:29:35 -0700
Message-ID: <CAJuCfpETYdLRigLTHe6HHQrC5vy5MmDc=HPsuMc6UKEzfr22ZA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the
 vm_flags in vm_area_struct
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        Liam.Howlett@oracle.com, jhubbard@nvidia.com, david@redhat.com,
        willy@infradead.org, linux-kernel-mentees@lists.linuxfoundation.org
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

On Mon, Mar 13, 2023 at 2:25=E2=80=AFAM Vincenzo Palazzo
<vincenzopalazzodev@gmail.com> wrote:
>
> On Mon Mar 13, 2023 at 1:57 AM CET, Andrew Morton wrote:
> > On Sun, 12 Mar 2023 23:42:50 +0100 Vincenzo Palazzo <vincenzopalazzodev=
@gmail.com> wrote:
> >
> > > With 6.3-rc1 is not possible to build the following drivers
> >
> > Well, let's cc Suren who actually wrote bc292ab00f6c ("mm: introduce
> > vma->vm_flags wrapper functions").
> >
> > > - nvidia, that the compilation returns the following errors
> > >
> > > - vboxhost/7.0.6_OSE where the build fails with the following errors
> > >
> > > ...
> > >
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -497,7 +497,7 @@ struct vm_area_struct {
> > >      * To modify use vm_flags_{init|reset|set|clear|mod} functions.
> > >      */
> > >     union {
> > > -           const vm_flags_t vm_flags;
> > > +           vm_flags_t vm_flags;
> > >             vm_flags_t __private __vm_flags;
> > >     };
> >
> > These out-of-tree drivers should be converted to use the wrappers which
> > bc292ab00f6c added.  Their maintainers have a couple of months to do
> > this before bc292ab00f6c is released in 6.3.
>
> Yeah I thought about that! nvidia update as soon as the 6.3 is out, not s=
ure
> about vboxhost. But let the driver update to this new feature make sense.
>
> >
> > It's unfortunate.  I guess it would be better if we were to find a way
> > to permit these drivers to compile OK but to generate warnings, as an
> > interim thing for six months or so.  Perhaps there's some clever way.
>
> Yeah it is! Regarding giving the possiblity to compile ok (and
> preserving the previous behavior) look like an interesting thought for
> kernel API, but am I think that it this is difficult to do?
>
> The real things that I'm missing with the new wrapper API
> is the meaning of the new `vm_flags_t vm_flags`, before the
> field was only one and it was getting modified, but now the real
> value is the private one `__vm_flags`, so what is the meaning of
> the new `vm_flags`?

Sorry for the delay. I'm on vacation until Wednesday and have limited
network access.
vm_flags is used as a read-only property so that readers of the flags
don't have to change, however flag modifiers should be using new
wrapper functions. Fixing the errors in this report should be trivial.
For example:
vma->vm_flags |=3D VM_IO | VM_PFNMAP | VM_DONTEXPAND;
should be replaced with
vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND);
and
vma->vm_flags &=3D ~VM_MAYWRITE;
with
vm_flags_clear(vma, VM_MAYWRITE);

Thanks,
Suren.

>
> I feel that this question is stupid but I can not avoid do it, otherwise
> my mind think about it till I will not find an answer :)
>
> P.S: regaring the warning at compile time the __deprecated looks a good
> fit to generate error message, but to me in this particular case do not.
>
> Thanks,
>
> Vincent.
>
