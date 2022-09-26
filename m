Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1615E98DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiIZFnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:43:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90025C7A;
        Sun, 25 Sep 2022 22:43:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z97so7457138ede.8;
        Sun, 25 Sep 2022 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3vj06gg+4e+iyP4RZ6i2/FiSz2wtb3Ohm9Bz3clbcEw=;
        b=ZmmxaopkLGa2SXBcoPANEPzcVwTLu8Kpyzx0Tkx4WIBt9C1cXtQZoYlhnvLt/+uwMK
         9w5pAUJuPQRDtRlYXTU80SXD/TH6SPUTa86hia/uvIfnFINdiWrhxSVbYjSgozZAtAyK
         gjkeh2fJmZ+LQvrvCeYcosxxJfgBw8LUsUiIRgAVgjdMHrKRNZSYhPzsAoPR6ttRT/Mw
         wceYy3gubrSDU04iLBRtAgV7gDFZt4o0bV6OeBQRqfvppMdjyR/xldDqqRt5ao9w2CFk
         peYBcX0Shw+8YKG6XkAVVb2H6BifS9tqlUbG7j0AzJfk9lTN9Jpa1F12W/F7FgPH1n+a
         qOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3vj06gg+4e+iyP4RZ6i2/FiSz2wtb3Ohm9Bz3clbcEw=;
        b=wIkRYJRuEBLaSma9pYilsF8w5UtrCoXa0W75Zw2iV2ES5fU55xpILNpZN/vnoHafph
         l5P8ZBLzwfxbK0A1HIemf4LTTdPztwy6UcQd/uvzn1X9IAgihOJRCUeWNfgBjqQU1fBu
         ra09HeRvg3i0kBoZuqINT2Nz4rpF+fordT6xtXcCsAS8lc3RZZdbIxA1eeAtOYSYQres
         eHMTTHYytU2B3Lv8hGcAUI9yx6Tiskv5xibgv+ek+j4p7jNMxRhw5xPwybXKfRzmIice
         u6Gha30CCF84LznnIImmhqjSVmRvnJ0tfwZH8HTOK38xsbL/WHN02wX4hXQAjsWP6WRq
         rXDQ==
X-Gm-Message-State: ACrzQf2/0XMLtp5F669A1tVgC4pUgUXx0GObm8xOEIZSxymjFLFSIIu/
        XHduGDP3MLG49OE6RXuWAuy3y5n7HMGOwfGbdwg=
X-Google-Smtp-Source: AMsMyM5C52ijJlcMNo+lh6V0U2If9PClEdDzrYLK/y8jyJcnNuiUDrkGfucf83AdbSD0IQirf4dpciq47a7Q81DXtvI=
X-Received: by 2002:a05:6402:27ca:b0:451:7b58:1b01 with SMTP id
 c10-20020a05640227ca00b004517b581b01mr21175814ede.61.1664170998592; Sun, 25
 Sep 2022 22:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com> <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com> <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
