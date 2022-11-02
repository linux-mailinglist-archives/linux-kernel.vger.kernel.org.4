Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB3615C52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKBGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBGcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:32:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FC26118
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667370734; x=1698906734;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:cc:to:from:subject:message-id:date;
  bh=JrCkN6j+stIgc9DlQIaeVXYqxXGpLNlrrltNN3dS+AY=;
  b=RVCWQSJzdF7SZGMdy77SsQrPi3dfIBzfQoKDuHEsQLMdR13BqpHkgWEm
   Kiy7hX6l6zNp5+loqDwcmqvBGKZcfRw5qIhuxbMWLUr46151IWS87Mul3
   I0nUp3vq/wYH2EAOxOb1Kjuexj+ukmO55CzilUGHbleEzT1wGk6hdi/ZE
   rTtFRJPyFWfMPHKJZknGmEw5P0NVG4iVDu/RPcG9HH0QWd91F61cW2ugs
   uA1YgX+3iXHQBbZhoTw0OJkKtuHWXTL62TalC7ZeqqvYdChKwtxk4b8Pb
   2nb6O/AGLlM5aOxdfNEOg6/i4XJP3BV9iFGivwpOb07FV9Vzlmb2GArSO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296766368"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="296766368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:32:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723429687"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="723429687"
Received: from ngorb-mobl.ger.corp.intel.com (HELO localhost) ([10.252.14.3])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:32:11 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8735b89vz6.fsf@intel.com>
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com> <Y1ercgaqQwfqt42U@ashyti-mobl2.lan> <87ilk7pwrw.wl-ashutosh.dixit@intel.com> <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan> <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com> <877d0lxl6s.wl-ashutosh.dixit@intel.com> <CAKwvOdmVJn8HvfF9WTnOAc+HsdJ4c1Tdck8E7Caky7AoCq4ZTA@mail.gmail.com> <875yg5xgkp.wl-ashutosh.dixit@intel.com> <c1c548f8-71a8-0d4d-d591-58a0cd5dac20@intel.com> <8735b89vz6.fsf@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/hwmon: Fix a build error used with clang compiler
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <166737072744.4614.10758297029461955484@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Wed, 02 Nov 2022 08:32:07 +0200
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2022-10-28 11:46:21)
> On Fri, 28 Oct 2022, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:
> > Resend, because some content was accidentally omitted from the previous=
=20
> > reply.
> > Please ignore the previous email.
> >
> > Hi all,
> >
> > I should have written the original commit message more accurately, but =

> > it seems that it was written inaccurately.
> >
> > If the FIELD_PREP macro is expanded, the following macros are used.
> >
> > #define FIELD_PREP(_mask, _val)                                        =
       \
> >       ({                                                              \
> >               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
> >               ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
> >       })
> >
> >
> > #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                     \
> >       ({                                                              \
> >               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> >                                _pfx "mask is not constant");          \
> >               BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero"); =
   \
> >               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> >                                ~((_mask) >> __bf_shf(_mask)) & (_val) :=
 0, \
> >                                _pfx "value too large for the field"); \
> >               BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >                                __bf_cast_unsigned(_reg, ~0ull),       \
> >                                _pfx "type of reg too small for mask"); \
> >               __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
> >                                             (1ULL << __bf_shf(_mask)));=
 \
> >       })
> >
> > Among them, a build error is generated by the lower part of the=20
> > __BF_FIELD_CHECK() macro.
> >
> >               BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >                                __bf_cast_unsigned(_reg, ~0ull),       \
> >                                _pfx "type of reg too small for mask"); \
> >
> >
> > Here, if you apply an argument to this macro, it will look like the=20
> > following.
> >
> > __bf_cast_unsigned(field_msk, field_msk) > __bf_cast_unsigned(0ULL, ~0u=
ll)
> >
> > The result is always false because an unsigned int value of type=20
> > field_msk is not always greater than the maximum value of unsigned long=
=20
> > long .
> > So, a build error occurs due to the following part of the clang compile=
r=20
> > option.
> >
> > [-Werror,-Wtautological-constant-out-of-range-compare]
> >
> > You can simply override this warning in Clang by adding the build optio=
n=20
> > below, but this seems like a bad attempt
> >
> > i915/Makefile
> > CFLAGS_i915_hwmon.o +=3D -Wno-tautological-constant-out-of-range-compare
> >
> > The easiest way to solve this is to use a constant value, not a=20
> > variable, as an argument to FIELD_PREP.
> >
> > And since the REG_FIELD_PREP() macro suggested by Jani requires a const=
=20
> > expression as the first argument, it cannot be changed with this macro =

