Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E972A7177A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjEaHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjEaHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:17:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10DF18C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:17:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so6405028e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685517433; x=1688109433;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6zuba+42QikFw+SZhZKKWqLdO5h+vgWV6OvnqfYZ4E=;
        b=MAROC3Itu8Rb30ZZq0XzoSrnOZCbUR3QtLFVln7CeB855WWkhgCy9BhAR4RLpy2Lq/
         2+ibMjW4MLMxKKr8a33dUE7NDughOA8CjTRxdxmau3Zmkrj19HIozkgZpp2Ug7vEMgNn
         lKqjxI6yqa3PyLgk4zU2QlxsZ15kWCoPZBWLFtufhowUPRmVb7Mq/4KJkiBaETp95fvH
         PzKRqnKeXbgtACIgh4vQ2gI8PPXDrO13RsErzSw0QSanRKGEqQ9Z14kNBWC+jpl8PO+q
         YyUO4Yf2uJy4/3sbKmhKr+pIWILuF5UGcnmGru6RvH9PHDDJflCJKuAsHnBXq8qbmRJQ
         a0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517433; x=1688109433;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6zuba+42QikFw+SZhZKKWqLdO5h+vgWV6OvnqfYZ4E=;
        b=hrPNr7bxu/3wO1xg29ori2j3O0yjd0GdSwUNncN+zAwey0JJOCbZ8ndOBfsAh5c640
         jT+rLjJbK1dBtJgHMpXHo5xCfr+AXQhgYYKBx3ggO4ZCp8R61kcYLkjH20dS7WfuwqjE
         xMzpxcvT1Wvu/26nQbomLstnGTtwluY4iLScQIq/H8oZ+5y8lNWziRl1HDztIn5vAiVz
         rEqYoVM42BaBaN67kwOTzf/5mrq3k1pfzpWqRoKTy4Y/K1pJZ00khP4l8QBT9ur2n08T
         7M2IVkghg57gmcnSYeqWr+v99aOnh0iLqiXczMWCXuFQcVT+79wT4fhZ8xOaZtrryr7l
         NxDQ==
X-Gm-Message-State: AC+VfDznR6M2+0WlISe3UOS/0tQRstkO7xTLWvN1aLOptmvfIRtawBt0
        hJSH+IpYogMHRmk4t4MzCzX75g==
X-Google-Smtp-Source: ACHHUZ618Kgo2wyP+qgnENoAmPPhleQ4byUvQhP0EDUGQg+dHaFEYOdVpCRWxkcAHMC0kg7h4pS2Zw==
X-Received: by 2002:a19:f608:0:b0:4dd:9f86:859d with SMTP id x8-20020a19f608000000b004dd9f86859dmr2152530lfe.13.1685517433467;
        Wed, 31 May 2023 00:17:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b0050bfeb15049sm5231685edo.60.2023.05.31.00.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:17:13 -0700 (PDT)
Message-ID: <38c9dfb3-e1c6-8a2d-993f-b6930bd0d8fa@linaro.org>
Date:   Wed, 31 May 2023 09:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
        davem@davemloft.net, kuba@kernel.org, nicolas.ferre@microchip.com,
        michal.simek@amd.com, harini.katakam@amd.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, claudiu.beznea@microchip.com,
        radhey.shyam.pandey@amd.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, git@amd.com
References: <20230530095138.1302-1-pranavi.somisetty@amd.com>
 <20230530095138.1302-2-pranavi.somisetty@amd.com>
 <20230530122559.o2nvvtkf2gddvjkz@krzk-bin>
In-Reply-To: <20230530122559.o2nvvtkf2gddvjkz@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 14:25, Krzysztof Kozlowski wrote:
> On Tue, 30 May 2023 03:51:37 -0600, Pranavi Somisetty wrote:
>> watermark value is the minimum amount of packet data
>> required to activate the forwarding process. The watermark
>> implementation and maximum size is dependent on the device
>> where Cadence MACB/GEM is used.
>>
>> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
>> ---
>> Changes v2:
>> None (patch added in v2)
>>
>> Changes v3:
>> 1. Fixed DT schema error: "scalar properties shouldn't have array keywords".
>> 2. Modified description of rx-watermark to include units of the watermark value.
>> 3. Modified the DT property name corresponding to rx_watermark in
>> pbuf_rxcutthru to "cdns,rx-watermark".
>> 4. Modified commit description to remove references to Xilinx platforms,
>> since the changes aren't platform specific.
>> ---
>>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1787378
> 
> 
> ethernet@e000b000: ethernet-phy@0: Unevaluated properties are not allowed ('device_type', 'marvell,reg-init' were unexpected)
> 	arch/arm/boot/dts/zynq-parallella.dtb
> 

Unrelated warnings, can be ignored.

Best regards,
Krzysztof

