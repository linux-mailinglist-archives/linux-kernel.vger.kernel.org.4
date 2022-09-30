Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6955F103A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiI3Qre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiI3Qrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:47:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BEB61D94;
        Fri, 30 Sep 2022 09:47:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5723247C;
        Fri, 30 Sep 2022 18:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664556447;
        bh=J8D/Bn7Wpr/IjvMKlhrSxs1NNupaYj+LgM6dPb2NuX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdq6NxCDkbMg7Cl2rrYvx+omB+MnCQpnj5ag1p5guCzcn9X9kpfIcMxtL2wkR2DbP
         aEEtsGWZyU+VjjgtHK1hV4SIuNyPkLc0EcVx7kdp9VtOojItigKVZDbEL7gWuxb66s
         GpqkKuQRe2WcqLYnWufhjzy0S01zyG+QY8JPhRuA=
Date:   Fri, 30 Sep 2022 19:47:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzcdnnjJA4M09dNH@pendragon.ideasonboard.com>
References: <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
 <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cfaef48-744f-000f-1be5-6f96d64dea24@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:34:08PM +0000, Artem S. Tashkinov wrote:
> On 9/30/22 16:19, Bird, Tim wrote:
> > E-mails sent from a web interface could have as much structure as you'd like.
> > So one avenue would be to set up a nice interface for bug reporting, that just
> > delivered the form data in e-mail format to the proposed bug-receiving mail list.
> >
> > Also, if an e-mail receiver (something automated) gave a quick response on missing fields, I think
> > you could quickly train users (even first-time bug submitters) to provide required
> > data, even if they're sending from a free-form e-mail client.
> >
> > Just my 2 cents.
> >
> >   -- Tim
> 
> Debian uses an email based bug tracker and you know what? Most people
> avoid it like a plague. It's a hell on earth to use. Ubunutu's Launchpad
> which looks and feels like Bugzilla is a hundred times more popular.

It would be pretty sad if the only options we could come up with for bug
tracking would be either popular with reporters and ignored by
maintainers, or the other way around. Ideally we wouldn't have to decide
which of those two classes of users to prioritize, but I fear that,
given resource starvation, we'll have to make a decision there that will
be unpopular with one of the two sides.

> Sometimes programmers have to realize that most people around are not as
> smart as they are.

I wouldn't equate familiarity with classes of tools (and related usage
habbits) and intelligence. Some tools may be easier to learn and use,
but it doesn't mean they're good for the problem at hand. I used to joke
several years ago that the younger generation will force older
maintainers to switch to doing code review on facebook (nowadays I would
probably say tik-tok). And then
https://github.blog/2021-05-13-video-uploads-available-github/ happened.
And that https://www.videocode.review/ (meanwhile, git..b still don't
support commenting on a commit message in a review).

-- 
Regards,

Laurent Pinchart
