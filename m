Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3A6FE606
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbjEJVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjEJVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:15:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C7E53;
        Wed, 10 May 2023 14:15:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so8773682e87.3;
        Wed, 10 May 2023 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683753327; x=1686345327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/rus91C04tG29B/ScEf5OKsFh39zkI9m79US8PQUjY=;
        b=kxU9hqWiGsb6rsgN4sv51cSToVaLDE6+6IgBcxEr62a3B/BMVcBuiVluCaqLMEHwlG
         BFAM6qG3wuW1WyQ9uhU3Tdd53L3Ny1BPh1yKrKNzyzy8RxWQ22VZ7PSM6LoWJpm1AZzc
         Gyz+SUfMIhvpvLa+0Uh8jC7FufEwGCFBTw5gycr4IMXnHXhUd4AIUgQ+RoJMT/FlP5IT
         WoWNoGlUwUETI35+lXLleEM5h+cVoS8tBcsRlEokqWNGiZm6/sGhBDotop8q6jf708MS
         CiRGnJhbBvnwsfTVHmoW7ZS2yKNMc04seGozJqJkCFhSx3CWaeYjags32ka57rBHgUWV
         R85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753327; x=1686345327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/rus91C04tG29B/ScEf5OKsFh39zkI9m79US8PQUjY=;
        b=DTsGBndQNgWbXxY/JAfmgWaZ1iJ+RF8CxLvdCSF482xT7DiaKr7Kl4LZXdwQ2oiSx2
         mAPRSoZxHLPpXOxIK4EH7l7xVIpejIQ+8aOcTlMAqIKzaBgjTHfrMjhvcRcLqk74znHU
         43mIfN9U7ApzSmS8YInEk7oFSpxMk6n2N3M2A7E/uvIcnooRVBeCjy2gKFFkLVUiv0mG
         0e+iOednETVeAeuOWXWA3KRU18ptpXvyJFH5ZTjfz6JhEVAzmGqtn2Z4jIuQazrX8fV3
         EfKRlhWv2HSmyhbH25P3pahMNjY+c/HTelD6JC+homZ5G6mdrwGgK+6wrBMred9NCHdM
         CfLg==
X-Gm-Message-State: AC+VfDzk9AtPHzUgkB6d4PKsV2kZXV+dlVbwvhFsGOXdkuggiSHES2Ak
        d17TfCT8/PvRL6UBLZWnxGo=
X-Google-Smtp-Source: ACHHUZ7mTLdh7Av90znwfta5PHJDraIwi2lq/a1/0UxCzBCWfwDKpJ8dEBq126g+Wle4n2oXjPdsAg==
X-Received: by 2002:ac2:5d67:0:b0:4ef:ed49:fcc2 with SMTP id h7-20020ac25d67000000b004efed49fcc2mr1937613lft.26.1683753327073;
        Wed, 10 May 2023 14:15:27 -0700 (PDT)
Received: from [100.119.7.139] (95-31-186-150.broadband.corbina.ru. [95.31.186.150])
        by smtp.gmail.com with ESMTPSA id k12-20020a2ea28c000000b002ab4c9c1514sm2167665lja.41.2023.05.10.14.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:15:26 -0700 (PDT)
Message-ID: <c16f87f8182bdb0a0fe89014e56a32758248baeb.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ftgmac100: convert to yaml
 version from txt
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Thu, 11 May 2023 00:15:24 +0000
In-Reply-To: <ec0a3553-2c11-301e-d838-f0bc70353b17@linaro.org>
References: <20230509143504.30382-1-fr0st61te@gmail.com>
         <20230509143504.30382-6-fr0st61te@gmail.com>
         <ec0a3553-2c11-301e-d838-f0bc70353b17@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-10 at 16:50 +0200, Krzysztof Kozlowski wrote:
> On 09/05/2023 16:35, Ivan Mikhaylov wrote:
> > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
>=20
> Need some commit msg.
>=20
>=20
> > ---
> > =C2=A0.../bindings/net/faraday,ftgmac100.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 110
> > ++++++++++++++++++
>=20
> Missing actual conversion (removal).
>=20
> > =C2=A01 file changed, 110 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > new file mode 100644
> > index 000000000000..98cd142f74bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> Dual-license, unless you copied some chunks of old binding... but was
> there old binding?

Krzysztof, I copied a lot from old one ftgmac100.txt.

>=20
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Faraday Technology FTGMAC100 gigabit ethernet controller
> > +
> > +allOf:
> > +=C2=A0 - $ref: "ethernet-controller.yaml#"
>=20
> Drop quotes.
>=20
>=20
> > +
> > +maintainers:
> > +=C2=A0 - Po-Yu Chuang <ratbert@faraday-tech.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: faraday,ftgmac100
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - aspeed,ast2400-mac
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - aspeed,ast2500-mac
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - aspeed,ast2600-mac
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: farada=
y,ftgmac100
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In accordance with the generic clock bi=
ndings.
>=20
> Drop this part. Obvious.
>=20
> > =C2=A0Must describe the MAC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IP clock, and optionally an RMII RCLK g=
ate for the
> > AST2500/AST2600. The
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required MAC clock must be the first ce=
ll.
>=20
> The cells depend on clock provider. Do you mean something else?

It's exactly from ftgmac100.txt, this section without any changes, I
didn't add anything new in the sentence.

>=20
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > +
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - MACCLK
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - RCLK
>=20
> This does not allow two clocks... List all the items and add
> minItems: 1.
>=20
>=20
> > +
> > +=C2=A0 phy-mode:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rgmii
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rmii
> > +
> > +=C2=A0 phy-handle: true
> > +
> > +=C2=A0 use-ncsi:
> > +=C2=A0=C2=A0=C2=A0 description: |
>=20
> Do not need '|' unless you need to preserve formatting.
>=20
> I will stop review, because it depends whether this is true
> conversion
> or new binding.
>=20

I've tried to convert it from ftgmac100.txt, everything is same in it
except mac-address-increment option with explanation for which purpose
it there, need I divide conversion from that option or is it fine in
one?

Thanks.
