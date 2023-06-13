Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD972D752
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjFMCUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbjFMCUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:20:02 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2105172B;
        Mon, 12 Jun 2023 19:19:58 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-558b6cffe03so2944689eaf.3;
        Mon, 12 Jun 2023 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686622798; x=1689214798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rc8puRsMNB1FwhvbPkjunTvdFQSMdNIDd9z2KyEZcY=;
        b=UkAIuPO4nfCvYOa1VJ1tK7XVbWnl1M1hYkZ6FaKYumVSAbsNQGAw4XzRXcAK2edeou
         5IAoEdSkabS7OOhcu+8RuwI5UVBzOgyveX6ek7QdbyJZsitqtqYsLk+tEwXiqJsUWgkv
         6hSJo/I0yJDTN+M0MxG7XUeZcP3sAE1RKNF6ZuWwz1P4YwLL2U7RFL8l+k144VshgBgo
         FcW2rd0s8Z7nl9JaEXKEdxzZFIuS/oBoDcgyrncNUuepa3er1cqe1n4dofeCv3yOnCt1
         emRx9Qzdm/IcLOyRKv0ufSW2wQgJJU3ZUtc3CLUMTSXFQlWTmic58/vDe3ycN0i8uYhO
         NXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686622798; x=1689214798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rc8puRsMNB1FwhvbPkjunTvdFQSMdNIDd9z2KyEZcY=;
        b=N0wvTugjE9jkuabrEF6PSD04dKmqORaZrNqU3auoUXx8vvrDHCUOJhnLAHGO07WtHk
         SBYYR/CtZ1hN4cyTban+tip/FRWBiHNorMosDeFpUH5Vuy3xTr+OuX/c7zi2KMSPy3Nw
         SiXjn3sviDgOIozdWkh8+wNKalrtwtRHkV2qGaO8QDPcGLPpNG6JXlFB57ozF+cSaPH4
         pwz44gbJkTStxkcSWQfoHwxFd32coh/7SL0LBWujYBFbnja5hik9+/nqjsUhWRd+QA/W
         6ioMo89O3RDI1TN1WAuR89Wgo+DOGJtHfnqQRs90RMuIt/W3KduL+uLJUYShnrjB6Gzh
         MKGA==
X-Gm-Message-State: AC+VfDz8afXtFZCEi70Nc3uMGFbP64EZvqw8m95Q+5yTbe/BOZu4lxZU
        W4aYNzrcKhdcm5UK900DY2COfwiYXXE=
X-Google-Smtp-Source: ACHHUZ4NUAZrRFfEixwJIufjYq1nC+yN5/3MPpGckOQqgAHxA7p/K+Zp1j/d7YD4R3hfhoAUKcWi/w==
X-Received: by 2002:a05:6358:cb1c:b0:129:c25e:1caf with SMTP id gr28-20020a056358cb1c00b00129c25e1cafmr4848634rwb.3.1686622797910;
        Mon, 12 Jun 2023 19:19:57 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a630b02000000b0051b7d83ff22sm8127529pgl.80.2023.06.12.19.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 19:19:57 -0700 (PDT)
Message-ID: <8b0376be-fbee-f4ad-c0d8-f12471fab7ae@gmail.com>
Date:   Tue, 13 Jun 2023 10:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 08/10] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, tmaimon77@gmail.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
 <20230605040749.67964-9-ychuang570808@gmail.com>
 <bda5f640831a8080a83eca8c8e37c30d.sboyd@kernel.org>
 <233f4e83-e872-5499-2ca7-a1c277425fb0@gmail.com>
 <b4a20267862f6cd20d50016cb130ba95.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b4a20267862f6cd20d50016cb130ba95.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/13 上午 10:16, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-06-12 18:37:31)
>> On 2023/6/13 上午 09:02, Stephen Boyd wrote:
>>> Quoting Jacky Huang (2023-06-04 21:07:47)
>>>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
>>>> +                                           int num_pdata)
>>>> +{
>>>> +       return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
>>>> +                                              CLK_SET_RATE_NO_REPARENT, reg, shift,
>>>> +                                              width, 0, &ma35d1_lock);
>>>> +}
>>>> +
>>>> +static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
>>>> +                                    void __iomem *reg, u8 shift, u8 width,
>>>> +                                    const char *const *parents, int num_parents)
>>> Please don't use string arrays for parent descriptions. Everything
>>> should use clk_parent_data or direct clk_hw pointers.
>> I will use clk_parent_data instead of strings.
>>
> When you use clk_parent_data, just don't set anything for the "dummy"
> clks besides a -1 .index to indicate there isn't a parent for that
> entry.


Okay, thank you for the reminder.

Best Regards,
Jacky Huang




