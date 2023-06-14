Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F72730A61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjFNWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjFNWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:06:19 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379792695;
        Wed, 14 Jun 2023 15:06:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62fd844ad58so11391706d6.2;
        Wed, 14 Jun 2023 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686780377; x=1689372377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt0E+gE2c9tWb/FVFSjcNFqAVT4Jc03x3okyqywpWl4=;
        b=O5SLdcqpfWwpVOckirFEmrcRZlcJj77388x4poZQKK/D06VAYUEuHV2EyAt209z5+T
         s+RSwLwuZymPaNUVfdzs1ZyQRJbv+5jAuusJig/2tVNs2h/L9rTCwYcYPNyPzK61utjK
         gAGoSQ9k5ooGmDMNt2JxBHzOUfbPY8ezsJX4pepO8WfGUMV9MMZKCDoZRc67DbZUHMeU
         GUSydhmVFoq1Z+91lyF3rYRzD0RWGRV3wRbb7Nt4icogluBOBeWheve7UhvyaLkwulLl
         rHxnEFjaj4rB+e0/JkZMhK49D7gDfcBd7cyequtKtZ76x8tAxf9xfnwAX703+1K/rU/2
         4Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686780377; x=1689372377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt0E+gE2c9tWb/FVFSjcNFqAVT4Jc03x3okyqywpWl4=;
        b=CQTAZNb0coeQZAHMAaNxikU7f9SkLIZFAJtDairr9hLC3zsB5YUaMccCyTNziqfAvw
         7NawsKVvl1brslQF8M8vG0rvKYR/SDlhrqOgPw9W+lcgEFQ+lStoIclH/rtuWciJC7Ld
         7tDZl007Qi9PndIbJflqT16zf+lk3nPFYwcGppbIAehkyRXb9OUHKCF+72MvVF839PHg
         4+NsIbWfZ9KmDRRnDfeJ/ebLfUFpE+EpVvjI0DLs7cNbqrogCRYsLG0mHcw7a+k/4VCA
         LuXzHM5Vh7z0bxwsxqqEatcfrHVp4lPp+dxEyK9qh+i/9o7QVS1cJjVTs7tAg6TQCyyZ
         eeog==
X-Gm-Message-State: AC+VfDwoUIwbFTwcNt6ORS/Gz03ceB1sNC71jmHsu0cBdyByBgldtoeg
        m7nQKZ0ByviaM2c833ihwZDTyG+/N4JshSdEbbPS8Y4KJAo=
X-Google-Smtp-Source: ACHHUZ7QSUKHz6eXKVGjn16hSJRIcttn0Cs9hdfy+fflsRqL6m/Cu2KmL77E7KQyQdWpf2q+eOyHfZdmyWR1J0JjSb8=
X-Received: by 2002:a05:6214:2a83:b0:62b:6615:22ce with SMTP id
 jr3-20020a0562142a8300b0062b661522cemr20081429qvb.33.1686780377150; Wed, 14
 Jun 2023 15:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com>
 <20230614074904.29085-8-herve.codina@bootlin.com> <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
 <20230614114214.1371485e@bootlin.com> <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
 <20230614223418.0d7e355d@bootlin.com>
In-Reply-To: <20230614223418.0d7e355d@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 01:05:40 +0300
Message-ID: <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 11:34=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:
> On Wed, 14 Jun 2023 14:51:43 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 14, 2023 at 12:42=E2=80=AFPM Herve Codina <herve.codina@boo=
tlin.com> wrote:
> > > On Wed, 14 Jun 2023 12:02:57 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Jun 14, 2023 at 10:49=E2=80=AFAM Herve Codina <herve.codina=
@bootlin.com> wrote:

...

> > > > > +       typeof(__array[0] + 0) __element =3D __array[--__len];   =
 \
> > > >
> > > > Do we need the ' + 0' part?
> > >
> > > Yes.
> > >
> > > __array can be an array of const items and it is legitimate to get th=
e
> > > minimum value from const items.
> > >
> > > typeof(__array[0]) keeps the const qualifier but we need to assign __=
element
> > > in the loop.
> > > One way to drop the const qualifier is to get the type from a rvalue =
computed
> > > from __array[0]. This rvalue has to have the exact same type with onl=
y the const
> > > dropped.
> > > '__array[0] + 0' was a perfect canditate.
> >
> > Seems like this also deserves a comment. But if the series is accepted
> > as is, it may be done as a follow up.
> >
>
> Finally not so simple ...
> I did some deeper tests and the macros need to be fixed.
>
> I hope this one (with comments added) is correct:
> --- 8 ---
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
>  * typeof(__array[0] + 0) used for __element is needed as the array can b=
e an
>  * array of const items.
>  * In order to discard the const qualifier use an arithmetic operation (r=
value).


>  * This arithmetic operation discard the const but also can lead to an in=
teger

discards

>  * promotion. For instance, a const s8 __array[0] lead to an int __elemen=
t due

leads

>  * to the promotion.
>  * In this case, simple min() or max() operation fails (type mismatch).
>  * Use min_t() or max_t() (op_t parameter) enforcing the type in order to=
 avoid
>  * the min() or max() failure.

This part perhaps can be avoided. See below.

>  */
> #define __minmax_array(op_t, array, len) ({                     \
>         typeof(&(array)[0]) __array =3D (array);                  \
>         typeof(len) __len =3D (len);                              \
>         typeof(__array[0] + 0) __element =3D __array[--__len];    \
>         while (__len--)                                         \
>                 __element =3D op_t(typeof(__array[0]), __element, __array=
[__len]); \

But can't we instead have typeof(+(array[0])) in the definition of __elemen=
t?
There are also other possible solutions: a) _Generic() with listed
const types to move them to non-const, and b) __auto_type (which is
supported by GCC 4.9 and clang, but not in the C11 standard).

>         __element; })

...

> Can you give me your feedback on this last version ?

Sure!

> If you are ok, it will be present in the next iteration of the series.
> Otherwise, as a last ressort, I will drop the {min,max}_array() and switc=
h
> back to the specific min/max computation in IIO inkern.c
>
> Sorry for this back and forth and this last minute detected bug.

It's good that we have some tests (perhaps you can add something to
unit test these)? Perhaps move your code to lib/test_minmax.c as KUnit
module?

--=20
With Best Regards,
Andy Shevchenko
