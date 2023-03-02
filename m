Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8CB6A8380
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCBN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCBN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:28:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32319695;
        Thu,  2 Mar 2023 05:28:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p6so16673558plf.0;
        Thu, 02 Mar 2023 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+2cOSAU7cCPB2Iw48oomRknv1SClnTidnPFnKWJLNQ=;
        b=eW3RE3hqtvdhDd7zz0lurZDgRMVwETomHOItnpCC42y5u1i638jbO1bJyicCDDpzBH
         g73xcNZfExTUDuxuWIPDTdJF5xYUnMD8WROtiCrsIpPRj4S4g1il2ToIBgN2t8d7Eth3
         5qRrXGMuG+qO405gdT85Ve/ZqHjg8m7Xo2cl0vCavTBJpsgmMszcqD1U/weS6Jo2mT5V
         5JV6TEimIB3b+Xvg/5pGrXXRnGMRfTQtGOGQJkUza0vyDUzP2HlzcCF3+u0aor9rGtUa
         9uofA2okzbFqNYKexeCxX5IEFD3bwUbQCmJaXTZp8IChyJhNJpyJsLBbomcXKtmxxnJ6
         1tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+2cOSAU7cCPB2Iw48oomRknv1SClnTidnPFnKWJLNQ=;
        b=Jgh/eRo3oFBvI7BZttjE210tP6HGRP0jXIt78q4ue/1B46vckPKMFtL2cEHM4az1id
         +iXWm/SIoNfelRrAd7j9zJp7Izo2wABrJHzsOLJ+2y7cuGfB6HpytVL13E9bT8zEkVRn
         4WNTBx0FUW1Vk592vRgm2XdCtwwEdCZqbqrRYAAYqXl3wBeGPiDRkkpeunoGng0E5sJz
         L+v9qEQjqQgQ5w+KBal726nE2VuLoAG+MjW5LPHUlqpBwX2ViE7iHB6wBbmrErE1r9VJ
         c885mAnT3lIADWdmZHQ4E+kQMoR84RUJzCcGwBUblNx8i/4eonoJzKaWXAa3FILepxYL
         uVmw==
X-Gm-Message-State: AO0yUKVkonqQ1meIBcOpMwdu4fsjo2Y1Xd7UlMEymqfkioKbeOmjQx0m
        605y+CWfvYnlhtuT0rTC7OGfwVcoiQ9RIdr+UPA=
X-Google-Smtp-Source: AK7set8oIhbXdukDoWxsfYM8ruHcaUg/sLM+TeAwHUGy4LjSmbgt1TA6GdpTN3Sll8FK0KxNFNQt828EB+N94DYECtE=
X-Received: by 2002:a17:903:2792:b0:194:6fc1:801f with SMTP id
 jw18-20020a170903279200b001946fc1801fmr3810927plb.6.1677763719390; Thu, 02
 Mar 2023 05:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20220717181000.1186373-1-aford173@gmail.com> <20220717181000.1186373-5-aford173@gmail.com>
 <20220718053721.GB7333@pengutronix.de>
In-Reply-To: <20220718053721.GB7333@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 2 Mar 2023 07:28:28 -0600
Message-ID: <CAHCN7xKKtCp52XVHd8_-+EvPvsx9hewsEdce=hsLov-0TY9dZA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: imx8mm-beacon: Enable Digitial Microphone
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jul 18, 2022 at 12:37=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.=
de> wrote:
>
> Hi Adam,
>
> On Sun, Jul 17, 2022 at 01:09:58PM -0500, Adam Ford wrote:
> > There is a PDM microphone port on the baseboard which is connected to t=
he
> > micfil controller.  Create a new sound card to support this interface.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi=
 b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > index 03266bd90a06..16444954f873 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > @@ -98,7 +98,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >               enable-active-high;
> >       };
> >
> > -     sound {
> > +     sound-codec {
> >               compatible =3D "fsl,imx-audio-wm8962";
> >               model =3D "wm8962-audio";
> >               audio-cpu =3D <&sai3>;
> > @@ -111,6 +111,18 @@ sound {
> >                       "AMIC", "MICBIAS",
> >                       "IN3R", "AMIC";
> >       };
> > +
> > +     sound-micfil {
> > +             compatible =3D "fsl,imx-audio-card";
> > +             model =3D "imx-audio-micfil";
> > +             pri-dai-link {
> > +                     link-name =3D "micfil hifi";
> > +                     format =3D "i2s";
> > +                     cpu {
> > +                             sound-dai =3D <&micfil>;
> > +                     };
> > +             };
> > +     };
>
> Note the micfil works well with the simple-audio-card driver which might
> be an alternative here.

Sascha,

Sorry to resurrect an old thread.

I tried using the simple-audio-card, but it doesn't present me with an
audio card.  I don't get errors, but I don't get a card either.  Can
you point me to an example where someone did this?  I added debug code
to the simple-audio-card and I migrated an existing card, and I see
the debug code for the wm8962 CODEC, but not the micfil.  The Micfil
works just fine with the imx-audio-card, but I don't mind using the
simple-audio-card if it makes more sense.

adam
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
