Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130869FB03
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBVSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBVSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:30:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEEF3C7BF;
        Wed, 22 Feb 2023 10:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0270B81233;
        Wed, 22 Feb 2023 18:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7B6C433EF;
        Wed, 22 Feb 2023 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677090637;
        bh=JnUZuH1esjrp1GlU9kN3wYCVcbLioydsVEkddTaeMXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fRg/4GZ9KB2rS2K0VHFITqEinzX0LuqhZ1sVveL/g9D/IJaLoMLxJG3AY0R8V5Neu
         eM6ug9NRvSvRCtgGcKNS4jtDE2ZyAGu42vKfq8Zd59KC8J1MgRocKjmY74q0/HWuOo
         3qyu1ZCszdAJOf0NSmKp+VSBlGdSj/qSLRBQIasg3QtVrcwBykgOep9+Oty2I9+AUb
         zwcS4lJ0W20t1trvUJdtJS6DMhkm65rC59pRzs7w2IOhMfyOMPtTsf+lazPf0PvVF0
         icFi4czUiIA19Fqy2W6fy+qpyTj7YEAvraz3Bde9NhVvW2cAxJ4lbbhtcOcM5/j3Zv
         6xm19U4BTD7gA==
Message-ID: <76bc79c9-a892-c43e-1f49-d07b54f52c90@kernel.org>
Date:   Wed, 22 Feb 2023 19:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] dt-bindings: display: Add Loongson display controller
Content-Language: en-US
To:     suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230222165514.684729-1-suijingfeng@loongson.cn>
 <20230222165514.684729-2-suijingfeng@loongson.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230222165514.684729-2-suijingfeng@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 17:55, suijingfeng wrote:
> This patch add a trival DT usages for loongson display controller found
> in LS2k1000 SoC.

Trivial yet so many things to improve... if you only started from recent
kernel tree (since you Cced wrong address, I doubt you did) and bindings
you would avoid half of these comments.

> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> new file mode 100644
> index 000000000000..98b78f449a80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml

Filename based on compatible, so "loongson,ls2k1000-dc.yaml"

> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson Display Controller Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Sui Jingfeng <suijingfeng@loongson.cn>
> +
> +description: |+

Drop |+

> +

No need for blank line. Do you see it anywhere else in the bindings?

> +  The display controller is a PCI device, it has two display pipe.
> +  For the DC in LS2K1000 each way has a DVO output interface which
> +  provide RGB888 signals, vertical & horizontal synchronisations
> +  and the pixel clock. Each CRTC is able to support 1920x1080@60Hz,
> +  the maximum resolution is 2048x2048 according to the hardware spec.
> +
> +properties:
> +  $nodename:
> +    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"

Drop nodename.

> +
> +  compatible:
> +    oneOf:

Drop oneOf

> +      - items:

and items...

> +          - enum:
> +              - loongson,ls2k1000-dc
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +

Drop blank line.

> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <2>;

Why do you need interrupt-cells?

> +
> +        display-controller@6,0 {
> +            compatible = "loongson,ls2k1000-dc";
> +            reg = <0x3000 0x0 0x0 0x0 0x0>;> +            interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +
> +...

Best regards,
Krzysztof

