Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2AC6A7FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCBKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCBKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:11:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB2252A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:11:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so15976220wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677751888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94soxuvv9weTj14EUenx4LGqDvReRutwCU3Hh0oH1RU=;
        b=wTSzRGaMzs2MJ8NdB54pig9Z7LYrG7AED2xx7sCab+Ktsh3ppzWX1E1QhLE2MmEHtw
         FqSP04+i3a0DBkwO6D7fd6xh8+NODsZwV6E3QmH9Vj1oKhpoxIplP0um9y3WXQpoaqYa
         Ler2y114ZBIYaAkj3du4Bxmr1/pza/1J5+QHCz8BCqgsfFMrphPYAa5bo/sfDvdQY5Dz
         C69F/vCEdISUO0Csr2dh2/I0H+VqXMmB0Rp+VeE2/z8UgLWnUh3PsAhymuSfFjkjpMsw
         DK9vYuljCM18N2jGnI+tYsloor+92Vn6A19+C9lmlnwRppkYpS/oZD7/8IUQlabg35jb
         JcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677751888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94soxuvv9weTj14EUenx4LGqDvReRutwCU3Hh0oH1RU=;
        b=ng9VnUd7dtdcm94EVtgpRzavnjv9eGUw8BcJl/+Fpg9FHmDM26hZiFjJ1ihV59qqSv
         1HXRDQWD0nT3gMAYNBa2cejxlV+ZnwfTV7EV5B0oFRIiug7DYkjASIyLVsIaW5oYhSy9
         GHMCPTPmFx6II9w19RCJMxaLJzHNSMDrYfgg+vHgRy7LzVX71nXt9E1OAja/53RQ1FMN
         CJxiaEDFL4/tWKSx/a7dCGzCGPZ0QyN8L/XwgeahLHMcCSlGfk1Ktukkv5iwPD7n1i+W
         I2SwkvCzXqk1KEEO7TClBuWVeopHHuMiPQTtk+7/z61yY94l1mnlfj2U8Ds+gA/9wXFl
         XQYA==
X-Gm-Message-State: AO0yUKUMeC/KipOfBlSDAKhDG9b+dcWVehymsu404y8/IUTs9fqeDnaF
        kb+6OaE6eY++Hp24zC0rUhDJQw==
X-Google-Smtp-Source: AK7set/f6DaunEW+qsu0USPsRajcEqVogfO5w8Xw2rlafpKuhapTBM1EKBnJBGGQGK1pzbCzwxUE+A==
X-Received: by 2002:a5d:4292:0:b0:2cd:f2c6:5d31 with SMTP id k18-20020a5d4292000000b002cdf2c65d31mr823851wrq.11.1677751888033;
        Thu, 02 Mar 2023 02:11:28 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:9a21:3c01:c6c8:757f? ([2a05:6e02:1041:c10:9a21:3c01:c6c8:757f])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056000018100b002c54fb024b2sm15073479wrx.61.2023.03.02.02.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:11:27 -0800 (PST)
Message-ID: <9c4d092c-6291-e9fc-6288-c9e365f30f29@linaro.org>
Date:   Thu, 2 Mar 2023 11:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 16/19] thermal/drivers/tegra: Remove unneeded lock when
 setting a trip point
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-17-daniel.lezcano@linaro.org>
 <Y/9eohV9h26hPuFn@orome> <e5a4aaf1-af0a-aac4-6f77-94c3c9bfcc67@linaro.org>
 <ZABwJdBk/Z1NHc12@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZABwJdBk/Z1NHc12@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:45, Thierry Reding wrote:

[ ... ]

>>>> +	/*
>>>> +	 * Disable the interrupt so set_trips() can not be called
>>>> +	 * while we are setting up the register
>>>> +	 * TSENSOR_SENSOR0_CONFIG1. With this we close a potential
>>>> +	 * race window where we are setting up the TH2 and the
>>>> +	 * temperature hits TH1 resulting to an update of the
>>>> +	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
>>>> +	 */
>>>> +	disable_irq(irq);
>>>> +
>>>>    	for (i = 0; i < ARRAY_SIZE(ts->ch); i++) {
>>>>    		err = tegra_tsensor_enable_hw_channel(ts, i);
>>>>    		if (err)
>>>>    			return err;
>>>>    	}
>>>> +	enable_irq(irq);
>>>
>>> Instead of disabling and reenabling the interrupt, could we simply move
>>> the channel enabling code a couple of lines above, before the IRQ
>>> request call? If enabling the channels were to trigger an interrupt, it
>>> should get triggered right after requesting the IRQ.
>>
>> Won't we have a spurious interrupt if that situation happen ?
> 
> It wouldn't be a spurious interrupt, but rather something that we want
> to react to. It's ultimately the same result as your patch. In your
> variant we basically request the IRQ (which automatically enables it),
> then immediately disable it, enable the HW channels and then reenable
> the interrupt. If enabling the HW channels were to trigger an interrupt,
> that interrupt would be raised immediately after enable_irq() as well,
> as far as I can tell.

I see, thanks for the clarification

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

