Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D29662DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjAIRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjAIRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:52:32 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75258718B9;
        Mon,  9 Jan 2023 09:48:54 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id i185so9476218vsc.6;
        Mon, 09 Jan 2023 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdV2vwGnOEmlhv8n7U93QPrw3soIxglDsMqqZoAGNCs=;
        b=OvViZphfr5738vJta/xF70K51WoKQjxplA5/RJo/AcybHvHZvOUTOU7+LAMoYwF4u2
         ie9ciq6sqY9Ob/ZMFTTQDMoSVXymbBeob6u+51pohUsru/rYxZaPMynfqEmAGSur41kD
         bxCbP8x+nMSayS1W8GGTy6p54I/KV+X3oQrVwIdzDbTNCe1U+PsJp5ErptBT0L6aIaWt
         1b1Hsyzqf0rUU2a0DzrvkJOS2gatasS6ig+OSKak3e81prvLOlx9VL4+v6ETNd537Rp5
         XGFV01P0QgiebzdQGPGyibWvcAiaJHoFEWbmVgm8r7nPr+uJMP+uqaGbsBaRSfFi78tS
         dmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdV2vwGnOEmlhv8n7U93QPrw3soIxglDsMqqZoAGNCs=;
        b=DfDVE4lPJ+yDjSeZB8atCjIIZjsg66F0Fx6G7aFSN49sadcuRh5HWhHCcbwf5XFdn3
         z8zF1fg/ZVFXk1lJa2r1spblwn3F0SVASy7TrBogaNmp5Au8Cfi4jQ5haarXYITG4RyJ
         uDOqUfpRnC8VORWAMPWlPbsVIba+O1KzJRRPhxVgkwur3xNtu4E7KT8psDx2hUCfw/sL
         jdgXenX5BI19WCCim2LzBepJxPOhlw10VYZKQNKrIrBtsWEvBsy0z2s393bIUL1YxyCo
         q43DaR3P85Xc5AN7wo5vXUchorurR4IXoJKSjjQrQJLOgVFhFFOLDQxaL+g4MNqEJ7Tt
         gp3Q==
X-Gm-Message-State: AFqh2kont9pYdOyAdit/e7qKshydfztufczPmxaX1TyYecra/z61TIyg
        SNrcJAbLqPd1RQieJiX/1PKUDQEvSLdzPHDRv/w=
X-Google-Smtp-Source: AMrXdXvBp1DINcXOCvLmPxiDkUAxnf/FP+Y6732tNVN6rP/zqZs1L1FGyO5PAdWj/z0iT8oGfYrhW/1lEXVhB44r4Cs=
X-Received: by 2002:a67:5c03:0:b0:3ce:a7c5:3757 with SMTP id
 q3-20020a675c03000000b003cea7c53757mr3875326vsb.63.1673286516391; Mon, 09 Jan
 2023 09:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-2-linux.amoon@gmail.com>
 <ef20a7dfa027f1a5a24a515e347af10c06a4da85.camel@icenowy.me>
 <CANAwSgSJ1SQXUovgM6FHUozr46C_CogLaAD4gf4ANNHXoav6ag@mail.gmail.com>
 <Y7YDwJX6aqa8vbQK@google.com> <CANAwSgTVnQXGoOfuxmwT7zCMJMY0Hw+uyQx126kNPL2WKGR8Hg@mail.gmail.com>
 <Y7xA0nO53cBRetz4@google.com>
In-Reply-To: <Y7xA0nO53cBRetz4@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 9 Jan 2023 23:18:19 +0530
Message-ID: <CANAwSgR1ymx_2QK5Mi_1eS+LbTa2-SdQ+1dQ4hfrwNDLU_DsAg@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys
 Logic hub controller
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Matthias,

On Mon, 9 Jan 2023 at 21:59, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Sat, Jan 07, 2023 at 08:31:23PM +0530, Anand Moon wrote:
> > Hi Matthias,
> >
> > Thanks for the review comments
> >
> > On Thu, 5 Jan 2023 at 04:25, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> > >
> > > On Wed, Dec 28, 2022 at 03:59:17PM +0530, Anand Moon wrote:
> > > > Hi Icenowy,
> > > >
> > > > Thanks for the review comments
> > > >
> > > > On Wed, 28 Dec 2022 at 15:38, Icenowy Zheng <uwu@icenowy.me> wrote:
> > > > >
> > > > > =E5=9C=A8 2022-12-28=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:03 +0=
000=EF=BC=8CAnand Moon=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub US=
B 2.0
> > > > > > root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
> > >
> > > nit: QFN 76 is one of the package options of the GL3523, I expect thi=
s
> > > binding to be applicable as well for other GL3523 variants, so I'd su=
ggest
> > > to drop the suffix. Not sure what 'OHG' stands for, the Genesys websi=
te
> > > only lists a GL852G hub with different package types (none of them 'O=
HG'),
> > > so I'd say drop the suffix unless it is known that 'OHG' variant uses
> > > a different product id than other GL852G variants
> > >
> >
> > Yes, I will be sure to do this reference, I just picked these from the
> > board schematics.
> >
> > > > > >
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 =
++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > > > b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > > > index a9f831448cca..db009f3ef438 100644
> > > > > > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > > > @@ -16,6 +16,8 @@ properties:
> > > > > >    compatible:
> > > > > >      enum:
> > > > > >        - usb5e3,608
> > > > > > +      - genesys,usb5e3,610
> > > > > > +      - genesys,usb5e3,620
> > > > >
> > > > > I don't think genesys, is needed here because usb5e3 means USB VI=
D
> > > > > 0x05e3, which is already linked to Genesys Logic.
> > > > >
> > > >
> > > > Ok, I added this as genesys, is it part of the manufacturer or vend=
or name
> > > > which is most commonly used for adding vendor-specific compatible s=
trings.
> > >
> > > That doesn't follow the generic USB binding, please drop 'genesys,'.
> > >
> >
> > Yes, I will drop this in the next version.
> >
> > > > > In addition, the control logic of these two hubs are needed to be
> > > > > verified.
> > > >
> > > > We were using gpio-hog to reset the USB hub, so now switch to USB o=
nboard hub
> > > >
> > > > >
> > > > > And what's the status of the companion hub of the USB3 hub? Is it
> > > > > really a USB3-only hub, or is its USB2 part just equal to another=
 USB3
> > > > > hub?
> > > > >
> > > > usb5e3,610 is USB 2.0 port hub present on Odroid C1 and Odroid C2 b=
oard
> > > >
> > > > usb5e3,620 is USB 3.1 port hub present on Odroid N2.
> > >
> > > Like Icenowy I would expect the GL3523 to provide also a 2.0 hub.
> > >
> > > What is the output of 'lsusb' on the Odroid N2?
> >
> > alarm@odroid-n2:~$ lsusb -tv
> > /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
> >     ID 1d6b:0003 Linux Foundation 3.0 root hub
> >     |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
> >         ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
> > /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/2p, 480M
> >     ID 1d6b:0002 Linux Foundation 2.0 root hub
> >     |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
> >         ID 05e3:0610 Genesys Logic, Inc. Hub
>
> Thanks. So it looks like 0x0610 is the product id of the USB 2.0 portion
> of the GL3523. From this patch it seems the GL852G uses the same product
> id?

Yes, it looks correct as per the lsusb output

Thanks
-Anand
