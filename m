Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BF65632C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiLZOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiLZOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04049262A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:22:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i15so15675410edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+7qtVYjcqPvE/k1QEDEyz+eQy6Hwuj22SxfubsIkZo=;
        b=QNaZe3TYok5E4UMDykUVs1doSqbl+yF9VyivY/zRr6IQnDZc5rsv03mxU+CHu4WafX
         cBoh45oOUzxF22snszZEwDCw9m2HV8LR0u9J1PyQ08WL5WhnYejulbrjUkzKOlb8gc7a
         GzVE4b5amh8Bm/nSDFtX82NJsQ9jxwO5FjhEYKpxNJiZ6RwRmlCMtXiEo1YpVP2dQQfb
         dOt8FnYp9LAW7x2UHL2X1koeF4tUsQjpGMOhPolMaKepoV7h2TB1jUlvM/l58cLzskOB
         MixrBiyNSF8+BR8udIRXu4H+kQKlcszmobTbThAuYAfHMBNp03yopvtlwKvf+E15NFkm
         AAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+7qtVYjcqPvE/k1QEDEyz+eQy6Hwuj22SxfubsIkZo=;
        b=mVV3P5f7i9KUWTOTLcO2WvoaLcrR0Up5vzkPfdVuUae9WtEMIGprK1sfdYqZFjR0fb
         8D+boJvxfpFomPkCEGjcsYC7y5iNqfg5v6FJrwvYI3boAfJV9LYgWhggtyhWMxk7kvAG
         eEMEE2K6UvKLPJu8N0RenngLZmKuXThVdHO1mrxwptuVfeCjrYI/qptmEq3ZOg3nZlnl
         IA0AjpxMfUYb8rBHZi7RVr3EVbFvZNTW+YsbYV29RigzLjg1m87v1ObJOkRFHdeiwwkL
         WLfL5sO8d0WqRqXypPy/ucXJ/2svX/WscUaGooqZMogcJUjdB3toZomoWIkQmO9YlTKb
         HMhw==
X-Gm-Message-State: AFqh2kreUoF2vHgu5vVBg0AgpRdc/IJ63Wdi1cwhsCtP+gqQ1qtXBEOa
        wyLqCQl0d8PuFZwGgcsaq5PxZw==
X-Google-Smtp-Source: AMrXdXtsIOWE06vpaTx7Hf5jTPvQqXas9JhYDADYc43XOYx0B8ZZsf6FzMSbIBcmmS5uIo/d3P8wSg==
X-Received: by 2002:a05:6402:390b:b0:465:f6a9:cb7b with SMTP id fe11-20020a056402390b00b00465f6a9cb7bmr15926698edb.12.1672064525630;
        Mon, 26 Dec 2022 06:22:05 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id s14-20020a056402014e00b0048263de5aa6sm3622014edu.75.2022.12.26.06.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 06:22:04 -0800 (PST)
Message-ID: <32ddf1f8-eda1-da00-a3dc-901c4ee61217@linaro.org>
Date:   Mon, 26 Dec 2022 16:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221220141352.1486360-1-arnd@kernel.org>
 <cae6328b-5204-a1ab-810d-8fb64e466453@linaro.org>
 <20221220165701.5696df1a@xps-13>
 <026225c6-f17f-e9da-b7c0-5d3473a97e89@linaro.org>
In-Reply-To: <026225c6-f17f-e9da-b7c0-5d3473a97e89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.12.2022 08:49, Tudor Ambarus wrote:
> 
> 
> On 20.12.2022 17:57, Miquel Raynal wrote:
>> Hi Tudor,
>>
> 
> Hi,
> 
>> tudor.ambarus@linaro.org wrote on Tue, 20 Dec 2022 17:44:49 +0200:
>>
>>> Hi, Arnd,
>>>
>>> On 20.12.2022 16:13, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
>>>> fails to build, as it includes the shared CFI header:
>>>>
>>>> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix 
>>>> selected. No NOR chip support can work. [-Werror=cpp]
>>>>      62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip 
>>>> support can work.
>>>>
>>>> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
>>>> remove the inclusion here to fix the warning. This uncovers a
>>>> missing #include in spi-nor/core.c so add that there to
>>>> prevent a different build issue.
>>>>
>>>> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Looks good to me. I'll let the linux-0day bot run over it and apply it
>>> once -rc1 is out.
>>
>> The issue sometimes produces build errors, shall I send it through a
>> fixes PR instead?
>>
> 
> Yes, that I was thinking about.
> 

Seems that I shouldn't push to mtd/fixes, so:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


