Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A26EC885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjDXJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDXJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:15:36 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BEB6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:15:35 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-771d9ec5aa5so17963733241.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682327734; x=1684919734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx7887igrG1FHuRUhWl71owqx8AZ7P/HQi+L6Ao/Eq0=;
        b=GKGcMayBMsRsIIULpLnyaH8cw7op/k+gp79J7FQeM5m8HgIn5SCkAO8oF7WTfmXtxG
         hVO7d47c3dnOYfF+O906h6NY6fsWYMF5qhJtDw8wJxaBeKD41cLs3xtVn5OSM/S+i9B7
         t7D0AKpyaQ/OWntA/F9BWu9GNsKLD4fuItkeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327734; x=1684919734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx7887igrG1FHuRUhWl71owqx8AZ7P/HQi+L6Ao/Eq0=;
        b=gSjK7OKyYysWpqItt+7uGf5EJSJ25SegJSBT8U/7TcNS2dv53eUSJPb85tV66o3Qrc
         t3T4ykFw9tWPX+Bu7Y7OrcNPKK7XdHgRFwq1AmruOrKv5lfv2l0oHxClz1yEoh+ou6jG
         eaqSIBYDVRGLWs7XktEerKHkRjFqf3OnALOatvJRa61bmXRG9THYQCFWmB41Y9fXG+DO
         48d8GqSa5L5BJTqZr5Rs9FnaTTVtxAElFxQ+hoC9y64XorAvsEsKI3cpG5nyy5NEPMen
         sC4RMfkxRkprNH9m5ixxbwfFQ6ps6/D/8stXKTcN/6iCHwWUS97kLaCi6yLgYTOhyZ+R
         L3Qw==
X-Gm-Message-State: AAQBX9e0nSnf/ho7qmGCYczDjyxsmxhXs+aveHf15qlpt8Mok5z/B2AU
        Po9yq995FijOUEX4qejC4N2DN9prLPvkp1tucx53jQ==
X-Google-Smtp-Source: AKy350bh1y5Id9K/CKKzxg/hyZXchzBox+vu/bgdhz9ztQs0ughNIHIXyDUJXslVwnFaDhDVB5HgLtOtP2DIrMdm73g=
X-Received: by 2002:a1f:4582:0:b0:446:ef36:2fa4 with SMTP id
 s124-20020a1f4582000000b00446ef362fa4mr4030463vka.6.1682327734321; Mon, 24
 Apr 2023 02:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230421110327.2395804-1-wenst@chromium.org> <872e8b77-c1ea-410a-b978-dd8f49f9904b@notapiano>
In-Reply-To: <872e8b77-c1ea-410a-b978-dd8f49f9904b@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Apr 2023 17:15:23 +0800
Message-ID: <CAGXv+5G8FsSjz5+4+NBgP+HXZfN4m1SkE2aOiV_i-18xDeVoKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada-hayato: Enable Bluetooth
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:01=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Fri, Apr 21, 2023 at 07:03:27PM +0800, Chen-Yu Tsai wrote:
> > Hayato's Realtek WiFi/BT module has it's Bluetooth function wired to
> > UART1.
> >
> > Add and enable the relevant device nodes for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts =
b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > index 43a823990a92..6a7d7870525b 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> > @@ -40,9 +40,89 @@ CROS_STD_MAIN_KEYMAP
> >       >;
> >  };
> >
> > +&pio {
> > +     bt_pins: bt-pins {
> > +             bt_kill: pins-bt-kill {
>
> Drop this label and for the other pinconfigs below as they'll never be
> referenced.

Ack.

> > +                     pinmux =3D <PINMUX_GPIO144__FUNC_GPIO144>; /* BT_=
KILL_L */
>
> I'd also drop this and the other comments, as they're already documented =
in the
> gpio-line-names property.

Ack.

> > +                     output-low;
> > +             };
> > +
> > +             bt_wake: pins-bt-wake {
> > +                     pinmux =3D <PINMUX_GPIO22__FUNC_GPIO22>;  /* bt t=
o wake ap */
> > +                     bias-pull-up;
> > +             };
> > +
> > +             ap_wake_bt: pins-ap-wake-bt {
> > +                     pinmux =3D <PINMUX_GPIO168__FUNC_GPIO168>; /* AP_=
WAKE_BT_H */
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     uart1_pins: uart1-pins {
> > +             pins-rx {
> > +                     pinmux =3D <PINMUX_GPIO94__FUNC_URXD1>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +
> > +             pins-tx {
> > +                     pinmux =3D <PINMUX_GPIO95__FUNC_UTXD1>;
> > +             };
> > +
> > +             pins-cts {
> > +                     pinmux =3D <PINMUX_GPIO166__FUNC_UCTS1>;
> > +                     input-enable;
> > +             };
> > +
> > +             pins-rts {
> > +                     pinmux =3D <PINMUX_GPIO167__FUNC_URTS1>;
> > +                     output-enable;
>
> Looks like the dt-binding doesn't currently support output-enable, but th=
e
> driver does, so please just add a patch with
>
>           output-enable: true
>
> on mediatek,mt8192-pinctrl.yaml

Looking at the driver and the datasheet, there is no actual output-enable
hardware. The driver simply sets an pin direction register, which is the
same thing done when setting the GPIO direction.

On the other hand, there is actually an input enable function, but the
driver also sets the pin direction. All pins have "input enable" set
by default in hardware doesn't help.

I'll drop this for now and look into fixing the pinctrl driver.

> > +             };
> > +     };
> > +
> > +     uart1_pins_sleep: uart1-pins-sleep {
>
> "-pins" needs to come last in the name otherwise the dt-binding will comp=
lain.

Ack.

> > +             pins-rx {
> > +                     pinmux =3D <PINMUX_GPIO94__FUNC_GPIO94>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +             pins-tx {
> > +                     pinmux =3D <PINMUX_GPIO95__FUNC_UTXD1>;
> > +             };
> > +             pins-cts {
> > +                     pinmux =3D <PINMUX_GPIO166__FUNC_UCTS1>;
> > +                     input-enable;
> > +             };
> > +             pins-rts {
> > +                     pinmux =3D <PINMUX_GPIO167__FUNC_URTS1>;
> > +                     output-enable;
> > +             };
> > +     };
> > +};
> > +
> >  &touchscreen {
> >       compatible =3D "hid-over-i2c";
> >       post-power-on-delay-ms =3D <10>;
> >       hid-descr-addr =3D <0x0001>;
> >       vdd-supply =3D <&pp3300_u>;
> >  };
> > +
> > +&uart1 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&uart1_pins>;
> > +     pinctrl-1 =3D <&uart1_pins_sleep>;
> > +     /delete-property/ interrupts;
> > +     interrupts-extended =3D <&gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
> > +                           <&pio 94 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +     bluetooth: bluetooth {
>
> I'd also drop this label and only introduce it if/when needed.

Ack.

> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Thanks,
> N=C3=ADcolas
>
> > +             compatible =3D "realtek,rtl8822cs-bt";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&bt_pins>;
> > +
> > +             enable-gpios =3D <&pio 144 GPIO_ACTIVE_HIGH>;
> > +             device-wake-gpios =3D <&pio 168 GPIO_ACTIVE_HIGH>;
> > +             host-wake-gpios =3D <&pio 22 GPIO_ACTIVE_LOW>;
> > +     };
> > +};
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
