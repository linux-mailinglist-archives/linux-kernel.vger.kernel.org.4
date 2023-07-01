Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D57447F7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGAIOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGAIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:14:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905BDB
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:14:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313e12db357so3410724f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688199266; x=1690791266;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9J7X11SuOiKzwg8zM4pCPONMh4yD15NNSD4f4DtEeY=;
        b=rh83CQApG43JSKsX6MyogdOQymYI/SkykLrlG3aahsbET0jEkvcKt1K0u/RyyenMj2
         dAc6r6pJZVzSge+xQpdul7MMzWbjZnZzAkzzx4d2JWXZhhMQcRW9dz/sMtWdeLauXQGA
         hGdSnn/SxPB9vjx6boygHjZI503KvKmoLA1jYlYhC7r4TMQvOJlgXQDL3dUXcgctwTG5
         M4olWhthyZvEpSTId5jtHyxXFnT3+XnMbfAgDXCZgdZuLQDGoQufkmOlSLrH4yljvHzD
         M5gyGew6BIZGPdCxbCM8bsAsD3w9W+J+EkBhfOcYpxkrLFvX98Qv8UqU89qhu5basW+t
         IwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199266; x=1690791266;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9J7X11SuOiKzwg8zM4pCPONMh4yD15NNSD4f4DtEeY=;
        b=LF7WC/uUy2XPtbNku8kQLbWjQe9FxPwneB0gUyKeBohy6JXaLMHGOp4gaWkmJVAUVi
         U3LEF9ZfVCDVik8vQWCDkzMCJLmLNEUmBrIEbPRyv5xzr5EFcwTza+30W1cX3PpywBoG
         nIaSVXj52lzVJVxzh6KEFL/MDJixRER1/YbaqjDvK9rG6c7gAKvfVNHReUf8nSYw+hG8
         pc+qFH/d6BhhQANYVI7HZ92l9VJ9TxikuPOfgu+5Yc5ay0+gteW8MRDdqxfiuy0LwjaW
         /X77mb1GGyzh1yz4LIg+y22L1sLZL+5KlcLVk7SIMf48+RhGT/9pbDq/UdmzXlbXveG2
         BRog==
X-Gm-Message-State: ABy/qLZ+xKrmEA0wI6jn3vf7S79SZfWV5zdNAOb36g2Vfx/gV2XaX5wh
        sovmCBMMdCf2w2eYqXC/4aY/GMr3+Z6gu0NYHUg5/ggt
X-Google-Smtp-Source: APBJJlGnZ87GlqELUyFSQTfpgmcHtXhAn0wDNgjNrtXAjDlesoGuFxZ1xlBsf1tFgZQDnxD5/8wNFA==
X-Received: by 2002:adf:f992:0:b0:314:1e87:f5d3 with SMTP id f18-20020adff992000000b003141e87f5d3mr6115912wrr.29.1688199266042;
        Sat, 01 Jul 2023 01:14:26 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id o9-20020a056402038900b0051de4f15362sm2071648edv.5.2023.07.01.01.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:14:25 -0700 (PDT)
Message-ID: <9fba446c-f0eb-ef44-8ced-f7a0bde8d064@linaro.org>
Date:   Sat, 1 Jul 2023 10:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
 <55cece9b-b4b8-854c-f948-2e30895f36b0@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <55cece9b-b4b8-854c-f948-2e30895f36b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 11:58, Jon Hunter wrote:
> 
> On 23/01/2023 15:15, Krzysztof Kozlowski wrote:
>> The serial node does not use clock-names and reset-names:
>>
>>    tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra132.dtsi | 8 --------
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 --
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ----
>>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 --------
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 --
>>   5 files changed, 24 deletions(-)
> 
> ...
> 
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index b54353f31df5..372be226a7f4 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -676,9 +676,7 @@ uarta: serial@3100000 {
>>   			reg = <0x0 0x03100000 0x0 0x10000>;
>>   			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&bpmp TEGRA234_CLK_UARTA>;
>> -			clock-names = "serial";
>>   			resets = <&bpmp TEGRA234_RESET_UARTA>;
>> -			reset-names = "serial";
>>   			status = "disabled";
>>   		};
>>   
> 
> 
> Thierry, do you have a patch to convert the Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt to yaml? I have noticed that the above change now cause the hsuart to fail on Tegra234 ...

my patch was touching only the UART (8250), not the HSUART. These are
different compatible and different drivers. Why do you think HSUART is
affected here?

Best regards,
Krzysztof

