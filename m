Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527B6E0C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjDMLR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjDMLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:17:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E5976C;
        Thu, 13 Apr 2023 04:16:43 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 162711C0AB3; Thu, 13 Apr 2023 13:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681384602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdTWHyetr0OruvmdqJ++oajTpTuDkNAAKK6sM/EDzsY=;
        b=nH+PRzcV9M4DIdyRbyw+weoev7JBd5GNtIFRGRyrKZ6MI3SZKUFBR0rggx27hbZ6kWjKn2
        vqc0OpsnSz8bCrSXvFBQyoVoLoY/9viw4RtwxuSZZ9N05M97509RjTCujgxqHSi+poUooh
        GU7KvdXtKgLuMiJQ33d1ABd0Tq1M90g=
Date:   Thu, 13 Apr 2023 13:16:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED driver
Message-ID: <ZDfkmbEh9xjtNGM/@duo.ucw.cz>
References: <20230413110307.310944-1-andreas@kemnade.info>
 <20230413110307.310944-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="heVF3nF5KL5x7bb5"
Content-Disposition: inline
In-Reply-To: <20230413110307.310944-2-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--heVF3nF5KL5x7bb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Document ROHM BD2606MVV LED driver devicetree bindings.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/leds/rohm,bd2606mvv.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b=
/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> new file mode 100644
> index 0000000000000..e4327d4cdefa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD2606MVV LED controller
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description:
> +  The BD2606 MVV is a programmable LED controller connected via I2C that=
 can
> +  drive 6 separate lines. Each of them can be individually switched on a=
nd off
> +  but the brightness setting is shared between two of them.

"off,"?

"between pairs"?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--heVF3nF5KL5x7bb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfkmQAKCRAw5/Bqldv6
8v3FAJ9gfV5gPhN0d63zw2HYJ/2fDv4J5gCfQpzLrkH/oyiYFF0w1lavEjwfGuc=
=2Kb0
-----END PGP SIGNATURE-----

--heVF3nF5KL5x7bb5--
