Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB070C476
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEVRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEVRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:39:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F9DB;
        Mon, 22 May 2023 10:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7825362334;
        Mon, 22 May 2023 17:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D108AC433D2;
        Mon, 22 May 2023 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684777176;
        bh=Kk6mby5P1tf8oTeyObXljroIwmNVqfqbu+Q9j5a2xb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnRSE3VBaPYHZ+XI5MyAO5m9rXr+zZ/6NY6dwsgM76rLJ5C/HIcZqIeZ8FgzOKCkN
         m6782JCKSHNmvo21eUQhoCKVLQ4V2NBOHfQBaWVcfd4VsprgyNT1vibL3uCihCaAZ7
         0s+jkXSsSMaW7JHi6m0XiLFfYgJptF3L7RtwtxFJ3MHsokArrotEAT4uuTESKU/sN0
         BjubL2KsMix0q2UXFaAEs9t81WGmHBFr70UOVtkQFyJ3+Z/0lL3CNJUT+B+3HQQwc9
         qdBgK4ZLNwcn4CGj2JWmc5BOq7QYOl5/SuCTr4FgVKG1sWnyXHuZfNV39hUNusdHfI
         shOsr/rj3UNVg==
Date:   Mon, 22 May 2023 18:39:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: qcom-lpg: document PM8550 compatible
Message-ID: <20230522-childhood-eastbound-06a5f02f1f4a@spud>
References: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1qfQUUVRK2UvHwkM"
Content-Disposition: inline
In-Reply-To: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1qfQUUVRK2UvHwkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 06:26:01PM +0200, Neil Armstrong wrote:
> The PM8550 PWM modules are compatible with the PM8350c PWM modules,
> document the PM8350c PWM compatible as fallback for the PM8550 PWM.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I suppose you picked "items/enum", rather than "items/const" to reduce
future churn?
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 30 +++++++++++++---=
------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/=
Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> index 6295c91f43e8..fa378ee05c16 100644
> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -16,18 +16,24 @@ description: >
> =20
>  properties:
>    compatible:
> -    enum:
> -      - qcom,pm660l-lpg
> -      - qcom,pm8150b-lpg
> -      - qcom,pm8150l-lpg
> -      - qcom,pm8350c-pwm
> -      - qcom,pm8916-pwm
> -      - qcom,pm8941-lpg
> -      - qcom,pm8994-lpg
> -      - qcom,pmc8180c-lpg
> -      - qcom,pmi8994-lpg
> -      - qcom,pmi8998-lpg
> -      - qcom,pmk8550-pwm
> +    oneOf:
> +      - enum:
> +          - qcom,pm660l-lpg
> +          - qcom,pm8150b-lpg
> +          - qcom,pm8150l-lpg
> +          - qcom,pm8350c-pwm
> +          - qcom,pm8916-pwm
> +          - qcom,pm8941-lpg
> +          - qcom,pm8994-lpg
> +          - qcom,pmc8180c-lpg
> +          - qcom,pmi8994-lpg
> +          - qcom,pmi8998-lpg
> +          - qcom,pmk8550-pwm
> +      - items:
> +          - enum:
> +              - qcom,pm8550-pwm
> +          - const: qcom,pm8350c-pwm
> +
> =20
>    "#pwm-cells":
>      const: 2
>=20
> ---
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> change-id: 20230522-topic-sm8550-upstream-pm8550-lpg-5bf409842c3d
>=20
> Best regards,
> --=20
> Neil Armstrong <neil.armstrong@linaro.org>
>=20

--1qfQUUVRK2UvHwkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGuo1AAKCRB4tDGHoIJi
0p6EAQDTIZTlFFa55WeO6xB3Ese2p9pWCG0HVK0S/9lsyT/vQgEAqmnB1lZVPXFo
H7E/qCropV1xS+Vq+mRyzXy6AflNGA0=
=QH2B
-----END PGP SIGNATURE-----

--1qfQUUVRK2UvHwkM--
