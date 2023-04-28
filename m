Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB96F174E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbjD1MNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjD1MNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:13:37 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B215D1726;
        Fri, 28 Apr 2023 05:13:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8a85:0:640:8fc9:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 7B71D5EB59;
        Fri, 28 Apr 2023 15:13:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UDIqPQ1DRSw0-oizJTPZv;
        Fri, 28 Apr 2023 15:13:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682684011;
        bh=8/DsglW6bXdL6cKM+snErWK1zkh/4xaDsTI58/cmNVI=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=TJwmrTCcVjrFrr3pAzJ629AteXtzNuVp9rAvtkWbI8aOWxvUiGt62HaU1oBYn/IUz
         IPICn1gnZTN/TY61XhL2BLxp7IWtwIFXOr3iX+z/upMRANUUGYm8C8d24THa1YgWMp
         ht8TU9U/75ncMus/ytq78TOG1VrJT6W/0gbTg+pE=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <90ad7d369ec3cae132245aa75daf460b90ec7b4e.camel@maquefel.me>
Subject: Re: [PATCH 34/43] ARM: dts: add device tree for ep93xx Soc
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>,
        support@embeddedTS.com
Date:   Fri, 28 Apr 2023 18:13:31 +0300
In-Reply-To: <e429c0e0-7044-492c-a4e2-ed0c1185bb39@app.fastmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-35-nikita.shubin@maquefel.me>
         <e429c0e0-7044-492c-a4e2-ed0c1185bb39@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd!

On Mon, 2023-04-24 at 13:28 +0200, Arnd Bergmann wrote:
> On Mon, Apr 24, 2023, at 14:34, Nikita Shubin wrote:
> > This adds a divice for Cirrus ep93xx SoC amd ts7250 board that has
> > been
> > my testing target for ep93xx device support.
> >=20
> > Also inluded device tree for Liebherr BK3.1 board through it's not
> > a
> > complete support.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Can you describe which parts are missing for BK3.1 in the
> changelog? I'm fairly sure that Liebherr is still supporting
> this board, but I don't have a contact to add to Cc here.

The current dt implementation is missing:

- I2S
- MMC on SPI

I will add those nodes so it will be a complete dt, however i have no
possibility to test it.


>=20
> I've added Lukasz Majewski to Cc here, as he originally worked
> on BK3.1 and likely either has the hardware or knows someone
> who does.=C2=A0 Technologic Systems also lists the ts7250 as supported
> on their website, but the only contact I found for them is the
> generic support@embeddedTS.com. In case someone from Technologic
> is available for giving the series a spin, see [1] for the
> full set of patches.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20
> [1]
> https://lore.kernel.org/all/20230424123522.18302-1-nikita.shubin@maquefel=
.me/

