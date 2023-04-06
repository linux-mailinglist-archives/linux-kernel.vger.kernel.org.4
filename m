Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168926D9F96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbjDFSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbjDFSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:13:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD592B0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:13:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-946a769ae5cso127650066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0paXA463L+EtVCwgLqEq3NSi1n2pAWf1P2JKWuvPWs=;
        b=Y1n8htse+WR7urL6ir+GJmrLL+gi84ojRf/71cH7wIhVBZZaB9oWVabYR5D7Ms7Ojv
         oA3EdiinNAkg5fabY+84rdIJhozYXDVbtjjVcuagdvimtJJVQOuM12RZnWWc43OlkllJ
         xdm2R6X3AbSVPZhiLYlZdulDcf2mLTW7VQwB8Mdm7s8L8C0vRfDj7srUpaH1RUSSh6Ps
         ReWp6EH4t3piC+Wv9nYUQEvDdhwLZRhpbPzsG9wy++1+5LgLXSzzBPKCHY8OcKQMAA+A
         nwc8bi07CxKPRjLV6GCQr31homngvDftxTH+EWaCazWAdj1ynoXMouuosMUwzY7CfkEs
         wLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0paXA463L+EtVCwgLqEq3NSi1n2pAWf1P2JKWuvPWs=;
        b=5Z75fo69xlinaAm+FbUSJ4MEs0d07+6/TL+RQblAfgUCPpB/+tsgW4fPWIC1g1gJ2X
         QrqnLB9R7zqKvlnISO2DginbtVcNOBAcsAyNAVMKp2uLcxqRin+sEdxH0FSNp2D3B6cP
         Gj9HKNBr3ibSBgVMXdf+f679FCBgQlGh+QFJ9ECD/N1BcPkQHgTV5rW1NcuSMCvit6mr
         qu7csc6AsaZGRe+1YHRu9WlG2t7E4vIxQxpiGL3bx0FDOfVzw8k+EgjE7UR/IajrucJW
         LL4uixRy4HLL7upwDEYxzQyHx4NrqRh1KMnxD03Qnfl8MLLSjLbKMyYURCzL35kVsBdt
         4qQQ==
X-Gm-Message-State: AAQBX9cp4qa1YIL6YG69xfWEeg1hjdD5feneCvCMYp/l4BivMtesVaUi
        +BZygJiJwgGzVAnEGlB8bjdEuw==
X-Google-Smtp-Source: AKy350Z0nZqHmNbZyz00wB8VMpvO3zmIRtHGjFaIz3WaaX2uNOmQUU3LQPEyXrcYbtDwX0W3JOXPAA==
X-Received: by 2002:aa7:c410:0:b0:4ac:bbaa:867a with SMTP id j16-20020aa7c410000000b004acbbaa867amr354784edq.24.1680804819195;
        Thu, 06 Apr 2023 11:13:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id z98-20020a509e6b000000b004fd29e87535sm1026042ede.14.2023.04.06.11.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:13:38 -0700 (PDT)
Message-ID: <ea1dfe0f-4ed3-9bfb-dc6b-6d87b0267a99@linaro.org>
Date:   Thu, 6 Apr 2023 20:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/8] regulator: fan53555: Add support for RK860X
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
 <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
 <53c803ce-2607-6fd1-485e-e19eb961fd08@collabora.com>
 <231b72cd-352c-10a9-8695-a04f61e36568@linaro.org>
 <8fc46929-6d73-ea75-f44f-b83820c0e5df@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8fc46929-6d73-ea75-f44f-b83820c0e5df@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 13:15, Cristian Ciocaltea wrote:
> On 4/6/23 14:03, Krzysztof Kozlowski wrote:
>> On 06/04/2023 12:08, Cristian Ciocaltea wrote:
>>>>> +	}, {
>>>>> +		.name = "rk8602",
>>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>>> +	}, {
>>>>> +		.name = "rk8603",
>>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>>
>>>> Why do you need this entry match data if it is the same as rk8602?
>>>
>>> This is consistent with the handling of syr827 and syr828:
>>>
>>> 		.name = "syr827",
>>> 		.driver_data = FAN53555_VENDOR_SILERGY
>>> 	}, {
>>> 		.name = "syr828",
>>> 		.driver_data = FAN53555_VENDOR_SILERGY
>>
>> Yeah, I understand, but it's not necessarily the pattern we want to
>> continue. Unless these devices are not really compatible?
> 
> They are compatible, so should I simply drop the rk8601 and rk8603 entries?
> 
> Probably also renaming rk8600 and rk8602, though I'm not sure what a
> proper naming scheme would be to combine the 2 variants for each.

For each compatible family you should have only one entry in each ID
table. Naming of driver data does not matter really. Just use lower chip
name.

Best regards,
Krzysztof

