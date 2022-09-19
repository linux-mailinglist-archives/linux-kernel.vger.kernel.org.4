Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B655BC5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiISKE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiISKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:04:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F472AFD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:04:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so34866893lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yNE2cp1RD1RoFuEYU5xwyQsBh6VbTtl5xLpOIA56rKU=;
        b=qL4HPMcfptSWQnmD3iCMUCdb7qVYUg0OJMQvjunISVwVid3qG9+fclUGpBJKtuRDfT
         7TO7gODJE3ezG0+ABlxs3nWZAfJDaFp/WEdcinjMOA4dK4mE19fWrAFTC8ZSYcFQSqC7
         z2882o9IRCJ3M62jsAlwbxfCAOdyrZ+Lcrxn7HoY1/ydvoo4jV3/1SF8PRQZdn8OwUZf
         PG529g6LcMpWf0NG7YSV9GUztHoVPTHwtxnsdNPD4bP3P2TkXg1fLycKtW2hu5O+AQ48
         KUK6rD9UMJgxPsmx8ZkVK6W2PE5rY+M1+ZS70rrtxv/VT4RS3RK6pQCIgb4vzq44kYsB
         9jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yNE2cp1RD1RoFuEYU5xwyQsBh6VbTtl5xLpOIA56rKU=;
        b=o+36ljuqBMcD2D/Y6GHO10q35MyUxnVSLz3qsq0gy7lh3uM6BXI88B9xWnEoo605ix
         xMw4f1vzwV2MWXNm2FYAArFkz8tRymUC4+f+Yrx6OyA/BVQCNenpJ4kTJ6m4JZRcwIot
         46gosVrbBFQeJKZzuqq07LVtm6Z6xR6Mq4sqwKRYeVGdmYunr7iZ5Q+u8WnuMLp9qI8W
         +VkfwRVSsoooP27dzCEA2WQ53PCM334x7YeigjVkKhlEwRAXE4dxwX8jLBHtyERJZoyO
         uKLWvG32dPDtCOpya3uer8HAYN6hcm24Ck0LX5Q6jdyk5YB8GgKpRNO1I0pOx+xbevcM
         8kLA==
X-Gm-Message-State: ACrzQf2KgtK/Mbze1Pv0lrPfvGIpjRm5VMzg0au9aGO+xgvEr00seE4X
        TchDNZGsGG+cjajb1xExs7hbcQ==
X-Google-Smtp-Source: AMsMyM64syZOKjIOi9iMOVhXz1gn4ACZcGEmVgxFTnQUH4zzM/GgVRcz3QHUBXYJ4FUtBMIK6Y9Wgg==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr5759696lfu.602.1663581889926;
        Mon, 19 Sep 2022 03:04:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q14-20020a056512210e00b00492cfecf1c0sm5136819lfr.245.2022.09.19.03.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:04:49 -0700 (PDT)
Message-ID: <54d22a77-5db7-e44b-176f-755e80e44c25@linaro.org>
Date:   Mon, 19 Sep 2022 12:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
References: <20220919055904.1659124-1-peng.fan@oss.nxp.com>
 <20220919065820.fk3ppcdoioubqfbg@krzk-bin>
 <DU0PR04MB9417BF9DF3BB65B859BBB676884D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417BF9DF3BB65B859BBB676884D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 11:28, Peng Fan wrote:
>>> V2:
>>>  Drop syscon, use clock-controller
>>>  Add fsl vendor prefix
>>>  Add interrupt property
>>>
>>>  dts update not included, so there will be dtbs_check fail.
>>>
>>>  .../bindings/clock/fsl,imx8m-anatop.yaml      | 51 +++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the following
>> warnings. Consider if they are expected or the schema is incorrect. These
>> may not be new warnings.
> 
> As I wrote in cover letter, dts patches are not included. Should I post V4
> to include dts fix? I planned to do that after this yaml got reviewed.
> 

Yes, better to include both DT schema and the DTS changes together.

Best regards,
Krzysztof
