Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87773A8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjFVTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFVTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29828210C;
        Thu, 22 Jun 2023 12:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A592C618D9;
        Thu, 22 Jun 2023 19:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF333C433C8;
        Thu, 22 Jun 2023 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687460754;
        bh=ys+KisNqnAg7Tah0SJFa7QXN8LXLO3X3kYZ3umnLK1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvsLOkjtKw9rv2BwGFtUphgK9rqJT3a3DQQlwtHRV5z73bJJfcQqE62DdWRwY/xU4
         hjo5Kn1eMjp12Nt5PcurYdDORqUDMoprylAYHgejB0l1A/JShQ7+xVffQrzjKaidmG
         eDoDiI9k3fQGHXi9wMqZyA6gbrWIuTnmVTVNCM/Zj/H4p7IxyUlIXoC5YtDTOirLWN
         RB0XcJWyxulmcQmgIfaLhXLaW7O+7R7cTqMkiDEid9YkXZyIupijaJAWxN1a8/0ruj
         1xVaVudGNhvsCr5gy7wNDZw3WIS0cDENJDeRC1nQBSzzLyF0UdgrP9HBNgXZNaSwMS
         Gx6xkIYwmOqhA==
Date:   Thu, 22 Jun 2023 20:05:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Praveen Talari <quic_ptalari@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI
 device mode support for GENI based QuPv3
Message-ID: <20230622-sustained-marauding-5c6c8a76c834@spud>
References: <20230622135955.941-1-quic_ptalari@quicinc.com>
 <20230622135955.941-3-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BpA4WeFicj+70oUn"
Content-Disposition: inline
In-Reply-To: <20230622135955.941-3-quic_ptalari@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BpA4WeFicj+70oUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 07:29:54PM +0530, Praveen Talari wrote:
> Add a property to configure QUPv3 SE as SPI Device mode.
>=20
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
> v2 -> v3:
> - modified commit message to use device mode instead of slave mode

Suitability or w/e of the property aside, I don't understand this.
Why not change the *property*, which has far more visibility than the
commit message, to use device rather than slave?

Chers,
Conor.

> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yam=
l b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> index 2e20ca313ec1..5c7d0293bbf7 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -66,6 +66,10 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  qcom,slv-ctrl:
> +    description: configure QUPv3 SE as Device mode
> +    type: boolean
> +
>  required:
>    - compatible
>    - clocks
> --=20
> 2.17.1
>=20

--BpA4WeFicj+70oUn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSbjAAKCRB4tDGHoIJi
0rQBAP9VpTT/MeUMABsfUwyLydR8mL17cNI3B76hNRLlyLp64AEAqfYCLzbG42gx
ytwOhlHoaVCMHkXXoV3Z855RkLCYXAU=
=n14M
-----END PGP SIGNATURE-----

--BpA4WeFicj+70oUn--
