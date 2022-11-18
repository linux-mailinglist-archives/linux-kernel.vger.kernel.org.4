Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB562FAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiKRQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiKRQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:51:12 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E2942F3;
        Fri, 18 Nov 2022 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1668790269; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nuvc8xs/tHY7tFt1K4QIyCzdBKfQ5FijC8GcRmpSk8=;
        b=sp3ZFBBa9zl7myNNfiumVeMAKCSAyZt5xTG2Hz1aGT3V3p6UOmfodKg7HShLsGtlih7YIT
        XnSUAcgkDbm9NJaaZKHcPMWwtx0mz06qBeiKXcvfabvtWoB0gtysLbd1jG2AGy9T2VCrfA
        Y+NmDgs2qXQfcNPHU8UN7pFwqhM8LLQ=
Date:   Fri, 18 Nov 2022 16:51:00 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: DTS: CI20: fix reset line polarity of the ethernet
 controller
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <0TYJLR.I2HAAXVSWQ2D@crapouillou.net>
In-Reply-To: <Y3e2Q9jeGotRlwqV@google.com>
References: <Y3e2Q9jeGotRlwqV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Le ven. 18 nov. 2022 =E0 08:43:47 -0800, Dmitry Torokhov=20
<dmitry.torokhov@gmail.com> a =E9crit :
> The reset line is called PWRST#, annotated as "active low" in the
> binding documentation, and is driven low and then high by the driver=20
> to
> reset the chip. However in device tree for CI20 board it was=20
> incorrectly
> marked as "active high". Fix it.
>=20
> Because (as far as I know) the ci20.dts is always built in the kernel=20
> I
> elected not to also add a quirk to gpiolib to force the polarity=20
> there.
>=20
> Fixes: db49ca38579d ("net: davicom: dm9000: switch to using gpiod=20
> API")
> Reported-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks.

Cheers,
-Paul

> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts=20
> b/arch/mips/boot/dts/ingenic/ci20.dts
> index 37c46720c719..f38c39572a9e 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -438,7 +438,7 @@ dm9000@6 {
>  		ingenic,nemc-tAW =3D <50>;
>  		ingenic,nemc-tSTRV =3D <100>;
>=20
> -		reset-gpios =3D <&gpf 12 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpf 12 GPIO_ACTIVE_LOW>;
>  		vcc-supply =3D <&eth0_power>;
>=20
>  		interrupt-parent =3D <&gpe>;
> --
> 2.38.1.584.g0f3c55d4c2-goog
>=20
>=20
> --
> Dmitry


