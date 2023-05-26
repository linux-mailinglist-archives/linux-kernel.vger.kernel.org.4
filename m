Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE8711AED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjEZAAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjEZAAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:00:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751018D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:00:11 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 504FF6606E63;
        Fri, 26 May 2023 01:00:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685059210;
        bh=SJiEXd6/8oMzmDefTMLfhXe8tjYP1lEXfOKt07RVh+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouQrKVkPYOoksse8vSJLLilFmm3rUE5tAp0uH/QPgCx0r7KOXq1mdDZMEhJsZEvkv
         LnVhDac9w2ZN+kR7QZYKuabi5VmIRirjwaKpEJZb9wgYfcsy214O+32o7aQilmYk82
         235JnKj6taV6USIumqXUUt4CFN/rsV1v19Jhav0vXbChJ2KaIHs76PtOdwSRk4P596
         vVuCiJajLFZQ7V3b3pmoM7ZpqFk3K4bXIkW9bpPxlXfjFN4ov8WohO6+c0Z9bzy5Yl
         K8ACV30Qq0WY2312YFcfejFnVtfu6Z2fNg9BrLVeTLCutG9K0iRPQw7HEP/k2M73Jx
         jvhaoHuWZNd3g==
Received: by mercury (Postfix, from userid 1000)
        id 2FA031060A51; Fri, 26 May 2023 02:00:07 +0200 (CEST)
Date:   Fri, 26 May 2023 02:00:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Milo Spadacini <milo.spadacini@gmail.com>
Cc:     heiko@sntech.de, lee@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: mfd: admit rk805 driver registration without
 interrupt support
Message-ID: <20230526000007.mt3opbr4zocm5j7r@mercury.elektranox.org>
References: <20230525070011.23761-1-milo.spadacini@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbwy45zghn6666mw"
Content-Disposition: inline
In-Reply-To: <20230525070011.23761-1-milo.spadacini@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nbwy45zghn6666mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 25, 2023 at 09:00:11AM +0200, Milo Spadacini wrote:
> rk805 use interrupt only for "rk808-rtc" and "rk805-pwrkey" drivers.
> On custom board these drivers could be not used and the irq gpio
> could be not connected.
> Force the usage of a not used gpio, that could be floating, could cause
> spurious interrupt.
>=20
> Signed-off-by: Milo Spadacini <milo.spadacini@gmail.com>
> ---
>  drivers/mfd/rk808.c | 39 +++++++++++++++++++++++++++------------

This will not apply to for-mfd-next, since the file has been renamed
to rk8xx-core.c in my patchset adding rk806/spi support.

Greetings,

-- Sebastian

--nbwy45zghn6666mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRv9oMACgkQ2O7X88g7
+po2qg//bDED4zrnREwdImHOlhboonEKRrrBCkRwOsISToq+lwXai2TC7JGZCseU
Le7IpJNssGuZ0TC8bUblZc+5JUv9JKzFORjeIdUAWnHGMcTC0TtS6rR2toiE11Yu
+vnAht13ybz3ljIm5ysiclGdbZbe0mRTrCgRwthrC+q7aqDObXEwDuzcUlnLkATV
ambH5yWQcA8yTGQ1tP+hPeYE6QN9c7S3cPJUgVpI0dME5P4jLq84ycqhU8eH646D
QsoKWSOCoAjOslLVwss7tzuZYmwG36cAgYR6i69hlRUQbY6/TlhIeN45cnTs+EQ/
ucyRpRR3QVm7YAptFSfoWe0XUCh/f00YnpClmPbYmgyYvhE3BQE4W/3sS1RLST9x
FBGPEwe6YkjAoS+tsR+VtZBD3CjZkAwY5giwS2Fs0KXxqDqKGLq21Yn0hi9wRERb
y0aoHpW80H9uVO/WwxfIKKmTE1MobEXYSjYypc8VhvHpsRB68fjhNEg/FDm/fTsT
tiPfL3dYdHikRQlb8hQFENgLGoyUeR9rjHORJMpXw1YXM4xnYh8aa/lrwYcKR8ZD
/BSqIhuk5Af8vo+WIWKlrEAjkptp3laqY46vHGAzkrtXQOnWc+jS8ACuV9kuTYcp
WKKvWbzRBVU8JpmzGDjMIhXzQCJG1XAUf1Cxh9etNNcAm+7Cjo8=
=uJKS
-----END PGP SIGNATURE-----

--nbwy45zghn6666mw--
