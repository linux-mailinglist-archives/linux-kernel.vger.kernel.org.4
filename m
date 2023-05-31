Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71971801E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjEaMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjEaMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D011F;
        Wed, 31 May 2023 05:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4C062DA0;
        Wed, 31 May 2023 12:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5349BC433D2;
        Wed, 31 May 2023 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685536947;
        bh=tZgE2oBQxYazjPO6CTUnPX79KVv4ZnyhW1uCkRKF24M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLqv3SEAFd//wuZRQJ+GZ0dMPxJWPnn5thnJpyoLbDfrRpXjyP2ovp8KlymRKwR9C
         tyc87kmIhAcVjYDUicmy0pWThiJws9KmimeN8j0/XdLZvv9KqP9kERgGuU0eQuB6Oh
         FZ0pcfDgO0QIvU1rwLpVAljbksp6f5IqyLcpwrf7QREdeoOoSKVqyO3FDFFUM4uEIr
         OksRIQk2owTJoW+5WtM0NcD1F3KdcyQifKgE+9BwOU1N6pu3GIzPqjvbZA4/iNBJaz
         2lzjHMv4Hht1nIWBQpJgZsq4dLLOeta9erG6J0pEmj1JHh3BYryJX9q7cL2wU75XLx
         UWt4XYGvuwfuw==
Date:   Wed, 31 May 2023 13:42:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, arnd@arndb.de, daniel.lezcano@linaro.org,
        neil.armstrong@linaro.org, f.fainelli@gmail.com,
        christophe.kerello@foss.st.com, liang.yang@amlogic.com,
        jdelvare@suse.de, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20230531-unfrosted-refried-bc4c953c4d70@spud>
References: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
 <20230531025847.1284862-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j0OUzNSQ82kM+G9g"
Content-Disposition: inline
In-Reply-To: <20230531025847.1284862-2-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j0OUzNSQ82kM+G9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 02:58:46PM +1200, Chris Packham wrote:
> Add binding for AC5 SoC.

Ideally the comment about how it has only 3 of something-I-forget
would go here too, explaining why you cannot use a fallback compatible.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/mtd/marvell,nand-controller.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> index 80ce854291cb..c09efd7a0043 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -18,6 +18,7 @@ properties:
>        - enum:
>            - marvell,armada370-nand-controller
>            - marvell,pxa3xx-nand-controller
> +          - marvell,ac5-nand-controller

IFF you end up respinning for another reason, I think alphanumerical order
would be preferable. Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

I figure this depends on the conversion, so alphanumerical order would
be good to have there from the beginning of the yaml binding's existence
if it isn't already.

Cheers,
Conor.

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.40.1
>=20

--j0OUzNSQ82kM+G9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHdArQAKCRB4tDGHoIJi
0gplAQCARBMi47SOwGp3JREhXmhkrMkwX3WMqE+KsYJqMneinAD/RIO4K86MUN3S
eBdxFm4J9aroXH4OMOP2k//ai0voMgw=
=xh3l
-----END PGP SIGNATURE-----

--j0OUzNSQ82kM+G9g--
