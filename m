Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE16000A5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJPPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJPPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:31:22 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6033863
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:31:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a24so6436409qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fG8tP6ulNvkW7prqoOtdguFD+mr4WxhtDePb8i/GegQ=;
        b=jtyK9tawIw2C4KLU0bugKmT3U5/ee5JXFKGlIcbQXqLt+c5xGMSBPyG06M1SKlymVF
         YYaPoVMH5EaMqsWV2Vh7cTnEpjNaRsxiePEeQlCEFRbqg27QijX5bAcgtSb6jC5j+LrR
         C+6wE5KbfIdF2SAfjBGYlG8ZITasN76hNvYkEculvQ52fOpkdH5PWAEhLOQDalWGJ/H0
         kQHn+VmG7c8k3HHtUb5KMSvfkPJP0uBQswLVtmIPSO0gnEIxfTRlHXnTcKdyYvvEG3Xr
         3nzo6OO6xzjcSnzOgnrGgXozFGIwb8yMWEqgG7yVM8lqOMjSgePFtFklg++pFhqsylMr
         4z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG8tP6ulNvkW7prqoOtdguFD+mr4WxhtDePb8i/GegQ=;
        b=dljGUUBPdk6OuNm1v+qay63Cl76aahTLZGHWqRXlK+CZ1DYxtOEl4JNgcaH913tlQV
         L7KCQMiWh7aTgU9KoaMNSRgTyRBOFPuYPfqriPpI7Mz5XFuj0Na7UwNaKkND5oSKHNrf
         37ShBBay7HjvRvz0XnPPYJplypzGD0aPnxbV0AibdGkU45BVFMMsY8MGhevAWYugByvA
         L/X9V9+IyX3V0WBW7hyn60ynAa7NbqeoSKBMMkICl6xkOIQ+Sh2vL1KQ0XnkJyTQ3oLT
         67058opA5HEET2+isgAGOJkjEBdArVICzgsfKE14O5QLrEH9Y+zJMh3nFHTUwttzhZ4Q
         iSnw==
X-Gm-Message-State: ACrzQf1rlSyD0aKx09Q932o3WySscFGwQHr3+v71+/9WBs4olt0O5GqX
        8Fb7CuusoMMltmvzDuHCsWEfRg==
X-Google-Smtp-Source: AMsMyM52zXE8H21VnnAi0L26xzxHGEAYVZ8vcpPooGRfX+RS9nAahoVcOGbKg2uzEgS50/tHmc6wSw==
X-Received: by 2002:ac8:4e4e:0:b0:39c:e3ac:df36 with SMTP id e14-20020ac84e4e000000b0039ce3acdf36mr4515219qtw.495.1665934279312;
        Sun, 16 Oct 2022 08:31:19 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r28-20020ae9d61c000000b006ed30a8fb21sm6672822qkk.76.2022.10.16.08.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:31:18 -0700 (PDT)
Message-ID: <77676eda-20f1-e029-9bfb-a588caa96d73@linaro.org>
Date:   Sun, 16 Oct 2022 11:31:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] dt-bindings: ingenic: Add support for the JZ4755
 dmaengine
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221016151256.3021729-1-lis8215@gmail.com>
 <20221016151256.3021729-2-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016151256.3021729-2-lis8215@gmail.com>
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

On 16/10/2022 11:12, Siarhei Volkau wrote:

You miss here now commit msg.


> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

No empty lines allowed between tags

> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> index 3b0b3b919..e42b8ce94 100644
> --- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> @@ -18,6 +18,7 @@ properties:
>        - enum:
>            - ingenic,jz4740-dma
>            - ingenic,jz4725b-dma
> +          - ingenic,jz4755-dma
>            - ingenic,jz4760-dma
>            - ingenic,jz4760-bdma
>            - ingenic,jz4760-mdma

Best regards,
Krzysztof

