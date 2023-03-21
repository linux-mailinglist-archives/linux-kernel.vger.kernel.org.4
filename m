Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF496C2A78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCUGe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCUGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:34:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342023B3CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:34:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so22677645edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679380455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7y6CEKyo9f4ym50W2J1VElNR4r7uzh+824EqBJttEg=;
        b=Mm5SHrWvt/C11CxBWPSs8OB5e0OmziG7kCV6tRt0IbilF4n0xQZSLrcCAvBOZAUCdD
         uyUEaL1w+TtX4rK16Epy3/9mHFp5wKyHv71UKR89yxpggDPaRjvzfgkYMPWJS7hvIRar
         /N0cgAMvBKGQgqAui1Pcl1ht41Qv5LHZmMWeJOLfIbkGpGVEeAexbHKlJDXLVpXqCXFr
         fnB82qAJ3FEwx3TkSnMNIcfajhVapOosI8LzCw3ajeLvfGckc389k0MG5p7QnwN9J0Da
         UAfNgQajaEmLOEQiYk4WVirZyD5BmXVpEWX/YOc6jelX8k+npy6gAmom9VSAWxn6tCPY
         P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7y6CEKyo9f4ym50W2J1VElNR4r7uzh+824EqBJttEg=;
        b=rTI0yRaMFKY2jFMVlvJvqUvb3epEWL2miq3eshRASOWfFC4EDxqiNUO7H4FBWZAeXA
         HOlfVsOAOEy7GQiIUXTqLu5nBvlriHJzEWkSNVD21mUXrJyoTryPyjWpGYE/gtqygael
         WzEGV4Nv4yJQU1koIwnAocTXE4RnCaSl8j4gSufirlcSJJ9e8TD4iNmEi4Fiz4Ff2o4H
         /+91UA7Nmv71aQh8fxN4lCqCTKfevUjEKxd7AXjfGdTYVEvKK9LvM38SL65Id07yNgtf
         i1s15tJCm1F1pv2oJZKVw/GTzzJzL8pco5g/BP7Typn8RAXoMhgj+Nt0d3H7lnEHeIbj
         jj4w==
X-Gm-Message-State: AO0yUKWAsZpGKIVXbRFw6jYyYUrYSCSzG64tFjD8F6D6DA4B0OrnbzTD
        N1XLfKLscGBYVc+KIwTDgo8CSg==
X-Google-Smtp-Source: AK7set+rivmM7028r39gA06BxStCr476bAgL3eYIZfoGXmza0rkmeJjO0OTLxMLISJVbixQsjd443Q==
X-Received: by 2002:a17:906:2a90:b0:8aa:1f89:122e with SMTP id l16-20020a1709062a9000b008aa1f89122emr1426902eje.39.1679380455530;
        Mon, 20 Mar 2023 23:34:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709060ad800b0092ffc83cc27sm5353883ejf.5.2023.03.20.23.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:34:15 -0700 (PDT)
Message-ID: <b3365947-5567-2fd7-1bb7-34052c40e5f6@linaro.org>
Date:   Tue, 21 Mar 2023 07:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <5109c01b-48bd-2854-3f42-bf8ef8b4a821@linaro.org>
 <9cfd5bc1-64e9-5250-5a8d-18ac4c205584@arinc9.com>
 <f323f1bc-1d91-f8bb-2c1f-2f1b93fe1b3e@linaro.org>
 <6a8989c5-f12d-a4cb-9b20-29049dee016e@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6a8989c5-f12d-a4cb-9b20-29049dee016e@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 19:23, Arınç ÜNAL wrote:
> On 20.03.2023 21:11, Krzysztof Kozlowski wrote:
>> On 20/03/2023 19:07, Arınç ÜNAL wrote:
>>> On 20.03.2023 21:01, Krzysztof Kozlowski wrote:
>>>> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - ralink,rt2880-sysc
>>>>> +          - ralink,rt3050-sysc
>>>>> +          - ralink,rt3052-sysc
>>>>> +          - ralink,rt3352-sysc
>>>>> +          - ralink,rt3883-sysc
>>>>> +          - ralink,rt5350-sysc
>>>>> +          - ralink,mt7620-sysc
>>>>> +          - ralink,mt7620a-sysc
>>>>> +          - ralink,mt7628-sysc
>>>>> +          - ralink,mt7688-sysc
>>>>
>>>> One more comment - this and maybe other compatibles - have wrong vendor
>>>> prefix. This is mediatek, not ralink.
>>>
>>> This platform was acquired from Ralink by MediaTek. I couldn't change
>>> some existing ralink compatible strings to mediatek as Rob explained on
>>> my pinctrl patch series that we don't do that. The compatible strings on
>>> this patch series here are new but I'd rather keep the compatible
>>> strings ralink to keep things consistent.
>>
>> The comment that you cannot change existing compatibles does not apply
>> to these, because these are new. However indeed some SoCs have already
>> compatibles with ralink, so it's fine for these. mt7620 and mt7628 are
>> already used with mediatek, so these should be rather corrected to new
>> prefix.
> 
> If you're talking about the pinctrl schemas for MT7620 and MT7628, it's 
> just the name of the yaml files that have mediatek. The compatible 
> string is still ralink so it should be kept ralink here as well.

No, I am talking about compatibles.

Best regards,
Krzysztof

