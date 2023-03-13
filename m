Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A077B6B777E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCMMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:30:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6C4109F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:30:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so16878444edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678710619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmn2nanx9djz8+cvYSEMDrQgDosVq8taY8kBuZP96dQ=;
        b=Oi4/QA9NHRIFvwt8o68xzUvZ6ZRD3e3g4it/tyEvKJJkr8KURbc4Vo6kqOwolyD1Q5
         8a/P7oZ1IhcOXtQal2xy7BzMCOhAMxj8ki1ai5zsrhvFEHyFteADBfMc2AdNNWeMLM30
         e87z7bdg3YQRybWDaRi4Au7DtUVg5ZYN+V8KzdWXfHIRfy7Pc3NyRQESmiCV6HwunXiz
         umjBmLYJuFwPGsBgfH5KfFfLprUJqMyhxMbC3telhO7S2W6tI5Wjz+M560Xxt2AkerUT
         y5YDikylUGkVaKbZOx+xNc2r1n68p7Z14zP8r8JWMyoBma70M3hzI6xQG5U7TsmBfOxu
         3Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmn2nanx9djz8+cvYSEMDrQgDosVq8taY8kBuZP96dQ=;
        b=KNS61R+YOR2epAop+g/L1+wPLO9adgBPdblTWOLNDqGQHqZi+1l4uxyTFf7bnPc/gm
         RQh4VxrBG+SJV5tzrAJ/jd/+MOImB4QBRSsxhC0uPIBsi7SeP01rLXba48OZoGn3HzPU
         xWuDMdk3FFD6f3CcBuBmuC16YXGz+XAIVU3Rg0jIZg5zz0hwh4ftLROqlFKnwSlvF0il
         nNA2+rL5laqnfUSalf2axFbXpH/b2Z0RnWOIQSsRIMLEdFYPmAImnd+ojAeB2Pw162T1
         58TfoS9/gS6GKXqfZa3F/blTt9jxKO+Nr14SOoUl0ThlezmSl1uMS2zLlD8ah77dpg1g
         fI0A==
X-Gm-Message-State: AO0yUKWn4baBdSssIPE0Z4lIMwXud6QNVeiLR9b8IcPpNKhrkEWj6d3Y
        JVxGDYf+04WmQCbnLSRMj86Alg==
X-Google-Smtp-Source: AK7set8vWnZvlNjQcq0Vh4v0+v2/D3pvGv7QjKi5Zpb1zXBn6XgfOOuoIqOEDpSc2Xt2IGKJW43YoA==
X-Received: by 2002:a17:907:a602:b0:8b1:76ca:f228 with SMTP id vt2-20020a170907a60200b008b176caf228mr34379930ejc.39.1678710618957;
        Mon, 13 Mar 2023 05:30:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:69db:4882:d071:27c4? ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b008e51a1fd7bfsm3426297ejc.172.2023.03.13.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:30:18 -0700 (PDT)
Message-ID: <0499e6e7-ab4e-3e7a-d6de-0979bd0d8cc8@linaro.org>
Date:   Mon, 13 Mar 2023 13:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230110083238.19230-1-jim.t90615@gmail.com>
 <20230110083238.19230-4-jim.t90615@gmail.com>
 <d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org>
 <CAKUZ0+HiR+GDG4EP8nxyVVMQrkotvyQP3N3Rs7+3d2aTLEtMoA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKUZ0+HiR+GDG4EP8nxyVVMQrkotvyQP3N3Rs7+3d2aTLEtMoA@mail.gmail.com>
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

On 13/03/2023 11:38, Jim Liu wrote:
> Hi Krzysztof
> 
> Sorry for the mistake.
> I think I need to explain more details about the clock.

It's still top-posting.

> 
> The NPCM7xx / NPCM8xx  SGPIO feature have 4 pins.
> picture is as below:
> https://drive.google.com/file/d/1E9i_Avh-AZV9IEZO1HLMT4EtgCBe46OV/view?usp=sharing
> 
> The clock is generated from npcm7xx APB.
> The bus frequency is derived from npcm7xx APB not HC595/HC165.
> Users can connect  1~8 HC595 on DOUT pin to decode the serial data for
> HC595 A~H pin
> and can connect  1~8 HC165 on DIN pin to encode the serial data to
> send to NPCM7xx.
> 
> The test device is as below:
> https://pdf1.alldatasheet.com/datasheet-pdf/view/345467/TI/SN74HC595N.html
> https://pdf1.alldatasheet.com/datasheet-pdf/view/27899/TI/SN74HC165N.html
> 
> NPCM7xx/NPCM8xx have two sgpio modules;
> each module can support up to 64 output pins,and up to 64 input pins.
> If the user needs 64 output pins , user needs to connect 8 HC595.
> If the user needs 64 input pins , user needs to connect 8 HC165.
> 
> the HC595 and HC165 connect is as below:
> NPCM7xx_DOUT    ->   HC595  SER pin
> NPCM7xx_SCLK     ->   HC595  SRCLK pin
> NPCM7xx_LDSH    ->    HC595  RCLK pin
> 
> NPCM7xx_SCLK     ->   HC165  CLK pin
> NPCM7xx_LDSH     ->   HC165  SH/LD pin
> NPCM7xx_DIN        ->    HC165  QH pin
> 
> The frequency is not derived from the input clock. so i think maybe
> the yaml needs to describe it.

That's not what your code was saying. It said:
"Directly connected to APB bus and its shift clock is from APB bus clock
divided by a programmable value."

> if yaml file still didn't need please let me know.

Now read the description of bus-frequency:
"Legacy property for fixed bus frequencies"

Don't add legacy properties to new bindings. You have
assigned-clock-rates and clocks properties.

Best regards,
Krzysztof

