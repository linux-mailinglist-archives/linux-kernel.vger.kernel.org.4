Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F95604684
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJSNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiJSNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:12:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E647DEF10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:57:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so14525515wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WaTBRcWI0PprR43j0Khvc0rTrt91bC3dvCC0GQdlaM=;
        b=Ab9BZHYrqQIgRzgpnZGm3kcbeBtAJGfkx25xpQZ9hoPoB7wjptcA+3ELYu/SDPeRC8
         MnFNkCgtDAIPvbg8/lSAyOpvLIM3GHLBGSE4ItebHTIVs0Sa2hL4uKEWxY7vyXghVXix
         iwohwsqOz3byWmVrO/gSKgl7d30XsRwLcjmac/mwgvmk9JGQxjxl8P/+CBgxwe2Mjq6H
         xrwWUPgKuefZmd5OwPEim4XrA1bornhIIur8QhsUF/HqBrB7cGgH2feEl68ZwU6botrV
         e/EKBeIljhuYkcqNoshuTkjlzmwq0NSiAl45J4lo2ZQ+DH9e0ombJY5ykVjyYsztNSD9
         uyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WaTBRcWI0PprR43j0Khvc0rTrt91bC3dvCC0GQdlaM=;
        b=IjlPWQ4jVT2qV3E8Pz0LDvco7ZPhoyaU1NoDQyR/JG4yCu2pTSDXKiRhazmUR+sBt0
         I0KtgM+ImaUzMkWDTWOpXbCwR9W9TNV4AxbA2W3beSrVKN07uCVigLKUmmYq8mxP18C4
         7SE9to3p989WA9ExcD4cMmx732I5USRt9BhZXYU5sLWhYhrg0zvJJZK3RdOiIAmyf/Rk
         ta3B1H+4gmAAOUfk7I9HccEehnLLxuzvi2dcYBP6y+XKuVibLlT81HjpwS/mSZt1a+tT
         P/C2g0anwGfBBlJHuf07JDEnpvfQFouwWNG3m4p6h7aa5vrmG7izGoox24gPUEf6Gv93
         BDGQ==
X-Gm-Message-State: ACrzQf2ziTSmk5MpKMF5I9EyuEJZIekE9ShsrtypjmTZ5ezXqKac1dVi
        8jHxitiGaKCR4rD+M4+/3sWbPQJSvQ7WUvMMSuM=
X-Google-Smtp-Source: AMsMyM5qcKw9UawwiWDLvtGEAHaXQSMo7ca/WKM1r58rASN4Z+z8LFJeCD+N0zr0cahOe88OFLBfTEumrdAIxVqPYEs=
X-Received: by 2002:a7b:c7c1:0:b0:3c7:103:f964 with SMTP id
 z1-20020a7bc7c1000000b003c70103f964mr4240871wmk.121.1666184178958; Wed, 19
 Oct 2022 05:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220912155919.39877-1-mairacanal@riseup.net> <20220912155919.39877-2-mairacanal@riseup.net>
 <3a285040-8541-59e3-a124-7bf16c38b180@amd.com>
In-Reply-To: <3a285040-8541-59e3-a124-7bf16c38b180@amd.com>
From:   Magali Lemes <magalilemes00@gmail.com>
Date:   Wed, 19 Oct 2022 09:56:07 -0300
Message-ID: <CADhVOGtiO4eT-aY5xfP5gQs7rXeDAfNM=6OOxYCXcVazesfgXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/amd/display: Introduce KUnit tests for
 fixed31_32 library
To:     Harry Wentland <hwentlan@amd.com>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nicholas Choi <nicholas.choi@amd.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, andrealmeid@riseup.net,
        mwen@igalia.com, Isabella Basso <isabbasso@riseup.net>,
        tales.aparecida@gmail.com, Trevor Woerner <twoerner@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

