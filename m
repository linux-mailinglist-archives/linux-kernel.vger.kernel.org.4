Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACC645738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLGKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:11:46 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FD40469;
        Wed,  7 Dec 2022 02:11:45 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id cg5so15765871qtb.12;
        Wed, 07 Dec 2022 02:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juRVNq6nOEAgeVByhHfIsBezpSVff7XnlAmpgRugblM=;
        b=DGzp66VLtLTd3mAXxnEFGCIx+YtsbQ0zBBWq8zS1OXF9SYsiSrbdnGZYMZbUW8vfZU
         DGIe+yuKNhUKIDWqfuXNZLhc3gxPWsR4JJ3dhyR2k0Dmzgc9vEKIktrl0NqxpQ/8fi8j
         y6zFJRClfZLRSYUyRjxZAsREle5tfbFdi6eZqItp5bDCs5czzJPnMFugcMz3jK81m57X
         n5gU0IUX3vsqMtb42Dy+yV0Z6DMt2mDB2Oh+ti3tY5K8yHu9oCe+MXzR+4rjuFRsAJVc
         V06st0CNqEntQaZWMDEnRUb2wo6ekLArcFrbC80slTLGl3VoEwfDsqWKpkJAKq5Y19/9
         JWuA==
X-Gm-Message-State: ANoB5plPy4VdQS6pnmYTnzML4OVMmGwkFFvYb6CoBQLfhRUG/NV0SRYh
        SK1TbQ6BoS2yjgQnNZrWzb7RpdMazqW1v82tVdTCLLtH
X-Google-Smtp-Source: AA0mqf5v/x8EGofGp9eIVXNaOHp9+Qq49rJ09fkRLEIgmVKttw3ywbZiq0oyo9d8wiacUAhQaof8qrzMAOlMKdYs0aA=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr65753022qtj.357.1670407904195; Wed, 07
 Dec 2022 02:11:44 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
 <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com> <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
In-Reply-To: <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 11:11:32 +0100
Message-ID: <CAJZ5v0gwBUBbGLoW4xZCEOnGRdi-8gKNDgQ6KJEebLyxyJEUkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
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

On Wed, Dec 7, 2022 at 11:05 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Dec 7, 2022 at 10:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 7, 2022 at 10:29 AM Bastien Nocera <hadess@hadess.net> wrote:
> > >
> > > On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does not
> > > > work when HID++ is enabled for it,
> > >
> > > This needs the output of the hidpp-list-features tool mentioned earlier
> > > in the thread so we can avoid words like "evidently" and provide
> > > concrete proof.
> >
> > Well, so point me to a binary of this, please.
> >
> > > But why is it needed in this case?
> >
> > Because it doesn't work otherwise.
> >
> > > We purposefully try to avoid blanket
> > > blocklists. The lack of HID++ can be probed, so the device should work
> > > just as it used to (if the fallback code works).
> >
> > No, because the hid-generic driver has no way to check that the probe
> > function of your driver fails for this particular device.  The probing
> > of hid-generic will fail so long as the device matches the device ID
> > list of any specific HID driver.  With patch [1/2] from this series
> > applied this is unless that specific driver has a ->match() callback
> > rejecting the given device.
> >
> > You'd need a list of drivers that have been tried and failed somewhere
> > for that and AFAICS no such list is present in the code.
>
> That is the reason why I never wanted to enable HID++ on all Logitech
> mice, and this comes back to bite us at the worst time possible, right
> before the merge window opens :(
>
> >
> > So a minimum fix for 6.1 that actually works for me is to add the
> > non-working device to the blocklist.  More sophisticated stuff can be
> > done later.
>
> Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I am
> worried that you won't be the only one complaining we just killed
> their mouse.
> So I think the even wiser solution would be to delay (and so revert in
> 6.1 or 6.2) the 2 patches that enable hid++ on all logitech mice
> (8544c812e43ab7bdf40458411b83987b8cba924d and
> 532223c8ac57605a10e46dc0ab23dcf01c9acb43).

Obviously that would work for me too, so it's your call.

Thanks!
