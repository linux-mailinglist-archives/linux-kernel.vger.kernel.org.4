Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687A61EDD5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiKGIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiKGIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:55:08 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165841582F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:55:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a15so15127800ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCr2ISKh+YafpbCB0kPf8RGIXBfoaFAOt+wxNjTYToY=;
        b=npBaWexOm/XE00LZTEl5xH2F9rnHMAlNZtaOpHjLTsOkRcStkVvKmpEcpmh05M7XGE
         hF7PvmxSuQGDXUlgikWuU/na2WwFCRc8IMm49a/kHA/sF801fWkqT8HqabPi+2Yh92f+
         77ZY8w/0Ffl8VAhsSoHvnRiMHEkpjbbyV4ehYuiYTBeEG9HPPm3KWpKc//Sy65AsGjuZ
         22NO7ipNEe8vuIEPO6qy7eep/god0yI/ViBnNdkvwVQ9kBDHMAHM+cK8PjnmghRK5Mrg
         5xc/ccwE9tICBKzEvpd8tFkkURtGW+E7CvVKM8ZcUvfrZsgwvwU3MwhGWGssgHRnbupH
         y1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCr2ISKh+YafpbCB0kPf8RGIXBfoaFAOt+wxNjTYToY=;
        b=0DK9mw9+QOtVurlpLTrCVZBgIWiFgUP8LrXIH4pnd9N1oDWoY95gGNsGlA138By2u4
         WuRQ8R3sNjTm98I3tULv/qfAzOx0yY+32vie6utWynjgL+QBKjhxDi6bF2WKHOpQrkgA
         9vQ7b5jYg2SLBYBHcXxtK+atY5LrYOydRHW8DGeBYUIN/kvigEoGLwzXV0McjUOUwwjv
         DbAJ4p+ZY0u8HE6fp+Xod/G7586HvIF2jnsbW+ESo6X6Q0PfZPTsId3z9EhRaWaVWhnK
         HKqz4/yMjqVd6Qcw+8uctNDXKHKSNiku+wruY1HPTxq/vDwRqYBVwzqnjF7bZM1QmAbT
         E3og==
X-Gm-Message-State: ACrzQf3vSt9S8LxV1iqTzJp9pOGnAG2yYyh7LWqg4szLMM/Dx0Hn4bG5
        S0CcLNLwT0a0sdCTZ11brQixqg==
X-Google-Smtp-Source: AMsMyM7rGKhCM6C7y8e7TdmUwKATYNhTY8uScYBir79zy6ZIF0aFkh+NX5galtcq7569oldmM2926g==
X-Received: by 2002:a2e:8e8a:0:b0:277:77a:b53b with SMTP id z10-20020a2e8e8a000000b00277077ab53bmr5112278ljk.59.1667811304919;
        Mon, 07 Nov 2022 00:55:04 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b0048a8c907fe9sm1120832lfh.167.2022.11.07.00.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 00:55:04 -0800 (PST)
Message-ID: <742d9ff1-8af8-8fa1-4f37-4b50bd874e82@linaro.org>
Date:   Mon, 7 Nov 2022 09:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mtd: onenand: omap2: add dependency on GPMC
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20221104194934.384371-1-krzysztof.kozlowski@linaro.org>
 <eef60a26-ef23-1b79-22f7-adaee3be9360@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eef60a26-ef23-1b79-22f7-adaee3be9360@kernel.org>
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

On 07/11/2022 09:44, Roger Quadros wrote:
> Hello Krzysztof,
> 
> On 04/11/2022 21:49, Krzysztof Kozlowski wrote:
>> OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
>> OMAP GPMC driver, so the latter cannot be module if OneNAND driver is
>> built-in:
>>
>>   /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
>>   onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/mtd/nand/onenand/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
>> index 34d9a7a82ad4..fa94c514626d 100644
>> --- a/drivers/mtd/nand/onenand/Kconfig
>> +++ b/drivers/mtd/nand/onenand/Kconfig
>> @@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
>>  	tristate "OneNAND on OMAP2/OMAP3 support"
>>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
>>  	depends on OF || COMPILE_TEST
>> +	depends on OMAP_GPMC || !OMAP_GPMC
> 
> Why did you add !OMAP_GPMC?
> 
> If OMAP_GPMC is not set we don't want to be able to build this driver correct?

It will build fine because of stubs, so building is not a problem. We
just want to forbid having this built-in if OMAP_GPMC is a module. The
question is whether this is a runtime dependency as well?

Best regards,
Krzysztof

