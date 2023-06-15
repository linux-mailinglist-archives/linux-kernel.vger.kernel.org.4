Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E22731A80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjFONwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjFONwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:52:16 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270E1BDB;
        Thu, 15 Jun 2023 06:52:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-5ed99ebe076so28045276d6.2;
        Thu, 15 Jun 2023 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686837129; x=1689429129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTISzDzB0vgzRtUm+XOEwGTMkJ6kple5Xm92txPcOLI=;
        b=RZs0H0colKUY6LS5gf+N4I7AdqC+9xX4y/bW1RwfN8MKvImH+r1v1PQZOrCjrU5nDt
         FsUk19iGS4qcdIpaKZBzfFzR90IEsZjP/cmgrWjolhyNxJIjCNveCNZt5MBpOU6tmDR+
         +lKN+lRE7dBIjY+mEzP6T6/JzM1D6LKxM0hknfDMhsLHyLi59tSfMVeO2QADLNAmbJBA
         prgMVlzi1fUMkU5k9DAMfS7U60GbueV0mN084FuSbM5Fs11usiozcJdhfNJ/QaSQF9od
         tStbo7OYeHdy+A81I+BiQVRSrQaWoEASjqWMpT/A2DIg2Nowe1MxBxKkdvOhs07UtdaH
         SxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837129; x=1689429129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTISzDzB0vgzRtUm+XOEwGTMkJ6kple5Xm92txPcOLI=;
        b=OrilFSMvkc52fG0Umcp6evpEpvvv8LA7Q7i65Mz+5xBKi+QUn2LmKCR4oglDjW4NCp
         FLw3XFzg9hhM6ULoLwGIe+xNRc54TYTJ6S63JAcb2dpGWkzLsWAIA7idx0Re3JwUiO1c
         775dpY+IIQvTr4Gr3qqFVchvuYeRUJ8MGIdmHcgbCBdkWQambCW8xxfEWhZ9VuawWgGD
         F9NxHAzzGDwRO3RvryVxfUl6pKr+jBWj1OhCZoCeaLrY/pojYwWI8vCZDM/BANE8PKFr
         +qzSBzcNZbl2fRAwzQ69AwUKFZAqXtBRkXyOsM8pBtDucgmicE4EudXRID35KqwalyfE
         oxIg==
X-Gm-Message-State: AC+VfDzohLOvSwjid3+JM1wCvrHKbLu2dtUnF33Km5EwxMQkBsk+coYy
        FuJhe07UksAIGQwRu2Vdh0+Ztdu5EoM5FIpN3Yow4DzllKCGpQ==
X-Google-Smtp-Source: ACHHUZ7wjjBG8VxmyvEb3k5iTRCIsao8mEEup0Ly3jqvyGSn+EjEgNrTRbdDIWOSsKwflUDuWQFak/maSvKiVTp6mqQ=
X-Received: by 2002:ad4:5de3:0:b0:62f:ea09:7088 with SMTP id
 jn3-20020ad45de3000000b0062fea097088mr3600822qvb.27.1686837128707; Thu, 15
 Jun 2023 06:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com>
 <20230614074904.29085-8-herve.codina@bootlin.com> <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
 <20230614114214.1371485e@bootlin.com> <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
 <20230614223418.0d7e355d@bootlin.com> <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
 <20230615113512.07967677@bootlin.com>
In-Reply-To: <20230615113512.07967677@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 16:51:32 +0300
Message-ID: <CAHp75Vf2aR1x-Nf2+uUySyGH-p12YbP2Z=Ezbspqg==pCpRbOg@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:35=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:
> On Thu, 15 Jun 2023 01:05:40 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> Did the job using _Generic().

Cool! Keep my tag for that version and thank you for pursuing the
implementation that works for everybody.

> This lead to:
> --- 8< ---
> /*
>  * Remove a const qualifier

...from integer types

>  * _Generic(foo, type-name: association, ..., default: association) perfo=
rms a
>  * comparison against the foo type (not the qualified type).
>  * Do not use the const keyword in the type-name as it will not match the
>  * unqualified type of foo.
>  */
> #define __unconst_type_cases(type)              \

__unconst_integer_type_cases() ?

>         unsigned type:  (unsigned type)0,       \
>         signed type:    (signed type)0
>
>

Single blank line is enough.

> #define __unconst_typeof(x) typeof(                     \

__unconst_integer_typeof() ?

>         _Generic((x),                                   \
>                 char: (char)0,                          \
>                 __unconst_type_cases(char),             \
>                 __unconst_type_cases(short),            \
>                 __unconst_type_cases(int),              \
>                 __unconst_type_cases(long),             \
>                 __unconst_type_cases(long long),        \
>                 default: (x)))
>
> /*
>  * Do not check the array parameter using __must_be_array().
>  * In the following legit use-case where the "array" passed is a simple p=
ointer,
>  * __must_be_array() will return a failure.
>  * --- 8< ---
>  * int *buff
>  * ...
>  * min =3D min_array(buff, nb_items);
>  * --- 8< ---
>  *
>  * The first typeof(&(array)[0]) is needed in order to support arrays of =
both
>  * 'int *buff' and 'int buf[N]' types.
>  *
>  * The array can be an array of const items.
>  * typeof() keeps the const qualifier. Use __unconst_typeof() in order to
>  * discard the const qualifier for the __element variable.
>  */
> #define __minmax_array(op, array, len) ({                               \
>         typeof(&(array)[0]) __array =3D (array);                         =
 \
>         typeof(len) __len =3D (len);                                     =
 \
>         __unconst_typeof(__array[0]) __element =3D __array[--__len];     =
 \
>         while (__len--)                                                 \
>                 __element =3D op(__element, __array[__len]);             =
 \
>         __element; })
>
> /**
>  * min_array - return minimum of values present in an array
>  * @array: array
>  * @len: array length
>  *
>  * Note that @len must not be zero (empty array).
>  */
> #define min_array(array, len) __minmax_array(min, array, len)
>
> /**
>  * max_array - return maximum of values present in an array
>  * @array: array
>  * @len: array length
>  *
>  * Note that @len must not be zero (empty array).
>  */
> #define max_array(array, len) __minmax_array(max, array, len)
> --- 8< ---
>
> Do you think it looks good ?

Yes!

> For, the KUnit tests, I agree, it would be nice to have something.
> I need some more substantial work to implement and run the test in KUnit
> and the first task will be learning the KUnit test system.
> I will do that but out of this series.

Thank you, it's fine with me.

--=20
With Best Regards,
Andy Shevchenko
