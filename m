Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEFE7334A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjFPPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFPPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:24:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6D297D;
        Fri, 16 Jun 2023 08:24:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51878f8e541so1025010a12.3;
        Fri, 16 Jun 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686929062; x=1689521062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn/BTN44xyxlUw2PKKrOnf8y3fWJcGe7KVRI/Ykt+jA=;
        b=PjK7PJXUhEVq2tZ96W0rtC4BiVLxcJJ2kCKOScDs0Q0WKawuBsWfLhsMcF7BbyC1y4
         MxgcVT4sE9BLN7VJMm+cJ9ZaT0uroz+x0ycYf6Z9IYQfuUUJJ6IWU00w5RBxi3ovmK3f
         05TrBhzwgGTOWuDKXuOV8qzCwvC6Mu+YklmPY3FQZGhEyl2Mb9JiokyJZ11Bxp/QXLXc
         RIlf14uOhYTlrV2tqXXtcJmF0ehtWlcQ7YY/GUyM4fTmlLorUDmtMMd5leoGmTJoQrap
         djkOURyaU6XbCg4ohKGl2IcHSul3hbfKWBOauF35IfcpL4uT1aKLH0Cjy3m19RDBf2NT
         sBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929062; x=1689521062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn/BTN44xyxlUw2PKKrOnf8y3fWJcGe7KVRI/Ykt+jA=;
        b=k7yMaMgbUdBvC7FJeJjrOW4voQW9SQIzcGGPrnd6CHxW3TD4qJFoV64+D7oc/jzqLg
         DaAZrIr8+pZXYTGwaZ3EtAYFhGf3CXFAXbMwq6sjStk6ULpw3JmMC98TnpYdt/16vqfo
         FzDEtnjhzAXlqB1PpUgPoH5Tp9V0zdOViDx/2WDn8XtgTP9MiJ+fJjO14dDzNipcHdrM
         FSyhclHiFVEVoXa03uOEf2bNk2FxeqMXPOqQb2UFgGis6DqQC5ENWpf8OTHADFHeErZP
         /k7aNmPctc1tp4zySQMmAd+Bf3LtwauPTiDGnbb38blh2JQ2x2P13GIwhK4/2wp6/de9
         x4xw==
X-Gm-Message-State: AC+VfDx9u/Nn5Zp6IDmTPlPdieoNPceWfsdVHJV5s+Upbz8oeZlffvLY
        co+F/fpWuSs35+y2s0pU2YSmKhNU8ISZoE2hDmU=
X-Google-Smtp-Source: ACHHUZ4AMCmpqMcRTbV6e0HWlHqHxMitWeGT8CX56omWy3/0BZFAfW8Pto0JzZaKJMamCHIIfJp8Wjj6rtKhpfsrxXI=
X-Received: by 2002:a17:907:cca0:b0:978:82fd:758b with SMTP id
 up32-20020a170907cca000b0097882fd758bmr1532295ejc.29.1686929061758; Fri, 16
 Jun 2023 08:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090403.5274-1-clamor95@gmail.com> <20230329090403.5274-2-clamor95@gmail.com>
In-Reply-To: <20230329090403.5274-2-clamor95@gmail.com>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Fri, 16 Jun 2023 18:24:10 +0300
Message-ID: <CAPVz0n3XAonUH-d4hZ7JsWcgQd+fmq_WRPPajbOopq8E6y6TNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: tegra: transformer: use labels for mmc in aliases
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 29 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:04 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Use phandle references for mmc instead of path in aliases.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114-asus-tf701t.dts           | 12 ++++++------
>  .../boot/dts/tegra30-asus-transformer-common.dtsi    | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/d=
ts/tegra114-asus-tf701t.dts
> index 84a3eb38e71d..3a420ac969ff 100644
> --- a/arch/arm/boot/dts/tegra114-asus-tf701t.dts
> +++ b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
> @@ -13,9 +13,9 @@ / {
>         chassis-type =3D "convertible";
>
>         aliases {
> -               mmc0 =3D "/mmc@78000600"; /* eMMC */
> -               mmc1 =3D "/mmc@78000400"; /* uSD slot */
> -               mmc2 =3D "/mmc@78000000"; /* WiFi */
> +               mmc0 =3D &sdmmc4; /* eMMC */
> +               mmc1 =3D &sdmmc3; /* uSD slot */
> +               mmc2 =3D &sdmmc1; /* WiFi */
>
>                 rtc0 =3D &palmas;
>                 rtc1 =3D "/rtc@7000e000";
> @@ -605,12 +605,12 @@ i2s@70080300 {
>                 };
>         };
>
> -       mmc@78000000 {
> +       sdmmc1: mmc@78000000 {
>                 /* WiFi */
>         };
>
>         /* MicroSD card */
> -       mmc@78000400 {
> +       sdmmc3: mmc@78000400 {
>                 status =3D "okay";
>
>                 bus-width =3D <4>;
> @@ -626,7 +626,7 @@ mmc@78000400 {
>                 pinctrl-0 =3D <&sdmmc3_default>;
>         };
>
> -       mmc@78000600 {
> +       sdmmc4: mmc@78000600 {
>                 /* eMMC */
>         };
>
> diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arc=
h/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> index 1861b2de2dc3..f32806f07989 100644
> --- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> +++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
> @@ -12,9 +12,9 @@ / {
>         chassis-type =3D "convertible";
>
>         aliases {
> -               mmc0 =3D "/mmc@78000600"; /* eMMC */
> -               mmc1 =3D "/mmc@78000000"; /* uSD slot */
> -               mmc2 =3D "/mmc@78000400"; /* WiFi */
> +               mmc0 =3D &sdmmc4; /* eMMC */
> +               mmc1 =3D &sdmmc1; /* uSD slot */
> +               mmc2 =3D &sdmmc3; /* WiFi */
>
>                 rtc0 =3D &pmic;
>                 rtc1 =3D "/rtc@7000e000";
> @@ -1388,7 +1388,7 @@ i2s@70080600 {            /* i2s3 */
>                 };
>         };
>
> -       mmc@78000000 {
> +       sdmmc1: mmc@78000000 {
>                 status =3D "okay";
>
>                 /* FIXME: Full 208Mhz clock rate doesn't work reliably */
> @@ -1401,7 +1401,7 @@ mmc@78000000 {
>                 vqmmc-supply =3D <&vddio_usd>;    /* ldo3 */
>         };
>
> -       mmc@78000400 {
> +       sdmmc3: mmc@78000400 {
>                 status =3D "okay";
>
>                 #address-cells =3D <1>;
> @@ -1431,7 +1431,7 @@ wifi@1 {
>                 };
>         };
>
> -       mmc@78000600 {
> +       sdmmc4: mmc@78000600 {
>                 status =3D "okay";
>                 bus-width =3D <8>;
>                 vmmc-supply =3D <&vcore_emmc>;
> --
> 2.37.2
>

Hello Thierry!
For some reason this commit was not picked while all others in
the patchset were. May I know why and how to fix this?

Best regards,
Svyatoslav R.
