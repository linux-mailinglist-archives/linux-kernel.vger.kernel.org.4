Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198C6EC740
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDXHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjDXHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:38:39 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006CAE69
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:38:37 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-42e668a2c5eso961741137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682321917; x=1684913917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+4jOM/f9b4JhLtBToA6gnoTrIKE0Inz7GSYYH9hvps=;
        b=MlxFoi8wfFCMMlCElQUmQ4fG7KGfDuE0bNFG+6Dt3SSfwV6nhDJyeTUIcsSBUvkLzy
         LZm5dTvwVpmnPCePy6RtL+4EH8nFUx4B7lzJi6fl0Qa58f44ootrF6U1m8pZfoD93zxw
         Ah7IjFpPJq5NjybtHvAclq9Wyq5A7SUsu8Zrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682321917; x=1684913917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+4jOM/f9b4JhLtBToA6gnoTrIKE0Inz7GSYYH9hvps=;
        b=HIEjbuXIcou/GhUGxdZdUmESJ+VpKxRY72X7v0Io3Mh+MVdvvHdrAwPtVSRQe7EBC0
         lpiN4KPWkQkAcRu7VYNe+zbJiqtnq5WuqH9uySOp1JrzL4v15+mloh5mfpPQNroJGhq4
         LoB07Peh/izUPBh8GXaCZcWHHpniiHqBT4Ee3hwFDHMQ3XXzrvTFT5la2c4xJwUnuqsd
         WDJUAfREIXiJBpYqL/z3c09CkCrV9OM3r6oAXoWvfNLos7KPGJzOlVM2OhGWwhqsTo9C
         tS9rzot5Vey65tnKtDZafcTbtvR5xuFZh+zVtx+bcesG/LOtlstCzoMzU3457DtLUMHW
         VEcw==
X-Gm-Message-State: AAQBX9cav1Uv7Z15BY/xhhy6KdKRLs3PMPHUnRALuLFUuwSM9tXjSRAB
        SGFqIGW0Qu5WEBfhUMN3RXKj2WEvyhKCMcDDukyzeQ==
X-Google-Smtp-Source: AKy350bp2mW5PudrRDEQA1sSdHF+rhXS2JyG6H9jfqdQRz9LGDjuEOsvxsuBu7xDrMWIYkAEesbrEYR9hwxGGdehnFo=
X-Received: by 2002:a67:ff03:0:b0:42f:e944:7ea7 with SMTP id
 v3-20020a67ff03000000b0042fe9447ea7mr5013129vsp.6.1682321916777; Mon, 24 Apr
 2023 00:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-2-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GuEQMxYTKrnia1ipYHLt_B2h6By7EejE7MjCypfavnFg@mail.gmail.com>
 <5ede9421-54d6-4dda-91af-2acbf46c2d3e@notapiano> <097d60ba-5604-a2c9-c6d2-121db2d55e36@collabora.com>
