Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920126BE2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCQIN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCQINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:13:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F455227B1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:12:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so17070395edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679040729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2NLPcV0e15KR2VTYIT5DvaZtAMS3Pymgc/Hfm10LCg=;
        b=bB4UQ33s1eTTVAAub1pQzyWt3Di5LZgHJWZ25KaHFZBwA3tasImcJ1vp5SpqERMiJG
         NpwWdBwxP56J0+eCfQDb5aitXcuu/Lkgmo+4AUI6Lb94dnXkuAp1UC010SHLItVZAEHO
         pwT333nCQbCA8rwKLwhoUhgPWWP3jsBV2Dn+Shql4GhmNKk2ol6kTrt0kjK60ktwtgT3
         1u3J8OpEv9x5ttql4H/6K4re27i9Y34TWZOCc4QHEiK4OvYhhl0+pTQFv6bVxMWfVFTw
         Vvb6ffTO8Kb1yNnz6pvmGnK9VyKdZAmhWE3MVRBeKqsPyJRzUFFudPTPiDih/gdp5v4+
         QJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2NLPcV0e15KR2VTYIT5DvaZtAMS3Pymgc/Hfm10LCg=;
        b=TJDuUE3Bm5kUmBgN5KLrBj7JsXxSytB73epBbXdQLqqoGBAvTyWGGWbkA6Uw6Bdts7
         kg+sk3gRtbjgVEZ3GoxC0Pumy8uq8XsHuyPihmEOz88+Ax00BwUM9urRf3Io0aLsEQZq
         EeD2/yz+tVGFBb/14NZ6JIo+E44GDlyYSj+QAg8qdFLaGes5RMPrMp7YSBSubuKictMJ
         Yi21zHX7ZWzy4D2KOGp0gBS+gJEUxFrLJGkLruMWJET9mI2gUYBtq0D1LSN61oHEFVCa
         Ru57AYKPKFJtl0B3+YteiVymygKI+5k0oSv269uTyTeLlzgnUJbQDcCbhPMR695uHxcm
         QIUw==
X-Gm-Message-State: AO0yUKUEJAxXsI1/NDSMM12yhppgNiErcWPcERLXNw6bNGHNbqUG+VcJ
        y9lAt0u6beoD7ojXOju6rhIYBw==
X-Google-Smtp-Source: AK7set8gXdMOUdQI+eibIGjQnRru2oIk5Y3dI3YgsRE3c5Tf6Zc3nEUpuNboj1Tcph8pjWe6MWJ+zA==
X-Received: by 2002:a17:906:e0d2:b0:92b:f3c3:7c5f with SMTP id gl18-20020a170906e0d200b0092bf3c37c5fmr12382818ejb.53.1679040728917;
        Fri, 17 Mar 2023 01:12:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906b30700b0092f500c5936sm658182ejz.201.2023.03.17.01.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:12:08 -0700 (PDT)
Message-ID: <b8cd828b-edc5-6748-bf97-af0fc85e14a4@linaro.org>
Date:   Fri, 17 Mar 2023 09:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] crypto - img-hash: Drop of_match_ptr for ID table
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
 <20230310223027.315954-2-krzysztof.kozlowski@linaro.org>
 <ZBPYpYfd29YwN1Dy@gondor.apana.org.au>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZBPYpYfd29YwN1Dy@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 04:04, Herbert Xu wrote:
> On Fri, Mar 10, 2023 at 11:30:27PM +0100, Krzysztof Kozlowski wrote:
>>
>> diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
>> index fe93d19e3044..4e9a6660d791 100644
>> --- a/drivers/crypto/img-hash.c
>> +++ b/drivers/crypto/img-hash.c
>> @@ -1106,7 +1106,7 @@ static struct platform_driver img_hash_driver = {
>>  	.driver		= {
>>  		.name	= "img-hash-accelerator",
>>  		.pm	= &img_hash_pm_ops,
>> -		.of_match_table	= of_match_ptr(img_hash_match),
>> +		.of_match_table	= img_hash_match,
> 
> I think we should keep this because this driver doesn't explicitly
> depend on OF.  Sure of_match_table is unconditionally defined but
> I'd call that a bug instead of a feature :)

The missing dependency on OF is not a problem. The OF code is prepare
and will work fine if the driver is built with !OF. The point is that
with !OF after dropping of_match_ptr(), the driver could match via ACPI
(PRP0001). If we make it depending on OF, the driver won't be able to
use it, unless kernel is built with OF which is unlikely for ACPI systems.

> 
> However, I would take this if you resend it with a Kconfig update
> to add an explicit dependency on OF.
> 
> Thanks,

Best regards,
Krzysztof

