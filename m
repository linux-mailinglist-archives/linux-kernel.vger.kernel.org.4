Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32C65F461
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjAET0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjAETZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:25:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B64644A;
        Thu,  5 Jan 2023 11:21:23 -0800 (PST)
Received: from [IPv6:2a00:23c7:6883:e501:6192:d8f9:963c:a052] (unknown [IPv6:2a00:23c7:6883:e501:6192:d8f9:963c:a052])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FEFF6602D2E;
        Thu,  5 Jan 2023 19:20:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672946421;
        bh=5L9drfFJSTu5DZP2sxEv+jFG5NmOrd7W3Q4N9gnPgNE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OXQrltlC/bx+E26cNvzRwuM2BZraSxwqp9NuKlbjaAkODY89kqtWTGRQ1a9o9qM9W
         zfOF6FlAo9rfvQ5swAmjte9abXjsGi5Zs2yzizp5UvOOqFtq8uCrvyjYvkCuA76y8I
         +I9Bf4e11Hh+kq/OD/qn5Urde+4GpStGTUNr/end09xgR0P2gpeBpAQi24alrBeD71
         eMD8n118TNjJPeHStj9g/cgSv+HYOIHsy5RbBldoFSKEvBeCtnRU5KHux3QfE+ZMM5
         yaf4LjiGgCWoAsEhBuHMtCYWzz+U5Qar/rn0ggVwFpwKrNgACbyU7HXjlz7Ib2Fo/L
         +217K54VdSugw==
Message-ID: <d12fc3f83ace9285f7e1153003b14bc351ce95de.camel@collabora.com>
Subject: Re: [PATCHv6 4/7] dt-bindings: arm: rockchip: add initial rk3588
 boards
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Thu, 05 Jan 2023 19:20:19 +0000
In-Reply-To: <20221214182247.79824-5-sebastian.reichel@collabora.com>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
         <20221214182247.79824-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-14 at 19:22 +0100, Sebastian Reichel wrote:
> Add DT binding documentation for the Rockchip RK3588 EVB1,
> Radxa Rock 5 Model A and B.
>=20
> Co-Developed-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> =C2=A0.../devicetree/bindings/arm/rockchip.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 15
> +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index c6c69a4e3777..49d442afe67f 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -620,6 +620,16 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rad=
xa,rock3a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: roc=
kchip,rk3568
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Radxa Rock 5 Model A
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: radxa,ro=
ck-5a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockchip=
,rk3588s
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Radxa Rock 5 Model B

Hi Sebastian,

To better match other boards from this vendor (e.g. RADXA ROCK 4)

would it be best to capitalise this (and obviously the model field in
the respective DTS patches) the same?

So it would become "Radxa ROCK 5A" and "Radxa ROCK 5B".

It's also capitalised this way on the documentation website [1].

(I think the vendor has specifically dropped the Pi reference from
these boards, but I don't know why)

Thanks!
Chris

[1]: https://wiki.radxa.com/Rock5/5B



> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: radxa,ro=
ck-5b
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockchip=
,rk3588
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Rikomagic MK808 v1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rik=
omagic,mk808
> @@ -704,6 +714,11 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: roc=
kchip,rk3399-sapphire-excavator
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: roc=
kchip,rk3399
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Rockchip RK3588 Evaluation=
 board
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockchip=
,rk3588-evb1-v10
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockchip=
,rk3588
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Rockchip RV1108 Evalu=
ation board
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: roc=
kchip,rv1108-evb
> --=20
> 2.39.0
>=20
>=20