In-Reply-To: <097d60ba-5604-a2c9-c6d2-121db2d55e36@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Apr 2023 15:38:25 +0800
Message-ID: <CAGXv+5G9Qh2ftB0NG4Km3wHQCgyxHK+Ae17QWJrv8V9VJaBH4A@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: mediatek: cherry: Add platform thermal configuration
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:31=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 21/04/23 22:53, N=C3=ADcolas F. R. A. Prado ha scritto:
> > On Fri, Apr 21, 2023 at 03:37:52PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Apr 20, 2023 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>>
> >>> This platform has three auxiliary NTC thermistors, connected to the
> >>> SoC's ADC pins. Enable the auxadc in order to be able to read the
> >>> ADC values, add a generic-adc-thermal LUT for each and finally assign
> >>> them to the SoC's thermal zones.
> >>>
> >>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> >>> ---
> >>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 105 +++++++++++++++=
+++
> >>>   1 file changed, 105 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/a=
rm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >>> index 8ac80a136c37..0820e9ba3829 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >>> @@ -114,6 +114,77 @@ ppvar_sys: regulator-ppvar-sys {
> >>>                  regulator-boot-on;
> >>>          };
> >>>
> >>> +       /* Murata NCP03WF104F05RL */
> >>> +       tboard_thermistor1: thermal-sensor-t1 {
> >>> +               compatible =3D "generic-adc-thermal";
> >>> +               #thermal-sensor-cells =3D <0>;
> >>> +               io-channels =3D <&auxadc 0>;
> >>> +               io-channel-names =3D "sensor-channel";
> >>> +               temperature-lookup-table =3D <    (-10000) 1553
> >>> +                                               (-5000) 1485
> >>> +                                               0 1406
> >>> +                                               5000 1317
> >>> +                                               10000 1219
> >>> +                                               15000 1115
> >>> +                                               20000 1007
> >>> +                                               25000 900
> >>> +                                               30000 796
> >>> +                                               35000 697
> >>> +                                               40000 605
> >>> +                                               45000 523
> >>> +                                               50000 449
> >>> +                                               55000 384
> >>> +                                               60000 327
> >>> +                                               65000 279
> >>> +                                               70000 237
> >>> +                                               75000 202
> >>> +                                               80000 172
> >>> +                                               85000 147
> >>> +                                               90000 125
> >>> +                                               95000 107
> >>> +                                               100000 92
> >>> +                                               105000 79
> >>> +                                               110000 68
> >>> +                                               115000 59
> >>> +                                               120000 51
> >>> +                                               125000 44>;
> >>> +       };
> >>> +
> >>> +       tboard_thermistor2: thermal-sensor-t2 {
> >>> +               compatible =3D "generic-adc-thermal";
> >>> +               #thermal-sensor-cells =3D <0>;
> >>> +               io-channels =3D <&auxadc 1>;
> >>> +               io-channel-names =3D "sensor-channel";
> >>> +               temperature-lookup-table =3D <    (-10000) 1553
> >>> +                                               (-5000) 1485
> >>> +                                               0 1406
> >>> +                                               5000 1317
> >>> +                                               10000 1219
> >>> +                                               15000 1115
> >>> +                                               20000 1007
> >>> +                                               25000 900
> >>> +                                               30000 796
> >>> +                                               35000 697
> >>> +                                               40000 605
> >>> +                                               45000 523
> >>> +                                               50000 449
> >>> +                                               55000 384
> >>> +                                               60000 327
> >>> +                                               65000 279
> >>> +                                               70000 237
> >>> +                                               75000 202
> >>> +                                               80000 172
> >>> +                                               85000 147
> >>> +                                               90000 125
> >>> +                                               95000 107
> >>> +                                               100000 92
> >>> +                                               105000 79
> >>> +                                               110000 68
> >>> +                                               115000 59
> >>> +                                               120000 51
> >>> +                                               125000 44>;
> >>> +       };
> >>> +
> >>>          usb_vbus: regulator-5v0-usb-vbus {
> >>>                  compatible =3D "regulator-fixed";
> >>>                  regulator-name =3D "usb-vbus";
> >>> @@ -260,6 +331,10 @@ &gpu {
> >>>          mali-supply =3D <&mt6315_7_vbuck1>;
> >>>   };
> >>>
> >>> +&auxadc {
> >>> +       status =3D "okay";
> >>> +};
> >>> +
> >>>   &i2c0 {
> >>>          status =3D "okay";
> >>>
> >>> @@ -1098,6 +1173,36 @@ mt6315_7_vbuck1: vbuck1 {
> >>>          };
> >>>   };
> >>>
> >>> +&thermal_zones {
> >>> +       soc_area_ntc {
> >
> > Not sure if that's what's causing the issue, but the thermal zone name =
should
> > end with -thermal as per the binding. Also note that it needs to be und=
er 20
> > characters otherwise it will fail to be registered with -22 like below.
> > (Also, node names shouldn't contain underscore)
> >
> > Thanks,
> > N=C3=ADcolas
> >
> >>> +               polling-delay =3D <1000>;
> >>> +               polling-delay-passive =3D <250>;
> >>> +               thermal-sensors =3D <&tboard_thermistor1>;
> >>> +
> >>> +               trips {
> >>> +                       trip-crit {
> >>> +                               temperature =3D <95000>;
> >>> +                               hysteresis =3D <2000>;
> >>> +                               type =3D "critical";
> >>> +                       };
> >>> +               };
> >>> +       };
> >>> +
> >>> +       pmic_area_ntc {
> >>> +               polling-delay =3D <1000>;
> >>> +               polling-delay-passive =3D <0>;
> >>> +               thermal-sensors =3D <&tboard_thermistor2>;
> >>> +
> >>> +               trips {
> >>> +                       trip-crit {
> >>> +                               temperature =3D <95000>;
> >>> +                               hysteresis =3D <2000>;
> >>> +                               type =3D "critical";
> >>> +                       };
> >>> +               };
> >>> +       };
> >>
> >> I'm still getting:
> >>
> >> thermal_sys: Failed to find 'trips' node
> >> thermal_sys: Failed to find trip points for thermal-sensor-t1 id=3D0
> >> generic-adc-thermal thermal-sensor-t1: Thermal zone sensor register fa=
iled: -22
> >> generic-adc-thermal: probe of thermal-sensor-t1 failed with error -22
> >> thermal_sys: Failed to find 'trips' node
> >> thermal_sys: Failed to find trip points for thermal-sensor-t2 id=3D0
> >> generic-adc-thermal thermal-sensor-t2: Thermal zone sensor register fa=
iled: -22
> >> generic-adc-thermal: probe of thermal-sensor-t2 failed with error -22
> >> thermal_sys: Failed to find 'trips' node
> >> thermal_sys: Failed to find trip points for thermal-sensor-t3 id=3D0
> >> generic-adc-thermal thermal-sensor-t3: Thermal zone sensor register fa=
iled: -22
> >> generic-adc-thermal: probe of thermal-sensor-t3 failed with error -22
> >>
>
> I think you have something wrong locally - there's no thermal-sensor-t3 i=
n this
> devicetree...

I seem to have run a stale kernel image. Rebuilt the kernel and everything
seems to work OK now.

BTW, I think the design went for a lower trip point. At least the hardware
thermal protection IC on the Acer device trips at 85 degrees C, instead of
95 degrees C. Maybe that's accounting for the fact that these are external
thermal sensors and have some latency and temperature difference. The PMIC
specifies 85 degrees C maximum ambient air temperature. The SoC doesn't
specify.

Either way this is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
