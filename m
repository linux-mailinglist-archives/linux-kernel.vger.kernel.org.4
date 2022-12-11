Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC4649621
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLKUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLKUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:13:28 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484C6440
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:13:27 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f16so10516518ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aIUqy6xITmiixDl/UAUB5VEYZloM6SDbzN9CnuO/W4=;
        b=od7v1JmOQwSD+sEg8epOQXQq7+4fL22Th+fnYtDdxsE2LFFtSFlUnTf2zcInLTsbyT
         Gp/w+IdNDDk08Kb5+vMJ542ZJAwt5w5mQVWQclouRfthr8kaGJQuJgFo0DJv+QZgwwEA
         UHhmgFkeZYDOJ/ba7KQ3wzzfH7wLlP4FeMyTu/FaTruhuomu7xYgMqQqy9+PW+rPLPzb
         IeUokJIen8Sl0IH19UMp1Jd/Yi9VsyFAfdR/8LYpoaxPueoROGnOBLmrTuZc2BzGk9F6
         L0iuEGiiLjIye/LR2TC0lflua70t2u7JADh4BvzBv5/pW+F3+uZeTemKTlNe1GCafsXg
         9amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aIUqy6xITmiixDl/UAUB5VEYZloM6SDbzN9CnuO/W4=;
        b=O/FfBjqSHeD9yCMzpZDUNCIkf3SkH/cNuY3v/wCpb57glY/HQKS9CgHc2MD+MSqcAb
         NwMl4RBMmtGEgc6zdSuVNgPZ61mIVfZGi9ByQXAIn56BRu1ZFWOH56s2w9FExNnqPc0c
         qzMb0TdkTzOdXL0WXrdd4QYqdZT9q8qNsqC/pmcZDefhs1F/MdGohvgqNzDNQGg08qIh
         yBrBcf0bp8PoQezsr8HCNa3x++vxe9d3TnQBF1KzhUEGnex1SQV9+bqMCzThOuUWjYj7
         B1aSsbgH/uGbeafJ8raOg2MS43q76lhgS1TZ4UXr6AyWnIXT07Cao/HDKeGTxGCXOhqt
         7guw==
X-Gm-Message-State: ANoB5pkpjoTTvZbKOhnCp9l/2pt/6cbJ9xQA2qscJFNFof5bQY84aWvq
        IKPtgeRfjFjOHqd/lkfmswdRVQ==
X-Google-Smtp-Source: AA0mqf5/jhibW52nDfYy3VXumCm94PK3z5WkppMY6y1QXUlvpoH6swreS4FOUXwzJJ+xKrRM52RmiA==
X-Received: by 2002:a05:651c:1797:b0:26f:db35:c02c with SMTP id bn23-20020a05651c179700b0026fdb35c02cmr4174716ljb.6.1670789605630;
        Sun, 11 Dec 2022 12:13:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bd1-20020a05651c168100b0026bf43a4d72sm1011840ljb.115.2022.12.11.12.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 12:13:25 -0800 (PST)
Message-ID: <61b4b894-2c49-881f-c2eb-107e8e558232@linaro.org>
Date:   Sun, 11 Dec 2022 21:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: move sound and codec nodes
 out of soc
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
 <f1aa7f4c-35e4-47d2-2443-8271175dc5af@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f1aa7f4c-35e4-47d2-2443-8271175dc5af@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 13:31, Konrad Dybcio wrote:
> 
> 
> On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
>> The sound and codec nodes are not a property of a soc, but rather board
>> as it describes the sound configuration.
> * in this case, there exist SoC-internal codecs

wcd9380 is not SoC internal, so to which codec you refer to? Sound node
is for sound configuration, not codec, and sound configuration is board
specific.

> 
>  It also does not have unit
>> address:
>>
>>   sm8250-hdk.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Best regards,
Krzysztof

