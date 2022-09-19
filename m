Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC475BCAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiISL0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiISL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:26:32 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50021E05;
        Mon, 19 Sep 2022 04:26:28 -0700 (PDT)
Date:   Mon, 19 Sep 2022 11:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1663586786; x=1663845986;
        bh=eOgNDfmPv3h8B96QcI6TtkCsFh4Fl5COX7PIDQpkG8Q=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=KfVoouthMHpiY5r4Ep5JyLnfk4F0ErkQ7vsQug1tTWFBBwXwc/lmnJEV4BYX3jecX
         B5eiYC7LQ8r1UPYgoW4gWzGANCXcZ5OyOzQy0XZNiZYMEkrFL61cpVzpty8isA/nbS
         yhbHb29vxQBx4I0tul+Zq7K+IpLnRKCkEEk2OuqY=
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
Message-ID: <f9ac56fe-0135-bf08-b7f3-5d3cd6d8c57b@connolly.tech>
In-Reply-To: <20220909035447.36674-4-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com> <20220909035447.36674-4-joelselvaraj.oss@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2022 04:54, Joel Selvaraj wrote:
> Introduce support for the Xiaomi Poco F1 EBBG variant. The EBBG variant
> uses EBBG FT8719 panel manufactured by EBBG.
>
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>

Kind Regards,
Caleb
> ---
>   arch/arm64/boot/dts/qcom/Makefile                 |  1 +
>   .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 15 +++++++++++++++
>   2 files changed, 16 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebb=
g.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom=
/Makefile
> index d0bba59d2a8c..a5045bd120c1 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-oneplus-fajita.=
dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-akari.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-akatsuki.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-apollo.dtb
> +dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-beryllium-ebbg.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-beryllium-tianma.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-polaris.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-shift-axolotl.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/=
arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> new file mode 100644
> index 000000000000..76931ebad065
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "sdm845-xiaomi-beryllium-common.dtsi"
> +
> +/ {
> +=09model =3D "Xiaomi Pocophone F1 (EBBG)";
> +=09compatible =3D "xiaomi,beryllium-ebbg", "qcom,sdm845";
> +};
> +
> +&display_panel {
> +=09compatible =3D "ebbg,ft8719";
> +=09status =3D "okay";
> +};
> --
> 2.37.3
>

