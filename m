Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFC729E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFIPcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFIPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:32:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E12D74
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:32:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7f6341b99so14773345e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686324726; x=1688916726;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1mhn381wGPq9VsfFUBH75JUbhAKYMmZAsIxZ0NhEH8=;
        b=fPfahtDhAJMzJoNJVTccQv7orfyS/dgzun65AdxRuRSsxcpbEkPL/IjmLNcrvhlODs
         KV9h/VpBXaPTKq5BYEWG30cPWUto9/0w2ujcb0PPSP5LpHwAhb8WU7RTXiOnZKVKkYAF
         JTUd/K+GHh+yOrbcEuJDZmgmK7qpYlbjIUSnoNFiGVgsU5UlL4D9zYTsUkKdHY9uyyZm
         EIG23rSUT2IH1dLUIFQyiwc/zkjbMJyIzLK+T73PUY7rb3ItLp8XWvqa69a50zk4/tXy
         RBWiSjsbRfLNUCsXXKlXj3f8Dc9FTTkUciCsfwtIOwT8UkSfhWTjz8mZ79XUfFsy6RoZ
         nkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324726; x=1688916726;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1mhn381wGPq9VsfFUBH75JUbhAKYMmZAsIxZ0NhEH8=;
        b=fk325DSNbxGvsM5QpXSyhYapiGo7BefOkGQjpewfTBCCOqIvMzvD6JteGjya2Hyckt
         xhKPR0+kmuTLmzbfLCxCsm6l+EnuL5b3bPb8Bm4hr0nTP+UiipZgth0TBliWk7LSHLqY
         rJXlJEEpsXNBXswW2rDHCXgaXMXBKK7dn77rJmaUjha0FWW65OXfHRbJyCzAGVw7AQSk
         LELT1aE8ZAeAgQDhtyHXBaVVebypeUo9A6it9wwTuHK4Ij4/pVCDsBFXoJU2xLldtAUZ
         I03S8zcQr3gHj5A1gOW6Dgr34pV/vf9whBC3wF+OPpj7Ld0ByQ64+TztoVLtIGT0LdDf
         CyNA==
X-Gm-Message-State: AC+VfDz4qQQmSa6aiP9N2PvlMfZ7oiB+1iMkd3s88c4Am0v/u/Wf+fRY
        dJKy3PKRSDMfkAsVjhrddBAkvQ==
X-Google-Smtp-Source: ACHHUZ7Po/UKSSzifvbKjlrEYfqLwnw9C7rwIkJpErr95fAz+R4+DXk8WHplcmI40TSbk3pmILRgow==
X-Received: by 2002:a1c:790f:0:b0:3f7:e629:9f3 with SMTP id l15-20020a1c790f000000b003f7e62909f3mr1145744wme.16.1686324725726;
        Fri, 09 Jun 2023 08:32:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c40:3a0f:b23:350f? ([2a01:e0a:982:cbb0:5c40:3a0f:b23:350f])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b003f42328b5d9sm2960711wmi.39.2023.06.09.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:32:05 -0700 (PDT)
Message-ID: <c76c6611-9c8c-27e1-3b60-1ec677bd6ad3@linaro.org>
Date:   Fri, 9 Jun 2023 17:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/18] clk: meson: migrate a1 clock drivers out of
 hw_onecell_data to drop NR_CLKS
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-3-9676afa6b22c@linaro.org>
 <1jlegu9l5d.fsf@starbuckisacylon.baylibre.com>
 <638206ba-e2da-bb8e-a2e4-138af84648b4@linaro.org>
 <1jwn0c672d.fsf@starbuckisacylon.baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <1jwn0c672d.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 16:30, Jerome Brunet wrote:
> 
> On Thu 08 Jun 2023 at 14:53, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 08/06/2023 14:45, Jerome Brunet wrote:
>>>>    +struct meson_a1_pll_clks {
>>>> +	struct clk_hw **hw_clks;
>>>> +	unsigned int hw_clk_num;
>>>> +};
>>>> +
>>>> +static struct meson_a1_pll_clks a1_pll_clks = {
>>>> +	.hw_clks = a1_pll_hw_clks,
>>>> +	.hw_clk_num = ARRAY_SIZE(a1_pll_hw_clks),
>>>> +};
>>>> +
>>>> +static struct clk_hw *meson_a1_pll_hw_get(struct of_phandle_args *clkspec, void *clk_data)
>>>> +{
>>>> +	const struct meson_a1_pll_clks *data = clk_data;
>>>> +	unsigned int idx = clkspec->args[0];
>>>> +
>>>> +	if (idx >= data->hw_clk_num) {
>>>> +		pr_err("%s: invalid index %u\n", __func__, idx);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	return data->hw_clks[idx];
>>>> +}
>>> I'd prefer to have a single struct type and and single custom
>>> callback for the different SoC please.
>>
>> Sure, I've written a common code for that, but I have a hard time finding
>> a proper naming for it... so I choosed meson-clkc since it could have
>> more common helper code for duplicated code over the clk driver:
> 
> Agreed. meson-clkc-utils maybe ?

Ack seems better

Thanks
Neil

> 
>>
>> ===================================><============================================================================
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 8ce846fdbe43..9070dcfd9e71 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -30,6 +30,9 @@ config COMMON_CLK_MESON_VID_PLL_DIV
>>   	tristate
>>   	select COMMON_CLK_MESON_REGMAP
>>
>> +config COMMON_CLK_MESON_CLKC
>> +	tristate
>> +
>>   config COMMON_CLK_MESON_AO_CLKC
>>   	tristate
>>   	select COMMON_CLK_MESON_REGMAP
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index d5288662881d..13c6db466986 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   # Amlogic clock drivers
>>
>> +obj-$(CONFIG_COMMON_CLK_MESON_CLKC) += meson-clkc.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
>> diff --git a/drivers/clk/meson/meson-clkc.c b/drivers/clk/meson/meson-clkc.c
>> new file mode 100644
>> index 000000000000..fa98b9d09011
>> --- /dev/null
>> +++ b/drivers/clk/meson/meson-clkc.c
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +
>> +#include <linux/of_device.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include "meson-clkc.h"
>> +
>> +struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
>> +{
>> +	const struct meson_clk_hw_data *data = clk_hw_data;
>> +	unsigned int idx = clkspec->args[0];
>> +
>> +	if (idx >= data->num) {
>> +		pr_err("%s: invalid index %u\n", __func__, idx);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return data->hws[idx];
>> +}
>> +EXPORT_SYMBOL_GPL(meson_clk_hw_get);
>> +
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/clk/meson/meson-clkc.h b/drivers/clk/meson/meson-clkc.h
>> new file mode 100644
>> index 000000000000..e3bad2aa17eb
>> --- /dev/null
>> +++ b/drivers/clk/meson/meson-clkc.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +
>> +#ifndef __MESON_HW_CLKC_H__
>> +#define __MESON_HW_CLKC_H__
>> +
>> +#include <linux/of_device.h>
>> +#include <linux/clk-provider.h>
>> +
>> +struct meson_clk_hw_data {
>> +	struct clk_hw	**hws;
>> +	unsigned int	num;
>> +};
>> +
>> +struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
>> +
>> +#endif
>> ===================================><============================================================================
>>
>> If it's ok I'll send a v2 using this.
>>
>> Thanks,
>> Neil
> 

