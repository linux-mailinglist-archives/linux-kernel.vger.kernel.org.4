Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151BD6058C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJTHjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiJTHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:39:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862C173595;
        Thu, 20 Oct 2022 00:39:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1673753wmr.2;
        Thu, 20 Oct 2022 00:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5sj8vy0lo4/X29EyGRfTJl32ojSVJoXPxFiY59mPF4=;
        b=a9c3CbY2ANrqRar4Qyis0fMk7Kv8z6Fd+XwUK+wXTfXqTTP+6kRQErIUxxRwHQq4qz
         HNdVyu9S1dLBSVCXbemLWq3HmbI0SGDoG6xHACsjn4nY8kMQsEuXVj6KxKfUtjf+5iTN
         BrKh7TX9YlrT0TdVnkUzgk/V8gFiJl8wuIq3dsoM+xkbM/czzlgQFKRG7NvpmZsGOlnt
         p1r4IWZjeXFMvAF8qcDSFLRURsPY3fDVwHf3NIaqZdQxmi8XYMOftN0sEcjTQwwNdeVt
         mWWhWrxjd5S921Omq1wgo1aBrXxbH2IZEtnrEqvnB+190Q+OknFdp/CeFKfC4lbcdBJ+
         QA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5sj8vy0lo4/X29EyGRfTJl32ojSVJoXPxFiY59mPF4=;
        b=UkH2GsLH7T9F5SLl6HwCSkTRMu9zPIvVgFNpF2Bw8L8qJwKaCLq7SkOAHnii0xfFYy
         Px/Uwp8HCZHjPh1ezVJGMHgw5KUNklXl9NGmWC1qMugk8Whx/gc1o/wTkm5RcPzIpsmp
         Hqp2EjSyEttk9IcOzdS18CLr4gFBYufo+8Cfu/YF4ZYvLAclJEraDsDf/otAAcFGmpbM
         9TuyKMqfJUSepMGBmvqh6aXeXinMPzL5KoJ1DtFV+TxeO9W1tzcIEkI4CKJS4UvLs0i/
         77XuYhZ1oQiC/KZIpdS6WJ87bUUG8Lq/zhCfLypUq5yY1ppZEmQnhtfgZhc1UlNbseVy
         NQGQ==
X-Gm-Message-State: ACrzQf376MRsJsnhMQc0AyTkO1URegHeS7mnkUTExNzeB/BJfU/uEza+
        Qw++8Cd7dIwF9UTUmBJp6HKubKtqjH8Hv+6y8rk=
X-Google-Smtp-Source: AMsMyM6CYuXUKQnz9imZsrnvD/sFgtGBZDiVqH6HH1iiL+D+jS7ihCLr3LidgnaBMq26osrXKLWwFHa3c397OH0dl4w=
X-Received: by 2002:a05:600c:198d:b0:3b4:a62c:a085 with SMTP id
 t13-20020a05600c198d00b003b4a62ca085mr27803199wmq.140.1666251539738; Thu, 20
 Oct 2022 00:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-4-git-send-email-u0084500@gmail.com> <20220916180823.p672rojsrjbpy4ft@mercury.elektranox.org>
 <CADiBU39FMkDOrMHXTQF+0JGX2tDn_iVXCb19jM6MopnKmaXOpQ@mail.gmail.com>
 <20221001205800.msywk4yvqgegjqpe@mercury.elektranox.org> <CADiBU38vLBfvpFuOOikdZ5XsMGqCaq7hh+ZcjBx85ksw6dbShQ@mail.gmail.com>
In-Reply-To: <CADiBU38vLBfvpFuOOikdZ5XsMGqCaq7hh+ZcjBx85ksw6dbShQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 20 Oct 2022 15:38:47 +0800
Message-ID: <CADiBU3-umFRQYx7Xk003JgTRYrS7eGeCj_At7UookCa0cQVzGw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Documentation: power: rt9471: Document exported
 sysfs entries
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
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

