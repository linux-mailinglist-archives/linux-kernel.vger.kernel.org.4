Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6613A6B0E40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjCHQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjCHQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:10:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB96196
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:09:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so67805652edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGGriQOuoP9kPU93+WJixjM30L7MDeV/RexEhwJQnac=;
        b=K/kj03yTh+emS5BuNrc7xTSb+Urjz1BnqRQzYuCGjKwf3OoLW0P7B3ikSA+vYPUOIN
         wHsFm6gRZfvzL9PKgORvS6wt29D942wNj0ndlH9fXVHlOsZF7MexapThzNnmtPdQZn8H
         fGrcj5zupXS3s6C96l5cvPgar3gb+zx0Swx0aBO0g0Z1mkG/4izlHAC5dt/AgWLs+KzV
         CTNgOxD24E2RjXWE8+BMrbw1czJjU8XZYjteixEqn3fYuXPtARvFCe7VEJZzSaTKYOmf
         SfMaF3FG33EBvnXie3yEKLP09hytpd8U1nzrqI0k5CtserA/RNhwMqW386oNBn5v3Lxb
         FVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGGriQOuoP9kPU93+WJixjM30L7MDeV/RexEhwJQnac=;
        b=1mND0RQKV2vZa6bhasQnz90ddn/9WIWUP/2dx92sljZwYJHBa/XWCoOgjVRmkeOnTv
         q5N8L1dW0sCndUj0TSpyL1GRpk500m2cymEjMU1Y/w1IlxtzLFIE2D/KAAnBTeFhifuY
         JUmt7oHL/BMy3rKaERUHg8eRATKI/KMxRdwbKLM6xk9Hs1/HOTaYFhyRjMSChrOyND7Z
         mnbcKaw6xu+lOn9OeIWX1WhpkfmyBzZVmRMm/H7b7NUDTnhqmGZB5jLHwBQheZ6XD32i
         jE3ZSDQsSLjNN56sXt79kahXxp/QNZlwyFctyuBLEoWnaZAaC7tJtPUHRsg5o1r8GwWK
         KSVA==
X-Gm-Message-State: AO0yUKXi4rHgwTDxq66c8+Q36reqs1KEiRr4qqqGPB5ojLcjylYWlsYu
        szixIJUI2GogN5eUWjw/a+TOaw==
X-Google-Smtp-Source: AK7set+iqB4Hpm8jcUdAQowcPEzmB13/jDv7C3DQQbWj4fu09WfsV5q4xZCp1V7pLJ2Z8Ew7BK6QYg==
X-Received: by 2002:a17:906:434c:b0:908:6a98:5b48 with SMTP id z12-20020a170906434c00b009086a985b48mr17955463ejm.40.1678291789830;
        Wed, 08 Mar 2023 08:09:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm7590578ejb.83.2023.03.08.08.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 08:09:49 -0800 (PST)
Message-ID: <21db93cb-883b-8799-b3a2-b143b4294a29@linaro.org>
Date:   Wed, 8 Mar 2023 17:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
Content-Language: en-US
To:     dev@pschenker.ch, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-4-dev@pschenker.ch>
 <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
 <309ec2042a73b943485671f926ec0f25c5d8f80a.camel@pschenker.ch>
 <48d0217d-283f-354b-fcb5-12801895376a@linaro.org>
 <93b5c8bb6ec2010792c117bc7ffad9692fdf063c.camel@pschenker.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93b5c8bb6ec2010792c117bc7ffad9692fdf063c.camel@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 15:50, Philippe Schenker wrote:
> On Wed, 2023-03-08 at 15:32 +0100, Krzysztof Kozlowski wrote:
>> On 08/03/2023 14:29, Philippe Schenker wrote:
>>> On Wed, 2023-03-08 at 13:57 +0100, Krzysztof Kozlowski wrote:
>>>> Is this approved coding style for IMX DTS?
>>>
>>> How the ordering should be done is nowhere specifically documented
>>> (at
>>> least this is my current understanding).
>>> The ordering how I noted it is what we gathered from multiple
>>> feedback
>>> on mailinglist discussions.
>>>
>>> With that ordering I hope everyone is happy.
>>>
>>> Philippe
>>
>> Yeah, but what if next developer next month re-orders all your nodes
>> again because he will use different coding style?
> 
> Someone from Toradex will complain that we want to have it the way I
> sent now, since this is the way we agreed on internally.

I am sorry, but coding style is per subsystem, not per Toradex boards.
Even if my example is not applicable, someone might come soon with
something different for entire iMX and again re-order it.

Either make a rule for entire iMX or do not make re-shufflings. They are
not useful.

Best regards,
Krzysztof

