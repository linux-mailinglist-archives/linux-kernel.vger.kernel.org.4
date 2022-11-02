Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069961689B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKBQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiKBQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:23:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556512CE12
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:17:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f8so12059531qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJek6NkURfosAp/uchM0s6cEp+OyqcYE/P5UFkvDx6c=;
        b=Beiw3KD5m0lV/hwTJJ4HkM8dOSrGiiegu49uo6QrhJ/Ek2JltLFdnlRfuJ90ZKJLk2
         rs5qjFPoSzlBuFqtIsTu/wJ/tjYQqxoqW1vDt365YkD97j9BdBo5rSaSJ6zDYG5E5DZG
         +MEwX2pHBQDnCfC5nl/IyrIz/5SVFK6FG2cSaXv1GiF7ZZl07BNezv3tJC68lIxQ6Ppc
         TCl2T74zLwlCLik6amA+9TaPYdh0eygJEGAVler8+KiHV6gYKC/mFGxgeC0e/V7B+i+v
         aoqkyADe1sOKPFx0wcOGUyNO6xRXqpyx3ZrmggMS8pdCij2u1g62wuG3ha11P97XEIUQ
         dDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJek6NkURfosAp/uchM0s6cEp+OyqcYE/P5UFkvDx6c=;
        b=8IUoU6PHSGCdwzU4VbJBXuenwG5nQ447zc1yhkP2+uO5ze4nFrMYdn5hvdpIoa9cML
         z2pBHNIUf2iisR0CCXezx91IVd1pmxzPKJSm6q3K+zH+2QiKrz+0VjJ1KVTVYLBmefLX
         OStiHjmtAt99jhM2W018dR7TsxVSFC1wUilbAZZTNe+wYgmSjBLJr+D2JzcsTv+6cM2L
         LfrRtwVElHEcPp1VEmOigCl+hCErgHQwgPowYqrD+HubNOVKn+CDH7SdCbiRv8xe1P+v
         mQ4qjF6gT3eLytONtrcJVX1lD2OGX3colAXw4q9pXqQN5puQNvsJx7itu2vWhR2mn8MK
         KSmw==
X-Gm-Message-State: ACrzQf1oecyLmKk/0YQLv+Af+V5PinM5+K/IoZYy2A2/ApRhUjBF7p30
        bH1mzVKzRC7/6sIFOAc1UnaCxg==
X-Google-Smtp-Source: AMsMyM6jI/HdsQJ1lS99LjoIpegy8BZrn9T/tm8NZcJHyPfkCUONRJvFwq4pMfMr751vTSJTlDVwgw==
X-Received: by 2002:a37:de0a:0:b0:6fa:422c:1fda with SMTP id h10-20020a37de0a000000b006fa422c1fdamr8696702qkj.607.1667405851525;
        Wed, 02 Nov 2022 09:17:31 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b006eecc4a0de9sm8578474qkk.62.2022.11.02.09.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:17:30 -0700 (PDT)
Message-ID: <abc9ed33-26d2-b850-8c7a-78cb1735ddb2@linaro.org>
Date:   Wed, 2 Nov 2022 12:17:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: add loongson-2 clock include
 file
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221028025504.13247-1-zhuyinbo@loongson.cn>
 <01a38c4c-b42a-c170-3c3d-0b7e087bfaa4@linaro.org>
 <2bd0f05d-a5c4-3c5c-ccbc-3e3385cc0a1d@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2bd0f05d-a5c4-3c5c-ccbc-3e3385cc0a1d@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 22:54, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/28 下午7:43, Krzysztof Kozlowski 写道:
>> On 27/10/2022 22:55, Yinbo Zhu wrote:
>>> This file defines all Loongson-2 SoC clock indexes, it should be
>>> included in the device tree in which there's device using the
>>> clocks.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>> Change in v5:
>>> 		1. Replace loongson2/Loongson2 with loongson-2/Loongson-2.
>>> 		2. Replace soc with SoC.
>>>
>>
>> Where is the rest of the changelog?
> What you're asking is where the replacement string is located.  it was 
> in commit log.

I am asking why there is only v5 changelog? Where is v4, v3, v2?

Best regards,
Krzysztof

