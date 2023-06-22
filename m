Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E279673A939
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFVTzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D93F1;
        Thu, 22 Jun 2023 12:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A13618DB;
        Thu, 22 Jun 2023 19:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD0C433C0;
        Thu, 22 Jun 2023 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687463748;
        bh=hFUatM9PSRU0Dtg23g2n8VgrlPwM86dU8bJ9w0p+FCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVNb0e2EKqjI5Qc332vgXziWEwH7cj78nZGHidT7flsGhZ2Pc3uG2tHz3SLHBH+i6
         RuuQuvNvxS/T1Z41sK5bHowla2XhehXYTtybi0w+V/em4hg7YKn7HLrXfBqD2it2Zo
         L85qzCl9mbs65Sa4XYLV1RQycOUZaQEEtBASRZfPKVIsIDSK4ub1qdX3aw9zN7tYhT
         XJD1gdLiHkUezRZpIpRZy2hxMbv6fveTmd+JKl0PcFoPE0dBSBxLtn+Kf+vTG3aYds
         LHiEdtmX8wV7ck3OTU2Ts8UC2FAMCeuiymrOY+L5b6770xGy+A/xh3CTXpqTPjaaFL
         /xbX7pzPi3ynQ==
Date:   Thu, 22 Jun 2023 20:55:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/2] dt-bindings: firmware: qcom,scm: Allow interconnect
 on SC8280XP
Message-ID: <20230622-santa-alias-6fb047a12794@spud>
References: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
 <20230622-topic-8280scmicc-v1-1-6ef318919ea5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y6lHOH+nZzJT02Is"
Content-Disposition: inline
In-Reply-To: <20230622-topic-8280scmicc-v1-1-6ef318919ea5@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6lHOH+nZzJT02Is
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 05:56:15PM +0200, Konrad Dybcio wrote:
> Just like all other Qualcomm SoCs, SC8280XP SCM should be fed an
> interconnect path. Do so.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/D=
ocumentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 09073e1d88ff..42d064be753b 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -174,6 +174,7 @@ allOf:
>              contains:
>                enum:
>                  - qcom,scm-qdu1000
> +                - qcom,scm-sc8280xp
>                  - qcom,scm-sm8450
>                  - qcom,scm-sm8550
>      then:
>=20
> --=20
> 2.41.0
>=20

--y6lHOH+nZzJT02Is
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSnPgAKCRB4tDGHoIJi
0jlIAP4h7eOJcII1qn4nFLfKSdk1p0Feg0+Vi4ccqrhZJwNKOAEAlGbcQW+dynEQ
ZQJj2xuB5X6bT7VckV39IkMvhdjUMwI=
=AnV9
-----END PGP SIGNATURE-----

--y6lHOH+nZzJT02Is--
