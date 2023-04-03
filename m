Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD46D5151
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjDCT1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjDCT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:27:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2619B6;
        Mon,  3 Apr 2023 12:27:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ew6so121544315edb.7;
        Mon, 03 Apr 2023 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680550055; x=1683142055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se3no2U1BEAjqgVkUIbiPXSr/UsK3c8ayHmiAOdc6i0=;
        b=UARtSgQC9EuQSnmSkoADr2dvvdSuJpxE7vadF3X6wLoCGOi0sFvwP2LoUBJ2XFNyIL
         0NYiwMV8vZpxV++leDIqavTa81a8JL1zbuPqdKC/ehXm8Hxe5GM5gw90LBIV80Z4SM9Y
         md+Fm2835dBY8U1o5w0QPWcy78b3nyFqPvk0ZVgR/CZAbbBIwV/NKvoWmP+fg7g1ER3K
         ejt6LbyGgDTMcKdmS3xqjD6x+lIFvVyM1+DvCnxvvSIhbjKHd96dr+iuOx4JQWM6CnLb
         S1suinDUUSTs/4fdJr5r2GmvZTlNXNPZ1RC3d5JlLsMpjOMs/qZ+0LhGjM6bM7WaaC3q
         yWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680550055; x=1683142055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=se3no2U1BEAjqgVkUIbiPXSr/UsK3c8ayHmiAOdc6i0=;
        b=azPNUMB966tPwVJdwg6fUkPx5Vhw7+AulU2kM6UqDmM1I7Ky/KVhzRvFcaj+P4CDIB
         jYuDrOzM4J3ovYrWO+Fe0Jc3nq/dHxS1cUMvJnq4cxM/YhKoj3452yjQNVHzwmC26g9n
         sufBsv5Lqpit5nUBkxDTNaMEvpD6A4gv0/ycFCQSQB6gEEKXUeakhQfpg0w0s4CSbuOy
         PEhid5wwF1TDf0nvvOYUsfLTiQhx3xpbGcyfX35WTEtr7cDit6Irt1kNyYTr9KVbVJax
         fG1wvfJuv5ZlV0tLRljHGvIEgJ6T92JgSP/MPY+CEjkhPenl8ajIo+mqfg4HI+Wz28C5
         MKpA==
X-Gm-Message-State: AAQBX9f8w8OuL8wyvnFGztU2o2FgRcA363le4JS4dZOJBflHZMex3ea5
        EkMVDjKXIwOlILxv9AHQBPn93l18fieURmpZZ5s=
X-Google-Smtp-Source: AKy350Zp9LknbtnkEs+08Ept4WC1GhtU1o1/b9YwSKETN24Wpa6BvZayW5azg1Q+UbYSDX+WtMPzwF3uyq4N2FNX9Lw=
X-Received: by 2002:a17:906:2357:b0:931:cac0:60ff with SMTP id
 m23-20020a170906235700b00931cac060ffmr17646305eja.13.1680550054866; Mon, 03
 Apr 2023 12:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-3-cristian.ciocaltea@collabora.com> <642b134c.4a0a0220.1d01a.5990@mx.google.com>
In-Reply-To: <642b134c.4a0a0220.1d01a.5990@mx.google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 3 Apr 2023 15:27:22 -0400
Message-ID: <CAMdYzYrLjV97_Q2jhmNa9SJkraKXjttrZwovc=dmPTNLYnz5qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 1:56=E2=80=AFPM Chris Morgan <macroalpha82@gmail.com=
> wrote:
>
> On Mon, Apr 03, 2023 at 01:50:52PM +0300, Cristian Ciocaltea wrote:
> > Add the necessary DT changes for the Rock 5B board to enable support fo=
r
> > the PWM controlled heat sink fan.
>
> Honest question, but should we be adding this to the board file if not
> every device has a PWM fan (they all have the socket for the fan, but
> not the fan)? For example I have a passively cooled case that doesn't
> include a fan.

Active cooling should be set up to take effect before throttling. If
it is there great, (especially if it has feedback), if it doesn't
exist it really doesn't affect anything because the throttling will
kick in as necessary.

>
> Thank you,
> Chris Morgan.
>
> >
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 95805cb0adfa..bd74d9da2c17 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -17,6 +17,14 @@ chosen {
> >               stdout-path =3D "serial2:1500000n8";
> >       };
> >
> > +     fan: pwm-fan {
> > +             compatible =3D "pwm-fan";
> > +             cooling-levels =3D <0 95 145 195 255>;
> > +             fan-supply =3D <&vcc5v0_sys>;
> > +             pwms =3D <&pwm1 0 50000 0>;
> > +             #cooling-cells =3D <2>;
> > +     };
> > +
> >       vcc5v0_sys: vcc5v0-sys-regulator {
> >               compatible =3D "regulator-fixed";
> >               regulator-name =3D "vcc5v0_sys";
> > @@ -27,6 +35,10 @@ vcc5v0_sys: vcc5v0-sys-regulator {
> >       };
> >  };
> >
> > +&pwm1 {
> > +     status =3D "okay";
> > +};
> > +
> >  &sdhci {
> >       bus-width =3D <8>;
> >       no-sdio;
> > --
> > 2.40.0
> >
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
