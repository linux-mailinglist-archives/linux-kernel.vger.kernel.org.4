Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4462265C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKIJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKIJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:10:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A8C13F93
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:10:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g12so24721294lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUlln+ES2ofzMXPrsOfnswoOHDIO3bY22Pgx0Ay6WPk=;
        b=MV68C3n0GQICSLAwp00AC9yglzAQp1vfaxo/B4ue5Ry1xKj5I31QZ3OTCdwPCovuog
         yHFAAIvUqcGEyaY93e4482AMThuXynpm5+oooGCu0mO/ElSaPS5HUGNRiNxIwp74zZ62
         B0yxpDjeS66ucs65FDeHoVu1jrpQAIZtPy7jin4QZ882MNwaIZr+ZIUcfq79+PggXNfp
         g4sKuDUxO6adM99W7/C/6LAEL74lbZck8V8Pwo3f9u4RUIGMjJ7JpTILJCXSfJrYuXLC
         sCiBva43F0x3hAa0/b2t7DEDi/OZLP4ghwYcJ7h/YzYm76cUI5xFOmTodewE5Lg5nQFU
         NeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUlln+ES2ofzMXPrsOfnswoOHDIO3bY22Pgx0Ay6WPk=;
        b=wG7GdmzbZ0KTPsgFxf6bjOZ2oobF+7YBR1BGgug5GeFOj04m2NUtBLDtqE1iWPa81k
         LEHeJl/Q+tdIMrel49bx2sFvNZu6ocM3AcKlTTplrHvgsNVGH9mmg8yUpb2BA2eZBJ3W
         MtAw6Jitxabo8DZG0lxOKYfRc4LPObt3ilL8SoVF6iu53Pw6MKdET3SQVPDWuZhd3CNM
         Va8CMoCmmROW/hA4RKIJonzOluaTo48EHHMbaskIN6fmQS8ZLk3lRzPqf2gON4DkMzMa
         hGAkKAsY35zHLGidIdVqHwRWQXVW0mrnptCymBQY7zIq0uPnnsT8jM4wD//gpmXw85On
         g7Nw==
X-Gm-Message-State: ACrzQf1wEjvYS9gsLpXcyB6EEw0zFaw8rpK1jGBARFqU5NKalzQmzujA
        Z8lHwpZ/wdeZICtk+iY67gTxww==
X-Google-Smtp-Source: AMsMyM6zn9x5eBceIcU5kdwdfaIIlWzZdFcVKfBMxaLydrD0GLJQMJC7mHVFI85gHOXKRtsixil4rA==
X-Received: by 2002:a05:6512:2391:b0:4a2:8cac:96ab with SMTP id c17-20020a056512239100b004a28cac96abmr543443lfv.415.1667984999434;
        Wed, 09 Nov 2022 01:09:59 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t12-20020a195f0c000000b004994117b0fdsm2134927lfb.281.2022.11.09.01.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:09:58 -0800 (PST)
Message-ID: <48094cb6-4662-d2ac-f5c8-371dd4cd5917@linaro.org>
Date:   Wed, 9 Nov 2022 10:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Content-Language: en-US
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
References: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
 <20221108035030.1040202-2-thippeswamy.havalige@amd.com>
 <d45ea394-5c51-2f95-e5ef-641af663fbb3@linaro.org>
 <CY4PR1201MB013577DE905AF12D1F5E03BA8B3E9@CY4PR1201MB0135.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CY4PR1201MB013577DE905AF12D1F5E03BA8B3E9@CY4PR1201MB0135.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 05:33, Havalige, Thippeswamy wrote:
> Hi,
> 
>>> +  dma-coherent:
>>> +    description: Optional, present if DMA operations are coherent
>>> +
>>> +  clocks:
>>> +    description: Optional, input clock specifier.
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all requested
>> changes or keep discussing them.
>>
>> Hint: same comment as v3.
> 
> Sorry I assumed it only for 'Input' and not Optional.

Missed comment was maxItems: 1.

Best regards,
Krzysztof

