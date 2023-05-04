Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A76F6850
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjEDJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEDJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:31:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE1149C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:31:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so15135712a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683192658; x=1685784658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaczximwLqjWvhf3kocqHyl+J5SvoMmPF03yVDwkRs4=;
        b=aNPccQY+gX06bolqcHhXi2YhG6kR04MHmDjVRfdOemxBzkYktH3gKS6dDofm6KP+Up
         Jhtmd94g6jXYRGWtkr+21KPl0Q4MtgiOtLaXDuDaKUEPNT3oW1LDbhh0yNvX7PS47i7R
         3jIaJrpfhYfTBhZV9jA7qOWXofW9NeDkQa0yaM12YWLc+jp/iOLi3HgsDhrO44Z6u3c3
         VJU5Ex3jk6CK+xA8sXQ9WMYJILu2bmXEFUe5Zzi9rf9LJ9GJf+sLbSF5JqNe485AGKLv
         4s4b65yZrcUE22zy50aIzWxXICitIDSH3YeP2nKSVQ3hcauABzOSfBCV59Jr0pjnxMfr
         dDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192658; x=1685784658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaczximwLqjWvhf3kocqHyl+J5SvoMmPF03yVDwkRs4=;
        b=e+DiKamhRWP+RgH8M3jneuHR8yylJ+DmFHDLQovRXS4z7RtlNsZxtXmLfdjtwoxjRO
         zmEnJMYl6uH14AJC1LCq+Cv6G2Zb1HHbnx60Sg2gVqY5j0ZZ8ll3/H3ch8hfDHu/r5sF
         AG+cuvS14hbYz+Uz5+2geTrhY85WNyzb9j9H/3w/vlHI4w27TGBAxo1EMfKo//9lM4IY
         yAYYKs6LfXyG1SfZZF6fSa1YpTlPM4AX3vW0m7gmbKEevuTIq/95kGN6FKThuBs9xJF/
         HGbLJqiliTEi2Dbi+Hubrfb93pKCXI2NLP1DD0PI4puPvBfcZh8JU3Pc9FlpJh8+Vqs9
         /zTg==
X-Gm-Message-State: AC+VfDyn0YYaQOq8t+gT7tu65j0vr5/YDDylDuVmiB9gjNCIY6Uz1kVN
        RGtguvuXRkahBZCKROV5i4aHIA==
X-Google-Smtp-Source: ACHHUZ4zWC5818MrlYN1OkCW/KpORJOzjBkAj9AnViKKKaMTTIpIp5OwrMHe9lbhkR79JVl27RQsFQ==
X-Received: by 2002:a17:907:3e84:b0:94f:1ce7:1865 with SMTP id hs4-20020a1709073e8400b0094f1ce71865mr5054078ejc.26.1683192658602;
        Thu, 04 May 2023 02:30:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b009629ffabe0asm3349435ejc.224.2023.05.04.02.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:30:58 -0700 (PDT)
Message-ID: <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
Date:   Thu, 4 May 2023 11:30:56 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:17, Peng Fan wrote:
> + DT maintainers.
> 
>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>> parameter
>>
>> On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> With the clk names specified in clk_bypassed module parameter, give
>>> user an option to bypass the clk from managing them by Linux kernel.
>>
>> As I said on another email, no, please do not add new module parameters
>> for drivers, this is not the 1990s
> 
> ok, but this is for boot, so only DT could be considered.
> 
> But DT is to describe hardware, here I just wanna give user
> an option to bypass some clocks. Is it ok to add a DT property
> saying "fsl,imx93-bypass-clks = <IMX93_CLK_X>, <IMX93_CLK_Y>" ?
> 

I don't know what it is to "bypass some clocks". This does not look like
parameter for system at all.

Best regards,
Krzysztof

