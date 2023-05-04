Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C26F6965
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEDLBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEDLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:01:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C5C49F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:01:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94ef0a8546fso51236666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683198072; x=1685790072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvJ0uy6HEutfybQ9hXUZ0WTdfx2BPiN+lraEEYn0v8k=;
        b=L8DvdtYMZCKoa5b2u64jYvu195WXlh+lGno9oFN6EYpFYsEMQnMxrpYihXNTEKSQfd
         gCZEMZpQJIuXPQuhV5gX8ljxClIC8dm1kTc+5WhFO6Nu01MKMJRTP+NNNCU6YofDGBMY
         V/1uJsDfCZVlGJ1vVBwsqmP2Kg38Qcxn1FliaLaHHK+y/IvcZqiEHlTbtpCFFNHbUlVU
         QdMQseQDl32ZmVQLnoZpxen7LiywtiieNOnTt12F1Fks4WeX1kAYBq8XqqAa9efEGKo8
         v9c2JT3ev0yZa0wLMIJpBbQbMpjq74olpzlx+zmWzLP3JNYytOvGcuCqezR3ln4jZDfX
         O7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198072; x=1685790072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvJ0uy6HEutfybQ9hXUZ0WTdfx2BPiN+lraEEYn0v8k=;
        b=UJS2BSV1dEK2LZJ3wI69SO24ONDNW0xqriwjpMz6fSbEr7Q8cG/txo9VmH23rY78XG
         41TCK1jqAMG8rDuKf06kXyWUEv/o2ZOcPS8fwTQtMKMTgAEutLSY+fXYj4KEzFieh8vJ
         bsS/A5T1kKb/7hkmb603PrV5YMxhaK+pTOB5XLF1ngVyQSUEhb23sHd4bdN5IDLDlA3p
         FCaJTzOES+fFq/zYWC5nUwWCNFu9cz9d8ztWaXssWjzscoBNVOjfeQh4c/p9TOsSSISW
         V7m6NTzrX42bbbIgnuyoK6SOJFHNEeMtkO6oZryf0CukLtP75R6PIkMbPf6m4BIDGNLi
         P+2w==
X-Gm-Message-State: AC+VfDzuDgBvyHixzyXydMgMH9H74LpGv7Ol0lGtGyrxXcQ3EW+cjOxM
        +Kzm97Cz/L6OY7guuZuMUVXK9Q==
X-Google-Smtp-Source: ACHHUZ6hvhyekVU+NPr1zEYkpDOImXg59GWPOs1lW78/gLNvIJeTQriFcfarF+KMexUWuBsi4In3ag==
X-Received: by 2002:a17:907:31ce:b0:94e:aa8e:b56e with SMTP id xf14-20020a17090731ce00b0094eaa8eb56emr5367364ejb.33.1683198072550;
        Thu, 04 May 2023 04:01:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906c40d00b0094aa087578csm18851613ejz.171.2023.05.04.04.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:01:11 -0700 (PDT)
Message-ID: <517aecda-681f-ce77-08df-97738a865f96@linaro.org>
Date:   Thu, 4 May 2023 13:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>, Greg KH <greg@kroah.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
 <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:34, Peng Fan wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年5月4日 17:31
>> To: Peng Fan <peng.fan@nxp.com>; Greg KH <greg@kroah.com>; Peng Fan
>> (OSS) <peng.fan@oss.nxp.com>; Rob Herring <robh+dt@kernel.org>;
>> krzysztof.kozlowski+dt@linaro.org
>> Cc: abelvesa@kernel.org; mturquette@baylibre.com; sboyd@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; linux-
>> clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>> parameter
>>
>> On 04/05/2023 11:17, Peng Fan wrote:
>>> + DT maintainers.
>>>
>>>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>>>> parameter
>>>>
>>>> On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> With the clk names specified in clk_bypassed module parameter, give
>>>>> user an option to bypass the clk from managing them by Linux kernel.
>>>>
>>>> As I said on another email, no, please do not add new module
>>>> parameters for drivers, this is not the 1990s
>>>
>>> ok, but this is for boot, so only DT could be considered.
>>>
>>> But DT is to describe hardware, here I just wanna give user an option
>>> to bypass some clocks. Is it ok to add a DT property saying
>>> "fsl,imx93-bypass-clks = <IMX93_CLK_X>, <IMX93_CLK_Y>" ?
>>>
>>
>> I don't know what it is to "bypass some clocks". This does not look like
>> parameter for system at all.
> 
> Currently the linux clk driver registers all the clocks and manage them.
> But when M33 is running, M33 may not wanna linux to manage
> some clocks M33 is using. So I wanna linux not register those clocks
> that M33 will use.

Ask the one who designed such system that second processor pokes parts
of first processor... I assume if the clock controller is enabled in DTS
for Linux, then the Linux owns it. Otherwise how do you expect to handle
concurrent access to same registers from different processors?

And how are you going to decide which clocks should be managed by M33?
One firmware could want to play with one clock, other with everything...
Module parameter is not the way to deal with it.

Probably Ahmad's idea is the only one reasonable in your case, if you do
not have hypervisor.


Best regards,
Krzysztof

