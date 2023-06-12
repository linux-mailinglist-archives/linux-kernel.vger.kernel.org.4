Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A872D32B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjFLVUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbjFLVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:20:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F841FC4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:14:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-97467e06511so772609766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686604461; x=1689196461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRapFMDM3VwfrRdeIe5Po/TWol/AUPXl4tSgkIwIhOk=;
        b=limPOmnoclWDxiGJBhuMu+J6EeGQSmknjQdT72EGTBnVB2eCSK1WWFhPVQTJQtbmlE
         HvzXgmpucFS6iK8hZ/sjfK+PWvPaBEugZhBNTn7uwEL6qAPAfGBW4q6avo/mFvGqlF2B
         36ScTXQmDyBABnzxd9U+zzpsPJ8miTB8KNvVozlq3pmKWgMH99fUwlnjK8U9YVBbGUsC
         XITSVBIow6MkU+mPGz2l8OHKUXsKeqvQB9yAia+yqh9MB1kFRosrAPNUA5ZKSQ2/GWHJ
         QhQNlTMrLZeINuitPDi3DqxKpPu7AGSUJHzZ5XzTQJr5O/L9Txf5HQHLfMJdFcX5XepY
         uWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686604461; x=1689196461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRapFMDM3VwfrRdeIe5Po/TWol/AUPXl4tSgkIwIhOk=;
        b=GkhljiDMtupWRW844TWQxCZ3K+jv7cvH/mFOeKEyGB8bbs7VCAyposroIp5su4QF+V
         +Q5KaUtZ1XK907/QELJwmY+FrlHfqmsC8+SKmJcnmDTCVAf7X2ywwr0vU3Jk18n0Xv+f
         po883uaB8hliA0eA6fbD4LoyOiOfuiR9rshPT3he1KqOBphvnTh1ngexvCB4aECQ7IjZ
         n3IzDiNcSEKkt16VvEn61iNzga5tHmVQ6VXWGqPnn9qsgDKaOtf15o/ftr2YVdUgvANN
         ztM1uUQn/EsGa+Ire1rMzdzcOyPyJ7NQGFCvhKJ7knb/+RfXM3MjmQmPtUi1108jkG/D
         55tQ==
X-Gm-Message-State: AC+VfDzeaPIZlps3F5V7Qolhz7eP6hXEVJkYhOa8FMNBs900xJdSPzi5
        8SFmYatJuH2g4QcRYs9YKy4hSAOMXl5yWUOHBS0=
X-Google-Smtp-Source: ACHHUZ42+IL5g3lr/+eMfmK2tikJXyCCiWGif4uYdShqbc9xFvK+c5yxujn8HyTfBZii6o032gKQNw==
X-Received: by 2002:a17:907:a08a:b0:97c:d2d1:3066 with SMTP id hu10-20020a170907a08a00b0097cd2d13066mr8180648ejc.33.1686604461560;
        Mon, 12 Jun 2023 14:14:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b0096f5781205fsm5716200ejb.165.2023.06.12.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 14:14:21 -0700 (PDT)
Message-ID: <11497426-1b3d-169b-4af1-f24f90f4de39@linaro.org>
Date:   Mon, 12 Jun 2023 23:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [EXTERNAL] Re: [PATCH v5 4/4] ASoC: dt-bindings: Add tas2781
 amplifier
To:     "Ding, Shenghao" <shenghao-ding@ti.com>
Cc:     Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>,
        "tiwai@suse.de" <tiwai@suse.de>
References: <20230610141821.576926-1-13916275206@139.com>
 <95aca760-c17c-eb96-bcfb-85f20124812b@linaro.org>
 <303B184A-1A35-4049-97F5-90D17FE990DA@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <303B184A-1A35-4049-97F5-90D17FE990DA@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 22:57, Ding, Shenghao wrote:
> 
> 
>> 在 2023年6月11日，00:33，Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 写道：
>>
>> ﻿On 10/06/2023 16:18, Shenghao Ding wrote:
>>> Create tas2781.yaml for tas2781 driver.
>>>
>>> Signed-off-by: Shenghao Ding <13916275206@139.com>
>>
>> We keep telling you that your email threading is broken. It still is
>> makes reviewers life more difficult. Maintainer as well as applying is
>> not straightforward.
>>
>> Why this is not improved?
>>
> Sorry for causing difficulties. Would you be so kind and tell me how to avoid threading broken? I get the threading broken issue every time, but I really have no idea of how to fix it.

git format-patch -v6 -4
git send-email v6*

You keep sending them as separate emails thus no proper threading.
Everything is explained:
https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/process/5.Posting.rst
https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/process/submitting-patches.rst

>>>
>>> ---
>>> Changes in v5:
>>> - remove ti,broadcast-addr
>>> - remove address-cells
>>> - remove size-cells
>>> - put compatible item first in properties
>>> - change the maxItems of reg from 4 to 8
>>> - remove white space around <>
>>> - correct the reg format to <0x38>, <0x3a> etc
>>> - remove '\t' in the file
>>> - correct a comment in the example
>>> ---
>>> .../devicetree/bindings/sound/ti,tas2781.yaml | 73 +++++++++++++++++++
>>> 1 file changed, 73 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> new file mode 100644
>>> index 000000000000..61db14a39630
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> @@ -0,0 +1,73 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments TAS2781 SmartAMP
>>> +
>>> +maintainers:
>>> +  - Shenghao Ding <shenghao-ding@ti.com>
>>> +
>>> +description:
>>> +  The TAS2781 is a mono, digital input Class-D audio amplifier
>>> +  optimized for efficiently driving high peak power into small
>>> +  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
>>> +  Smart Amp speaker protection algorithm. The integrated speaker
>>> +  voltage and current sense provides for real time
>>> +  monitoring of loudspeaker behavior.
>>> +
>>> +allOf:
>>> +  - $ref: dai-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,tas2781
>>> +
>>> +  reg:
>>> +    description:
>>> +      I2C address, in multiple tas2781s case, all the i2c address
>>> +      aggreate as one Audio Device to support multiple audio slots.
>>> +    maxItems: 8
>>> +    items:
>>> +      minimum: 0x38
>>> +      maximum: 0x3f
>>
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>
> Kindly point my mistake, I run the commands from the Documentation/devicetree/bindings/writing-schema.rst before submission.
> For dt_binding_check, command as follow, no issue reported,
> make DT_CHECKER_FLAGS=-m O= O=build_dir/x86 dt_binding_check -j $(expr $(nproc) - 1) 2>&1 | tee $OUTPUT_DIR1/$OUTPUT_DIR2/dt_binding_check.log
> ……………
>   DTEX    Documentation/devicetree/bindings/sound/samsung,tm2.example.dts
>   DTEX    Documentation/devicetree/bindings/sound/ti,tas2781.example.dts
>   DTEX    Documentation/devicetree/bindings/sound/amlogic,t9015.example.dts

Hm, you are right, it passes the checks. There must be a bug in dtschema
around minimal items if "items" is present. You miss minItems: X, next
to maxItems.

> ……………..
>   DTC_CHK Documentation/devicetree/bindings/sound/samsung,tm2.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/sound/ti,tas2781.example.dtb
>   DTC_CHK Documentation/devicetree/bindings/sound/amlogic,t9015.example.dtb
> ……………..
> 
> As to “make dtbs_checktest”, it can’t work in default compiling system(x86) at all. In order to test the bindings, it was integrated into the BeagleBoneBlack compiling system.

There is no problem running it on x86 system. We all run it there. Just
install basic cross compiler. Every distro has it...


Best regards,
Krzysztof

