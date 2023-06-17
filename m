Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94317343CA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjFQUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFQUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603EA1717;
        Sat, 17 Jun 2023 13:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0CDE6130D;
        Sat, 17 Jun 2023 20:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70350C433C8;
        Sat, 17 Jun 2023 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034532;
        bh=WX/ny3bQSc/mSYEm1J1YzU7+UYxZ9RPhpjwAi58MXH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXVs55UrLapO907ehdg+amsoikUNM51FImBIRMT57u8WClBi6VnI4k3LFIt0docBw
         xpmioIJbuGM5NBuzEsBmwTMD6Hmhi+dA8huMnn8vOgvhvMmO3PyM9WLAswHnCa5wQt
         8ZqWWTckq1H5tkpqi8AiIRie83a7I/B6fYHEsf+9qWb1wfRr2iCixGziOaNJqto8H7
         uf20rsugiFsAqBSBtsVur79sSxQwKpm6PcCGTNzL2W1hNIPIgVrR5L1E+XjpyWydks
         qxfuOWcF3IxLQQBoyJz6IN2oFBoXkC5eo0TGOPHD08xszk4eMBGDed3K7YXUouK9jR
         YnVTx8dSUtovQ==
Date:   Sat, 17 Jun 2023 21:42:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sdx65-tlmm: add pcie_clkreq
 function
Message-ID: <20230617-untimed-huskiness-fd212e6dca96@spud>
References: <20230617111809.129232-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="itG2DWeY27fGdIw0"
Content-Disposition: inline
In-Reply-To: <20230617111809.129232-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itG2DWeY27fGdIw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2023 at 01:18:09PM +0200, Krzysztof Kozlowski wrote:
> DTS and driver already support pcie_clkreq function for a pin.  Add it
> to fix dtbs_check warning:
>=20
>   qcom-sdx65-mtp.dtb: pinctrl@f100000: pcie-ep-clkreq-default-state: 'one=
Of' conditional failed, one must be fixed:
>     'bias-disable', 'drive-strength', 'function', 'pins' do not match any=
 of the regexes: '-pins$', 'pinctrl-[0-9]+'
>     'pcie_clkreq' is not one of ['blsp_uart1', 'blsp_spi1', ... 'gpio']
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.ya=
ml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> index 2ef793ae4038..27319782d94b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> @@ -85,7 +85,7 @@ $defs:
>                  qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib=
14,
>                  dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
>                  dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
> -                dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
> +                dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,=
 pcie_clkreq,
>                  dac_calib22, dac_calib23, dac_calib24, tsif1_sync, dac_c=
alib25,
>                  sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
>                  qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, b=
lsp_i2c3,
> --=20
> 2.34.1
>=20

--itG2DWeY27fGdIw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI4angAKCRB4tDGHoIJi
0g1gAQDv2kVJcPxiEhVhKgwUNwWJ7WdK+ExNYXrzNZTq/SemVgEAhdmDEE8h1h26
TEL4XR+3KBwp/wYgJO0Ah1FoMCqT4g0=
=UpIb
-----END PGP SIGNATURE-----

--itG2DWeY27fGdIw0--
