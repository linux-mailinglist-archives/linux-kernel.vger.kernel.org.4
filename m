Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950216CB851
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC1HiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC1HiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:38:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4942F26A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:37:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so45888595edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679989076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9cVbOj2hTelYElgGTzqGVtpL3knBAwPGkwPEQbuDv8=;
        b=G/qGnUlLPAVRx3hZ8ER0OdGVl5WX+lwJmVbL7h0KgQ9Bs25+SIFKTaDvv11v5e/nqN
         P1XHWSnc0MPYBZegu+r3AkzbfyyIbo9bJKZYGOSKI5qpL6tGKwCNqPpMtnyFsRIki/5L
         eOh0qpJilgtqd5Oxlezz3+ceJGef2UDiqFefjCR+/mBfxVw4ff1vyDcP7unMp9MmFqw1
         8xHPedV4rgsuu9GqbF6fHcG2wsI4K/wggiwbb0xx8b22y4e//D/0y+9HBuv7CEwTaECn
         oo5Gt65coTSTlmsDitMGPKhgDzBpOCIXI543TzeGSXUEKimaB6I1+KWXuMUQPjUGyXC/
         6FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9cVbOj2hTelYElgGTzqGVtpL3knBAwPGkwPEQbuDv8=;
        b=UqCJPvjnzT92+51BG+oB+pDtw2h1Eyo8bW6j5rRV3Uyf2Xlri2HnzeV8dl5oBkNS0c
         2VKZIcqUmOjWsqjP72a8tYD0aJjwKnmfxpy4/ffyaCCQifr0TBztkUGVKVP6OPSE3H14
         QUoStznhHqFPMaxEdm2viqjgh4EK9BLeRuFmOJ04xj7T2G1XKqI48vLUAGJK3e7vPDPy
         dhVK0+RA7twO3Sp2+OcxtxFcDROo9WMTM/m+59vYitiUavREPAqMQn1Q6Af7W+rEHffk
         a1VgDZKY8zpfHvgBeJEBnCDrl6/3oYtwiZ6fg0IMysU8p4PZyl+Ap43XijQvN2XjGAKL
         mH5A==
X-Gm-Message-State: AAQBX9dQVRQxeRg9ssN7CKCOFgNYN9nj6Q6yfsIeN6YVWSmO1w2wRt0o
        NlFFySKl8GtDoKmukEWenns+vg==
X-Google-Smtp-Source: AKy350YhSF13sxJjRSritYNctWoIhjA9llZmiG4TT3T8s7wmQMO9euMgGym/RxdMJW0QiCszqoXonA==
X-Received: by 2002:a17:907:c25:b0:8b2:d30:e722 with SMTP id ga37-20020a1709070c2500b008b20d30e722mr21666345ejc.3.1679989076678;
        Tue, 28 Mar 2023 00:37:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b008d1693c212csm14877174ejc.8.2023.03.28.00.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:37:56 -0700 (PDT)
Message-ID: <74d62ddf-8257-3f67-c33d-b6e76314bc3b@linaro.org>
Date:   Tue, 28 Mar 2023 09:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
 <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
 <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
 <BY5PR12MB425806889EE700C1FCC8A465DB8B9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <1f97dec8-d30c-ccc7-3026-713bf9a15850@linaro.org>
 <84d34a5a-c29b-f38d-2a71-6cf39447b03d@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <84d34a5a-c29b-f38d-2a71-6cf39447b03d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 09:31, Michal Simek wrote:
> 
> 
> On 3/28/23 09:14, Krzysztof Kozlowski wrote:
>> On 27/03/2023 11:58, Potthuri, Sai Krishna wrote:
>>> Hi Krzysztof,
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Friday, March 24, 2023 5:14 PM
>>>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Ulf Hansson
>>>> <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>>>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Michal Simek
>>>> <michal.simek@xilinx.com>; Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (AMD-
>>>> Xilinx) <git@amd.com>; saikrishna12468@gmail.com
>>>> Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
>>>> compatible
>>>>
>>>> On 24/03/2023 08:36, Sai Krishna Potthuri wrote:
>>>>> Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.
>>>>>
>>>>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>>> index 8296c34cfa00..cf44a4b988a7 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>>> @@ -27,6 +27,7 @@ allOf:
>>>>>               enum:
>>>>>                 - xlnx,zynqmp-8.9a
>>>>>                 - xlnx,versal-8.9a
>>>>> +              - xlnx,versal-net-5.1-emmc
>>>>
>>>> v5.1 is eMMC standard or Versal block version? If the first, it's not suitable for
>>>> compatibles.
>>>>
>>>> Also, what's the difference from xlnx,versal-8.9a?
>>> V5.1 is an eMMC standard and this compatible is defined based on sdhci arasan
>>> eMMC5.1 Host Controller(arasan,sdhci-5.1), where as in Versal, it’s a different
>>> controller and it is based on 4.51 Host Controller(arasan,sdhci-8.9a).
>>
>> Mixing IP block versions and eMMC spec versions in one binding is a
>> great way to confuse.
> 
> What do you suggest then?

Stick to IP block versions or code names. The eMMC spec version would
only make sense if you had such possibility:

xlnx,versal-net-emmc-5.0
xlnx,versal-net-emmc-5.1
xlnx,versal-net-emmc-x.y

So exactly one device with different blocks inside. This is very
uncommon, but there such SoC (SunPlus IIRC).

> 
>>
>>> Versal Net Compatible is defined it this way to make it inline with the other
>>> existing SoC compatibles like "intel,keembay-sdhci-5.1-emmc".
>>> Please suggest if the compatible need to be renamed to "xlnx,versal-net-emmc"?
>>
>> Is Versal Net uniquely identifying your SoC or IP block?
> 
> Yes. versal-net is unique identifier for specific silicon with fixed set if IPs.

Then I suggest xlnx,versal-net-emmc.

> Can you please refresh my mind if we can introduce specific compatible strings 
> for this SOC or should we used existing one if functionality is the same with 
> previous SOC family?

It's regular case and recommendation is always (for every SoC) the same:
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

You should add new SoC specific compatible followed by existing one
(fallback).

> There could be currently unknown issues related to SOC wiring out of specific IP 
> version.

Best regards,
Krzysztof

