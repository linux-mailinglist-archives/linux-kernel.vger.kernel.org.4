Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57F645B22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLGNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLGNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:39:36 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82259864;
        Wed,  7 Dec 2022 05:39:35 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id mn15so12607577qvb.13;
        Wed, 07 Dec 2022 05:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POEYbus31nl5lGZyaVLCaTjVbQ3uHYNP++mB76/Ajas=;
        b=mlJLD+o+TDbbAe5Mblf1F49emwji/WN6Z9pA2RQ6MB4eFhiRZB16ljnNLhl3LAGgHb
         ZV2JcsGTvS3EyXsCVEYIbLjG/5PLhN2RO6WNTznNNuW7nYiiqYQu6BYbf9fEIHWMOt6O
         H7xxhRZm1jZVRxOxA8CX8wZ7uJbkchPVF4NoNgjE8k/E/ggNFH3ZHZFgQ4d4JtmbrFAp
         Gk0Wd5ovqlUVZhwtqpcOT2bd4Aj+Ef0lv3aE7wyExveab1rsy0Xs2dc8XLb23gu3sLpA
         TcB4/yjGc66D8c+AoarAgl/iBgu7LsuBeKQtsFFw9ybndC5LU0GRK00qFElarKGEpPdw
         I/gw==
X-Gm-Message-State: ANoB5pk74FW3FdbTkLoHgcplo7vXrEvcKC7urNMetwh2IhDDO3G6peHR
        V6ze3TnblAvSLqYmHEXBSuLZaBkJVn6Bp12ggYwqzooj
X-Google-Smtp-Source: AA0mqf4OTkUP1xNO0vcVo/o2R+82M0M6ZHTHb5UlXGWqJGkjTGW10beKcidK0OM/pA+GawMER1rvfn1kA1zI3wa/IiM=
X-Received: by 2002:a0c:c589:0:b0:4b1:a9ac:21de with SMTP id
 a9-20020a0cc589000000b004b1a9ac21demr64622850qvj.119.1670420374190; Wed, 07
 Dec 2022 05:39:34 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
 <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
 <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
 <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm> <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
 <CAJZ5v0iwEKtLVzzJw+XG5-w=qr86ec0yKpAWCU-KLwYmFnt5Zg@mail.gmail.com> <CAO-hwJLXPKwvFPHFq=y12p41Sx2Ab69sAY9Co7i0=iL1HzdXOg@mail.gmail.com>
In-Reply-To: <CAO-hwJLXPKwvFPHFq=y12p41Sx2Ab69sAY9Co7i0=iL1HzdXOg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 14:39:22 +0100
Message-ID: <CAJZ5v0g-_o4AqMgNwihCb0jrwrcJZfRrX=jv8aH54WNKO7QB8A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 2:25 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Dec 7, 2022 at 2:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 7, 2022 at 1:43 PM Bastien Nocera <hadess@hadess.net> wrote:
> > >
> > > On Wed, 2022-12-07 at 11:19 +0100, Jiri Kosina wrote:
> > > > On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> > > >
> > > > > Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I
> > > > > am
> > > > > worried that you won't be the only one complaining we just killed
> > > > > their
> > > > > mouse. So I think the even wiser solution would be to delay (and so
> > > > > revert in 6.1 or 6.2) the 2 patches that enable hid++ on all
> > > > > logitech
> > > > > mice (8544c812e43ab7bdf40458411b83987b8cba924d and
> > > > > 532223c8ac57605a10e46dc0ab23dcf01c9acb43).
> > > >
> > > > If we were not at -rc8 timeframe, I'd be in favor to coming up with
> > > > proper
> > > > fix still for 6.1. But as things currently are, let's just revert
> > > > those
> > > > and reschedule them with proper fix for 6.2+.
> > >
> > > Has anyone seen any other reports?
>
> It's not so much about how many reports, but *what* the end result is.
> If the device were working-ish, that would have been OK. But here the
> device is completely ignored by the kernel which basically enters the
> "no regression rule".
>
> > >
> > > Because, honestly, seeing work that adds support for dozens of devices
> > > getting tossed out at the last minute based on a single report with no
> > > opportunity to fix the problem is really frustrating.
>
> I know, and I feel your pain as I was about to have the same last week
> for HID-BPF. But as much as I hate dropping patches from the queue,
> not being able to have at least a week to fix it properly ends up with
> "fixes" that are broken and that might break other devices. Talking
> from experience as my first fix from last week was exactly in that
> category.
>
> >
> > Well, that's why I sent patches to address this particular case
> > without possibly breaking anything else.
>
> My concern is more that we now have a data point were the series broke
> a device (pretty badly) and if (when) this happens shortly after 6.1
> is getting released, we would have to say, oh yes, we know, so we need
> to patch the kernel because our driver is buggy, and we knew it. This
> is not acceptable, and I am sure that if Linus reads that thread he
> would revert the 2 patches or maybe more.

Well, I agree.

> >
> > Improvements can be made on top of them and the blocklist entry added
> > by patch [2/2] need not stay there forever, FWIW.
> >
>
> I need to check with Jiri, but there is a chance we can re-introduce
> this in 6.2. This way we will have slightly more time to fix it in a
> proper way.

Sounds good to me.
