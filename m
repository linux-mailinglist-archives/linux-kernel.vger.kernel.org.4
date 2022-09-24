Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C465E86FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiIXB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 21:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiIXB1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 21:27:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F7D98CA;
        Fri, 23 Sep 2022 18:27:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so3918780ejc.5;
        Fri, 23 Sep 2022 18:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=m/PjUUxrYO5sK0QcBYF7bpeBPFlohOK1LJyIVNV7DKo=;
        b=iCVANWynO3KNyhfTMLphDyDVXHsC91mqZ8dICHlvhKzx9ukZB4p4e1A293I0guutd6
         h/JjlWFl4aCRNoviThyCqBpU6uSKIZrXS30RPmzUWEms7qbDuHyvauxGM8lufn57ZeCu
         Cjun/L67rjkm9gXw93mowhXgir58cGU5JkuDvEK/y8teRxUkj49DLEokTzCUjLL5Osuz
         rNM2PHoK7G1rh/p/fpZOFNs/AkU6j+P3HMOSS09/OhuzvHHSXCAc8dWBCpHePC8C9yTJ
         0T/Tpp+eGp1qn8TMbCs0z6b52pHUoYshO73TEZCmEWtO0wX2Al6RMBRk18TrzdSTmObv
         gZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m/PjUUxrYO5sK0QcBYF7bpeBPFlohOK1LJyIVNV7DKo=;
        b=kxy9l0IRm+pq3MCUk3X1Y9Fqdh1unsqbL25bqUH/oofMwfXKkqFniF9g+KlPddAsmQ
         WSsEPv3dpM+04HwiH/Iaz+ETLssJPnfMAV/HGdGYihJvblFIhK6jXp/BMrU2W+15/wVR
         /KyOz8TPC3wEFcAwte41INCejovFo6BowDoGFuDJ+FRLVWk6sjC+dtsfs7XR+1uGesSd
         XMWOgjBgXI6G9kAUBUBfH7orAmpYPfU/b699JXxqelsCOZcLzV2B9acv+ItximU/6IeH
         TDqBQU0a6NRDlEu4E4CFZYGwuozue/BYEmfU+tK2zEaRl6XePwbRRG5KY5SObSzaDGSF
         lvsw==
X-Gm-Message-State: ACrzQf3iQK2VGKVEp1ASN1YZIdARCHWPVuIeMv7RAO95nr4eEi08HhKW
        aoUdlSCeIobJCXLf+tKmErs+zSTU3LFB5KqmPNpZBSHKZMI=
X-Google-Smtp-Source: AMsMyM5Ok3i63r4aN8rPmqFgSiFTkZ07cR971OuWUrM+iOTqoEYZgVCVKtQSWzjEfdOGbUnuWm8UAyyFsrK10MHgtTI=
X-Received: by 2002:a17:906:730b:b0:782:2eaf:a4ad with SMTP id
 di11-20020a170906730b00b007822eafa4admr9972376ejc.27.1663982849718; Fri, 23
 Sep 2022 18:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com> <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <Yy4A7W9y4eeHOvco@smile.fi.intel.com>
In-Reply-To: <Yy4A7W9y4eeHOvco@smile.fi.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 23 Sep 2022 18:27:18 -0700
Message-ID: <CAHQ1cqG8KfZAFwvjkn1f+aKrOkPNKW=NJo-rz-Zqp+WFZLoF4g@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 11:54 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Sep 23, 2022 at 11:23:23AM -0700, Andrey Smirnov wrote:
> > On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> > > > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote=
:
> > > > > On 22-09-2022 12:08, Andy Shevchenko wrote:
> > > > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> > >
> > > FYI: For now I sent a revert, but if we got a solution quicker we alw=
ays
> > > can choose the course of actions.
> >
> > I think we have another problem. This patch happened in parallel to min=
e
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.0-rc6&id=3Dab7aa2866d295438dc60522f85c5421c6b4f1507
> >
> > so my changes didn't have that fix in mind and I think your revert
> > will not preserve that fix. Can you update your revert to take care of
> > that too, please?
> >
> > I'm really confused how the above commit could be followed up by:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/usb/dwc3/drd.c?h=3Dv6.0-rc6&id=3D0f01017191384e3962fa31520a9fd98=
46c3d352f
> >
> > the diffs in dwc3_drd_init seem contradictory
>
> I'm not sure I follow. Your patch has been merged and after that some kin=
d of
> merge conflict was resolved by an additional change. To revert your stuff
> cleanly we need to revert the merge update patch first. That's why revert=
 is a
> series of patches and not a single one. I have no idea how above mentione=
d
> commit at all related to all this.
>
> Can you elaborate more, please?
>

It's not important to clarify, just me voicing my confusion, we have
way too many threads of discussion already.

> > > > > If the extcon device exists, get the mode from the extcon device.=
 If
> > > > > the controller is DRD and the driver is unable to determine the m=
ode,
> > > > > only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> > > > >
> > > > > According to Ferry (Cc'ed) this broke Intel Merrifield platform. =
Ferry, can you
> > > > > share bisect log?
> > > > >
> > > > > I can but not right now. But what I did was bisect between 5.18.0=
 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) b=
