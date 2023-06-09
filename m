Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5D729A49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbjFIMrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjFIMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:47:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BB1988
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:47:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso16804325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686314826; x=1688906826;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rOTekZ5T+8f+I9icACI6rQNlKGe8FwQ65t371dbDET4=;
        b=N/BLDSdzR3Mi95f15LLB94rPtv/IiwH3XNsvqylwQAXuFvQkrx7+ciBBZou9DMMzpf
         3mOXdEGQR/uth2xonAF4e548O70L4xp1xoyNhJllKYYWNpPGlXaM0fkWGJncEb7Gak2r
         m+V3asGqBTr8HdARTIFmulyE3JGHleu4Z6YvSMciWoafFfg9yfVr5nMjmKNxTox1guGS
         d0UaeJx/VpTONDm55AddEBBl+n2GNt47NtloB6xN6+Bir9MOYimtG3oBTNZr/oXgdgGp
         CIa6tahuviftxnJiaXRCoCF2zjSkoj8ApKqTWGS6Jrd3voiCtCbrcNjfTfTNcY21sgFZ
         1BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314826; x=1688906826;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOTekZ5T+8f+I9icACI6rQNlKGe8FwQ65t371dbDET4=;
        b=iiRGYWBsXHY+wasHS6dbdPNTCsKDj73SGD5VV67KPI59PCmK4D+SSFZOzgvaScYcuK
         A+AUPKPw8nVUdp2n4jXginTiH8i+FrtTAc/C5s1B9Zofs/iP5lqlaXY5Dj1p3EaYr0tZ
         XpyldVOQM1+1CfLrpnOBC8SJ0RcLO9w76tccyjxGXoXgnVV1Dr2fdT/kZRRgD8i2fNMn
         mo28r7qPPP6FmrnNDBu1PnSp3VVtiPFBUhnwe4mR4tXqoMWP00MFUphql0eKr/hQ9hBx
         RlmPxzsTv7HwtNNNrf80HLlxCfRGe3gZ/zgPwOzIltJrvdbUz5dpi8tC3d9osNLrJzSW
         QAGg==
X-Gm-Message-State: AC+VfDxAsD1tjIntRtHKZ3Myg/2sT938X8PyVwgYmbi8/U8rT1GS4PUR
        /UcsCimYKHJPIhBpkLTwtNSv+w==
X-Google-Smtp-Source: ACHHUZ598KxTRlV0xO/wTz4SLv55tV+LKVZzKPfvFsog7VJcxvw6JHHgXGzacLuwgbHHids/gLcMmg==
X-Received: by 2002:a05:600c:2116:b0:3f6:a44:73bb with SMTP id u22-20020a05600c211600b003f60a4473bbmr1196866wml.8.1686314825864;
        Fri, 09 Jun 2023 05:47:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c40:3a0f:b23:350f? ([2a01:e0a:982:cbb0:5c40:3a0f:b23:350f])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b003f8009be6c0sm2628646wmi.3.2023.06.09.05.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:47:05 -0700 (PDT)
Message-ID: <04791890-56f3-e620-1660-e8ed80eb5752@linaro.org>
Date:   Fri, 9 Jun 2023 14:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/18] clk: meson: migrate a1 clock drivers out of
 hw_onecell_data to drop NR_CLKS
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-3-9676afa6b22c@linaro.org>
 <1jlegu9l5d.fsf@starbuckisacylon.baylibre.com>
 <638206ba-e2da-bb8e-a2e4-138af84648b4@linaro.org>
 <20230609114847.x24by2foebojbchq@CAB-WSD-L081021>
Organization: Linaro Developer Services
In-Reply-To: <20230609114847.x24by2foebojbchq@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2023 13:48, Dmitry Rokosov wrote:
> Hello Neil,
> 
> On Thu, Jun 08, 2023 at 02:53:50PM +0200, Neil Armstrong wrote:
>> On 08/06/2023 14:45, Jerome Brunet wrote:
>>>> +struct meson_a1_pll_clks {
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
>>>
>>> I'd prefer to have a single struct type and and single custom
>>> callback for the different SoC please.
>>
>> Sure, I've written a common code for that, but I have a hard time finding
>> a proper naming for it... so I choosed meson-clkc since it could have
>> more common helper code for duplicated code over the clk driver:
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
> In addition, I propose consolidating the probe() routine of the a1
> clocks into a common part, which can be utilized for s4 and other
> similar clocks. This solution was presented in the early a1 review
> stages of this patch set.
> 
> https://lore.kernel.org/linux-amlogic/20221201225703.6507-7-ddrokosov@sberdevices.ru/
> 
> Maybe, it can be generalized for the all meson clock controller drivers.
> 

Sure, the goal of that is to get rid of NR_CLKS & private IDS only,
then yes afterwards any common clkc function will be welcome !

Neil

