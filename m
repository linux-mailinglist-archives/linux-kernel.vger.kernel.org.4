Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EA563896A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:09:36 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7241992
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:09:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t10so4984883ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91MuML7JJZ6zElri/OMGlnT1cEg4AMa72Ix0GPKAExM=;
        b=U5GYc7M+mqwu4a0qJaIu5fcH5AVdQZWrGvylRLpOqnVMHSDAwsvNidrw4dwPlIZxtB
         wfAm21Z0UT7nn4/1TE1Wlppr5SiwpuB3Vle8yd59+s2u1TCLnLuJESs0axD7KHoDysai
         VtB1ER3BK2wZ9Dbbm0autykC+vaWAGg3rIPhme+amqGCQMrfJYw50cLxv9rFaanh1e37
         67Hl3xH/gRLsVavKB3q9jOeO/dPTRuwjrIpjIcEqXsnDTrS6rXonqhhOtt+CYFUPO6Ve
         IuOBlHCB5wPUz0J4IcKQfqKo/kRKu1SJIrtTt+hZyeycWTT8JMoMXfRRiyjAEzv1ZiWT
         VsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91MuML7JJZ6zElri/OMGlnT1cEg4AMa72Ix0GPKAExM=;
        b=yuf3qHQZ1uUtdVIwKq/VVWlr2LrKrL0oaPG7E6dOCO5Qn5TO96pd9PUhfE27meUr+r
         8Q2zcMb8TTJfRqezVax4oGWkyldHSOuyGdvhTZ7zSPbXd6ETxs+PwmTd9bMEs6F4Uhsr
         UyElUBp0SRkZPkS8dt7uS8q4YN+T8sBdNFhTcvkESoeSjT8PyL4dhvnc7JfKIqc2wcOV
         Waj0ih6CxnLnJQbs2gUvBqrZE7BktcEkSYiD8XNfN1RqsNUmDX0XcdT4xQKxkusL3cm6
         7/u2q+Dqvb0hJ1lbmeL1NZzab8hKhuK7BuSni9pOOcrmICihpGU0XMFQn67Vv7C6J1h6
         T5xg==
X-Gm-Message-State: ANoB5pnY0SMYvCvBm8cshPrnEjIDec5rpDzAaSMNEyz01+3YGzSeBNJD
        bWSJ7QXrd3sxvm4TglHIX6utVg==
X-Google-Smtp-Source: AA0mqf5NkUarevJ+YN8nlxT2bV36CGFbcTQk1X7c2TXngQ0pB/y9CyD2JRpUYr4LlVCPoMAidmpLkA==
X-Received: by 2002:a05:651c:88e:b0:277:139d:78d2 with SMTP id d14-20020a05651c088e00b00277139d78d2mr11106234ljq.22.1669378173406;
        Fri, 25 Nov 2022 04:09:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0027966a022c9sm345559ljp.5.2022.11.25.04.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:09:32 -0800 (PST)
Message-ID: <6947c59a-25c5-2331-2769-5ec138c5bb8c@linaro.org>
Date:   Fri, 25 Nov 2022 13:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] leds: MAINTAINERS: include dt-bindings headers
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Olliver Schinagl <oliver@schinagl.nl>
References: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
 <93f128ce-5229-5163-841a-66d3cd54130a@linaro.org>
 <Y4CgmOqhF12UtG+Q@duo.ucw.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4CgmOqhF12UtG+Q@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 12:01, Pavel Machek wrote:
> On Fri 2022-11-25 11:52:59, Krzysztof Kozlowski wrote:
>> On 30/08/2022 10:36, Krzysztof Kozlowski wrote:
>>> Include the Devicetree binding headers in LED SUBSYSTEM entry.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  MAINTAINERS | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>
>> Anyone is going to pick it up?
> 
> That's for me, I guess.

Yes, please.

Best regards,
Krzysztof

