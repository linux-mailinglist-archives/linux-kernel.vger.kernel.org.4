Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4360714F59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE2SW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2SWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B209C4;
        Mon, 29 May 2023 11:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E19E61B00;
        Mon, 29 May 2023 18:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8170DC433D2;
        Mon, 29 May 2023 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685384542;
        bh=oCMX/Geu63rceF98CJ4hQyNEh8roIyS9yo/tz8IHJuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilh+jWqCoBaVa6PXTgaflF1MN1eQX6Ro1ekApfU2/9nYgdf0ImtiEGMHPkee4JDcz
         jsBHaLxgISpJFp010BZFPG+5zJjsjjf7phcPMrP79szhjgxiLoNTSMT3RQ4km6iCcz
         mEYUEtKZatnlgOMOMlEasG2QxbNDAwuaW91x/Kl57ooXbG0RNobfEpoVq/jrAHWmDr
         NcsxWz45vF0fpYXCL1EJ0Ah89NtOIqktL5mxXv3HF16Ezqx81yTu/Ywzx9fxCfdPQ2
         DT5n0iT17ldfHlRBF1QrclTHBmetTLu1NQ89Kwu2mrzFkj03tT+K4kQjS0HBNoy4AU
         f9o0ktwOhwmKw==
Date:   Mon, 29 May 2023 19:22:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: msm: dsi-phy-28nm: Document msm8226
 compatible
Message-ID: <20230529-encircle-cherub-374102ca43d4@spud>
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-1-679f335d3d5b@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UyjEm4CeDHfnthCw"
Content-Disposition: inline
In-Reply-To: <20230308-msm8226-mdp-v1-1-679f335d3d5b@z3ntu.xyz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UyjEm4CeDHfnthCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 11:43:58AM +0200, Luca Weiss wrote:
> The MSM8226 SoC uses a slightly different 28nm dsi phy. Add a new
> compatible for it.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml | 1 +
>  Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml    | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.y=
aml b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> index cf4a338c4661..bd70c3873ca9 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> @@ -18,6 +18,7 @@ properties:
>        - qcom,dsi-phy-28nm-hpm
>        - qcom,dsi-phy-28nm-hpm-fam-b
>        - qcom,dsi-phy-28nm-lp
> +      - qcom,dsi-phy-28nm-8226

How come the order is different in both places?

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>        - qcom,dsi-phy-28nm-8960
> =20
>    reg:
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml=
 b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> index b0100105e428..db9f07c6142d 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
> @@ -125,6 +125,7 @@ patternProperties:
>            - qcom,dsi-phy-14nm-660
>            - qcom,dsi-phy-14nm-8953
>            - qcom,dsi-phy-20nm
> +          - qcom,dsi-phy-28nm-8226
>            - qcom,dsi-phy-28nm-hpm
>            - qcom,dsi-phy-28nm-lp
>            - qcom,hdmi-phy-8084
>=20
> --=20
> 2.40.1
>=20

--UyjEm4CeDHfnthCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHTtVwAKCRB4tDGHoIJi
0nvKAQDbhG5jqoLQjbATFU8ogWNuoWFeY5pQPfj1a1MKxd++VAD/fQ/wznbK/2Ma
4WV5Mn40WKJywRLn/w7MU15yVh9TGgk=
=M/da
-----END PGP SIGNATURE-----

--UyjEm4CeDHfnthCw--
