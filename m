Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919676CC3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjC1O5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjC1O5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:57:46 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F0E060
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:57:45 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1680015463; x=1680274663;
        bh=8VYClvItDD5z4B2IZDetMy87zHl4JJwRVsi0b1MCWg4=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eao+F0VqQ4+vZO+XM0/+cXlZmkIj2LPG3t23KlyemYnb00QIv6Ixpn+AC1vguHrr+
         fs99bpLxcTdGLY8vqMtT5zkbVcXcj4XkP/rwUFqpBtCnoMYWU/C/Bo9fh3dgpzTsOz
         Q9KP+qA+dR2W2hbjdnb+L0FVK+Wt7nJP+JN2F3J8=
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sdm845-oneplus: drop invalid panel properties
Message-ID: <f5521c4c-01d7-7783-bdfd-dadf88396fd6@connolly.tech>
In-Reply-To: <20230326155753.92007-9-krzysztof.kozlowski@linaro.org>
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org> <20230326155753.92007-9-krzysztof.kozlowski@linaro.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/03/2023 16:57, Krzysztof Kozlowski wrote:
> Panel does not have children with unit-addresses thus address/size-cells
> are not valid:
>
>   panel@0: '#address-cells', '#size-cells' do not match any of the regexe=
s: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/a=
rm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index b01542d79ae2..0c268c560d37 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -347,8 +347,6 @@ &dsi0 {
>  =09display_panel: panel@0 {
>  =09=09status =3D "disabled";
>
> -=09=09#address-cells =3D <1>;
> -=09=09#size-cells =3D <0>;
>  =09=09reg =3D <0>;
>
>  =09=09vddio-supply =3D <&vreg_l14a_1p88>;
> --
> 2.34.1
>

--
Kind Regards,
Caleb

