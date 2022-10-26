Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74B60DA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJZETJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:19:05 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD69AE230;
        Tue, 25 Oct 2022 21:19:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ED1B242118;
        Wed, 26 Oct 2022 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666757941; bh=qhzUPcOcF+OJLNGytglyLThvv/BfpWhoB/mxl2yogrU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=w6sr6724xSL1yO9EbVvKuD031mN4mcy99nmvPLmV9qnV6f9fWKmjIjPM3jruM5InZ
         6ORBrw4bHaovI5t4ANlpxrFQ8LWhQRcNNgZS7VyLCNRvxDGTWHoqdHzd87C3xr3Q63
         kzLQ4ZGOBNMn/9hgMhAq9sqCokn64sdewjIzX6fmEeuZrnTp6KUjwXMSNZWNxF7AHG
         Ukg0bfAPbedffj8iWExnUNxeBsAinDRl7PN0KBU1dA2Sza+gjvxCh02Lufyh/rkSi+
         Ku313v+2m73H03CF5Nv6cTd/rkElGaF/K40PvWAddSI7Y+KcaZZ9nu8bGQzFTUjygY
         s/L6BxUAnnkWA==
Message-ID: <0f76c1b5-8fe5-e3dc-dc9a-7b0ad9660275@marcan.st>
Date:   Wed, 26 Oct 2022 13:18:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-3-marcan@marcan.st>
 <5c3126fb-8fdb-5163-95a8-136a4a7ee2ce@linaro.org>
 <97d3d6d4-b19c-a194-de41-f17e65bf3eb6@marcan.st>
 <21602556-8312-fb7a-1981-cd03a314d904@linaro.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <21602556-8312-fb7a-1981-cd03a314d904@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 03.56, Krzysztof Kozlowski wrote:
> On 25/10/2022 13:22, Hector Martin wrote:
>> On 26/10/2022 01.01, Krzysztof Kozlowski wrote:
>>> On 24/10/2022 00:39, Hector Martin wrote:
>>>> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
>>>> The hardware has an independent controller per CPU cluster, and we
>>>> represent them as unique nodes in order to accurately describe the
>>>> hardware. The driver is responsible for binding them as a single cpufreq
>>>> device (in the Linux cpufreq model).
>>>>
>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>> ---
>>>>  .../cpufreq/apple,cluster-cpufreq.yaml        | 119 ++++++++++++++++++
>>>>  1 file changed, 119 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>>> new file mode 100644
>>>> index 000000000000..b11452f91468
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>>> @@ -0,0 +1,119 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Apple SoC cluster cpufreq device
>>>
>>> Few nits, in general looks fine to me.
>>>
>>>> +
>>>> +maintainers:
>>>> +  - Hector Martin <marcan@marcan.st>
>>>> +
>>>> +description: |
>>>> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
>>>> +  the cluster management register block. This binding uses the standard
>>>> +  operating-points-v2 table to define the CPU performance states, with the
>>>> +  opp-level property specifying the hardware p-state index for that level.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: apple,t8103-cluster-cpufreq
>>>> +          - const: apple,cluster-cpufreq
>>>> +      - items:
>>>> +          - const: apple,t6000-cluster-cpufreq
>>>> +          - const: apple,t8103-cluster-cpufreq
>>>> +          - const: apple,cluster-cpufreq
>>>> +      - items:
>>>> +          - const: apple,t8112-cluster-cpufreq
>>>
>>> With the first one (t8103) - it's an enum.
>>
>> This is deliberate. t6000 is compatible with t8103, but t8112 is not
>> (though all are compatible with what the generic apple,cluster-cpufreq
>> compatible implies).
> 
> I was not talking about t6000. I was talking about two entries - first
> and last - which should be just an enum. There is no compatibility, so
> what is here deliberate? To not make enum things which are an enum?

Sorry, I didn't understand what you meant. You mean that the two entries
should be merged, with an enum for the first item listing both SoCs, right?

- Hector
