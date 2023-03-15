Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E86BB7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjCOPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjCOPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:30:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD571CAEE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:30:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so33299586ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678894253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KClxxgRQukl7kvRgovwy9/J2dhtuP4MRXvjFVgkceug=;
        b=L/wXf5gztwqfwhlh5WQgUuPqA0Kc8XZBuYjW+UUeEUqMycvz1/pjqxEUhdOHaontfN
         A06734KLTus/PajJS7Ktyota8nvM35HdvAg+Vyu3kWf62DnqjCDIpQ6EQIKG2twFd34y
         Ncfj4UsEhe+xQeE0gXZvpvwQ5kmuATafHJLQlmQn1SeBCmHT/yY2XxP7Ujo16JhQ+VlW
         TO+e33FR2sHrs8heOWjOW1bznspMjqn+aGd/VkM3ecLxJF9OB6PP6sKLBf3t2Njuikrn
         jYOqiHRM/Zdaz6nxcFgVsjQtKisAcECWu/MoxGp0Y2Io+eWqh1u3/KxfohuUI9AI+vDK
         vvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KClxxgRQukl7kvRgovwy9/J2dhtuP4MRXvjFVgkceug=;
        b=1sDq+1pNsh6hC48y2h2aJ69CMYQD6aoz64eJEqY6SmrJNoI9a3uY5+Ende6/fIesZN
         LMx/svc4Sa55TSDIyFkWD3sW4GB0ZCTgxpkQQ9tvGlFty2+mE5KOZDW5A+gkyQezjDu3
         bsbDXH+FD19oND7WMJcv6Bhgm8EcHusHkAOcWuFd8J8JZLwHBHSA/CJ0uRdOt/kcyhnc
         rFlvqyySC3ouERh2yidL/ohRFLGLnAdomw6Ou0OzmLl0Wg8+kQfJdkU7q61uhVtQewHh
         XJOyR9qc/j0N44AYcsKJ6vy36m4Gt6bcN+XJvWcvxsqldI4UCR8hfQjer1EP0sz7X8BO
         JZTg==
X-Gm-Message-State: AO0yUKVX0K7Wr7/0wEB1b8MgRCskuB+VT82nnsY3umWtgJx70OyaQRkJ
        26TRmQ3sIDMAjAtaoBe2JEU1oXgXTlY2npBNI70=
X-Google-Smtp-Source: AK7set8b2eblWRwblvgFpekETWIpmI2Wm7H5FUzfxTTdQp6TGeC1Z4KrokuznG5NSYOxoI/uQa4XzA==
X-Received: by 2002:a17:906:2a49:b0:8e9:afb1:65c6 with SMTP id k9-20020a1709062a4900b008e9afb165c6mr2338665eje.13.1678894252893;
        Wed, 15 Mar 2023 08:30:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id i19-20020a508713000000b004af62273b66sm2633194edb.18.2023.03.15.08.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:30:52 -0700 (PDT)
Message-ID: <f852216a-51ec-4c9c-19b5-7de7c9ce321f@linaro.org>
Date:   Wed, 15 Mar 2023 16:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: cisco: add device tree for Cisco CrayAr
 Argos.
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230315010920.2473206-1-danielwa@cisco.com>
 <d6f7a967-a0ea-c5d0-93f5-683e02673ed1@linaro.org>
 <20230315144654.GY15751@zorba>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315144654.GY15751@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 15:46, Daniel Walker (danielwa) wrote:
> On Wed, Mar 15, 2023 at 07:38:52AM +0100, Krzysztof Kozlowski wrote:
>> On 15/03/2023 02:09, Daniel Walker wrote:
>>> From: Marcin Wierzbicki <mawierzb@cisco.com>
>>
>> Also few nits: subject: drop full stop.
>  
> I don't know what your asking here.

I am asking to drop full stop from Subject.

> 
>>>
>>> This adds device tree include file for Cisco CrayAR SoC and
>>
>> Do not use "This commit/patch", but imperative mood. See:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> Ok, I'll consider it.

Use Linux coding style, not your own.

Best regards,
Krzysztof

