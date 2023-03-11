Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F596B5B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCKM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:26:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C4C12A4C2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:26:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so31025402edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678537574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB4Ni2uX+3u4IJ5ML15pCyQ9+CaCvWs0eDgtz8E7XVo=;
        b=cd7wiPXQBcPYlkVC8qV6hdFP+hlnHXakGxmgaQia+ea22FSab7QftrFreVg7ECwzgz
         hvdrEbUsYkMtOLeW4+rpn3leguN975q6AfHTw2UQGjEz691hMu/mzDyTN5LKpxbLtuur
         LrxmcXwFIEKj00COphg80S4ZaPGLJL/mMC+F5k5y4gZgIV4BZ6+Qp0thWb6kh1NIdnRe
         CwATBsYH6iCX69oUvHW79PJ3288DWO6klw76MVYdc3qZgnMybX8D/qwjlGb+93owZCkI
         xg0kKtnUiJIRyBch+J27tIou2gaMv3XemcyrElvfM5JNbHgK4yPQ/vPp5grrw9Wv32WM
         xOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB4Ni2uX+3u4IJ5ML15pCyQ9+CaCvWs0eDgtz8E7XVo=;
        b=tvvix0uSR8+LU7Z0CSN1uRRYnam6ycR3lSH+vkAIe0DSgtKA2aGqQOgwvdM8+y06uF
         H35NCxoXZo7InGylDP0ynyxKEjX+9rISPBw6DeXLCDBazapZDGCtCIWBm3WbrrfNyqxp
         vwIAPqzCOnCrvoKzghDR1KjhJgNbvjOpevhk23oyy5bOGt0ZeSRsOM8Y5G/sXO3V25WE
         Lmt+bewkIQ+SBRSC7sQJdsDhFcQR7+Woimf7XZH/Nm9KX5t7LLh4/bEwIKsoQe2QYDIe
         UILR4xxg8qqN8661PRhc841qFZFY7eCNX8ELkg83iLmWi0oulIEu2Mz4hjrKo03JfegH
         tKFg==
X-Gm-Message-State: AO0yUKXl4uRV4Bsf8ZfeGieyri9Miw3PUh2s5QQFA6s/yc+vs9uMJkR3
        34fJFbPj61R+Jl5qe/xYiQvV0g==
X-Google-Smtp-Source: AK7set/czhny9lKHeEECG/9uE+wGq381Tvn687jNCsTAAXJXwiKyXHfQxLc2EjFJ8KD+TsWgzsFiTA==
X-Received: by 2002:a17:906:7710:b0:8f3:8bfd:a8e with SMTP id q16-20020a170906771000b008f38bfd0a8emr5299789ejm.26.1678537574082;
        Sat, 11 Mar 2023 04:26:14 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id c1-20020a170906762100b008b17e55e8f7sm1028226ejn.186.2023.03.11.04.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:26:13 -0800 (PST)
Message-ID: <179df7bf-8ab4-c3a7-7af2-d576670e3d9e@linaro.org>
Date:   Sat, 11 Mar 2023 13:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] iio: adc: rcar-gyroadc: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311122342.7aa5e6ad@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311122342.7aa5e6ad@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 13:23, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 12:14:54 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/iio/adc/rcar-gyroadc.c:286:34: error: ‘rcar_gyroadc_child_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Whilst in general I'd prefer to see these converted to generic fw properties, this
> one is not trivial. So applied to the togreg branch of iio.git.
> 
> It would be nice if anyone has time to circle back to this and get rid of
> the of specific stuff.

This is device ID table. What do you want to remove here? What OF part?

Best regards,
Krzysztof