In-Reply-To: <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 25 Sep 2022 22:43:07 -0700
Message-ID: <CAHQ1cqGrfTO9JLgD-k0Akg7+hXNT+WevfjH_YpsVi8wQt6_iBw@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 12:21 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> Promising results below.
>
> Op 24-09-2022 om 23:29 schreef Ferry Toth:
> > Hi,
> >
> > One more test
> >
> > Op 23-09-2022 om 20:23 schreef Andrey Smirnov:
> >> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> >> <andriy.shevchenko@intel.com> wrote:
> >>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> >>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> >>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
> >>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> >>> FYI: For now I sent a revert, but if we got a solution quicker we
> >>> always
> >>> can choose the course of actions.
> >>>
> >> I think we have another problem. This patch happened in parallel to mine
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> >>
> >>
> >> so my changes didn't have that fix in mind and I think your revert
> >> will not preserve that fix. Can you update your revert to take care of
> >> that too, please?
> >>
> >> I'm really confused how the above commit could be followed up by:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
> >>
> >>
> >> the diffs in dwc3_drd_init seem contradictory
> >>
> >>>>> If the extcon device exists, get the mode from the extcon device. If
> >>>>> the controller is DRD and the driver is unable to determine the mode,
> >>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> >>>>>
> >>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform.
> >>>>> Ferry, can you
> >>>>> share bisect log?
> >>>>>
> >>>>> I can but not right now. But what I did was bisect between 5.18.0
> >>>>> (good) and 5.19.0 (bad) then when I got near the culprit (~20
> >>>>> remaining) based on the commit message I tried
> >>>>> 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch
> >>>>> OTG -> peripheral if extcon is present" (bad) and commit before
> >>>>> that (good).
> >>>>>
> >>>>> The effect of the patch is that on Merrifield (I tested with Intel
> >>>>> Edison Arduino board which has a HW switch to select between host
> >>>>> and device mode) device mode works but in host mode USB is
> >>>>> completely not working.
> >>>>>
> >>>>> Currently on host mode - when working - superfluous error messages
> >>>>> from tusb1210 appear. When host mode is not working there are no
> >>>>> tusb1210 messages in the logs / on the console at all. Seemingly
> >>>>> tusb1210 is not probed, which points in the direction of a
> >>>>> relation to extcon.
> >>>>>
> >>>>> Taking into account the late cycle, I would like to revert the
> >>>>> change. And
> >>>>> Ferry and I would help to test any other (non-regressive) approach).
> >>>>>
> >>>>> I have not yet tested if a simple revert fixes the problem but
> >>>>> will tonight.
> >>>>>
> >>>>>
> >>>>> I would be happy to test other approaches too.
> >>>>
> >>>> It's a bit hard for me to suggest an alternative approach without
> >>>> knowing how things are breaking in this case. I'd love to order one of
> >>>> those boards to repro and fix this on my end, but it looks like this
> >>>> HW is EOLed and out of stock in most places. If you guys know how to
> >>>> get my hands on those boards I'm all ears.
> >>> There are still some second hand Intel Edison boards flying around
> >>> (but maybe cost a bit more than expected) and there are also
> >>> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> >>> option though requires more actions in order something to be boot
> >>> there.
> >>>
> >> OK, I'll check e-bay just in case.
> >>
> >>> In any case, it's probably quicker to ask Ferry or me for testing.
> >>> (Although currently I have no access to the board to test OTG, it's
> >>>   remote device which I can only power on and off and it has always
> >>>   be in host mode.)
> >>>
> >>>> Barring that, Ferry can you dig more into this failure? E.g. is it
> >>>> this hunk
> >>>>
> >>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> >>>>                   * mode. If the controller supports DRD but the
> >>>> dr_mode is not
> >>>>                   * specified or set to OTG, then set the mode to
> >>>> peripheral.
> >>>>                   */
> >>>> -               if (mode == USB_DR_MODE_OTG &&
> >>>> +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
> >>>>                      (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> >>>> !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
> >>>>                      !DWC3_VER_IS_PRIOR(DWC3, 330A))
> >>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
> >>>>          }
> >>>>   }
> >>>>
> >>>> that's problematic or moving
> >>> I think you wanted to revert only this line and test?
> >> Yes.
> >>
> >>>>   static int dwc3_probe(struct platform_device *pdev)
> >>>>   {
> >>>>          struct device           *dev = &pdev->dev;
> >>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device
> >>>> *pdev)
> >>>>                  goto err2;
> >>>>          }
> >>>>
> >>>> +       dwc->edev = dwc3_get_extcon(dwc);
> >>>> +       if (IS_ERR(dwc->edev)) {
> >>>> +               ret = PTR_ERR(dwc->edev);
> >>>> +               dev_err_probe(dwc->dev, ret, "failed to get
> >>>> extcon\n");
> >>>> +               goto err3;
> >>>> +       }
> >>>> +
> >>>>          ret = dwc3_get_dr_mode(dwc);
> >>>>          if (ret)
> >>>>                  goto err3;
> >>>>
> >>>> to happen earlier?
> >
> > I tried moving dwc3_get_extcon after dwc3_get_dr_mode like so::
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 8c8e32651473..3bf370def546 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1843,6 +1843,10 @@ static int dwc3_probe(struct platform_device
> > *pdev)
> >          goto err2;
> >      }
> >
> > +    ret = dwc3_get_dr_mode(dwc);
> > +    if (ret)
> > +        goto err3;
> > +
> >      dwc->edev = dwc3_get_extcon(dwc);
> >      if (IS_ERR(dwc->edev)) {
> >          ret = PTR_ERR(dwc->edev);
> > @@ -1850,10 +1854,6 @@ static int dwc3_probe(struct platform_device
> > *pdev)
> >          goto err3;
> >      }
> >
> > -    ret = dwc3_get_dr_mode(dwc);
> > -    if (ret)
> > -        goto err3;
> > -
> >      ret = dwc3_alloc_scratch_buffers(dwc);
> >      if (ret)
> >          goto err3;
>
> After trying to understand the code a bit, I successfully tested the
> following move:
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 8c8e32651473..4a38cff8cb16 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1843,13 +1843,6 @@ static int dwc3_probe(struct platform_device *pdev)
>           goto err2;
>       }
>
> -    dwc->edev = dwc3_get_extcon(dwc);
> -    if (IS_ERR(dwc->edev)) {
> -        ret = PTR_ERR(dwc->edev);
> -        dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
> -        goto err3;
> -    }
> -
>       ret = dwc3_get_dr_mode(dwc);
>       if (ret)
>           goto err3;
> @@ -1867,6 +1860,13 @@ static int dwc3_probe(struct platform_device *pdev)
>       dwc3_check_params(dwc);
>       dwc3_debugfs_init(dwc);
>
> +    dwc->edev = dwc3_get_extcon(dwc);
> +    if (IS_ERR(dwc->edev)) {
> +        ret = PTR_ERR(dwc->edev);
> +        dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
> +        goto err5;
> +    }
> +
>       ret = dwc3_core_init_mode(dwc);
>       if (ret)
>           goto err5;
>
> This moves dwc3_get_extcon() until after dwc3_core_init() but just
> before dwc3_core_init_mode(). AFAIU initially dwc3_get_extcon() was
> called from within dwc3_core_init_mode() but only for case
> USB_DR_MODE_OTG. So with this change order of events is more or less
> unchanged.

I think we'd want to figure out why the ordering is important if we
want to justify the above fix.

>
> Due to move I modified goto to err5, not sure if that is correct.
>
> Thoughts? Can we get something like this in quick or should we revert first?
>

This will need some extra code to fix the case Sven's patch was fixing

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507

IMHO instead of trying to rush something in it be prudent to revert my
patch _and_ address the fact that above patch was lost during the
merge (Andy's revert needs to be updated)
