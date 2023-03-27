Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909E6C9EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjC0I4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjC0I4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:56:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF05BBA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:52:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so32708646edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJ7r+Qhe7qVp4owbhfQXaIuIJ5xTZz7JXqNZYOcMpJs=;
        b=tm0EY+Z6DUNfTIeAGVJtpQaBCRrpwJlu6fNVojTeVDEdcdqFD9ajWuqQ4cWjaoaWgS
         CsNsU0e0dohKWB0m9rLsaTKKCDQFdfxNiNWKE8FfNgwkZKAIXuNAb101PMIg4DPxm6Lc
         imN4moNM0tbI84wKr6pkZs16VsLJ997h3SVq0/J4+rIl+LotIEUC9viwTJ4bqXetVuDc
         VCtbhKNfnnfkUCSl3T8EIHPCAxU1JEQDnYhAOsHk5sXKEGYVFTfbXEhbJIUypeua1ALZ
         UtDEGA8dpjiCe9lw5IBaGaHUs8+KtvauU2IyJpOu9f72Q5oJg7sYDJhwdHLTCSg4ULqk
         M6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ7r+Qhe7qVp4owbhfQXaIuIJ5xTZz7JXqNZYOcMpJs=;
        b=V6GAjvUiiDKCjrfo6EF4DGmhZcgsM+Sl0zl4T3Z27W5MKPybSeFWVpKtswJ4CQe8ZW
         3drCDJQ5Zak6GcLVQGEE0fGSjjgyj8S+xdqO74dNSCFE+9aFsfBcW0t7LYOXjhOY5+Nf
         FWiAX7foO9l1H0homKvccGXPIqlr+6hMmFQACfApNP1rAao7lWU3/jimwVme4Vc1zt78
         UuIAElqEqnfS9uXWhRz7TUchYOadU6aCVCZhFYDseRlDXMQsV8wIdP80qUq00Ug4+AiS
         FWmf6g1niFBHRbXSd+AmApmxB+bNe4oYnNZM3qBgM2VyHwN1ePnm8uJgHe/LWrHj+Z31
         TDiw==
X-Gm-Message-State: AAQBX9dwgZWEHNFRagj7+7IQhSUggkks4Gu9FlTtOOUdMjQc9SmNdpWC
        nZluReFCTKQWLNeOn70EqKE8/FDwBfp7AjOhCgo=
X-Google-Smtp-Source: AKy350Z5KnieCxxhcGNuzpjaGClZTmUGMeJhJnKpPEr13oKvvVkF1zVa3uUYd8NRh5/SM8SAEBGXkQ==
X-Received: by 2002:a17:906:fa1b:b0:922:2ba3:2348 with SMTP id lo27-20020a170906fa1b00b009222ba32348mr12177607ejb.7.1679907156456;
        Mon, 27 Mar 2023 01:52:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id qq24-20020a17090720d800b008df7d2e122dsm13790482ejb.45.2023.03.27.01.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:52:36 -0700 (PDT)
Message-ID: <87045dd7-7af1-7af2-83f3-aa15bf74e965@linaro.org>
Date:   Mon, 27 Mar 2023 10:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add loongson spi
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, loongson-kernel@lists.loongnix.cn,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-2-zhuyinbo@loongson.cn>
 <167966252219.1675112.1668738117284963309.robh@kernel.org>
 <31026abc-bdb3-9d30-276f-82ff93e43d48@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <31026abc-bdb3-9d30-276f-82ff93e43d48@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 10:39, zhuyinbo wrote:
> 
> 
> 在 2023/3/24 下午9:07, Rob Herring 写道:
>>
>> On Fri, 24 Mar 2023 14:33:16 +0800, Yinbo Zhu wrote:
>>> Add the Loongson platform spi binding with DT schema format using
>>> json-schema.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>>   .../bindings/spi/loongson,ls-spi.yaml         | 43 +++++++++++++++++++
>>>   MAINTAINERS                                   |  6 +++
>>>   2 files changed, 49 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
>> FATAL ERROR: Unable to parse input tree
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1512: dt_binding_check] Error 2
> Hi Rob Herring,
> 
> This error was still appears on 22 line, this line was 
> LOONGSON2_BOOT_CLK not refer, it need depend on 
> https://lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/ 
> then compile will be successful. and I had added this depend on 
> description in v2, v3 patch changelog, I was also send a email to remind 
> your bot for the test my patch need dpend on other clock patch.

... and did you read Rob's advice? For some reason you responded to
automated bot's email, but not to actual email from Rob.

Best regards,
Krzysztof

