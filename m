Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4645BC0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiISBL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiISBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:11:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3D13F61;
        Sun, 18 Sep 2022 18:11:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n10so14544669wrw.12;
        Sun, 18 Sep 2022 18:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pzIUOyVLtSPMVDAuIWcWbNx/UCTO3gkibWwLDlz6q7A=;
        b=cao8a9Up8/LvLn/kMNo36sXtO7qaFWcdSlkGPMSrYBy37o7qTsznlDbqCTVsct4Heo
         Q2+7mS45l0mgmsxPxzRxHM5QrqZTLVqZu02/DPqZNilFw5fQIGHudkKnQwtPRvyGasWy
         DDsG92tOzLCcTzPG18vysLRYasAa01J8/j4rS4DC566CZa+6uY59Bhjr5lNiN6ZhU9+q
         +BbX5f8InGK0PX4zsShysNiAjT+rqIjHCQXWgs4gexnvkztYFVVopIKftKDWSBipXXvo
         ZUN1Vht5oEv153jgVkLPwM+cm+fqgQ/L+PbAj4TvpqJTG/XKpWvsSxa7qsV6SyifDk3S
         hHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pzIUOyVLtSPMVDAuIWcWbNx/UCTO3gkibWwLDlz6q7A=;
        b=oO1Fu3U2AJtqtS6RMJ72d5M+Br06xLb7hJ80K5Yl+Pi4aohCVKz4EY2+NWyScxgDRQ
         nGIaP4ZBH7c3oIIQ9802b5l1a/Tsa2FdycLfORPz2XrIFV5z32xZMJE0yOdg9L7HQ5z0
         gB1hamvOwn01vJO/m3wVB06Yf3Zj90oUD1bCG6oYycwM7I9KmNgNx68c9lynf/Bkksqu
         zA0UGBhdKb5XcOG6Vl1x+G6TstRjFs40HoKM9RTdiw1fMnZ4SJWsp2KBYq+nga4V6X81
         IjgnovD6UL1dfPvVVVza5lHEvVaqS/T61orGxY0aB/nkcEm5z0DHs6PN1uQPjnXtG1GC
         ghxA==
X-Gm-Message-State: ACrzQf3jM/O8zOTphz9Oo7Cy/odkkxIyLip0Nbx9rtsq0vMHF9eZmOkj
        fRvZ/SN9U6PCYWCzpodVB0aePS8T7BTUpbKrX0o=
X-Google-Smtp-Source: AMsMyM7WN5f8Ug1Ea5BJazc/zVFEK63qxwuMQkKLG07ooIeW8e9cHYmbfFciRTCRePjVa9epNTYJofgLT1gKli0YupU=
X-Received: by 2002:a05:6000:1f8e:b0:22a:ff55:ea48 with SMTP id
 bw14-20020a0560001f8e00b0022aff55ea48mr1287516wrb.121.1663549881082; Sun, 18
 Sep 2022 18:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-4-git-send-email-u0084500@gmail.com> <20220916180823.p672rojsrjbpy4ft@mercury.elektranox.org>
In-Reply-To: <20220916180823.p672rojsrjbpy4ft@mercury.elektranox.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 19 Sep 2022 09:11:09 +0800
Message-ID: <CADiBU39FMkDOrMHXTQF+0JGX2tDn_iVXCb19jM6MopnKmaXOpQ@mail.gmail.com>
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

Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=B9=B4=
9=E6=9C=8817=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:19=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Thu, Sep 15, 2022 at 12:30:15AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Document the settings exported by rt9471 charger driver through sysfs e=
ntries:
> > - sysoff_enable
> > - port_detect_enable
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v5:
> > - Recover all the change in sysfs-class-power.
> > - New a sysfs-class-power-rt9471 file.
> > - Remove 'charge_term_enable' sysfs entry, directly integrate it in
> >   'charge_term_current' power supply property control.
> >
> > ---
> >  Documentation/ABI/testing/sysfs-class-power-rt9471 | 29 ++++++++++++++=
++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Docum=
entation/ABI/testing/sysfs-class-power-rt9471
> > new file mode 100644
> > index 00000000..ad5b049
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> > @@ -0,0 +1,29 @@
> > +What:                /sys/class/power_supply/rt9471-*/sysoff_enable
> > +Date:                Oct 2022
> > +KernelVersion:       6.1
> > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > +Description:
> > +             This entry allows enabling the sysoff mode of rt9471 char=
ger devices.
> > +             If enabled and the input is removed, the internal battery=
 FET is turned
> > +             off to reduce the leakage from the BAT pin. See device da=
tasheet for details.
> > +             It's commonly used when the product enter shipping stage.
> > +
> > +             Access: Read, Write
> > +             Valid values:
> > +             - 1: enabled
> > +             - 0: disabled
>
> I still fail to see why this needs to be controllable at runtime.
> This looks like a hardware property. Are there any known products,
> which need this disabled?
It's just a switch, actually 'disabled' is not needed.
For the enabled case, mostly used in below scenarios
1. Online testing, USB IN -> Factory testing -> write 1 to enable ->
USB out -> immediately VSYS off -> pack
2. Offline testing no vbus -> Factory testing -> write 1 to enable ->
immediately VSYS off -> pack

The 'disable" can use to cancel the shipping mode in case 1 before USB out.
It's more like the testing.

Like as you said, shipping BATFET_OFF is all the hardware behavior.
To leave this mode after VSYS off, there're three ways
1. power key pressed
2. VBUS IN
3. control BATFET_OFF to 0 (But it need SOC to be alive, at the time,
VSYS off, no one can execute this I2C command)

If what you care is no need to mention 'disable', then just remove it.
It's fine.
>
> > +What:                /sys/class/power_supply/rt9471-*/port_detect_enab=
le
> > +Date:                Oct 2022
> > +KernelVersion:       6.1
> > +Contact:     ChiYuan Huang <cy_huang@richtek.com>
> > +Description:
> > +             This entry allows enabling the USB BC12 port detect funct=
ion of rt9471 charger
> > +             devices. If enabled and VBUS is inserted, device will sta=
rt to do the BC12
> > +             port detect and report the usb port type when port detect=
 is done. See
> > +             datasheet for details. Normally controlled when TypeC/USB=
PD port integrated.
> > +
> > +             Access: Read, Write
> > +             Valid values:
> > +             - 1: enabled
> > +             - 0: disabled
>
> So basically this depends on the hardware integration (e.g. it
> should be disabled when power source is a DC barrel jack instead
> of USB) and is not supposed to change at all during runtime? Then
> the information wether it needs to be enabled should be derived
> from the device tree.
It's a switching charger integrates OTG boost.
For the case 'DC Jack', there's no need to use this kind of product.

With typec integration, at most time, it still need bc12 to be enabled
by default.
Just in some case, like as power role swap (SNK -> SRC -> SNK), to
automatically identify the USB port,
this may interrupt USB communication.

So as my understanding, keep it enabled by default, just in some case,
it my need to control at runtime.
>
> -- Sebastian
