Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCD6585CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiL1ShJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiL1ShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:37:05 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCE13F45;
        Wed, 28 Dec 2022 10:37:02 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:36:24 -0600
From:   John Helmert III <ajak@gentoo.org>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6yMqNRxwVuFnWJZ@gentoo.org>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
 <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CoFdSg65v6lCt4eN"
Content-Disposition: inline
In-Reply-To: <Y6yEv+6iYQQNaqi9@itl-email>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CoFdSg65v6lCt4eN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 01:02:35PM -0500, Demi Marie Obenour wrote:
> On Wed, Dec 28, 2022 at 12:25:17PM -0500, Shawn Webb wrote:
> > On Wed, Dec 28, 2022 at 11:47:25AM -0500, Demi Marie Obenour wrote:
> > > On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> > > > On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/=
VE6BBM) wrote:
> > > > > Dominique Martinet writes:
> > > > >=20
> > > > > > But, really, I just don't see how this can practically be said =
to be parsable...
> > > > >=20
> > > > > In its current form it never will be.  The solution is to place
> > > > > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > > > > to get the command+args part (assuming I counted all those fields
> > > > > correctly ...)
> > > > >=20
> > > > > Of course, this breaks backwards compatability.
> > > >=20
> > > > It would also break forwards compatibility in the case new fields
> > > > needed to be added.
> > > >=20
> > > > The only solution would be a libxo-style feature wherein a
> > > > machine-parseable format is exposed by virtue of a file extension.
> > > >=20
> > > > Examples:
> > > >=20
> > > > 1. /proc/pid/stats.json
> > > > 2. /proc/pid/stats.xml
> > > > 3. /proc/pid/stats.yaml_shouldnt_be_a_thing
> > >=20
> > > A binary format would be even better.  No risk of ambiguity.
> >=20
> > I think the argument I'm trying to make is to be flexible in
> > implementation, allowing for future needs and wants--that is "future
> > proofing".
>=20
> Linux should not have an XML, JSON, or YAML serializer.  Linux already
> does way too much; let=E2=80=99s not add one more thing to the list.

Handling a new binary format is not 'one more thing' added?

> --=20
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab



--CoFdSg65v6lCt4eN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQyG9yfCrmO0LPSdG2gXq2+aa/JtQUCY6yMpgAKCRCgXq2+aa/J
tWoKAQCRkJHN0sL4FpQZJY3bEVntGJDGPha+T+AREOiCTkv5zgEAiC0DnVVwRiL6
YXK06d3aRs3A6Ldg3QXXk1hNCncD7wM=
=GEbr
-----END PGP SIGNATURE-----

--CoFdSg65v6lCt4eN--
