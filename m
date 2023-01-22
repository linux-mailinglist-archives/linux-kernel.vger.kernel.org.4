Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16726676D92
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjAVOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:18:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A1144B1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:17:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g10so7233675wmo.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjtzMpfc/L7l3fC8W1FOlPndT4/yZbcPMqMFz9cu9kY=;
        b=e8Ep5xa52Zw9S9fKBFg5pmufcH+1T5QSycoeAReB0gK3rpjZjv8UoeFu/crHjPM+NX
         rczOIH1HfixNQqjj0Sl948H9UymQ8xzxIZMIvUge/Y8JgqCEpLidz2IbY2MUDW/h4Gx9
         JmGlsfvbEQn+v6UrghHuVeO7yo0RJGjdGEUzbkq3K9uP/kan0t3UHdz46WWUfe3xfy25
         crTIo3/o/tnipKPc38h9b9A7gOfbjNOMr0RjFCan2OzwwmPlHiexqLOqdOV83yWxyfsz
         4eQG2S4TFXtRfFUeiLtPFHQ0brDDcsTs/BPTKYQcT6E2qB2jqd/6iVpGkdiC4TZ/lHRD
         FdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjtzMpfc/L7l3fC8W1FOlPndT4/yZbcPMqMFz9cu9kY=;
        b=qEaDbze79d8KI79D4mubRaQpIRKW5u4wxgeB8YLOcEM3QVWTlMUmWm6h8Ly098+0M1
         i3hiPcBAsquNHcNRAKsdFSyc4dref9hC72dcotB3Q6v33SNSWOeo/6WPb9ZhPF+yTUqZ
         OU/2fOge3MCCRjWseNmMc+Ie0+0Mogbx5o/hu7q8zFVx5ePQus/6rUI6Nto0ZH1B62Kx
         OUFMHakfFwBOShiQGJlebSwqXKOyVrKZ+EGWHmriYVuGcsCZUvyk7jnP+HyDNBlcQaX2
         Mhi0KwO+7hGBWy3tVtyYAKV1XnOdQzEiBQJCXEej148vrdg1XoXt7EXaiHmnnNF24f15
         WUaA==
X-Gm-Message-State: AFqh2kp757XCCkZt0Uy3sj3ssAoYJuxuFWcrwpH/ZL5nlUj1W2T/Uxjy
        aUhb27eGsMirJaa+pt4a5cl83Q==
X-Google-Smtp-Source: AMrXdXvqx3OuPPUrVEDE4FcnCybgJCBy6h2YA83AtFMcVZlG47Pyh9oMcY7c9dsmQc2Sv7qDPcQKzA==
X-Received: by 2002:a05:600c:6001:b0:3da:f80a:5e85 with SMTP id az1-20020a05600c600100b003daf80a5e85mr20338672wmb.26.1674397077429;
        Sun, 22 Jan 2023 06:17:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b003d9fa355387sm7825029wms.27.2023.01.22.06.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:17:57 -0800 (PST)
Message-ID: <c5888e27-18e7-24da-f177-4651fc875269@linaro.org>
Date:   Sun, 22 Jan 2023 15:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt
 nvmem based
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-2-ansuelsmth@gmail.com>
 <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
 <63cd44e6.050a0220.ed90.635a@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63cd44e6.050a0220.ed90.635a@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 15:15, Christian Marangi wrote:
> On Sun, Jan 22, 2023 at 03:00:22PM +0100, Krzysztof Kozlowski wrote:
>> On 21/01/2023 01:01, Christian Marangi wrote:
>>> The operating-points-v2-kryo-cpu driver supports defining multiple
>>> opp-microvolt based on the blown efuses in the soc. It consist of 3
>>> values that are parsed: speedbin, psv and version. They are all
>>> appended to the opp-microvolt name and selected by the nvmem driver and
>>> loaded dynamically at runtime.
>>>
>>> Example:
>>>
>>> opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
>>> opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
>>> opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
>>> opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
>>>
>>> Add support for this and reject these special binding if we don't have a
>>> nvmem-cell to read data from.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>>> index b4947b326773..cea932339faf 100644
>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>>> @@ -61,6 +61,17 @@ patternProperties:
>>>  
>>>        required-opps: true
>>>  
>>> +    patternProperties:
>>> +      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':
>>
>> This does not end with correct unit suffix. Should be
>> opp-speed-.....-microvolt
>>
> 
> I think I didn't understand this?
> 
> From opp-v2-base and from what we are using downstream, the named
> opp-micrvolt works correctly.
> 
> (speed[0-9]-pvs[0-9]-v[0-9] is the entire name of the named
> opp-microvolt- binding)
> 
> This is the reference I always used for the pattern. [1]
> Here the pattern used by the driver. [2]
> 
> [1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/opp/opp-v2-base.yaml#L209
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/qcom-cpufreq-nvmem.c#L238

Are you documenting existing property or adding new? Commit msg suggests
you add new property, so what do you reference here? How is it related?

> 
>>> +        description: |
>>> +          Assign a microvolt value to the opp hz based on the efuses value from
>>> +          speedbin, pvs and vers
>>
>> Where is the DTS change?
> 
> You mean an additional example that use this additional binding? This
> may be difficult to add since the current example in this schema is a
> root one and I can't put multiple root example.

No, I mean, you DTS using it. We do not want empty (unused) bindings...

Best regards,
Krzysztof

