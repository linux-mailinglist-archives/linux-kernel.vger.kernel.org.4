Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9D5BEA88
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiITPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiITPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC74E61E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:50:13 -0700 (PDT)
Received: from mercury (dyndsl-091-096-056-222.ewe-ip-backbone.de [91.96.56.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E7AC6601FB8;
        Tue, 20 Sep 2022 16:50:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663689012;
        bh=Ele2r5Mk82M6ScWql+6Q6RFVoEglGSLdXgSuQ7MAzic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFD4LsZXinzZiFYL9PA612J1vI/988d4OhCQ1vjSoFzcrSKS5qe34+Fk/mxYtf603
         MCYc1Lu7o6S7CPlioayjJXjpxHXWEqezeHkHL+kss5DxdBSjZLcVVLEZk45YJSH8/R
         IKdRlE8rC2YJptskK+q6hANhRF3HcDLqeE3e8BxO7wdOofjBnXEiyz00qjHJdm/eOY
         xXxcD565UqB57Xt5LyGoVIs8vOHerY5wZ3Ox7kP/r7gWdRHfwxEvImHVQ21uAH4Eg4
         Yb2HrFXN3C7iJ4zcJIAXfzJ5rwFm5m0xjdgq4iNrcFQLabfNJHfxY+CgyKyXS1MPSg
         UyRpkTLl/7tOw==
Received: by mercury (Postfix, from userid 1000)
        id D607210607CF; Tue, 20 Sep 2022 17:50:09 +0200 (CEST)
Date:   Tue, 20 Sep 2022 17:50:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] HSI: nokia-modem: Replace of_gpio_count() by
 gpiod_count()
Message-ID: <20220920155009.z64izmgko23soava@mercury.elektranox.org>
References: <20220914153755.37866-1-andriy.shevchenko@linux.intel.com>
 <Yym01zusrm4qX7sv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ul5xfs7eqfpyhm7"
Content-Disposition: inline
In-Reply-To: <Yym01zusrm4qX7sv@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ul5xfs7eqfpyhm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 20, 2022 at 03:40:55PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 14, 2022 at 06:37:55PM +0300, Andy Shevchenko wrote:
> > As a preparation to unexport of_gpio_named_count(), convert the
> > driver to use gpiod_count() instead.
>=20
> Any comments on this?

No comments, but I just queued it :)

-- Sebastian

--6ul5xfs7eqfpyhm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMp4TEACgkQ2O7X88g7
+pp8Nw/9HOL6T19PxomspaEO37KCXXf/tXlaOtrDthxhlP6BBx1iuUANrAYod1xE
0PxL77MAFhjw0qHwvi4Hun3CQfoS+N0axmOm+HQ0Vg2kmGtOd0Yqz2+3/f69Pd7S
CajOTXWOuZzFpC6QkgGciI6kdmv+85HJrkKf74oCyhuNVDnchDJM06Y9m2xKIS/t
0SJm2mtkw5sKM+OKAOl1gKD3mT2bX95C+ZUK04PQpYpIJKn1tNrHAvmjco3G1gAL
l0KCKXKxpNuIyq/NHO56CwjH4kwh2rfcoBBFSDaBoW6rse7tTb1t4W9e1lr0xgUI
CZZ9sv8X8se0ix8McBUPf3dZbJ0Wlv5E93d5KtoRWxbeZqHizL52FmD1j8zKM3X2
6vQpwNkdDheIbMAdLEzniNG5BHu/1FDx4+TNgYVGXLYROT/Z6PvGBlADqWzy92eu
I0M841eQuaiDb6zLxSzUHqu5LPjChS9tbR+MtjXv1/keUJpoYq7/XIhtuCx823E2
MECgOANnmDafmFkL8xV/t+yUM1Bv6fODTKA1LJNiq/51WzECKoojFV9/S/YNSn4f
/FMhMHLVlPBgbBHnwS1IemBls82OGexf5mjhqblIDoPTnxScHKgsK3ZHc9bRrtvf
J6jrRHfdU+SZUNZJtK5v92vmCyXiPsRaJQTDeB0TOHHmVzaAYD8=
=Fpnw
-----END PGP SIGNATURE-----

--6ul5xfs7eqfpyhm7--
