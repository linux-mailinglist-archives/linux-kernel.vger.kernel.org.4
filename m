Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAE67994A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjAXNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:32:42 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5AA1420D;
        Tue, 24 Jan 2023 05:32:39 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 95E82240007;
        Tue, 24 Jan 2023 13:32:37 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] module.h: Fix full name of the GPL
Date:   Tue, 24 Jan 2023 14:32:26 +0100
Message-ID: <3145585.5fSG56mABF@bagend>
Organization: Connecting Knowledge
In-Reply-To: <Y89HHtQQ4/pvsOut@debian.me>
References: <20230122193443.60267-1-didi.debian@cknow.org> <Y89HHtQQ4/pvsOut@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5798158.MhkbZ0Pkbq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5798158.MhkbZ0Pkbq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] module.h: Fix full name of the GPL
Date: Tue, 24 Jan 2023 14:32:26 +0100
Message-ID: <3145585.5fSG56mABF@bagend>
Organization: Connecting Knowledge
In-Reply-To: <Y89HHtQQ4/pvsOut@debian.me>
MIME-Version: 1.0

On Tuesday, 24 January 2023 03:49:02 CET Bagas Sanjaya wrote:
> On Sun, Jan 22, 2023 at 08:34:43PM +0100, Diederik de Haas wrote:
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> 
> No patch description, really?

Writing the exact same comment 5+ times ... really? *
You might take inspiration from Greg's bot, which clearly identifies itself as 
being a bot, is WAY more friendly and actually useful as it points out why 
it's wrong and where I can find out how to improve it.
Your messages were none of that.

While I should have, but hadn't read "The canonical patch format" section 
Greg's bot pointed to, it turns out that my own common sense/practice didn't 
violate it. I'm a HUGE proponent of extended commit messages and often try to 
convince others to do so too, often pointing to the linux kernel to take 
inspiration from.

"The explanation body will be committed to the permanent source
changelog, so should make sense to a competent reader who has long since
forgotten the immediate details of the discussion that might have led to
this patch."

So it should add context for people who'd see the patch months/years down the 
line. As the Subject/summary phrase rarely is capable of providing the 
*needed* context, that's highly useful and valuable.

In this case, the patch is simple and IMO the Subject already contains all the 
details one need have to understand this patch 5 years from now.

So I could've added "The full name of the GPL is not GNU Public License, but 
GNU *General* Public License." to/as the explanation body, but I didn't 
consider that to provide extra (needed) info which wasn't clear from the 
Subject and diff.

My only previous patch submission (to the linux kernel) did contain a full 
explanation body: 7074b39d83f5d71fa4f0521b28bd4fb3a22152c1

*) I made a clusterfsck of similar patch submissions where I replaced "GNU 
Public License" with "GNU General Public License", and got the exact same 
comment from Bagas to several of them.
I've (now) retracted all of those patches, except this one. In those other 
ones, I later realized I would actually be changing the license, not merely 
fixing a spelling error.
See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/

AFAICT, for this patch I'm not changing the actual license, only references to 
that license, so that can still be considered spelling fixes.
That's why I haven't requested to ignore this patch (too).

> >  include/linux/module.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 8c5909c0076c..329fa0b56642 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -186,14 +186,14 @@ extern void cleanup_module(void);
> > 
> >   * The following license idents are currently accepted as indicating free
> >   * software modules
> >   *
> > 
> > - *	"GPL"			[GNU Public License v2]
> > - *	"GPL v2"			[GNU Public License v2]
> > - *	"GPL and additional rights"	[GNU Public License v2
> > rights and more]
> > - *	"Dual BSD/GPL"		[GNU Public License v2
> > + *	"GPL"			[GNU General Public License v2]
> > + *	"GPL v2"			[GNU General Public License v2]
> > + *	"GPL and additional rights"	[GNU General Public License 
> > v2 rights and
> > more] + *	"Dual BSD/GPL"		[GNU General Public License v2
> > 
> >   *				 or BSD license choice]
> > 
> > - *	"Dual MIT/GPL"		[GNU Public License v2
> > + *	"Dual MIT/GPL"		[GNU General Public License v2
> > 
> >   *				 or MIT license choice]
> > 
> > - *	"Dual MPL/GPL"		[GNU Public License v2
> > + *	"Dual MPL/GPL"		[GNU General Public License v2
> > 
> >   *				 or Mozilla license choice]
> >   *
> >   * The following other idents are available
> 
> Why did you do that? Maybe as justification for your other GPL name
> expansion fix patches?

Debian's lintian tool complained about it and after looking at
https://www.gnu.org/licenses/ I concluded that lintian was right.

As the full/proper name of the GPL is GNU General Public License, I submitted 
a patch to fix that.

> Anyway, let's see what Linus thinks.

Sorry you all had to see my rant, but after seeing (and ignoring) Bagas' 
rather useless and exactly the same comment numerous times yesterday and 
getting accused of being a bot (!) and someone else feeling the need to point 
out Bagas' less then constructive behavior AND me feeling shitty about my 
clusterfsck and spending considerable time fixing that (which is fair) 
yesterday, it seemed Bagas went out of their way to find the one patch I hadn't 
asked to ignore and add the same useless and bot-like comment to, I had 
enough. I'm not a delicate flower which needs to be handled with extreme care, 
but everyone does have a breaking point.

If this patch is just wrong, please ignore it. If it needs improvement, let me 
know and I'll do my best to do so.

Regards,
  Diederik
--nextPart5798158.MhkbZ0Pkbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY8/d6gAKCRDXblvOeH7b
biyVAQDf7ls0EQkqAqKpC2oSGzyvWGEgag3P4hVNLFKf2b9aqwEAl3Av/tGKPril
Sq32iwuA67K3SF84QLpo+GvWejYi4wA=
=MzL3
-----END PGP SIGNATURE-----

--nextPart5798158.MhkbZ0Pkbq--



