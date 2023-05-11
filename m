Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A246FF9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjEKTOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbjEKTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:14:26 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A68A73
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=nSymzzpt1JEDs/GOQx703VjKGgzj
        sDvD7bP2a/kUT7I=; b=K/gXAkHHjonaNKDPCrNMOJfcpn/MM3upIsWM94buSQWF
        ebZRYTWbuhJeLS9bPHxY2NTNciIZAYMFupYHMuGkgrr8K0c4QuXd4UoQEs0OMhcf
        GATfa08DITX8ZxmwPYsT9dYT+TU4xeqV/p7RzB6HgCp5nB+82tO0cbx1V9qYltQ=
Received: (qmail 2933041 invoked from network); 11 May 2023 21:12:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2023 21:12:59 +0200
X-UD-Smtp-Session: l3s3148p1@N53Mxm/75swujnsI
Date:   Thu, 11 May 2023 21:12:56 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT v2 3/3] drivers/thermal/rcar_gen3_thermal: add
 reading fuses for Gen4
Message-ID: <ZF0+OIvCcaDGoJ51@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
 <20230420092128.6073-4-wsa+renesas@sang-engineering.com>
 <TYBPR01MB53413B97CCBAC486C2CF7085D8609@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E8UlnS00tFbKHZn8"
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53413B97CCBAC486C2CF7085D8609@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E8UlnS00tFbKHZn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	priv->ptat[0] =3D rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSF=
MON01) &
> > +		GEN4_FUSE_MASK;
>=20
> s/REG_GEN4_THSFMON01/REG_GEN4_THSFMON16/
>=20
> According to the table in 13.3.3.4 of R-Car {S4,V4H} Hardware manuals:
>=20
> PTAT1	PTAT_PF_U_SR1 bits (of THSFMON16 register)
> PTAT2	PTAT_PF_R_SR1 bits (of THSFMON17 register)
> PTAT3	PTAT_PF_L_SR1 bits (of THSFMON15 register)
> THCODE1	THCODE_U_SR1 bits (of THSFMON01 register)
> THCODE2	THCODE_R_SR1 bits (of THSFMON02 register)
> THCODE3	THCODE_L_SR1 bits (of THSFMON00 register)

Oops, you are right, I mixed the two blocks :/ I'll send a fixed version
right away!


--E8UlnS00tFbKHZn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRdPjgACgkQFA3kzBSg
KbbBOQ//Un2jeKGr+C04Wx6HIeeqRXI+G47g1ImBzHTGtjZhvz4IBL3fVn3C4A20
n7N1HQAGfohCmdzRg0X7uKWe6knY8m3SmDCwPMS7Z9WfQCdfNYZE7+isSylOTenh
9Ow67waOknQBL7jYgq7vTu87oeCLAVeopvBEZgj5lda/7cIHU4YZx9MbKPaL096L
NxiMZC3qyqmy6NlrRPoeUxlGgdAZMs6I28N8X8rB1OkOUz390EHW+S1SPrAkk08G
IjpcHn7TYx1RBq2nQG1UGZLbYQbZCBVCSnp7rOepz5OHaR7Mtn448k4vIn4ELU7P
hQ1Hx3Qtf9N8E67HaT2q+dXgF58CYIgXKgfJFfSxCuUPSRIUPjCnkufkRHZAGit9
stUNAdQINgVb900Jg8pAxcMvdLn1a4ZgkgGY5iGWfEbvqZLtCNqYES0nZE9gErFc
5bE9JoNDSXGVS2tEGOSra4AvzJrc+Js1ginvQ+zmhoclLE9pSvVLGz45VXO39tOf
Mjl0rVVOZFy9c1B7UNZqntip3jcOmL35BFYNgBP9Up5CBD/DgQwrbqw2g2UJIVNL
xyD579Ukl3Da/CDBms1PNx3vOnvGz5RewkuDpzxibZc+caY9hOmB6AlRrtGKbnyc
FxwycsI/5H+jyLqYODmd+u4rzGbHl7CWeKe122AZWywGuAfgK9w=
=PBCL
-----END PGP SIGNATURE-----

--E8UlnS00tFbKHZn8--
