Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D86C7948
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjCXIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:00:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6241E1E8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:00:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso405194wmo.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679644805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Et+I6m2/3M3ihrXodAsozWva/ZYQ4ukUjISIAm7jl7w=;
        b=7uTrwDQ1t1lwRIveny17vL0ua24bvr+rukAwV8ZAU/Bh/9eHLfPnqzJcagHhJ77xc1
         R12KpmviwRpqJ4y6Y7xZIAjO5cSmC7a20FEkkQ031zyw3mgdRfGkV9F4b0WXVo//BDWb
         pv33ubHZsRu1o5S6esuayqgduq2qg1o1BR+zc4rnXRk4R7JxDuvuyoUZvrWGQggjnFpg
         HFKdo01a2yCcEWZbpylOeM49mBx2kRTMZIlUJ8Acg29QyPuKSkobnONi1GVPP8xdXPtk
         SS+d9gHTVyKvmxTlJaUNIYst+zO15RsLKQpmIe06ziCZcvuCWRJgRKMT0WC97EwRPFTv
         UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679644805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Et+I6m2/3M3ihrXodAsozWva/ZYQ4ukUjISIAm7jl7w=;
        b=CKzipGYsLWNYj+xU4PcUKNtOSkgKZmVTo8darP1J7wb2Bizxc66H6foyH5V2YAPxuF
         qXsM9Vh8T6Z9o1xi+/VQ4Om1w3gFt8dGHyvG2t7dbrABWnxtvAPGNTz8s0bzG47GNM5O
         H2RcbnIXyAL1oXD/k9RIhDjU4VvOhzoJak2y9E5/N7t/OS5jt6qQfDFR9X/YD/ZHc0vH
         eENWIBlb/1oBFL2z+YUcuwKd1xp8zrb4K5DWVzqdPYVBWm72x6NNEMANzLHp+ktOpPSV
         pTEywsUvqBiaXu6ol47iVjqV4/g8LMvLliuYtRdUxa5xJ6UNt80QQZoMIzv+kC3j/Zmr
         BgDA==
X-Gm-Message-State: AO0yUKWbZHG/CHJt/+OQ1c3NwOIeekMFSqqxp3efzkCBzrHXOzdITxP9
        oV7fqfWgQ1WYvsVuLw3pO7+O/g==
X-Google-Smtp-Source: AK7set+7GtYYYBL2VrSmA9bJmuExAPTlzEC0BfGfpIDI3vPJ/0MYCH4+pz2gUQPasqmxOJoLCzyLKw==
X-Received: by 2002:a7b:c409:0:b0:3ea:f6c4:305e with SMTP id k9-20020a7bc409000000b003eaf6c4305emr1653541wmi.38.1679644804698;
        Fri, 24 Mar 2023 01:00:04 -0700 (PDT)
Received: from [192.168.1.91] ([85.68.201.192])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc852000000b003ed2c0a0f37sm4082775wml.35.2023.03.24.01.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 01:00:04 -0700 (PDT)
Message-ID: <3d684dec-338a-085f-3ef1-1642e5067fb2@baylibre.com>
Date:   Fri, 24 Mar 2023 09:00:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
 <Y/i+wVSy+eQxDFJ3@sirena.org.uk>
 <bd4aa2ad-4535-94ca-7630-846546ae3d82@baylibre.com>
 <e08686be-0b46-403b-b3cd-3462db92dd60@sirena.org.uk>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <e08686be-0b46-403b-b3cd-3462db92dd60@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2023 12:38, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 10:12:21AM +0100, jerome Neanne wrote:
> 
>>> This would be simpler and you wouldn't need this lookup function if the
>>> regulator descriptions included their IRQ names, then you could just
>>> request the interrupts while registering the regulators.
> 
>> I changed the code to follow your recommendations then now in case of a
>> multiphase buck, only one set of interrupt is requested.
> 
>> buck2, buck3, buck4 are not associated to a regulator device because buck1
>> registers control all the multiphase bucks (only one logic regulator).
>> Consequently the mapping for the associated interrupts does not occur.
>> I'm not sure it's the right option.
>> Do you suggest to keep it like that for multiphase?
>> Is it better to request all the interrupts anyway and map it to the same
>> rdev?
> 
> Do the other interrupts do anything useful for this configuration?  With
> a lot of hardware the whole control interface gets merged into one which
> includes the interrupts.
> 
Discussed the point with TI in //. In case of multiphase buck ex: buck12
All the control is delegated to buck1 registers but there is still a 
possibility that an interrupt triggers on buck2 (overcurrent typically).
I slightly changed the logic so that all the interrupts are registered 
even in multiphase mode. In that case interrupts for buck2 are attached 
to rdev buck12.
>>>> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
>>>> +						  tps6594_regulator_irq_handler,
>>>> +						  IRQF_ONESHOT,
>>>> +						  irq_type->irq_name,
>>>> +						  &irq_data[i]);
>>>> +		if (error) {
>>>> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
>>>> +				irq_type->irq_name, irq, error);
>>>> +			return error;
>>>> +		}
> 
>>> This leaks all previously requested interrupts.
> 
>> I'm not sure to understand this sentence correctly. You mean all the
>> interrupts already requested are still allocated after the error occurs?
> 
> Yes, I'd either not registered the devm or thought there was some other
> interrupt wasn't devm.
All the interrupts are requested with devm, then should be fine.
