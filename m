Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C086F8F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjEFGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjEFGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:31:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F89ED3
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 23:31:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so33419237a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683354683; x=1685946683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAtZBzGq/K371lgu2uGriXQv86Ola8BpEn4aIcDi9OQ=;
        b=m9MzzgGRrTGwMDNjRn1SfcbtC0bE+JN12uUt+jLjTrZ5ZuHakyZdEdbV94qNFvLFuq
         RimCyEsemP3RchBaz3DsuHMr3+ZTrJgSHMFUSKsWV4Ys2bqrTW8S/K0m0u0N5W3MG7p3
         mKIoXzBNZ0e6fAww/isJIycI4nDbmKgRkBGukwyu5lFGyTCDIQByg/yFU0uVeD4lJZ40
         gvvj3v/qs3HZw7bMnIs7o+YE0HAuENH8DdwaAPBTgvYyOAFopBidrA8NTrVz1tyiUp/J
         WiLabHKJYfOHPTpzMWZACHM83Qe38692dzkEjQMPEbmmGJqEp69MwDOfyICxCCR6PA8A
         rkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354683; x=1685946683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAtZBzGq/K371lgu2uGriXQv86Ola8BpEn4aIcDi9OQ=;
        b=NY8yYAPBWH+hDHAItxZ4MxdwDckfOOB9A0V7yjAWryMNifFcv95MBbDbqwl8UCcKpg
         Y+KOqujKrEq8c5JrZD009PncCImETWCp85URiPCssqw2RsKHpdTqBX4zB2MjWYt3Xa03
         79WDElVHsTOhgRMGSX70FjR2d/hfPEVdMHXIulHUVRRnGRKEBTRIhjB3nza84KJ3LEKn
         iGbdSulWB9kGTpLGV0oDrQfY8PqHa6Qgre7gtmj98LfcFoZ6MQE8/TChFpHY38re7tVc
         jzOzTDcZcpq61GJ3T2+egp3m2wzu9+CtNBO62YHjdE4NOAd8d2nZh5QNC3uExGhGomex
         Ua9A==
X-Gm-Message-State: AC+VfDzogm8W60ejaJAF9R1OTBhVdg7ekPujZAhovPiju+TvS4seerbI
        fXW7VCjozc5tbTC7bNfG5UsCGQ==
X-Google-Smtp-Source: ACHHUZ6pZsEivEFSme4odojv7RRMViKRqgoDTFoMhFVUH8QIGY17Kx6qZrjLonbVuVyerntCZm25VQ==
X-Received: by 2002:a05:6402:4405:b0:50b:2088:3533 with SMTP id y5-20020a056402440500b0050b20883533mr4681883eda.1.1683354683120;
        Fri, 05 May 2023 23:31:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id r12-20020a056402018c00b0050bcaedc299sm3664387edv.33.2023.05.05.23.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 23:31:22 -0700 (PDT)
Message-ID: <9e7b265d-bfe5-f583-2357-d8e342bcf982@linaro.org>
Date:   Sat, 6 May 2023 08:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
References: <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
 <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
 <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
 <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
 <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
 <5adda0ad-965c-fbf0-878c-9d41d28b5c39@starfivetech.com>
 <86693969-59bf-5bcc-42a3-b6e94a0d6f3e@linaro.org>
 <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
 <20230504-worshiper-ongoing-5581e1f2c2c4@wendy>
 <2f473307-2219-61a4-fa66-5848fe566cf0@starfivetech.com>
 <20230505-magician-poet-724c96020c2f@wendy>
 <ba6a1a47-d3b1-ee16-4785-f5c61d593127@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba6a1a47-d3b1-ee16-4785-f5c61d593127@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 03:45, Changhuang Liang wrote:
> 
> 
> On 2023/5/5 20:38, Conor Dooley wrote:
>> On Fri, May 05, 2023 at 09:29:15AM +0800, Changhuang Liang wrote:
>>
>>> But if keep this "starfive,jh7110-aon-syscon" compatible. Which .yaml match to
>>> it? Use this series dt-bindings or syscon series dt-bindings.
>>
>> There is no syscon series anymore, it's part of the PLL series now:
>> https://lore.kernel.org/linux-clk/20230414024157.53203-1-xingyu.wu@starfivetech.com/
>>
>> I don't really care what you, Walker & Xingyu decide to do, but add the
>> binding in one series in a complete form. It's far less confusing to
>> have only have one version of the binding on the go at once.
>>
> 
> Hi, Krzysztof and Conor
> 
> Due to the current aon pmu needs to be adjusted, it affects the syscon in PLL series.
> So It's inevitable to change syscon in PLL series.
> 
> My current idea is PLL series don't add the aon_syscon node. I will add it in my
> aon pmu series in next version like this:
> 
> aon_syscon: syscon@17010000 {
> 	compatible = "starfive,jh7110-aon-pmu", "syscon";
> 	reg = <0x0 0x17010000 0x0 0x1000>;
> 	#power-domain-cells = <1>;
> };
> 
> In my opinion, the first we add "starfive,jh7110-aon-syscon" because "syscon" can 
> not appear alone in the compatible. If we have "starfive,jh7110-aon-pmu", this
> "starfive,jh7110-aon-syscon" is not a must-be need.
> 
> Do you agree with doing so.

Sorry guys, I don't know what you talk about. I have no clue what are
PLL and aon series. More over I don't understand what is complicated
here... all SoCs follow the same rules and similar way of development.

Best regards,
Krzysztof