Em sex., 30 de set. de 2022 =C3=A0s 11:14, Harry Wentland
<hwentlan@amd.com> escreveu:
>
>
>
> On 9/12/22 11:59, Ma=C3=ADra Canal wrote:
> > From: Tales Aparecida <tales.aparecida@gmail.com>
> >
> > The fixed31_32 library performs a lot of the mathematical operations
> > involving fixed-point arithmetic and the conversion of integers to
> > fixed-point representation.
> >
> > This unit tests intend to assure the proper functioning of the basic
> > mathematical operations of fixed-point arithmetic, such as
> > multiplication, conversion from fractional to fixed-point number,
> > and more. Use kunit_tool to run:
> >
> > $ ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
> >       --kunitconfig=3Ddrivers/gpu/drm/amd/display/tests/
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> > Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > ---
> >  drivers/gpu/drm/amd/display/Kconfig           |  13 +
> >  drivers/gpu/drm/amd/display/Makefile          |   2 +-
> >  .../gpu/drm/amd/display/tests/.kunitconfig    |   6 +
> >  drivers/gpu/drm/amd/display/tests/Makefile    |  12 +
> >  .../display/tests/dc/basics/fixpt31_32_test.c | 232 ++++++++++++++++++
> >  5 files changed, 264 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
> >  create mode 100644 drivers/gpu/drm/amd/display/tests/Makefile
> >  create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/fixpt31=
_32_test.c
> >
> > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/=
display/Kconfig
> > index 96cbc87f7b6b..cc44cfe88607 100644
> > --- a/drivers/gpu/drm/amd/display/Kconfig
> > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > @@ -55,4 +55,17 @@ config DRM_AMD_SECURE_DISPLAY
> >              Cooperate with specific DMCU FW.
> >
> >
> > +config AMD_DC_BASICS_KUNIT_TEST
>
> I would prefer if we kept the same prefix as for other
> configs in the file: "DRM_AMD_DC". Maybe name all the
> KUNIT configs here "DRM_AMD_DC_KUNIT_XYZ".
>
>
> > +     bool "Enable KUnit tests for the 'basics' sub-component of DAL" i=
f !KUNIT_ALL_TESTS
> > +     depends on DRM_AMD_DC && KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +             Enables unit tests for the Display Core. Only useful for =
kernel
> > +             devs running KUnit.
> > +
> > +             For more information on KUnit and unit tests in general p=
lease refer to
> > +             the KUnit documentation in Documentation/dev-tools/kunit/=
.
> > +
> > +             If unsure, say N.
> > +
> >  endmenu
> > diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd=
/display/Makefile
> > index 2633de77de5e..0f329aab13f0 100644
> > --- a/drivers/gpu/drm/amd/display/Makefile
> > +++ b/drivers/gpu/drm/amd/display/Makefile
> > @@ -43,7 +43,7 @@ endif
> >  #TODO: remove when Timing Sync feature is complete
> >  subdir-ccflags-y +=3D -DBUILD_FEATURE_TIMING_SYNC=3D0
> >
> > -DAL_LIBS =3D amdgpu_dm dc      modules/freesync modules/color modules/=
info_packet modules/power dmub/src
> > +DAL_LIBS =3D amdgpu_dm dc      modules/freesync modules/color modules/=
info_packet modules/power dmub/src tests
>
> Can we put these tests into a 'kunit' directory instead of 'tests'?
> We use the codebase on other platforms and 'tests' might be
> confusing to some AMD-internal developers, whereas 'kunit' is
> explicit and will ensure people understand where these are coming
> from and how to use them.
>
> Other than the CONFIG and directory naming these tests look really
> nice. Thanks for your contribution.
>
> Harry
>

Hi, Harry.
Thank you for your feedback and comments. We'll change the directory
and config entries' names in a new version.

Magali