> > alone in the existing code, it must be changed to input a constant valu=
e=20
> > as shown below.
>=20
> We've added REG_FIELD_PREP() precisely to avoid the problems with the
> types and ranges, as we want it to operate on u32. It also uses
> __is_constexpr() to avoid dependencies on compiler implementation and
> optimizations.
>=20
> Please use REG_FIELD_PREP() and a constant value. Maybe rethink the
> interface if needed.

Ashutosh and GG, can we get a fix for this merged ASAP. It's currently
blocking the drm-intel-gt-next pull request.

Regards, Joonas

>=20
> BR,
> Jani.
>=20
>=20
>=20
>=20
> >
> > diff --git a/drivers/gpu/drm/i915/i915_hwmon.c=20
> > b/drivers/gpu/drm/i915/i915_hwmon.c
> > index 08c921421a5f..abb3a194c548 100644
> > --- a/drivers/gpu/drm/i915/i915_hwmon.c
> > +++ b/drivers/gpu/drm/i915/i915_hwmon.c
> > @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat, =

> > i915_reg_t rgadr,
> >
> >   static void
> >   hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
> > -                         const u32 field_msk, int nshift,
> > +                         int nshift,
> >                            unsigned int scale_factor, long lval)
> >   {
> >          u32 nval;
> > @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata *ddat,=
=20
> > i915_reg_t rgadr,
> >          /* Computation in 64-bits to avoid overflow. Round to nearest.=
 */
> >          nval =3D DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_fact=
or);
> >
> > -       bits_to_clear =3D field_msk;
> > -       bits_to_set =3D REG_FIELD_PREP(field_msk, nval);
> > +       bits_to_clear =3D PKG_PWR_LIM_1;
> > +       bits_to_set =3D REG_FIELD_PREP(PKG_PWR_LIM_1, nval);
> >
> >          hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
> >                                              bits_to_clear, bits_to_set=
);
> > @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32 attr,=
=20
> > int chan, long val)
> >          case hwmon_power_max:
> >                  hwm_field_scale_and_write(ddat,
> >                                            hwmon->rg.pkg_rapl_limit,
> > -                                         PKG_PWR_LIM_1,
> >                                            hwmon->scl_shift_power,
> >                                            SF_POWER, val);
> >                  return 0;
> >
> >
> >
> > In addition, if there is no build problem regardless of the size of the=
=20
> > type as the first argument in FIELD_PREP, it is possible through the=20
> > following modification.
> > (Since this modification modifies include/linux/bitfield.h , I will sen=
d=20
> > it as a separate patch.
> >    )
> >
> > However, it seems that we need to have Jani's confirm whether it is oka=
y=20
> > to use FIELD_PREP() instead of REG_FIELD_PREP() which is forced to u32 =

> > return type in i915.
> >
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index c9be1657f03d..6e96799b6f38 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -9,7 +9,7 @@
> >
> >   #include <linux/build_bug.h>
> >   #include <asm/byteorder.h>
> > -
> > +#include <linux/overflow.h>
> >   /*
> >    * Bitfield access macros
> >    *
> > @@ -69,7 +69,7 @@
> >                                   ~((_mask) >> __bf_shf(_mask)) & (_val=
)=20
> > : 0, \
> >                                   _pfx "value too large for the field")=
; \
> >                  BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >   =
  \
> > -                                __bf_cast_unsigned(_reg, ~0ull),      =
 \
> > +                                __bf_cast_unsigned(_reg,=20
> > type_max(__unsigned_scalar_typeof(_reg))),    \
> >                                   _pfx "type of reg too small for mask"=
); \
> >                  __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +               =
  \
> >                                                (1ULL << __bf_shf(_mask)=
)); \
> > @@ -84,7 +84,7 @@
> >    */
> >   #define FIELD_MAX(_mask)                                             =
  \
