Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F947394D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFVBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFVBqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:46:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0552193;
        Wed, 21 Jun 2023 18:46:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4974588a12.1;
        Wed, 21 Jun 2023 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687398384; x=1689990384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPMiuxbS9NOOQ4+DNE9uNSqWe6GAo5kvJCb8pnY4nuU=;
        b=eEHocDbH9f9me9XpL+taH/BN1LFFZXMjMTqpcwslaXuz+vCBPROCyNBVK62b4fej4k
         3Gzm6TyXozGG1jzf/m9r8/IQaQjmMp5DSLthq/69nbB6wgrgg0YDptpZ20SSPmwyWETZ
         uKGHw1BgT6xsfR07WvbyYmithQtipKUUjF9g+ygIbS67/n9kzCl7BH07s10SVTUJAQy/
         7bRolrmyPG4r7iw9MVMkPLTLp6IAhGFOriLhEs60A+iR9X3EXSwnc+BoKQSIMUJLsVmr
         XCqdcAi4co7WohQ0sb0TVYQaR5ZuMEZUTQCoxLdFjWAOuLrfgp/MDTKRyhBPz5YxikGG
         YEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398384; x=1689990384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPMiuxbS9NOOQ4+DNE9uNSqWe6GAo5kvJCb8pnY4nuU=;
        b=kCdg4xxgD+ufsp4/+nWyo6g9PGveznb2DEE4rQDhy2DgyZj+89dl79wkcTMj6OG+bt
         dNrYosjKjoYikQiEIcpKdo/FsN2ZqZQb2zmWXL3lMHP+XdBg9aDVqr/fX7qoduQ5cD8M
         VMHAqTY00f7uJoTwVouuH4CHQgmx4Dsf8KgQOjwm8T4OVy6LV2yJbRnzzIT3eEXiz5GZ
         tgrtiWmwpg90DP3kqsHhI2VEvLr12glwxlAMNPymDOCRkFyNoyqSFm4El2yAqmPUWHWQ
         tJPqKuAoHiQ4hdftc4WQENtBso5mQ05xRqEHXrF6Z/4J+csdFnWiSV+lRy6w76wrK0NR
         QYBQ==
X-Gm-Message-State: AC+VfDyW3zGLH1fvxeeM2cZgWueZQ2I+gK485gIjdtZwov9iwOsGpFow
        tlCgLweFtFl9a70FN12MP3E=
X-Google-Smtp-Source: ACHHUZ76OXYU9TbS+0Z4NA+bFoq6TTgVUXYsp0Yq8bzgnHbGfhRcLhpb1I/4yXUI6fgY/i7Sgw4XcQ==
X-Received: by 2002:a05:6a20:3c92:b0:122:60e8:10e1 with SMTP id b18-20020a056a203c9200b0012260e810e1mr8627801pzj.31.1687398384117;
        Wed, 21 Jun 2023 18:46:24 -0700 (PDT)
Received: from [192.168.1.101] (1-160-168-200.dynamic-ip.hinet.net. [1.160.168.200])
        by smtp.gmail.com with ESMTPSA id r22-20020a62e416000000b0063b86aff031sm3461297pfh.108.2023.06.21.18.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 18:46:23 -0700 (PDT)
Message-ID: <8d87f85d-f239-bc8b-c48b-143ceac30082@gmail.com>
Date:   Thu, 22 Jun 2023 09:46:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] clk: nuvoton: Use clk_parent_data instead of
 string for parent clock
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230621031605.234149-1-ychuang570808@gmail.com>
 <20230621031605.234149-3-ychuang570808@gmail.com>
 <2023062103-obtuse-parasitic-e675@gregkh>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023062103-obtuse-parasitic-e675@gregkh>
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


On 2023/6/21 下午 08:51, Greg KH wrote:
> On Wed, Jun 21, 2023 at 03:16:05AM +0000, Jacky Huang wrote:
>>   
>> -	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0,
>> -					 26, 1, axiclk_sel_clks,
>> -					 ARRAY_SIZE(axiclk_sel_clks));
>> -	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux", clk_base + REG_CLK_CLKSEL0,
>> -					  2, 1, sysclk0_sel_clks,
>> -					  ARRAY_SIZE(sysclk0_sel_clks));
>> -	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0,
>> -					  4, 1, sysclk1_sel_clks,
>> -					  ARRAY_SIZE(sysclk1_sel_clks));
>> +	hws[AXICLK_MUX] = ma35d1_clk_mux(dev, "axiclk_mux", clk_base + REG_CLK_CLKDIV0, 26, 1,
>> +					 axiclk_sel_clks, ARRAY_SIZE(axiclk_sel_clks));
>> +
>> +	hws[SYSCLK0_MUX] = ma35d1_clk_mux(dev, "sysclk0_mux",
>> +					  clk_base + REG_CLK_CLKSEL0, 2, 1,
>> +					  sysclk0_sel_clks, ARRAY_SIZE(sysclk0_sel_clks));
>> +
>> +	hws[SYSCLK1_MUX] = ma35d1_clk_mux(dev, "sysclk1_mux", clk_base + REG_CLK_CLKSEL0, 4, 1,
>> +					  sysclk1_sel_clks, ARRAY_SIZE(sysclk1_sel_clks));
>> +
> No need to reformat lines that are not actually changing anything, as
> this makes the patch harder to review for real changes in it :(
>
> thanks,
>
> greg k-h


Dear Greg.


Thanks for your advice.

I will modify the patch again to remove these irrelevant parts that have 
no practical effect.


Best Regards,

Jacky Huang

