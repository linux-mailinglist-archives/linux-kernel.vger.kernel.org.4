Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36C7006A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjELLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbjELLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:23:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F88BD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:23:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so17983589a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683890611; x=1686482611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edDdu+NCg3jW5eoW+kl6y4sYpXMtc+5hziBAwHJ4X+0=;
        b=nfBqnT+opiXTpo9HleIszpC2W8fT2zaIj7CgqcEuF+0Jmz1vIO+qk7fYffenhXPK9w
         F8nAjd+h+gcNZuVyPBfAG09Jsfb1OBHxOfcIcxQTpk6zxqQbBPd31OVNwC3+JfdECjT9
         olRjdr6+navwjTqwZKAoEqaMwuie7qO8g1xwkeh7mxaVBJzn2bK31difIavi/yYri6mR
         d9w8l2TRWmLbIlC6CNvWCZp2e18tqVrU+AQIoiTYBs3umGuzCj02CYzgeHww+y+DARC+
         cCPf9i8Ocndd06r7WI+uBbHPqeVoS73zJgPMKar+D0TEaxsgHse4ckLBPJ0TMZyRBw1S
         5p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890611; x=1686482611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edDdu+NCg3jW5eoW+kl6y4sYpXMtc+5hziBAwHJ4X+0=;
        b=Ap/1+xAVoWdW05etFE7cizK+fPYpmjmSJaUw6Q5hgsetnSd6lkialxAcv9J7acXAEU
         cA8vjRgLeg3FPyegK0Htbyk/AklFueGo+/ruj2cbbIbpTQN/0UEfBmr0CO6fsB0nzb7h
         wp8eFLOSrOsb1ZRBn9/0e+Uk3AHOhqbqOI8SSRExjpY5LDAqvKrwDII8ZanSKtBpWQVe
         z5sbgIMVKFcC805zZ0npJP8KWW4l98U3HmPDrk6r0fMsUG77nrggqRXOuYjT4vRLQaYB
         OfIkFeHXdGFoKNuOa29LNYJsx2koQjFTgZgFhL9zLg1agHodNZVVq85QnA7T0AamG5AI
         bTCQ==
X-Gm-Message-State: AC+VfDz0B3bTg4mdJhOu/QXK0irdK0p7bvFXN7X6Gv/pqVADq0IwnC4A
        ezBhZJbawT2P8lf1rBN2Uxfc+w==
X-Google-Smtp-Source: ACHHUZ7wQK+y5H6NIfr64Ls+Slw/dqNNKTJ30QNAnp1zx4iMnxKkQYP/k9CCR1noCkvh+v6dSJ2trw==
X-Received: by 2002:a17:907:2d2a:b0:965:b087:8002 with SMTP id gs42-20020a1709072d2a00b00965b0878002mr21971995ejc.0.1683890611530;
        Fri, 12 May 2023 04:23:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00969f25b96basm4678090ejb.204.2023.05.12.04.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:23:31 -0700 (PDT)
Message-ID: <bba885a3-0969-92f7-ee5b-eeaca4e40b3e@linaro.org>
Date:   Fri, 12 May 2023 13:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
Content-Language: en-US
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
 <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
 <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
 <12a57688-6e9a-a21d-41cb-978a274c8b2b@kernel.org>
 <kxms6scr4unumfbj4ru4t5khxvx3654vucjgczwf7rgxgvmjo6@hvvd4rqioius>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <kxms6scr4unumfbj4ru4t5khxvx3654vucjgczwf7rgxgvmjo6@hvvd4rqioius>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 13:17, Jakob Koschel wrote:
> On 23/05/12 12:26PM, Krzysztof Kozlowski wrote:
>> On 12/05/2023 12:19, Jakob Koschel wrote:
>>> How strange, I just checked and my checkpatch doesn't complain.
>>>
>>> I also redownloaded and double checked 
>>> (b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com).
>>>
>>> What's the exact issue you are seeing?
>>
>>   ✓ [PATCH v2] w1: Replace usage of found with dedicated list iterator
>> variable
>>     + Link:
>> https://lore.kernel.org/r/20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
>>     + Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>   ---
>>   ✗ No key: ed25519/jkl820.git@gmail.com
>>   ✓ Signed: DKIM/gmail.com
>> ---
>> Total patches: 1
>> ---
>>  Base: using specified base-commit eeac8ede17557680855031c6f305ece2378af326
>> Applying: w1: Replace usage of found with dedicated list iterator variable
>> [Checking commit]  12b61e664c29 w1: Replace usage of found with
>> dedicated list iterator variable
>> [Checkpatch]
>> CHECK: Alignment should match open parenthesis
>> #70: FILE: drivers/w1/w1.c:849:
>> +			if (iter->reg_num.family == id->family &&
>> +					iter->reg_num.id == id->id &&
> 
> I tried a bunch of things but I can't see this message. I tried with 'checkpatch.pl' from different kernel commits.
> 
> I did:
> 
>   b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
>   scripts/checkpatch.pl ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx
> 
> and always get:
> 
>   total: 0 errors, 0 warnings, 64 lines checked
> 
>   ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx has no obvious style problems and is ready for submission.
> 

First - the missing indentation is visible with bare eyes, you can also
fix it without checking in checkpatch.

It seems you are not running checkpatch with --strict. If you want to
see the exact error - run with strict.

Best regards,
Krzysztof

