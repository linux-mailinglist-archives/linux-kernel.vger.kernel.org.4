Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0404D699202
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBPKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBPKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:44:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16D552B7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b2so4053945ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tmGKKfjVIBTMe/d8Q3K3B9sQlvKc2r/WPRmBl0j3Rg=;
        b=onoMjrN1fBlNr/ewi7C0X97B0C0HX9kB5Cf/ZFZMHmYwn0d9DCcS8OlDTB8BkFUbPA
         4oilebj57DPFl5EiQqOdBa4rNQbVk4Tkef4QNpR0XzDHatNmHdsEMJryKOqVz90CThSK
         6H807FxbWmzH1W2yYAJsJOccJzUC/JkE1W+21Hknw8snYRhXZZIZ5Z9NNJRNoDqHiqgp
         Bnhxlu68d/euV+l4geG+44OmG134ckuwzaP4P4LrcDM9DIxnoPjF7H1bzM12TXd+NoKV
         dv1ypqyMz3lJNBhxh7B7Wvhg+kQlcMdBbqL3HMvWqVwwqYxM5kcdV/Bq9jlYgLY99tgA
         C+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tmGKKfjVIBTMe/d8Q3K3B9sQlvKc2r/WPRmBl0j3Rg=;
        b=VsPYImU2nTN78aJViWg/yB2p0NIJ60aZferyBB3iygu2qBxqJTqW0/QX8atit8OaJ3
         /qoFKiSc+A/b85sKJmctwFwmAT459Zt9tFVLJ0DN67vsbiOsC9XVRWSa+uMB6QNbC1+d
         /IWkABluQbQeg25uRqrrNwOe0fAqDG9LlvuqEETJHekwb4yM7nLgBFuek49oZ8nv30JZ
         XK2LZQjQTNMFbvrEDO6yFxQxHINKz0w/9xH3XDGMle+FoMra7FSrrFdyfIPF6uD3yE4w
         7d7AdDskStsQ/IlC0mCOAUpVFa+/6swUy7zyJhp54woQU4JSVlP1M9Ehu+2Qua4nauIz
         xZKg==
X-Gm-Message-State: AO0yUKU1v+KBS+O1mt8lDgkoDqdv0FW57ngr2G0C3TuBw9bTit4OeV/2
        kN5NDlL/+97F6UTdrWLC1Re7aQ==
X-Google-Smtp-Source: AK7set+zAOPDXoym9X0HJWJ3l2oohe7BBFTuWjfmepeqDdLC5b0Q9buCYCxc0feUynlvyuvDy/6l7w==
X-Received: by 2002:a17:906:a40f:b0:873:7108:c6a9 with SMTP id l15-20020a170906a40f00b008737108c6a9mr5864023ejz.32.1676544206460;
        Thu, 16 Feb 2023 02:43:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0087bd2ebe474sm630213ejq.208.2023.02.16.02.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:43:16 -0800 (PST)
Message-ID: <dff2c160-faab-96c9-e37a-182cb47dc01c@linaro.org>
Date:   Thu, 16 Feb 2023 11:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/7] dt-bindings: clock: split qcom,gcc-ipq4019 to
 separate file
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
References: <20230214162325.312057-1-robert.marko@sartura.hr>
 <dcdd0a62-8d1f-d9b1-6137-34d9e68313a1@linaro.org>
 <CA+HBbNHmDeBBBc31OayTjegi4KrAgqOiRLQscorENjqg3dEa3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+HBbNHmDeBBBc31OayTjegi4KrAgqOiRLQscorENjqg3dEa3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 11:41, Robert Marko wrote:
> On Thu, Feb 16, 2023 at 11:16 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/02/2023 17:23, Robert Marko wrote:
>>> Move schema for the GCC on IPQ4019 platform to a separate file to be able
>>> to allow passing XO and sleep clks directly to GCC.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>  .../bindings/clock/qcom,gcc-ipq4019.yaml      | 53 +++++++++++++++++++
>>>  .../bindings/clock/qcom,gcc-other.yaml        |  2 -
>>>  2 files changed, 53 insertions(+), 2 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
>>> new file mode 100644
>>> index 0000000000000..6ebaef2288fa3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq4019.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Global Clock & Reset Controller on IPQ4019
>>> +
>>> +maintainers:
>>> +  - Stephen Boyd <sboyd@kernel.org>
>>> +  - Taniya Das <tdas@codeaurora.org>
>>> +  - Robert Marko <robert.markoo@sartura.hr>
>>> +
>>> +description: |
>>> +  Qualcomm global clock control module provides the clocks, resets and power
>>> +  domains on IPQ4019.
>>> +
>>> +  See also:: include/dt-bindings/clock/qcom,gcc-ipq4019.h
>>> +
>>> +allOf:
>>> +  - $ref: qcom,gcc.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,gcc-ipq4019
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: board XO clock
>>> +      - description: sleep clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: xo
>>> +      - const: sleep_clk
>>> +
>>> +required:
>>> +  - compatible
>>
>> Aren't the clocks now required? Will it keep working without them?
> 
> There are not required, this just allows passing them but the driver is
> still using global matching until in patch 2 XO and sleep clocks are converted
> to use parent data and in patch 3 they are passed via phandles to GCC,
> however, even then global matching by name is preserved in the driver
> as a fallback
> to keep backward compatibility.
> 
> However, I see your point, after parent data conversion they should be
> required by
> schema as that is preferred over global matching.

Yes. Especially that these clock inputs must be there for the device to
operate, so regardless of how Linux implements this, the hardware
requires them, I think.

Best regards,
Krzysztof

