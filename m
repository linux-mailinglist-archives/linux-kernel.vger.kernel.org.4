Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215670FE98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjEXTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEXTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772D12F;
        Wed, 24 May 2023 12:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A18B763F8F;
        Wed, 24 May 2023 19:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B33C433D2;
        Wed, 24 May 2023 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684956957;
        bh=q6oVak1JjPBBwBaJsThubhVCnJC0XZxrZ9mqD6xGVUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbkzHtxozaAhe2sT1GMu0aArsGyqDKQO/5EXJhu8jZosdmd5k0opznoZgC4oE38VV
         lxgCRcynslnoX7m+ui3+cVqmT4VD4sYoOAaSLoGZ2lnwgh72qEW7HKO+cy/bwIQXe9
         3XWU0fh4SGJqqaHANqhTj0ojcfUDT+E7pSJgzfIkCQVlJwaXs/gS+MBc0BZoSbmtEY
         VdFqghX1SqChpyM2A+KXj0CAqrDBoMjoZQ/oh3cK4uzRmF/l5/2dY9C5Hn+3HHfiz3
         xSgYFTH/ovOqVEebEMH6wtU6rb7Q2hYzGGRsu+fiuOLoeX2NF0OnpiWWX9ROJJ2Sgf
         HRVew3zsBDfjg==
Date:   Wed, 24 May 2023 20:35:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230524-salvaging-claim-221dbce412ba@spud>
References: <cover.1684920389.git.quic_varada@quicinc.com>
 <cb26ad4a6550c18b1a70104c6b75c10946766944.1684920389.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c6h9mX6sLJw8eQFn"
Content-Disposition: inline
In-Reply-To: <cb26ad4a6550c18b1a70104c6b75c10946766944.1684920389.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c6h9mX6sLJw8eQFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 03:06:09PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>=20
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsen=
s.
>=20
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v4]:
> 	Add description about IPQ9574 and remove unnecessary
> 	additions to the file
> [v3]:
> 	Fix dt_binding_check & dtbs_check errors (Used
> 	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> 	as reference/example)
>=20
> 	Drop 'Acked-by: Rob Herring' as suggested in review
>=20
> [v2]:
> 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 	for the tip to make qcom,ipq8074-tsens as fallback.

Thanks for re-sending. I'm going to "ignore" this patch & Krzysztof can
take a look at it next week.

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 11 +++++++++=
--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/=
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d1ec963..1a752e0 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -16,9 +16,14 @@ description: |
>    The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 ca=
ptures
>    everything before v1 when there was no versioning information.
> =20
> +  Since IPQ9574 is similar to IPQ8074, mapping it to IPQ8074 without
> +  introducing a new compatible.
> +
>  properties:
>    compatible:
>      oneOf:
> +      - const: qcom,ipq8074-tsens
> +
>        - description: msm8960 TSENS based
>          items:
>            - enum:
> @@ -64,8 +69,10 @@ properties:
>            - const: qcom,tsens-v2
> =20
>        - description: v2 of TSENS with combined interrupt
> -        enum:
> -          - qcom,ipq8074-tsens
> +        items:
> +          - enum:
> +              - qcom,ipq9574-tsens
> +          - const: qcom,ipq8074-tsens
> =20
>    reg:
>      items:
> --=20
> 2.7.4
>=20

--c6h9mX6sLJw8eQFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5nFwAKCRB4tDGHoIJi
0jeuAQD16dQoVqamS6B4gq0jASyRcA9aeUrOCZ3BmgiK+L2TswEAklEFt/dvgvNt
aRqoErbPSRhcRNA/TaezC2aOeCYLugs=
=A7CO
-----END PGP SIGNATURE-----

--c6h9mX6sLJw8eQFn--
