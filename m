Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA72700509
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjELKPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbjELKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:15:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD7106CC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:14:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f42c865535so41932545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683886494; x=1686478494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHnhA3bsFZjXjI2KBvdNTkEA6cTI4PkTEh92A9BH1zM=;
        b=S8PGo4cc5Tz3LuPdUzGu4UWFwpneiq8+NePyuExEpbZppz9MgmNbLXYf33dvKz0YLo
         d4/qmKqyLjzw6a3BU2WKQvlqXn4gifQN24rDWez4wTBHJ2tapij7WUx7/4cvj6mF/M5b
         ZB532RByd26rQWs4+HeLmm2+QloO6j/7mklzHVfrD4m+iRGkphjlUfGTX/bTlDqAZwwp
         2ao3ae5gelXdnq99DEPoH2kEqq7TGn38vRmQprgTbA87YYp/8JoiwvleLwhOcvKQBy6O
         j/godrhrygCcvOf8aX0UW2wMgNx4vQr0eOin1sGzJ07L7h+HnHohC8jMDV0Mve0tQ0MQ
         LjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886494; x=1686478494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHnhA3bsFZjXjI2KBvdNTkEA6cTI4PkTEh92A9BH1zM=;
        b=I0GjvSMIJGbVDPLdFZixxyHiozUu1f4zuFI3JhBGMz/E+dp1/5bXbSsXW6GDOB60Ay
         0tW+V1+YZ9hTVsJeVH3v+ZCslvXBTwz4BWuvKWWMEL51G+rA/r6i0o+Kvi9r0CcRbIkY
         I4RfQ4FeV4gA6dVWJIW+3mLFF/Ufw12q35UY4aGBwBBj6s/Etsg5NU5CSCkp/CxZRMBV
         zxti5xWRgfDpm/cg+HrJ8UCo/CuBl76crA/hc60O7OMrHwTnEwoyDKs7rYJEnZVbpSTi
         c4PXOB4TvotLKUTGU0DF1grlLFGNhS4Soz9SY85KhYXWUD6Pho1V+ge9NEI9YhvJI2Ye
         JKvg==
X-Gm-Message-State: AC+VfDxwB8OaWbNtrzrD7DKZxswSCisvQv8SW2FhrB3/2PFgRX0pCBVT
        UrzXkgL3lB4/R683Za7lgEngEw==
X-Google-Smtp-Source: ACHHUZ6SwFMkMNcp6yW+rNENGPX7CBBWtFxzW+G296zfPURSmofZ5GhZUA/Pxczsz5Ob23whxcz/rA==
X-Received: by 2002:a05:6000:1191:b0:306:462a:b78d with SMTP id g17-20020a056000119100b00306462ab78dmr15388534wrx.53.1683886494530;
        Fri, 12 May 2023 03:14:54 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h8-20020a1ccc08000000b003f17eaae2c9sm28317794wmb.1.2023.05.12.03.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:14:53 -0700 (PDT)
Message-ID: <68aa0f6d-db89-8e01-264d-95d3839fb648@linaro.org>
Date:   Fri, 12 May 2023 11:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/3] dt-bindings: nvmem: brcm,nvram: add
 #nvmem-cell-cells for MACs
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
References: <20230421084312.27932-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230421084312.27932-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2023 09:43, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom's NVRAM contains MACs for Ethernet interfaces. Those MACs are
> usually base addresses that are also used for calculating other MACs.
> 
> For example if a router vendor decided to use gmac0 it most likely
> programmed NVRAM of each unit with a proper "et0macaddr" value. That is
> a base.
> 
> Ethernet interface is usually connected to switch port. Switch usually
> includes few LAN ports and a WAN port. MAC of WAN port gets calculated
> as relative address to the interface one. Offset varies depending on
> device model.
> 
> Wireless MACs may also need to be calculated using relevant offsets.
> 
> To support all those scenarios let MAC NVMEM cells be referenced with an
> index specifying MAC offset. Disallow additionalProperties while at it.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied thanks,

--srini
> V2: Add additionalProperties: false
> ---
>   .../devicetree/bindings/nvmem/brcm,nvram.yaml     | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 36def7128fca..13412af7f046 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -36,14 +36,29 @@ properties:
>     et0macaddr:
>       type: object
>       description: First Ethernet interface's MAC address
> +    properties:
> +      "#nvmem-cell-cells":
> +        description: The first argument is a MAC address offset.
> +        const: 1
> +    additionalProperties: false
>   
>     et1macaddr:
>       type: object
>       description: Second Ethernet interface's MAC address
> +    properties:
> +      "#nvmem-cell-cells":
> +        description: The first argument is a MAC address offset.
> +        const: 1
> +    additionalProperties: false
>   
>     et2macaddr:
>       type: object
>       description: Third Ethernet interface's MAC address
> +    properties:
> +      "#nvmem-cell-cells":
> +        description: The first argument is a MAC address offset.
> +        const: 1
> +    additionalProperties: false
>   
>   unevaluatedProperties: false
>   
