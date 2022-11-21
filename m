Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AA632869
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiKUPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiKUPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:41:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58545EE6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:41:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gv23so29475237ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCMlnWg+myOhhKN0SxZMVCH4mYM2c7IIKgrkO+HeaWk=;
        b=Y2RO/yW642IDIaLYTAISydu25+lH0EHbLtHCbKmBKzdnSwR4XVBHiICXHVrhgghG8f
         qzDASEcxyUzmk5Az0j2opwEyoq+DlHwLteDgK1bUfPBVgMSxXn4RfCTuSaZ+0g67ZzS6
         7PC8oehAF2iilexEtWcuzzPq194e5+ZsSkStZnZwm0M8jP8p6EEstIbEcO8wND7uY+9Z
         KQLWrNK0wMSON02oH+DSHWAWUVQuPYVDYr/E5OIZ/ugRbDxYxsEg4PkrAMgjYGAZq8Xn
         uXHkfai7YE97+XY6rOJusPdqRdvo2H+eIq/y7P2MBDncBo4Xr02NdvLuzE2Yd+Uf2zLc
         Dr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCMlnWg+myOhhKN0SxZMVCH4mYM2c7IIKgrkO+HeaWk=;
        b=RxMNikDmJDV2ORe//pzz6B03Ew4pclPSTlDgaBA4TtyaML+g+SifsYdan92bAkHsyD
         /rac0r5Yd0VA4aWONVrqSSd3OgWnnsFSVwO+itif4FF2RSkUX3Ig4zV2o9cUAeUx/VBh
         SmVNg6hhAfDzUYSZiRoF/QI1e9c1Erurz/M5ft/6vfMtsENIzJZfLFgXOEPcPnW1npnh
         Ohy9UrXR1KQ4eYR0rzfS7GhDkaSxOJY+8Cw3lHJaqJdaSzJxOCdv4RDXT0djn84bCIQL
         fhSMhbhy5ZDksCmHawVQc/rzNAJOOzdLxEq/kACCl1pfiRUpQjTGsDJAocMz9RQXaSwU
         r2Hg==
X-Gm-Message-State: ANoB5pnsB4Av0rU+PrfiTvqj2Hdr030OrRQCFO073hhj5ODcCz53Sxin
        iHHvButQ8evSwfQZlflfFjqgs0xoCEP+1/m0sog=
X-Google-Smtp-Source: AA0mqf5uOHOc2RxD/WaWaZ1u85j1VVhGSa0IldqxagvBVMqoRS1IH+b3Ral1oqQSSUWehCElDYUPp1lqEbwMbm6ODRU=
X-Received: by 2002:a17:906:448d:b0:7ae:37aa:6bf with SMTP id
 y13-20020a170906448d00b007ae37aa06bfmr15892382ejo.481.1669045306558; Mon, 21
 Nov 2022 07:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
 <Y3f9O0S8kVXZ+py+@mail-itl> <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
 <Y3kFYeml1CPL318u@mail-itl>
In-Reply-To: <Y3kFYeml1CPL318u@mail-itl>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 21 Nov 2022 10:41:34 -0500
Message-ID: <CAKf6xpts-u_JUtTGnzhxmRHZYVFnVMksTERZWS8EC+7BGsoViw@mail.gmail.com>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
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

On Sat, Nov 19, 2022 at 11:33 AM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Sat, Nov 19, 2022 at 09:36:54AM -0500, Jason Andryuk wrote:
> > Hi, Marek,
> >
> > On Fri, Nov 18, 2022 at 4:46 PM Marek Marczykowski-G=C3=B3recki
> > <marmarek@invisiblethingslab.com> wrote:
> > >
> > > On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> > > > I was trying to test your xen-pciback v3 patch, and I am having
> > > > assignment fail consistently now.  It is actually failing to
> > > > quarantine to domIO in the first place, which matches the failure f=
rom
> > > > the other day (when I more carefully read through the logs).  It no=
w
> > > > consistently fails to quarantine on every boot unlike the other day
> > > > where it happened once.
> > >
> > > Does this include the very first assignment too, or only after domain
> > > reboot? If the latter, maybe some cleanup missed clearing MASKALL?
> >
> > It's the quarantine during dom0 boot that fails.  Later assignment
> > during VM boot fails.  I tried warm reboots and cold boots and it
> > happened both times.
> >
> > I also modified my initrd to halt in there and checked the config
> > space.  MASKALL wasn't set at that time.  I need to double check -
> > MASKALL may have been unset after dom0 booted in that case.
> >
> > I'll test more to figure when and how MASKALL is getting set.

I'm testing with a laptop without a battery.  It seems MASKALL remains
set when rebooting or when left plugged in.

From unplugged, a cold boot doesn't have MASKALL set and the network vm boo=
ts.

After that, rebooting the laptop leaves MASKALL set on the NIC when
the laptop reboots.   NIC assignment fails.

Shutdown and later boot while left plugged in keeps MASKALL set.  NIC
assignment fails.  I have only tested this scenario for short periods
of time, so I don't know if it would eventually clear after a longer
time.

Regards,
Jason
