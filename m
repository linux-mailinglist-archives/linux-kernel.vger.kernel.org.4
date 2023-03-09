Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B556B2100
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCIKNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCIKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:13:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE450E63EF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:12:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j3so765084wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678356762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzmhJXXqsUPDGL1OfCiiuwjtuR41HcUClODCqGGbdEM=;
        b=NVVDEda1/qMXLn8YSl+LtedOKO7jvbY7PxhboOczPwrk5BZp5OVPud+YXpbT9ChSZW
         1L1W2di9cPXZnq2BHdbq1ei3BbXeQYgR9wJRI50pA/l1SbmHKubz4r3dXXBO2efJtstn
         xPHHN/QwHa/eHb9OZgOahNDqlXcOmt4Gm8SqNqfFEIOqZTYcjQXvYDliFFu0xkLOorIs
         EoSUseoSkXs7IS0calUwmZFxSMdHU2lwyLArYswvia0w/uk5SxO1ZmhjP9URYN8H5Pc5
         crLA3Nt0f+sa5ps9ps1gO5e/OrCLcg1yBr7kkgUW9CjPscFJvlVpxheDv2U4MG6F9xxI
         Clxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzmhJXXqsUPDGL1OfCiiuwjtuR41HcUClODCqGGbdEM=;
        b=R3J6yB4nKdTHB3grbqpBBFVXHYKiEGX3huwqEOaIZrBAn0Y919QR8C3H6k4cB4oxwD
         YOUQzykhkRzx1pHS1qj03nIWM7Wru8idJ8hhFH+sr7zyKwUzWGcysnhqKuxnZ7SN6WZ/
         lEnHI5iHwHG+5xegPOQ+dBo8J/MQUFEkHnqz2M/VUhs17Cu465uvua3KlmWBx6FhTSmG
         hpmFoZuGsRyn/ipjTxpuBkNDRLIJcH80f5pL8Yd8/EcjEF77RDsFj4Tdjst6iJEeCmAi
         PmaZNcRqa7C5MKZMxJwUuoe7DDTjdeZQ7FW997l+Ty3VxtszOc/FD1w+Cbk+vSE1MiFz
         If5w==
X-Gm-Message-State: AO0yUKVP4DuduNKTEpx8isEz8tcC/Ph0vRyFbap7AA+Gkpqc44Uj0RGP
        /v2NnFO//Zfekpzen7xZ04xZln3ntHJGbnzgGV0=
X-Google-Smtp-Source: AK7set8eZ9De3LSiDswOXLUZ1DkYKJ+n+tIQmaOs/8atrNCbBD/yLCdPW/TPLy0hXBbVLnhYdzQNFNtQoYJ/hEjYSPM=
X-Received: by 2002:a05:600c:a:b0:3e2:1fd8:887 with SMTP id
 g10-20020a05600c000a00b003e21fd80887mr4890489wmc.2.1678356762233; Thu, 09 Mar
 2023 02:12:42 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
 <5e192700-c54a-04cf-a223-281af7af0457@amd.com>
In-Reply-To: <5e192700-c54a-04cf-a223-281af7af0457@amd.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 9 Mar 2023 10:12:30 +0000
Message-ID: <CAEzXK1qPjYxDiRVTy8McXbagC8JKgtu+C0E+-VP3NHZvtYdZ+g@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit architectures
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     akpm@linux-foundation.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
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

Hi,

Ping? This is actually a regression.
If there is no one available to work this, maybe I can have a look in
my spare time, in accordance with your suggestion.

Regards,
Lu=C3=ADs

