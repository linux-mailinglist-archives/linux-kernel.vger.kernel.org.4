Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAE60DA40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiJZE0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJZE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:26:46 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE89F37D;
        Tue, 25 Oct 2022 21:26:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5D3CC41A36;
        Wed, 26 Oct 2022 04:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666758402; bh=qm4aYyGD3DVLhKfzPb+ArUTMkaciiOa9Q8FLwCVwMD0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=lGKtkQC7s7ikOWouDCY6qM1YdysnmQYFLx0332XvWc3ve5WT9Wiz3b16tpVGKWYNl
         GmF8bJylUXOZC//eEhbYXfdpbFr2rqsl9hLTrfgfquPNZ0pCXvCS8TAEGUt0F1qhaN
         V3SCMmp/6cn5/jUV3FNzSKUioD8I9WxmyIST6nxPqbKVeLo26Lj9LZcnCL7iBuu2I1
         g5A28rmRIp5NGzLlHi1zcs/q3Bae1bn4bi41bAV2axPO1Kn0dZ6Q0xtQxYDL7qs4en
         4aUMbmHuyT0Fwin274QzxgjKvXkMywT0SYu4aC4eJdoP0j/UOAyqi+xGFGLTNDlumg
         5CRTXII9xQimA==
Message-ID: <d4596ae0-d0ff-a33a-c436-f00abf12d115@marcan.st>
Date:   Wed, 26 Oct 2022 13:26:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
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
 <20221025231236.GA3416036-robh@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 2/5] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <20221025231236.GA3416036-robh@kernel.org>
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

On 26/10/2022 08.12, Rob Herring wrote:
> On Wed, Oct 26, 2022 at 02:22:40AM +0900, Hector Martin wrote:
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
> What does compatible mean here? IOW, what can a client do with 
> 'apple,cluster-cpufreq' alone? It's one thing for self-contained blocks 
> to remain unchanged from chip to chip, but things like this tend to 
> change frequently. It looks like for 4 chips we have 3 different 
> versions.

This is described in the cover letter. The actual cpufreq control is
identical for all shipping SoCs right now (that's 5 SoCs, since t6000 is
actually also t6001 and t6002) and will work with just that generic
compatible (and almost certainly quite a few SoC generations going back
too). It's just that I found a useful register that gives you feedback
on the *actual* pstate, and that register field shifted one bit on t8112
because they ran out of bits. If the driver finds a t8103 or t8112
compatible, it will use that register to accurately report the current
frequency (subject to boost frequency restrictions). If it doesn't, it
will just report the requested frequency as actual. t6000 is compatible
with t8103 in this regard, hence the tiering. I expect lots of future
SoCs to be compatible with t8112, since although they exceeded 16
pstates there, I doubt they'll push beyond 32 and have to move it
another bit any time soon.

Right *now*, since boost frequencies are unachievable and disabled due
to reasons unrelated to this driver, all compatibles are, in fact,
completely equivalent in functionality for end users, and nothing would
change if we just had `apple,cluster-cpufreq` in the DT. This will
change once we get cpuidle support, which unlocks boost frequencies as a
side effect, but that will require no changes to this driver/series
(other than uncommenting the extra OPPs in the DT).

- Hector
