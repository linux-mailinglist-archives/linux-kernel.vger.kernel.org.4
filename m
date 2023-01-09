Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5666662871
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjAIO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjAIO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:27:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCFA1A7;
        Mon,  9 Jan 2023 06:27:25 -0800 (PST)
Received: from [IPv6:2a00:23c7:6883:e501:e3dd:1a86:446f:7abf] (unknown [IPv6:2a00:23c7:6883:e501:e3dd:1a86:446f:7abf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 99A346602D66;
        Mon,  9 Jan 2023 14:27:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673274443;
        bh=tLNThKqZUB1DNyTWYvgWqdVsU5kyJKEgZq9b9ugHPaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RPNXhDRfX1c2Bi9mrDKcZzUiviQA60XpYEFXb9IzNye4DXIZ0CjUeDsbC+DC5sjrL
         yWtC/7SdtOd9g9XFvthticMcdfIUncQwRotmkckYf401pvUWp3gJzsPQ1vabgDj0OQ
         7v2GrID0HB/EQjrZh2ACUjmdfAaGBY8+eIliQsq8gHBWtm2yDh6ML2m3Kr0gaRNEaq
         pnQ87S1B3xnrIAHl5MvNTfEzrAQ/baWVJZer49Y3XwqZkK4Dz6bpQgZTDH90Ed4B8a
         5jkzhyazihqVdwh8AYB49ch8TpbMIdratY3AO29zsWyYATaqr/FBNw1UeN7I5h8aB3
         xbFvePIT9gJZQ==
Message-ID: <0a3c520c75dcfe6ff86e96aa18fc5b52ce1e3f30.camel@collabora.com>
Subject: Re: [PATCHv6 4/7] dt-bindings: arm: rockchip: add initial rk3588
 boards
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Mon, 09 Jan 2023 14:27:21 +0000
In-Reply-To: <20230107002854.2kok76qdvl4a3hzw@mercury.elektranox.org>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
         <20221214182247.79824-5-sebastian.reichel@collabora.com>
         <d12fc3f83ace9285f7e1153003b14bc351ce95de.camel@collabora.com>
         <20230107002854.2kok76qdvl4a3hzw@mercury.elektranox.org>
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

>=20
>=20
Hi Sebastian,

> > To better match other boards from this vendor (e.g. RADXA ROCK 4)
> >=20
> > would it be best to capitalise this (and obviously the model field
> > in
> > the respective DTS patches) the same?
> >=20
> > So it would become "Radxa ROCK 5A" and "Radxa ROCK 5B".
> >=20
> > It's also capitalised this way on the documentation website [1].
> >=20
> > (I think the vendor has specifically dropped the Pi reference from
> > these boards, but I don't know why)
> >=20
> > Thanks!
> > Chris
> >=20
> > [1]: https://wiki.radxa.com/Rock5/5B
>=20
> The current format has been requested by Radxa:
>=20
> https://lore.kernel.org/all/892CB3E963AEF095+eaed7498-2324-9476-6a24-f940=
d62adb74@radxa.com/
>=20

The comment there suggests to use "Radxa ROCK 5 Model A" and "Radxa
ROCK 5 Model B", so can we make the following changes before the next
revision, to align on the model names?

PS. I think "board" is a terrible suffix, it's almost like when people
say "PCB Board". But maybe I am missing some historical context here ?


- Patch 4: "description: Radxa Rock 5 Model A" > "description: Radxa
ROCK 5 Model A"
- Patch 4: "description: Radxa Rock 5 Model B" > "description: Radxa
ROCK 5 Model B"
- Patch 6: "Radxa Rock 5A Board" > "Radxa ROCK 5 Model A"
- Patch 7: "Radxa Rock 5B Board" > "Radxa ROCK 5 Model B"


Thanks!
Chris
