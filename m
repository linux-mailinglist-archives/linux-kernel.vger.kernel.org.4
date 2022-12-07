Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A5645A47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLGNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:00:42 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C25133D;
        Wed,  7 Dec 2022 05:00:41 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id j16so593083qtv.4;
        Wed, 07 Dec 2022 05:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUPGz9duJAj674G1HKLRXDzt7EeIFrS+Dk9kzWixWeI=;
        b=A+xUc9crwAMbkULycC9Hc56ijghLDy+WWfpBBPnSBVd+aGNetNzk6wf+cNCxss7afM
         cepA9KQczllyj2mHUMA32slZfTdhTeip+S5jk4JpAfwa0zuHjCJuBIALWddxXvkTP0hz
         QkbR6rg0pz7Fs691rbqi02rliJYaj7DJKePvDrWBY26b4xYFEdeVI0rCZCnW7+2eBub3
         f+yxlnZCLruAsKDW+w++ZlckdvzRsRrtu1qGF7YNloJBtXCGofacuTjiyx9SM2d43VkI
         vuYJmvCUD5ZiSGx7FJKOaBeQ9cHqLsxk9Cn0tMwoPXxBaOiDWvgypgnI0+5TR8mEIiNf
         1hww==
X-Gm-Message-State: ANoB5pk/8jyGfdC86gOdwbdgXrMMz5MvBuA1rScVUoS+p3HsxrDVoSS/
        wdQ4x9hncfwzq+IYW6W1GAcGwxXhB8U3rcFLDSk=
X-Google-Smtp-Source: AA0mqf65Zc7aQsSeuNEVmbOtyMubetzIfXmSi9RGmeblMfyRFofgtOIIBWWEcUhvRTa44wkT20Qizvbt3ytpi3/gmVQ=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr27914500qte.411.1670418040428; Wed, 07
 Dec 2022 05:00:40 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
 <2283816.ElGaqSPkdT@kreacher> <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
 <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
 <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
 <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm> <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
In-Reply-To: <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 14:00:28 +0100
Message-ID: <CAJZ5v0iwEKtLVzzJw+XG5-w=qr86ec0yKpAWCU-KLwYmFnt5Zg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Dec 7, 2022 at 1:43 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-12-07 at 11:19 +0100, Jiri Kosina wrote:
> > On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> >
> > > Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I
> > > am
> > > worried that you won't be the only one complaining we just killed
> > > their
> > > mouse. So I think the even wiser solution would be to delay (and so
> > > revert in 6.1 or 6.2) the 2 patches that enable hid++ on all
> > > logitech
> > > mice (8544c812e43ab7bdf40458411b83987b8cba924d and
> > > 532223c8ac57605a10e46dc0ab23dcf01c9acb43).
> >
> > If we were not at -rc8 timeframe, I'd be in favor to coming up with
> > proper
> > fix still for 6.1. But as things currently are, let's just revert
> > those
> > and reschedule them with proper fix for 6.2+.
>
> Has anyone seen any other reports?
>
> Because, honestly, seeing work that adds support for dozens of devices
> getting tossed out at the last minute based on a single report with no
> opportunity to fix the problem is really frustrating.

Well, that's why I sent patches to address this particular case
without possibly breaking anything else.

Improvements can be made on top of them and the blocklist entry added
by patch [2/2] need not stay there forever, FWIW.
