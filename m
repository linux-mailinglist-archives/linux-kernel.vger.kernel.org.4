Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE36407C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiLBNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLBNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:36:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E6C9353
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:36:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so7787476wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NSQmW5YxjbuneNhJ6KbeJhq3/ChGxKuyY2+shwyWAFY=;
        b=hThn92958p8GAYwnggbWKyJot52EESD2qp4nNgtQPuVsGuUD08W0X1M0L5K5QNm4W7
         YFpdSZJ22DlMnB4thycsIXgPH2hUH6T0PjSJSaZzDr7uzzusq6TTquOy7cqqHnwbtPc0
         OJcf/4rRR3XjDZSaa1oaDZYUaGPiykA2x2ZMhx1PkEYPwoEExQmu7aVl9R31GWM9/LGY
         T77SepAnUB3XPNUJU7eIUbxf5feKUEH7NTivKdqAxlUNir1AZxBvR0Lsa70nSTmLORaQ
         1qPfB++LV82kCLHqJhpFG4K/Q0UEavY513XrewGEaBcrTJDdJuikWhFzrLuC7Ac0zjWq
         JRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSQmW5YxjbuneNhJ6KbeJhq3/ChGxKuyY2+shwyWAFY=;
        b=zPTBXCsPnMKK2Y9QEcHPRbozlf9FGnJlN+98RjL+BCU4/gyxp/fW7NmxT2e56j59er
         q6tZmtJWejSJ82X40bOJZ4kS4+WLc1ObdFPmlZ+1Wu/sZMyF7Z3FbqJoAPkzuJYbqZd9
         f2hKSckgPrwy9fbwR2PlYZQlOVJIWVhmgu8NBWlsmDqKeFsrcX9Fjt+GA3mevHay3hE5
         IdLKhGjDNmW9y5uWhZ1xvP9WKiNhQ66J3dERq/oRVcLLTEXMTuhL3RUnD4CRkyQcn8AG
         6i9aqt2pEbYGYbX5QE+8KpuAMfmGgOEJXN2XqpNtc6FFidgT6e87E/zZWHeRlvGCbkTS
         8tDg==
X-Gm-Message-State: ANoB5pkPoE+BZD9lBSgRO7ICXTyVjpd11WQJQVfIs/6lG7yAeWmcnRmb
        l/W7cc5L7XIC4AWRmqp639GSWw==
X-Google-Smtp-Source: AA0mqf4lMbaEjBgYIV2OLBHivBa/8hU4TeVP1kZQZvX6vp9GnI6UFiFG6l+7NheRXkwYaUBfmjai9Q==
X-Received: by 2002:a05:6000:1c1e:b0:242:1aec:7c5b with SMTP id ba30-20020a0560001c1e00b002421aec7c5bmr14270946wrb.386.1669988172939;
        Fri, 02 Dec 2022 05:36:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d55ce000000b002422816aa25sm8571784wrw.108.2022.12.02.05.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 05:36:12 -0800 (PST)
Message-ID: <3b02ab6f-56c7-a877-1b2f-01fc1fb8f552@linaro.org>
Date:   Fri, 2 Dec 2022 14:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        sboyd@kernel.org, khilman@baylibre.com, kernel@sberdevices.ru,
        robh+dt@kernel.org, martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org, jian.hu@amlogic.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
 <166995398251.2089685.16059995540663317860.robh@kernel.org>
 <20221202095124.4ecpfqhtzf34lwbf@CAB-WSD-L081021>
 <cea3cdd4-3d36-1439-b211-047091c05a0f@linaro.org>
 <1jfsdy83h3.fsf@starbuckisacylon.baylibre.com>
 <b425da35-c189-aabb-65b9-f956945d7b08@linaro.org>
 <20221202112826.zkpjyb3f4e2755sh@CAB-WSD-L081021>
Organization: Linaro Developer Services
In-Reply-To: <20221202112826.zkpjyb3f4e2755sh@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 12:28, Dmitry Rokosov wrote:
>>>>>> On Fri, 02 Dec 2022 01:56:53 +0300, Dmitry Rokosov wrote:
>>>>>>> From: Jian Hu <jian.hu@amlogic.com>
>>>>>>>
>>>>>>> Add the documentation to support Amlogic A1 PLL clock driver,
>>>>>>> and add A1 PLL clock controller bindings.
>>>>>>>
>>>>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>>>>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>>>>>> ---
>>>>>>>   .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>>>>>>>   include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>>>>>>>   2 files changed, 68 insertions(+)
>>>>>>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>>>>>>   create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>>>>>>>
>>>>>>
>>>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>>>
>>>>>> yamllint warnings/errors:
>>>>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml:26:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
>>>>>>
>>>>>> dtschema/dtc warnings/errors:
>>>>>> ./Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml: $id: relative path/filename doesn't match actual path or filename
> 
> ...
> 
>>>>>
>>>>> Please find all fixes of above warnings and errors in the my patch
>>>>> located at the link:
>>>>>
>>>>> https://lore.kernel.org/linux-amlogic/20221201225703.6507-9-ddrokosov@sberdevices.ru/
>>>>
>>>> Why? This patch here is broken and it should be fixed. Don't apply
>>>> broken patches...
>>>
>>> Dmitry is ressurecting a series that is several years old and not his to
>>> begin with.
>>>
>>> He was unsure about take the code of somebody else.
>>> To be fair, he even asked for advice on IRC about to proceed.
>>>
>>> Dmitry, as you may have guessed, for next revision, please fix Jian Hu
>>> original patches in place, not with fixup patches.
>>>
>>> If your fixes are minor (not complete rewrite), please keep the original
>>> author and add your SoB
>>
>> We never take intentionally wrong patches, e.g. code which does not even
>> compile, and immediately fix it in next patch.
>>
>> Can you imagine adding such drivers? Which are broken in the commit they
>> are added?
>>
>> So the patchset is old or abandoned, take ownership, add co-developed
>> etc. Just don't add known broken code.
> 
> Okay, I've got your point. It's reasonable.
> I will fix Jian Hu's patches (squash with mine) and mark all of them
> with co-developed and SoB Jian Hu tags. Thank you for explanation.

It was clearly explained in the cover-letter, nobody expected these patches
to be applied as-is.

Using RFC would have been the best solution, but this situation is rather
specific and he made the right decisions to trigger this current discussion
toward an acceptable solution for everybody.

Neil

> 

