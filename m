Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F55660FC4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjAGPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjAGPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:01:41 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33E40C22;
        Sat,  7 Jan 2023 07:01:40 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id e2so983000uar.11;
        Sat, 07 Jan 2023 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkMPSY5sKQ0G3VOrU/JYEQvYOS+As5T7ufct2VUi/QM=;
        b=TNZk6gqUjOVJBmU7O/HMCzxN8LPAaAMpUKP+epKD9obgPAaNCz/sjeJriQazNYDTgI
         4Uf16VtaoRiBGkXEpp/+MJQRPGsidRVksdPATT0ooxmKWLwueysUXMFgMCuYDXM4ru/9
         Fh7sJe1YY8VU+8bxWJ0pSbs3Hp6oU/vJhJCoNqU8GSQvLyS2+mBiv7MhJV1tFg8ZQJYt
         UOF7izKu6Mq8Ee8zHLPvbF5uUi35UOfGU9MZoxiQWsMieCC5S8u1rvoXH9HFAbPbUBO0
         mU/YyS6weew+OFwoEZDdDRE1S8vMgcNQusx8y6m/+e/P2vpR5XonQcgOrYK97m3MTGth
         itaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkMPSY5sKQ0G3VOrU/JYEQvYOS+As5T7ufct2VUi/QM=;
        b=4qp1ZdoawckuGB1mvbeAFt5X6VaS7xY8ZcSIuOYXXjnUwpym1lrcqcEe8MS955f1M8
         +pEpMMgUJ5j89oDQPlp5RGHfmYIKQ7Kn56GPrMDPnRK3IHwj20KOj70iDrJxbODQqScl
         su9WWbD6F/1VoZNqv2NwDkY6wlnPpoAxg6OIQi7648KiCbaInJvNUtL+uD1vlKQftKrd
         nG4fOGQbt2xtMyjqdE4AYYGnZbSoRs5iGh/wmlb/2V1H4WxSp9EnQVnICcjZvRB1gWBD
         O5LINaAHjnwuSa9d0c/SV7mbUr3RRW1bAXD49KUHIsF7+2V0hjEd/pWs+r5mBHV8XIlB
         EbGA==
X-Gm-Message-State: AFqh2kr1nKHcw4DwpP7oWaeNGKiuvROpS+CxMG5yHHBgXpDbWsPDMnNA
        sYCN/nRxc+OCAnjsrFpWULt58fvn5tCYTcWcKW0zNvGvDk0=
X-Google-Smtp-Source: AMrXdXtpIdeGO3n0jLF4X9cDlM+2Oq6/kcUAXyuQTzqP0oBwwKEFDlsROPij5X64Oy6R89WuzpgNZUFDF7TVhjEZqNk=
X-Received: by 2002:ab0:4566:0:b0:418:b66a:6f26 with SMTP id
 r93-20020ab04566000000b00418b66a6f26mr6268456uar.21.1673103699191; Sat, 07
 Jan 2023 07:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-2-linux.amoon@gmail.com>
 <ef20a7dfa027f1a5a24a515e347af10c06a4da85.camel@icenowy.me>
 <CANAwSgSJ1SQXUovgM6FHUozr46C_CogLaAD4gf4ANNHXoav6ag@mail.gmail.com> <Y7YDwJX6aqa8vbQK@google.com>
In-Reply-To: <Y7YDwJX6aqa8vbQK@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:31:23 +0530
Message-ID: <CANAwSgTVnQXGoOfuxmwT7zCMJMY0Hw+uyQx126kNPL2WKGR8Hg@mail.gmail.com>
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

Thanks for the review comments

On Thu, 5 Jan 2023 at 04:25, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Dec 28, 2022 at 03:59:17PM +0530, Anand Moon wrote:
> > Hi Icenowy,
> >
> > Thanks for the review comments
> >
> > On Wed, 28 Dec 2022 at 15:38, Icenowy Zheng <uwu@icenowy.me> wrote:
> > >
> > > =E5=9C=A8 2022-12-28=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:03 +0000=
=EF=BC=8CAnand Moon=E5=86=99=E9=81=93=EF=BC=9A
> > > > Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.=
0
> > > > root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
>
> nit: QFN 76 is one of the package options of the GL3523, I expect this
> binding to be applicable as well for other GL3523 variants, so I'd sugges=
t
> to drop the suffix. Not sure what 'OHG' stands for, the Genesys website
> only lists a GL852G hub with different package types (none of them 'OHG')=
,
> so I'd say drop the suffix unless it is known that 'OHG' variant uses
> a different product id than other GL852G variants
>

Yes, I will be sure to do this reference, I just picked these from the
board schematics.

> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > index a9f831448cca..db009f3ef438 100644
> > > > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > > > @@ -16,6 +16,8 @@ properties:
> > > >    compatible:
> > > >      enum:
> > > >        - usb5e3,608
> > > > +      - genesys,usb5e3,610
> > > > +      - genesys,usb5e3,620
> > >
> > > I don't think genesys, is needed here because usb5e3 means USB VID
> > > 0x05e3, which is already linked to Genesys Logic.
> > >
> >
> > Ok, I added this as genesys, is it part of the manufacturer or vendor n=
ame
> > which is most commonly used for adding vendor-specific compatible strin=
gs.
>
> That doesn't follow the generic USB binding, please drop 'genesys,'.
>

Yes, I will drop this in the next version.

> > > In addition, the control logic of these two hubs are needed to be
> > > verified.
> >
> > We were using gpio-hog to reset the USB hub, so now switch to USB onboa=
rd hub
> >
> > >
> > > And what's the status of the companion hub of the USB3 hub? Is it
> > > really a USB3-only hub, or is its USB2 part just equal to another USB=
3
> > > hub?
> > >
> > usb5e3,610 is USB 2.0 port hub present on Odroid C1 and Odroid C2 board
> >
> > usb5e3,620 is USB 3.1 port hub present on Odroid N2.
>
> Like Icenowy I would expect the GL3523 to provide also a 2.0 hub.
>
> What is the output of 'lsusb' on the Odroid N2?

alarm@odroid-n2:~$ lsusb -tv
/:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
        ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
/:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub

Thanks

-Anand
