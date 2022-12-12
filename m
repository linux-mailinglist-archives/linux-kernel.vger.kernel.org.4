Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25217649A31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiLLIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLLIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:40:51 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5EC758
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:40:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s10so11756061ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+6fEYSz7m/CPUV4/+SEcQDFawyZfISqhe/v9Owp5pU=;
        b=H1Jk1RLOPg9VYMLvqyNaJw3wTLfyV51sNzM1xYb7d+lzkrEB6mVox9o567x5glUjH6
         fJ/lRVNJHtjhU2peVl8ruNNeZv94g+K5g4gMw5qQAXps/5ykovYIfR7SLwO/jU5ISYyR
         w6mIEpSlc3AK8WJR0/AVHxDt4WXy6vxLIBvvDuPaCLlT0CT4IzU+yn0Zi+idc1uSsfjQ
         sm2eMXJ9KSyEKlUpbbi0s7jZK8pNORQjbU3jP5MnoxY4rgpwUy9GMDzymnne27k02M4k
         qwGCTdIPoInshL+nQplRmu5UIdJ5Ijz54cXFCwG0Z+D1XFpFFeYZ84APYHHFfKRWLGqV
         XP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+6fEYSz7m/CPUV4/+SEcQDFawyZfISqhe/v9Owp5pU=;
        b=cqVvDe84vzQ8LXRERGysC6fUazP+ibYtCD3eB4chJzJ45YmtAixGaY+bKO3mEt/j1x
         Gjvx+E20GWfO394fEkRNiupIUmQpzRT9TDXwIlYhbwXufHeVWRmn4487ms/N2ZuVFhL+
         fGZ5uuDHjPrpJBW8T3umZZwa1PnQyK8BnS5UBbr83WVLhZkpwA7sQE6DtJFePc0HQVgU
         TRDaUIMs04lN00DtPQjZS/IxaDZODi8oumcc1ApWs07ftKWwQe92JoCtC5gHfMJd8NVp
         64YvwuRfB04iAbjpz10fOOEFEEni9qJ43Ztl2p2XXyQMLAi17CF4jlenQorktvZGvyTH
         17hQ==
X-Gm-Message-State: ANoB5plsiDk6PFClbEdqDa52e2oitf1liXwj+jTkqiIJUbLqnY4iHUtY
        RRW4B0u8az4II0c1eHYWgR3lxQ==
X-Google-Smtp-Source: AA0mqf5SXiv1Zkg7HMMVCWRXZmcBBmj3rggFfCSnSxwz4n0RrQilNwopPTQTwh39iLbyyURas6wTZQ==
X-Received: by 2002:a05:651c:905:b0:277:155c:f4a3 with SMTP id e5-20020a05651c090500b00277155cf4a3mr3625178ljq.38.1670834448153;
        Mon, 12 Dec 2022 00:40:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eb989000000b0027a197d8247sm1153836ljp.16.2022.12.12.00.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 00:40:47 -0800 (PST)
Message-ID: <e20884d2-5d30-9519-d070-8e2ac07f2171@linaro.org>
Date:   Mon, 12 Dec 2022 09:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
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
 <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
 <e08fab2a694313abc12e0f8303de3e2e704b388c.camel@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e08fab2a694313abc12e0f8303de3e2e704b388c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 03:43, Trevor Wu (吳文良) wrote:
>>>
>>>>> +    uniqueItems: true
>>>>> +    items:
>>>>> +      minimum: 0
>>>>> +      maximum: 15
>>>>> +
>>>>> +  "^mediatek,etdm-in[1-2]-mclk-always-on-rate-hz$":
>>>>> +    description: Specify etdm in mclk output rate for always
>>>>> on
>>>>> case.
>>>>
>>>> How is it different than assigned-clock-rates?
>>>>
>>>
>>> This includes clock enabling at init stage.
>>
>> assigned-clock-rates are also at init stage. I asked what is
>> different.
>>
> 
> If the property is used, there are three parts included in dai driver
> probe function.
> 
> 1. set clock parent (which APLL)
> 2. set clock rate (MCLK rate)
> 3. enable clock (MCLK On)
> 
> The first two parts can be done by existing dts clock properties, but
> the last one can't.
> When MCLK should be enabled at boot time and kept on, this property is used. That's why I say the property is designed for always-on case.

Heh, so the "always on case" means this property enables clock? How is
this even DT property? That's not how clocks should be kept enabled. You
need proper clock provider and consumer.


Best regards,
Krzysztof

