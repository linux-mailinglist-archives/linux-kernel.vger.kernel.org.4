Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221996BF77A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCRDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRDAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:00:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CDF7BA2D;
        Fri, 17 Mar 2023 20:00:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cn6so7252988pjb.2;
        Fri, 17 Mar 2023 20:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679108413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBvrljxOKkoB1S/4mky0NJx5RgxtZPsZg+SYz9qBDkI=;
        b=ZTA7hjr5SMxU5D2pu0T73SoZw4wL0d+OvP9pqVRJ4rADjAyIOyFcz/ZuVq/K28fVj5
         LGSiVcRblvHv1mdVGdAV2bCwLkpuWbpNvwUhySCyPRyll3QxMNAi6BE55hOAoqYrWlO2
         rDIbgCa8sWsWwlsEN1JmPgv2n2MggNeYp+AT6pjd013YwEkbto8YxvcRwyAyEx2EP/2N
         jTZVZxXy6InOZA3uH9W5sLc/HU0yz/hXBlICkdTtSpn5hKtCag2ROIQ4JJkt/h5uZ+Qk
         iw8bbNNqXhKL3P7V1j6jvktBLCoZiGxIPRvUtGG3bTr6Id1sc7HXtlVXbv2JYSXpFsx5
         breg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679108413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBvrljxOKkoB1S/4mky0NJx5RgxtZPsZg+SYz9qBDkI=;
        b=Dn2GvS+j0eqIRrx/iOhCn2wuPhRD5fVSbw2/zSEoQCS+BbhdEnPCb1GVlT4p+Z0WNp
         cnQXLkriwv6T5qwlHvxl86kBT3JHZZL8HWCsqP7AwBo5iq6FYOUQytKNvH/H8WC1iLpY
         uLTPrWPH0fOSwbmOEcYa04gnLiC5eywWF0Dew0tD0ogqWArwCLO/Ycwd/+VKfaiwnjIr
         2VmThk/g4w8HZv//bMzDpWl+S9Ju7N0qs1bjMNGZwkLBF9cPpGXvztWSzD1yQ8UvDKxe
         sB5INgjVDIBREAo8ZODCSxgoUYlT4fbcdohAktMx8fmvEMjC5YYqSC9Zvx0BScWgsOp4
         6AZA==
X-Gm-Message-State: AO0yUKVmTjbjPv+pR7x0Jj/VczNUHbMTh3yZCVeerwq4lOEkP6OiVKpD
        c8hLA74CHg1CqOePrAWoIBmNCrPJ0A8=
X-Google-Smtp-Source: AK7set955FdxbubOsGGFEmj1xjrvvZcsclhhg6hbhiVSISWIqaTrYEExC+Y3X0cxEGBOEyNZdFV0VQ==
X-Received: by 2002:a05:6a20:548f:b0:d5:10ca:5264 with SMTP id i15-20020a056a20548f00b000d510ca5264mr11715819pzk.59.1679108412612;
        Fri, 17 Mar 2023 20:00:12 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id a7-20020a62bd07000000b006222a261188sm2216915pff.62.2023.03.17.20.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 20:00:12 -0700 (PDT)
Message-ID: <ab2b31a3-d6e0-71fa-9e91-37add8df55be@gmail.com>
Date:   Sat, 18 Mar 2023 11:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
 <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
 <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd,


Thanks for you advice.


On 2023/3/17 下午 09:21, Arnd Bergmann wrote:
> On Fri, Mar 17, 2023, at 07:30, Jacky Huang wrote:
>> On 2023/3/16 下午 10:05, Arnd Bergmann wrote:
>>
>> Thank you very much for your kind help. You explained it so well,
>> I have understood the process. We got a lot of suggestions for this
>> patchset, and there are a lot of issues to fix. When most of the
>> problems get solved and acknowledged by the reviewers, I will
>> add you and soc@kernel.org to Cc.
> Ok, sounds good. Two more clarifications from me:
>
> 1. I expect you will have to go through two or three submissions
> that get more feedback before everyone is happy. Please include
> my arnd@arndb.de on Cc on all the submissions, but only include
> the soc@kernel.org address when all patches have an Acked-by
> or Reviewed-by from the respective subsystem maintainer.


Sure, I will add you on Cc. Thank you.


> 2. I think the series looks very good at this point, and most of the
> feedback was about minor details, so I am optimistic that we can
> actually merge it soon.
>
> I only now saw that you had already submitted this several times
> at the beginning of last year, and this is technically 'v5'
> of the series, and it would make sense to add 'v6' to the subject
> next time and link back to the previous [1] and this[2] submission
> on lore.kernel.org.
>
>
>      Arnd
>
> [1] https://lore.kernel.org/all/20220510032558.10304-1-ychuang3@nuvoton.com/
> [2] https://lore.kernel.org/all/20230315072902.9298-1-ychuang570808@gmail.com/


In fact, I was thinking about this before submitting the patch. Looks 
like this is causing

confusion for reviewers, so thanks for the suggestion. I will submit the 
next version as v6,

and add the history of v1 ~ v4, and this version will be regarded as v5.


Best regards,

Jacky Huang

