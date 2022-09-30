Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D85F0C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiI3NXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiI3NXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:23:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C72170B1F;
        Fri, 30 Sep 2022 06:23:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31F4A47C;
        Fri, 30 Sep 2022 15:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664544189;
        bh=e4soUKkxacbJnR6n7y5MVvLpmY1Ws21HAPdvVVRyU4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMOLg9erIA7v3yON/DpX4v0tkzu9MYw2ANO1gLe/Ii6mW7LeMogubv8KPJtYrpLAh
         mCRvpHoq0OSuIFBF3XX8zc+3CgvM5kBvyR4jTWb6kk4Mia5Q/TLglZa+nVw5p3mdc7
         ku0ww0RcAwi9HDu62rQOhfMstFefawy2yZJwmXko=
Date:   Fri, 30 Sep 2022 16:23:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On Fri, Sep 30, 2022 at 11:35:16AM +0200, Thorsten Leemhuis wrote:
> On 29.09.22 18:42, Laurent Pinchart wrote:
> > On Thu, Sep 29, 2022 at 10:54:17AM -0400, Slade Watkins wrote:
> >>> On Sep 29, 2022, at 10:22 AM, Artem S. Tashkinov <aros@gmx.com> wrote:
> >>>
> >>> I've mentioned several times already that mailing lists are _even worse_
> >>> in terms of reporting issues. Developers get emails and simply ignore
> >>> them (for a multitude of reasons).
> >>
> >> It’s 100% true that emails get _buried_ as waves of them come in (LKML
> >> itself gets hundreds upon hundreds a day, as I’m sure all of you know)
> >> and it just isn’t something I personally see as viable, especially for
> >> issues that may or may not be high priority.
> > 
> > E-mails are not that bad to report issues, but they can't provide the
> > core feature that any bug tracker oughts to have: tracking. There's no
> > way, with the tools we have at the moment (including public-inbox, b4
> > and lei), to track the status of bug reports and fixes.
> 
> Well, I'd disagree partially with that, as my regression tracking bot
> "regzbot"
> (https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> ; https://linux-regtracking.leemhuis.info/regzbot/mainline/) does
> exactly does that: tracking, by connect the dots (e.g. monitoring
> replies to a report as well recording when patches are posted or
> committed that link to the report using Link: tags), while making sure
> nothing important is forgotten. But sure, it's still very rough and
> definitely not a full bug-tracker (my goal is/was to not create yet
> another one) and needs quite a bit of hand holding from my side. And I
> only use it for regressions and not for bugs (on purpose).

Patchwork does something similar for patches, and I agree that it would
be possible to use e-mail to manage and track bug reports with tools on
top (and don't worry, I'm not asking for regzbot to be turned into a bug
tracker :-)). It however has to rely on lots of heuristics at the
moment, as the data we exchange over e-mail is free-formed and lacks
structure. I've been dreaming of support for structured data in e-mails,
but that's a pipe dream really.

-- 
Regards,

Laurent Pinchart
