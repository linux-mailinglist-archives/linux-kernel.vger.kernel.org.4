Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF4653313
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLUPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiLUPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:19:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89522B0A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:19:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o6so19082176lfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQ73qbFm6UCJeP4jhQYp+B0qUa7NcAt4luT99qxjzU4=;
        b=ON2Cs2nWCEQZOh2t/kPzh3ik2xLc3N1COsahZWqVrV+AwFPwCRqx3BX+9sf+0/0QR/
         WCdAIekO4VUIMUB6alGZrIVYyI+dbeFP/NvO8d7OO2QD06KLTV/aASRcy7rjIGN9MVlV
         fHHoOk7gb+BuDUMAuksiGC6pdluV3jVBon91zQFqlszHz2yySpvcgUQ8gxD5+6LJWmyJ
         fw28RCkLGg0noefUHQ2hMvzb+5kr7MwKb6HZMFa47z1BbNYCxp9FfoUOIrqjksFi/h6P
         EVeR6iq4fLXSsaiUOw77bdo9zxYUeZkAz182mTDkdt013CMg3RiZ5CetCs0MZBFzjZT9
         Z6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ73qbFm6UCJeP4jhQYp+B0qUa7NcAt4luT99qxjzU4=;
        b=FAPvwBrWwKM9hsHGa+ROCasRAoA4K0yRlfAlhATiJHJvTtRn9o+HojIQ03tDPsG7al
         AGuOSSWrJnz9M5qnLYdgwjMDY1tLSPOuSCKJCOqJWafXbqbqoBQdZhvLP36smen6LxeX
         MAshSdNYsZaoc8GrldHf5ilKbbNcrxJR91ejLKhK9HcwZpFDnXQRwmZKLzfCvaAZAQML
         dbLSjVY0pUcYp+CQtvfVkTXmbZ6CLdJYsEi7M8k5xwwe+kaYuw7afheQdnjbRdpugnzO
         reFEw/raVL+/x/7jwXtVWtheodDnsIomOhyR68KCxn1ce1G5Tyk7FXSG9xN3/5HOazpS
         Mlug==
X-Gm-Message-State: AFqh2kpVXjJ5oIOUqYPGJSwYw5yylCsfxbLVGmml6HuiSzDQjULEXpOT
        wyocZWYj/oz/CXe1224Werh5Kw==
X-Google-Smtp-Source: AMrXdXtU+/ZUhZbu0zYB+63eEHjnu+1g+kiav0QKX0Q+Q2WfCnothw2l04vC4i9t9nKzQC6777WWlQ==
X-Received: by 2002:a05:6512:340a:b0:4b5:8fee:1d71 with SMTP id i10-20020a056512340a00b004b58fee1d71mr626877lfr.64.1671635962255;
        Wed, 21 Dec 2022 07:19:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b004b5866f048csm1862025lfs.268.2022.12.21.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:19:21 -0800 (PST)
Message-ID: <bedc2750-100c-d3f7-cc11-0027d6b8e867@linaro.org>
Date:   Wed, 21 Dec 2022 16:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <20221221132428.702-1-lujianhua000@gmail.com>
 <4c37d74d-aaa2-242f-a25f-bf5f92d50756@linaro.org> <Y6MjDxxi8CunFLmM@Gentoo>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6MjDxxi8CunFLmM@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 16:15, Jianhua Lu wrote:
> On Wed, Dec 21, 2022 at 04:03:44PM +0100, Krzysztof Kozlowski wrote:
>> On 21/12/2022 14:24, Jianhua Lu wrote:
>>> Add Kinetic KTZ8866 backlight binding documentation.
>>>
>>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
>>
>> Do not resend. You need to fix everything, test and send a new patchset
>> (entire) with the changelog.
> 
> Ok, I got it. I was just a bit confused about "Need to resend with proper
> thread".

But you did not thread it properly anyway.

Best regards,
Krzysztof

