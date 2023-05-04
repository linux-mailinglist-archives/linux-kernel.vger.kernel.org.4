Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09C46F6EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjEDPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjEDPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:11:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378D448B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:11:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so18190299a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683213067; x=1685805067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tey8IgI2Eogyj8DLj3lLUefcK0DJhrR1c7b9md2XLUE=;
        b=rpXjfZxPNhxSs/Pqs2il5JzS35rl8R9kbck1iqU1VfnoESn/Gof253CCM0BNQqXaDZ
         Y/7OyizPrIpWo43eOiReOnSIZX0INV+Wq6SVHe1zmQHGEKp45pKpenJ2MA9KhMKCewnj
         lgnxCCijQON7OJJmJB0+e+rEqssJgysUqQHfTXmFpQ1/uFbh7mDxCWdij37etfUL+q9L
         1NiWduqk/Uwo5w3q5/OUyfBQf53VPpFC9JTBtTheR741MwTxO+rkxLAxOrO2K6XaqTLP
         mii4VAQhEXwsvtdwGi/7hfwKHwWUG7uBYgZTEkpt9O7rgm8XV/obVFm7jxlGcSX99W4J
         b4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213068; x=1685805068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tey8IgI2Eogyj8DLj3lLUefcK0DJhrR1c7b9md2XLUE=;
        b=PDYOWwSP7ZAjXgc69NXSGBU6tgu3aupaTmtTumi0mYfVJcKO0Wm4n9DgV2Eeh8TxIs
         2rcoxNNwV5Yj/OTBeTNcdlEtcJw+7krU5u1z2rWPKrhIdUsI1WUHi78Uw8sOSNAsis50
         znQRhA3G4CHl7nWP6g+Z6XlJlEsKwmap3+cDC4GEe0vJwr8WdTp1avUarc1PxFAdeG93
         8jBBxEvx/GjylQ81t5neOCp9D98BeS5Ptve8wbv/IaS33AIVPrg6j6kxedb3BdbpXlfO
         oDvx4pwJT8Y7t2IpfL++OD3nf3VL32wKfhj5O7ta1udPfPhl8eTX1OU6c+q3fI8SM46Y
         qQGA==
X-Gm-Message-State: AC+VfDxgcn53JGe7WigHvDAovpVhgYSa1nCvCDMii7ZpODeRVq4I+5WE
        SssBwxc41mHt03aojpbFrK7vGw==
X-Google-Smtp-Source: ACHHUZ4xo5vjjee9U6LJ8ueGUC3O0IY85SY9/ukGO4581/zqT3bF9s4ZZl+aAhKLUYtKdMAYrN/BWA==
X-Received: by 2002:a05:6402:274a:b0:50b:d668:10a8 with SMTP id z10-20020a056402274a00b0050bd66810a8mr1968590edd.12.1683213067666;
        Thu, 04 May 2023 08:11:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id f12-20020a05640214cc00b005068fe6f3d8sm1948195edx.87.2023.05.04.08.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:11:07 -0700 (PDT)
Message-ID: <1f62d6dd-1ab8-a8e8-c881-da03ad9bfbd9@linaro.org>
Date:   Thu, 4 May 2023 17:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] regulator: Add bindings for TPS6287x
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
 <dfd3498c-62ab-92d3-22d6-21729dc619fa@linaro.org>
 <c42a721c-13a4-16a1-efe6-002c76f5c69b@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c42a721c-13a4-16a1-efe6-002c76f5c69b@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 17:08, Mårten Lindahl wrote:
> Hi Krzysztof!
> 
> On 5/4/23 11:34, Krzysztof Kozlowski wrote:
>> On 04/05/2023 10:30, Mårten Lindahl wrote:
>>> Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
>>> regulators.
>>>
>> Use subject prefixes matching the subsystem (which you can get for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching).
>>
>> Just a hint - I in general ignore all the emails without dt-bindings prefix.
> Ok, I'll prefix it "dt-bindings: regulator:"

You got command to run, so run it.  This semi-automated response is made
longer for the purpose to help you, not to be quickly scrolled and
ignored. When you run it you will see the order is opposite, regulator
followed by dt-bindings.

You can apply such habit for other subsystems where maintainers also
expect certain prefixes.


>>
>>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>>> ---
>>>   .../devicetree/bindings/regulator/ti,tps62870.yaml | 62 ++++++++++++++++++++++
>>>   1 file changed, 62 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>>> new file mode 100644
>>> index 000000000000..32f259f16314
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>>> @@ -0,0 +1,62 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
>>> +
>>> +maintainers:
>>> +  - Mårten Lindahl <marten.lindahl@axis.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,tps62870
>>> +      - ti,tps62871
>>> +      - ti,tps62872
>>> +      - ti,tps62873
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  regulators:
>>> +    type: object
>>> +
>>> +    properties:
>>> +      "vout":
>> Drop quotes.
>>
>> Why do you need entire "regulators" node for one regulator? Why do you
>> need child at first place. Drop it entirely.
> I will remove the regulators node. I think the vout node is needed to 
> get the of_get_regulator_init_data.

Hmmm, how other simple regulators deal with it? Like all the fixed ones
and few other one-regulator-devices?


Best regards,
Krzysztof

