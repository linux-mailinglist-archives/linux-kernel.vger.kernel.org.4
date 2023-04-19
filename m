Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA956E75F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjDSJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjDSJEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:04:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D7903C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:04:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a342f7c4cso737585566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681895058; x=1684487058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHMn+/z+AhV+laISEPmRX5KlY1p5dWrPe6LZ6z4zmBE=;
        b=kHviwiRwM+zy4FbjNNsi5t9H6dXOCPOoA70lvTQTfyvhXoSNmpZU+gyZpohV9iPDO/
         unLuYmCvBT1oTE8k3bFKBrKozkb1a5rcWO/O2Ykted9Rex8IZvEJHSYSdik53OmfXwgq
         O3utDEHxXNH6UNpOK2fcMT1HNSBGiiTzeNTSTgXME75qhMYPR4YthMc8tsrxbt1wxrt7
         9a0yZutjku858hHuyb3EEFSUuT1UzacBHTx88Nel5CoB93ftqXfJ/zsJyfkbBQr/zM74
         OdqrFpSKdLxE82C3eAJcAbNtQKCw1itYoT2Qyu4wnq6EVVFmqe9Zm7xzi7f00SQMuhWF
         Mqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681895058; x=1684487058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHMn+/z+AhV+laISEPmRX5KlY1p5dWrPe6LZ6z4zmBE=;
        b=Qm9gXYmaVthI+q1hTHi0c7E0BEJbxELIReGWBZ/gJ28oDtZE2Xk2ZX9SRD60hwEswq
         l0AXh5diseZHGD2AXinvBmWrfAnqWn5nq69BxrsHmA2h1tcjFvl16Kl9Cs/W/JoL1Mr8
         tanbzt3y+q+8HhXj14HPoC2ju38L4MM3vXn3+mmL/LgSqWL4RVpSB4Yo8sNvVffV5Qh6
         QHqJRSSP2olPRgpzweSwLTnU11d68ptGidDxuNawcdamqpivX7qPLwCvwM8Lu6RXOvwS
         Ibcx3Y30ZDlc5sLSEwsDA5wVAGT/WVNz6PtxbooAy9XYLIcwiJ/nQNjgCjPX8uSNdmaZ
         lJJA==
X-Gm-Message-State: AAQBX9drsk0IxE80wbzDNFfwfMO1U2nqjNMO4XMBbHHewCyQOfr+acwn
        ckcCM0LnZyNpX754aoaoKmU4EG55nYNZK/xF3QkBJw==
X-Google-Smtp-Source: AKy350a9He6Zfm/MZjkCRgYyCS4s49N0SlPDzPuTyEUy5jWTvl10BvyWyhoWoZCCbJmVoLPS64hM4g==
X-Received: by 2002:aa7:d508:0:b0:504:77ed:ac87 with SMTP id y8-20020aa7d508000000b0050477edac87mr5905269edq.5.1681895058667;
        Wed, 19 Apr 2023 02:04:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d98b000000b004ad601533a3sm7848956eds.55.2023.04.19.02.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:04:18 -0700 (PDT)
Message-ID: <84e1428b-a50e-92c4-9c8b-74e2a8034e64@linaro.org>
Date:   Wed, 19 Apr 2023 11:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
 <742f546b-3952-32f4-9f20-3a355785d162@linaro.org>
 <e63bba13-05f0-7d1b-bf11-04ef5eda3afd@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e63bba13-05f0-7d1b-bf11-04ef5eda3afd@9elements.com>
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

On 19/04/2023 11:00, Naresh Solanki wrote:
> Hi Krysztof,
> 
> On 18-04-2023 09:47 pm, Krzysztof Kozlowski wrote:
>> On 18/04/2023 13:32, Naresh Solanki wrote:
>>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>>> monitor with PWM fan-speed controller.
>>
>> Subject: drop second/last, redundant "binding for". The "dt-bindings"
>> prefix is already stating that these are bindings.
> Ack
>>
>>>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   .../bindings/hwmon/maxim,max6639.yaml         | 55 +++++++++++++++++++
>>>   1 file changed, 55 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> new file mode 100644
>>> index 000000000000..20b28cd36555
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> @@ -0,0 +1,55 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +
>>
>> Drop blank line
> Ack
>>
>> This is v9. Where is the changelog? Where is previous authorship? At
>> least some parts of it? Why this has less properties than old one? Why
>> this has more mistakes than the old one? Go to previous patch... or fix
>> everything which was already fixed.
> This patch is to add basic dt support only hence no additional properties.

How does that answer my questions?

Best regards,
Krzysztof

