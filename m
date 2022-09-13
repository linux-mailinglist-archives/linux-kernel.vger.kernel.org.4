Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD45B650B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIMBTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIMBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:19:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004F51A2E;
        Mon, 12 Sep 2022 18:19:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so18342215wrx.7;
        Mon, 12 Sep 2022 18:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=2ZtmY3p3zkbf0/C0gK6bwRBWycdaKIqBbOKnACUNU7M=;
        b=AL1BVqi9hIL/x7zgbavqIgUuEnM/XAicWtI2yIwukVJlelv1kcBbY8Vc5ZsdW3SVzI
         hHA8Zzxo+gu1C9blS6eroeADuUZlVh392GlRjnMukUJ0ViPZtCpd63noNlTx9u19DlCS
         HpFQn81yACvNelLfqQW8u1WCupuxDud9MGyDlJygbuPytdDcZGLTS/Xeuo674CWnFGmv
         RO07CpdwKt5qZszkzUtc3kkHPwYffkBDIpKa1PiuAAwlb6X+0atZ1eWfzMxgwvQPM5hg
         8B82CKlGQYp8T1FXw9ZWFnTviSN5t6lGpwOJhnXYxx22tKHujmMLUTCIls+8szw3onL3
         RPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2ZtmY3p3zkbf0/C0gK6bwRBWycdaKIqBbOKnACUNU7M=;
        b=DZkA8mRD7R7I+7RHo6KIIV3mtd2kKnZWN6WYjSHbMMGpqfYE8JykpxwOXz5dupoFI7
         zmZy5aSU0Ee1cNJr1vi1eXs1bgavPihNLRzbBl6wzemnNS0mbQncM6yHomE7u397Ogt9
         fH4lDntHPnjcA9QiLJ5CMAznQrZQEBTmHFwaQpFdPSWHaxQYm/VEjKHHj2DAF795Gpdt
         7YO6cfMNUgfdFr+PTqOW4BOYfxH1Z43pzNc64sEPF+gt/Ue5H3S5hFYWJklyFratEBF+
         JCjqjX3uJqLb0x/+mLlbyrKTUTAli8RnX5q5eDPwAqxyVyjg5iRjHXFgvd3Q0Lop/Cp1
         Q7cw==
X-Gm-Message-State: ACgBeo3eW2ibB1yJ3XR7FsjY5PRyGqfEPZVcQOmwdGS+jyY5LbO1dwtd
        JY2BUVLCdX8/nA2F/yDTl09tV7SuYdb9ECxdKP8=
X-Google-Smtp-Source: AA6agR6464tWOzKavoMdE8q5Ua3C/+achxMvT+dskDhj0QwzbEJRKMn7YKPLgkJBV+MiLwFrGmgAMj53rsjWGqW5jag=
X-Received: by 2002:a5d:4dcd:0:b0:228:d1e4:9cf1 with SMTP id
 f13-20020a5d4dcd000000b00228d1e49cf1mr15876557wru.182.1663031945255; Mon, 12
 Sep 2022 18:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
 <1661742391-11378-4-git-send-email-u0084500@gmail.com> <20220912111201.nxjgqzpa7pftzwlb@mercury.elektranox.org>
 <20220912112955.cpbzov6h7am4m37b@mercury.elektranox.org>
In-Reply-To: <20220912112955.cpbzov6h7am4m37b@mercury.elektranox.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 13 Sep 2022 09:18:53 +0800
Message-ID: <CADiBU39RHWHUFQfnnf-rBBtVh3q4G9ssv7yROFhQCKCXx-kX0A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=B9=B4=
9=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A7:29=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Mon, Sep 12, 2022 at 01:12:01PM +0200, Sebastian Reichel wrote:
> > On Mon, Aug 29, 2022 at 11:06:31AM +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Document the settings exported by rt9471 charger driver through sysfs=
 entries:
> > > - sysoff_enable
> > > - charge_term_enable
> > > - port_detect_enable
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 44 +++++++++++++++++++=
++++++++++
> > >  1 file changed, 44 insertions(+)
>
> I forgot to mention: custom driver properties are described in their
> own files, see Documentation/ABI/testing/sysfs-class-power-*. But
> are to be avoided if possible. So first of all I want to make sure
> you actually need any of these.
>
OK, it means I need to new a file  sysfs-class-power-rt9471.
> -- Sebastian
>
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentat=
ion/ABI/testing/sysfs-class-power
> > > index a9ce63c..1f8afe5 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -768,3 +768,47 @@ Description:
> > >
> > >             Access: Read
> > >             Valid values: 1-31
> > > +
> > > +What:              /sys/class/power_supply/rt9471-*/sysoff_enable
> > > +Date:              Sep 2022
> > > +KernelVersion:     6.1
> > > +Contact:   ChiYuan Huang <cy_huang@richtek.com>
> > > +Description:
> > > +           This entry allows enabling the sysoff mode of rt9471 char=
ger devices.
> > > +           If enabled and the input is removed, the internal battery=
 FET is turned
> > > +           off to reduce the leakage from the BAT pin. See device da=
tasheet for details.
> > > +
> > > +           Access: Read, Write
> > > +           Valid values:
> > > +           - 1: enabled
> > > +           - 0: disabled
> >
> > This is not a very good description of what the control does. When
> > do you expect users to control this?
When products leaves the factory and enter shipping stage.
> >
> > > +What:              /sys/class/power_supply/rt9471-*/charge_term_enab=
le
> > > +Date:              Sep 2022
> > > +KernelVersion:     6.1
> > > +Contact:   ChiYuan Huang <cy_huang@richtek.com>
> > > +Description:
> > > +           This entry allows enabling the charge termination functio=
n of rt9471 charger
> > > +           devices. If enabled, the battery charging current, and th=
e battery voltage
> > > +           reachs charge termination condition, the internal battery=
 FET will be turned off
> > > +           to optimize the battery life. See device datasheet for de=
tails.
> > > +
> > > +           Access: Read, Write
> > > +           Valid values:
> > > +           - 1: enabled
> > > +           - 0: disabled
> >
> > Just write 0 to .../charge_term_current to disable it.
> > No need for a custom property.
OK, I will merge this 'TE' switch directly into 'charge_term_current' prope=
rty.
> >
> > > +What:              /sys/class/power_supply/rt9471-*/port_detect_enab=
le
> > > +Date:              Sep 2022
> > > +KernelVersion:     6.1
> > > +Contact:   ChiYuan Huang <cy_huang@richtek.com>
> > > +Description:
> > > +           This entry allows enabling the USB BC12 port detect funct=
ion of rt9471 charger
> > > +           devices. If enabled and VBUS is inserted, device will sta=
rt to do the BC12
> > > +           port detect and report the usb port type when port detect=
 is done. See
> > > +           datasheet for details.
> > > +
> > > +           Access: Read, Write
> > > +           Valid values:
> > > +           - 1: enabled
> > > +           - 0: disabled
> >
> > Why would one want to disable this?
> > Can't the driver just enable it unconditionally?
The current product may use the typec port.
This make the user can control bc12 port detection switch.
If bc12 port detect always on, for some cases like as power role swap
or hard reset, it will cause bc12 port detect be retriggered.
USB communication will be affected.

> >
> > -- Sebastian
>
>
