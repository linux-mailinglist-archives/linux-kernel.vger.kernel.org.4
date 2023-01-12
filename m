Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C89667446
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjALOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjALODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:03:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003054FCCF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:03:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id l22so15269537eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=My5pjeUClAjTF9dSWjS7HwACXv9ARtmx5WO8ZfndvtA=;
        b=uBy7G5Rox1wP6B4fH9uy5CmEflO6HygSAGGHurab3cnZrdiaHCdUjBrlvDAKPJHkr7
         MiWmt7ezLDtrvtJdFH4F4yYUGBWfAI+X17IxfsvlM1ViBZRxmt1jB3ycNx6Y3lidI49E
         O1oKilXC5ef76Lhx+/q8U7U6rmVjDfW7yNA3WkYrqwMlE4whGt8kUEK6Cb29R7AluF5y
         +I8UefUeOI4BZyWNxMdvTL/ep55guLz+d2Z32mIpPq1dgH2veD2CBR0hwkSqqDJJS4Id
         ZCCFsGLPydd8vF26ZbQk+hX4sU/c8AQRFDwRfUfof6LT0OR2LilEoaCRpS9WF6xh11Ya
         sLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My5pjeUClAjTF9dSWjS7HwACXv9ARtmx5WO8ZfndvtA=;
        b=R/VuusS6sR4Q9s22sIT7//IaJJY+mk7bIlbYNAL5bOE1QBPs0caW9Od900+ntQJA+X
         mnxoXTkzSOTzX2dPu9/YZZOXZFwQfF+Qt0PC1njYemkyIOZ98Sxf5DDzIgbUoEBFbLHi
         4zfHRDoaAsULbAkHxS0BAiTUdZQQatuKrp9K3c7EOGOMDICHUXcrgvjbU8NsGvEoEHFF
         Obf9e/VkQYOT49e6nlMOh4Gz9o3jnJsOrFz9wGRjS6KVhyYoR8w05FBrz16qaHwLG+4a
         F+zWchv9UXZCQpa7a9JFMn3mafnFpw+lX8XJUvAE07co4lSyGVOaV8TawgpByk6/24hf
         O0Pw==
X-Gm-Message-State: AFqh2koUxdCmQq9GwjdgoQCAAnC9IKoZI4/ERJ45N2thdLzuMrH10pKg
        n7SGHoOw/mfodArHtjKgmMOx6w==
X-Google-Smtp-Source: AMrXdXvGbdkQmK11XIYeXqsM2R9ZZHZRbxHVGXyT82WofEzYZUCqFMHjTZxbDkoGkeNeMW1pn3jBEQ==
X-Received: by 2002:a17:906:308b:b0:7ae:cda1:76d0 with SMTP id 11-20020a170906308b00b007aecda176d0mr59917554ejv.15.1673532224583;
        Thu, 12 Jan 2023 06:03:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f12-20020a170906494c00b00860c51f7de5sm1709975ejt.131.2023.01.12.06.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:03:44 -0800 (PST)
Message-ID: <9ce176c4-60df-6768-1c4c-b387a9c3a2e3@linaro.org>
Date:   Thu, 12 Jan 2023 15:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] pinctrl: samsung: Do not mention legacy API in the
 code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230112134849.59534-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112134849.59534-1-andriy.shevchenko@linux.intel.com>
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

On 12/01/2023 14:48, Andy Shevchenko wrote:
> Replace mentioning of legacy API by the latest one.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Linus, please pick it up directly.

Best regards,
Krzysztof