> >          ({                                                            =
  \
> > -               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");    =
 \
> > +               __BF_FIELD_CHECK(_mask,=20
> > type_min(__unsigned_scalar_typeof(_mask)),=20
> > type_min(__unsigned_scalar_typeof(_mask)), "FIELD_MAX: ");   \
> >                  (typeof(_mask))((_mask) >> __bf_shf(_mask));          =
  \
> >          })
> >
> > @@ -97,7 +97,7 @@
> >    */
> >   #define FIELD_FIT(_mask, _val)                                       =
  \
> >          ({                                                            =
  \
> > -               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");    =
 \
> > +               __BF_FIELD_CHECK(_mask,=20
> > type_min(__unsigned_scalar_typeof(_mask)),=20
> > type_min(__unsigned_scalar_typeof(_val)), "FIELD_FIT: ");    \
> >                  !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask=
)); \
> >          })
> >
> > @@ -111,7 +111,7 @@
> >    */
> >   #define FIELD_PREP(_mask, _val)=20
> >           \
> >          ({                                                            =
  \
> > -               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");   =
 \
> > +               __BF_FIELD_CHECK(_mask,=20
> > type_min(__unsigned_scalar_typeof(_mask)), _val, "FIELD_PREP: ");      =
 \
> >                  ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); =
  \
> >          })
> >
> > @@ -125,7 +125,7 @@
> >    */
> >   #define FIELD_GET(_mask, _reg)                                       =
  \
> >          ({                                                            =
  \
> > -               __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");      =
 \
> > +               __BF_FIELD_CHECK(_mask, _reg,=20
> > type_min(__unsigned_scalar_typeof(_reg)), "FIELD_GET: "); \
> >                  (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask))=
; \
> >          })
> >
> >
> > Br,
> >
> > G.G.
> >
> > On 10/27/22 9:32 PM, Dixit, Ashutosh wrote:
> >> On Thu, 27 Oct 2022 10:16:47 -0700, Nick Desaulniers wrote:
> >>>
> >>=20
> >> Hi Nick,
> >>=20
> >>> Thanks, I can repro now.
> >>>
> >>> I haven't detangled the macro soup, but I noticed:
> >>>
> >>> 1. FIELD_PREP is defined in include/linux/bitfield.h which has the
> >>> following comment:
> >>>   18  * Mask must be a compilation time constant.
> >>=20
> >> I had comments about this here:
> >>=20
> >> https://lore.kernel.org/intel-gfx/87ilk7pwrw.wl-ashutosh.dixit@intel.c=
om/
> >>=20
> >> The relevant part being:
> >>=20
> >> ---- {quote} ----
> >>>>> ./include/linux/bitfield.h:71:53: note: expanded from macro '__BF_F=
IELD_CHECK'
> >>>>>                  BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) =
>     \
> >>=20
> >> So clang seems to break here at this line in __BF_FIELD_CHECK (note ~0=
ull
> >> also occurs here):
> >>=20
> >>              BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >>                               __bf_cast_unsigned(_reg, ~0ull),       \
> >>                               _pfx "type of reg too small for mask"); \
> >>=20
> >> So it goes through previous checks including the "mask is not constant"
> >> check. As Nick Desaulniers mentions "__builtin_constant_p is evaluated
> >> after most optimizations have run" so by that time both compilers (gcc=
 and
