Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF1687FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBBOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBBOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:19:42 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA56F8E4B8;
        Thu,  2 Feb 2023 06:19:41 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1F1215FD02;
        Thu,  2 Feb 2023 17:19:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1675347580;
        bh=38mW2MG6AD/VgdIfDWi13KtnVGKK3tE+NF61HxE3xIU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=K6T8wv/aPOjMRcvDwTGNk7/CMaOoKbty7sqlnSNHk9BevAHUUMlQM8hOrWAdyOLtG
         tFgj5q7NLiaGjmm0Lji1rXo5OUMVvd51W06myxIY/1rJp+jN7weeeiSSYGOSDPGErz
         BcyPf3nEabm2t0NPkPRapXBfYl0LbyKw8BGvelLVCMbyV6nnbSM8TlLcst1i9k6tm8
         eZKhFaSNLYP6NgmBTt66bchhJdO9eZg+s8RS+jFg/hILQEuRChT5+Vz1S26nAgy57o
         JKS1LEIqIxIVI+APbqmZBh0vkmVx8rX+Ca2Ar/BnO28XGgozJRRwAx5HH1xYcXiUfs
         sCotoka1Nh3/g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Feb 2023 17:19:39 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Topic: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Thread-Index: AQHZNxDMFNGdYZWqIECM18Y2pLjN2K67gk+A
Date:   Thu, 2 Feb 2023 14:19:39 +0000
Message-ID: <20230202141931.s75et3ttrypes7m4@cab-wsm-0029881>
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
In-Reply-To: <20230202141520.40003-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4469070D0C9B964F9BA2130E92985FE5@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/02 10:55:00 #20831577
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this patch has the wrong subject (I am tolking about1/2),=20
there is no second patch.

On Thu, Feb 02, 2023 at 05:15:20PM +0300, Alexey Romanov wrote:
> Add gpio interrupt controller node.
>=20
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index 6268c323a810..a04ddf0f4cd3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -158,6 +158,16 @@ clkc_pll: pll-clock-controller@7c80 {
>  					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
>  				clock-names =3D "xtal_fixpll", "xtal_hifipll";
>  			};
> +
> +			gpio_intc: interrupt-controller@0440 {
> +				compatible =3D "amlogic,meson-a1-gpio-intc",
> +					     "amlogic,meson-gpio-intc";
> +				reg =3D <0x0 0x0440 0x0 0x14>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <2>;
> +				amlogic,channel-interrupts =3D
> +					<49 50 51 52 53 54 55 56>;
> +			};
>  		};
> =20
>  		gic: interrupt-controller@ff901000 {
> --=20
> 2.38.1
>=20

--=20
Thank you,
Alexey=
