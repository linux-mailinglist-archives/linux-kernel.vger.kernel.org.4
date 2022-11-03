Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9A618ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCVxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKCVxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:53:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEE1CB28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:53:38 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k2so2064362qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4FNfyLMzedwinhTE/GOK3SRUlFuPs6PJ+uM4x6Afo=;
        b=E3mKpOiagBNOsP0QnA2ALjIYNwglgetXX08TBFD+dDh0HnEsomwqSI3kaKWul/yudQ
         bPDZC94K06g8N4N8HgrBTxJazvUdELrIn/Hvw3WbijXKk8KnUyvpHp3IgJcjn427rKpf
         bTE/t7BovIgzkVorZsAHlgDk1ofz9NHcBoAqsMA1Kp5ydxN9dCqeH33fZy8BxkDu/DmK
         pXXC60yaphgHnpxxi+JgcIpVhI7okdgm25QgEUn6f9slkrhC/SHpK7lF5sq+L4VSQsXK
         TFIufp2tEwmbizXsUbBsR8XfjuAmYGw7xT8CZ2rZJ2vGbRVjHpca088gR0nyntyRHbG+
         Dr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw4FNfyLMzedwinhTE/GOK3SRUlFuPs6PJ+uM4x6Afo=;
        b=mTJAapH2nqJhHPhAzT5z4L8FvruGM/zfOQlbNBOuHWN0pDkwxbj5rHhAYEeI6spaEL
         QrL8wAQBpmyYNETkn1mZ3UnJN34x6izorLETlmwEeeRnT4ev+kErZFUXkofeQ0fh0tc7
         7sG50BywSz5awl5Ljk+oMxswfnW1tEZYu9l6UHiA7sSlN2uyS0HFm4I1sQc2pHkjEuKP
         fX1jOYNd1hV/PPQE4D2kAlagjwmHjYZ7TI3O7fMippt3tKXAqYUNT9U2fYg8IagOYmqL
         chh56tSHWLlOeynYjYPpz5JzNc/rcWEn5zy6nkGgBPY7nP7uVUeeCXLu6RSkpzUSOtWD
         Gkpw==
X-Gm-Message-State: ACrzQf1k+t7bW3vRA63c7md9pe1OjlpWx5gigUV4EUFK8uuzF+YuV5XX
        DrQ6zVdT3Fkc+c5LGURrGre0zw==
X-Google-Smtp-Source: AMsMyM7NS+xQFx4aWxTnlG4WJ6XwPD50YljjnHFy4ShrNwrN1k8AXbwhLEJqdkFF9w1Spms4LLUzXg==
X-Received: by 2002:a05:620a:1027:b0:6f9:8ff2:7ea2 with SMTP id a7-20020a05620a102700b006f98ff27ea2mr24810767qkk.652.1667512417161;
        Thu, 03 Nov 2022 14:53:37 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id t26-20020a37ea1a000000b006fa8ab991a4sm367979qkj.27.2022.11.03.14.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:53:36 -0700 (PDT)
Message-ID: <01e8e789-68a8-626e-1a47-814d182807e7@linaro.org>
Date:   Thu, 3 Nov 2022 17:53:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] dt-bindings: PCI: loongson: Add skip-scan property
 for child node
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103090040.836-1-liupeibao@loongson.cn>
 <20221103090040.836-2-liupeibao@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103090040.836-2-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 05:00, Liu Peibao wrote:
> Add the newly added "skip-scan" property for child node.

This we can see from the patch log. You need to say answer here to "Why".

> 
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
>  Documentation/devicetree/bindings/pci/loongson.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
> index a8324a9bd002..5c2fe9bf2c78 100644
> --- a/Documentation/devicetree/bindings/pci/loongson.yaml
> +++ b/Documentation/devicetree/bindings/pci/loongson.yaml
> @@ -32,6 +32,13 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  child-node:

What is "child-node"?

> +    type: object
> +    properties:
> +      skip-scan:
> +        description: avoid scanning this device.
> +        type: boolean

Why? Isn't status for that?

You also need additionalProperties: false/true, depending on what this
child-node is...

...and add the case illustrating it in the example.


Best regards,
Krzysztof

