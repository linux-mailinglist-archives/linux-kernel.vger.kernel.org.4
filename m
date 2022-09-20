Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAACB5BE9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiITPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiITPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:17:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82B65257
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:16:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n12so4797621wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sTa1pbTVMPJ1tf0fbIJm6r4QEWbV/1sWEH4W85gfxdA=;
        b=Y0I8B2b3LP+wzBoIwffHFhR8WfPrSkke8bPxBfdpa1N8AqQnjtUb7c4CmtN24qDDhp
         qdL9Uud2I30izEuKxHpDkDIvQsHjjHSigXA8ob2zyPlsjdSDJEqyqPpzLn28QvWSy7KL
         qQeFNIl2oWaknO+UzEWzpGs+d8ZNb2Cx/uKizP1/tOe+EHQFl93J0S8U18g/IvP7Y7F4
         d6f4YSPMFnQYjUgtnRkeGD7bo7q0GU0CxKxamfwit1fq15nkLEYURNwTzCI/sJHwioVE
         98Z217tzwyEGW4GGj3HG0mcmrgh37N5Ne8Nwz9cTvOGRaCoWzT7R1EwI6zs2gdSg2djQ
         KQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sTa1pbTVMPJ1tf0fbIJm6r4QEWbV/1sWEH4W85gfxdA=;
        b=ylcRlGtMXV+0O5K0K4Nfjf2pMn7LDMFdJ8QDuq3+5M0G1uElFAw3c1pBQUr+Y9UF2f
         GXsYj9PhS3Q2N3swral3a3CveryLzgYVJzARmm6PXY9gZSngCsl2ziY49MQdoPwpcIgD
         EK7PgCBK+Ruhu7floJ27wViNgO9MXHrEMUix8ybdCNOOChRcIFLYnNYgRf4TYdAljYn1
         podQxP1eaK4RgY57p/uSgiLVxzgS/w/iegKX0CAfa79eWCeXRkP7pFe9E0orJvBnHCDv
         w3h4ag7okPP3uB2oDQsATyc8nnGupDi8OszmzHYx6GaK2ETAGk5PRICkemyg91B98eYS
         PKjA==
X-Gm-Message-State: ACrzQf3eLgh0tdekjljCiiO0Insd1F6zZBJXk5kxnawpd+1n5MhIYGiS
        UGaBWHYflmFt6u8Wxk1/MV+IbA==
X-Google-Smtp-Source: AMsMyM4CnxN9VS5xftyuGqfVz/42sP79DDIp25KA4140PE5NmZBRvjW0ASBqI2gKS8NFBNgL+mI2tQ==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr14533501wri.455.1663687016603;
        Tue, 20 Sep 2022 08:16:56 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id cc16-20020a5d5c10000000b0021e4829d359sm40298wrb.39.2022.09.20.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:16:56 -0700 (PDT)
Message-ID: <bf4d4cdf-27a1-7e09-59dc-25a8646fad1f@baylibre.com>
Date:   Tue, 20 Sep 2022 17:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: remove thermal zones
 without trips.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914131339.18348-1-aouledameur@baylibre.com>
 <a8af4c54-12a2-a314-f190-f12859ef4ddd@gmail.com>
 <ca326ce8-3eee-8a7a-a522-9ffbdf7d8a82@linaro.org>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <ca326ce8-3eee-8a7a-a522-9ffbdf7d8a82@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/22 17:50, Daniel Lezcano wrote:
> On 14/09/2022 16:15, Matthias Brugger wrote:
>>
>>
>> On 14/09/2022 15:13, Amjad Ouled-Ameur wrote:
>>> Thermal zones without trip point are not registered by thermal core.
>>>
>>> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
>>> only but are not supposed to remain on DT.
>>>
>>> Remove the zones above and keep only cpu_thermal.
>>>
>>
>> My understanding is that this thermal zones exist but are not used. 
>> DTS should describe the HW as it is, so I propose to add
>> status = "disabled";
>> to the zones.
>>
>
> At least the trip points must be declared as stated in the bindings
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n213 
>
>
In the base case we should but there are no trip points for these 
sensors according to MediaTek.


Regards,

Amjad

