Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FB70082F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbjELMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjELMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:39:49 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2AC10E6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=s2NZcg55unREGVI0OwhK9zry2exN
        8BKg42mDXxE31HQ=; b=0IeA5ymnNhDMyF3AOSSpQbc46bGkZJnHH9S6IQ2HmYnb
        jp5MBGGT+A8H0kaMlYI9OB+vUN2RnW7C1iuy6yYYlkquvtDTsG8Re++3XC48Mpvm
        laO2wl87s8jve736KiR7bPqYh0Cbz5YmPgBGt6ooSjYWgniTCAkmo/3sohSBA9c=
Received: (qmail 3191189 invoked from network); 12 May 2023 14:39:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 May 2023 14:39:42 +0200
X-UD-Smtp-Session: l3s3148p1@GMU0Zn77qqMujnsI
Date:   Fri, 12 May 2023 14:39:42 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RFT v3 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4
 fuse support
Message-ID: <ZF4zjmkoE/njjG4x@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
 <TYBPR01MB5341AF3D9EB0F9A074283341D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tZvcxKU0LyhGLxNP"
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341AF3D9EB0F9A074283341D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tZvcxKU0LyhGLxNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thank you for the patches!
> I checked the patches. So:
>=20
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> And, I tested on R-Car H3 ES3.0 and R-Car S4 and it worked. So,
>=20
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Awesome, thank you Shimoda-san!


--tZvcxKU0LyhGLxNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmReM4oACgkQFA3kzBSg
KbaR7Q//Y5e1EGDljIopLMY2e9FsTCgBG/ZHzSWpV3DnGgBLdm3IxkexqVP9IcNI
DE1Kd9nxdDLnKVik5IFEe7Lh6k1BAdA4FJzsqvcsGXqm6VS6a5RaWYmcluTqqZ/O
q6TaDbROSftcAvcV1+T11dhGpBVXYxfkPw3jZmFM66p+ITUKp2ha998eAlbEbP+C
zd97yZRZC+VgGAPWYHIoXMPHr+pyuteU9rgPOparWtzp8nj8BzoEAEoAzMjnln5k
6xxObgrzxOHJZA1Dc9JcparuA7qZgATiNvOtanEH3kIBg/cbf9HaQ0TRBGIEQw7z
VSsQxakdadrakyKVstu/0bdP3SmGpJQRSEwzKCYmYTp1qNpasOi4wj/wkpM9L3m3
8bxeOqsnD0skvnJTpL2NPKq3jz/PF1PJQyqFW5aFraVMGqansGufzeuU1JS1uksk
qxjysMWUSvWhIRAvtBj/CvZkPPsSWO8y7L3c4BzH7tZcRq7jmwWGme92vkjAvC69
nx3cwiqmngVn8ghYKXR6orvR60RPNELZl+2BQXBEK05uGzV8CetnNExzFIrZhEOq
KGbTDBvK+TTagA0jTsuyA4g+idacnySmDCHFLxTEVp6Zjb4NGUvvUHEIV3YCHUkT
Gx6p3JmS1Fa5InmuZIG7ANXww8AVM8/+oxhwAhCyJ4YaIkAmc+s=
=ZnvZ
-----END PGP SIGNATURE-----

--tZvcxKU0LyhGLxNP--
