Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214A660FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjAGPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAGPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:07:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B0669A9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 07:07:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g25-20020a7bc4d9000000b003d97c8d4941so5538449wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5NdmOy1Ai82n93j2R+2KO8HXukW+/GStni2h9f4Guo=;
        b=J2grbRRYLvRvHQMNex7quauPQpxtJI12KZZofBJvtRSuVlLdQJ/OeU30i6jI10nCc6
         U2Hvlg6vgdFkr3qrJvQXio75A+5k/rxuaHC9VFUE6QUIk4YAxjdss1rDu1HJNbyp9CZo
         1J9QeRwewJg64YAZxER6eiozsN4budlK1N1b+whwLwhNaFNBRO9HdxHLe3gYitFmyjlv
         6UbNZqD9FuYnjCisYHdG3X7n40fA8diSShoUA1Q1M5sqglvOxK8fRh0SBJs6qIPZXuhU
         ZIGP152Xk7jk/LhHPqRYzbJ7SrUIhLSFWDO4nQ+XcwxjDViC5YLRohZMy+6uaLyfBRVg
         +onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5NdmOy1Ai82n93j2R+2KO8HXukW+/GStni2h9f4Guo=;
        b=O+hNmFXa8K7GAD5iQI6tmaE6fovL05p/MjLj28mRMSusJWACW87AKV6jzl/mjrDGhV
         jwGr4RUVu+Zj5PnQpuOpGTCK1PhnZAEG/yVDuVA3ii3YeKeKIXsGnV4b/iqVEoccilAm
         gsVVyeiz59R2aefNui5kPQuA93F1Ji40bTmemb0nI+I057rCV8DXXTiEr8Pz+4yGN91e
         4Y5OBNPsKl9f368gtkUtyq/K5JconYbgeH1fhTkRKq6Au1UUiE+LF3WBYT9nfG7thyUs
         ItIIjAk86X958X7l+WHfJSAw7CkSohbU5OD+5fhaha+RPkuv5UIFpJu97EOJ7xhyofBp
         ulrQ==
X-Gm-Message-State: AFqh2kq9TBZD1nKBgOLqrbrZZ/PVZ1YI0x5aHjuXyiLBgkWnTzcjjj/s
        3QW+R9782ngQjEAP8txn7Cqzpg==
X-Google-Smtp-Source: AMrXdXtQ+AVqw4FmyKIXZ2qw5rRUUMYF+o2woAsQxnVzG1eBHl9KZ2kRFMIfKUD/kbeeXOvMWwv7iw==
X-Received: by 2002:a05:600c:1c21:b0:3cf:9844:7b11 with SMTP id j33-20020a05600c1c2100b003cf98447b11mr50993432wms.23.1673104058040;
        Sat, 07 Jan 2023 07:07:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003cf5ec79bf9sm6034449wmo.40.2023.01.07.07.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 07:07:37 -0800 (PST)
Message-ID: <e1b1450b-9421-3732-2d74-50c47b5afb0e@linaro.org>
Date:   Sat, 7 Jan 2023 16:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
 <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
 <20230107150740.0ba34aa1@aktux>
 <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
 <20230107160105.66df4136@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107160105.66df4136@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2023 16:01, Andreas Kemnade wrote:
> On Sat, 7 Jan 2023 15:09:24 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/01/2023 15:07, Andreas Kemnade wrote:
>>> On Sat, 7 Jan 2023 15:00:56 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> [...]  
>>>>>> I asked to remove half-compatible. Not to enforce.
>>>>>>    
>>> so you are saying that allowing
>>> compatible = "A", "B" 
>>> is not ok, if B is not fully compatible. I agree with that
>>> one.  
>>
>> I did not say that. It's not related to this problem.
>>
> You said "I asked to remove half-compatible" that means to me
> remove "B" if not fully compatible with A which sounds sane to me.
> 
>> Again - you cannot have device which is and is not compatible with
>> something else. It's not a Schroedinger's cat to be in two states,
>> unless you explicitly document the cases (there are exception). If this
>> is such exception, it requires it's own documentation.
>>
> so conclusion:
> If having A and B half-compatible with A:
> 
> compatible = "A" only: is allowed to specifiy it the binding (status quo),
>   but not allowed to make the actual dtsi match the binding documentation
>   https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
>   and
>   https://lore.kernel.org/linux-devicetree/20210924091439.2561931-5-andreas@kemnade.info/
> 
> compatible = "A", "B" in the binding definition: is not allowed ("I asked to remove
>    half-compatible" (= removing B))

No, half compatible is the A in such case.

> 
> having mismatch between binding definition and devicetree causes dtbs_check errors
>    -> also not nice.
> 
> I rather drop this patch and learn to live with dtbs_check errors
> for this one since I have no idea how to proceed. All roads are blocked.
> This all causes too much churn.

And why you cannot implement what I asked for?

Best regards,
Krzysztof

