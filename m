Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5B671FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjAROkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAROjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:39:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF36C4A1F1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:30:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1653523wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6fqLv/UnsGBNSc1Mg2An/wLaAUk0qhAVQW6Ibj1PBg=;
        b=uSwrEp6ZoJZh6sAuoGCD4UCnDtztV6IpGP/AtZLvPmNNrN9xz/jnx5F8XJMVHPBqn5
         ZzcZzqX0tvwa9jZAPnNb9Iir1I4A3yJpVI6pELJJZ/reofaXSE+ykAPOL9zkoaWypm4c
         dFDBuJBzKtRQsxUsPNxYQunkXbxsH+rTEPJ0YWB744+v7U7SGNb404KVu0RxlW2ZS2P9
         fn3p6hvdQYoNOOyI7OWuf3xzjM84jsVF+aQx7V2oF6MOXWagF3jni9AWzSRyJMt/Yo/9
         01FTIhNrN54CvWR8VmxYaozTjid29UxEWxMal0tY0lReyeq4362SFO21i1sEMCT6+ttu
         XLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6fqLv/UnsGBNSc1Mg2An/wLaAUk0qhAVQW6Ibj1PBg=;
        b=gIwFt0iQTnoeP4zDAD82tkZy2ctXljuSSXMn5zFLvbcobhDlBkvf0Iw5zIoDz6xII3
         BDQTBzAEaSMTtmFnIe2dJhfLrzHhNxkG8DuB/11HihPTShjvqJNaGp1CU9CqaG/rZuhN
         73z0iisZjbilcXXvTvKFh4pwwe0TGdAhSAv0wRyPmN8sMYR/f8Unp+quI4nnzPaWplSg
         dcehLUyEqDR9hM0YyqHEFBTDVeqF+YZbTrZCtQgSoYQJK5/sn0EEmlwN8tvnmSAQT9zB
         lZ3Vope41cqxzNn8WuyegixJgnA2T327ejjtd7qbabv3WDOTDCYhIoNeQBisi/6QXhIG
         eCgw==
X-Gm-Message-State: AFqh2kqqcoGbMXcQPuJkttC71gtKnUmcGJdaFdstrZhBIhuL5Dqk7Piw
        jWe8qMo0J+YOTwVqoCCI6SyxFQ==
X-Google-Smtp-Source: AMrXdXvLSN0PHBbiULtPldAnGFmVmcZkI5nbWAR+T2eQFEX0x8wEip7qwseRQfUhjWZgAKhOO6oFSQ==
X-Received: by 2002:a05:600c:540a:b0:3db:a3a:45ac with SMTP id he10-20020a05600c540a00b003db0a3a45acmr5788450wmb.32.1674052236293;
        Wed, 18 Jan 2023 06:30:36 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l23-20020a05600c1d1700b003db0dbbea53sm2418963wms.30.2023.01.18.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:30:35 -0800 (PST)
Message-ID: <71e5c68a-dbc7-caac-d6d4-5a8cd5b20d5e@linaro.org>
Date:   Wed, 18 Jan 2023 15:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
 <CAGuA+ooxTf-j957gQ1zRe2-+u2kphaaLGvTDi1=kit5Q3bKOxA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGuA+ooxTf-j957gQ1zRe2-+u2kphaaLGvTDi1=kit5Q3bKOxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Balsam,

On 18/01/2023 14:58, Balsam CHIHI wrote:

[ ... ]

>> You're describing the register with nice words, but there's another way to do
>> the same that will be even more effective.
>>
>> /*
>>    * LVTS MONINT: Interrupt Monitoring register
>>    * Each bit describes the enable status of per-sensor interrupts.
>>    */
>> #define LVTS_MONINT_THRES_COLD  BIT(0)  /* Cold threshold */
>> #define LVTS_MONINT_THRES_HOT   BIT(1)  /* Hot threshold */
>> #define LVTS_MONINT_OFFST_LOW   BIT(2)  /* Low offset */
>> #define LVTS_MONINT_OFFST_HIGH  BIT(3)  /* High offset */
>> #define LVTS_MONINT_OFFST_NTH   BIT(4)  /* Normal To Hot */
>> #define EVERYTHING_ELSE ........................
>>
>> #define LVTS_MONINT_SNS0_MASK   GENMASK( ... )
>> #define LVTS_MONINT_SNS1_MASK   GENMASK .....
>>
>> /* Find a better name for this one */
>> #define LVTS_MONINT_EN_IRQS     ( LVTS_MONINT_THRES_COLD | LVTS_MONINT_THRES_HOT |
>>                                    LVTS_MONINT_OFFST_LOW ..... etc etc)
>>
> 
> Given the complexity of the controller and the number of registers,
> if we create a define per bits, we will end up with a huge list of
> defines (~300).

Yeah, that is too much for a little gain.

However, a few can be added for the interrupt only.

Instead of LVTS_MONINT_THRES ..., it could be LVTS_INT_THRES_... and 
reused for LVTS_MONINTSTS and LVTS_MONINT setup as the bits position are 
the same?

[ ... ]


>>> +static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>>> +{
>>> +     u32 period_unit = (118 * 1000) / (256 * 38);
>>
>> #define SOMETHING       118
>> #define SOMETHING_ELSE  1000
>> #define ....
>>
>> const u32 period_unit = (SOMETHING * SOMETHING_ELSE) / ....
>>
> 
> Constifying "u32 period_unit" generates the following compilation warning :
> ./include/asm-generic/io.h:273:61: note: expected ‘volatile void *’
> but argument is of type ‘const void *’
>    273 | static inline void writel(u32 value, volatile void __iomem *addr)
>        |                                      ~~~~~~~~~~~~~~~~~~~~~~~^~~~

That is strange. period_unit is the 'value', not the 'addr'. Are you 
sure about the warning?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

