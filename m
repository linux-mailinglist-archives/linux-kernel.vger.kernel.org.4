Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23168738D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjFURsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFURr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:47:59 -0400
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE621726
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:47:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687369676; x=1687628876;
        bh=8wOHeVh8ASp47LbruLjcoxPj0RWoySUx98rYNUG5rns=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SYii8ho0XGyfqCNuwG/oM+9hEVubfi+O/ds5Uo160ej92Hj0GASJshaRdzDWPvi8n
         O1B8jG8XXWN2awTZbZlWhAvYPKt0t654Se5EEQoessoAA/prD8Rxc+x5CO29ihKxEJ
         /JxglePMyzNecSRfqUn7DFgqFNduVasE/c6JSO824p9UdeKHn4e87Jv7Y2S97+Jk8y
         ESR0FH9eFK7L2cNngnt3zLVmBdwkv2MqHpCMbwS5kNfm+374i97iSO3btn9q9zdBAi
         juplSdmMY4dbvNqcIrUWl+x/KzCtDxZfvx3JT4zYfW8CVVxHr1q9To2t4H+zkR9IvI
         3qVxCO/cnoBxA==
To:     lee@kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        luca@z3ntu.xyz, pavel@ucw.cz, raymondhackley@protonmail.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033 compatible
Message-ID: <20230621174735.1161-1-raymondhackley@protonmail.com>
In-Reply-To: <20230621150141.GE10378@google.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com> <20230602131009.260239-1-raymondhackley@protonmail.com> <20230621150141.GE10378@google.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wednesday, June 21st, 2023 at 3:01 PM, Lee Jones <lee@kernel.org> wrote:


> On Fri, 02 Jun 2023, Raymond Hackley wrote:
>=20
> > Add devicetree binding for Richtek RT5033 Flash LED charge pump used fo=
r
> > camera flash LEDs.
> >=20
> > Signed-off-by: Raymond Hackley raymondhackley@protonmail.com
> > ---
> > Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
> > 1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b=
/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > index 4d2ffe5fcfc7..37d2a93780ab 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > @@ -20,6 +20,7 @@ properties:
> > compatible:
> > enum:
> > - ocs,ocp8110
> > + - richtek,rt5033-led
>=20
>=20
> Why is "-led" appended on to this one and not the others?
>=20

"richtek,rt5033" has already been taken by a MFD device, and this LED is
a part of rt5033 MFD, so "-led" is appended here.

> > - sgmicro,sgm3140
> >=20
> > enable-gpios:
> > --
> >=20
> > 2.30.2

I tried to configure protonmail not to send encrypted mails.
Hope that it works for you.

Regards,
Raymond

