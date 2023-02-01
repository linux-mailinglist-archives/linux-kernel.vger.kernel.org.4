Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2C685E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBAELl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBAELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:11:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F57EC71;
        Tue, 31 Jan 2023 20:11:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P67lS5B2Sz4x1f;
        Wed,  1 Feb 2023 15:11:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675224694;
        bh=ZxoymRVk02ddEs9/fYpUAdMk5ZQOF6B6GW8rBCDkzC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DLr8ZxcoUfgnD8jAXCMQ0ANO9I/L3eqxPSdQqmH7e7ryKwY9FTJ8hQdNzb9bfjxM2
         DrRBUPpgyWdSRsh6E3j5GGYdNDmOlON+r5LSc/wy/hCuwvV6KgzyeKAnfvESt9gQ4I
         9UqTlT2EiTpYM8RZowy8Q7ZBad708GiQaH+LjN6UhtxZPixPd03LjBhd4veWgJwS2L
         15lFE6XMJbMNMb/7vbnZKIu1VBodwwnar7gwdhicYGGz0x/slkePyfn9f7CaFMhgYa
         g1O2zYtj44yjkCK86+J9OyVeJ2+s0rQEuhIF4hfXQL02rdoh7/xvXTdatvHZ5inwmm
         w5fkaUV0UdrHw==
Date:   Wed, 1 Feb 2023 15:11:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Harrison <john.c.harrison@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <greg@kroah.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the
 drm-intel-fixes tree
Message-ID: <20230201151113.22382269@oak.ozlabs.ibm.com>
In-Reply-To: <9566dc52-2ff1-760d-c9cb-fdfef9278f05@intel.com>
References: <20230131130305.019029ff@canb.auug.org.au>
        <Y9kNRVppj5Uxa9ub@smile.fi.intel.com>
        <9566dc52-2ff1-760d-c9cb-fdfef9278f05@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=65UFbDmGI+=z0lGGX0n6Id";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=65UFbDmGI+=z0lGGX0n6Id
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 31 Jan 2023 10:27:29 -0800 John Harrison <john.c.harrison@intel.com=
> wrote:
>
> On 1/31/2023 04:44, Andy Shevchenko wrote:
> > On Tue, Jan 31, 2023 at 01:03:05PM +1100, Stephen Rothwell wrote: =20
> >>
> >> Today's linux-next merge of the usb tree got a conflict in:
> >>
> >>    drivers/gpu/drm/i915/gt/intel_engine_cs.c
> >>
> >> between commit:
> >>
> >>    5bc4b43d5c6c ("drm/i915: Fix up locking around dumping requests lis=
ts")
> >>
> >> from the drm-intel-fixes tree and commit:
> >>
> >>    4d70c74659d9 ("i915: Move list_count() to list.h as list_count_node=
s() for broader use")
> >>
> >> from the usb tree.
> >>
> >> I fixed it up (the former removed the code changed by the latter) =20
> > Hmm... Currently I see that 20230127002842.3169194-4-John.C.Harrison@In=
tel.com
> > moves the code to the drivers/gpu/drm/i915/gt/intel_execlists_submissio=
n.c.
> >
> > Is there any new series beside the above mentioned that touches that fi=
le and
> > actually _removes_ that code? =20
> As long as the removal is limited to list_count/list_count_nodes,
> that's fine. I only moved it from one file to another because the one
> and only function that was using it was being moved to the other
> file. If someone else has found a use for the same and wants to move
> it to a more common place then great. I assume there was no conflict
> happening in the i915 specific code.

I have added this fix up patch to linux-next today (more or less - this
is a hand hacked version, but you get the idea):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 1 Feb 2023 13:13:01 +1100
Subject: [PATCH] i915: fix up for "drm/i915: Fix up locking around dumping =
requests lists"

interacting with "i915: Move list_count() to list.h as list_count_nodes() f=
or broader use"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../gpu/drm/i915/gt/intel_execlists_submission.c    | 15 +------------
 1 file changed, 2 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers=
/gpu/drm/i915/gt/intel_execlists_submission.c
index 3c573d41d404..e919d41a48d9 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -4150,17 +4150,6 @@ void intel_execlists_show_requests(struct intel_engi=
ne_cs *engine,
 	spin_unlock_irqrestore(&sched_engine->lock, flags);
 }
=20
-static unsigned long list_count(struct list_head *list)
-{
-	struct list_head *pos;
-	unsigned long count =3D 0;
-
-	list_for_each(pos, list)
-		count++;
-
-	return count;
-}
-
 void intel_execlists_dump_active_requests(struct intel_engine_cs *engine,
 					  struct i915_request *hung_rq,
 					  struct drm_printer *m)
@@ -4172,7 +4161,7 @@ void intel_execlists_dump_active_requests(struct inte=
l_engine_cs *engine,
 	intel_engine_dump_active_requests(&engine->sched_engine->requests, hung_r=
q, m);
=20
-	drm_printf(m, "\tOn hold?: %lu\n",
-		   list_count(&engine->sched_engine->hold));
+	drm_printf(m, "\tOn hold?: %zu\n",
+		   list_count_nodes(&engine->sched_engine->hold));
=20
 	spin_unlock_irqrestore(&engine->sched_engine->lock, flags);
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/=65UFbDmGI+=z0lGGX0n6Id
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZ5nMACgkQAVBC80lX
0GwZSgf+J3HPZ1ZJA5+d4OY81uKWKuMZJ5FKUiR+PijIJt/sW0bnG4JzcsHpuXzs
3//OTlFawYLzfGCqrHPDF58h5I5a5Eubjffwla1LnXM9lJG0qffm7mp8/ZksQ7BC
yDgDVx0hPWLem4UASwpiFo/NTkcxUBmyLkttqsw/3vc5KB2iUCdn9m5W5fYZdctR
CNYXPouHcY1yjWx6tXJXjbCjHHXo+M/JkGDRDRByggEDDPterS7K0HDeRLU1BrXj
DjBc9G5DigbkR6kCMmwqAqYOqeCOxm6bJvn2N7VVGqdfUmOW2t2Rqls6na5b2gTU
iu6hRSeH9OX50CQ1P0IM8rDRbTPVnQ==
=YPei
-----END PGP SIGNATURE-----

--Sig_/=65UFbDmGI+=z0lGGX0n6Id--
