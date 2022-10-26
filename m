Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF660E36D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiJZOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiJZOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:34:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BFE08A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:34:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r19so10006595qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aue1n5CdddDvk+uG+qHnNwSRlkDsHeAwN2g8IgZTjZc=;
        b=ZpdLrONk4T6DRMobcv1MM1zbz53uAK5KlJ8hgYZAUAJvkLvs4p6HTb9Vjl7PS72DnZ
         QkzWf0/9/43kJ5xqNpPlMdGbeMnd57IUjvglfjgrPoXwsXv/4OeF3mJ3XkqXFi0KxGS+
         A+tMkaNxlmLYrkZuf1wEYuFoKFa9dSn1ugeKoDBO8Wrpz0ijxgm34ejLn+yrwnKvSbyb
         Bng7/dtj+ITU0xggXXST+qFO4YQ1ft4FBxYZ9Hl9O0oY08Lp2ptdruM2T/ZIuRLLcL8J
         MUwW7+WZlhkQP5QR6n7EqeqCK/F3CTVRRUuUUkSr014OsGYPC6/qm8Lp8HA1/6neaeWA
         OnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aue1n5CdddDvk+uG+qHnNwSRlkDsHeAwN2g8IgZTjZc=;
        b=EyqZWiJkOSYdGgJqHS9fx9BuWwgsYFbNvv3UkDArU7RSB9gYYzQytuCMfwKxPHbydU
         rU/MqT2GLI4DYpgQVj2meE6UNDgokCYXxS7jKZiDi5fKSpbGMYbN+wRq/tGQGjOuyB3I
         ewdEA9azBwp3n/tDyERzrvQj4Us6BSSRM/7aDQsdqvH/Qr8osK1Q9K1JoDADGfxPT0nz
         MEpMYqnVKEWJFjJO2Sn87Lmci8E55MbK8SfISspSNuiTH46GgY+6mZ04LtUJ3s5F5Ekp
         KuUfgTjqch+Egxbkx5/2mRsOGkAaHr1yFB4EfLHJSc1rJF/mK/QCeU3qkB3eklzjmlKw
         /X4w==
X-Gm-Message-State: ACrzQf0oXQAtJRadw6FljjtUhdic6aQcyGJAmxy4yHKaZGY9RQ+hEKBa
        xsqCg6q9/hAs4UvT/4mKOghaMA==
X-Google-Smtp-Source: AMsMyM7c1sgYx5YIZenvo5DDl/wD/h249LQ6L6+sQqdnyE+pVe7N1cKfoDBZBVAAPrt8rMe2PLHswA==
X-Received: by 2002:ac8:5849:0:b0:39a:8e35:1bfa with SMTP id h9-20020ac85849000000b0039a8e351bfamr36305054qth.573.1666794879194;
        Wed, 26 Oct 2022 07:34:39 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a269b00b006ee7923c187sm4013390qkp.42.2022.10.26.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:34:38 -0700 (PDT)
Message-ID: <7ceca209-9361-e811-8fe0-282639f9e967@linaro.org>
Date:   Wed, 26 Oct 2022 10:34:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] dt-bindings: net: snps,dwmac: Document queue config
 subnodes
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221021171055.85888-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021171055.85888-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 13:10, Sebastian Reichel wrote:
> The queue configuration is referenced by snps,mtl-rx-config and
> snps,mtl-tx-config. Most in-tree DTs put the referenced object
> as child node of the dwmac node.
> 
> This adds proper description for this setup, which has the
> advantage of properly making sure only known properties are
> used.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 154 ++++++++++++------
>  1 file changed, 108 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 13b984076af5..0bf6112cec2f 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -167,56 +167,118 @@ properties:
>    snps,mtl-rx-config:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> -      Multiple RX Queues parameters. Phandle to a node that can
> -      contain the following properties
> -        * snps,rx-queues-to-use, number of RX queues to be used in the
> -          driver
> -        * Choose one of these RX scheduling algorithms
> -          * snps,rx-sched-sp, Strict priority
> -          * snps,rx-sched-wsp, Weighted Strict priority
> -        * For each RX queue
> -          * Choose one of these modes
> -            * snps,dcb-algorithm, Queue to be enabled as DCB
> -            * snps,avb-algorithm, Queue to be enabled as AVB
> -          * snps,map-to-dma-channel, Channel to map
> -          * Specifiy specific packet routing
> -            * snps,route-avcp, AV Untagged Control packets
> -            * snps,route-ptp, PTP Packets
> -            * snps,route-dcbcp, DCB Control Packets
> -            * snps,route-up, Untagged Packets
> -            * snps,route-multi-broad, Multicast & Broadcast Packets
> -          * snps,priority, bitmask of the tagged frames priorities assigned to
> -            the queue
> +      Multiple RX Queues parameters. Phandle to a node that
> +      implements the 'rx-queues-config' object described in
> +      this binding.
> +
> +  rx-queues-config:
> +    type: object
> +    properties:
> +      snps,rx-queues-to-use:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of RX queues to be used in the driver
> +      snps,rx-sched-sp:
> +        type: boolean
> +        description: Strict priority
> +      snps,rx-sched-wsp:
> +        type: boolean
> +        description: Weighted Strict priority
> +    patternProperties:
> +      "^queue[0-9]$":
> +        description: Each subnode represents a queue.
> +        type: object
> +        properties:
> +          snps,dcb-algorithm:
> +            type: boolean
> +            description: Queue to be enabled as DCB
> +          snps,avb-algorithm:
> +            type: boolean
> +            description: Queue to be enabled as AVB
> +          snps,map-to-dma-channel:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: DMA channel id to map
> +          snps,route-avcp:
> +            type: boolean
> +            description: AV Untagged Control packets
> +          snps,route-ptp:
> +            type: boolean
> +            description: PTP Packets
> +          snps,route-dcbcp:
> +            type: boolean
> +            description: DCB Control Packets
> +          snps,route-up:
> +            type: boolean
> +            description: Untagged Packets
> +          snps,route-multi-broad:
> +            type: boolean
> +            description: Multicast & Broadcast Packets
> +          snps,priority:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: Bitmask of the tagged frames priorities assigned to the queue

If we are not going to fix it, at least let's improve the constraints,
so add allOf:if:then here (with proper indentation) which disallows
mixing mutually exclusive properties.
Here's example:
https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml#L155

Best regards,
Krzysztof

