Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3663CED3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiK3FpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiK3FpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:45:10 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE311EADC;
        Tue, 29 Nov 2022 21:45:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 753073200904;
        Wed, 30 Nov 2022 00:45:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Nov 2022 00:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669787105; x=
        1669873505; bh=LkZuJhoFPALKZewfNv71Q2bTIVj19V0FYRHh96YSopA=; b=V
        b14HqnKNhghBeiSxGLwAxdjwLwPaUu1p/bYwm5hqd0cfIH83Fn4xckngJMp2AoJb
        /wZ1UTRAJ3cLMhfrhSpBz0HK6q84comT/SQu0b8oAXd5UAOvnl+H3sTBfFGg7Gpf
        d+2PcsALD3uC25R7iYve+aekl1e0Cxo8sj4uLXTKbj9ewbA/3C98Et/vA++ZOb2/
        1wJOyfuNjw3w+hzqpbgYHamUsvjOD6L4FSA/tmsCfbHI2bo/aTu4wePVkvVcY9UX
        yLhB5Xk3RbvX18+HG/WCnij6OgJuYa6U6EXJzzu2uZGcvUjR/hjQVEqEpYgbI6gC
        usdBbHg8odzIRHy43YkNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669787105; x=
        1669873505; bh=LkZuJhoFPALKZewfNv71Q2bTIVj19V0FYRHh96YSopA=; b=k
        wGiPT9yBN5R0ELE4mGlBKh4ypOq5HHBkngvvtP8Eb0QCsEeDidhwaG/9yOFitZ7X
        BfI/eXk8BlZyEr3zokiheY2NzH/m1CwOUJ/YpT86iR4AalQ6mqgQ+NuwX1mCZ6Wa
        EDCpo00ORWsIHS6aEsG4XTcbZXhvZP9HcwU/r0zC6V1RaRX5KZzOHRGU3Q+7O678
        7X8ptn3H3Wnr8EKbrYvIIDwOuNUCKeJPVkGTgBF0IdaQG25Spb1tR2BynU5dXv2s
        OMFnrkFHRqGtNovf6KtDfjf1jF4doQhdEmsMMKADa1xjDtKQazTACP5HqDAwPz6w
        JdDhSOWlFl3gPryVk31HQ==
X-ME-Sender: <xms:3-2GY4LfYbXANE94B4-b3M6xbVSF1n52BB5Uq3CssrNTRHjASw5-yA>
    <xme:3-2GY4ISSTk5zdS7G30qZmANE49qtUrkOCt_tf1Sa-4PWtHRR6bzC7p6QupT-cX24
    Pb3Nf7g0MhmEN3IRQ>
X-ME-Received: <xmr:3-2GY4sF9s3ko5Bvsdv3gi0PAVIk8IS8XguHMxweVh8LrSCsxwPUfoAZ-mo81iNWsXBRbKnvKmiqDKg9K8z3hcVLip1ruI7f2He3X-YMIdRNLwN7m1wTWrfchw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhvfevfhfujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptefghfelffeiueetjefhteektddvkedttdetleevlefhhefgkeeu
    gfekieduleejnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4O2GY1aqwqVKHzbN5zqeT9yy2cfQkK0xDGWSy_nMy6UetU53rqBBfA>
    <xmx:4O2GY_aOd1BaVEmTOjzsBq-Uqj82iwuRJMJmyvkJ_3ZlMLJ9hNKj0g>
    <xmx:4O2GYxB_B017LvgwjXTIDi_gHFOA6FNfzbsiKytdums5foyMQMaMpQ>
    <xmx:4e2GYzSNNOMBxGZ921_CrEzbqHkcYhfJnbvqT-QqVLZ9m8y7lR2s4A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 00:45:01 -0500 (EST)
Message-ID: <eee2d11d-a3b3-41d7-5f51-02294d5ee2cc@sholland.org>
Date:   Tue, 29 Nov 2022 23:45:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Samuel Holland <samuel@sholland.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-2-jszhang@kernel.org>
Content-Language: en-US
Subject: Re: [PATCH v2 1/9] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
In-Reply-To: <20221127132448.4034-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 07:24, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/serial/bouffalolab,uart.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> new file mode 100644
> index 000000000000..a8293444ca31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalolab UART Controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: bouffalolab,bl808-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

There is also a reset control for this peripheral (in the GLB registers
at GLB_SWRST_S1A0).

And since you set additionalProperties, I believe you need to add the
DMA channel properties here as well.

Regards,
Samuel

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    uart0: serial@30002000 {
> +        compatible = "bouffalolab,bl808-uart";
> +        reg = <0x30002000 0x1000>;
> +        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&xtal>;
> +    };
> +...
