Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344806E622D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjDRMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjDRMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:30:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145D9C17B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:30:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9514ac7c8cfso53731366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681821012; x=1684413012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RebJ7KlFGR0siwm86EnWjSWViyEw3vNqJd5Fx0fargE=;
        b=k3rBsl8R6I0HUCPUtWmkwwHa+e/z8pHzk0R2ccAZV/j1MR8yHhrOp6+nakU++RBlOE
         oZ294IzekZCd1ikt+zahhPJh6+D3BSTUdQ55qFFwg6L9CyM5NlusLR9boEHOyrO5J6d7
         4u0bJUCGZCEFDdJabe+uOqJSo5gTFcjpW3St9LClsEnucWhWBR7kpmvqUJLGK2v9lD4U
         O/DxYDMOz0XGh6v1PkxXAiYeXbw1xGg2FN4G4zY7IcwCIvdzKD9pFOgz0xjM3vf1M19F
         HQitsfLoO/LlpA9sC5mg1ORedYHgrX6k/4+JdvkgcR/f9cUdDmcUt8ARabKBOtEYaz1v
         93SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681821012; x=1684413012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RebJ7KlFGR0siwm86EnWjSWViyEw3vNqJd5Fx0fargE=;
        b=IuwARohbg09mIR3zdcnq9LTr5D6EvZkBMg0C3zXDRAZxdIF8KVq2bB9MTFbg3jZu1j
         NUncQoxEbxbU1fVG+xnS+njmriiZ4cDsRxd7Y+x+Teu3+ISRp4WOQrlRdGxx2Z/JnXU1
         GTLhPW97T0INHQ6t1/XOt1tx8y8T3y3mv65ybZU881LeRdon8if5wYpwUADQg+nS1F6L
         1xSmMxZLFhBzMLV+40S9N4RGCBb4Qc+i2IT3MWAbs0j/8IW1FU/xyp//xgx4pEI80xa0
         9vlP/JIsR3rW5p6RFlX3esGNxX6ap7/k7QBicShA5Etp6g/SdOIc5u7RiW2gXGL2Tr0e
         qFdg==
X-Gm-Message-State: AAQBX9eRR+syemKGahQGNcRYLWgDhnPADxC4NkuCkMHzHALPVj/52Nj0
        0kUZwEychqA1r4YxhGO7GGVNiA==
X-Google-Smtp-Source: AKy350YfhlmHlX4w/RB2R+FFmHcIcze1lh7/khJZjO6qYv8P8AseVca5DA+ke0RMIVkCXuUL7N9wig==
X-Received: by 2002:aa7:c6ce:0:b0:506:741e:5c1b with SMTP id b14-20020aa7c6ce000000b00506741e5c1bmr1796854eds.12.1681821011855;
        Tue, 18 Apr 2023 05:30:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fe8c000000b00504c33675cesm7010724edt.35.2023.04.18.05.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:30:11 -0700 (PDT)
Message-ID: <d0071447-8521-1a71-6978-7a0f7f6f7d41@linaro.org>
Date:   Tue, 18 Apr 2023 14:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
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
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
 <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
 <MN2PR03MB5197E655DE2EAACAEA2316578B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <1e1fb90a-43c0-3b0a-ab7a-8ca3ce8b02ed@linaro.org>
 <MN2PR03MB51977056C2DC014B0BC7D40F8B9D9@MN2PR03MB5197.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB51977056C2DC014B0BC7D40F8B9D9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 11:41, Arslanbenzer, Zeynep wrote:
>>>> No, use suffixes for common units.
>>>
>>> Hi Krzysztof,
>>>
>>> Thank you for your review. The possible register values of the fast charge safety timer are described in the datasheet as follows. I was undecided about using the common unit, second, as it may affect the comprehensibility of the code. Of course, I can use second as the common unit if you think it's more appropriate.
>>
>> This is quite common property, so I do not understand why this one driver should have it written differently. I understand that parsing
>> 0/1/2/3 is easier for the machine than 0/3/5/7 but it is not easier for humans.
> 
> I referenced property-units.yaml for common units.
> 
> As I understood hours and minutes are not common units in Linux for time so I cannot use them as suffixes. Therefore, I thought I had to use "seconds" instead of "hours" or "minutes". I am totally fine if I can use " adi,fast-charge-timer-hours" and "adi,topoff-timer-minutes". 

Wrap your replies to match mailing list style.

Yeah... indeed... because it should not be in DTS in the first place.
It's not a property of the hardware, so the same as with other drivers -
we don't store it in DT. Check other maxim drivers.

> 
>>
>>>
>>> 0b00 = Timer disabled
>>> 0b01 = 3 hours
>>> 0b10 = 5 hours
>>> 0b11 = 7 hours
Best regards,
Krzysztof

