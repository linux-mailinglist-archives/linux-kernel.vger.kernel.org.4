Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340585BABA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIPKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIPKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:51:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A6B5154
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:30:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so670767wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3pSSbYLsUZVphsAWzkeXxvJouGOGgPDa3BFZ6REzto4=;
        b=u8x/gpFB48PZ2CVbPWXd89tZdFwnU41LwIPsiCY6fWlNE61ORB4aaNwFhBQA33VcqJ
         1rgIMOQhIL7BpbiSm6SxOAE/Jhl4KPdFLkK7FhPlgpqCSTHYTooCLmsZV7fiUTeLtHuJ
         2seIzGcFeLlUWwQSb+NW+1vXI+SUydvOSe2zuKQToyp49RczDOykjMVp3jwsGLAosbIP
         7w4T+by5xnZok/pnf1td5ZEYjDmbBPDuPYoifV5mJMLDXZTbSDV+74i7zKIEHRQqTDEq
         2xcEEXblCkNKih7XRRRnX2mDclvu8bjKfACWz/Y5wXoyxbbW2BK1Vq2n8RLh20rPUIir
         toLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3pSSbYLsUZVphsAWzkeXxvJouGOGgPDa3BFZ6REzto4=;
        b=aU7a9b9Q0Vg+9RFi1HfOsXymTrE8/dnW7f1L2vRb4wpeAmeFWSwIrIqjDS9WNNUZKY
         5SowKZKKiwyQQpXstFApQXCoxVKDEiOIt+lQXtdUk9Aq9x9pydam3G2HaQX33vAw7bTI
         5duo6cALML5ULPvH/lucWSDUNs6IrdCJK/nQnowWRdxbagDUVNiKUt5ayA1YrYuup56P
         UtQ4B2Peg1o2OcDR9T097D2U/0oL2IEvTRoxk5xGhxym5Oqe4qtPYbKtompOR7dhBC0X
         7hooB5fCLba5eED2qKbZ+drdrlKZoIpndq8zbqGxM4E4P7v34zqDso0+4TDLaf3ykMvG
         +WbA==
X-Gm-Message-State: ACrzQf1w5kvaC5FCn/loFmhFDGe5UVvjN+TcTGXktyTpCuqxWyto+ukt
        OoFk8AzzkgdzWmnn0e6tHx4/vg==
X-Google-Smtp-Source: AMsMyM4OyQkKoo2fuhcDIb/EjBh2hnOfoU1+YHmTYRKnnONgZLG46VxZ2lyHsBWIqlwMI1WUY1go/w==
X-Received: by 2002:a7b:c417:0:b0:3b4:5c94:24c1 with SMTP id k23-20020a7bc417000000b003b45c9424c1mr2843337wmi.86.1663324215296;
        Fri, 16 Sep 2022 03:30:15 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b00228e1e90822sm4679007wrw.112.2022.09.16.03.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 03:30:14 -0700 (PDT)
Message-ID: <66a057d4-8c52-6a64-c23f-ba4a4428efb5@linaro.org>
Date:   Fri, 16 Sep 2022 11:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: firmware: imx: sync with SCFW kit
 v1.13.0
Content-Language: en-US
To:     Viorel Suman <viorel.suman@oss.nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
 <20220915181805.424670-2-viorel.suman@oss.nxp.com>
 <42e78db0-74f9-3098-0cf2-908092a0b594@linaro.org>
 <20220916101738.xn7xx7ipf7p5dbok@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916101738.xn7xx7ipf7p5dbok@fsr-ub1664-116>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 11:17, Viorel Suman wrote:
> On 22-09-16 10:38:30, Krzysztof Kozlowski wrote:
>> On 15/09/2022 19:18, Viorel Suman (OSS) wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> Sync defines with the latest available SCFW kit version 1.13.0,
>>> may be found at the address below:
>>>
>>> https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
>>>
>>> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>>> ---
>>>  include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
>>>  1 file changed, 203 insertions(+), 96 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
>>> index 43885056557c..a4c68f394986 100644
>>> --- a/include/dt-bindings/firmware/imx/rsrc.h
>>> +++ b/include/dt-bindings/firmware/imx/rsrc.h
>>> @@ -13,34 +13,38 @@
>>>   * never be changed or removed (only added to at the end of the list).
>>>   */
>>>  
>>> -#define IMX_SC_R_A53			0
>>> -#define IMX_SC_R_A53_0			1
>>
>> You cannot change binding constants... Aren't you breaking all possible
>> boards and users?
> 
> Hi Krzysztof,
> 
> There is a backward compatibility section added in the end of the patch,
> it follows the same approach as in SCFW kit v1.13.0:
> 
> +/*
> + * Compatibility defines for sc_rsrc_t
> + */
> +#define IMX_SC_R_A35                   IMX_SC_R_AP_2

Then it looks fine, except someone would need to compare/test the numbers...


Best regards,
Krzysztof
