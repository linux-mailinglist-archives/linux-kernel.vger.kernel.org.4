Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0C63C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiK2QFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiK2QEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:04:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105569DD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:03:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ns17so6270738pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsITLE+ecJEDs+fMIMyIS1u642edYlb6N5jZ2J6E0Xo=;
        b=TT1ct+yusnHIyzhkoGHfVrA9karnrHsnV1WS8EgPmRgEtX+Z86/pIOh3aB1zaLkp7K
         yB9ACqAGtXjMoqh0bY6bnp8b/EW6SqH0JMdp6jP53dRaIISsl2gC2UiP6aK0jeSoRD28
         RQBSugLJi5kCDcNCXliErgSVSpCQCe0uwK+bpeX3jqBpHVjGM8787D1Pw6Zjn8jA3KnX
         lJwhqP4PfEFyOp6oVcydwocCb3vdtZryN7HFDMR86iYvJNVKCwvik75rAlZIPkuGSBVy
         1By2UgB5UrTJpY7bh84t3Syoe7HQ0ydX7DRWiUSOPax06utzIA1B+CluVBWrY5i+S/cu
         Am6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsITLE+ecJEDs+fMIMyIS1u642edYlb6N5jZ2J6E0Xo=;
        b=xCZDoCMfS9Zr9iWW4g7hbCR1xyO/378c2MtPuqqyno/4SRg2yxlkhgQyGRv/tfxkFu
         ZeNbIboBn2Hiq2ghzltyDqKYE8fwYD0GZQQjmbWawh5E0A4rV1kaNjlKj0cfGvnHXy7b
         MVL7CV6ZHDHTwuKcx5+kHSi9xJNPOTBKLdXBIvt0vUICq03pnSQFHQ4PsMc+tRrB9TUH
         krH1eVvID9HaQRpe5tfvhfwKnAKcxvqPbh0gfxXJCYNBFSIk/Bifo2ll+ANtWck68Arq
         FOeIxKz809dy+JVfa/Q/bdb5dfICTLxHUfKVM1xFK1X9A+p+/BtisUKOm/9giLymvr92
         gHdg==
X-Gm-Message-State: ANoB5pkJo4SfOoFC/2wGr0CnzNSN+dmIvD5eYz4NNI61nHD51EhQCEYK
        vg2FXkd5NIn/hPuD3szv9NKNLw==
X-Google-Smtp-Source: AA0mqf4dNkeQ6AsDEfu9i04EvW/zAcxwq8dWCioxe1co0/ItsfGe96PZlSLREYLF1wdvQR1DoqHYbg==
X-Received: by 2002:a17:90a:d681:b0:213:d08f:a455 with SMTP id x1-20020a17090ad68100b00213d08fa455mr67354403pju.130.1669737792151;
        Tue, 29 Nov 2022 08:03:12 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001782a6fbcacsm11056862pls.101.2022.11.29.08.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:03:11 -0800 (PST)
Message-ID: <120f9acb-ed28-52cc-2ca0-f434a6cf4afa@9elements.com>
Date:   Tue, 29 Nov 2022 21:33:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 1/4] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
 <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
 <c35917d1-dfbd-f7d9-5c94-a9f0ee3b7ed8@linaro.org>
 <2487f032-1261-be6e-2e2a-38ca0af7c83c@9elements.com>
 <a5e9ecca-b17e-3045-db37-e109ecca3235@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <a5e9ecca-b17e-3045-db37-e109ecca3235@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29-11-2022 09:27 pm, Krzysztof Kozlowski wrote:
> On 29/11/2022 16:46, Naresh Solanki wrote:
>> Hi Krzysztof,
>>
>> On 29-11-2022 01:42 pm, Krzysztof Kozlowski wrote:
>>> On 21/11/2022 13:29, Naresh Solanki wrote:
>>>
>>>> +  pulses-per-revolution:
>>>> +    description:
>>>> +      The number of pulse from fan sensor per revolution.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  target-rpm:
>>>> +    description:
>>>> +      Target RPM the fan should be configured during driver probe.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  pwms:
>>>> +    description:
>>>> +      PWM provider.
>>>
>>> Ah, so it is not a PWM provider by this FAN controller? A bit confusing
>>> description. Instead maybe:
>>> 	PWM signal for the fan
>> Sure.
>>>
>>> and do you expect more than one PWM for one fan?
>> One pwm per fan
> 
> then:
>    maxItems: 1
> 
Sure
> Best regards,
> Krzysztof
> 
Regards,
Naresh
