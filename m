Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462671517D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjE2WIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2WIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F0D9;
        Mon, 29 May 2023 15:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 501DB6222C;
        Mon, 29 May 2023 22:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA58C433D2;
        Mon, 29 May 2023 22:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685398089;
        bh=/SAkM6L6pLMXULtkz7jaGIEEbq1gF6/aA1Vc65sJ6uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8PWnZW4AF72HlirtTCBde2dEFCjGxmiRFxxMqa7GeOJ7e3N2qNnJ75HENYd8hpBS
         DS7bS/KZZlfRWnFScHpfcsyJsdG7blZOcE484Ndyo7gKFkO8Mgt8E+X47Q1qJwiT69
         hqD0E0492cXsYx5jE/nlwKvxOBmaEMSYCzVLrymQJa0E0Yik3KEMKTLFdElbxdSEIU
         UNjEB/IHooaDwHQAZoMTsYedMNcfj2ryA0k5d7H6XX3AEw16MpvmODxW6QUjdM0Kmo
         hdh9EAvP48SVIQgABOMYLdUFa2Yx5h7tiikhNdWhkarkMkL3URCL5shmsvmQAGbZtm
         Uayx8z7JA0RQA==
Date:   Mon, 29 May 2023 23:08:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mips: Add bindings for TP-Link HC220
 G5 v1 board
Message-ID: <20230529-justify-runaround-a1dc64980ece@spud>
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-3-liviu@dudau.co.uk>
 <20230529-unhook-alone-1b1bd6e6a226@spud>
 <ZHUe9RJfweNBAU0K@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lt45wcAU/aD5Q3aP"
Content-Disposition: inline
In-Reply-To: <ZHUe9RJfweNBAU0K@bart.dudau.co.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lt45wcAU/aD5Q3aP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 10:53:57PM +0100, Liviu Dudau wrote:
> On Mon, May 29, 2023 at 10:00:20PM +0100, Conor Dooley wrote:

> > Two process things:
> > - Please run get_maintainer.pl against the current git tree - you seem
> >   to have missed 2 of the 3 dt-bindings maintainers. I don't mind my
> >   omission, but omitting Krzysztof means you're submitting patches based
> >   on a tree that is over a year old.
>=20
> Appologies for that, I should have check get_maintainer.pl rather than lo=
oking
> at the output of git log for the file.

Yeah, git log ain't the way to do things ;)

>=20
> > - Please don't send a v2 in reply to the v1.
>=20
> Sorry, I'm not sure why that makes any difference. Reason for sending it =
as a
> reply was the fact that last conversation was more than two weeks ago, pe=
ople
> might have forgot the context. This way it's all in one thread.

That's fine, just include a link to v1 on lore for anyone that cares
about the context, like so:
https://lore.kernel.org/all/20230529150833.526084-1-liviu@dudau.co.uk/

I knew this mail had been sent today because I noticed at the time that
you'd only CCed Rob but I remembered nothing of the subject line since
I saw it hours ago. Look how far back in my mailbox it ended up because
of being sent as a reply to the v1, and that mailbox only contains
emails from the devicetree list!

4380     May 29 Liviu Dudau     (7.6K) =E2=94=82       =E2=94=8C=E2=94=80>[=
PATCH v2 1/2] mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board
4381   T May 29 Liviu Dudau     (5.8K) =E2=94=82       =E2=94=82   =E2=94=
=8C=E2=94=80>
4382  sF May 29 To Liviu Dudau  (6.8K) =E2=94=82       =E2=94=82 =E2=94=8C=
=E2=94=80>
4383     May 29 Liviu Dudau     (4.6K) =E2=94=82       =E2=94=9C=E2=94=80>[=
PATCH v2 2/2] dt-bindings: mips: Add bindings for TP-Link HC220 G5 v1 board
4384     May 29 Liviu Dudau     (4.7K) =E2=94=82     =E2=94=8C=E2=94=80>[PA=
TCH v2 0/2] mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board
4385     May 12 Ar=C4=B1n=C3=A7 =C3=9CNAL      ( 12K) =E2=94=82   =E2=94=8C=
=E2=94=80>
4386     May 11 Liviu Dudau     ( 10K) =E2=94=82 =E2=94=8C=E2=94=80>
4387     May 11 Ar=C4=B1n=C3=A7 =C3=9CNAL      ( 10K) =E2=94=9C=E2=94=80>
4388     May 09 Liviu Dudau     (7.8K) [PATCH] mips: dts: ralink: Add suppo=
rt for TP-Link HC220 G5 v1 board.

Some patch application & CI tools apparently also get confused, but I
dunno what those tools are.

Cheers,
Conor.

--lt45wcAU/aD5Q3aP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHUiRQAKCRB4tDGHoIJi
0owQAQDqQWE836dDmnGHAOUfNHHIZo2m1J7F1iDctD7ujYfvdgD8DoD19Osygghi
TeU1n9CbriOf+S+Q4AL6mAvfDHyyIQY=
=J02g
-----END PGP SIGNATURE-----

--lt45wcAU/aD5Q3aP--
