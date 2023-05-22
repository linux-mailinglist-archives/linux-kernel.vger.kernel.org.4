Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B470C2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEVQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjEVQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:03:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C472B5;
        Mon, 22 May 2023 09:03:10 -0700 (PDT)
Received: from g550jk.localnet (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E765CCA85E;
        Mon, 22 May 2023 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684771388; bh=4XvRSDbvIXkjecwnvetjzUMpIEjFmhXNnmgXxrB2XEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jhKmMBzJsEHA9sPBkfTEnumYRRJGhqqFYVwqHZFgtw6qG4++XEnN9GYLv/eI5T5E3
         sG3OShwDk3UszwqkGs2MzBxz7Bh9JjXGBiTcbtbUxYxP2OFmqqqzyO8/QPzmU9JQX5
         9Z/F6H/Vnz7xSYBj/RxQ/NlWmN7eJbPEgBWITyv0=
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
Subject: Re: [PATCH v2 2/4] ARM: dts: qcom: msm8226: Add PMU node
Date:   Mon, 22 May 2023 18:03:07 +0200
Message-ID: <2679828.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <20230520121933.15533-3-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
 <20230520121933.15533-3-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 20. Mai 2023 14:19:31 CEST Matti Lehtim=E4ki wrote:
> Enable perf events on MSM8226 devices by adding the PMU node.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
> Changes in v2:
>   - Use constants instead of magic number
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi
> b/arch/arm/boot/dts/qcom-msm8226.dtsi index c373081bc21b..cb4b4a6d0447
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -46,6 +46,12 @@ scm {
>  		};
>  	};
>=20
> +	pmu {
> +		compatible =3D "arm,cortex-a7-pmu";
> +		interrupts =3D <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
> +					 IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;




