Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9DE70E386
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbjEWRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbjEWRCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49390;
        Tue, 23 May 2023 10:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4D0C634CB;
        Tue, 23 May 2023 17:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D70C433EF;
        Tue, 23 May 2023 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861357;
        bh=bqtg2gzZ7yBsVvMiiXA1gNJFMTN6BSdFaSLeeq2qr8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkpoetokkQsg+j8zbENYRW3D/eapwSURz3+12Nlh0Y+0ULUKRA8mbBMoX/3q/cy5I
         pZkLkfhPs3w3CRXs1McibPqt480fhRYOxOgUBycsEB9EQZ1q1+XtXfCWn1ewgKIYH0
         Y2D1EYO57h6UPfuCmcJBkbVc8hEzQJPOlO1ktePDHN16UHyS+yQgDK+RxVG4drVlEJ
         x2/YhgmlpYCdPLGyrq46eVuXYSkQxBxjqQd68s5FRdIO9EBZj57eaOiIaGyQj+uQzM
         s/Mxrglcp9RAb7AOsTL/xDyScqTrbk9JiXWIlSAaspUCBJA8oUDeJ8sCGabqF+NznS
         dGcPz5IqA7rEA==
Date:   Tue, 23 May 2023 18:02:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     p.paillet@foss.st.com
Cc:     lee@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: add vref_ddr supply for STPMIC1
Message-ID: <20230523-popular-chastise-67184785bae4@spud>
References: <20230523074206.201962-1-p.paillet@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UbRlB+0udV4GUR2J"
Content-Disposition: inline
In-Reply-To: <20230523074206.201962-1-p.paillet@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UbRlB+0udV4GUR2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 09:42:06AM +0200, p.paillet@foss.st.com wrote:
> From: Pascal Paillet <p.paillet@foss.st.com>
>=20
> Add vref_ddr supply description for the STPMIC1.
>=20
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Docu=
mentation/devicetree/bindings/mfd/st,stpmic1.yaml
> index 9573e4af949e..97c61097f9e2 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> @@ -184,7 +184,7 @@ properties:
>          additionalProperties: false
> =20
>      patternProperties:
> -      "^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$":
> +      "^(buck[1-4]|ldo[1-6]|vref_ddr|boost|pwr_sw[1-2])-supply$":
>          description: STPMIC1 voltage regulators supplies
> =20
>        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
> --=20
> 2.25.1
>=20

--UbRlB+0udV4GUR2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzxqQAKCRB4tDGHoIJi
0nVwAP9HoYA6RsRFC5ZRa8pRYOFuGxOZoqpu4qiPLakmq++azAEA3ezO6nGHTrLH
Kh6X9fVxXJ/zLYUM7NWAWNQbmWl+Twc=
=7sMn
-----END PGP SIGNATURE-----

--UbRlB+0udV4GUR2J--
