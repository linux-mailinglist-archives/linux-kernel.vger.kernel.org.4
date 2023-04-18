Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441946E6902
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDRQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:10:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FEE67
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:10:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fw30so21790596ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681834218; x=1684426218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J61Na07hGCkQ1KuLYjiBLVLpdGvMenY/upJoZnjMSn0=;
        b=saJh1JDYpAps5A8IvRMIbctMsx/rRsHIvpac2Q5NdTMLsGtHp1WJusAdGQACvdrhhe
         updya1CADurvN4f69bSK0keoZj+ZwXgV/OoTdVowutfo6WzgvCRUpMkAC3bwy2EPGcii
         4QFPQnbWgCp3gj/g5X9sKkvIazTdQ/p/pDf7k4ORAG7sGgagbvHCj8q5B1FZ3r6lKWcO
         NNIN9cD+cKnFKTvZqZm9DiLcL6jcL/mg4NoJt5n68USEWFFufTdaXpBdgMP9PIDf/uCy
         r7moKlv8EPkpj2a7PXuTJsbzfplYVC7NK56EgYV6rIXUjEnXRH6eSxVQIOA/6SIBAGMz
         VNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834218; x=1684426218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J61Na07hGCkQ1KuLYjiBLVLpdGvMenY/upJoZnjMSn0=;
        b=OWbqSSoRPCSmCLiAshKDT82perdnoD3mzPzQzgDhqr5gcMh986Q6baE9QdMnbQLxDM
         JCYNBfI1O2K6i9H8KVuTKgPeM/6iCDAzZUo0e7F1sDYujl4pNQsFwnFp+uKNsUaS48Ux
         qh0b2QuehflBH39OnaFPdf6d7Ix3ZaDHFsqAtyPXO6jE45yfU2o7blYsy6GBwZj10qmL
         YDVQzBDpFfgAh35BCD8kG/dn2XO2bobDG22XnXkXhO9Ytiu6eZNHVLsx4tt96GWKsJNN
         Oq3VicVEyp3BwKYxjCnpcrVy+09vz7oieDPS8Dmy+moGktVJRo1Pjw0kyzx+wHn9LE3i
         /LZg==
X-Gm-Message-State: AAQBX9eGtuBD9E09ptehyZoQWFr9f1CsJ9HePeHsrESrXuDFDhIiI/kl
        bqjH7ITGsk39kVlFDbd3dU0WIw==
X-Google-Smtp-Source: AKy350YCjKqxq98DjI5ho6miiDb3QwnGD3Ctdpyy172e5x8e2GthnxvlV/UnS3C0q4HnyZh6sr1Q/A==
X-Received: by 2002:a17:906:505:b0:94a:7450:9e2e with SMTP id j5-20020a170906050500b0094a74509e2emr11340754eja.32.1681834218578;
        Tue, 18 Apr 2023 09:10:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id wf7-20020a170907d68700b0094f71500bfesm3342722ejc.4.2023.04.18.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:10:18 -0700 (PDT)
Message-ID: <eb6bfe2e-1e44-bfb5-01b9-bbf53eba6501@linaro.org>
Date:   Tue, 18 Apr 2023 18:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20230414105225.194195-1-n-francis@ti.com>
 <20230414105225.194195-2-n-francis@ti.com>
 <40498f71-d0cd-e7af-6515-c60a8d1edce8@linaro.org>
 <d4a017e6-6df4-fc50-49c4-12c53719b7c0@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d4a017e6-6df4-fc50-49c4-12c53719b7c0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 10:56, Neha Malcom Francis wrote:
> Hi Krzysztof
> 
> On 14/04/23 17:10, Krzysztof Kozlowski wrote:
>> On 14/04/2023 12:52, Neha Malcom Francis wrote:
>>> Document the binding for TI K3 ESM (Error Signaling Module) block.
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
>>>   1 file changed, 54 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/esm-k3.yaml b/Documentation/devicetree/bindings/misc/esm-k3.yaml
>>> new file mode 100644
>>> index 000000000000..5e637add3b0e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/misc/esm-k3.yaml
>>
>> Filename matching compatible. Missing vendor prefix and device name.
>>
>>> @@ -0,0 +1,54 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022 Texas Instruments Incorporated
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/misc/esm-k3.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments K3 ESM Binding
>>
>> Drop: Binding
>>
>>> +
>>> +maintainers:
>>> +  - Neha Malcom Francis <n-francis@ti.com>
>>> +
>>> +description: |
>>> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
>>> +  that allows handling of safety events somewhat similar to what interrupt
>>> +  controller would do. The safety signals have their separate paths within
>>> +  the SoC, and they are handld by the ESM, which routes them to the proper
>>
>> typo: handled
>>
>>> +  destination, which can be system reset, interrupt controller, etc. In the
>>> +  simplest configuration the signals are just routed to reset the SoC.
>>
>> There is no proper bindings directory for ESM? Misc is discouraged.
>>
> 
> There is no other directory I see fit for a block like ESM; it could 
> either remain in misc/ or maybe create a directory error/ for all error 
> signaling and correction mechanisms? I see misc/xlnx,sd-fec.txt that 
> could also go in error/
> 
> What do you think is fit?

I don't know. Maybe it is something like hwmon? Or maybe along with
xlnx,sd-fec, tmr-inject and tmr-manager should be moved to some "fault"
directory for all fault-management-and-handling hardware?

Best regards,
Krzysztof