> >> clang) have figured out that even though _mask is coming in as function
> >> argument it is really the constant below:
> >>=20
> >> #define   PKG_PWR_LIM_1              REG_GENMASK(14, 0)
> >>=20
> >> But it is not clear why clang chokes on this "type of reg too small for
> >> mask" check (and gcc doesn't) since everything is u32.
> >> ---- {end quote} ----
> >>=20
> >>>
> >>> 2. hwm_field_scale_and_write only has one callsite.
> >>>
> >>> The following patch works:
> >>=20
> >> If we need to fix it at our end yes we can come up with one of these
> >> patches. But we were hoping someone from clang/llvm can comment about =
the
> >> "type of reg too small for mask" stuff. If this is something which nee=
ds to
> >> be fixed in clang/llvm we probably don't want to hide the issue.
> >>=20
> >>>
> >>> ```
> >>> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
> >>> b/drivers/gpu/drm/i915/i915_hwmon.c
> >>> index 9e9781493025..6ac29d90b92a 100644
> >>> --- a/drivers/gpu/drm/i915/i915_hwmon.c
> >>> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
> >>> @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
> >>> i915_reg_t rgadr,
> >>>
> >>>   static void
> >>>   hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgad=
r,
> >>> -                         u32 field_msk, int nshift,
> >>> +                         int nshift,
> >>>                            unsigned int scale_factor, long lval)
> >>>   {
> >>>          u32 nval;
> >>> @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata
> >>> *ddat, i915_reg_t rgadr,
> >>>          /* Computation in 64-bits to avoid overflow. Round to neares=
t. */
> >>>          nval =3D DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_fa=
ctor);
> >>>
> >>> -       bits_to_clear =3D field_msk;
> >>> -       bits_to_set =3D FIELD_PREP(field_msk, nval);
> >>> +       bits_to_clear =3D PKG_PWR_LIM_1;
> >>> +       bits_to_set =3D FIELD_PREP(PKG_PWR_LIM_1, nval);
> >>>
> >>>          hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
> >>>                                              bits_to_clear, bits_to_s=
et);
> >>> @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32
> >>> attr, int chan, long val)
> >>>          case hwmon_power_max:
> >>>                  hwm_field_scale_and_write(ddat,
> >>>                                            hwmon->rg.pkg_rapl_limit,
> >>> -                                         PKG_PWR_LIM_1,
> >>>                                            hwmon->scl_shift_power,
> >>>                                            SF_POWER, val);
> >>>                  return 0;
> >>> ```
> >>> Though I'm not sure if you're planning to add further callsites of
> >>> hwm_field_scale_and_write with different field_masks?
> >>=20
> >> I have reasons for keeping it this way, it's there in the link above i=
f you
> >> are interested.
> >>=20
> >>>
> >>> Alternatively, (without the above diff),
> >>>
> >>> ```
> >>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> >>> index c9be1657f03d..6f40f12bcf89 100644
> >>> --- a/include/linux/bitfield.h
> >>> +++ b/include/linux/bitfield.h
> >>> @@ -8,6 +8,7 @@
> >>>   #define _LINUX_BITFIELD_H
> >>>
> >>>   #include <linux/build_bug.h>
> >>> +#include <linux/const.h>
> >>>   #include <asm/byteorder.h>
> >>>
> >>>   /*
> >>> @@ -62,7 +63,7 @@
> >>>
> >>>   #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                  =
    \
> >>>          ({                                                          =
    \
> >>> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),       =
   \
> >>> +               BUILD_BUG_ON_MSG(!__is_constexpr(_mask),             =
   \
> >>>                                   _pfx "mask is not constant");      =
    \
> >>>                  BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zer=
o");    \
> >>>                  BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?       =
    \
> >>> ```
> >>> will produce:
> >>> error: call to __compiletime_assert_407 declared with 'error'
> >>> attribute: FIELD_PREP: mask is not constant
> >>>
> >>> I haven't tested if that change is also feasible (on top of fixing
> >>> this specific instance), but I think it might help avoid more of these
> >>> subtleties wrt. __builtin_constant_p that depende heavily on compiler,
> >>> compiler version, optimization level.
> >>=20
> >> Not disagreeing, can do something here if needed.
> >>=20
> >> Thanks.
> >> --
> >> Ashutosh
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center
