Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389A0707BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjERIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjERIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0D30D2;
        Thu, 18 May 2023 01:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4296764904;
        Thu, 18 May 2023 08:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD61C433D2;
        Thu, 18 May 2023 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398254;
        bh=bthXTbRdn0p6tWozz2CFQo/ARnZN5zmu2V0n1rsAQ5Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OM5lRlNpkVVzjDFq/sjddkhE/QNh6e4/zqBcwgDRC3xKn2i6gEAaADYvlcb13OJhe
         usNdQnJuXh6m8DUwJ5XYXAI6IrCo+ZyGYMpeO3asBobK0aOfAIBsnzBL0TqecUNbGC
         YWJrMXUntyQQFt5kqLLnn7MfJ+S73I8oYqdLhPoFj78zkA1LSeLnwHuwIKLIJHRz+W
         NI3Jhy6e0/A6OS90DWtTms2SIS3KbtJKUMM5CX1sNnxNXxmviDHtbEcrYITmVprHZW
         N+nCJltmo5TrNZ4+JbDLaxOC1Xtm5Fk2WJHg43Blf1mSSXx4vTqxSA3Gu8+TW6gtT9
         +hbiecR+bVBPg==
Message-ID: <669d7b79-71a6-e1f9-8d7a-71c4b64de28d@kernel.org>
Date:   Thu, 18 May 2023 10:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
Content-Language: en-US
To:     Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230517144144.365631-3-romain.perier@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 16:41, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> SSD20xD RTC driver.
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

A nit, subject: drop second/last, redundant "devicetree bindings
documentation". The "dt-bindings" prefix is already stating that these
are bindings. You actually repeated everything...

> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/rtc/mstar,ssd20xd-rtc.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> new file mode 100644
> index 000000000000..2acd86cce69f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mstar,ssd20xd-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar SSD20xD RTC
> +
> +allOf:
> +  - $ref: rtc.yaml#

This goes just above properties:

> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mstar,ssd20xd-rtc

Why rtc suffix? Can it be anything else?

Missing blank line

> +  reg:
> +    maxItems: 1
> +
> +  start-year: true

Drop

What about interrupt line?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

instead
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    rtc@6800 {
> +        compatible = "mstar,ssd20xd-rtc";
> +        reg = <0x6800 0x200>;
> +    };
> +...

Best regards,
Krzysztof

