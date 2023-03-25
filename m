Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13506C8D20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCYKhY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Mar 2023 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 06:37:22 -0400
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7A769C;
        Sat, 25 Mar 2023 03:37:20 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pg1Gt-00019P-Bl; Sat, 25 Mar 2023 11:37:15 +0100
Message-ID: <f91b463f52a3ce3002212b429350f592a0131042.camel@apitzsch.eu>
Subject: Re: [PATCH 1/2] dt-bindings: input: atmel,maxtouch: add
 linux,keycodes
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Sat, 25 Mar 2023 11:37:13 +0100
In-Reply-To: <20230227205035.18551-1-git@apitzsch.eu>
References: <20230227205035.18551-1-git@apitzsch.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 27.02.2023 um 21:50 +0100 schrieb André Apitzsch:
> In some configurations the touch controller can support the touch keys.
> Document the linux,keycodes property that enables those keys and
> specifies the keycodes that should be used to report the key events.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../devicetree/bindings/input/atmel,maxtouch.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> index 3ec579d63570..c40799355ed7 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> @@ -14,6 +14,9 @@ description: |
>    Atmel maXTouch touchscreen or touchpads such as the mXT244
>    and similar devices.
>  
> +allOf:
> +  - $ref: input.yaml#
> +
>  properties:
>    compatible:
>      const: atmel,maxtouch
> @@ -60,6 +63,10 @@ properties:
>        or experiment to determine which bit corresponds to which input. Use
>        KEY_RESERVED for unused padding values.
>  
> +  linux,keycodes:
> +    minItems: 1
> +    maxItems: 8
> +
>    atmel,wakeup-method:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
> 
> base-commit: 982818426a0ffaf93b0621826ed39a84be3d7d62

Hi Nick, hi Dmitry,

Friendly ping.

What is missing to get this up-streamed?

Best regards,
André
