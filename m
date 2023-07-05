Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD24E748FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGEV2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGEV2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:28:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498AF1980;
        Wed,  5 Jul 2023 14:28:49 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F29B6600B9D;
        Wed,  5 Jul 2023 22:28:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688592527;
        bh=v6KF89+CnrHuNVZAgjNXnRgiaU2Do6lQOOpDJ6osiAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eS/wQGRAe4CG/hm3MP3R8XTqLtBe//woCEASq6y3SBppN4b/Mo7Q8RLZA2wwwoif5
         uVHnBeZ/MlMumMDXdwGZ6KPI1J0W8IpX3/ihoqBxHblxWcCGr6+AvAU02aijLd1yLB
         8jp91/E2jOltL9ra0dVIJpnqM+OzY5h2r0YnACPNbZHwsZqZ7pdK0B5wsdcVCq9i7M
         cZdnSGgOCUwc9B8uJVyCPd/VjLRA4EitZH+Pu25fLPdXb+e8pMMBJPEPEQ6todfY3B
         tOGU+vrNUvGAi0UJ2at7osEybrgxeiV+hdKLYaI3UBDOyyPRyAq4sjNNEJziIwUVUL
         YNv9P+g67KrRA==
Received: by mercury (Postfix, from userid 1000)
        id 2B0E1106742B; Wed,  5 Jul 2023 23:28:45 +0200 (CEST)
Date:   Wed, 5 Jul 2023 23:28:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] input: cpcap-pwrbutton: remove initial kernel-doc
 notation
Message-ID: <20230705212845.w2yhqb75fqx6psim@mercury.elektranox.org>
References: <20230703230005.14877-1-rdunlap@infradead.org>
 <20230704000821.z3tx4chw7x6pn6nq@mercury.elektranox.org>
 <ZKXEcr+43Qkj8Y4m@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lv4j3zwvdo6qii6"
Content-Disposition: inline
In-Reply-To: <ZKXEcr+43Qkj8Y4m@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lv4j3zwvdo6qii6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 05, 2023 at 12:28:50PM -0700, Dmitry Torokhov wrote:
> On Tue, Jul 04, 2023 at 02:08:21AM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Mon, Jul 03, 2023 at 04:00:05PM -0700, Randy Dunlap wrote:
> > > Change the beginning "/**" in the file to "/*" since it is not a
> > > kernel-doc comment. This prevents a kernel-doc warning:
> > >=20
> > > drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts =
with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/k=
ernel-doc.rst
> > >  * CPCAP Power Button Input Driver
> > >=20
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > ---
> >=20
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Applied, thank you.
>=20
> BTW, the driver is missing SPDX annotation, Sebastian I wonder if you
> could send a patch addressing this (given you are the author it is
> better coming from you).

DONE: https://lore.kernel.org/all/20230705212231.631525-1-sre@kernel.org/

-- Sebastian

--3lv4j3zwvdo6qii6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSl4IkACgkQ2O7X88g7
+pr6DhAAm6e1g1dwTF3ltG47UxrTAZ6IlYSjvtm+1zaDnqxcKm3Ce7H489wAcsTc
tKDJ1YHl2VXqMkStHpXJ/XiGJjkgGT6lPntjaTrYmCt+ewHYNB1PJPp/a1jbiTDC
Sr26JnGHvoDMpifx5AcWLO27QKxzxl2NIGSYkJchUaphnRDblSYZaqWy/B2v9GVw
K9Hkym65vq0guXFmDyuApEXZ9bFjLTa/zG0KzdCyISZVfwVdAZIu6Iep43TScMiE
H3WLWK7zz4ex6yBddgMSgaT3DNaZb50hv93LvGmNvpOaVGYYzLxB0UBEdRAF/5B2
2Lcc4u/Z/ukYnEJzLo8vv7nupZwlVbad1crTPqo1Ot5qoEHoLfZazydYzAax1aSo
ZB0FqwcCRYA7YbDIvI78K5pFOYv2/bsrsQlaogAoCMAYwzowNhkzJAhznyg4rAaZ
PSdVL7JJMyGjJEHXfTxl52SWh4ddT8nLowFq8UNqc/+X2zwyptMOQHE5XGysKt7C
mfnihL8te6rdoIN/Prc+pyLfKy9IMxk81uUfSiDhnbZj0OlW+VHr8cGbLgqlq/QU
Dxw9XWJHwysktq8s6GBVoI8mHcCc63tWezQXVwtYgRRN5vUTeAKQwzOZYCtCu2D/
/3zj2VGTYTmGvOVn1kaumHh8t7nqiqYJnc1wbLgfVAbyluq0jK4=
=Sdn7
-----END PGP SIGNATURE-----

--3lv4j3zwvdo6qii6--
