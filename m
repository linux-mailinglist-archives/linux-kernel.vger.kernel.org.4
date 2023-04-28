Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE86F16DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjD1Lfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjD1Lfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:35:44 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEBC59F5;
        Fri, 28 Apr 2023 04:35:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 40E245EB4F;
        Fri, 28 Apr 2023 14:35:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aZHRVt0Wo8c0-ZH0b4yvg;
        Fri, 28 Apr 2023 14:35:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682681737;
        bh=CCx18jxXnQWO9tYFjWm/WdccOn5/RZF/6RqlULR1c7g=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=Q+zmdGt0nz+3XBM3dGR1j8w0Te+iwZ5NERi58hbhOz/nbbFlaHemMnDcfTPT4a8ET
         xoDaVzXGqPa7tKcRK7ch4kfXbt+25hIVPmnp+Oh80Xb+ypEf9C1rw7BXDbngCd9BZp
         BogMcMnPSjbZRlxUMigYMBk6UTi5TpR+OEbNg9LM=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <d1b7f24604332cf6010f533898f96eb9be4bb686.camel@maquefel.me>
Subject: Re: [PATCH 07/43] dt-bindings: rtc: add DT bindings for Cirrus
 EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Apr 2023 17:35:38 +0300
In-Reply-To: <9e7583be-ad4a-0ccc-08f6-cdf3fa4ed6bd@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-8-nikita.shubin@maquefel.me>
         <9e7583be-ad4a-0ccc-08f6-cdf3fa4ed6bd@linaro.org>
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

On Tue, 2023-04-25 at 11:28 +0200, Krzysztof Kozlowski wrote:
> On 24/04/2023 14:34, Nikita Shubin wrote:
> > This adds device tree bindings for the Cirrus Logic EP93xx
> > RTC block used in these SoCs.
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0.../bindings/rtc/cirrus,ep93xx-rtc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 32
> > +++++++++++++++++++
> > =C2=A01 file changed, 32 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-
> > rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-
> > rtc.yaml
> > new file mode 100644
> > index 000000000000..d4774e984e7b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/cirrus,ep93xx-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus EP93xx Real Time Clock controller
> > +
> > +maintainers:
> > +=C2=A0 - Hartley Sweeten <hsweeten@visionengravers.com>
> > +=C2=A0 - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: cirrus,ep9301-rtc
>=20
> Why only one compatible? What about ep9307 and ep9312? The same
> question
> for your previous patch - timer.
>=20
> Anyway, if you want to keep it like that, then filename should match
> compatible. Or merge it into trivial-rtc like Alexandre suggested.

I think i should move it to trivial-rtc - there is no need for a
separate file.


>=20
> Best regards,
> Krzysztof
>=20

