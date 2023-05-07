Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FB6F9B77
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjEGU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEGU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:27:10 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C035BF;
        Sun,  7 May 2023 13:27:07 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B1E79CEC2E;
        Sun,  7 May 2023 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683491225; bh=6XPFg6n/QATK/aTr9w55XEB4/N+ENG1ZYSPsFzf1AR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hr4dVbMoKvQupkRHTV+do/r7TUu9pPaB3j423XiOnGxJWinwTQo3tof3FqrBhtkDp
         TgLf7cDlLg3pFR3hlRatl7wQTWxIMz16tK2kNL5GVvIy38WLXQgjfMY+IWXtDDvfnz
         ADGP/3ipkZ6gr440zYKVrG5pR3k483x6icOSNr6o=
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
Subject: Re: [PATCH 4/6] ARM: dts: msm8226: Add qfprom node
Date:   Sun, 07 May 2023 22:27:05 +0200
Message-ID: <5160214.GXAFRqVoOG@z3ntu.xyz>
In-Reply-To: <20230507201225.89694-5-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-5-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 7. Mai 2023 22:12:22 CEST Matti Lehtim=E4ki wrote:
> Add missing QFPROM definition for MSM8226 SoC.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi
> b/arch/arm/boot/dts/qcom-msm8226.dtsi index c373081bc21b..c34b8f3139ae
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -505,6 +505,13 @@ restart@fc4ab000 {
>  			reg =3D <0xfc4ab000 0x4>;
>  		};
>=20
> +		qfprom: qfprom@fc4bc000 {
> +			compatible =3D "qcom,msm8226-qfprom",=20
"qcom,qfprom";
> +			reg =3D <0xfc4bc000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +		};
> +
>  		spmi_bus: spmi@fc4cf000 {
>  			compatible =3D "qcom,spmi-pmic-arb";
>  			reg-names =3D "core", "intr", "cnfg";




