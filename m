Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18A5BCAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiISLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiISLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:25:20 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1619C02;
        Mon, 19 Sep 2022 04:25:18 -0700 (PDT)
Date:   Mon, 19 Sep 2022 11:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1663586715; x=1663845915;
        bh=y9rKANHchjNpSN9Qq9D6AIPXx6ITqAMrHklDuvucp2w=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=RBJ+K+7rzjAsOk9Zz+PDE3BkfOK2eCcz0DGQk3cIdvN6b8xmAuHzVJVt1giEHc9Pe
         BmgZ9MRg8oDeV6hm9SjTh7+G1xTRJGHlwi8yfVnC1YO3MaNLua/A5QON1aF0TJiXZs
         BR8dLHD7vXpiO9+AdNXC434ZYNlZxv0IVE/DOKaM=
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
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
Message-ID: <a28bbb3c-68ca-9d3f-5eb3-837c4ec53e50@connolly.tech>
In-Reply-To: <20220909035447.36674-2-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com> <20220909035447.36674-2-joelselvaraj.oss@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2022 04:54, Joel Selvaraj wrote:
> There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
> The previous beryllium dts supported the Tianma variant. In order to
> add support for EBBG variant, the common nodes from beryllium dts are
> moved to a new common dtsi and to make the variants distinguishable,
> sdm845-xiaomi-beryllium.dts is now named as
> sdm845-xiaomi-beryllium-tianma.dts. The model property is updated to
> distinguish between the variants. The compatibility property is
> moved to the tianma variant, but it is not updated to avoid any
> further conflict with other projects/users that might depend on it.
>
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>

Kind regards,
Caleb
> ---
>   arch/arm64/boot/dts/qcom/Makefile                 |  2 +-
>   ...um.dts =3D> sdm845-xiaomi-beryllium-common.dtsi} | 11 +++++------
>   .../dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 15 +++++++++++++++
>   3 files changed, 21 insertions(+), 7 deletions(-)
>   rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts =3D> sdm84=
5-xiaomi-beryllium-common.dtsi} (98%)
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tia=
nma.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom=
/Makefile
> index 1d86a33de528..d0bba59d2a8c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -128,7 +128,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-oneplus-fajita.=
dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-akari.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-akatsuki.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-sony-xperia-tama-apollo.dtb
> -dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-beryllium.dtb
> +dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-beryllium-tianma.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-xiaomi-polaris.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-shift-axolotl.dtb
>   dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm850-lenovo-yoga-c630.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/=
arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> similarity index 98%
> rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 82c27f90d300..940ac9cd0aba 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -26,8 +26,6 @@
>   /delete-node/ &rmtfs_mem;
>
>   / {
> -=09model =3D "Xiaomi Pocophone F1";
> -=09compatible =3D "xiaomi,beryllium", "qcom,sdm845";
>   =09chassis-type =3D "handset";
>
>   =09/* required for bootloader to select correct board */
> @@ -221,8 +219,7 @@ &dsi0 {
>   =09status =3D "okay";
>   =09vdda-supply =3D <&vreg_l26a_1p2>;
>
> -=09panel@0 {
> -=09=09compatible =3D "tianma,fhd-video";
> +=09display_panel: panel@0 {
>   =09=09reg =3D <0>;
>   =09=09vddio-supply =3D <&vreg_l14a_1p8>;
>   =09=09vddpos-supply =3D <&lab>;
> @@ -234,8 +231,10 @@ panel@0 {
>   =09=09backlight =3D <&pmi8998_wled>;
>   =09=09reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;
>
> +=09=09status =3D "disabled";
> +
>   =09=09port {
> -=09=09=09tianma_nt36672a_in_0: endpoint {
> +=09=09=09panel_in_0: endpoint {
>   =09=09=09=09remote-endpoint =3D <&dsi0_out>;
>   =09=09=09};
>   =09=09};
> @@ -243,7 +242,7 @@ tianma_nt36672a_in_0: endpoint {
>   };
>
>   &dsi0_out {
> -=09remote-endpoint =3D <&tianma_nt36672a_in_0>;
> +=09remote-endpoint =3D <&panel_in_0>;
>   =09data-lanes =3D <0 1 2 3>;
>   };
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts =
b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> new file mode 100644
> index 000000000000..8e176111e599
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "sdm845-xiaomi-beryllium-common.dtsi"
> +
> +/ {
> +=09model =3D "Xiaomi Pocophone F1 (Tianma)";
> +=09compatible =3D "xiaomi,beryllium", "qcom,sdm845";
> +};
> +
> +&display_panel {
> +=09compatible =3D "tianma,fhd-video";
> +=09status =3D "okay";
> +};
> --
> 2.37.3
>

