Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C63689802
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBCLrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:47:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60EC9D5B7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:46:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o18so4415689wrj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkvhY/M3i27TJzBu2FTalX8Fzoqjo+dapPkiWdkYWek=;
        b=sBhSAeU7M0zdDwTNlp0NGqbmaQpKri/AusnIu0sKKU3WLJWarlOAnvh9a+A7VIehjj
         koRMvuJagUwK5m9Aus2sD6vVojFnEOuuS94xZDGycNKIRwOBTvIbBT/qDYp7+LfyBjEZ
         PD00xQIMXCSMJWgzGl5uD0mcSL3z9i0KqIS/ryjAjVTZW6yNd5x5AEHjaVisFhBPXwUp
         HL/XD/M8i/2hNXPoh7lrMa9qje3W/iDvyRm1LpWc4cAYxlJvHHxG0eCWquhAVqPm/E4x
         VweMIaxiZcKvvXxBb4y4vfXJ52/HoHqJbP9rtT1jeKGwoklB+s4mSmcPmuZ2LofLxYnM
         tkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkvhY/M3i27TJzBu2FTalX8Fzoqjo+dapPkiWdkYWek=;
        b=RJzcxHTH4aZKyKzj29XGrj7SsaSK1Zr0Wf8xGEf7jgbW8kKLpVeQxWEQkZMScJmtqE
         lDFRPeGN5O15nCHHNGZP4rPmUmwbzB5iduh7shuscor72p8IpY3XF4EqBzRE1Hmx6xmd
         9WjXmFa0hQhKaZGB+3pIURzJkJGLFVMg6bPObYtYkbStrf67KlqIVqgPenNkJUDFtemI
         Q04UzEmpfQhBeorX2zjnLJJXF3dfEHrvrfjGJ3nueJb0MQXVfSWGhCQstJ1RP+1tzy2b
         YfVJKAkzPVHdmrOCcUBasIAIyns5xEAvI+8UbMT1wM0YTeCDJzRkTCgEnE84j1gtXnRj
         oFgQ==
X-Gm-Message-State: AO0yUKWFaxYGGA5juLVKtXRVzGEwQkY6DQwSwoV6RakR1omqXsyx8M5+
        DHwemb6W5m2i3rjj8g3dofTOiw==
X-Google-Smtp-Source: AK7set8EuBqx6nx/b+JVSCjTMNawsTIeFwRZ640GCpeQoIsVKGyp/echWUve0rfjlnRTAiUxanBouw==
X-Received: by 2002:a5d:5949:0:b0:2bf:9582:1378 with SMTP id e9-20020a5d5949000000b002bf95821378mr8632813wri.37.1675424815477;
        Fri, 03 Feb 2023 03:46:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm1844222wrt.5.2023.02.03.03.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 03:46:55 -0800 (PST)
Message-ID: <d54792c5-2842-e5b9-26b8-1f52471211a9@linaro.org>
Date:   Fri, 3 Feb 2023 12:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos4412
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <20230125094513.155063-5-krzysztof.kozlowski@linaro.org>
 <CGME20230129104220eucas1p15b70f73be86fa5600cfe170d22869836@eucas1p1.samsung.com>
 <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
 <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 12:45, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>> as reported by dtc W=1:
>>>
>>>    exynos4412.dtsi:407.20-413.5:
>>>      Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>
>>> and dtbs_check:
>>>
>>>    exynos4412-i9300.dtb: soc: bus-acp:
>>>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>
>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>> Re-order them alphabetically while moving and put some of the OPP tables
>>> in device nodes (if they are not shared).
>>>
>> Applied.
> 
> I don't have a good news. It looks that this change is responsible for 
> breaking boards that were rock-stable so far, like Odroid U3. I didn't 
> manage to analyze what exactly causes the issue, but it looks that the 
> exynos-bus devfreq driver somehow depends on the order of the nodes:
> 
> (before)
> 
> # dmesg | grep exynos-bus
> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc 
> (100000 KHz ~ 400000 KHz)
> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp 
> (100000 KHz ~ 267000 KHz)
> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c 
> (100000 KHz ~ 400000 KHz)
> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus 
> (100000 KHz ~ 200000 KHz)
> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus 
> (100000 KHz ~ 200000 KHz)
> [    6.494612] exynos-bus: new bus device registered: soc:bus-display 
> (160000 KHz ~ 200000 KHz)
> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys 
> (100000 KHz ~ 134000 KHz)
> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri ( 
> 50000 KHz ~ 100000 KHz)
> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc 
> (100000 KHz ~ 200000 KHz)
> 
> (after)
> 
> # dmesg | grep exynos-bus
> 
> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000 
> KHz ~ 400000 KHz)
> [    6.122726] exynos-bus: new bus device registered: bus-leftbus 
> (100000 KHz ~ 200000 KHz)
> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000 
> KHz ~ 200000 KHz)
> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000 
> KHz ~ 100000 KHz)
> [    6.204770] exynos-bus: new bus device registered: bus-rightbus 
> (100000 KHz ~ 200000 KHz)
> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000 
> KHz ~ 267000 KHz)
> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000 
> KHz ~ 400000 KHz)
> [    6.225748] exynos-bus: new bus device registered: bus-display 
> (160000 KHz ~ 200000 KHz)
> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000 
> KHz ~ 134000 KHz)
> 
> This is definitely a driver bug, but so far it worked fine, so this is a 
> regression that need to be addressed somehow...


Thanks for checking, but what is exactly the bug? The devices registered
- just with different name.

Best regards,
Krzysztof

