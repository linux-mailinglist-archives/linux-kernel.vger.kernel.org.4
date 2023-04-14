Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB76E1E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDNIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:34:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2694ED5;
        Fri, 14 Apr 2023 01:34:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so6937372pjk.4;
        Fri, 14 Apr 2023 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681461278; x=1684053278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXMwXqcrpUiU9dk+EsfRSt5kNG0i+4dtdeK+iRChPWc=;
        b=SvKsmpW4bm6DL+E4UfMWhLf77qqTurbgjNAeMlCkEKhmHwoX1lcM2KGJweIhJsSWUM
         +aLFrme183Er6PtYgySl/1KNdYhdlQeAwi7pjO13QI/8MF2yEc1CkFX8S7gLCgggq6+u
         zOCrcHv6X8Tv3R/XRdQwqjAt2RzPA7zrVXqIOu12XItrq01jPT6E1zicRXFaXTIVybK3
         Sp0mGAtUGl1x413GRyolpv0kxnjcy+SkX2gtF0LaMpGCBvMQmBQYGPJNxtEDjzw4a1ye
         SKC9db/3odJHenRwFK15SV1PO6NkwWPzFVg0+Y/bGd/Dfk9dDL+JSzWS7y8CGSDfsOWR
         QqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461278; x=1684053278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXMwXqcrpUiU9dk+EsfRSt5kNG0i+4dtdeK+iRChPWc=;
        b=SiF6DvSwJvQQPRugZoMHxsa6oAZAyOOLel+ENZHkP+c7IupdfK3EQHsUYVQIm/Av2z
         SPx/OyKO5aimHdOLBkfxZ1BWedwA6u2sKf0UaX36dOZ9twDS4epU7ZnlEcVHvHKWsR0R
         okafsn8BMZjPgkMuqxQB68APDx1+7rHilAtb+wGeZdFodD7aK3qFg6TBlwmc07eqnQdK
         b4pMw0qKGDSTc8G2yb/uhBt3F6nJczD2KSVRzY9oM2Jk0QJ/Ll9+fKMvx7bgBKohDYG7
         ZH9JRCJnTmekGbqnLldi2z85gtii4Y6e2lXo96wQqcikNjNGHZY+K1FHotXY7hKhzUVW
         xrJg==
X-Gm-Message-State: AAQBX9e6XXjruiYIZYkr2sKhCKARsJSgM9rBR1YpQ+uHqP7po3B/5tBy
        ZVytJTQ0RBTimAavGa2VK3I=
X-Google-Smtp-Source: AKy350ZutiwM2zHwZT3hOp9PJUH4ekEPRJgSWPP3fk5qersMoeH3CbZx7I5ACHxSY3zuxWKS7sBsoQ==
X-Received: by 2002:a17:90a:43c6:b0:246:b4b4:555f with SMTP id r64-20020a17090a43c600b00246b4b4555fmr4861345pjg.7.1681461278098;
        Fri, 14 Apr 2023 01:34:38 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c15-20020a63d50f000000b0051b603bf22csm1287769pgg.69.2023.04.14.01.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:34:37 -0700 (PDT)
Message-ID: <a7217c06-1037-9245-1241-33a7b1398907@gmail.com>
Date:   Fri, 14 Apr 2023 16:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
 <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
 <69b0aa3a-f5d2-8310-81ae-61d379db0d3b@gmail.com>
 <20230414070326.GA1036697@google.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230414070326.GA1036697@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/14 下午 03:03, Lee Jones wrote:
> On Fri, 14 Apr 2023, Jacky Huang wrote:
>
>> Dear Krzysztof,
>>
>>
>> On 2023/4/14 上午 12:47, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 07:38, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add Nuvoton ma35d1 system registers compatible.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> What about the tag? Why did you ignore it?
>>>
>>> Also, wasn't this applied? Why do you resend (incorrect version)?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> When I was making this patchset, this patch was still not merged.
>> So I'm not sure if I should remove it.
>> This is just a resend with no updates. And I will remove this patch
>> in the next version as it was applied.
>> If possible, please add the following tags for this patch.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> I added this.
>
>> Reviewed-by: Lee Jones <lee@kernel.org>
> When did I provide this?
>
> --
> Lee Jones [李琼斯]

Dear Lee,

Thank you for your help. And, I'm sorry, I thought 'applied' meant 
'reviewed', and this patch
didn't actually get your review tag. If this offends you, please remove 
it. Of course, if you are
willing to provide a review tag, I would greatly appreciate it.


Best regards,
Jacky Huang

