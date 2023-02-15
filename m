Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC4697CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBONPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBONPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:15:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79162411B;
        Wed, 15 Feb 2023 05:15:06 -0800 (PST)
Received: from mercury (dyndsl-095-033-159-037.ewe-ip-backbone.de [95.33.159.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81B056602181;
        Wed, 15 Feb 2023 13:15:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676466905;
        bh=dwkwEZMUZEbFVvhUviofeDXBcsOqsOaQbrTHdVJ8mAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f64LgxxoccMfGRd5MY2qsJk0C395jy4CGz+QoQYGn3lNsphKCeI9LzZjmjJcX7hG8
         r72p7Tq3y503a/zcntpe1rjyp2zMc5wcjZvqqgcezyMr0uO/d3kg2AO2EYTWvspZQ3
         azBbLr2CsyUtaC5udjzzqmgP+RPCOUppxXpwe1jFU/eCio3yew7SD9nlqIj9VFeGLA
         lxW2YDpFWFqcZ8P6AitCWIPegkqZV/O/T99iiEGU7rF6txiV0NJxW6IZ5B9RtMRLyw
         CnN+l6paW/dM9Ql3j93z8A7vij1Oa7EJiJA7KhtVl1fCebkP8c2yi0IK/bNphnz3mS
         PedPnKeJn/14g==
Received: by mercury (Postfix, from userid 1000)
        id B1EF610603FE; Wed, 15 Feb 2023 14:15:03 +0100 (CET)
Date:   Wed, 15 Feb 2023 14:15:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Message-ID: <20230215131503.lnk7onzpsnxq5atb@mercury.elektranox.org>
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
 <20230213205321.xrhvrdqy5ksiagbv@mercury.elektranox.org>
 <75d37ae7-3632-a195-b12b-44e8a940be4a@linaro.org>
 <20230215033440.GA6570@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3k3pldcpjihsbnrs"
Content-Disposition: inline
In-Reply-To: <20230215033440.GA6570@linuxcarl2.richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3k3pldcpjihsbnrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2023 at 11:34:40AM +0800, ChiYuan Huang wrote:
> H, Krzysztof/Sebastian:
> On Tue, Feb 14, 2023 at 09:14:37AM +0100, Krzysztof Kozlowski wrote:
> > On 13/02/2023 21:53, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > On Wed, Feb 08, 2023 at 11:14:24AM +0800, ChiaEn Wu wrote:
> > >> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> > >> "richtek,rt9467"
> > >>
> > >> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467=
 battery charger")
> > >> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > >> ---
> > >=20
> > > Is there a new version of this fixing the issues pointed out by Krzys=
ztof?
> > > Also I think the filename and $id should be changed to richtek,rt9467=
=2Eyaml
> > > in addition to the compatible change.
> >=20
> > Yes, indeed.
> >=20
> From the current discussion, there're things to be fixed.
> 1. In bindings, change compatible property from 'richtek,rt9467-charger' =
to 'richtek,rt9467'.
> 2. Rename 'richtek,rt9467-charger.yaml' to 'richtek,rt9467.yaml'
>
> Anything else? like as changing source code filename from from 'rt9467-ch=
arger.c' to 'rt9467.c"?

No, the source code can remain unchanged. But you also need to change
the $id line (line 4) in 'richtek,rt9467-charger.yaml' after renaming
file.

-- Sebastian

--3k3pldcpjihsbnrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPs2soACgkQ2O7X88g7
+prtfhAAnsfReDwggQ6kbCNeAll0Sfl4BVg8e5HP8cO+f9PcGHrZ2QGRVw2qd53j
nruU1+a10OYZp7rqCCnXXfR2JdQyXedNCY6KafJ8QhUnkVX4mRi66YziXcPeAdRm
5hpcA8eOTY0aBsx9CvQA1XdA1MNyjtnaqmkQ2ZtRaTeSQnBHxb+GPbSqXwnn65LE
TM2Zu8Y9SUYkamywW5bcHOE2QXmOlbDimostnI9R5eaW/jIJ8yP2f1fKbg76BaJz
i4z4DY2QKdRN3FDsUD2Ukt8PkqokUbLfKeCqZQWUe7vGnu+dlUXPZJ2KtFsvGcyN
qW15tbqKKpTsFQcLoqRw15Cv7//+g13vTz1tiFO8pPbuPsCgr9Y3pgE9qLJz/ODM
OmiC57nSG1QEpCWrld+45vA6j4CNYsTwf8wTqU/CLHMQWMTzpsARBRSHX9npXv+b
qWlF6m2mFZVhFwcdFE2ueI3p9vvDQ5J4A5epPUbXsumCBHVVWh2Y3WMWzLbRxQx5
+1t36bQ9G/s3XjT/i00GYl9KbCNCchySoMhHASlaG0dsB3X5kq1fNuzxlRyQiQcl
Bwxj3E8yI09zwbJQO19ayMlnVrh2jTDBjrtoSdkll04jFUOdVYDZZv/emX599gzN
hnCqTKL3pHy0Du+1g6mD+eD0o4yPE7WigBzSl7HGmbEfPHp5yBE=
=JKHO
-----END PGP SIGNATURE-----

--3k3pldcpjihsbnrs--
