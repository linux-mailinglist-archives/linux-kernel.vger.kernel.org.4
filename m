Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A560B71C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJXTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiJXTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:19:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653615A8EA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:55:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i65so8408367ioa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUL2O9wbBAu6ztSDG3ElgZvx99nzcRnOeYgEYBuGPRA=;
        b=EEmIXtqXupNZGMQusrGu9cSwDxciaaGSv2LhhL0tX6byMmK28IsBk8c6ClWRq6lYkA
         5+dolwExw1XyN7N2ZUnUo6goPkhL7uOXaTIp+47CzWhPnD5qROzOOFZav4k7YHRwqMEH
         FUMPtqxOPxGTW4BVMVkUU5EW2Xr8k2N+TpV67Fm2aVZNsQK2YGa5ARYpVK2ZvjpFSstW
         5LGsb9+H93HpawF9AoNVTC4rjX5VhkPFm7zaO/rvKQjhCs45phjNvhnsoAZmagQcq/C/
         HnRdp7bCxBKgaIB0yVFB18J5KwAXnMljceuUkDgw1IMXcatnvOp8r7QAReZIeerM+SnW
         dxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUL2O9wbBAu6ztSDG3ElgZvx99nzcRnOeYgEYBuGPRA=;
        b=bJoMsU++EgoGjb4NUIcq08fUA0crAY0jIlc1r+ZstcWLxML8m6NNRZO/w0kMOQ10dm
         9K9gjdUvUa1n9dLsIb1unNtPOSzMZGJ4uGwDX65N56B9+QBjuBdzPBSsD+ERUiWZLjLh
         yT2xkccxVEPnKrEYKegBCs3yry7hyCTDxJWSqL8FOkzrH6jMPE4SSMXEN5QzWLkRETJK
         9g3jD0taTSP/6THgVkETS5K83EhsAlkp9Sxop1E8hJw2yR/RKIyQmsSBn3MjWMzkZQPl
         gncI3lf0JHFzlDudEe/6mVLmYtsbF50UsU921/Vd0TKp378zujjj6LmHtwIJPrJTfTvz
         oB7w==
X-Gm-Message-State: ACrzQf2eBE+6YxMbB9nVm/wgfLl7msxYN4ng4izj0pcVRWqNir1AKn5o
        whUzVRmgwslCzVOtw6QlsSHgert2yj9jhg==
X-Google-Smtp-Source: AMsMyM57TE1ja12+inLNwlTcq5BSzAd/+4nM91OaJJGzUPwVHrd3YNRlGWdmd5z78YjGbtZPGpbilw==
X-Received: by 2002:ac8:5c11:0:b0:39c:fd77:336d with SMTP id i17-20020ac85c11000000b0039cfd77336dmr24199445qti.479.1666630114992;
        Mon, 24 Oct 2022 09:48:34 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q8-20020a37f708000000b006ce0733caebsm279848qkj.14.2022.10.24.09.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:48:34 -0700 (PDT)
Message-ID: <0b9d7768-3f30-c084-9a14-f439cd49d643@linaro.org>
Date:   Mon, 24 Oct 2022 12:48:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Aw: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-4-linux@fw-web.de>
 <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
 <trinity-95441a68-0025-49de-8c73-9730fb9cec42-1666623320110@3c-app-gmx-bap55>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-95441a68-0025-49de-8c73-9730fb9cec42-1666623320110@3c-app-gmx-bap55>
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

On 24/10/2022 10:55, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Sonntag, 23. Oktober 2022 um 14:56 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> An: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead.org
>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Chaotian Jing" <chaotian.jing@mediatek.com>, "Ulf Hansson" <ulf.hansson@linaro.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Wenbin Mei" <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
>> Betreff: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
>>
>> On 23/10/2022 05:12, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add SoC specific section for defining clock configuration.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi,
> 
> got another config from mtk which requires changing binding a bit
> 
>                        clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
>                                 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
>                                 <&infracfg CLK_INFRA_MSDC_CK>,
>                                 <&infracfg CLK_INFRA_MSDC_133M_CK>,
>                                  <&infracfg CLK_INFRA_MSDC_66M_CK>;
>                        clock-names = "source", "hclk", "source_cg", "bus_clk",
>                                      "sys_cg";
> in binding:
> 
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -241,15 +241,17 @@ allOf:
>            items:
>              - description: source clock
>              - description: HCLK which used for host
> -            - description: AXI bus clock gate
> -            - description: AHB bus clock gate
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register access (required for MSDC0/3).
> +            - description: msdc subsys clock gate
>          clock-names:
>            minItems: 3
>            items:
>              - const: source
>              - const: hclk
> -            - const: axi_cg
> -            - const: ahb_cg
> +            - const: "source_cg"
> +            - const: "bus_clk"
> +            - const: "sys_cg"
> 
> will send an updated v4...old version was working but i should use the new one.
> 
> @Krzysztof can i take your RB here or should i leave it as Patch was changed?

Please drop my tag, so I will re-review it.

Thanks!

Best regards,
Krzysztof

