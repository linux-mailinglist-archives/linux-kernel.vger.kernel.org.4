Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F368C739983
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjFVI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFVI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:27:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16791BE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:26:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so9214253e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687422417; x=1690014417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6VjWt+6pr3rMzoGINogfGHu4avJHisgEYBXXjQzvm4=;
        b=sJP11aREhkvOtW+E/okkCh1Vaz7KT352DBLFlOhT58DhvAeJcWYQZcZCH++xpGogcA
         2SQNgG56+g9ORDK2jpIwazDZF6uTSnnfyDZrOQCueZ5yWNk5K/njoz7izWdHs3JSqidz
         l/9oq3zdcG1WHlcFnxBVoeYdNfgv0DvFCM1bW6cI/iv01KnDRANY8YBJVoheL6RFvy0M
         2nN2Nv+rKGUdNzeGH/qTSU5sjQytpD333hQvnuY8I4TC6R138R05ArKEJH3XuH0+vCgb
         Jh3FhKjA1WZJhYYzREJ3WVQLiMzLKjafEruCGMwtucbJW0PINqXzF10pQ5DppzpGjcNq
         HVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422417; x=1690014417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6VjWt+6pr3rMzoGINogfGHu4avJHisgEYBXXjQzvm4=;
        b=dgkCQA2dfsg2MVik2Y+gTZQgFWUjX71dbuV8VBAybEahE/DRDKaT/ivQfcmd0XWXSL
         uyxQFaCuMaSBeCxdtrhNMNXEeQPWMSwzWL39aoAcXh+UaGG5TfybXDGLSGT4K6DghNI0
         lXoqQvVOkcEpOQ7kuiYgkfM1KZE+l7cgCOEbuu5Y0qcprjApg+MQUJdTZRcBuXlnBtxV
         kyUQixnMLLHcw1zSprX506TuHYm6secKyxKsj9OhWdfka2lvuIIj1vZsNySQZ2Fa6zQg
         LXyrIfciUit4EKnEPHnnq2YGtewkgYdCjjoviM+18s0UIXXqLSwprUN648gNE7coUmc+
         b9rw==
X-Gm-Message-State: AC+VfDyxV7MyEicAHK5wmsGvMoAKTri6EN5BzwJ3mGY/VBzu5spR9/VF
        wk/g5zWhO3U2dIrIWp0Bxgnysg==
X-Google-Smtp-Source: ACHHUZ6b4oFoOQN6J6JmbZSNyIU0e6BraZ1C02UbgQCLjZCYi4qFCfrdDZauI6HAeYyiOtqPuTzqEA==
X-Received: by 2002:a05:6512:23a9:b0:4f9:6221:8faf with SMTP id c41-20020a05651223a900b004f962218fafmr1182949lfv.53.1687422417087;
        Thu, 22 Jun 2023 01:26:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm7083436wmi.15.2023.06.22.01.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:26:56 -0700 (PDT)
Message-ID: <e9f0518d-e0ba-5fc1-1984-0fcfb9fe9102@linaro.org>
Date:   Thu, 22 Jun 2023 10:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
References: <20230622104810.30055fb1@canb.auug.org.au>
 <afeb9fad-0d3b-48ac-82da-218dcd8010e7@app.fastmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <afeb9fad-0d3b-48ac-82da-218dcd8010e7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 10:19, Arnd Bergmann wrote:
> On Thu, Jun 22, 2023, at 02:48, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the arm-soc tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning 
>> (spi_bus_reg): /soc/spi@10680/flash@1: SPI bus unit address format 
>> error, expected "0"
>>
>> I am not sure why this has only shown up now.
> 
> Thanks for the report, I also just ran into the same thing.
> It's probably instroduced by 89e73afc3f540 ("ARM: dts: marvell:
> align SPI NOR node name with dtschema"), but I don't know why
> there was no warning before.
> 
> Added the fixup patch now.

The unit/reg mismatch was there before my commit. Maybe something
changed in default flags for dtc compiler, thus the warning appeared?

> 
>     Arnd
> 
> ---
> commit 7dc3be1745d05c1ed7d385487238ec06a07f4f29
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Jun 22 10:14:02 2023 +0200
> 
>     ARM: mvebu: fix unit address on armada-390-db flash
>     
>     The unit address needs to be changed to match the reg property:
>     
>     arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning (spi_bus_reg): /soc/spi@10680/flash@1: SPI bus unit address format error, expected "0"
>     
>     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

