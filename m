Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3860BAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiJXUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiJXUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:42:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C95B1B83;
        Mon, 24 Oct 2022 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rxB2FjaZ9ZC5MOe8rAcEH+DbpA4H6kqr69ZwAxYWy3w=; b=2SpxXp+WJxWYA+TqzODzh8lOqr
        qmj9cDaJSvrb7PleUO7oOYPnoUNim0LDb8BgOUadHv+4kQUSr3ZgtaJ7O25Ws4hjyTOz+G1qJt+M8
        wWzCteWwy70L8CMrulJUPpUNt6UpWFEbcKGlhrFaqeYwgz5ITqEuUb767QmUjdpcvIwUCnegfIk5M
        5IgIIyvuF/CAktILfPovYkzUrx/INUq2G6G4U4rZz6oh8NBxssQjakU1yVHMyTR8fgLrLxKUrVMrO
        BASBlGQPKI8+6N34iDiGnwJSLZptb7tGfWPEugWeGKJUXjDPPPj9PoySdzwZ93YHHblk/uJM6bjme
        kIi5JJuQ==;
Received: from p200300ccff06c5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:c500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1on1Oe-0003lA-1x; Mon, 24 Oct 2022 19:37:56 +0200
Date:   Mon, 24 Oct 2022 19:37:54 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alistair23@gmail.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, shawnguo@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/4] dt-bindings: input: Add Cypress TT2100
 touchscreen controller
Message-ID: <20221024193754.2c3163fa@aktux>
In-Reply-To: <20221024111017.43859-3-alistair@alistair23.me>
References: <20221024111017.43859-1-alistair@alistair23.me>
        <20221024111017.43859-3-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this should go in, I am tired of carrying it around...
to make the bot happy, the following things need to be changed.

On Mon, 24 Oct 2022 21:10:15 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> new file mode 100644
> index 000000000000..0913b585af5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cypress TT2100 touchscreen controller
> +
TT21000

> +description: The Cypress TT2100 series (also known as "CYTTSP5" after
TT21000 (also in the subject)

> +  the marketing name Cypress TrueTouch Standard Product series 5).
> +
> +maintainers:
> +  - Alistair Francis <alistair@alistair23.me>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: cypress,tt21000
> +
> +  reg:
> +    maxItems: 1
> +

'#address-cells':
  const: 1

'#size-cells':
  const: 0


> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator for voltage.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  linux,keycodes:
> +    description: EV_ABS specific event code generated by the axis.
> +
> +patternProperties:
> +  "^button@[0-9]+$":
> +    type: object
> +    $ref: input.yaml#
$ref: ../input.yaml#


Regards,
Andreas