> >
> >  ifdef CONFIG_DRM_AMD_DC_HDCP
> >  DAL_LIBS +=3D modules/hdcp
> > diff --git a/drivers/gpu/drm/amd/display/tests/.kunitconfig b/drivers/g=
pu/drm/amd/display/tests/.kunitconfig
> > new file mode 100644
> > index 000000000000..60f2ff8158f5
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/display/tests/.kunitconfig
> > @@ -0,0 +1,6 @@
> > +CONFIG_KUNIT=3Dy
> > +CONFIG_PCI=3Dy
> > +CONFIG_DRM=3Dy
> > +CONFIG_DRM_AMDGPU=3Dy
> > +CONFIG_DRM_AMD_DC=3Dy
> > +CONFIG_AMD_DC_BASICS_KUNIT_TEST=3Dy
> > \ No newline at end of file
> > diff --git a/drivers/gpu/drm/amd/display/tests/Makefile b/drivers/gpu/d=
rm/amd/display/tests/Makefile
> > new file mode 100644
> > index 000000000000..ef16497318e8
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/display/tests/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: MIT
> > +#
> > +# Makefile for the KUnit Tests for DC
> > +#
> > +
> > +ifdef CONFIG_AMD_DC_BASICS_KUNIT_TEST
> > +     DC_TESTS +=3D dc/basics/fixpt31_32_test.o
> > +endif
> > +
> > +AMD_DAL_DC_TESTS =3D $(addprefix $(AMDDALPATH)/tests/,$(DC_TESTS))
> > +
> > +AMD_DISPLAY_FILES +=3D $(AMD_DAL_DC_TESTS)
> > diff --git a/drivers/gpu/drm/amd/display/tests/dc/basics/fixpt31_32_tes=
t.c b/drivers/gpu/drm/amd/display/tests/dc/basics/fixpt31_32_test.c
> > new file mode 100644
> > index 000000000000..2fc489203499
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/display/tests/dc/basics/fixpt31_32_test.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: MIT
> > +/* Unit tests for display/include/fixed31_32.h and dc/basics/fixpt31_3=
2.c
> > + *
> > + * Copyright (C) 2022, Tales Aparecida <tales.aparecida@gmail.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include "os_types.h"
> > +#include "fixed31_32.h"
> > +
> > +static const struct fixed31_32 dc_fixpt_minus_one =3D { -0x100000000LL=
 };
> > +
> > +/**
> > + * dc_fixpt_from_int_test - KUnit test for dc_fixpt_from_int
> > + * @test: represents a running instance of a test.
> > + */
> > +static void dc_fixpt_from_int_test(struct kunit *test)
> > +{
> > +     struct fixed31_32 res;
> > +
> > +     res =3D dc_fixpt_from_int(0);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_zero.value);
> > +
> > +     res =3D dc_fixpt_from_int(1);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_int(-1);
> > +     KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_int(INT_MAX);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x7FFFFFFF00000000LL);
> > +
> > +     res =3D dc_fixpt_from_int(INT_MIN);
> > +     KUNIT_EXPECT_EQ(test, res.value,
> > +                     0x8000000000000000LL); /* implicit negative signa=
l */
> > +}
> > +
> > +/**
> > + * dc_fixpt_from_fraction_test - KUnit test for dc_fixpt_from_fraction
> > + * @test: represents a running instance of a test.
> > + */
> > +static void dc_fixpt_from_fraction_test(struct kunit *test)
> > +{
> > +     struct fixed31_32 res;
> > +
> > +     /* Assert signal works as expected */
> > +     res =3D dc_fixpt_from_fraction(1LL, 1LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_fraction(-1LL, 1LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_fraction(1LL, -1LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_fraction(-1LL, -1LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     /* Assert that the greatest parameter values works as expected */
> > +     res =3D dc_fixpt_from_fraction(LLONG_MAX, LLONG_MAX);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_fraction(LLONG_MIN, LLONG_MIN);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     /* Edge case using the smallest fraction possible without LSB rou=
nding */
> > +     res =3D dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRA=
CTIONAL_PART));
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
> > +
> > +     /* Edge case using the smallest fraction possible with LSB roundi=
ng */
> > +     res =3D dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRA=
CTIONAL_PART + 1));
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
> > +
> > +     /* Assert an nil numerator is a valid input */
> > +     res =3D dc_fixpt_from_fraction(0LL, LLONG_MAX);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0LL);
> > +
> > +     /* Edge case using every bit of the decimal part without rounding=
 */
