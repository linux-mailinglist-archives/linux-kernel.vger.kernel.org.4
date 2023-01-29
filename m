Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA56800F2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjA2Ssj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjA2Ssd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:48:33 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074B1F48C;
        Sun, 29 Jan 2023 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675018082; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gp0QeP64H/wO4jt2W7DBtZuRtm1/SuWDRrls07fc3e8=;
        b=ke3KpsJvNaqAiMIqgO7WBG27A7VYm1WZ7r3q8c4Zx+D8XA/NoGDlSnkk3Pgem7JU+Lhter
        1AEdslKEU4P3k6KG721YdjkwIc421PJQSJmXw6/8RFe/zTuknpiGtR8Gs6BbltljLIuJKG
        8DBkuPJzAzGw2WOY6Ek8PHFSrUvyaSI=
Message-ID: <b7745c417d5ac46efa273f1fc45217bb6254ea4f.camel@crapouillou.net>
Subject: Re: [PATCH] MIPS: DTS: CI20: fix otg power gpio
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?Q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Date:   Sun, 29 Jan 2023 18:47:59 +0000
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

Le dimanche 29 janvier 2023 =C3=A0 18:48 +0100, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> According to schematics it is PF15 and not PF14 (MIC_SW_EN).
> Seems as if it was hidden and not noticed during testing since
> there is no sound DT node.
>=20
> Fixes: 158c774d3c64 ("MIPS: Ingenic: Add missing nodes for Ingenic
> SoCs and boards.")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I missed it, but every time you have a Fixes: tag, you also need to add
below:
Cc: stable@vger.kernel.org

unless the bug you fix is in one of the RCs (and not in a released
kernel).

I think you should send a V2 with this tag (and my ACK).

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

