Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF506D0229
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC3Kwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC3Kwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:52:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE3C9;
        Thu, 30 Mar 2023 03:52:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso21497014pjb.3;
        Thu, 30 Mar 2023 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680173535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTW1KNElMTqle5HEHRBSAcEJNim2iyioQE5RQEzYbdw=;
        b=BvWvc7f13UO2dZkYEfqF5+pb5eMP0PVyqrKRxbwY+t1pZ4oh3Hcvn2bFPjeytGynvW
         R0Lw4+lumQyLU69bs8HVLqw7JItlOf2Sscgpn7nioTkM1SD3FiMygwXYiYM44L6j2fdh
         WrVd7AeVXWTjJxjA6DLlGJtgFDTJ9zaDKD9AOfzz74BRxaGmaP1Zt30OdCtnoL5w7a5S
         zdCOZGbYDJyuAJyq4Cal2Bg2pqnnM014WvqRRxSitEIdLz/FfeL/xbsYeC34Pe+IjuOl
         kfmpnoQOVXEu8BPXMH4xsEXb88CUqURNtGwxfdvHIWYo37WyLHive+ekUmnU3Pf0Iy9C
         /8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680173535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTW1KNElMTqle5HEHRBSAcEJNim2iyioQE5RQEzYbdw=;
        b=onHA3EKces5QkYXlP7k7Akxn/4T3wwCvtYXj/aaudbmAR2yJHwVRMgTgSvkNlC8caM
         pm6QkCLKWYOcUK/azcbvXrCREX1Hxw8Dr5D8cxIUc2QjwauJ2pnXH2C8mcY6yRJBAmPO
         3MrFTijEpcdGmskW/5JLMT3LgXIY8XK9so7fslD0tjTr9Ut2RK2JT8gBzzpeaIT4PLFS
         LPn5YqEuSQQrCvvufXJL/fJ9OZQAEPRo4XLFDEymK8HI/omXOQBNCjY4AhJZ/xivyYLb
         B+j7AVvUhmwL7p+Gg1QCIyUgfzIQhJ+MoXVKyeKQs46Arpo4e5YZmHcedOuYeIBvepq+
         m0kw==
X-Gm-Message-State: AAQBX9dNKV4GVPg9SD5G+lXU8kLuAHhYgZdOcWFNWxgYa78aTBlodVQj
        elUXmsCoBPRqTJmkQw3Yy/I=
X-Google-Smtp-Source: AKy350bRC/GtaxNa5mRK4IrBQlZWHOdOCh3e9bfrlRbD5TncI8syNL+EJ55MVS0+Us5TjIgEq+X/Rg==
X-Received: by 2002:a17:902:ec8b:b0:1a2:87a2:c910 with SMTP id x11-20020a170902ec8b00b001a287a2c910mr3559370plg.53.1680173535575;
        Thu, 30 Mar 2023 03:52:15 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001a01bb92273sm24428522plb.279.2023.03.30.03.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:52:15 -0700 (PDT)
Message-ID: <8bf559ec-0f5f-7ac5-6400-ccd2395b3b95@gmail.com>
Date:   Thu, 30 Mar 2023 18:52:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
 <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
 <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
 <4c1fa450-79c9-2c66-4bb8-b880f2cf07a5@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <4c1fa450-79c9-2c66-4bb8-b880f2cf07a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 下午 03:33, Krzysztof Kozlowski wrote:
> On 29/03/2023 10:44, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> Thanks for your review.
>>
>>
>> On 2023/3/29 下午 04:20, Krzysztof Kozlowski wrote:
>>> On 28/03/2023 04:19, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add documentation to describe nuvoton ma35d1 uart driver bindings.
>>>>
>>> This depends on clock patches, so it must be taken together.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> OK, I will combine this patch with the clock patch.
> I don't know what you mean by "combine", but I don't think this is what
> we want. You must clearly state all dependencies and patch merging
> strategy/way.
>
> Best regards,
> Krzysztof
>

Dear Krzysztof,


I may be misunderstanding your request.
I thought it was moving the "nuvoton,ma35d1-serial.yaml" to the patch of 
nuvoton,ma35d1-clk.h.
Would you please provide guidance what should I do next on this [PATCH 
v6 07/12]. Thank you.


Best regards,
Jacky Huang







