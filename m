Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF465B352A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIIK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIIK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:27:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401212B350
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:26:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so1952197lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rjf3+l6MpExiUnh1Bd+nB5CMQur85rkGUg6VM0DVBw4=;
        b=O8RB512Bn+Q7t0Atdu+5AkZtUaG86wv7F3nNgng05IDsMyqY5Bz/G+//df9K5DjIfo
         +pGUgtti4Du/NP9GdWyt3m/Cj4KbfiJoWOGSkn9HidFk17UyQYRvw20V2kh92r3e7eCH
         /tYfIxb2SuTby4WWGtM3503SJiQZ8Txxb+7M2LR0j/34xaOihT/2OlGo0W0Uhtlcx+BH
         uKnEE97ZUeD03IB4psakfxgQ2tK4D2115JzvhxSuG4r708kAtGZ0Ztcp6uzETn2kPzb4
         MIbDSOFRjnMFrSUNZY5J77oHx+UlFUlj3dhheG58S4fXvkCGHBrIuFMUSPYv3dZzZLSP
         1yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rjf3+l6MpExiUnh1Bd+nB5CMQur85rkGUg6VM0DVBw4=;
        b=vAhYnqk7FddsZO7MsdygKXrsUZUPuKVhOFJZ2kvK0IrEj3mYHRjBq8jWseVzK1gmvd
         5/rv5n70kNs9uUy4UWwCRd7sk77hcwu5KhToRjP2GUIcirEvzb/8uDFtVlrZFG1lUPTo
         4fkqMXXJIrbFfDWDE7uu/AKbIZG0ag/mXtzPVxxlao5EXjDuQHzR8Nq1fcp83kTig7//
         KXt9eLFc6hTXvr0oqTuHmNePHqpe/PmteEAcNP55za3aUI/qL6k9UesHpE3B9rAiHNOK
         hU2uQEzuRpNR4Uh4tuCtoggbOpQCNUAKudbzZGXejkctUoEN+LYvoI8vus62palHX9CD
         oZhw==
X-Gm-Message-State: ACgBeo15sNTA+mn6oOwif7JrJKMQu/+EEyeEoAvPvyxfnF+cA9wyse8p
        Y5+f6wUExRtlYo13y27BaByEHA==
X-Google-Smtp-Source: AA6agR6jd09WMg8R7tIo5zQ5wgKH7Sj3LUvV8fQn9ibb3/z+a656gZFZOUZ4xUWvFzpqlrAqx0VCOA==
X-Received: by 2002:a19:ee0a:0:b0:497:a2e3:a9dc with SMTP id g10-20020a19ee0a000000b00497a2e3a9dcmr3941356lfb.96.1662719214910;
        Fri, 09 Sep 2022 03:26:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a0565123b1100b0048b26d4bb64sm32492lfv.40.2022.09.09.03.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 03:26:53 -0700 (PDT)
Message-ID: <fe1838eb-8ec5-62a9-3d90-bf2fe4070535@linaro.org>
Date:   Fri, 9 Sep 2022 12:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        baolin.wang@linux.alibaba.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
References: <20220909073456.239668-1-gengcixi@gmail.com>
 <20220909073456.239668-2-gengcixi@gmail.com> <Yxr0+LJWWsF53dr2@google.com>
 <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
 <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org>
 <CAF12kFt95PYcK249Zm8r+jZtEm3vGTd3AXn2DB_CG0Xf=3xeFQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFt95PYcK249Zm8r+jZtEm3vGTd3AXn2DB_CG0Xf=3xeFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 12:16, Cixi Geng wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年9月9日周五 17:57写道：
>>
>> On 09/09/2022 11:50, Cixi Geng wrote:
>>> Lee Jones <lee@kernel.org> 于2022年9月9日周五 16:10写道：
>>>>
>>>> On Fri, 09 Sep 2022, Cixi Geng wrote:
>>>>
>>>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>>>
>>>>> Add bindings for Unisoc system global register which provide register map
>>>>> for clocks.
>>>>>
>>>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>> ---
>>>>>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>>>>>  1 file changed, 68 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
>>>>
>>>> I'll take this when the clk driver changes are merged.
>>> this patch is depends on the clk dt-bingdings, which is already merged [1]
>>
>> which is merged to different tree, so this one here cannot go via MFD
>> tree without cross-tree merges.
> Hi Krzysztof:
> I test on the latest kernel 506357871c18e06565840d71c2ef9f818e19f460
> (torvalds/master) version:6.0.0.rc4
> what you mean is I must warting your branch upgrade the cross-tree?

Ah, you linked email message so that rather indicated applying to clk
tree, but indeed it is already in the mainline.


>> Anyway please respond to my comment.
> it in different reply-letter, about the question "Hmm, why these are not const?"
> do your mean I should write as follow? what the different,
> because I found both the two ways of writing are exist
>   "#address-cells":
>     const: 1
> 
>   "#size-cells":
>     const: 1


Yes.


Best regards,
Krzysztof
