Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940AE73E65C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC98891;
        Mon, 26 Jun 2023 10:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5260560F0E;
        Mon, 26 Jun 2023 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BDC433C0;
        Mon, 26 Jun 2023 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800241;
        bh=J5IE0ZFd89PlUjMsyC5ZSSfbrAt4OkK3g5ZAb+NJ6cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+67EIwv9mAa2V7iEVLKwGUPMnb38s1xTCeeadi1GdFveWAGuua0K6aWOGajDM8As
         q+7TiNF4Hm5Yb+tgqpOXIzT8YDjIQiXMNi3fFmHg90gTplcy6mLes2qSQOp7exnhe1
         KIapOq4nn+uMK38lXA/4aszTTNZmJTukNnDNVaydmE3kVw8vWOnTfvnKX3/sy7dkrq
         G6JzqULi8qz6kgPd5gNIbxlMm3n1yLeXckEUR4Yxc7TXhbbUBJayXJZ6u9mpa2kG4U
         /5QvQLmoeIAfS2CJIxFPWVnamCFxgPwbLeevfpASqhXXy3jjIbF+kxeEjHnflzTpBR
         O4Wb5GrpJTfhg==
Date:   Mon, 26 Jun 2023 18:23:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, michael@walle.cc,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitrkcian2002@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
Message-ID: <20230626-stonework-freely-bec6f8bc83e6@spud>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjgSjtDERNYXQ8hA"
Content-Disposition: inline
In-Reply-To: <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjgSjtDERNYXQ8hA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 03:32:50PM +0530, Amit Kumar Mahapatra wrote:
> If the WP# signal of the flash device is either not connected or is wrong=
ly
> tied to GND (that includes internal pull-downs), and the software sets the
> status register write disable (SRWD) bit in the status register then the
> status register permanently becomes read-only. To avoid this added a new
> boolean DT property "no-wp". If this property is set in the DT then the
> software avoids setting the SRWD during status register write operation.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> As the DT property name has changed so, removed Reviewed-by tag.
> @Cornor if possible, could you please review this updated patch.

Rob was the one who objected to the property name.
Old & new names are fine by me, it was the text I think I cared about.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for actually explaining why you dropped the tag,
Conor.

> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/D=
ocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 89959e5c47ba..97344969b02d 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,21 @@ properties:
>        be used on such systems, to denote the absence of a reliable reset
>        mechanism.
> =20
> +  no-wp:
> +    type: boolean
> +    description:
> +      The status register write disable (SRWD) bit in status register, c=
ombined
> +      with the WP# signal, provides hardware data protection for the dev=
ice. When
> +      the SRWD bit is set to 1, and the WP# signal is either driven LOW =
or hard
> +      strapped to LOW, the status register nonvolatile bits become read-=
only and
> +      the WRITE STATUS REGISTER operation will not execute. The only way=
 to exit
> +      this hardware-protected mode is to drive WP# HIGH. If the WP# sign=
al of the
> +      flash device is not connected or is wrongly tied to GND (that incl=
udes internal
> +      pull-downs) then status register permanently becomes read-only as =
the SRWD bit
> +      cannot be reset. This boolean flag can be used on such systems to =
avoid setting
> +      the SRWD bit while writing the status register. WP# signal hard st=
rapped to GND
> +      can be a valid use case.
> +
>    reset-gpios:
>      description:
>        A GPIO line connected to the RESET (active low) signal of the devi=
ce.
> --=20
> 2.17.1
>=20

--qjgSjtDERNYXQ8hA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJnJrAAKCRB4tDGHoIJi
0ntuAQDVpae9PflF2Bc8e7EAKMWs4/x2R2zXS1I6cmwqsdqWJwD/SL5M96LQ13GW
oDRx25XRP1+G6pAwWLHTEwIoub+Q9gc=
=EFCF
-----END PGP SIGNATURE-----

--qjgSjtDERNYXQ8hA--
