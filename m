Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473406F1AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjD1OmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjD1OmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:42:22 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DF30EE;
        Fri, 28 Apr 2023 07:42:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:5d0f:0:640:79fc:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 40A2A5EDA5;
        Fri, 28 Apr 2023 17:42:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wfKd9j2DbeA0-3XktHJY5;
        Fri, 28 Apr 2023 17:41:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682692919;
        bh=orHJq+nqnTkJFK2ER5u6DtrHQIQKDona602odu5GDtw=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=YYflK+ozee/PW496UDsSRi8cPV/tRoifFz8B5AfanNcrSUBT+L80SQF25E3AYLdP3
         ieGFq/woMC/q9MRyXvza74CSKasfKgLw8qMAB7/P6Tui3Epu/qSyoHAz6KCN8rW1Hr
         Jj/2zeiq32dsbOGGN1gH7r/8MYCg7//l3ffNbvvw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <c74d958aa1ea38f61cd1db965dce3cadbff530b5.camel@maquefel.me>
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
Date:   Fri, 28 Apr 2023 20:42:00 +0300
In-Reply-To: <e73cec19-9ac8-bee2-8c28-c7a40b929e53@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-10-nikita.shubin@maquefel.me>
         <00882340-477b-dc0b-d489-94efdf045f1c@linaro.org>
         <cb0b1779a8bd18212439f9baf70fdb183c9f0fc7.camel@maquefel.me>
         <e73cec19-9ac8-bee2-8c28-c7a40b929e53@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-28 at 14:20 +0200, Krzysztof Kozlowski wrote:
> On 28/04/2023 16:33, Nikita Shubin wrote:
> > Hello Krzysztof!
> >=20
> > On Tue, 2023-04-25 at 11:31 +0200, Krzysztof Kozlowski wrote:
> > > On 24/04/2023 14:34, Nikita Shubin wrote:
> > > > This adds device tree bindings for the Cirrus Logic EP93xx
> > > > watchdog block used in these SoCs.
> > > >=20
> > > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > > ---
> > > > =C2=A0.../bindings/watchdog/cirrus,ep93xx-wdt.yaml=C2=A0 | 38
> > > > +++++++++++++++++++
> > > > =C2=A01 file changed, 38 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
> > > > wdt.yaml
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
> > > > wdt.yaml
> > > > b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
> > > > wdt.yaml
> > > > new file mode 100644
> > > > index 000000000000..f39d6b14062d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-
> > > > wdt.yaml
> > > > @@ -0,0 +1,38 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > > > http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Cirrus Logic EP93xx Watchdog Timer
> > >=20
> > > EP93xx is no EP9301. This does not match your compatible list.
> > > You
> > > should probably list all of your devices. With or without
> > > compatibility
> > > between them (so with a generic fallback for example).
> >=20
> > I will rename file to cirrus,ep9301-wdt.yaml, all ep93xx SoC family
> > has
> > the same watchdog, so there is now reason for other compatible i
> > think.
>=20
> You should always have dedicated compatibles, even if using one
> fallback.
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree=
/bindings/writing-bindings.rst#L42

Krzysztof, sorry to bother you - but i don't quite get, what we should
have in compatibles ?=C2=A0

Should i make an additional fallback compatible like "cirrus,ep-wdt"
and then "compatible" will look like:

properties:
  compatible:
    - items:
      - enum:
        - cirrus,ep9301-wdt
      - const: cirrus,ep-wdt

Or should i describe every ep93xx SoC variant like:

properties:
  compatible:
    - items:
      - enum:
        - cirrus,ep9302-wdt
        - cirrus,ep9307-wdt
        - cirrus,ep9312-wdt
        - cirrus,ep9315-wdt
      - const: cirrus,ep9301-wdt

There are ep9301, ep9302, ep9307, ep9312 and ep9315 SoC variants - all
have the same watchdog and rtc implementation without any difference at
all.

If on of this is true does the same applies to ep9301-rtc and any other
variants where we do have a single compatible ?

>=20
> Best regards,
> Krzysztof
>=20

