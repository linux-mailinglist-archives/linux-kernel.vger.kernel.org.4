Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC15B5E58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiILQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiILQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:36:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACC2229F;
        Mon, 12 Sep 2022 09:36:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333a4a5d495so107821437b3.10;
        Mon, 12 Sep 2022 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=oMkhE0t6jKHS9gOEJlLL58JzB03vinVVkGANNn41C8M=;
        b=F9q1avKpewsEoOtSW75rKk+2Gta6Pz3azQ1CxJtytiuY/MJcMdnptlEuyK92IHBqCk
         2QyM0WnbZ5HqcgLO6PnfXasiBWwYB/AzdsnEUnirYLjaV8DwzRQ4B9dl4djA6CnIklRo
         Km/J1SESc/d0kjVse9ZKZTaDFstTNMoYAWX6+cUBWUaaYjSQG0NtuH2bhbYmLy2F3wQ0
         Ff9XuTw08txtQHuMleyvaavHiW4jY0/oXrXRQM8UAn5jC/v5xzBi3qt4dMd/ZSWABpD8
         dlSDgUtM4kyx/LrsKN7WTR7iB0ucE2dZYGpikixl2ST1ggPJYAGP0oF5diX1ce6r1Z9C
         pZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oMkhE0t6jKHS9gOEJlLL58JzB03vinVVkGANNn41C8M=;
        b=fGY7UovW6KIi/nBeIfsMWkNaSOgjsyskKmbzRcZ/4EeJQgNDCewpBMxDabLyHEtRal
         F2kqfuGVQg+ctKHoFeP/pHjOWHEuf/a+9Ij4gz5oUnZymKl6WbbEifIQ1nf83oo0x78Z
         EsVEfyt7e/a018sxnObXGB3Ly5OorFt4AExgj2/pZaIm/svqHz/L+OJA0OeuBkPH0j4C
         ebSmZKBV2yJuCgAUQ75XOTX3UEpi5/B/GCtc0nzTnLX+ltOymMOdP1JaYCz7VpPNL8vj
         Wr8HNouMdidjMPzReDQHcj/sX4peKr65qLql5LccsHT4OTjkSElcKsvDLtLY8OPCZf4Q
         PhUw==
X-Gm-Message-State: ACgBeo2RNjxCVS7LpEZfTVefDyra9I1bUQmnCUbQxnjz0AYK/Ow6gYu3
        Yvz2RhmORR+w/Mryf0QH75Z1293w9Raua7n497M=
X-Google-Smtp-Source: AA6agR5TqJXuuQZakuuDKylP4JcPcOz6Te9m6MYHXag1agUiXsL3Dlzxp7PI37BK+592sxq9teueX1SAWW7Ommz3wXE=
X-Received: by 2002:a0d:e344:0:b0:324:37f6:85df with SMTP id
 m65-20020a0de344000000b0032437f685dfmr22902025ywe.517.1663000581069; Mon, 12
 Sep 2022 09:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220906170239.30384-1-jorge.lopez2@hp.com> <1d2d7da9-3046-b5fc-da6f-7615aa8a8285@redhat.com>
In-Reply-To: <1d2d7da9-3046-b5fc-da6f-7615aa8a8285@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 12 Sep 2022 11:36:10 -0500
Message-ID: <CAOOmCE9vYLTnfdPwH5jGVN5ExCPwAjmpAKozFyV2c6R1zQNK9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hp-wmi: Setting thermal profile fails with 0x06
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     balalic.enver@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, markgross@kernel.org
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

Hi Hans,

On Fri, Sep 9, 2022 at 1:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Jorge,
>
> On 9/6/22 19:02, Jorge Lopez wrote:
> > Error 0x06 (invalid command parameter) is reported by hp-wmi module
> > when reading the current thermal profile and then proceed to set it
> > back. The failing condition occurs in Linux NixOS after user
> > configures the thermal profile to =E2=80=98quiet mode=E2=80=99 in Windo=
ws.  Quiet Fan
> > Mode is supported in Windows but was not supported in hp-wmi module.
> >
> > This fix adds support for PLATFORM_PROFILE_QUIET in hp-wmi module for
> > HP notebooks other than HP Omen series.  Quiet thermal profile is not
> > supported in HP Omen series notebooks.
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>
> Thank you for looking into this!
>
>
>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  drivers/platform/x86/hp-wmi.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wm=
i.c
> > index bc7020e9df9e..f5c13df35af0 100644
> > --- a/drivers/platform/x86/hp-wmi.c
> > +++ b/drivers/platform/x86/hp-wmi.c
> > @@ -177,7 +177,8 @@ enum hp_thermal_profile_omen_v1 {
> >  enum hp_thermal_profile {
> >       HP_THERMAL_PROFILE_PERFORMANCE  =3D 0x00,
> >       HP_THERMAL_PROFILE_DEFAULT              =3D 0x01,
> > -     HP_THERMAL_PROFILE_COOL                 =3D 0x02
> > +     HP_THERMAL_PROFILE_COOL                 =3D 0x02,
> > +     HP_THERMAL_PROFILE_QUIET                =3D 0x03,
> >  };
> >
> >  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) !=3D HPWMI_POWER_F=
W_OR_HW)
> > @@ -1194,6 +1195,9 @@ static int hp_wmi_platform_profile_get(struct pla=
tform_profile_handler *pprof,
> >       case HP_THERMAL_PROFILE_COOL:
> >               *profile =3D  PLATFORM_PROFILE_COOL;
> >               break;
> > +     case HP_THERMAL_PROFILE_QUIET:
> > +             *profile =3D PLATFORM_PROFILE_QUIET;
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1216,6 +1220,10 @@ static int hp_wmi_platform_profile_set(struct pl=
atform_profile_handler *pprof,
> >       case PLATFORM_PROFILE_COOL:
> >               tp =3D  HP_THERMAL_PROFILE_COOL;
> >               break;
> > +     case PLATFORM_PROFILE_QUIET:
> > +             tp =3D HP_THERMAL_PROFILE_QUIET;
> > +             break;
> > +
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> > @@ -1266,6 +1274,7 @@ static int thermal_profile_setup(void)
> >       }
> >
> >       set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> > +     set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices)=
;
>
> In the commit msg you say that quiet profile is only supported on the non=
 Omen
> models, should this then not be inside the else branch of the:
>
> if (is_omen_thermal_profile()) { ... } else { ... }
>
> just above this code block ?
>
> >       set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choic=
es);
> >       set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.ch=
oices);
> >
You are correct.  I will submit a new patch shortly.

>
>
> Regards,
>
> Hans
>
