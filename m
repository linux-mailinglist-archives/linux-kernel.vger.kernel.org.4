Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EC6EC9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjDXKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDXKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:08:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D29B;
        Mon, 24 Apr 2023 03:08:38 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2F41C1C0008;
        Mon, 24 Apr 2023 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682330917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSjwAVriP8NSs8GDNrCwBt3GMm7ESSx/o2pcAH83Wi0=;
        b=jNylB+SqKQYfJS2hb3gYwyPEocjggyM16Bfv/d4AZBhLmzCFEcDtoc9Iz5zL2NdSx7YQep
        gOnNcZJ2QrHBUtGkLwbVBPBCHCaHPDKAzYspMqdFfl5hQoXCWaOzrb/n2GXotWRHfEqpF3
        IlE0+ZTmviM1GkojNcCvxzGOKDD5YoALxvPnf6QDaUalvsyg8Pe5aQOqgt90obBlCO98M+
        dF6/nX0hHMn3Jg5q8QfYl1auoNNRUD0rfMnlNry/tbGD6jPS+8DTlUgp/QBjOdbGY8v1Zg
        EEbdRNktcpRM7/cso5gMwKCEqnXlNU8YxbnWDzWnaUDVBh1fpPggIoK64yIjJg==
Date:   Mon, 24 Apr 2023 12:08:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/43] dt-bindings: rtc: add DT bindings for Cirrus EP93xx
Message-ID: <2023042410083435b9b09b@mail.local>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-8-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-8-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 15:34:23+0300, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> RTC block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/rtc/cirrus,ep93xx-rtc.yaml       | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> new file mode 100644
> index 000000000000..d4774e984e7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml

I guess this one should go in .Documentation/devicetree/bindings/rtc/trivial-rtc.yaml?

> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/cirrus,ep93xx-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx Real Time Clock controller
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc0: rtc@80920000 {
> +        compatible = "cirrus,ep9301-rtc";
> +        reg = <0x80920000 0x100>;
> +    };
> +
> -- 
> 2.39.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
