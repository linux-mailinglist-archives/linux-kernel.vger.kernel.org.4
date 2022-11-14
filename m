Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823DF6276CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiKNHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiKNHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:53:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173F1A04D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s8so824479lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPteRXuurrYIqWrse9JwxLjzfWbyyHOFXx8cvgeh7xI=;
        b=RbpQb7sW542HdgS4M2H8DTDHsg3T3PRosLUxU5N5G7BQU4oBb+axXvDmDDLLiVQRYg
         BTwR98kQW7n6JuXEBKN5cxk1srrQW3yrFmVdslAWHN2zWtwd6zo/7558lfHWTCJ7C9kW
         JBd1p9HA08p4EJwZIEax9c1/cGR+BNCOOTNUm+tZhoXhUWu/8vJRzsGTe4bzbGUsViWP
         4yWEsMzdddtTYwR0NdUe/QKHdEVwiRPtzVKqHkwmP3w+/v+tSe8Fs7PjHE+DCqFQYHPc
         HuEBULhWe/jOd/2gM1HclbjFR8A/kPlPcJ9d+2KSX8wGh32m3xuSPgLy/39gVIpvf+Qg
         mNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPteRXuurrYIqWrse9JwxLjzfWbyyHOFXx8cvgeh7xI=;
        b=yhtdlEjU/MQ8CtYrVBAm2sQhdr70nk1A6QJhOHTePV3esLtMzAddfYdhfN0Zt8JIvs
         8cNOvbsvEWal2ha0u5nTSKVotby0Z6qcAIkEEqg7pLExQEEnFPHcrC08E6eCMjuOvVbT
         JiSGmIr4hkBarVMKuuUnW91IypOa56ML8/dmCddERgVMML6Y80mepbeK4smGUAwAbv46
         KxZoIWRFxlIEh1R+EKSI10OX85OT5Yalz9vcFyRJtCPXmQCVe+RjYHVvx/nzq+75QgCB
         n1qK03cBsTmIbcSPXRpph3dP0vva8NgZMuAViFfsTwWSLS5Cje6k0ZE+YVbCEh9jUCY9
         RbfQ==
X-Gm-Message-State: ANoB5plnVMNBTS94naHYUFLRilPblUdh9mS/jYHxHw5CNH44EsWhIDgK
        JBwaY0pCfOMxA/Qz2hfWgpacUw==
X-Google-Smtp-Source: AA0mqf4OBoAylXtT0sBiy8jHQ+/GQteJ4T/mfs0zyPgj4RG4qH2mkmcXLXi4oSRxCmQCriiQPyBeAA==
X-Received: by 2002:a05:6512:308:b0:4aa:8cd:5495 with SMTP id t8-20020a056512030800b004aa08cd5495mr3446242lfp.254.1668412397911;
        Sun, 13 Nov 2022 23:53:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u3-20020ac25183000000b004ae394b6a6fsm1709573lfi.246.2022.11.13.23.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:53:17 -0800 (PST)
Message-ID: <fa9255f1-d083-936f-e402-61873e582882@linaro.org>
Date:   Mon, 14 Nov 2022 08:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: rockchip: Add SOQuartz Blade
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
 <20221112160404.70868-6-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112160404.70868-6-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 17:04, Nicolas Frattaroli wrote:

You miss commit msg.

> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 244c42eaae8c..fc5f14fcd007 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -579,6 +579,7 @@ properties:
>          items:
>            - enum:
>                - pine64,soquartz-cm4io
> +              - pine64,soquartz-blade

Keep alphabetical order,


Best regards,
Krzysztof

