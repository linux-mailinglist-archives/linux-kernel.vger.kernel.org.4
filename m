Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4AF5BE236
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiITJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiITJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:39:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA410F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:39:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a8so2749164lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4UgBRhi/yvelR37RQjVh4NzYnNRpZ6qRgldTaLCmdbM=;
        b=XdVDfRqdjptItUwji9CmGgIVKEnZDePYc4197BbBVbCFNzGljxG0zxBp8Pnewbo1vw
         ag5chzMklLZdqkK8uZV6PEADKB6s76qsrYNjbdCkH/o09FcaCkS+oldc/z3Kw1mf+nF1
         TbJYVTLsbDL/vytIfeTaA68Yf0go8X34Isw8yk8iPXzjfYEvaWUqF1NFfk3wfMbYlF2C
         3BNDIUcRRhTs7BZfepVEkQ7FY6US50CNv9mXJEqboE1ejKYWdI0e/Xc/8jJK+Se7V/63
         HXPm7fu4ebmAImVqw6x0mLRakWkJ5WkvWJGl36kw/hAGNFModr0vttx9F6l3goD7W6oo
         O2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4UgBRhi/yvelR37RQjVh4NzYnNRpZ6qRgldTaLCmdbM=;
        b=hYnSYs4QzdRRfRozNmrnxTSBvLFV5hzxHqJ9N2R/pBg5mNJLMOxdkm1FDrPXI478kx
         EKasgJfMhFgekg/0xpf1rIIA8WXnpxUJayCdDYPNZ1yawm9hsT5wsWt1hVZSxdpbHngC
         U85LsljHcOQ6N6Kd6d2DUueydQPJXscL0eH5G7MLHatTzIkQZIqbK+xe/Q8LoMhf3Lp6
         fXm2GYuthUJb5Al21dp0RkhTYMwRuy4DeXaHct58ao4c/gsmAo6bdZ3RpFV6FXSvUeFA
         zMPurV3yIu2pXEy1hjxYTqyXQsEpa5hkIhvPZBiAtc5Q4zBsihk1drkHMmflW0BjCPcL
         osUA==
X-Gm-Message-State: ACrzQf2402SJoK85xs++edh8F2k9uUa8KYYCilAcvlyuIlEkageLH1/q
        UfhU7QjyPjPmCrRKFBEJ5qSNR5H8ToQxuQ==
X-Google-Smtp-Source: AMsMyM6X1xHBZJPJsES15OMkWmtricB4yfOni/ZQAAQjDNVfy9pw/5Uyi0+bJj8VCGhZy3faaQf/ZA==
X-Received: by 2002:a19:910f:0:b0:498:7212:10c0 with SMTP id t15-20020a19910f000000b00498721210c0mr8316238lfd.39.1663666771493;
        Tue, 20 Sep 2022 02:39:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 20-20020a2eb954000000b00268cfcf841asm177886ljs.56.2022.09.20.02.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 02:39:30 -0700 (PDT)
Message-ID: <ccc318c0-ee1b-d538-6d2b-bf85a3c9c6fd@linaro.org>
Date:   Tue, 20 Sep 2022 11:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/4 RESEND] ARM: dts: qcom: Use new compatibles for
 crypto nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, Jordan Crouse <jorcrous@amazon.com>
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
 <20220919221509.1057574-2-bhupesh.sharma@linaro.org>
 <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
 <00dd028f-d636-0cda-40ce-01d5addcbec9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00dd028f-d636-0cda-40ce-01d5addcbec9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:57, Bhupesh Sharma wrote:
>>>   		crypto: crypto@8e3a000 {
>>> -			compatible = "qcom,crypto-v5.1";
>>> +			compatible = "qcom,ipq4019-qce";
>>
>> There are few issues here:
>> 1. Compatible is not documented.
> 
> Its documented here: 
> https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/
> 
> [as mentioned in the dependency section in the cover letter :)]
> 
>> 2. Compatible is not supported by old kernel - ABI break.

You cannot fix this with dependencies/ordering.

>> 3. Everything won't be bisectable...
> 
> I think its a question of dependencies b/w the patchsets intended for
> separate areas. Let me think more on how, I can resolve it in newer
> versions.

DTS always goes separately so this also cannot be fixed with ordering or
dependencies. However if Bjorn is fine with it, it's good.

Best regards,
Krzysztof
