Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD73F74F7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGKSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGKSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A39170A;
        Tue, 11 Jul 2023 11:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A917615B8;
        Tue, 11 Jul 2023 18:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD92DC433C7;
        Tue, 11 Jul 2023 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098981;
        bh=+mRQnnvwI4SKREDWdwihTC8LToebwOozVYnFhR8we8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR+CLGC2mBuk1ME5FLTSieByI5+XU4XE7zQBUE2MzOeTdPlzR9H+EkIs/NST0rH8/
         vqb9qHOj+StFwxH63sE4bhPvpk8Ba8eR6x0xBuZyJSqZYUHZoilSH22sRX/F3k6Sc+
         A/HtZojNZXY8JmCh+q+1rUqaNOan/MamOTBxu45zU87LLxtn77SZGFQwPhaHh9p+bC
         DoueZd7+CxE7pjd3mna9ZnwUDni8HB2TPeOYsmQmbptr+FhdEqWnxr8nAgS7bE6Imq
         RhSe4buFUX64+QaHgQmbZa7Yy6CTjZhppsBw4k7ANlJj/yROpNgamx2WlrWJ2MPV8S
         KdGMLYNlV8cOg==
Date:   Tue, 11 Jul 2023 19:09:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM8250 bwmon instances
Message-ID: <20230711-bodacious-royal-1852a5716807@spud>
References: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
 <20230711-topic-sm638250_bwmon-v1-1-bd4bb96b0673@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MlZ2u2W+u/pn47Cp"
Content-Disposition: inline
In-Reply-To: <20230711-topic-sm638250_bwmon-v1-1-bd4bb96b0673@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MlZ2u2W+u/pn47Cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 04:35:13PM +0200, Konrad Dybcio wrote:
> SM8250 has a BWMONv5 for LLCC and a BWMONv4 for CPU. Document them.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml |=
 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-=
bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bw=
mon.yaml
> index b63db9098345..51ba6490c951 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.y=
aml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.y=
aml
> @@ -29,12 +29,14 @@ properties:
>                - qcom,sc7280-cpu-bwmon
>                - qcom,sc8280xp-cpu-bwmon
>                - qcom,sdm845-cpu-bwmon
> +              - qcom,sm8250-cpu-bwmon
>                - qcom,sm8550-cpu-bwmon
>            - const: qcom,sdm845-bwmon    # BWMON v4, unified register spa=
ce
>        - items:
>            - enum:
>                - qcom,sc7180-llcc-bwmon
>                - qcom,sc8280xp-llcc-bwmon
> +              - qcom,sm8250-llcc-bwmon
>                - qcom,sm8550-llcc-bwmon
>            - const: qcom,sc7280-llcc-bwmon
>        - const: qcom,sc7280-llcc-bwmon   # BWMON v5
>=20
> --=20
> 2.41.0
>=20

--MlZ2u2W+u/pn47Cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2a4AAKCRB4tDGHoIJi
0uooAQDkQ4XIxsH2sVPIdg6Jd5+l39IkarR5xswL9VWJ9I8QkQEA0wr5w9nYuCX4
U4aXmgwnvmX/CmapUpiqUhfr07E0UgU=
=rwut
-----END PGP SIGNATURE-----

--MlZ2u2W+u/pn47Cp--
