Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBDC6BB366
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjCOMoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjCOMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:43:55 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABFA4B25
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:42:39 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416b0ab0ecso236354717b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678884157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VGLSkdp/JfsirR3LcEkkmvJURH6d1IHkRJNqZm1w8Y=;
        b=DgCbHHIojs4W+B/kKCCmnVxjfrPt0ghOPhwtubZBlgXR4eLixWwRyqhbNTiR/blH3m
         SwQYW9wwAq8gzEhMN9cb7Ktv288mbgsCKuzUM+U1BWgnZSTHEH/bDa0kiqu+MFvhUuMu
         aZ/7W8gMt9K5f8gPhpLyVzVjC18RRo3ibKGbO4xMD4CZoKNDnWcYAiXw2rW10c/F1chF
         9+rdv4HeRaOYril947tu7u/q+kxJJFYltPCoyjvmJ3w2uEQPwTWQjZuoKM9JiXmUKJck
         d2oykOomDKm6BBdjiiryU3iEBrII/72pF725ibQryYgIvU/dKQEgeX8GvQeQ7nKJ+wgC
         Grzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VGLSkdp/JfsirR3LcEkkmvJURH6d1IHkRJNqZm1w8Y=;
        b=lxbL6fju5sJn1ntJkkIxYYJvgnkB1UCIC9gjOeVKrh4asnjRWS9Rs7/hcmB/GIdsy4
         doW5WdabXDJqXIpmGyl+OZf5xmk768hmdmrFKF1llcf5ITX06aayklhO9MAeKyJv3pIh
         1ZhoFwIESzooYWazD4rejSgpjo95zW1dipcRdtCt12ncFRdOlh1mRGMr9IrslxGs7Gdq
         Z3w6CXyFWkArIYNg9IUarF8skpluU10Bwult7LqvropYV6/4DJCI6buId5uNoqGrWvTs
         ME3Nan4OLVX/KsLGkkXNP87fuC5S0XVRoTR4PW0A5vY4qgp+hST9S76lv/f3bStikRCb
         b6sg==
X-Gm-Message-State: AO0yUKURxj0LuMudE572bR5UYJwMzvnniH7sWsm5a5Peyi9v4O8/pbh/
        Rm/glv7Dxj+O0fzJBHPN2WlGndiC+dPFCpZA3Ns=
X-Google-Smtp-Source: AK7set9QWh4rEF1YKbvqoa2ilXNWQCmrK+TELEvrOh6X23xhP6MgVxdDAOANSoJ9/iDo1VmN6whwBrI1rdfHr+1GiOo=
X-Received: by 2002:a81:4424:0:b0:536:3c2c:bf5e with SMTP id
 r36-20020a814424000000b005363c2cbf5emr27266149ywa.8.1678884156776; Wed, 15
 Mar 2023 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
 <5e192700-c54a-04cf-a223-281af7af0457@amd.com> <CAEzXK1qPjYxDiRVTy8McXbagC8JKgtu+C0E+-VP3NHZvtYdZ+g@mail.gmail.com>
 <ce410155-1052-cd0a-60bf-2807e6376ddd@amd.com>
In-Reply-To: <ce410155-1052-cd0a-60bf-2807e6376ddd@amd.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 15 Mar 2023 12:42:26 +0000
Message-ID: <CAEzXK1qOPCDevS2KgpySZnrwSLeX20fFZBv-i+O-xTWwV8-i9w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit architectures
To:     Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        akpm@linux-foundation.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll give it a try this weekend.

Lu=C3=ADs

