Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83BE65754B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiL1K3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1K3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:29:35 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B9DDC;
        Wed, 28 Dec 2022 02:29:34 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d185so15172825vsd.0;
        Wed, 28 Dec 2022 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojYNDiVvW5O96P8SY9WJxKmUEE42niI4l4BjCEll5Tc=;
        b=W8m7pH4Jzws/6d+Q2fA5u2Ife3Iz7M2qhrNmwh7UvjmwNNKq+NFtOuoNicXUK2TSxe
         o2s0uXpQFxooNZsUHZIwyAOZtx+Zogc0sfOz4q/NFPIMuceBOFXV5exCjprJTI+JUePv
         Umbk+CPxEm92GNcNJlkmgREeAfwmEmpXhi/RjwBRfbjhNpGI1t9V5JhC6ra/ug+GxoM+
         yrYsYGG6MxQhRs1l9x/x0Q2tD9SjAUWFoQPPyNOqTW9NyQ/sabyod5Tja+Uq5HprspsG
         UyrnR91tAzJyB1Smg0jbDzEDZKiWe9H66znA+nS6LYlzTUsi2XcATM5SvUWC82WxURH0
         sT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojYNDiVvW5O96P8SY9WJxKmUEE42niI4l4BjCEll5Tc=;
        b=EgyHom2ERsM3DE6NXkYOaIDWs1eZQCO+f7iWuv1Y8r4TWvmZ8bmzDsP4NHzOP+DRI8
         jxU2+da/aC9FYY5tg0oDSdaucZKv6OuSIv8LvO7aRQ39HlLTZUGDF+cIh+M6hERgzXen
         R5vv7mFBAX0VLaC1S76B1ceRwiLD5hYgUJ13+URXxHJBG9vDmTbXFdnycpf8EpijYlcT
         I2dlxJniJBn/qv+x707l4wSepjriURsyHcuguIDBao/L/ULx3iyU4rJ0ZGW/TRCzffyq
         12Bmr/ch3/nZGj34SzJsaEYNA8UWdE5qd9cggRQoF+JMj3x5ZB12jVIRdK5PHb37KZye
         a2LQ==
X-Gm-Message-State: AFqh2krAaxlxYFC8rVk1vnmwc28+DD2LkrJErY1LqhRoIjBKmyCCCGGa
        r7kHfSvaW5DocdkFbsWXYOjHT1XW9ICFBavwSKA=
X-Google-Smtp-Source: AMrXdXsNQGqcHh16rEam6d68yAikJ0QyFEiLfbX/FBIlndF+snOBA1R/3+TrtxdXmnLlItVjMv2rduXkI0Ce+X8DA5Q=
X-Received: by 2002:a05:6102:388:b0:3c6:6870:1435 with SMTP id
 m8-20020a056102038800b003c668701435mr1617707vsq.76.1672223373665; Wed, 28 Dec
 2022 02:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-2-linux.amoon@gmail.com>
 <ef20a7dfa027f1a5a24a515e347af10c06a4da85.camel@icenowy.me>
In-Reply-To: <ef20a7dfa027f1a5a24a515e347af10c06a4da85.camel@icenowy.me>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 28 Dec 2022 15:59:17 +0530
Message-ID: <CANAwSgSJ1SQXUovgM6FHUozr46C_CogLaAD4gf4ANNHXoav6ag@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys
 Logic hub controller
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Icenowy,

Thanks for the review comments

On Wed, 28 Dec 2022 at 15:38, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> =E5=9C=A8 2022-12-28=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:03 +0000=EF=
=BC=8CAnand Moon=E5=86=99=E9=81=93=EF=BC=9A
> > Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.0
> > root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index a9f831448cca..db009f3ef438 100644
> > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > @@ -16,6 +16,8 @@ properties:
> >    compatible:
> >      enum:
> >        - usb5e3,608
> > +      - genesys,usb5e3,610
> > +      - genesys,usb5e3,620
>
> I don't think genesys, is needed here because usb5e3 means USB VID
> 0x05e3, which is already linked to Genesys Logic.
>

Ok, I added this as genesys, is it part of the manufacturer or vendor name
which is most commonly used for adding vendor-specific compatible strings.

> In addition, the control logic of these two hubs are needed to be
> verified.

We were using gpio-hog to reset the USB hub, so now switch to USB onboard h=
ub

>
> And what's the status of the companion hub of the USB3 hub? Is it
> really a USB3-only hub, or is its USB2 part just equal to another USB3
> hub?
>
usb5e3,610 is USB 2.0 port hub present on Odroid C1 and Odroid C2 board

usb5e3,620 is USB 3.1 port hub present on Odroid N2.

> >
> >    reg: true
> >
>

Thanks
-Anand
