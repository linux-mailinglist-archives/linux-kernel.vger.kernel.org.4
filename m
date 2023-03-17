Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DD6BE4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCQJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCQJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:04:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2347E91BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Rhi3f9praoz5y8ySslDnXpCvODq7
        jZR0ixa9gWhtu+g=; b=sli5IyEZd7dQYW9hxdazjvgWONCLVPbLFjq1mxVsKbV4
        zxuVPW8tEb8GYWHBdd2jubs5Je6gtRo3se6d+IPzaL6CaWRemTtGJUZ3gC2iQ06E
        uqS5Iq7C7HVw/wJQt9HqZyrGCJ0rU5KDzRzohK5akEG8DK5sz7KkoRoAztwdk1I=
Received: (qmail 4168939 invoked from network); 17 Mar 2023 10:02:49 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2023 10:02:49 +0100
X-UD-Smtp-Session: l3s3148p1@qN5A1xT3sp8ujnvb
Date:   Fri, 17 Mar 2023 10:02:43 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: renesas: Add "renesas," file content pattern
Message-ID: <ZBQss4CsKVrV/nMZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c1be1e97c5457eade25b0eb5118196677cecfc08.1679039809.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcYeugDHl1UQYMh0"
Content-Disposition: inline
In-Reply-To: <c1be1e97c5457eade25b0eb5118196677cecfc08.1679039809.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bcYeugDHl1UQYMh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 08:59:00AM +0100, Geert Uytterhoeven wrote:
> Add a keyword match pattern for the word "renesas," in files to the
> ARM/RISC-V/RENESAS ARCHITECTURE section.  This make sure patches
> changing drivers that match against "renesas,<foo>" (as used mostly for
> Renesas on-SoC components) are CCed to the linux-renesas-soc mailing
> list.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--bcYeugDHl1UQYMh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQULK8ACgkQFA3kzBSg
KbbGig//bCKGptOrExgDeYlfst5dVW1CEnflbrvLLY76wr7K8RuS0+T0wN+9PoMG
TXTzFTmfh3lWWK5+549msZ5YEk5cV6wwupVCnoBI9y9rpmRNPyTw7WEpqDnki0Fr
tMFjPSUKBreCLb2CT76eTAi3ghcYdrMhYvOS63hyUx+NYAXrW38M4EUDYI2zcZPn
ynQ1lAXNTS+ZqMm8JRsGTz5tDSk3nSboWug0uv0z/8oksknW9y63ludzEbHFXZBA
iHWSNuwJngUhc095XZsHWPkLa163BYOUEKnYLvrEzGYKU1CR7BSjWVKaN5Kc/boQ
RG1pfikY4vOd3c+lfkj/0vA5p/Oeel1EoNUrqQZAXrCVGIlqXm7SWOsmV9gF6bxc
yarbMvAPpjHwBYKyaycJcpfWxf/DKWyma/kvrWqF5PscagotvuCGZBxFNcd3I+Sg
CdJupkaUW0qN4AKW7aTmYenUG4jzeOXxtz161RSDDH1775wkI1S/fXzyPyQ7EWkM
oySAAhnRSmqlZi0z21zzVsTUaMmmeLHPciViXJbtyTM8mQ4N4Zk+kcAFVtpfLQn1
w3Ins7GRp+g/DYyXbTZPNDW/P0wgmhPEhhsT0Z67KXWl52Rh3N/tflgWnsz2aueE
Ice9brMC3wr1OTqKYZ9dL+GU3z+v7tKbJ9OXn9cp/0OUb0RpxXY=
=WAN0
-----END PGP SIGNATURE-----

--bcYeugDHl1UQYMh0--
