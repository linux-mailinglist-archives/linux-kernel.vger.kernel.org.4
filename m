Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DB5E8702
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiIXBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIXBfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:35:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96133F1FD;
        Fri, 23 Sep 2022 18:35:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l14so3911729eja.7;
        Fri, 23 Sep 2022 18:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=FmXNgKNiR6L03MR28liqOUt594RqBBZGOnZhnHELJMk=;
        b=avhlzXJiFl2JtY7A4VK/eK93CT8mXZlE6+Iq/5dEiB/Lle6blMlzLEkbYwfYxBk6Ue
         0pp8WoSyp/jlDPIQ/lGRRLJq9YMlK5AbPfJylxuEeEPBYxdFbBiyE0RdfGnLwP7usIsq
         y21X27Lrc6nrMCqx7V8i1r/KJgBeyvn+o+ZxtOUrll8zvluM3cP4jzvKa4NJWEUwIrF3
         t7XwqgqddovyphLBUHTJXoFYdMPJzhGzMUh+QeivE/8HFOXjnOUs4Ckr9AvVgt6GCGnf
         sM342dsszjWMDJxMnvEOshZpQ4zwbq3vt4BoqrZGNG16OFHkLMJpbubmQiEmRAeLNwn5
         XziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FmXNgKNiR6L03MR28liqOUt594RqBBZGOnZhnHELJMk=;
        b=zZayATP3IO4LgUG2iARRBdadTTu1ugeMqDCF1dRilZDOoOfJYxLkKC38PZyQG98jLo
         GhsmMYss0ziumCpytzO/HXfhv3b6Z0FwcytGAE3UuvUpzFvrzUGyXqr0Z3l+CbhseHBR
         oV2us7yq9hV3OWd9BNU08jJw9ze/KIgR6SOhg04x9Xam/Et28k469Rjg6mBi2Bcg9KzZ
         UdgC6IaE2tvdFXrlqfuxIPNceJdGBKCkMr2y1hwL0+FblohP9VVIZpnYIeo1d2MCHsKd
         Pc4ZTsq/nCH9LUtenGAPDq6KEwqgL6StWKc5OrnWNoJMt9ovUuGWgFE6IfsJYNbUUvqm
         zIDQ==
X-Gm-Message-State: ACrzQf2FykeMgk0nD7jVmaHtxgf8HY54CSYW9p6lw3QFHMyhFqCLd1IK
        UVl3Yd5Ty+0kQzojnffd+KTM5Fh6upKBFa+xXqs=
X-Google-Smtp-Source: AMsMyM7Ld7YZrjF5QB6UKRako5m2ln0sKbieW6A9jlXcekzi/caJ9Tjf/T5TNvHdq7Ng+jWnaf9cBPpwfSFfO9RGQHI=
X-Received: by 2002:a17:907:6e27:b0:782:9f5f:fb5a with SMTP id
 sd39-20020a1709076e2700b007829f5ffb5amr5064100ejc.75.1663983309293; Fri, 23
 Sep 2022 18:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com> <47a0249c-e129-7e98-503d-4254f216e485@gmail.com>
In-Reply-To: <47a0249c-e129-7e98-503d-4254f216e485@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 23 Sep 2022 18:34:57 -0700
Message-ID: <CAHQ1cqG7oL2sn=SRxp9se_h=rm+C6qYTkjp_DD1hPLBRPJpoGg@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

On Fri, Sep 23, 2022 at 2:12 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> Op 23-09-2022 om 18:42 schreef Andy Shevchenko:
> > On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> >> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> >>> On 22-09-2022 12:08, Andy Shevchenko wrote:
> >>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> > FYI: For now I sent a revert, but if we got a solution quicker we alway=
s
> > can choose the course of actions.
> >
> >>> If the extcon device exists, get the mode from the extcon device. If
> >>> the controller is DRD and the driver is unable to determine the mode,
> >>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> >>>
> >>> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferr=
y, can you
> >>> share bisect log?
> >>>
> >>> I can but not right now. But what I did was bisect between 5.18.0 (go=
od) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based=
 on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "us=
b: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and com=
mit before that (good).
> >>>
> >>> The effect of the patch is that on Merrifield (I tested with Intel Ed=
ison Arduino board which has a HW switch to select between host and device =
mode) device mode works but in host mode USB is completely not working.
> >>>
> >>> Currently on host mode - when working - superfluous error messages fr=
om tusb1210 appear. When host mode is not working there are no tusb1210 mes=
sages in the logs / on the console at all. Seemingly tusb1210 is not probed=
, which points in the direction of a relation to extcon.
> >>>
> >>> Taking into account the late cycle, I would like to revert the change=
. And
> >>> Ferry and I would help to test any other (non-regressive) approach).
> >>>
> >>> I have not yet tested if a simple revert fixes the problem but will t=
onight.
> >>>
> >>>
> >>> I would be happy to test other approaches too.
> >>
> >> It's a bit hard for me to suggest an alternative approach without
> >> knowing how things are breaking in this case. I'd love to order one of
> >> those boards to repro and fix this on my end, but it looks like this
> >> HW is EOLed and out of stock in most places. If you guys know how to
> >> get my hands on those boards I'm all ears.
> > There are still some second hand Intel Edison boards flying around
> > (but maybe cost a bit more than expected) and there are also
> > Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> > option though requires more actions in order something to be boot
> > there.
> >
> > In any case, it's probably quicker to ask Ferry or me for testing.
> > (Although currently I have no access to the board to test OTG, it's
> >   remote device which I can only power on and off and it has always
> >   be in host mode.)
> >
> >> Barring that, Ferry can you dig more into this failure? E.g. is it thi=
s hunk
> >>
> >> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> >>                   * mode. If the controller supports DRD but the dr_mo=
de is not
> >>                   * specified or set to OTG, then set the mode to peri=
pheral.
> >>                   */
> >> -               if (mode =3D=3D USB_DR_MODE_OTG &&
> >> +               if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
> >>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> >>                       !device_property_read_bool(dwc->dev, "usb-role-s=
witch")) &&
> >>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
> >> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
> >>          }
> >>   }
> >>
> >> that's problematic or moving
> > I think you wanted to revert only this line and test?
>
> On v6.0-rc6 and reverting manually only this line
>
> - if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
>
> + if (mode =3D=3D USB_DR_MODE_OTG &&
>
> host mode still does not work (no change visible).

Cool, thanks for checking that. Don't think I have any more
experiments off the top of my head to run. I'll have to go read that
code more. I'll reply in the thread if I have something new to
try/say.

>
> >
> >>   static int dwc3_probe(struct platform_device *pdev)
> >>   {
> >>          struct device           *dev =3D &pdev->dev;
> >> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *p=
dev)
> >>                  goto err2;
> >>          }
> >>
> >> +       dwc->edev =3D dwc3_get_extcon(dwc);
> >> +       if (IS_ERR(dwc->edev)) {
> >> +               ret =3D PTR_ERR(dwc->edev);
> >> +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n")=
;
> >> +               goto err3;
> >> +       }
> >> +
> >>          ret =3D dwc3_get_dr_mode(dwc);
> >>          if (ret)
> >>                  goto err3;
> >>
> >> to happen earlier?
> > It is not always possible to have an extcon driver available, that's wh=
y in
> > some cases the probe of it defers. I dunno how your patch supposed to w=
ork
> > in that case.
> >
> >> Does tracing the "mrfld_bcove_pwrsrc" driver (the
> >> excton provider in this case AFIACT) show anything interesting?
> > I believe there is nothing interesting.
> >
