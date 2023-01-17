Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE566DBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjAQLI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbjAQLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:08:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C441A4AC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:08:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j17so3401484wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKyl2zoU+BjMXCo25Yq+FS/cMerlf+L/tTkaM+HpUWM=;
        b=yBvWniZjy0VkFEbDqPu3V+YksJ6CZUrjOAAXpU7QSq2QfuB9+ASjo2cUnmHVJe8vIA
         ivG27uA6aR7kW5nGIKcc82fMA78wW7yq3DwZM6d/M8C40o8dbk+rWg73MryY3YbFylal
         gkGWYAYCHxsRu4AoLFmktFcFz0r3NjUAVNMnbKlcGMkqKz1t8EiFvaivDjUlpL7ysyO4
         m1wwXejgzlnTbU6zWv/lkVhn1DjZ/BJSCw26eOgp3WEvqSf7F+DnZ7QrcZOe0eI9K549
         Tk6GQMOFN9KcnD4sv6mccWvsqTyCC4a0CgZSwZlKwe8vQaerHniv+4Gek8so/14oyKrS
         KMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKyl2zoU+BjMXCo25Yq+FS/cMerlf+L/tTkaM+HpUWM=;
        b=jXYPrXQomeoitofezwSqi/IpfwTQKnB7M07pnIi/3rkpkmzpOcXrQ3u+PARi8x1U9A
         exXU893fVblMsySITECfVYjkt/rxNhgA60v3q/fkNS/C0MR8Jev1Xazkt2xUSmMDSzJt
         Yap8Ogot3IlFIgLlqsBb7LBlbQJVO0UX0gGui5kspGTFQsq7WrXOWjpX/h5bX4w1oF7I
         73KxkADXNc7QGi5Y0YHuL53WYB0FqgQJFUcX5pRHHJ1XUteMMMShw889NZvVnsgo6Lxe
         XEuHCT0XVcipVr2Bds9NhySV7r3ekXbPkjIq4NnbvZpPjRsHObGCEcAX940scGX9I5v+
         4uSw==
X-Gm-Message-State: AFqh2kr4tb65E6Wi8J/A6VWADEm1SA5aBa4UjFHaLIF/b8fF+f96ICyw
        xuUPdJNDmxJOAd5cm6qJdkZfoQ==
X-Google-Smtp-Source: AMrXdXspbYFHRdbbVdr4/3JT7LRnsXzejbNAGI3Nfo6ewz+rYZm7PqNfx5DnKv/RFAUyBANMxz2s3A==
X-Received: by 2002:a05:600c:4fc9:b0:3d9:f769:2115 with SMTP id o9-20020a05600c4fc900b003d9f7692115mr2654176wmq.26.1673953728371;
        Tue, 17 Jan 2023 03:08:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm12519222wrb.57.2023.01.17.03.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:08:47 -0800 (PST)
Message-ID: <b727f099-f734-49d3-1099-dfdb241b4074@linaro.org>
Date:   Tue, 17 Jan 2023 12:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock
 driver
Content-Language: en-US
To:     Kelvin Cheung <keguang.zhang@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com>
 <167362342081.2212182.3990856069388425566.robh@kernel.org>
 <CAJhJPsX-c_05bzA6cvN5b5wubS=cJCcXvRcQNTqR2RUa6Y3ZFw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsX-c_05bzA6cvN5b5wubS=cJCcXvRcQNTqR2RUa6Y3ZFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 11:54, Kelvin Cheung wrote:
> Rob Herring <robh@kernel.org> 于2023年1月13日周五 23:26写道：
>>
>>
>> On Fri, 13 Jan 2023 19:07:37 +0800, Keguang Zhang wrote:
>>> Add devicetree binding document for the Loongson-1 clock driver.
>>>
>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>>> ---
>>>  .../bindings/clock/loongson,ls1x-clk.yaml     | 81 +++++++++++++++++++
>>>  1 file changed, 81 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/clock/loongson,ls1x-clk.example.dts:36.39-41.15: Warning (unique_unit_address_if_enabled): /example-0/clocks/cpu_clk@1fe78034: duplicate unit-address (also used in node /example-0/clocks/ahb_clk@1fe78034)
> 
> I did notice this warning.
> But my situation is the cpu_clk and ahb_clk share the same registers.
> May I have your suggestion?

Don't introduce warnings and errors no matter what. If your code is not
correct, don't submit it, but instead try to fix it.

You got proper solution - use one clock controller, not devices per each
clock. Why Loongson is special here from all other devices in the world?


Best regards,
Krzysztof

