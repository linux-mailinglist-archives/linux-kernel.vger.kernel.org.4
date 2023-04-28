Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D536F16D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbjD1Leq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjD1Leo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:34:44 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FF2D5B;
        Fri, 28 Apr 2023 04:34:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:5d0f:0:640:79fc:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 0703B5EE82;
        Fri, 28 Apr 2023 14:34:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eYHNs41DZuQ0-njgeY67C;
        Fri, 28 Apr 2023 14:34:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682681680;
        bh=Y11U5k7D3rE8W513bKQpz7lLAZiHXe9J0ppF+72wWOQ=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=c1ITq0Ean/GuwDZYhdC5NjtX4tB2SzHox9vptrN2zqJt6LosnbwxLexJ4/4SeasP2
         oudrAB51o+t9+PLnKcvqQX+YMoDKMbpEvFbngol+kc6WVpmkKXD6FD/g3rV4TOpf3n
         rI7Bceu/hgKd8R9Auz+kw4K+h6pOR8GOZbmvsfF4=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <119e319aadd2c76fc290f71c8444e7438219ca6c.camel@maquefel.me>
Subject: Re: [PATCH 05/43] dt-bindings: timers: add DT bindings for Cirrus
 EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 28 Apr 2023 17:34:41 +0300
In-Reply-To: <9805a697-423a-7488-8cd6-f5c35686d431@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-6-nikita.shubin@maquefel.me>
         <9805a697-423a-7488-8cd6-f5c35686d431@linaro.org>
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

On Tue, 2023-04-25 at 11:29 +0200, Krzysztof Kozlowski wrote:
> On 24/04/2023 14:34, Nikita Shubin wrote:
> > This adds device tree bindings for the Cirrus Logic EP93xx
> > timer block used in these SoCs.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >=20
> > Notes:
> > =C2=A0=C2=A0=C2=A0 Arnd Bergmann:
> > =C2=A0=C2=A0=C2=A0 - replaced ep93xx wildcard with ep9301
> >=20
> > =C2=A0.../bindings/timer/cirrus,ep93xx-timer.yaml=C2=A0=C2=A0 | 41
> > +++++++++++++++++++
> > =C2=A01 file changed, 41 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep93xx-
> > timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-
> > timer.yaml
> > new file mode 100644
> > index 000000000000..ce8b8a5cb90a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-
> > timer.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/cirrus,ep93xx-timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP93xx timers bindings
> > +
> > +maintainers:
> > +=C2=A0 - Hartley Sweeten <hsweeten@visionengravers.com>
> > +=C2=A0 - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: cirrus,ep9301-timer
>=20
> 1. Why only one compatible?
> 2. If this is kept, then filename matching compatible.

I should rename the file to cirrus,ep9301-timer.yaml

>=20
> Best regards,
> Krzysztof
>=20