Hi,
ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B410=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=B9=
=B410=E6=9C=882=E6=97=A5 =E9=80=B1=E6=97=A5 =E5=87=8C=E6=99=A84:58=E5=AF=AB=
=E9=81=93=EF=BC=9A
> >
> > Hi,
> >
> > On Mon, Sep 19, 2022 at 09:11:09AM +0800, ChiYuan Huang wrote:
> > > Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=
=B9=B49=E6=9C=8817=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:19=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > On Thu, Sep 15, 2022 at 12:30:15AM +0800, cy_huang wrote:
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > Document the settings exported by rt9471 charger driver through s=
ysfs entries:
> > > > > - sysoff_enable
> > > > > - port_detect_enable
> > > > >
> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > ---
> > > > > Since v5:
> > > > > - Recover all the change in sysfs-class-power.
> > > > > - New a sysfs-class-power-rt9471 file.
> > > > > - Remove 'charge_term_enable' sysfs entry, directly integrate it =
in
> > > > >   'charge_term_current' power supply property control.
> > > > >
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-class-power-rt9471 | 29 ++++++++=
++++++++++++++
> > > > >  1 file changed, 29 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-r=
t9471
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b=
/Documentation/ABI/testing/sysfs-class-power-rt9471
> > > > > new file mode 100644
> > > > > index 00000000..ad5b049
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> > > > > @@ -0,0 +1,29 @@
> > > > > +What:                /sys/class/power_supply/rt9471-*/sysoff_ena=
ble
> > > > > +Date:                Oct 2022
> > > > > +KernelVersion:       6.1
> > > > > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > > > > +Description:
> > > > > +             This entry allows enabling the sysoff mode of rt947=
1 charger devices.
> > > > > +             If enabled and the input is removed, the internal b=
attery FET is turned
> > > > > +             off to reduce the leakage from the BAT pin. See dev=
ice datasheet for details.
> > > > > +             It's commonly used when the product enter shipping =
stage.
> > > > > +
> > > > > +             Access: Read, Write
> > > > > +             Valid values:
> > > > > +             - 1: enabled
> > > > > +             - 0: disabled
> > > >
> > > > I still fail to see why this needs to be controllable at runtime.
> > > > This looks like a hardware property. Are there any known products,
> > > > which need this disabled?
> > > It's just a switch, actually 'disabled' is not needed.
> > > For the enabled case, mostly used in below scenarios
> > > 1. Online testing, USB IN -> Factory testing -> write 1 to enable ->
> > > USB out -> immediately VSYS off -> pack
> > > 2. Offline testing no vbus -> Factory testing -> write 1 to enable ->
> > > immediately VSYS off -> pack
> > >
> > > The 'disable" can use to cancel the shipping mode in case 1 before US=
B out.
> > > It's more like the testing.
> > >
> > > Like as you said, shipping BATFET_OFF is all the hardware behavior.
> > > To leave this mode after VSYS off, there're three ways
> > > 1. power key pressed
> > > 2. VBUS IN
> > > 3. control BATFET_OFF to 0 (But it need SOC to be alive, at the time,
> > > VSYS off, no one can execute this I2C command)
> >
> > If factory testing and preperation is the only use case, I don't
> > think exposing this in sysfs and creating userspace ABI is worth
> > it. Just tell factory to use i2c-dev and poke the correct registers.
> >
> I agree your comment if there's only this case will use it.
>
> So I ask our HW members about this.
> They said there's still one case I didn't consider about.
> It's the dual charger scenario.
> If the charging process is entering CV mode, the slave charger is no
> need to join the charging.
> Then in common case, slave charger need to minimize the battery leakage.
> And the BATFET_OFF is needed to lower the battery leakage.
>
> They think this sysfs entry is needed. Can this persuade you?
>
> > > If what you care is no need to mention 'disable', then just remove it=
.
> > > It's fine.
> > > >
> > > > > +What:                /sys/class/power_supply/rt9471-*/port_detec=
t_enable
> > > > > +Date:                Oct 2022
> > > > > +KernelVersion:       6.1
> > > > > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > > > > +Description:
> > > > > +             This entry allows enabling the USB BC12 port detect=
 function of rt9471 charger
> > > > > +             devices. If enabled and VBUS is inserted, device wi=
ll start to do the BC12
> > > > > +             port detect and report the usb port type when port =
detect is done. See
> > > > > +             datasheet for details. Normally controlled when Typ=
eC/USBPD port integrated.
> > > > > +
> > > > > +             Access: Read, Write
> > > > > +             Valid values:
> > > > > +             - 1: enabled
> > > > > +             - 0: disabled
> > > >
> > > > So basically this depends on the hardware integration (e.g. it
> > > > should be disabled when power source is a DC barrel jack instead
> > > > of USB) and is not supposed to change at all during runtime? Then
> > > > the information wether it needs to be enabled should be derived
> > > > from the device tree.
> > >
> > > It's a switching charger integrates OTG boost.
> > > For the case 'DC Jack', there's no need to use this kind of product.
> > >
> > > With typec integration, at most time, it still need bc12 to be enable=
d
> > > by default. Just in some case, like as power role swap (SNK -> SRC ->=
 SNK),
> > > to automatically identify the USB port, this may interrupt USB commun=
ication.
> > >
> > > So as my understanding, keep it enabled by default, just in some case=
,
> > > it my need to control at runtime.
> >
> > This should be part of the description. You can drop the sentence
> > "Normally controlled when TypeC/USBPD port integrated.", since
> > that's hard to comprehend. Instead add the information that this
> > is supposed to be always enabled, but can be disabled to avoid
> > USB link loss (?) when doing a USB PD role swap.
> >
> Thanks for the comment.
>
> I'll rewrite it as below
> 'It's supposed to be always enabled, but can be disabled to avoid usb
> link interruption especially when doing a USBPD 'power' role swap.'
>
> Sorry, due to the long reply period, I already sent v6/v7/v8 to fix
> some coding like as missing header and irq wakeup check.
> Actually only missing header change is needed.
> Please ignore these noise.
>
> And after the sysfs reviewing is finished, you can just review the revisi=
on v9.

I'm preparing the final patch.
2 more weeks past, now only one question is left for rt9471 ABI document.
After my explanation, is 'to keep sysoff_enable" acceptible?
Or no more discussion, just delete it?

> Thanks.
> > -- Sebastian
