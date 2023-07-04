Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F87478F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjGDUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:24:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1BE76;
        Tue,  4 Jul 2023 13:24:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so463862a12.0;
        Tue, 04 Jul 2023 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688502288; x=1691094288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXcoyB2c2LmPovrfcZqFCh1F+dK1nMZObtAQzAlFgu0=;
        b=H7/P+BxaeP0N3C+tbkIDNCg32NLgroPE2sONbk5/kGI/NZH9BHeZfzSL6slAIOM8bf
         hjUiS0bmu0QS5bSKoMeh9nk2ACtJ4fvWXRO6hcYoDJt915cKMlHo8vkztzHy2rTOB8ZD
         u0cllXoxcq36G+VNI5RLx+SEIw6Kw5Deg3W9fUnV4o4gg8mdAMUlIORZFCMd4R2fVaFF
         aDPhMuc9X+Da7JuDKu4/nGF51le2Fbwkk89PGTJ3ZZetJ6EJGS7V8/se1Gwn5tFh9fc5
         DzpWgS2AwuaR7MMG+JxxVye2WcMN8h+Mn99FbxP+g+Dtz0r922k3OxeYn83PsUmp/IaU
         EAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688502288; x=1691094288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXcoyB2c2LmPovrfcZqFCh1F+dK1nMZObtAQzAlFgu0=;
        b=lMb4ST2fi42MBjt4xGXJYPaRVwroVfBvVhUmt7QhITV3P3iIxIO/DTUEw6ZSJjvT3I
         9vG0BgYAd9X+0wqGL3lE2/keqgNTKW6Bfwzt/+9vyxMpoBIfyM6a1CDBYnp5POFyVimh
         4cQDbEjHvi821FStTksnTEyx4KcClSIxP3XLKKzoYXCh6kF0r4uPlN+Ry/QtDhfzAHU8
         TmzQXSagRjbFaquB6tewzForgnCseB+XH8qkSugPChdYz/WlETNHyeLhvXiRaD5PAMmb
         lNMR9droPO/iEXlDCF9LlE9uz0GeIaqISy6Vu9ggtP7vxH35iYX3G2o8SXLQOELzngER
         8m1A==
X-Gm-Message-State: ABy/qLY7UtpWtneINIPe9SlKepzN99hQAufhF1cCGP981Bzq2AjQIOh0
        +FPLu/Fbq2TbtquqPA+KNeK877KoPzwplQTUv4H8BKyulQ4=
X-Google-Smtp-Source: APBJJlE75SoXvUcaKn+0M4NzzJRZdJFs9Q59qM9V68AgG6NSgpM5KHfjRyVh308gqb0wj64XVW1sOsE7REkdmConEe8=
X-Received: by 2002:a05:6a00:280a:b0:676:2a5c:7bc5 with SMTP id
 bl10-20020a056a00280a00b006762a5c7bc5mr15978772pfb.1.1688502288424; Tue, 04
 Jul 2023 13:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230704184109.991104-1-m.felsch@pengutronix.de> <20230704184109.991104-3-m.felsch@pengutronix.de>
In-Reply-To: <20230704184109.991104-3-m.felsch@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 17:24:36 -0300
Message-ID: <CAOMZO5C21f9+ByLVHMaK9wHcCSF3R9W1c1ZCfirx7TuX=786Rw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add DEBIX SOM A and SOM A I/O
 Board support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Jul 4, 2023 at 3:41=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.d=
e> wrote:

> +&fec {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_fec>;
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&ethphy1>;
> +       fsl,magic-packet;
> +       phy-reset-gpios =3D <&gpio4 19 GPIO_ACTIVE_LOW>;
> +       phy-reset-duration =3D <10>;
> +       phy-reset-post-delay =3D <150>;

These properties are deprecated. Please move them under the mdio node.

> +               /*
> +                * Since USB1 is binded to peripheral mode we need to ens=
ure

s/binded/bound

> +/* =C2=B5SD Card */
> +&usdhc2 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc2>;
> +       pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;
> +       pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;
> +       vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +       bus-width =3D <4>;
> +       disable-wp;
> +       no-sdio;
> +       no-mmc;
> +

No need for this blank line.

> +       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC2>;
> +       assigned-clock-rates =3D <400000000>;
> +

Ditto.

> +
> +       pmic@25 {
> +               compatible =3D "nxp,pca9450c";
> +               reg =3D <0x25>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_pmic>;
> +
> +               interrupt-parent =3D <&gpio1>;
> +               interrupts =3D <3 GPIO_ACTIVE_LOW>;
> +
> +               regulators {
> +                       buck1: BUCK1 {
> +                               regulator-name =3D "BUCK1";
> +                               regulator-min-microvolt =3D <600000>;
> +                               regulator-max-microvolt =3D <2187500>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay =3D <3125>;
> +                       };
> +
> +                       buck2: BUCK2 {
> +                               regulator-name =3D "BUCK2";
> +                               regulator-min-microvolt =3D <600000>;
> +                               regulator-max-microvolt =3D <2187500>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay =3D <3125>;
> +                               nxp,dvs-run-voltage =3D <950000>;
> +                               nxp,dvs-standby-voltage =3D <850000>;
> +                       };
> +
> +                       buck4: BUCK4{

Missing space after BUCK4.

> +                               regulator-name =3D "BUCK4";
> +                               regulator-min-microvolt =3D <600000>;
> +                               regulator-max-microvolt =3D <3400000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       buck5: BUCK5{

Ditto.

> +&usdhc3 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc3>;
> +       pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +       pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +       bus-width =3D <8>;
> +       non-removable;
> +

No need for this blank line.


> +       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC3>;
> +       assigned-clock-rates =3D <400000000>;
> +

Ditto.
