Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEE6CD7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjC2KmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjC2KmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:42:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9E2135;
        Wed, 29 Mar 2023 03:41:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso11135916wms.1;
        Wed, 29 Mar 2023 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680086514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC9tkwmc75gH+H4hmPLG9arYbdYTuVC7oSrQJMaQnv4=;
        b=Cc2dmxbQ/7I1964fGShEZ3shF85jMjOc1v14qFyDLTLhqAOSisK8qbpY59K3FmbXGY
         8UkcjrFtVEsov7au6iHkR7dZb/q3OTVkTeqNscYkpePzZaHOl/Edrp9GF1lm2uMe5KMk
         Ye7x6u2c727j7gfKY8HM7MnP+FIQspJXmxjkSsaLSi85BQqOPjc+QlaUhoQxEnG2Qz6y
         fqZCaUmjF+FWoZ1LZCykZvg8l175DTJLZDzOOpJOdHZSMb+L4bsAr717KbuIgx465TNc
         oXF6hY2OWmjXmJ+3LVBLqsbUuLLuchA5k7Hj1WsG/8eSoZIy06u5B//RA6tsoLrRTZKt
         ctXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680086514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC9tkwmc75gH+H4hmPLG9arYbdYTuVC7oSrQJMaQnv4=;
        b=KznW5cFUK2kJZrrruQDsjaPgluj13dP04OhFBQWnk0Ufwtl1JVUIAvEPYNu9DLJVgz
         q9jvT35R3PVFDHNfL002kj/gce+P/D8CbFR4dE3S2O9A7GGE+OuKDq1oxq4vISTsKZRg
         HmiUuZzTP87CDLJjzBnIuOr285M80yesP22jm1d0co5ERW+DT6cIfAsMnwC8PqH4ItCP
         TFGFuqST6/Y4Q0AXtjBUB3McZ8pqv8OyBj7l84r2rvAmN7DQGfQ71QryNRv+Xrxld+i7
         k1M6QxVh+bOX9e/0tqabvTrVM2at6ubGPKvS0O88WK5dEFiDY32RJ+AgreS0bBD3+ucJ
         atUA==
X-Gm-Message-State: AO0yUKWcDjhT3boip3cLhPqcz8CLPgT2QoHOKQh+Ih4mukphljvATn2e
        aIXbZpkrJbs+9jrBj0ZD2O4=
X-Google-Smtp-Source: AK7set9MejkHT15VJJ8MLManRzjpXvMRuJPfIzaBWi3Mz4d8r2iGuZRrpmASD5IG5FD1prYen7xdxw==
X-Received: by 2002:a05:600c:114f:b0:3ed:5eed:555d with SMTP id z15-20020a05600c114f00b003ed5eed555dmr13741150wmz.10.1680086513662;
        Wed, 29 Mar 2023 03:41:53 -0700 (PDT)
Received: from [192.168.42.225] ([81.95.8.244])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm1926412wmq.19.2023.03.29.03.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 03:41:52 -0700 (PDT)
Message-ID: <0e863367-5b24-9559-f782-4d3e5dc06961@gmail.com>
Date:   Wed, 29 Mar 2023 12:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 2/6] dt-bindings: memory-controllers:
 mediatek,smi-larb: add mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
 <20230207-iommu-support-v1-2-4a902f9aa412@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230207-iommu-support-v1-2-4a902f9aa412@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 11:52, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-smi-larb
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 5f4ac3609887..aee7f6cf1300 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -34,6 +34,10 @@ properties:
>             - const: mediatek,mt7623-smi-larb
>             - const: mediatek,mt2701-smi-larb
>   
> +      - items:
> +          - const: mediatek,mt8365-smi-larb
> +          - const: mediatek,mt8186-smi-larb
> +
>     reg:
>       maxItems: 1
>   
> 
