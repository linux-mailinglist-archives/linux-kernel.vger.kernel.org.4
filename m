Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797826BF75B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCRCLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:11:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553296422F;
        Fri, 17 Mar 2023 19:11:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j13so7186228pjd.1;
        Fri, 17 Mar 2023 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679105505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zI0yBx4d8vdMtB+YaSxWS1LI0ZmHMo+83XiyK1URtHs=;
        b=MhFu1Fwcp2kBb8u0E09bT1kl0lIJumPpd6QCQbPReSWhXD8yQ9h6hZnG9HBVPk9frm
         rw4GpMXSMVuCiasLC/z/DjW3CcvY1ICBiWXkWENwlw2oTFB3lLLcngGz8FhODZA9LOoZ
         Je5CPcZ3vel/epKUnWpuhaVVTTH1CnlPBOgHkyM3oqRIkSMXygHXD29qf2oRYuiUYtnZ
         U+db1FThhedGCuBlkrPolUBI3FaN+9u6PgZW/+DNz2WFWAsg2e9nTZV280s8oFtPcR95
         zQ9DNDehvtlZGc+msrUv8CF0N6SF6iVBTK1Nt5YXe6/PvP35BbCu9DuJAE7ERZCgWDTe
         BP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679105505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI0yBx4d8vdMtB+YaSxWS1LI0ZmHMo+83XiyK1URtHs=;
        b=UcUU1tR8bEuUcQzR2pj3n+dlUA3ZGG/LsgxJkFKYjnv2mzmstFekVBrsZb7Y6Y8kbE
         Dwp7Gz+Nn3fyiIp3lsACPW1syOTUl1VAWT3TBBmBGPc5adN6/bozDZby2APQqgqIaGPq
         mYC6oepx4927wUxUvKoRAXOT4TE9gnKyZWsG0Y40Q95R5EGiK6loOLCxR4EJtiN+mlKH
         ZG+HZMxf55qK2tG+GcBIg97J1c+bPKF2t8nQreZEXK5rZTH4lAf6LtAemaPlUE14LcGv
         6X+thsK3Jo/Nrwc7YQF21OkOlzh3AwRSTpQxqOW2N3NAVw022GyjMGXpMczxljSXCwpr
         RPEw==
X-Gm-Message-State: AO0yUKV1UCqHMvohmaIj/+/6Rvo4HPKgyLzsB8RwKj6iYAdCvyiESaZC
        OkabQw40UYk80a/OxVgKu78TMC/Z0sg=
X-Google-Smtp-Source: AK7set/AnNindADR1ivsPPaLC8vDMgUIXU6vdI7wzA7TKJrogPpnjI9FDD8/v7g89sDCjK67FkPXLA==
X-Received: by 2002:a17:902:db10:b0:19d:1474:2ba4 with SMTP id m16-20020a170902db1000b0019d14742ba4mr11240342plx.32.1679105504682;
        Fri, 17 Mar 2023 19:11:44 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b00198f36a8941sm178125pll.221.2023.03.17.19.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 19:11:44 -0700 (PDT)
Message-ID: <8ada6750-620c-fa09-91e5-88ee3491a282@gmail.com>
Date:   Sat, 18 Mar 2023 10:11:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
 <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
 <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
 <77b713f8-93bd-d0fa-d344-c8a4ec365c50@gmail.com>
 <85d9b8c3-6ddf-9b4c-76a2-8e9761eacc96@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <85d9b8c3-6ddf-9b4c-76a2-8e9761eacc96@linaro.org>
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

Dear Krzysztof,


Thanks for your advice.


On 2023/3/18 上午 12:03, Krzysztof Kozlowski wrote:
> On 17/03/2023 10:52, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>> Thanks for your advice.
>>
>> On 2023/3/17 下午 05:13, Krzysztof Kozlowski wrote:
>>> On 17/03/2023 04:47, Jacky Huang wrote:
>>>>>> +
>>>>>> +  nuvoton,pll-mode:
>>>>>> +    description:
>>>>>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>>>>>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>>>>>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>>>>>> +      spectrum mode.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>> +    maxItems: 5
>>>>>> +    items:
>>>>>> +      minimum: 0
>>>>>> +      maximum: 2
>>>>> Why exactly this is suitable for DT?
>>>> I will use strings instead.
>>> I have doubts why PLL mode is a property of DT. Is this a board-specific
>>> property?
>> CA-PLL has mode 0 only.
>> DDRPLL, APLL, EPLL, and VPLL have the same PLL design that supports
>> integer mode, fractional mode, and spread spctrum mode. The PLL mode
>> is controlled by clock controller register. I think it's not board-specific.
> You described the feature but that does not answer why this is suitable
> in DT. If this is not board-specific, then it is implied by compatible,
> right? Or it does not have to be in DT at all.
>
>
> Best regards,
> Krzysztof


I got it now. Yes, at least DDR PLL and VPLL (video pixel clock) can be 
different on

different boards. You're right, it should be board specific. Thank you.

In the next version, I will move PLL property to board dts.


Best regards,

Jacky Huang

