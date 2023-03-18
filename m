Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708F6BFA42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCRNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:32:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70883305C9;
        Sat, 18 Mar 2023 06:32:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso7962750pjb.3;
        Sat, 18 Mar 2023 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679146345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fE4fkK4CVvPV2ORVzxsWLs3YTL4Kj2gXtPF2Q+CSy8=;
        b=DZroDm5W2oC5U48qFw3XK3nEpzf5+YaeX2vZwKhAeqvVH2iJ2+aKGcxpgGvbP+EJbl
         fyOUq2FwopdoFR0LX7N+VGWYXPxqUtLGzmisjD5MehNZz77Ak0mT72VAztsECgdjd9Bo
         qZNgI+wQJbb6NFdxD37IwDwrod38wNUHscDncoCaC0oLIXB0KECGx5MFPBRidOldICQW
         7aR10kAB9WxS4cFMiOZCpDdkVnLvobgykPgwWfm2w4uHewnWxvMff/Ylx/8ZCou5C33h
         +fWJsu8F8cssoxgBdRl4jLBPtkZeB57f7zodGu5s4xU5fIoBy73x/dhT68OrsHOzIt5L
         ZK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fE4fkK4CVvPV2ORVzxsWLs3YTL4Kj2gXtPF2Q+CSy8=;
        b=WU2TLHXMHOhCJhCGnfRfu6l8q8EgUKg+O1by8cO6cPmgaDWn4mxJJ5UbAG9N2ULyPZ
         0hOLU3SA/2Wh2cXV3wu5tOG6IdEKOLw6M2OY23hphG3GZSofRZAPkvBs+aFfSFhLBrno
         bnV/64yW4kULCEPGTzmKwmDtJZ2QamaYbb60qRf2vtpNVoKK7PuQflWAYEb8S5ALlR8O
         kWrDQhvjT70N4URSCJNQ7IWHls8uNVy9FGTMdGbf+n3q2qD+pTEIG04+J79OFQcrgY4z
         LFBHu7/kG4cyfuuKfG1VjJxbDH5hvqfs+2rHpSCz8ghP4MqXWn/4kRrsh8nk9VzPyWYv
         ZnfQ==
X-Gm-Message-State: AO0yUKXuBtY/URAMpnb/zWPvxpWZ0H7u6e5uIBfmx0Lpu5/wY7iNzHBA
        rjIGaG2px6UInUHic7U68Ns=
X-Google-Smtp-Source: AK7set9D/+jbrcpZKCdza1ZHngFovGsWsbMZ6mL0qbwuisVAz9e88VJCOyzVzDFz4NH8d+zyKAk7jw==
X-Received: by 2002:a05:6a20:4a04:b0:d5:1f74:7e65 with SMTP id fr4-20020a056a204a0400b000d51f747e65mr10098873pzb.43.1679146344744;
        Sat, 18 Mar 2023 06:32:24 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78e48000000b005a9bf65b591sm3254828pfr.135.2023.03.18.06.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 06:32:24 -0700 (PDT)
Message-ID: <35870fce-210b-d3ab-df7a-e4e49ce49391@gmail.com>
Date:   Sat, 18 Mar 2023 21:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
 <20230316164428.GY9667@google.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230316164428.GY9667@google.com>
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

Hi Lee,


Thanks for your attentions.


On 2023/3/17 上午 12:44, Lee Jones wrote:
> On Thu, 16 Mar 2023, Arnd Bergmann wrote:
>
>> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>>> +	mem: memory@80000000 {
>>> +		device_type = "memory";
>>> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
>>> +	};
>>> +};
>> In most machines, the memory size is detected by the boot loader
>> and filled in the dtb in memory before starting the kernel, so
>> you should not need two separate files here for the two common
>> memory configurations.
>>
>> Since the machine is called 'som', I would assume that this is a
>> module that is integrated on another board, so more commonly one
>> would have a dtsi file for the som in addition to the one for the
>> soc, and have all the components of the module listed in this
>> file, while the dts file that includes the som.dtsi lists the
>> devices on the carrier board and enables the on-chip devices
>> that are connected to the outside.
> It's using syscon and simple-mfd by the looks of it.
>
> --
> Lee Jones [李琼斯]


We just copy from what other chips's dts have done.

This seems be defined in Documentation\devicetree\bindings\numa.txt.


Best regards,

Jacky Huang

