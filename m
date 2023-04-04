Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD746D61CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjDDNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjDDNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:02:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE141731
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:02:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so130126880edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680613337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80YBPi+85zCnOkMuZy/EOCJgSFeaKJCfBUB0QXoMJG0=;
        b=n9c4JUKx+rSAWG3kH+jFpCPCju35S2p0ig5Szc/q2VRDyUfttMRDmgoXNqSX8dC5Um
         QCkapdOErvevGkUPysYDk1W/A582aXWjKE5a5BNq7Eh9MEdtH8ysVCQnt+4SV+wRgSiQ
         iAB6iQzhfbcU5+SR4y/bPpSCiOrT5g+P9DZRHMgQO/Q2PArngIWvPdf69/26Uqk9uRnm
         bVcv2j6SNqTEZG5u1xKS9sVWybQADCF5W9LyjwAIPY17BlUdLfBFkK0Ho+1d+86dIBeQ
         ggTuSsovpCQ3aGOA2GfrPdm+sa7GCq5G4cxZLl2boJJiRiIxkhYUM4YPEsEaCZSIwZ7y
         ddiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80YBPi+85zCnOkMuZy/EOCJgSFeaKJCfBUB0QXoMJG0=;
        b=ydiemsMqp2ILS67oA33fiL9iMdUwhFMbfigfbjVfhIwnxuP6yN1veSaPEDkjyID2+y
         3cbqrzbU/4M0XP4NTRH70BDxfD9buY/dGZA/4d26mVjMZrQBdDVdLHn0Sns8Fg3HdrOs
         Inbtv6AizSrfBekQFNjYcENIRkqggwBVOInLKycg6Xh380eD3N7MTbxEoHLr5UE1bhnx
         WIgG3f7JtIE47wzXiqgCkEOp78UnjIAoU9s1bhFNjbC3m5J+H46Sza+D8HnRNTcWR1JO
         7kaOJFycOrEEyLPU52DHP3sNIJzIM2EKpcXkLdTIbzqN3Ta8pPFrp4uTV7UTTKLfXYKM
         K3lA==
X-Gm-Message-State: AAQBX9fNHcJcXlK8H17J0S26mAjZqwOLMF1NcTG1Z/HqeXh7mnPrmQGD
        sqDOTPshnbxjpUGUe4cxVVI3mQ==
X-Google-Smtp-Source: AKy350aF8oPMiNgn4tk1wpZPkLE/N6LCtJYbRyyIQqV6ip9JZ5rFaqVYWqODG9QkmJpKUvt6S7C6AA==
X-Received: by 2002:a17:906:27d4:b0:930:3840:1c4d with SMTP id k20-20020a17090627d400b0093038401c4dmr2207998ejc.32.1680613337609;
        Tue, 04 Apr 2023 06:02:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7467:56f4:40b7:cba8? ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id e27-20020a50d4db000000b004fadc041e13sm5884140edj.42.2023.04.04.06.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:02:17 -0700 (PDT)
Message-ID: <68bc0c88-541d-269d-58d2-67dbe6d44b7e@linaro.org>
Date:   Tue, 4 Apr 2023 15:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <CY4PR03MB2488DFC99C23ADE16FF40E2F96939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <1efdb870-cac2-f6ed-72b5-d0550dbb5257@linaro.org>
 <CY4PR03MB24883E0406C2A16E566DB39196939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <202304041226162e231e78@mail.local> <2023040412291166c04438@mail.local>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2023040412291166c04438@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 14:29, Alexandre Belloni wrote:
> On 04/04/2023 14:26:18+0200, Alexandre Belloni wrote:
>> On 04/04/2023 10:35:53+0000, Tilki, Ibrahim wrote:
>>>>>>>> +  aux-voltage-chargeable:
>>>>>>>> +    enum: [0, 1, 2]
>>>>>>>> +    description: |
>>>>>>>> +      Enables trickle charger.
>>>>>>>> +      0: Charger is disabled (default)
>>>>>>>> +      1: Charger is enabled
>>>>>>>> +      2: Charger is enabled with a diode
>>>>>>>
>>>>>>> 2 is not an allowed value. I asked to drop this property. It is coming
>>>>>>> from rtc.yaml. I also do not understand "with a diode". So otherwise it
>>>>>>> is charging with, I don't know, FET?
>>>>>>
>>>>>> No, what is not explained here (and maybe not unsterstood by the
>>>>>> submitter) is that the RTC has an extra diode so, charging will always
>>>>>> enable a diode, select a resistor and then have or not an extra diode.
>>>>>> Figure2 of the MAX31329 datasheet is great.
>>>>>>
>>>>>
>>>>> That is exactly why I had "adi,trickle-diode-enable" property in previous patch.
>>>>> So if I can't have "adi,trickle-diode-enable" and can't add an additional value
>>>>> to "aux-voltage-chargeable", I am not sure how to add support for the extra
>>>>> diode at this point.
>>>>
>>>> Ask the person who asked you to remove adi,trickle-diode-enable...
>>>
>>> That was the purpose.
>>>
>>
>> If the earlier submission was clearer my answer would have been
>> different but note how I had to dig up the datasheet to understand there
>> were two diodes. All the trickle chargers have a schottky diode so
>> "adi,trickle-diode-enable" nor the commit log were explicit about the
>> second diode (which is a regular diode).
>>
>> aux-voltage-chargeable is enabling a diode on all the existing RTC
>> drivers so instead of trying to make me look like the bad guy you should
>> rather thank for taking the time trying to get better DT bindings.
>>
> 
> BTW, Krzysztof, you should focus more on how v5 of the driver is still
> abusing the #clock-cells property to do pinmuxing after I repeatedly
> explain to not do that.

Uh, I assumed #clock-cells in the binding is for its purpose - clocks. I
am rarely verifying driver implementation.

Best regards,
Krzysztof

