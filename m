Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70870FEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEXTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:50:39 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACFBB6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:50:38 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5552cbcda35so703461eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957838; x=1687549838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FltIaokl6US61SmteGHT2ZHdFzbBsYCMluzlsNH7Eo0=;
        b=AP1ELHPauM/XYUZc5qS9ndLT4WMva+aBaHm1pYtsTx1VEfCnRozy3iF4efGEjOeoFK
         w+57cNa7WZ7or57mRibrY9sqtjXQfEPCyon9DJS+I4tfwnbcjo93c2ojBKiSLYQU/QDF
         Qfpg13BJ7MAu8urcumV8LwA7WFyIxvD0/knPiqXeuwTGPGziOqAY/MN4xzJ7gvLVTsBf
         jE/FI6h87EbZNay1qjO8QRNfrBG7JWvFvT1ixYy1no1JNutkUhKcwvc9veHcfeqXp+bW
         kHbDtf1XjAOWjGhkB/soxOR1fiuGnGExdjmOgLlZzQ2JSDpJY3SYy//WL0WCRUkVVyjF
         W7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957838; x=1687549838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FltIaokl6US61SmteGHT2ZHdFzbBsYCMluzlsNH7Eo0=;
        b=JP4uVt4RISAotjhlFhwSkLr/eOEdej5vJcXvqCe1cj7LWtGAC/+MfLVKrXSRLOc5Xd
         oi3oyTKpg4y0I6u+D+aleINAhdsUAUDY49KCMu/cBa26/cT7/wCa7YCiX4moi4sKSzCI
         7eLafuHSX8HZAjJWzjuyg9o0rJU2RrTi9P7efx1iu4/iuPaL+Us5Z2Ml8p+THT0HAJYQ
         ZtIwTbn6cBRPV4gYUA7wAuQFqISvTq2EH598RMwtcUC3AtR/sXhDFo++194ObBGqW1xk
         V3O/AeXKxWTCXlIYSVxUtJvYoIfXpir1octP5rTcSC1G+IyicwcrTU3Hxyk4iA5UP/jg
         WmDw==
X-Gm-Message-State: AC+VfDzNriYavHxSG1HQ8SAvvpHPmWt9ueqwGaVHGIkDlZG8Pz/feOuh
        /cBbO/JxgwFXpTDrkZzWkoVTOSri56ClTZqYg1M=
X-Google-Smtp-Source: ACHHUZ5phGsstqTL/HGb4xw/DFAIglHfkZRy/nFUcrYNP92cyOgPNC1xID5jsm5zX9Yc/biCl0nfqoak7gA2iDavfZQ=
X-Received: by 2002:a4a:6107:0:b0:54c:8991:5f8b with SMTP id
 n7-20020a4a6107000000b0054c89915f8bmr8782798ooc.5.1684957837694; Wed, 24 May
 2023 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
 <CADnq5_Mz6aPFYGnr8J8C8UeTpbo7JDg+uvjqAxo7o4vmTGej2A@mail.gmail.com>
 <DM6PR12MB3996C4248CBC968A7B08341583419@DM6PR12MB3996.namprd12.prod.outlook.com>
 <BL1PR12MB589849F37FBE98A3A06A316185419@BL1PR12MB5898.namprd12.prod.outlook.com>
 <3fefc712-913a-a391-bc7b-c0c75eff1c3d@amd.com>
In-Reply-To: <3fefc712-913a-a391-bc7b-c0c75eff1c3d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 May 2023 15:50:26 -0400
Message-ID: <CADnq5_OdWbg6zKjPrRwd2QSDnHgFuThF+OQHM=tVWj-2ySCu_A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     "Russell, Kent" <Kent.Russell@amd.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Wed, May 24, 2023 at 3:46=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> Sure, I think we tried enabling warnings as errors before and had to
> revert it because of weird compiler quirks or the variety of compiler
> versions that need to be supported.
>
> Alex, are you planning to upstream this, or is this only to enforce more
> internal discipline about not ignoring warnings?

