Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32970C0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjEVOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjEVOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:23:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907FC1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:23:46 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55db055b412so53072347b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684765426; x=1687357426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2hQTPUfuJNacgMvbympUA555bAfKHNIBxMHLi2LZdc=;
        b=rOTajVneBQhIGoLRDiTAKs06aV0ZOoGSH5biVYGbjl78Iz8FzehO/v0hZ/VJ7knTJR
         zAgSOWXa3du18HrxOP/0JFGEhvlkVJun16BMBLcSwY5r6JJRnno3YOrFrqjwutsqqvxw
         F8hPiSH0KeouQivgMEkMM2EfcooGzUqekyu0zsMoEVsjyzjtBz59lEWNrvOVZBAQw43Y
         9ZgQk1K64FCzfPlyx6YleOwJ9kI/Ze9iRZONxG8mlc/OO3BxV95UuTz4UyREfmCfg6rC
         RRnK6gTVuwL9/1CfYHD+7uw/6Z8+rlsPO+U1JXXGdGU8mPG5FW6lubwQtztoi9HBXECA
         hTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684765426; x=1687357426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2hQTPUfuJNacgMvbympUA555bAfKHNIBxMHLi2LZdc=;
        b=hBrSZoMzT6Iq9pqTHDxxZfxl9blpY9CvyW8A3UKMfCRL/TlAj4J0x6/PXDDiW0xMP/
         sDCcbihyzlkmc7/1G3sb+Up3+BtEE13L9dWUSL+HYK6H2Ffb4cVuooQnVJmOvIxGHXQZ
         jtwrnfRudp+7pcyXJAV74qAUoZcZsOXXxlK4pjhrB1qOYSn+Osyz5L0k5nEPBWlNUKM+
         iL/J7Ix26Om9JKbQdB9Fv0wl6C21K4UweitPNe6BMt69Lx2HbTYqARjNgWb/NNNBxzw7
         QhzHbTbkughvev3/8lEl2Dbx8R6SIa6bIyVLr+xRfJQnahXQoZYVCp89k7e2Ca7H3WCR
         AzAg==
X-Gm-Message-State: AC+VfDzVMu5HMQdMy7rnRW29dU7Ma+GDRBmDHWj0Nh96DR7qMbfWJPQ/
        cX9wuwnPXFn/HEgQ9xCj9kmvZTyy8i7b7YbfdadZiw==
X-Google-Smtp-Source: ACHHUZ53/p5WrRGTADHz/P1eg0TzLqwPuexyukJwKo6PBD3Z5NBokuPlVMNwrk3h+57YFEC2ij05Mwx6SuXzhaAtnHs=
X-Received: by 2002:a81:9ac4:0:b0:55a:5323:2801 with SMTP id
 r187-20020a819ac4000000b0055a53232801mr11209388ywg.23.1684765426003; Mon, 22
 May 2023 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
 <20230203-evk-board-support-v7-8-98cbdfac656e@baylibre.com> <c6ea1360-9ca7-783e-0d0f-f5100fd8d024@collabora.com>
In-Reply-To: <c6ea1360-9ca7-783e-0d0f-f5100fd8d024@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 22 May 2023 16:23:34 +0200
Message-ID: <CAFGrd9qiYV2ct-z56Mu_4di1Rd0_u+u_WwyYYin6oJotq=2xpw@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] arm64: dts: mediatek: add ethernet support for mt8365-evk
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Le lun. 15 mai 2023 =C3=A0 13:47, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Il 11/05/23 18:29, Alexandre Mergnat ha scritto:
> > - Enable "vibr" and "vsim2" regulators to power the ethernet chip.
> >
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 57 ++++++++++++++++++++=
+++++++++
> >   1 file changed, 57 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/b=
oot/dts/mediatek/mt8365-evk.dts
> > index 3a472f620ac0..cf81dace466a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> > @@ -88,6 +88,28 @@ optee_reserved: optee@43200000 {
> >       };
> >   };
> >
> > +&ethernet {
> > +     pinctrl-0 =3D <&ethernet_pins>;
> > +     pinctrl-names =3D "default";
> > +     phy-handle =3D <&eth_phy>;
> > +     phy-mode =3D "rmii";
> > +     /*
> > +      * Ethernet and HDMI (DSI0) are sharing pins.
> > +      * Only one can be enabled at a time and require the physical swi=
tch
> > +      * SW2101 to be set on LAN position
> > +      */
> > +     status =3D "disabled";
> > +
> > +     mdio {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             eth_phy: ethernet-phy@0 {
> > +                     reg =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> >   &i2c0 {
> >       clock-frequency =3D <100000>;
> >       pinctrl-0 =3D <&i2c0_pins>;
> > @@ -137,12 +159,47 @@ &mt6357_pmic {
> >       #interrupt-cells =3D <2>;
> >   };
> >
> > +/* Needed by analog switch (multiplexer), HDMI and ethernet */
>
> What part of the ethernet HW needs this regulator?
>
> > +&mt6357_vibr_reg {
> > +     regulator-always-on;
> > +};
> > +
> >   /* Needed by MSDC IP */
> >   &mt6357_vmc_reg {
> >       regulator-always-on;
> >   };
> >
> > +/* Needed by ethernet */
>
> Same question for this one. If a device needs us to turn on a regulator i=
n
> order for it to be powered (read: if the supply is not fixed-on), setting
> that supply as always-on is not beneficial for anyone, as eventually in a
> power-off sleep/idle/whatever-pm state, this device (whole chip or IP) *w=
ill*
> leak some amount of power.
>
> If hardware engineers decided to connect a device to a supply that *can b=
e*
> shut down entirely there must be a reason, right? :-)

In theory yes, but mistakes happen. For MT8195, ethernet is supplied by VSY=
S.
Curiously, all other SoC except one haven't the regulator drived by
the mdio driver.
Why is it powered by a regulator which can be turned off here, whereas
the ethernet
chip is able to Wake-on-Lan ? Maybe the vibrator regulator has been chosen
to supply enough current for all analog switches (to share pins between eth=
ernet
and HDMI), I don't know.

Should I create a new mdio binding/driver/node related to the ethernet chip=
 to
enable/disable power ? Currently I found only one who does that: "mdio-sun4=
i",
so I'm not really confident.
OR
Should I introduce the regulator management directly into mtk_star_emac
binding/drive, even if it's more related to mdio ?
OR
Should I put a comment in the DTS which warns that vibr & vmc must be on
to have ethernet working ?

Do you have a better suggestion?

Finally, we are speaking about power optimization where the feature isn't
already supported for this SoC. Can we do this step by step ? Because setti=
ng
the regulators always-on doesn't look bad when ethernet is enabled (for WoL=
).

Do you have a better suggestion?

Regards,
Alex
