Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB6708E16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjESDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjESDA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:00:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB43E7F;
        Thu, 18 May 2023 20:00:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 854FC32002E8;
        Thu, 18 May 2023 23:00:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 18 May 2023 23:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684465253; x=1684551653; bh=+qkxtfKU3Ynscb5yTikTTXCK9eZg6WEQh+t
        MM6/33d8=; b=hNWz0p1gsuo5wONFgBckUAcIho7GfZrE5+H0IqTXKpkLXNmiXg/
        fBQwxLLRH6UK9gslUDTcoZ60E9fm1OdwRa25dQpyoFX9o1gEhngWhhHI+ad27Gk4
        4sWeYQBzKuLOweH6p/V+ccb+p/zzXPuQ3+uS6sutSXFVSaPFV78U6ICT+G5g5Z1E
        LfZ5IJUENUzfJwX+fWANj6+gI3efJEmZ+QXEVuNTRSQXePsXbkIi9DJzRa9MmSMu
        mup3UfXsSPQSN9R1nlc7Ucs6dZ8Iu+6SpiiS4ylPTggd8jIx8qgj6+Cn1u8G35zS
        PPL6yZm1pZlR5aOpTcLi8v+ZqLY/zKelrGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684465253; x=1684551653; bh=+qkxtfKU3Ynscb5yTikTTXCK9eZg6WEQh+t
        MM6/33d8=; b=y+wOYQT/ANu5AMZI7Fl7sytCChsbyLHXQZskBSHM+zPR31YTDAP
        wITvMOv3uSzbrFZnBkrBw2Q3XNc24IU0pGzNY2tsNxBuYZ5oBoky2EX9P+m7362E
        IqeHt7pfYsbIsHB9dOKDsRaseksKJflR/1CW2Lj+hzySt6NY0fOOjZ6FtCAXo26P
        0AcGHJVLh9raTYsEobXB1kS4ppVZsBC7Zy5cPwWfsgrUzz37epGF8hbfZDXC9krg
        ZuV4pctGXKK2yjPMk05QS168YGSLyxfI/TojIU9KCAvVoWvE/ggBxObIeyRShKX3
        CYdqR9LnOGuts8W/dxAP46qq11tuF/Jhdcw==
X-ME-Sender: <xms:ZOZmZP7okI05FPgBNxXSElrXSmzWnIzfB6J3_X0ASFryZ8KuVCvJcg>
    <xme:ZOZmZE6EJc66H8piJOvZf61pIt8hLG_7B3Pt-nY73wm4AgJj48phpJntT4D0HqsFZ
    norrXmOms0tTbb_-g>
X-ME-Received: <xmr:ZOZmZGfBHw7C4zXn6g9n_7E17Pc_4pyg5aRqvoEznI5IUYWuc0YzK08dQhAsq1sGGHSl_hbKmwi00WwYed1ELMf8I0WQ83ctaKzaImhc_jsMjrDnlpgA_lfutw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegteekvefhgefhgfeigeejffejvdeihedvfefgtedvjeeiudet
    teeihfffgfeugfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehs
    hhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ZOZmZAJPH212OL9KuUHe8uBw8xWju1lsBQ-I-_q16E0UCK8YQys9NA>
    <xmx:ZOZmZDI0bGVDsyfwER1gYIxWT5xzG04GIuI93_KbNqNAEpjMkeNerw>
    <xmx:ZOZmZJzB9WCu14F4hnGLNBPBhf9vD6EocjdorOM-wTnnN-jK_rlFfw>
    <xmx:ZeZmZFhKjwHAij4VV7saGI05qHbueuiZ4SsiWx94x4hOoWuhPatYtQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 23:00:50 -0400 (EDT)
Message-ID: <b5869cb0-1eab-4ab7-6dd7-16b06f91d93f@sholland.org>
Date:   Thu, 18 May 2023 22:00:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-4-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
In-Reply-To: <20230518152244.2178-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 5/18/23 10:22, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../serial/bouffalolab,bl808-uart.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> new file mode 100644
> index 000000000000..0ef858e50efb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#
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

This is not complete. There are separate APB and module (baud) clocks,
as well as a peripheral reset line. If we are going to keep the binding
stable, these need to be described up front.

(I still don't fully understand the clock tree, and so far that has been
the main blocker for me sending a follow-up series with additional
bindings for hardware that's otherwise already supported, like the
Ethernet MAC.)

Regards,
Samuel

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
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

