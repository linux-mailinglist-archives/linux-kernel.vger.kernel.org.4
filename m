Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAE6DAD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjDGNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbjDGNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:13:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394CAD32
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:13:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h198so5203163ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873212; x=1683465212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf5pLslbtdeYLIBav9Q4n1LWSY2rIYqcHA2Pww/eWJg=;
        b=aIWXZD8qO6c8F/XQe/9bJTSOdBP5zW1qOfbX3BkKFerdWseMYXJG419xOdGmj4qkcF
         BQfI2Fp7/QVleMlEAubkIWeUqdzJiYV2o+6csPe9Gwl8zT2qRlw9mEqyMaAJ7rRBbiWD
         CiX53X2W7iUg09VfMnqPTx0eyhNpzfepcZWUVFIER+HWR+ntkGWv6BCnCBdqDUcpX5Ky
         hRD5NvGJC2BHTcnBpFSTWkqu8pfHEYRTXkOMOQSSID921xZxZcius+5YXiDRcwLPB3If
         l0b8gA7AH6vsLLj/6FI9VGgrGvWfBt+LFbQgqQoW3O+Zs6K38+moqFRo/VwMt3FpSaZw
         M+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873212; x=1683465212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf5pLslbtdeYLIBav9Q4n1LWSY2rIYqcHA2Pww/eWJg=;
        b=Q84ijX3g1Uveb/6U4LOtOhlCz3bBxbLGIwYrCQy3fSbljP4HH1X0UUWCBQwP36lPNm
         s6f0W5xgh6iIm0zu9VtGj/VpkvIJOKeUa35h15cn5QTGHoT4hOTzJDOAAQ7+9D4KoGTF
         H66W5Lks5vViSIWMSs0kpzNrRHDwwm8XfXtgJlghJaQ1HzYqSNbgsWk0bj27yeQRPFdz
         qi12VD7h8FR+V5ERPzTMUNJLQO69oqA5UPDB/kRBbhQnnVip5h3DPsUH1OELili0Buyv
         xPZq9W9NOnvOBJpeAwjibUWhG1g1yePBPeutnYVZsKgG7bpQt6A3UiU4/9MKKS5ZXe3x
         jYUw==
X-Gm-Message-State: AAQBX9elPUCwQlGJWxr+JPT5507Amp0k5a67SnFgymJJ4K8yvkfAQocr
        OzkkouwIEAr6ERZNoMlCE9uMttVPfepJMbZdXnilww==
X-Google-Smtp-Source: AKy350YKEEfJQWX1GeUa5EIHq4VHQwjHUmval/5WC9MouV84sA3alh+Vugt+1dChC3aMBSnGARWLKAL8BsYMtlCPvGM=
X-Received: by 2002:a25:d994:0:b0:b33:531b:3dd4 with SMTP id
 q142-20020a25d994000000b00b33531b3dd4mr1373821ybg.1.1680873211869; Fri, 07
 Apr 2023 06:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-8-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-8-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:13:20 +0200
Message-ID: <CAFGrd9oohBtNi5YNm+FP7bsfEqgHwfXnp9kGJEwvP_Wc_xD-Ug@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ To: Catalin Marinas <catalin.marinas@arm.com>
+ To: Will Deacon <will@kernel.org>

Sorry for the noise.

Regards,
Alexandre

Le ven. 7 avr. 2023 =C3=A0 14:59, Alexandre Mergnat <amergnat@baylibre.com>=
 a =C3=A9crit :
>
> This patch add support for SuperSpeed USB, in OTG mode, on micro connecto=
r.
> It also add support for the Extensible Host Controller Interface USB.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boo=
t/dts/mediatek/mt8365-evk.dts
> index 1c36d8f19525..9760f181eb34 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -314,6 +314,28 @@ &pwm {
>         status =3D "okay";
>  };
>
> +&ssusb {
> +       dr_mode =3D "otg";
> +       maximum-speed =3D "high-speed";
> +       pinctrl-0 =3D <&usb_pins>;
> +       pinctrl-names =3D "default";
> +       usb-role-switch;
> +       vusb33-supply =3D <&mt6357_vusb33_reg>;
> +       status =3D "okay";
> +
> +       connector {
> +               compatible =3D "gpio-usb-b-connector", "usb-b-connector";
> +               id-gpios =3D <&pio 17 GPIO_ACTIVE_HIGH>;
> +               type =3D "micro";
> +               vbus-supply =3D <&usb_otg_vbus>;
> +       };
> +};
> +
> +&usb_host {
> +       vusb33-supply =3D <&mt6357_vusb33_reg>;
> +       status =3D "okay";
> +};
> +
>  &uart0 {
>         pinctrl-0 =3D <&uart0_pins>;
>         pinctrl-names =3D "default";
>
> --
> 2.25.1
>