> > +     res =3D dc_fixpt_from_fraction(8589934590LL, 8589934592LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x0FFFFFFFFLL);
> > +
> > +     res =3D dc_fixpt_from_fraction(-8589934590LL, 8589934592LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, -0x0FFFFFFFFLL);
> > +
> > +     /* Edge case using every bit of the decimal part then rounding LS=
B */
> > +     res =3D dc_fixpt_from_fraction(8589934591LL, 8589934592LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_from_fraction(-8589934591LL, 8589934592LL);
> > +     KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> > +     /*  A repeating decimal in binary representation that doesn't rou=
nd up the LSB */
> > +     res =3D dc_fixpt_from_fraction(4, 3);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x0000000155555555LL);
> > +
> > +     res =3D dc_fixpt_from_fraction(-4, 3);
> > +     KUNIT_EXPECT_EQ(test, res.value, -0x0000000155555555LL);
> > +
> > +     /* A repeating decimal in binary representation that rounds up th=
e LSB */
> > +     res =3D dc_fixpt_from_fraction(5, 3);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x00000001AAAAAAABLL);
> > +
> > +     res =3D dc_fixpt_from_fraction(-5, 3);
> > +     KUNIT_EXPECT_EQ(test, res.value, -0x00000001AAAAAAABLL);
> > +}
> > +
> > +/**
> > + * dc_fixpt_mul_test - KUnit test for dc_fixpt_mul
> > + * @test: represents a running instance of a test.
> > + */
> > +static void dc_fixpt_mul_test(struct kunit *test)
> > +{
> > +     struct fixed31_32 res;
> > +     struct fixed31_32 arg;
> > +
> > +     /* Assert signal works as expected */
> > +     res =3D dc_fixpt_mul(dc_fixpt_one, dc_fixpt_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     res =3D dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
> > +
> > +     res =3D dc_fixpt_mul(dc_fixpt_one, dc_fixpt_minus_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
> > +
> > +     res =3D dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_minus_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     /* Assert that the greatest parameter values works as expected */
> > +     arg.value =3D LONG_MAX;
> > +     res =3D dc_fixpt_mul(arg, dc_fixpt_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, arg.value);
> > +
> > +     arg.value =3D LONG_MIN;
> > +     res =3D dc_fixpt_mul(arg, dc_fixpt_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, arg.value);
> > +
> > +     arg.value =3D LONG_MAX;
> > +     res =3D dc_fixpt_mul(dc_fixpt_one, arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, arg.value);
> > +
> > +     arg.value =3D LONG_MIN;
> > +     res =3D dc_fixpt_mul(dc_fixpt_one, arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, arg.value);
> > +
> > +     /* Assert it doesn't round LSB as expected */
> > +     arg.value =3D 0x7FFFFFFF7fffffffLL;
> > +     res =3D dc_fixpt_mul(arg, dc_fixpt_epsilon);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x000000007FFFFFFF);
> > +
> > +     /* Assert it rounds LSB as expected */
> > +     arg.value =3D 0x7FFFFFFF80000000LL;
> > +     res =3D dc_fixpt_mul(arg, dc_fixpt_epsilon);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x0000000080000000);
> > +}
> > +
> > +/**
> > + * dc_fixpt_sqr_test - KUnit test for dc_fixpt_sqr
> > + * @test: represents a running instance of a test.
> > + */
> > +static void dc_fixpt_sqr_test(struct kunit *test)
> > +{
> > +     struct fixed31_32 res;
> > +     struct fixed31_32 arg;
> > +
> > +     arg.value =3D dc_fixpt_one.value;
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     arg.value =3D dc_fixpt_minus_one.value;
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     arg.value =3D 0;
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0);
> > +
> > +     /* Test some recognizable values */
> > +     arg =3D dc_fixpt_from_int(100);
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_from_int(10000).value);
> > +
> > +     arg =3D dc_fixpt_from_fraction(1, 100);
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value,
> > +                     dc_fixpt_from_fraction(1, 10000).value);
> > +
> > +     /* LSB rounding */
> > +     arg =3D dc_fixpt_from_fraction(3, 2);
> > +     res =3D dc_fixpt_sqr(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value,
> > +                     dc_fixpt_from_fraction(9, 4).value + 1LL);
> > +}
> > +
> > +/**
> > + * dc_fixpt_recip_test - KUnit test for dc_fixpt_recip
> > + * @test: represents a running instance of a test.
> > + */
> > +static void dc_fixpt_recip_test(struct kunit *test)
> > +{
> > +     struct fixed31_32 res;
> > +     struct fixed31_32 arg;
> > +
> > +     /* Assert 1/1 works as expected */
> > +     res =3D dc_fixpt_recip(dc_fixpt_one);
> > +     KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> > +
> > +     /* Assert smallest parameters work as expected. */
> > +     arg.value =3D 3LL;
> > +     res =3D dc_fixpt_recip(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, 0x5555555555555555LL);
> > +
> > +     arg.value =3D -3LL;
> > +     res =3D dc_fixpt_recip(arg);
> > +     KUNIT_EXPECT_EQ(test, res.value, -0x5555555555555555LL);
> > +}
> > +
> > +static struct kunit_case dc_basics_fixpt31_32_test_cases[] =3D {
> > +     KUNIT_CASE(dc_fixpt_from_int_test),
> > +     KUNIT_CASE(dc_fixpt_from_fraction_test),
> > +     KUNIT_CASE(dc_fixpt_mul_test),
> > +     KUNIT_CASE(dc_fixpt_sqr_test),
> > +     KUNIT_CASE(dc_fixpt_recip_test),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite dc_basics_fixpt31_32_test_suite =3D {
> > +     .name =3D "dc_basics_fixpt31_32",
> > +     .test_cases =3D dc_basics_fixpt31_32_test_cases,
> > +};
> > +
> > +kunit_test_suites(&dc_basics_fixpt31_32_test_suite);
> > +
