Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DC6EDDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjDYIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDYIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:25:38 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DB4C1E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:25:37 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4409786dab8so1784688e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682411136; x=1685003136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EagTYKGNK6lO5EWiNmyq6BDWbqfgu0PNzfW6Qz+RZcw=;
        b=U6OrDrUM1GmENXF8WYe8ocV7bnUwN51NadjwaQUq2YR7VWexpqeK3cEcIzfQh6kaka
         HxpKew5iLlOP4m3q403RiJWu+3rtiA3VJaW/tPnVWjZ2rP0gOZDdsr6V7O9y0ne3NeZL
         L7VdvmMBdUiGjFzPp2XVUoWD18wndom4AncqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411136; x=1685003136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EagTYKGNK6lO5EWiNmyq6BDWbqfgu0PNzfW6Qz+RZcw=;
        b=L91HLh5fQtMYJvbw5wgUEMUNdHjMM6rIj7J5a+L1ViwaCXRSSdgd+mCKarB+d7Cbg/
         LUn+IWJrcL4W0DSyVf/Q77fOwC5WBZ1SAjXCAHjXCNNQ5ZpzyE3nUyfxB9ASh9mS8J+P
         rCTU79x9gtPOIF5p25Bu1qXEMrZpUInR/X+s/3R8LX5HwuWIGQ+SrQxJIAGwzvglZruJ
         CjFMaOuqEHSLp7bQF+ia5H+jdzJjpBuerviDcB7o5agCqlA/GDSkQC2WYiZbt/iKXZXq
         O+P7kaCz6ObVmHx1RthI/Ml2gaEYGAUZ9JXibLQlqtzbNm3v0Wbs/w+vTFhua9y2JIIG
         So3A==
X-Gm-Message-State: AAQBX9d49Wk8QIbvudw9S7wGSzEKspjSWBkcnSLUXYO51bGRQkvX/aEx
        e7OH+IUrKYL1XIlKWKzFa+EdyF4uBFOkoDbB73p6ZaQZqjOECb4Nb58=
X-Google-Smtp-Source: AKy350YhcoGqhVqNt5WXPIhi5+U894y/gxCPIbGqm9Af3HXXxVtXCfd/efWsN5790EYhzuWriECmkqwACsF4uECb0hw=
X-Received: by 2002:a1f:c142:0:b0:432:2abc:fc2b with SMTP id
 r63-20020a1fc142000000b004322abcfc2bmr4178714vkf.0.1682411136465; Tue, 25 Apr
 2023 01:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com> <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Apr 2023 16:25:25 +0800
Message-ID: <CAGXv+5GX1CqH4OEoL7tQ9bherzXOVpJrNGrSYQj4Oh3ecUJh3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Enable PCI-Express
 ports for WiFi
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 7:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
> over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
> to enable enumerating this chip.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195-cherry.dtsi
> index adbda4dccdd5..eca5df85fe33 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -565,6 +565,13 @@ flash@0 {
>         };
>  };
>
> +&pcie1 {
> +       status =3D "okay";
> +
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pcie1_pins_default>;
> +};
> +
>  &pio {
>         mediatek,rsel-resistance-in-si-unit;
>         pinctrl-names =3D "default";
> @@ -959,6 +966,24 @@ pins-vreg-en {
>                 };
>         };
>
> +       pcie0_pins_default: pcie0-default-pins {
> +               pins-bus {
> +                       pinmux =3D <PINMUX_GPIO19__FUNC_WAKEN>,
> +                                <PINMUX_GPIO20__FUNC_PERSTN>,
> +                                <PINMUX_GPIO21__FUNC_CLKREQN>;
> +                                bias-pull-up;
> +               };
> +       };

I think we should remove this. We can add it later with the actual device
that has NVMe.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +       pcie1_pins_default: pcie1-default-pins {
> +               pins-bus {
> +                       pinmux =3D <PINMUX_GPIO22__FUNC_PERSTN_1>,
> +                                <PINMUX_GPIO23__FUNC_CLKREQN_1>,
> +                                <PINMUX_GPIO24__FUNC_WAKEN_1>;
> +                                bias-pull-up;
> +               };
> +       };
> +
>         pio_default: pio-default-pins {
>                 pins-wifi-enable {
>                         pinmux =3D <PINMUX_GPIO58__FUNC_GPIO58>;
> --
> 2.40.0
>
