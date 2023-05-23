Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEC70E25D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjEWQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjEWQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF81B0;
        Tue, 23 May 2023 09:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6871862516;
        Tue, 23 May 2023 16:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42567C433D2;
        Tue, 23 May 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860309;
        bh=NRw1W4HpGmmYZbObtDbW+NMxBV30GJdRhczbOMk8wOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgpEuzr+NUiFb27m5x6bpjWbczifNkqngA4Nw34LOAcIysxhuR52LXvN+ITo/XPnk
         LOIUALNQQZWvCBaN6SzTfzpPCtyzGS7yW+bSKs7XpmpLF+w3mVDRkiqlOtXyqscfOd
         rExI2TPEIWlVfUluEZGmQZiIBVS74RT1h+gIcMQ8zd3bjsJMKN9vgpDvwT71HPBNVw
         SJD8bc7ar61xsc7hMk851ytSe1abd/bCKCkToquDxQiyn/ffjdQ4ihon/V7NHcOk9h
         QU7+cF4xasC8sE/sgiMhPJDonpLLZeWD8OsdOBE8gkIIL/yzLv995EcHblN1M2IkkH
         PeBw2+MZzukHQ==
Date:   Tue, 23 May 2023 17:45:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Accept power-domains for GPUCC
Message-ID: <20230523-refined-geography-02d04205eff2@spud>
References: <20230523010348.63043-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ak2IoA+0FDGjSn4D"
Content-Disposition: inline
In-Reply-To: <20230523010348.63043-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ak2IoA+0FDGjSn4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 06:03:48PM -0700, Bjorn Andersson wrote:
> In many designs the power-domains provided by the GPU clock controller
> are powered by some GFX rail, add power-domains as a valid property to
> allow this to be specified.
>=20
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Do=
cumentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 1e3dc9deded9..a00216b3b15a 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -50,6 +50,9 @@ properties:
>        - const: gcc_gpu_gpll0_clk_src
>        - const: gcc_gpu_gpll0_div_clk_src
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
> =20
> --=20
> 2.39.2
>=20

--Ak2IoA+0FDGjSn4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGztkAAKCRB4tDGHoIJi
0vZFAP9Nbk3mJ50i5zSvohUyvJimL3nOYmExbUAvJKt/hlf7tAEA14y6vgIlyuA2
YK+ioUXBp7lNBQcyBUuNl+cTA5iIfQw=
=XFd/
-----END PGP SIGNATURE-----

--Ak2IoA+0FDGjSn4D--
