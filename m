Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623DA703942
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjEORke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbjEORkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FD17971;
        Mon, 15 May 2023 10:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8581E62DD3;
        Mon, 15 May 2023 17:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D87C4339C;
        Mon, 15 May 2023 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684172226;
        bh=98fQRjRbIONriWHlH0jkdaXZtrfJPS0ULJrgh04jqRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGyw1bkpr9f7GqhykoFj+LHG6LjTaTEaVHjneXE6Tce9OHVKXZuSNB3GPMRY1deRX
         /QY0neJgSM8drcYk3Ryl7F4WHZlUs+wnV1uQXLLPPQCWBc76fdTOCXJipLPDPJmG9s
         2X+AgkuBuLQgc3Ad5DnlQZS8Bhf8sWxakUSHE8iv5NvzLHwQGgRrJuZQhEtuDq/8/y
         1AFd0gupvZh9LXPChv8hiEe9jVq5q/zOyMcWO8g5w52VdVBUk3ptLJsmzftZLUHPOo
         f4KY6BbkjO+CzcHKS2winJbvp7HYnXILJ9F8nIWZxG26+PVRwAFdz73tdXfXCESXDm
         8qQ4VTxZho5EQ==
Date:   Mon, 15 May 2023 18:36:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anusha Rao <quic_anusha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
Subject: Re: [PATCH V2 3/4] dt-bindings: qcom-qce: add SoC compatible string
 for ipq9574
Message-ID: <20230515-hull-contented-48626dc36eb7@spud>
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
 <20230515150722.12196-4-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1KmiYcElde803Ao3"
Content-Disposition: inline
In-Reply-To: <20230515150722.12196-4-quic_anusha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1KmiYcElde803Ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 08:37:21PM +0530, Anusha Rao wrote:
> Document the compatible string for ipq9574.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>  Changes in V2:
> 	- Added a new compatible for ipq9574 SoC.
>=20
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Doc=
umentation/devicetree/bindings/crypto/qcom-qce.yaml
> index e375bd981300..0d1deae06e2d 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -28,6 +28,7 @@ properties:
>            - enum:
>                - qcom,ipq6018-qce
>                - qcom,ipq8074-qce
> +              - qcom,ipq9574-qce
>                - qcom,msm8996-qce
>                - qcom,sdm845-qce
>            - const: qcom,ipq4019-qce
> --=20
> 2.17.1
>=20

--1KmiYcElde803Ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJtugAKCRB4tDGHoIJi
0lTsAP98vINl5qwa4mwXN5MAy30GSKbEzxqH9j57jfS+ZRaVyQEAkAHcT7+n5aaj
CSCU2+v6aAOTrxqZpWXlSzyJXNUAIwc=
=AVb7
-----END PGP SIGNATURE-----

--1KmiYcElde803Ao3--
