Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12763A949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiK1NSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiK1NRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:17:39 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE220346;
        Mon, 28 Nov 2022 05:15:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A944D3FB17;
        Mon, 28 Nov 2022 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669641291; bh=FIkQB5lmPZ4s9NS7JtxyZUKE03ixueajpd0v6qEFWhY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I4j7QaFyIkkiCf6wp4xp7IiFLrNgBX4uvHR4J9RZSgrRabszG/xGCknbFN3Lsv5Vt
         eB38csaqIghQPRuYpLkZBflq9ZVQT2tNkF7uLYihmOQFdHWF4bw63mdMOJdDo6zasE
         dWuaDG7P+Im0nFkATFeSsX4LNJD6dj0/vajMo64hv3GfX8ObB7fK8d17l5cpTJIjPg
         xqorCK/GyExauyLoVS0aww8QuYdWwrUoNMcCi780QD4BbKvBPDFy7ihYcEC8jjtG4t
         YW0S//3Ymvu8jP6Sf6HXGI8CFPM//rQW0LNGaHHZ53BfCWPIBHIXaNqWzVGoaWmSbj
         qD5lfyPZGXvgw==
Message-ID: <0b250757-b7b4-2df9-5d16-1b540fa85b0d@marcan.st>
Date:   Mon, 28 Nov 2022 22:14:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
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
References: <20221128124216.13477-1-marcan@marcan.st>
 <20221128124216.13477-3-marcan@marcan.st>
 <0b608b1e-e7a0-0084-e691-6e957028dd90@linaro.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <0b608b1e-e7a0-0084-e691-6e957028dd90@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 21.56, Krzysztof Kozlowski wrote:
> On 28/11/2022 13:42, Hector Martin wrote:
>> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
>> The hardware has an independent controller per CPU cluster, and we
>> represent them as unique nodes in order to accurately describe the
>> hardware. The driver is responsible for binding them as a single cpufreq
>> device (in the Linux cpufreq model).
>>
>> Acked-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++++++++++++++
>>  1 file changed, 117 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>> new file mode 100644
>> index 000000000000..a21271f73fc1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>> @@ -0,0 +1,117 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple SoC cluster cpufreq device
>> +
>> +maintainers:
>> +  - Hector Martin <marcan@marcan.st>
>> +
>> +description: |
>> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
>> +  the cluster management register block. This binding uses the standard
>> +  operating-points-v2 table to define the CPU performance states, with the
>> +  opp-level property specifying the hardware p-state index for that level.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - oneOf:
> 
> This is enum.

Sigh. Every single time I think the changes are too simple and I
definitely don't need to run the DT checker this time.

I'll send a v5 shortly because this is just me being an idiot.

> Any other changes? Your cover letter say quite unspecific "minor review
> feedback"...

For the DT, the things you asked for ;) (this, dropping the reg
description, and the performance-controller thing).

- Hector
