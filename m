Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D074F7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3910D2;
        Tue, 11 Jul 2023 11:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC9E615B7;
        Tue, 11 Jul 2023 18:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DAEC433C8;
        Tue, 11 Jul 2023 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098959;
        bh=lxqKz1fXilmbmExU5zZS6bRZAzz+KDaE3lki+iQDT04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRzHUvso7igjJ85rG5JnTVXKoWxeK6ia3uk/4VKeURbmokAEfS/G9Ij4JpSvUUigl
         mIjjkQhRVO3TFqmDQB93wr1Ud7j/USyGKLdt7zMcWY37deDSD6g9Kp2r2gJ+OdG8YV
         qcnzn5Pw1TfpLgdL1xg1eo0JuT8Gq79EkmCowzdwfDpswYxCVL52z3fL9y8t9Haacq
         vhozEjrWqS0sKaSn8w9dbVQ90EnRAy2SVtSrku678YVJSSfCHaaWODVaAHStqp74P9
         JuQnNuGk6zKRPC/SNJLWlSF3sSufpUe1JeHlC8R4rW2xN95iWdiM4hvuFser/vk2od
         lVkQobz+HUvBQ==
Date:   Tue, 11 Jul 2023 19:09:14 +0100
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
Subject: Re: [PATCH 2/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM6350 bwmon instances
Message-ID: <20230711-happiest-unworldly-15ed297b668d@spud>
References: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
 <20230711-topic-sm638250_bwmon-v1-2-bd4bb96b0673@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bUr6myj+mW8Jbc5x"
Content-Disposition: inline
In-Reply-To: <20230711-topic-sm638250_bwmon-v1-2-bd4bb96b0673@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bUr6myj+mW8Jbc5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 04:35:14PM +0200, Konrad Dybcio wrote:
> SM6350 has a BWMONv4 for LLCC and a BWMONv5 for CPU. Document them.
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
> index 51ba6490c951..73f809cdb783 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.y=
aml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.y=
aml
> @@ -29,6 +29,7 @@ properties:
>                - qcom,sc7280-cpu-bwmon
>                - qcom,sc8280xp-cpu-bwmon
>                - qcom,sdm845-cpu-bwmon
> +              - qcom,sm6350-llcc-bwmon
>                - qcom,sm8250-cpu-bwmon
>                - qcom,sm8550-cpu-bwmon
>            - const: qcom,sdm845-bwmon    # BWMON v4, unified register spa=
ce
> @@ -36,6 +37,7 @@ properties:
>            - enum:
>                - qcom,sc7180-llcc-bwmon
>                - qcom,sc8280xp-llcc-bwmon
> +              - qcom,sm6350-cpu-bwmon
>                - qcom,sm8250-llcc-bwmon
>                - qcom,sm8550-llcc-bwmon
>            - const: qcom,sc7280-llcc-bwmon
>=20
> --=20
> 2.41.0
>=20

--bUr6myj+mW8Jbc5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2aygAKCRB4tDGHoIJi
0gXbAQC1U8xbWc2YXj6Lizngzmt9aqAMIpsEZeEr2Fd1zb5vIwD9H4L8PrT/tC5m
FaYfRdCrN7jpeAlDILxLRyT/1lBHTQM=
=GcWR
-----END PGP SIGNATURE-----

--bUr6myj+mW8Jbc5x--
