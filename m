Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377E6B68A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCLRJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCLRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:09:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160321945
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:09:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id da10so39871525edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur0YRak4azgO8ER8v9X1Sisyj3A0UjrzNilpdcu+HRk=;
        b=IIumIHOspITOgjriMp5ESfe4mr+ULnDvPBgJipm3w8unQT74U3jSJ0ZYxyJ3yA7l1w
         wzQzBmdo48JSDwrmGI5NNHrj6qB4LwBjNcm+y4kD7txoNzXnlv6W3m54HK8X+qOL5YA0
         IY6cyOAQZmZuL9WqiPPaoGuXb3wqfwCMSmzUPXNTQBiq1ErNXeA5UtcMRXcnh0xzlDK6
         87eT+bj19kVx2bzZiI8RHt/APiSIdokGzw/U5ZgKxoJrWKwXnQFPWFgHdszEeIHUE9RR
         w+1cESbv7K+k5D0KDdqDm0NdHJzG8kigScImY2DdcrNQeGzwaQwMCyLrse+TD39Ykv78
         /P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur0YRak4azgO8ER8v9X1Sisyj3A0UjrzNilpdcu+HRk=;
        b=dyfFsMfAERUXHxYVgnTWU7fCeV5fPhZRxtaWCNzY5veTvVjbzJ9upfLSCriDeHthY2
         fOyAoFi06vRelpr+ai+1AOll/ZwWqj627oAlhc/YfZV8sdlkoRZBZf5hHNYfuXRMOzSk
         640hX+B6TgztyDW7zkHr8i1lZjRCHVmzoQuoecV377/8AKREE+IinuBNEBj+4f6HUeja
         RVztmRhZEfLdFW9SBlyLfvS/SobcD55HuMWSG+yvD3RI9s6aCUZqexMNL4rN5Jj7gSwV
         L4sMdctTKlAlm6enEgvH8CjJXcIFUPfkH/ArdegUe7vwmJFoLRPel6QfO1prIPttevLv
         +jFA==
X-Gm-Message-State: AO0yUKXtYQ1/C6G1kWbddxsB4FQqIyfH++7nmIpDl7xiF+WtvaC5llbv
        QeoeR4pptEHSuqUm5U5eZg/VtA==
X-Google-Smtp-Source: AK7set+9rjs/pkVy7AWNiNv0a34Mg1Vn463+p/9TwJdBU4BL6GlFQorb6rS66Q1i0nTHMIp1JktUoQ==
X-Received: by 2002:a17:906:3b48:b0:921:da99:f39c with SMTP id h8-20020a1709063b4800b00921da99f39cmr5463449ejf.12.1678640951442;
        Sun, 12 Mar 2023 10:09:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id i5-20020a170906850500b0091e1878bc59sm2425726ejx.68.2023.03.12.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:09:11 -0700 (PDT)
Message-ID: <f34ba6e5-4a8d-0812-c334-ea47de7b1d21@linaro.org>
Date:   Sun, 12 Mar 2023 18:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <640e0136.c20a0220.2d5bf.1959@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e0136.c20a0220.2d5bf.1959@mx.google.com>
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

On 12/03/2023 17:43, Sergey Lisov wrote:
>> Bindings and DTS (and driver) are always separate.
> 
> Okay, will split the patch.
> 
>> Compatibles must be specific.
> 
> No, this way you'd have tons of identical compatibles that only differ in
> the exynosXXXX digits, and are functionally equivalent.

Thanks for letting me know.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

>> That's non-bisectable change (also breaking other users of DTS), so you
>> need to explain in commit msg rationale - devices were never compatible
>> and using exynos7 does not work in certain cases.

BTW, this rationale was only example - you need to come with something real.

Best regards,
Krzysztof

