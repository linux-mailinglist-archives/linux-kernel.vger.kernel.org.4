Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CA5E81B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiIWSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiIWSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:23:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44E113B51;
        Fri, 23 Sep 2022 11:23:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z2so1349124edi.1;
        Fri, 23 Sep 2022 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=33LjaNk1Tjca6dUzmO0Adf4kxIK8nCjhuFIJU9mQ4Eg=;
        b=lQcqH4KRF+rxXiS6T2p0DEjlyIn7bhnOAeOkm7j+nt8p/XJ74lq5GRRpa6ngtGOYXa
         GxMXpdPNeLcqatOyg/OS9FAlZzYQlEH82qhgw7Gks2mMuySztgEiwsRx75bHG5qrkDJ6
         23gzU+XBrfuEYxN/2DiADScTX19E2TM6lvRK8IK/ZneQqlysQT5uPn0Kx6GDQSgtGj4E
         0P1eLiSgRqZt0FxKQ5zmL1ZtJNyant/S7nvVUIxB4aurZnXJOFZIzh4IhdV6hbLpMvFc
         OYBAOo7SVcoIhDyq8glts+2d3DpOG3brAMh2Fi5Htf09/CiCya1b0iXnbCgNmrZ5OzOW
         bJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=33LjaNk1Tjca6dUzmO0Adf4kxIK8nCjhuFIJU9mQ4Eg=;
        b=AuKzPWZXW5f7cb51e/syYZaEXpt48mpKasxlhdfbAeC0iiupM5waVs6kRZuruCQzW0
         sgmShqjNcg2NUfmDKxRzoMZfQ4zBrNI9UvXxVJC3T0hrPZhRxZgJAl7qbHubjQv0BSyZ
         b+g9u1uh5ivDl9kFZEq/m5Vt1wDBEvEWP4SvUrfc0ancwHFUKsjguQSw6ywGNl/t2Tpw
         +9lnCo3MnZMXym4fIa27qn5ulekptB6y+yVjbghSfzbCkyh2+Jp0p32mdWbsK/hjlVE4
         OghdARSsslBFXmN5hkmnotLT+7BRBkmRBcEW6KwpDbHlGcf9hdZM9kx4hFRDbJIz24GV
         0AgQ==
X-Gm-Message-State: ACrzQf3sn7J+aQpARdt/VKRANOxPh52K2wwVeVY8sGZ7aWRRXIa4Lj7h
        mKiIXRa8MglkiY3U5voN8pKTDr561rGa0AXtGd4=
X-Google-Smtp-Source: AMsMyM6J+UOiDUMskTWjkScneqvdtDj38aZ28Cio+6uZe//hW798R98NmXUKEVEJUwAz7WcAQbWues5aRWfjs8gdX5c=
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id
 g9-20020a056402090900b004350a8b5232mr9868769edz.240.1663957414824; Fri, 23
 Sep 2022 11:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com> <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
In-Reply-To: <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 23 Sep 2022 11:23:23 -0700
Message-ID: <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
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

On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> > > On 22-09-2022 12:08, Andy Shevchenko wrote:
> > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>
> FYI: For now I sent a revert, but if we got a solution quicker we always
> can choose the course of actions.
>

I think we have another problem. This patch happened in parallel to mine

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.0-rc6&id=3Dab7aa2866d295438dc60522f85c5421c6b4f1507

so my changes didn't have that fix in mind and I think your revert
will not preserve that fix. Can you update your revert to take care of
that too, please?

I'm really confused how the above commit could be followed up by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/usb/dwc3/drd.c?h=3Dv6.0-rc6&id=3D0f01017191384e3962fa31520a9fd9846c3=
d352f

the diffs in dwc3_drd_init seem contradictory

> > > If the extcon device exists, get the mode from the extcon device. If
> > > the controller is DRD and the driver is unable to determine the mode,
> > > only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> > >
> > > According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferr=
y, can you
> > > share bisect log?
> > >
> > > I can but not right now. But what I did was bisect between 5.18.0 (go=
od) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based=
 on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "us=
b: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and com=
mit before that (good).
> > >
> > > The effect of the patch is that on Merrifield (I tested with Intel Ed=
ison Arduino board which has a HW switch to select between host and device =
mode) device mode works but in host mode USB is completely not working.
> > >
> > > Currently on host mode - when working - superfluous error messages fr=
om tusb1210 appear. When host mode is not working there are no tusb1210 mes=
sages in the logs / on the console at all. Seemingly tusb1210 is not probed=
, which points in the direction of a relation to extcon.
> > >
> > > Taking into account the late cycle, I would like to revert the change=
. And
> > > Ferry and I would help to test any other (non-regressive) approach).
> > >
> > > I have not yet tested if a simple revert fixes the problem but will t=
onight.
> > >
> > >
> > > I would be happy to test other approaches too.
> >
> >
> > It's a bit hard for me to suggest an alternative approach without
> > knowing how things are breaking in this case. I'd love to order one of
> > those boards to repro and fix this on my end, but it looks like this
> > HW is EOLed and out of stock in most places. If you guys know how to
> > get my hands on those boards I'm all ears.
>
> There are still some second hand Intel Edison boards flying around
> (but maybe cost a bit more than expected) and there are also
> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> option though requires more actions in order something to be boot
> there.
>

OK, I'll check e-bay just in case.

> In any case, it's probably quicker to ask Ferry or me for testing.
> (Although currently I have no access to the board to test OTG, it's
>  remote device which I can only power on and off and it has always
>  be in host mode.)
>
> > Barring that, Ferry can you dig more into this failure? E.g. is it this=
 hunk
> >
> > @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> >                  * mode. If the controller supports DRD but the dr_mode=
 is not
> >                  * specified or set to OTG, then set the mode to periph=
eral.
> >                  */
> > -               if (mode =3D=3D USB_DR_MODE_OTG &&
> > +               if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
> >                     (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> >                      !device_property_read_bool(dwc->dev, "usb-role-swi=
tch")) &&
> >                     !DWC3_VER_IS_PRIOR(DWC3, 330A))
> > @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
> >         }
> >  }
> >
> > that's problematic or moving
>
> I think you wanted to revert only this line and test?

Yes.

>
> >  static int dwc3_probe(struct platform_device *pdev)
> >  {
> >         struct device           *dev =3D &pdev->dev;
> > @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pd=
ev)
> >                 goto err2;
> >         }
> >
> > +       dwc->edev =3D dwc3_get_extcon(dwc);
> > +       if (IS_ERR(dwc->edev)) {
> > +               ret =3D PTR_ERR(dwc->edev);
> > +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
> > +               goto err3;
> > +       }
> > +
> >         ret =3D dwc3_get_dr_mode(dwc);
> >         if (ret)
> >                 goto err3;
> >
> > to happen earlier?
>
> It is not always possible to have an extcon driver available, that's why =
in
> some cases the probe of it defers. I dunno how your patch supposed to wor=
k
> in that case.

I'm not sure I understand what you mean. AFAIU the logic is that if
the platform specifies the presence of extcon either via DT or, like
Merrifield, via and explicit "linux,extcon-name" device property in
the code then extcon is a mandatory component of the DRD stack and the
driver is expected to be present for the whole thing to work. I don't
think I really changed that logic with my patch, even after the revert
dwc3_get_extcon() will be called as a part of a probing codepath, so
if the a missing driver is causing a probe deferral it should still be
happening, unless I missed something.

>
> > Does tracing the "mrfld_bcove_pwrsrc" driver (the
> > excton provider in this case AFIACT) show anything interesting?
>
> I believe there is nothing interesting.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
