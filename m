Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76569648453
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLIO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiLIO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:56:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D9584268
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:56:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so7421526lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zn39Cq6H46SfgCPMDp1Yyg4Hy1ifOLwJBJ6L3zqm8MM=;
        b=oK6qJslOKT34uL/1v4g3iVT1myebBNEM4jqIgvwqM03/FD9DabncthU7iZSDV0Dw6V
         XsercsMR7iFL4hosx9kgIZ9YzmeCwbSXsSX4/PK42T64csirCJrUZDGR63AA3gzG1g41
         zlLghgCExlKP16+a3f94HqnFX/ZzAhWZHtnZtcyd5lQqtnZGVR+xrZz6v60MtrThIAwE
         XQEk16WFuKtIqjvbXFNEA7UN1gFNRMxtw2StjPUdNgiBZiUp23HOjBaOGribElE0U6rD
         481bOTOymtR3SVQCOPXoy+Dnb7PRwjW6PGEXoMZeDb2M9MiCGeBIBtnUuFWXLdoTE2dW
         +kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn39Cq6H46SfgCPMDp1Yyg4Hy1ifOLwJBJ6L3zqm8MM=;
        b=yAPLol/IgIdMKehjtDQkh1PNrVTzSjVXlaZXF8RYk6YeNox/sOd7lOAAAqAhwZw+RE
         5i2aC6n+MqX7c+0Mj4rJExLFjuzxN/ZuUW91H97pFoq73Pc4sQ+8l/NcsrjfQKkjUPXP
         GLgit78DXrN7SfkRmOAdOBbxsq+tPR3PBicocS6dEe5oYrCHNjSijk/RsJsw6Dht8SDV
         KfEz6MdkvfwlzogV/sWDyFWQD7JPWdJf65NP2YtWB9KCnDUGeuAnm9fenOUKmicYQBkF
         WdimF1bOglPbkwWqXXsflbfMB3eR7nwxUiEbWhJWNBijvGqwVnu7SnkAtWYgRobT0h0p
         9MDA==
X-Gm-Message-State: ANoB5pnIwNjnaD840DvuxYjh5dwYrDaR8dmXyZzBJHwYe/3wpac0Axa8
        tkmdPLOWa+ZX5MAwfLT2OYXZrA==
X-Google-Smtp-Source: AA0mqf6+eQqJYIlJ4RBGy5DkLM0OPyqhKXbsUkA+Jn4oqxjdS9sXP0vfO1VIWussQDLHIAES8/dMgw==
X-Received: by 2002:a05:6512:13a2:b0:4a4:68b7:d61d with SMTP id p34-20020a05651213a200b004a468b7d61dmr2041235lfa.4.1670597785748;
        Fri, 09 Dec 2022 06:56:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h9-20020ac24d29000000b004b50b4f63b7sm287771lfk.170.2022.12.09.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 06:56:25 -0800 (PST)
Message-ID: <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
Date:   Fri, 9 Dec 2022 15:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-11-trevor.wu@mediatek.com>
 <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
 <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 11:56, Trevor Wu (吳文良) wrote:
>>> +
>>> +patternProperties:
>>> +  "^mediatek,etdm-in[1-2]-chn-disabled$":
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    minItems: 1
>>> +    maxItems: 16
>>> +    description:
>>> +      By default, all data received from ETDM pins will be
>>> outputed to
>>> +      memory. etdm in supports disable_out in direct mode(w/o
>>> interconn).
>>> +      User can specify the channel ID which they hope dropping and
>>> then
>>> +      the specified channel won't be seen on memory.
>>
>> So we know what are the IDs but it's a mystery what are the values.
>> Especially with unique values - how any of these should case that
>> channel "won't be seen in memory"?
>>
> For example,
> FE can support 14ch, but BE(etdm) can't support 14ch(it can support
> 16ch).
> In the case, we can configure 16ch to etdm and make use of the property
> to disable the last two channels.
> 
> mediatek,etdm-in1-chn-disabled = /bits/ 8 <0xE 0xF>;

Your description should explain that this is a list of channel IDs which
should be disabled.

> 
> 
>>> +    uniqueItems: true
>>> +    items:
>>> +      minimum: 0
>>> +      maximum: 15
>>> +
>>> +  "^mediatek,etdm-in[1-2]-mclk-always-on-rate-hz$":
>>> +    description: Specify etdm in mclk output rate for always on
>>> case.
>>
>> How is it different than assigned-clock-rates?
>>
> This includes clock enabling at init stage.

assigned-clock-rates are also at init stage. I asked what is different.

> 
>>> +
>>> +  "^mediatek,etdm-out[1-3]-mclk-always-on-rate-hz$":
>>> +    description: Specify etdm out mclk output rate for always on
>>> case.
>>> +
>>> +  "^mediatek,etdm-in[1-2]-multi-pin-mode$":
>>> +    type: boolean
>>> +    description: if present, the etdm data mode is I2S.
>>> +
>>> +  "^mediatek,etdm-out[1-3]-multi-pin-mode$":
>>> +    type: boolean
>>> +    description: if present, the etdm data mode is I2S.
>>> +
>>> +  "^mediatek,etdm-in[1-2]-cowork-source$":
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      etdm modules can share the same external clock pin. Specify
>>> +      which etdm clock source is required by this etdm in moudule.
>>
>> typo: module
>>

Best regards,
Krzysztof

