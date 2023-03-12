Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA36B6BE4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCLV5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:57:40 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852133BD94
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:57:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev;
 q=dns/txt; s=smtp; t=1678658257; x=1678665457; h=In-Reply-To: Content-Type:
 MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From:
 From: Date: Sender: Sender; bh=w0I+lyfV4KTpAnoXhV952nqm+Pgiow7LJPvJH10ZJ6I=;
 b=cAe6fSW4tq9JhV1uV9QICmpVPiTeEUV/EQJ7rXWCgB1C4+11zxhQkIMSOjlEw4fzyUk3mphyCByNK/4IGPq2KFsx2z1yoT02m2Ub8vdM2SgeXLIpvZN1JKnEyhMezfNEQbH00KYwIFsCWf1lm5EfZPyrS5+BFbq32c0KzLA1HkEZ9fKTG8puz8DiHuf+vJZE7oR3LgoVOCAhnAStb9TDSrcLzS+Y4k1Y/x6hIt704z2RG38wwFvlfQcjH4yeG6BzHB81crYatIByu5gTxfW/5f87F8Lt421W6KjyZ2VpXcqHSYnxgXu+YNzpJq9DkK79QG04Jw12wEcxeXSBcDISZw==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJiZTljNmQiXQ==
Received: from guidai (186-250-91-164.mhnet.com.br [186.250.91.164]) by a70f3eba752c
 with SMTP id 640e4ad1b0de3c33d3d2efd6; Sun, 12 Mar 2023 21:57:37 GMT
Sender: codeagain@codeagain.dev
Date:   Sun, 12 Mar 2023 18:57:27 -0300
From:   Bru Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH] coding-style.rst: indentation: Clarify tabs text
Message-ID: <20230312215727.xjs4jusdzpnfhjd3@guidai>
References: <20230228222035.k227xb3okt2lbksn@guidai>
 <87356gpjqv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkxuay2ar4gkqjoa"
Content-Disposition: inline
In-Reply-To: <87356gpjqv.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vkxuay2ar4gkqjoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Jonathan!

(Resending for I accidentally didn't copy the lists)

On Tue, Mar 07, 2023 at 10:13:44AM -0700, Jonathan Corbet wrote:
> Bru Moreira-Guedes <codeagain@codeagain.dev> writes:
>
> > It might be misleading, especially for some autistic readers for whom
> > English is not the first language and whose tendency to interpret things
> > more literally might be present (i.e., my very own self).

Perhaps I clearly made a poor description of the problem this patch
solves. I'll address it in details when I respond to your points. I
could certainly improve it for a v2.

> >
> > The present patch clarifies the tabs text on such aspects.
> >
> > Signed-off-by: Bru Moreira-Guedes <codeagain@codeagain.dev>
> > ---
> >  Documentation/process/coding-style.rst | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 007e49ef6cec..9a0205fa7ed3 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -18,23 +18,25 @@ Anyway, here goes:
> >  1) Indentation
> >  --------------
> >
> > -Tabs are 8 characters, and thus indentations are also 8 characters.
> > -There are heretic movements that try to make indentations 4 (or even 2!)
> > -characters deep, and that is akin to trying to define the value of PI to
> > -be 3.
> > +The Linux Kernel uses the TAB character for indentation, as in the K&R
> > +style. Tabs are meant to be viewed as 8-characters, and thus
> > +indentations are meant to be seen as 8 characters as well. There are
> > +heretic movements that try to use spaces for indentation, or make tabs
> > +viewed as 4 (or even 2!) characters, and that is akin to trying to
> > +define the value of PI to be 5.
>
> I guess I really don't see how this kind of tweaking helps things; this
> text has stood for a couple of decades or so without evident
> misunderstandings.

Well, there was my own misunderstanding that motivated this patch :-}
so, there is at least one evidenced case. Anyway, I think this is more
of an improvement to make the text accessible for everyone, including
autistic readers who might have a tendency towards literal
interpretation. Just like me :D

I don't actually think we would have a way to find out if everyone else
who read this text throughout all those decades got it properly.
Historically, the linux kernel hasn't been overall a much accessible
project in a general sense. I think this kind of change is important if
we want to move to the right direction.

> ...and I'm totally mystified as to why we've redefined pi from 3 to 5?

Ohhh, never mind this part, it shouldn't be here. At first I was
undecided on whether to change it or not. I actually thought I had
removed it. It just came to my mind that the value of pi is a constant,
yet its representation is always bound to a certain precision level.
Since the text didn't use decimal places, assuming no decimal precision
the pi is actually near 3. Since the text appears to be trying to show
an example of something "absurd", I think another value could be more
appropriate. But yea, this change would not affect anyone and I think it
shouldn't be done.

> >
> > -Now, some people will claim that having 8-character indentations makes
> > +Now, some people will claim that viewint 8-character tab indentations makes
>
> Adding typos doesn't really help either.

Sorry, I clearly had a poor review of the changed text (and I failed to
setup spell-checking on checkpatch.pl). Yet Bagas did an excellent job
in the other thread pointing me out all the details I missed. I'll be
doing a v2 soon!

Best,
Bru Moreira-Guedes
they/them


--vkxuay2ar4gkqjoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCZA5KxwAKCRAZtd3tyEY2
knx6AQC4IrNGSbbmCnvUGreWoxw8zI51sGbmnP5/QW1HhysmvgEA0uRDJ1PFc8lw
c03rv5iS2gh053jNGIjb8lvOM+2O3gM=
=5Q7e
-----END PGP SIGNATURE-----

--vkxuay2ar4gkqjoa--
