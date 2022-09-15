Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D305B9FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIOQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIOQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:32:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B08A1D7;
        Thu, 15 Sep 2022 09:32:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso14122293wmr.3;
        Thu, 15 Sep 2022 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OW/Ex82NxAoUPhZ7WksjsJWpT0Wxc4UMr3Q8n9sA3l0=;
        b=oa1iAq2oQGEn8eKul2dVLQzOitSaXu1V04U72I5Tb0OJxKctS0GCAc9ZSxB0ODpizN
         dJ/F5KUO+H+d6BJkjcgX4GbYv5T2yLX6nJjt7FZ6xuQNXQUNp615t60zU28VyfC20HYa
         EyRu7HQpsUN9ud7rY9SDSkPkrXYxVs1LFi1qkOyBpO05fcwiS76omNG8QrNo0OayXhWO
         cVNqgX4cl5DNheQtok6eO86lW3GRYsEm4iN9IZD1saczShJXfDcjsWa0TWoZS6F8uwbP
         uUzh2eNswEfdIkHix87bYZ2fxQerSaaSUB7vkmwvx0813r39HwLdzpBcLYm0RR4ouMhe
         z0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OW/Ex82NxAoUPhZ7WksjsJWpT0Wxc4UMr3Q8n9sA3l0=;
        b=M2+rnjQvd3LoOTnfP5HeItbxj/vuMzpjhjM3F0MvUkZnEawKUWMLc0AWWJTiu0Dir8
         sDNCwXvrV6a/YuO/a+IlYPLPmCJrrInciOD2fTsgxI9zpVMLp2VtcrnXNxyI3CtkK0R8
         8YRDVQrl3ophALVL2G556qxRhptbxYNqQpM/rZOVqOalKNTsFPe5R+RzHwx4MU8YWuY1
         O3LVvMuhdiqFauc5nX1oawB44dDYFRxvTEiXWbyMKPNVW/zAXUicSxntEBBbteIK3Kfn
         RLhu/gsd39nGVTFjtHM1dThpmqtC9gW2NNR4VLa2mz3z2nmoIeiTjv6qwVhJDAe6tOQL
         vsyQ==
X-Gm-Message-State: ACrzQf12k2S4oxxE5tP1Wp5Z//ycOd/sSg/MAapPDL9cEpHQT04FlFJh
        QIKm7cc+gI2Pj4+knaMUYrZWaNu83/0=
X-Google-Smtp-Source: AMsMyM5vSjMhWO1RDq7b4M3mpsFrRuHxRzzw7FrIG+23DFOAsZqCTFeWng1l9RQ7qYEL5fpA6SuztA==
X-Received: by 2002:a05:600c:6029:b0:3b4:9fcc:cbb3 with SMTP id az41-20020a05600c602900b003b49fcccbb3mr451881wmb.169.1663259546781;
        Thu, 15 Sep 2022 09:32:26 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05600c524800b003b48dac344esm3975873wmb.43.2022.09.15.09.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:32:25 -0700 (PDT)
Message-ID: <990c00a4-f20d-1e7e-e4d3-6731947c1456@gmail.com>
Date:   Thu, 15 Sep 2022 18:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt6795: Add CPUX system timer node
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220729093536.27623-1-angelogioacchino.delregno@collabora.com>
 <3a91e743-2b8f-51b6-9ac1-adc3e7ec8cc4@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3a91e743-2b8f-51b6-9ac1-adc3e7ec8cc4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/2022 13:01, AngeloGioacchino Del Regno wrote:
> Il 29/07/22 11:35, AngeloGioacchino Del Regno ha scritto:
>> Add a node for mt6795-systimer: this is necessary to start the
>> System Timer(s) for all cores, finally making CNTVCT_EL0 usable.
>>
>> Signed-off-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
> 
> Hello Matthias,
> 
> gentle ping for this one - this has no floating dependencies and it's
> verified to work as expected.
> 

Applied, thanks!

> Cheers,
> Angelo
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> index d4842b4a4eb7..46f0e54be766 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
>> @@ -230,6 +230,14 @@ sysirq: intpol-controller@10200620 {
>>               reg = <0 0x10200620 0 0x20>;
>>           };
>> +        systimer: timer@10200670 {
>> +            compatible = "mediatek,mt6795-systimer";
>> +            reg = <0 0x10200670 0 0x10>;
>> +            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&system_clk>;
>> +            clock-names = "clk13m";
>> +        };
>> +
>>           gic: interrupt-controller@10221000 {
>>               compatible = "arm,gic-400";
>>               #interrupt-cells = <3>;
> 
> 
