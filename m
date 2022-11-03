Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A8617CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiKCMqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:46:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06310FCC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:46:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c15so1084292qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGm7wbTciWDJS7qmpqQ3ufS50mFVa2yb9x+7BoqLpII=;
        b=qDuHKKPzpdz33t7ixNmaA5Jq4D6VNL+K147HV/FEkQB+NvN2GLYXD3q+G1n/EhyydT
         mc+amok9gUlQCoub6CBSQucIgTAMH7XVSeOD8nnKS8+U9dHbXKKTpgn2q829hOucW2qW
         boslcXZcvJmnXbE40+x56mqW3z78ORvK2F3/8T3Vn0GRYP0Hcy/w+5HiYLc0HfWWj/DG
         4rwXkQCdXw2Fz5I+J5HsqkVrs+oN2sixOEnI21i36bWG8Kd/rkumxLY4+VYH0FH264Dg
         yUTzSrN9RwMVBWY2IAgvqS0rMaL2sITwou3TZAeGG7D2q/YFQqiawwA/jAEb4S41JsZT
         93bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGm7wbTciWDJS7qmpqQ3ufS50mFVa2yb9x+7BoqLpII=;
        b=U8o9jZBgfjJdWFJ6mdAe9OWeF8Tkh7VyJ6I50HKo7p7h5knAoLS8UUvF9e8eBHt7C4
         9WSlW2hwSxOgqf1NeZ+mpk9yUsCDOL/LJHD0Oywi2UE7ae9AlQSnvRNTHu+zw3moT+Bv
         Yk456XalLtmgRvf1lVW/RXtxAX50LPWQq6/ahPuwLxWlpVjmdO6KdhRQiaJaHZ3r2RL+
         91rdpTFclYW8txGHCEdwrOumII/06OwZo/GSe+YwvyGCaqDKfGZD9u5ZN5ZN4m6tPKCy
         OjHt+NpquFxPsn9t27OHGQYA9gIHhlccKd1ALO2a8HOwbQv+YfUkK6Qr1yduQwXYwXY8
         jsfg==
X-Gm-Message-State: ACrzQf28UcIlnPQTHkt0X+DJdjZzRRlSqlNr4OWar3FPRxnna/0TLm0n
        XvC1f5ZdtoeBE0t/2qubvTq5zg==
X-Google-Smtp-Source: AMsMyM7qSGREB3yZtzh4NB3yiFrMVNwRE3iO2Jdqd329JikQegHzwdbB8mxPOwlUSvCzLS9OKhKiww==
X-Received: by 2002:a05:622a:181:b0:3a5:492b:c3af with SMTP id s1-20020a05622a018100b003a5492bc3afmr6142031qtw.383.1667479572295;
        Thu, 03 Nov 2022 05:46:12 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05622a488b00b00399d5d564b7sm454947qtb.56.2022.11.03.05.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:46:11 -0700 (PDT)
Message-ID: <f4ca26c6-6c03-b7e7-3d5e-f6bc42c3a785@linaro.org>
Date:   Thu, 3 Nov 2022 08:46:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SOC
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andrzej.hajda@intel.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        smitha.t@samsung.com
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
 <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
 <20221102130602.48969-2-aakarsh.jain@samsung.com>
 <c55d29d2-a70a-f2ae-b605-1c63051202bf@linaro.org>
 <aadbb452-506d-89cc-28d9-497369c0018e@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aadbb452-506d-89cc-28d9-497369c0018e@samsung.com>
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

On 03/11/2022 08:44, Marek Szyprowski wrote:
> On 03.11.2022 13:35, Krzysztof Kozlowski wrote:
>> On 02/11/2022 09:06, Aakarsh Jain wrote:
>>> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
>>> Exynos3250 and used the same compatible string as used by
>>> Exynos5240 but both the IPs are a bit different in terms of
>>> IP clock.
>>> Lets add variant driver data based on the new compatible string
>>> "samsung,exynos3250-mfc" for Exynos3250 SoC.
>> Aren't you just missing the clock on Exynos3250?
> 
> Nope, the Exynos3250 variant indeed has only one clock and the driver 
> code simply ignored the -ENOENT error while getting the clocks, see the 
> code in drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c, so it 
> worked fine even without it.
> 
> IMHO it is a good idea to clean this up.

OK, then please make the new compatible followed by old.

Best regards,
Krzysztof

