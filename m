Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFC6F693E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEDKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:45:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37349E3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:45:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so444887a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683197128; x=1685789128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kbnLTEp2yBlKAAmaLqoi0wepN0hkxEBOJrNBPjDWDk=;
        b=R04FPhe1JctQvzrxdXVgR4qnCj2LY/3mmJkIqOvkIwk7yq3Vu1KPJrGW9VVHcwjFGE
         MGoxpAiS+LNuylnFjDEC5ZjSu7oVsA+tvNvXZc9+sacXCcmVQD+vIOeDs6FJonrsR7a9
         x0Q23Drln1ivOYRHj5Cf5kUOMrDPabSvKuV0a9LWXW8pQjlcIjIHnCX8zwSCkyf7jOgs
         +JhAcGFn8IG6GQ4SndjloV2bL6P3NsVpQKmBOpSilsueWPQG6HkrkksG95wl47TisBTs
         +vy6gm+0VPAi/bIZMMQUzOleXQ5f1uCUYNddMiRzMQfLVsSKqCcg+wShFaEQeOyRvpZz
         z8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197128; x=1685789128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kbnLTEp2yBlKAAmaLqoi0wepN0hkxEBOJrNBPjDWDk=;
        b=JiXnL2XED4uCwbApqq+J4T4Rdf5GNG3XxI42JdZrhGiPk93WwjB2zb5rtcFqyHRrcS
         TTFlDbtjO4GQXiR7Y7G0ahmCa5dT9U5V29bKQxWdv9nivizOeUQwNMDZDavpzXyLIkF7
         3nL2RjUVFWIPueX6tnnS7n2N3AsqJj2jEkSlu6JEjo3jv6MihoKIsCiRiD2fYV1nn4Cp
         8o8122lj8zfhwSF5+RGEZuMvP1xbwPN+V3uyIrVnMauHgssDZKS9h4GnNQm3nMO2TPcP
         SNSvGMqyfQbHlpdyHgiJ3EQFGU/+nYVxowMf6/Qg7voMNRXjjkxNpqKWe5zHhIvB7SLN
         3aFw==
X-Gm-Message-State: AC+VfDxGT723Fz0rG8J3GcXsgEGdAbPDNww9C+h5EcPnBLhcDciqYGdo
        TDmkilu8MWmjf+Gkxfu5w4m6bA==
X-Google-Smtp-Source: ACHHUZ6n3V+rr3/dW0RrNVam5YEv4mqxuLEWesUPl3GkDY22G7wyaBdB3kWoGFLDtzVFkQ7ua/lFlw==
X-Received: by 2002:aa7:c2d9:0:b0:504:b228:878d with SMTP id m25-20020aa7c2d9000000b00504b228878dmr1325015edp.25.1683197128237;
        Thu, 04 May 2023 03:45:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b0050bc6c04a66sm1743127edo.40.2023.05.04.03.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:45:27 -0700 (PDT)
Message-ID: <e585f4e2-1914-0a3f-9e32-dffbac82b4fe@linaro.org>
Date:   Thu, 4 May 2023 12:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Content-Language: en-US
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
 <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
 <MN2PR03MB5197DF4EEA50D6CB5DF311098B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <07c36d46-76c0-1bad-a124-55b96aff8347@linaro.org>
 <MN2PR03MB51973E709B85F83606D987038B6D9@MN2PR03MB5197.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB51973E709B85F83606D987038B6D9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 12:36, Arslanbenzer, Zeynep wrote:
> On Tue, 2 May 2023, Krzysztof Kozlowski wrote:
>> On 02/05/2023 08:32, Arslanbenzer, Zeynep wrote:
>>> On Wed, 22 Mar 2023, Krzysztof Kozlowski wrote:
>>>> On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
>>>>> Regulator driver for ADI MAX77643/MAX77654/MAX77658/MAX77659.
>>>>>
>>>>> MAX77643/MAX77659 has 1 LDO regulator.
>>>>> MAX77654/MAX77658 has two LDO regulators.
>>>>>
>>>>> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
>>>>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
>>>>
>>>>
>>>>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct platform_device_id max77658_regulator_id[] = {
>>>>> +	{ "max77643-regulator" },
>>>>> +	{ "max77654-regulator" },
>>>>> +	{ "max77658-regulator" },
>>>>> +	{ "max77659-regulator" },
>>>>
>>>> Why do you need so many entries? They do not differ.
>>>
>>> They are slightly different. Just MAX77659 and MAX77643 regulators have 
>>> exactly the same features. MAX77659 and MAX77643 have 1 LDO regulator but 
>>> others have 2 and the voltage base of the MAX77654 regulators is different 
>>> from others. Should I use the same entry for the MAX77643 and MAX77659?
>>
>> Your driver does not choose regulators based on these compatibles. Your
>> of_device_id table claims all devices are fully compatible and do not
>> differ from regulators point of view. If they are different, you should
>> encode the difference. If not, use only one entry in of_device_id (only
>> of_device_id, not bindings).
> 
> I used id table matching and I did not use of_device_id table. Should I use 
> OF style match instead?

My comment stands regardless which device ID table you use. It's the
same mechanism.

Best regards,
Krzysztof

