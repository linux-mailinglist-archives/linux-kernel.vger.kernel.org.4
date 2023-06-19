Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA429734D94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFSIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFSIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:25:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054DCFA;
        Mon, 19 Jun 2023 01:25:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ed230c81so2068951b3a.0;
        Mon, 19 Jun 2023 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687163141; x=1689755141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRAMSb3QLjF2Pifd9MJCuo7PLicH63ZOqCju9kt2DRc=;
        b=g9vkRqXznPmnyw096XgVwqzl/mWuQjez8CHkXq0G3sgqxo5UrY+QhcNKe7Aq9h4lGq
         LvAZYej2HJTgizPJk5Ei3J4ZtYVQx4uGPnZRikXhTKqAqQFUurbYfWeJJeZZbBns5yfW
         rasG1e0w2wRllONuQYPZ9xWB4z0mAoNgKLh/BHFENVI6DW5n+FNZdtx8885jr3Ltp1et
         rHVFeV/phZ7Ak2jEhgwIxCOCJ1b3R6m7DHs/YjnTg8DdjsvOWtPDWyN25xJtt45HlQrU
         yUUKjk5s5hvEqy7ibBXGvm1RWtPXQ0QVLyjHEH/Knr6JMS4vvk84b8YDwIXXnMGpBS5O
         s2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687163141; x=1689755141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRAMSb3QLjF2Pifd9MJCuo7PLicH63ZOqCju9kt2DRc=;
        b=U1DySPDBEQr3k4Y1Y55Hr75cx2r74dcUdjlt38sus0n2jleh+ieU/QKnyF9r0/bWE/
         WcvcP6aJvNOQ9zzefdYXJ/grqm8QPs9In86RngSUB/RXkOw5B+7wNIZRxm6S5fy5UfCy
         movTX1TZ9X6eGGuaftM62rZyUvWLpvVtH/bEUVm7kMcP9BSJcgTquOxfBFIftu9j5r5n
         1e/OTSzNMcp/yPF9Yd592azXE0gKlv3UiMytTx10OfVQ7F2z7IqpKoCnieTR5Qg4ozY8
         2rl2febR9l/Il7PsDQTOliOglYXUVdZgAGRw0cnnKNn1u7RvXpxgJa8bvMc0/MPUOTNf
         ALFQ==
X-Gm-Message-State: AC+VfDx21AT6pCWzHUu+6QU/vGz4KeuqZ9aHZVwNumZmX6T/socuAtdX
        ib18O9ztB1TmW4DUdEZlkdo=
X-Google-Smtp-Source: ACHHUZ68kJjz2ljXB0Yz5H2UWJkK6ZZQS9rxmZ3ddDF9ffIAXIG/lVIosS4Jf8SsHVunlrF9VeARAA==
X-Received: by 2002:a05:6a00:21ce:b0:666:64fb:b129 with SMTP id t14-20020a056a0021ce00b0066664fbb129mr13429469pfj.27.1687163141133;
        Mon, 19 Jun 2023 01:25:41 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78647000000b0066642f95bc5sm8075178pfo.35.2023.06.19.01.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:25:40 -0700 (PDT)
Message-ID: <f7594eb2-9c89-14bf-56a2-990bcd0c7abe@gmail.com>
Date:   Mon, 19 Jun 2023 16:25:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v15 2/2] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, soc@kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230619033041.233921-1-ychuang570808@gmail.com>
 <f3f9bd5c-b4bd-461c-a6e1-b310cdaa0595@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <f3f9bd5c-b4bd-461c-a6e1-b310cdaa0595@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 下午 04:12, Arnd Bergmann wrote:
> On Mon, Jun 19, 2023, at 05:30, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> The clock controller generates clocks for the whole chip, including
>> system clocks and all peripheral clocks. This driver support ma35d1
>> clock gating, divider, and individual PLL configuration.
>>
>> There are 6 PLLs in ma35d1 SoC:
>>    - CA-PLL for the two Cortex-A35 CPU clock
>>    - SYS-PLL for system bus, which comes from the companion MCU
>>      and cannot be programmed by clock controller.
>>    - DDR-PLL for DDR
>>    - EPLL for GMAC and GFX, Display, and VDEC IPs.
>>    - VPLL for video output pixel clock
>>    - APLL for SDHC, I2S audio, and other IPs.
>> CA-PLL has only one operation mode.
>> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
>> operation modes: integer mode, fraction mode, and spread specturm mode.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Hi Jacky,
>
> Since I have already picked up the previous version of this patch,
> please send a diff against the version I merged please.
>
>       Arnd

Dear Arnd,

I got it. Thank you.
I will send a diff version based on the previous patch.


Best regards,
Jacky Huang