ased on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f=
 "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and=
 commit before that (good).
> > > > >
> > > > > The effect of the patch is that on Merrifield (I tested with Inte=
l Edison Arduino board which has a HW switch to select between host and dev=
ice mode) device mode works but in host mode USB is completely not working.
> > > > >
> > > > > Currently on host mode - when working - superfluous error message=
s from tusb1210 appear. When host mode is not working there are no tusb1210=
 messages in the logs / on the console at all. Seemingly tusb1210 is not pr=
obed, which points in the direction of a relation to extcon.
> > > > >
> > > > > Taking into account the late cycle, I would like to revert the ch=
ange. And
> > > > > Ferry and I would help to test any other (non-regressive) approac=
h).
> > > > >
> > > > > I have not yet tested if a simple revert fixes the problem but wi=
ll tonight.
> > > > >
> > > > > I would be happy to test other approaches too.
> > > >
> > > > It's a bit hard for me to suggest an alternative approach without
> > > > knowing how things are breaking in this case. I'd love to order one=
 of
> > > > those boards to repro and fix this on my end, but it looks like thi=
s
> > > > HW is EOLed and out of stock in most places. If you guys know how t=
o
> > > > get my hands on those boards I'm all ears.
> > >
> > > There are still some second hand Intel Edison boards flying around
> > > (but maybe cost a bit more than expected) and there are also
> > > Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> > > option though requires more actions in order something to be boot
> > > there.
> >
> > OK, I'll check e-bay just in case.
> >
> > > In any case, it's probably quicker to ask Ferry or me for testing.
> > > (Although currently I have no access to the board to test OTG, it's
> > >  remote device which I can only power on and off and it has always
> > >  be in host mode.)
> > >
> > > > Barring that, Ferry can you dig more into this failure? E.g. is it =
this hunk
> > > >
> > > > @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> > > >                  * mode. If the controller supports DRD but the dr_=
mode is not
> > > >                  * specified or set to OTG, then set the mode to pe=
ripheral.
> > > >                  */
> > > > -               if (mode =3D=3D USB_DR_MODE_OTG &&
> > > > +               if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
> > > >                     (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> > > >                      !device_property_read_bool(dwc->dev, "usb-role=
-switch")) &&
> > > >                     !DWC3_VER_IS_PRIOR(DWC3, 330A))
> > > > @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *d=
wc)
> > > >         }
> > > >  }
> > > >
> > > > that's problematic or moving
> > >
> > > I think you wanted to revert only this line and test?
> >
> > Yes.
>
> Ferry, can you try that (but I believe it won't help anyway, because I do=
n't
> see how we handle deferred probe).
>
> > > >  static int dwc3_probe(struct platform_device *pdev)
> > > >  {
> > > >         struct device           *dev =3D &pdev->dev;
> > > > @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device=
 *pdev)
> > > >                 goto err2;
> > > >         }
> > > >
> > > > +       dwc->edev =3D dwc3_get_extcon(dwc);
> > > > +       if (IS_ERR(dwc->edev)) {
> > > > +               ret =3D PTR_ERR(dwc->edev);
> > > > +               dev_err_probe(dwc->dev, ret, "failed to get extcon\=
n");
> > > > +               goto err3;
> > > > +       }
> > > > +
> > > >         ret =3D dwc3_get_dr_mode(dwc);
> > > >         if (ret)
> > > >                 goto err3;
> > > >
> > > > to happen earlier?
> > >
> > > It is not always possible to have an extcon driver available, that's =
why in
> > > some cases the probe of it defers. I dunno how your patch supposed to=
 work
> > > in that case.
> >
> > I'm not sure I understand what you mean. AFAIU the logic is that if
> > the platform specifies the presence of extcon either via DT or, like
> > Merrifield, via and explicit "linux,extcon-name" device property in
> > the code then extcon is a mandatory component of the DRD stack and the
> > driver is expected to be present for the whole thing to work.
>
> > I don't
> > think I really changed that logic with my patch, even after the revert
> > dwc3_get_extcon() will be called as a part of a probing codepath,
>
> But it's not true as proved by the experiment. So with your patch it does=
n't
> work anymore, so the logic _is_ changed.
>

I think you are jumping the gun here. We know that the patch breaks
USB host functionality on Merrifield. We know that "Seemingly tusb1210
is not probed". Do we know that dwc3.ko (I think that'd be the
driver's name) is not probed? Did Ferry share that info with you in
some other thread? I don't deny it is possible, but I don't think this
is really clear at this moment to say definitively.

> >       so
> > if the a missing driver is causing a probe deferral it should still be
> > happening, unless I missed something.
>
> The merge fix removes deferred probe by some reason.
>
> > > > Does tracing the "mrfld_bcove_pwrsrc" driver (the
> > > > excton provider in this case AFIACT) show anything interesting?
> > >
> > > I believe there is nothing interesting.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