On Fri, Mar 10, 2023 at 1:15=E2=80=AFPM Arunpravin Paneer Selvam
<arunpravin.paneerselvam@amd.com> wrote:
>
>
>
> On 3/9/2023 3:42 PM, Lu=C3=ADs Mendes wrote:
> > Hi,
> >
> > Ping? This is actually a regression.
> > If there is no one available to work this, maybe I can have a look in
> > my spare time, in accordance with your suggestion.
> >
> > Regards,
> > Lu=C3=ADs
> >
> > On Tue, Jan 3, 2023 at 8:44=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >> Am 25.12.22 um 20:39 schrieb Lu=C3=ADs Mendes:
> >>> Re-sending with the correct  linux-kernel mailing list email address.
> >>> Sorry for the inconvenience.
> >>>
> >>> The proposed patch fixes the issue and allows amdgpu to work again on
> >>> armhf with a AMD RX 550 card, however it may not be the best solution
> >>> for the issue, as detailed below.
> >>>
> >>> include/log2.h defined macros rounddown_pow_of_two(...) and
> >>> roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
> >>> architectures (tested on armv9 armhf machine) causing
> >>> drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
> >>> value, thus impeding amdgpu to load properly (no GUI).
> >>>
> >>> One option is to modify rounddown_pow_of_two(...) to detect if the
> >>> variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u3=
2
> >>> n) or if the variable takes more space than 32 bits, then call
> >>> __rounddown_pow_of_two_u64(u64 n). This would imply renaming
> >>> __rounddown_pow_of_two(unsigne
> >>> d long n) to
> >>> __rounddown_pow_of_two_u32(u32 n) and add a new function
> >>> __rounddown_pow_of_two_u64(u64 n). This would be the most transparent
> >>> solution, however there a few complications, and they are:
> >>> - that the mm subsystem will fail to link on armhf with an undefined
> >>> reference on __aeabi_uldivmod
> >>> - there a few drivers that directly call __rounddown_pow_of_two(...)
> >>> - that other drivers and subsystems generate warnings
> >>>
> >>> So this alternate solution was devised which avoids touching existing
> >>> code paths, and just updates drm_buddy which seems to be the only
> >>> driver that is failing, however I am not sure if this is the proper
> >>> way to go. So I would like to get a second opinion on this, by those
> >>> who know.
> >>>
> >>> /include/linux/log2.h
> >>> /drivers/gpu/drm/drm_buddy.c
> >>>
> >>> Signed-off-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> >>>> 8------------------------------------------------------8<
> >>> diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
> >>> linux-nextLM/drivers/gpu/drm/drm_buddy.c
> >>> --- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
> >>> 16:29:26.000000000 +0000
> >>> +++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
> >>> 17:04:32.136007116 +0000
> >>> @@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
> >>>            unsigned int order;
> >>>            u64 root_size;
> >>>
> >>> -        root_size =3D rounddown_pow_of_two(size);
> >>> +        root_size =3D rounddown_pow_of_two_u64(size);
> >>>            order =3D ilog2(root_size) - ilog2(chunk_size);
> >> I think this can be handled much easier if keep around the root_order
> >> instead of the root_size in the first place.
> >>
> >> Cause ilog2() does the right thing even for non power of two values an=
d
> >> so we just need the order for the offset subtraction below.
> Could you try with ilog2() and see if you are getting the right value
> for size as suggested
> by Christian.
>
> Thanks,
> Arun
> >>
> >> Arun can you take a closer look at this?
> >>
> >> Regards,
> >> Christian.
> >>
> >>>            root =3D drm_block_alloc(mm, NULL, order, offset);
> >>> diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux=
/log2.h
> >>> --- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 =
+0000
> >>> +++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.31990149=
2 +0000
> >>> @@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
> >>>    }
> >>>
> >>>    /**
> >>> + * __roundup_pow_of_two_u64() - round up to nearest power of two
> >>> + * (unsgined 64-bits precision version)
> >>> + * @n: value to round up
> >>> + */
> >>> +static inline __attribute__((const))
> >>> +u64 __roundup_pow_of_two_u64(u64 n)
> >>> +{
> >>> +    return 1ULL << fls64(n - 1);
> >>> +}
> >>> +
> >>> +
> >>> +/**
> >>>     * __rounddown_pow_of_two() - round down to nearest power of two
> >>>     * @n: value to round down
> >>>     */
> >>> @@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
> >>>    }
> >>>
> >>>    /**
> >>> + * __rounddown_pow_of_two_u64() - round down to nearest power of two
> >>> + * (unsgined 64-bits precision version)
> >>> + * @n: value to round down
> >>> + */
> >>> +static inline __attribute__((const))
> >>> +u64 __rounddown_pow_of_two_u64(u64 n)
> >>> +{
> >>> +    return 1ULL << (fls64(n) - 1);
> >>> +}
> >>> +
> >>> +/**
> >>>     * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigne=
d value
> >>>     * @n: parameter
> >>>     *
> >>> @@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
> >>>        __ilog2_u64(n)            \
> >>>     )
> >>>
> >>> +
> >>>    /**
> >>>     * roundup_pow_of_two - round the given value up to nearest power =
of two
> >>>     * @n: parameter
> >>> @@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
> >>>     )
> >>>
> >>>    /**
> >>> + * roundup_pow_of_two_u64 - round the given value up to nearest powe=
r of two
> >>> + * (unsgined 64-bits precision version)
> >>> + * @n: parameter
> >>> + *
> >>> + * round the given value up to the nearest power of two
> >>> + * - the result is undefined when n =3D=3D 0
> >>> + * - this can be used to initialise global variables from constant d=
ata
> >>> + */
> >>> +#define roundup_pow_of_two_u64(n)            \
> >>> +(                        \
> >>> +    __builtin_constant_p(n) ? (        \
> >>> +        ((n) =3D=3D 1) ? 1 :        \
> >>> +        (1ULL << (ilog2((n) - 1) + 1))    \
> >>> +                   ) :        \
> >>> +    __roundup_pow_of_two_u64(n)            \
> >>> + )
> >>> +
> >>> +
> >>> +/**
> >>>     * rounddown_pow_of_two - round the given value down to nearest po=
wer of two
> >>>     * @n: parameter
> >>>     *
> >>> @@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
> >>>        __rounddown_pow_of_two(n)        \
> >>>     )
> >>>
> >>> +/**
> >>> + * rounddown_pow_of_two_u64 - round the given value down to nearest
> >>> power of two
> >>> + * (unsgined 64-bits precision version)
> >>> + * @n: parameter
> >>> + *
> >>> + * round the given value down to the nearest power of two
> >>> + * - the result is undefined when n =3D=3D 0
> >>> + * - this can be used to initialise global variables from constant d=
ata
> >>> + */
> >>> +#define rounddown_pow_of_two_u64(n)            \
> >>> +(                        \
> >>> +    __builtin_constant_p(n) ? (        \
> >>> +        (1ULL << ilog2(n))) :        \
> >>> +    __rounddown_pow_of_two_u64(n)        \
> >>> + )
> >>> +
> >>>    static inline __attribute_const__
> >>>    int __order_base_2(unsigned long n)
> >>>    {
>
