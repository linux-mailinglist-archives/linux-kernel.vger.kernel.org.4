Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB976A1A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBXKwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjBXKvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:51:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C8354A08
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:51:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ck15so54462223edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWipjI5mniJwj+Zo4zdUNY2FbRwRYxCeXGMJn2ipLck=;
        b=k4ggbccT39ghWzkqPfOuKg+e5dqk6S0iiRLcagST86D6Ehg1wAdUjlc/SuqwBa+dqn
         WimQ6P/WlBwKVMP1IzwfxpBF2Byg8Kznh26l1swwOO+1MzON8n1q9kgeq5M2AdPpUmw+
         6TGc8nOWg7YV/QaZaFD4MnHz4XGuv8ZQdRs8yThtQjEfhpX5B1dzvcQnpxonc//7bYdo
         V6SpfXw/Tx1JOMCs5UiifAVL9IKb+h6Myskgw3STaA1e7tAnNY46NFFAzN4x21NMn2sq
         KksIaXPBjWNZxi12LdvNW3SyHsr8OJMiOvpT9Sm1hYDjG/O9CMXTHjVEHiMkdpjhV4vL
         OwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWipjI5mniJwj+Zo4zdUNY2FbRwRYxCeXGMJn2ipLck=;
        b=UUJ6ynQW5e/O0YiaWzjz9K9sRBPt0cNuApe2yF35mKKeuGndLMVz1A5OHgiZ7M7E3f
         QyltfrIyfxVQ5QzyVekybTBpD8RyofBhFlo97yIlnjtMl5W5PjLku9MIOzBXZICqDsyY
         Wy7V53NxprxY8Y0y46v/vBlSY+hi/627E80ZEuuNEPYknJI9tx/SM/D/oBYp9bY0RDVC
         5rrBaL0hvO/tZemT2as2x9NSwod+1GiOHNBOBkYF3ZVBM4Hmv20fGnHdP0x8nkHpWYDz
         Ecp9b3n5ijqowzcKFTW9o/dJGfWge5dU7f3JW8rHKNtBFaigDauL4zAFpMdc3MdjyF68
         Mxmg==
X-Gm-Message-State: AO0yUKX4PVNHhaAWsqw/FD/s3vVwU3lMHoGZYRqyRVAVmwz+1rUqLFjv
        K2tCbLCdON1rmV2KKxbEWp0n9g==
X-Google-Smtp-Source: AK7set/8r3ELb6NzgTDjS/JxvwXd778mA4ZaHD648XBFslKOZSwwXSIMZSZD4DlfMpG9Ny3kLVZl7g==
X-Received: by 2002:a05:6402:1356:b0:4ac:746e:2edf with SMTP id y22-20020a056402135600b004ac746e2edfmr15950821edw.9.1677235896393;
        Fri, 24 Feb 2023 02:51:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b008c9b44b7851sm7197176ejd.182.2023.02.24.02.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:51:35 -0800 (PST)
Message-ID: <36188e04-332f-e944-9c58-f6f2b74987da@linaro.org>
Date:   Fri, 24 Feb 2023 11:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add reset
 items
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230221140424.719-1-walker.chen@starfivetech.com>
 <20230221140424.719-2-walker.chen@starfivetech.com>
 <1467f7c5-07eb-97db-c6f2-573a4208cc28@linaro.org>
 <d0984638-3f7f-7e4e-fe3e-5e1f88375dca@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d0984638-3f7f-7e4e-fe3e-5e1f88375dca@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 11:14, Walker Chen wrote:
>>>    resets:
>>> -    maxItems: 1
>>> +    maxItems: 2
>>
>> This breaks ABI and all other users. Test your changes before sending.
> 
> I think 'minItems' should be added here. So like this:
> resets:
>   minItems: 1
>   maxItems: 2
> 
> Other platform/users will not be affected by this.

Which will allow two resets on all platforms. Is this correct for these
platforms? Do they have two resets?


Best regards,
Krzysztof