I'd like to upstream it.  Upstream already has CONFIG_WERROR as a
config option, but it's been problematic to enable in CI because of
various breakages outside of the driver and in different compilers.
That said, I don't know how much trouble enabling it will cause with
various compilers in the wild.

Alex

>
> Regards,
>    Felix
>
>
> On 2023-05-24 15:41, Russell, Kent wrote:
> >
> > [AMD Official Use Only - General]
> >
> >
> > (Adding Felix in CC)
> >
> > I=E2=80=99m a fan of adding it to KFD as well. Felix, can you foresee a=
ny
> > issues here?
> >
> > Kent
> >
> > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
> > *Ho, Kenny
> > *Sent:* Wednesday, May 24, 2023 3:23 PM
> > *To:* Alex Deucher <alexdeucher@gmail.com>; Mahfooz, Hamza
> > <Hamza.Mahfooz@amd.com>
> > *Cc:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Siqueira,
> > Rodrigo <Rodrigo.Siqueira@amd.com>; linux-kernel@vger.kernel.org;
> > dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; Daniel
> > Vetter <daniel@ffwll.ch>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; David Airlie <airlied@gmail.com>; Koenig,
> > Christian <Christian.Koenig@amd.com>
> > *Subject:* Re: [PATCH v2] drm/amd/display: enable more strict compile
> > checks
> >
> > [AMD Official Use Only - General]
> >
> > [AMD Official Use Only - General]
> >
> > (+ Felix)
> >
> > Should we do the same for other modules under amd (amdkfd)?  I was
> > going to enable full kernel werror in the kconfig used by my CI but
> > this is probably better.
> >
> > Kenny
> >
> > -----------------------------------------------------------------------=
-
> >
> > *From:*Alex Deucher <alexdeucher@gmail.com>
> > *Sent:* Wednesday, May 24, 2023 3:22 PM
> > *To:* Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> > *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> > Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Ho, Kenny <Kenny.Ho@amd.com>;
> > Pan, Xinhui <Xinhui.Pan@amd.com>; Siqueira, Rodrigo
> > <Rodrigo.Siqueira@amd.com>; linux-kernel@vger.kernel.org
> > <linux-kernel@vger.kernel.org>; dri-devel@lists.freedesktop.org
> > <dri-devel@lists.freedesktop.org>; Daniel Vetter <daniel@ffwll.ch>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; David Airlie
> > <airlied@gmail.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig,
> > Christian <Christian.Koenig@amd.com>
> > *Subject:* Re: [PATCH v2] drm/amd/display: enable more strict compile
> > checks
> >
> > On Wed, May 24, 2023 at 3:20=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@am=
d.com>
> > wrote:
> > >
> > > Currently, there are quite a number of issues that are quite easy for
> > > the CI to catch, that slip through the cracks. Among them, there are
> > > unused variable and indentation issues. Also, we should consider all
> > > warnings to be compile errors, since the community will eventually en=
d
> > > up complaining about them. So, enable -Werror, -Wunused and
> > > -Wmisleading-indentation for all kernel builds.
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > Cc: Kenny Ho <kenny.ho@amd.com>
> > > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > ---
> > > v2: fix grammatical error
> > > ---
> > >  drivers/gpu/drm/amd/display/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/Makefile
> > b/drivers/gpu/drm/amd/display/Makefile
> > > index 0d610cb376bb..3c44162ebe21 100644
> > > --- a/drivers/gpu/drm/amd/display/Makefile
> > > +++ b/drivers/gpu/drm/amd/display/Makefile
> > > @@ -26,6 +26,8 @@
> > >
> > >  AMDDALPATH =3D $(RELATIVE_AMD_DISPLAY_PATH)
> > >
> > > +subdir-ccflags-y +=3D -Werror -Wunused -Wmisleading-indentation
> > > +
> >
> > Care to enable this for the rest of amdgpu as well?  Or send out an
> > additional patch to do that?  Either way:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Alex
> >
> > >  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
> > >  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
> > >  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
> > > --
> > > 2.40.1
> > >
> >
