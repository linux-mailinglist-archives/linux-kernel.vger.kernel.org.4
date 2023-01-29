Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340C6800A4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjA2SIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2SIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:08:52 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F51BFC;
        Sun, 29 Jan 2023 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675015729; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/R7VJYc0XHjp71v1j7ancxzPKlUub94NGM/mZIaP9dQ=;
        b=0E22Ftxa4PYzal438wqLo2X/LCKsGJkajExS1Id8Na/JG38zwqU/M8VRo8cbtfd7iAUrn8
        GyVDkw89MnuQr68LTMTMFUNA/Q2eyfdQJmZHlbvL2RG98XErEsPVi+Vp/qNT23T+KGUDNC
        spzdAoYGjnbKahahZllU1JLZT1LS1pU=
Message-ID: <d2d59f33dca05239b73b4221262086bfb1ce9e98.camel@crapouillou.net>
Subject: Re: [PATCH] MIPS: DTS: CI20: fix otg power gpio
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?Q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Date:   Sun, 29 Jan 2023 18:08:46 +0000
In-Reply-To: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>
References: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le dimanche 29 janvier 2023 =C3=A0 18:48 +0100, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> According to schematics it is PF15 and not PF14 (MIC_SW_EN).
> Seems as if it was hidden and not noticed during testing since
> there is no sound DT node.
>=20
> Fixes: 158c774d3c64 ("MIPS: Ingenic: Add missing nodes for Ingenic
> SoCs and boards.")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Looking at the schematics it looks like you are correct. So:
Acked-by: Paul Cercueil <paul@crapouillou.net>

I'm curious though, it is connected to the "SYS_POWER_IND" trace in the
schematic, which seems to also switch the main led between red and
blue, is that the case?

Cheers,
-Paul

> ---
> =C2=A0arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts
> b/arch/mips/boot/dts/ingenic/ci20.dts
> index 9819abb2465dd..a276488c0f752 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -115,7 +115,7 @@ otg_power: fixedregulator@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-min-microvolt =3D <5000000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0regulator-max-microvolt =3D <5000000>;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0gpio =3D <&gpf 14 GPIO_ACTIVE_LOW>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0gpio =3D <&gpf 15 GPIO_ACTIVE_LOW>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0enable-active-high;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0};