On Tue, Jan 3, 2023 at 8:44=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 25.12.22 um 20:39 schrieb Lu=C3=ADs Mendes:
> > Re-sending with the correct  linux-kernel mailing list email address.
> > Sorry for the inconvenience.
> >
> > The proposed patch fixes the issue and allows amdgpu to work again on
> > armhf with a AMD RX 550 card, however it may not be the best solution
> > for the issue, as detailed below.
> >
> > include/log2.h defined macros rounddown_pow_of_two(...) and
> > roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
> > architectures (tested on armv9 armhf machine) causing
> > drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
> > value, thus impeding amdgpu to load properly (no GUI).
> >
> > One option is to modify rounddown_pow_of_two(...) to detect if the
> > variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u32
> > n) or if the variable takes more space than 32 bits, then call
> > __rounddown_pow_of_two_u64(u64 n). This would imply renaming
> > __rounddown_pow_of_two(unsigne
> > d long n) to
> > __rounddown_pow_of_two_u32(u32 n) and add a new function
> > __rounddown_pow_of_two_u64(u64 n). This would be the most transparent
> > solution, however there a few complications, and they are:
> > - that the mm subsystem will fail to link on armhf with an undefined
> > reference on __aeabi_uldivmod
> > - there a few drivers that directly call __rounddown_pow_of_two(...)
> > - that other drivers and subsystems generate warnings
> >
> > So this alternate solution was devised which avoids touching existing
> > code paths, and just updates drm_buddy which seems to be the only
> > driver that is failing, however I am not sure if this is the proper
> > way to go. So I would like to get a second opinion on this, by those
> > who know.
> >
> > /include/linux/log2.h
> > /drivers/gpu/drm/drm_buddy.c
> >
> > Signed-off-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> >> 8------------------------------------------------------8<
> > diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
> > linux-nextLM/drivers/gpu/drm/drm_buddy.c
> > --- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
> > 16:29:26.000000000 +0000
> > +++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
> > 17:04:32.136007116 +0000
> > @@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
> >           unsigned int order;
> >           u64 root_size;
> >
> > -        root_size =3D rounddown_pow_of_two(size);
> > +        root_size =3D rounddown_pow_of_two_u64(size);
> >           order =3D ilog2(root_size) - ilog2(chunk_size);
>
> I think this can be handled much easier if keep around the root_order
> instead of the root_size in the first place.
>
> Cause ilog2() does the right thing even for non power of two values and
> so we just need the order for the offset subtraction below.
>
> Arun can you take a closer look at this?
>
> Regards,
> Christian.
>
> >
> >           root =3D drm_block_alloc(mm, NULL, order, offset);
> > diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux/l=
og2.h
> > --- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 +0=
000
> > +++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.319901492 =
+0000
> > @@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
> >   }
> >
> >   /**
> > + * __roundup_pow_of_two_u64() - round up to nearest power of two
> > + * (unsgined 64-bits precision version)
> > + * @n: value to round up
> > + */
> > +static inline __attribute__((const))
> > +u64 __roundup_pow_of_two_u64(u64 n)
> > +{
> > +    return 1ULL << fls64(n - 1);
> > +}
> > +
> > +
> > +/**
> >    * __rounddown_pow_of_two() - round down to nearest power of two
> >    * @n: value to round down
> >    */
> > @@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
> >   }
> >
> >   /**
> > + * __rounddown_pow_of_two_u64() - round down to nearest power of two
> > + * (unsgined 64-bits precision version)
> > + * @n: value to round down
> > + */
> > +static inline __attribute__((const))
> > +u64 __rounddown_pow_of_two_u64(u64 n)
> > +{
> > +    return 1ULL << (fls64(n) - 1);
> > +}
> > +
> > +/**
> >    * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned v=
alue
> >    * @n: parameter
> >    *
> > @@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
> >       __ilog2_u64(n)            \
> >    )
> >
> > +
> >   /**
> >    * roundup_pow_of_two - round the given value up to nearest power of =
two
> >    * @n: parameter
> > @@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
> >    )
> >
> >   /**
> > + * roundup_pow_of_two_u64 - round the given value up to nearest power =
of two
> > + * (unsgined 64-bits precision version)
> > + * @n: parameter
> > + *
> > + * round the given value up to the nearest power of two
> > + * - the result is undefined when n =3D=3D 0
> > + * - this can be used to initialise global variables from constant dat=
a
> > + */
> > +#define roundup_pow_of_two_u64(n)            \
> > +(                        \
> > +    __builtin_constant_p(n) ? (        \
> > +        ((n) =3D=3D 1) ? 1 :        \
> > +        (1ULL << (ilog2((n) - 1) + 1))    \
> > +                   ) :        \
> > +    __roundup_pow_of_two_u64(n)            \
> > + )
> > +
> > +
> > +/**
> >    * rounddown_pow_of_two - round the given value down to nearest power=
 of two
> >    * @n: parameter
> >    *
> > @@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
> >       __rounddown_pow_of_two(n)        \
> >    )
> >
> > +/**
> > + * rounddown_pow_of_two_u64 - round the given value down to nearest
> > power of two
> > + * (unsgined 64-bits precision version)
> > + * @n: parameter
> > + *
> > + * round the given value down to the nearest power of two
> > + * - the result is undefined when n =3D=3D 0
> > + * - this can be used to initialise global variables from constant dat=
a
> > + */
> > +#define rounddown_pow_of_two_u64(n)            \
> > +(                        \
> > +    __builtin_constant_p(n) ? (        \
> > +        (1ULL << ilog2(n))) :        \
> > +    __rounddown_pow_of_two_u64(n)        \
> > + )
> > +
> >   static inline __attribute_const__
> >   int __order_base_2(unsigned long n)
> >   {
>
