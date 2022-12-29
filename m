Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7685E658A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiL2ImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2ImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:42:05 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15911004D;
        Thu, 29 Dec 2022 00:42:04 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B7620CC38B;
        Thu, 29 Dec 2022 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672303323; bh=z74Wvw2dl/J6TN1vPrye61RN3quWMD3vkV0739va1Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ppugLIFkeEkZ3D4fy3r7n+6r6SIVDcfslAWLHs8RwdKwYzwjUFMkefDrC78v4nBbN
         D6pEU6RrZTh9eUHAJeqnUp2lpF0GtcmMsc/RKjyHXuqCJSVm8U1ICR5A+Wc2dEyxk6
         WGADAKl7S02wwi6laqsDQ8cc1Z0DwKAR+JbjkqJs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
Date:   Thu, 29 Dec 2022 09:42:02 +0100
Message-ID: <2660205.mvXUDI8C0e@g550jk>
In-Reply-To: <20221218211957.118473-1-matti.lehtimaki@gmail.com>
References: <20221218211957.118473-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Sonntag, 18. Dezember 2022 22:19:57 CET Matti Lehtim=E4ki wrote:
> Configure the reserved memory for ADSP and enable it.
> Delete nodes with reference to label.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
> Changes in v2:
>   - Delete nodes with reference to label
> ---
>  .../arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts index
> 1c52337af560..15b9590ba07b 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -9,6 +9,9 @@
>  #include "qcom-msm8226.dtsi"
>  #include "qcom-pm8226.dtsi"
>=20
> +/delete-node/ &adsp_region;
> +/delete-node/ &smem_region;
> +
>  / {
>  	model =3D "Samsung Galaxy Tab 4 10.1";
>  	compatible =3D "samsung,matisse-wifi", "qcom,apq8026";
> @@ -133,7 +136,7 @@ wcnss@d200000 {
>  			no-map;
>  		};
>=20
> -		adsp@d900000 {
> +		adsp_region: adsp@d900000 {
>  			reg =3D <0x0d900000 0x1800000>;
>  			no-map;
>  		};
> @@ -143,7 +146,6 @@ venus@f100000 {
>  			no-map;
>  		};
>=20
> -		/delete-node/ smem@3000000;
>  		smem_region: smem@fa00000 {
>  			reg =3D <0x0fa00000 0x100000>;
>  			no-map;
> @@ -169,6 +171,10 @@ rmtfs@fd80000 {
>  	};
>  };
>=20
> +&adsp {
> +	status =3D "okay";
> +};
> +
>  &blsp1_i2c2 {
>  	status =3D "okay";




