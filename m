Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CE6F16D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbjD1LdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbjD1LdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:33:17 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB95FEA;
        Fri, 28 Apr 2023 04:33:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:18e:0:640:44ac:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 302375EDF2;
        Fri, 28 Apr 2023 14:33:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DXH4o21DcuQ0-R9hs8aMt;
        Fri, 28 Apr 2023 14:33:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682681594;
        bh=HvV52W5SJzjsycQVe5Vz9KpN8mw9Ht6bm14pJrshHFg=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=LQ8UIoL6uGoOxDgTf1jjlk+s9RTWe0rJQenNnIsDxBXuU3jtwChlZTZH+EL4oAEYn
         DwAnIGzSxNheKQFFffrkwpK+9iEE5ja99Xl8zuJBUzYpS0zp+gFAsD6MPagSN3BbIe
         zwnnjnv74V/pn5Gz/2oIRy1rMPZJrZHl3NSlFyT8=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <cb0b1779a8bd18212439f9baf70fdb183c9f0fc7.camel@maquefel.me>
Subject: Re: [PATCH 09/43] dt-bindings: watchdog: add DT bindings for Cirrus
 EP93x
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Apr 2023 17:33:15 +0300
In-Reply-To: <00882340-477b-dc0b-d489-94efdf045f1c@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-10-nikita.shubin@maquefel.me>
         <00882340-477b-dc0b-d489-94efdf045f1c@linaro.org>
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

Hello Krzysztof!

On Tue, 2023-04-25 at 11:31 +0200, Krzysztof Kozlowski wrote:
> On 24/04/2023 14:34, Nikita Shubin wrote:
> > This adds device tree bindings for the Cirrus Logic EP93xx
> > watchdog block used in these SoCs.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0.../bindings/watchdog/cirrus,ep93xx-wdt.yaml=C2=A0 | 38
> > +++++++++++++++++++
> > =C2=A01 file changed, 38 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > new file mode 100644
> > index 000000000000..f39d6b14062d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
> > wdt.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> > http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP93xx Watchdog Timer
>=20
> EP93xx is no EP9301. This does not match your compatible list. You
> should probably list all of your devices. With or without
> compatibility
> between them (so with a generic fallback for example).

I will rename file to cirrus,ep9301-wdt.yaml, all ep93xx SoC family has
the same watchdog, so there is now reason for other compatible i think.

>=20
> > +
> > +maintainers:
> > +=C2=A0 - Wim Van Sebroeck <wim@linux-watchdog.org>
> > +
> > +description:
> > +=C2=A0 Watchdog driver for Cirrus Logic EP93xx family of devices.
>=20
> Drop "driver for" and instead describe the hardware.
>=20
> > +
> > +allOf:
> > +=C2=A0 - $ref: "watchdog.yaml#"
>=20
> Drop quotes.
> Best regards,
> Krzysztof
>=20

