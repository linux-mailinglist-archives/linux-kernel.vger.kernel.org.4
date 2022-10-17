Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2956007D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJQHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJQHkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:40:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DBB20BF8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:39:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so9362643wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xULmL9toOM8goswSRi9Z/PganGhK1BnJ45pxOOozJ0=;
        b=u23cLIE8delL0pdutyQe6kJnksOAOK+A2YkMQPq4/gjWhjCp7jI/X+7EdAHQ7InRqY
         ozhOTzcaqG1q12Vwa92mgN/N0VUOWas3OjXJ8FgZbAAdv6+oKsthHeeWZipnaucI/XO8
         r3wbRpMj6sXD1s2qK0pTYPE2xAl5rG5BXDESx+Ko8yS4wl9iU/SK07C6BV7EZJowkUyv
         ytGRRnYNB24J8t2JXpeud/fcenA12ur49JDgmfmypQ1TT05pVUMqQ3gWPqu3ripzT9OI
         P/VLwV7aOLLYPfUUK17FW9VzdIbATUOy4ZqK/1Kut+9QcawjH/XAq8lKdE5nhBt4xC2d
         Z2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xULmL9toOM8goswSRi9Z/PganGhK1BnJ45pxOOozJ0=;
        b=Z2pn4D41VDZsVs32KIbms/Q4lIEx6pi6yjFoK03/ANyd339EnZT1DaGbpxnQq+1h07
         EG9xvYRHBbMS+uvq4H95bJdY/NLjNuQnSuqTQwJ7hjFyh6Wemc5KBTjx0onGi9uL3sWe
         0K5jWr1u9SJbVvKG2FdlE1lu6I2pXid9IIFGpJuq+vlYos5s1Bpq3nfcaWMwQrz8FPG7
         LFnFwjCHsWxKV2FFiW4gA928qU28Ya4HJT1AnwOqkI8qMNt80V9UHj92v/EGKW6ouWss
         xpMfObOYrqc6zdfNxUdhGrEFdUupbVFhgleblNZjsnLb7zpjNAl9IbjCD/3Me/yM/nmh
         5KEw==
X-Gm-Message-State: ACrzQf3oqlJ8K+LPr9ckJgOuTGn4TqfkTxkBT3CmEFYYX625VQKd8hBK
        TlsSLBoiVbKotFb8AVLY5n/sU7eIavkX4g==
X-Google-Smtp-Source: AMsMyM4y0wAj3Yf6zsIoEbhqs2P7MFNeDZzZWw64Y65KCdYW+ICqrNZ9qRBEAVa9mO4GiMoYqPG9IA==
X-Received: by 2002:a05:600c:2f08:b0:3c6:befc:9778 with SMTP id r8-20020a05600c2f0800b003c6befc9778mr6257607wmn.101.1665992391800;
        Mon, 17 Oct 2022 00:39:51 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9? ([2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9])
        by smtp.googlemail.com with ESMTPSA id d20-20020a05600c34d400b003b4de550e34sm9537531wmq.40.2022.10.17.00.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:39:51 -0700 (PDT)
Message-ID: <7c4a9b4a-d84c-33f1-eade-6ba445c917e4@linaro.org>
Date:   Mon, 17 Oct 2022 09:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix the debug print message
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     bb@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010034126.3550-1-j-keerthy@ti.com>
 <a1eaa937-dcfe-52d0-954b-3aaecedc1aa6@linaro.org>
 <aed3cf8e-62d2-febe-8de9-24cec1eeafaf@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aed3cf8e-62d2-febe-8de9-24cec1eeafaf@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 09:38, J, KEERTHY wrote:
> 
> 
> On 10/17/2022 1:02 PM, Daniel Lezcano wrote:
>> On 10/10/2022 05:41, Keerthy wrote:
>>> The debug print message to check the workaround applicability is 
>>> inverted.
>>> Fix the same.
>>>
>>> Fixes: ffcb2fc86eb7 ("thermal: k3_j72xx_bandgap: Add the bandgap 
>>> driver support")
>>> Reported-by: Bryan Brattlof <bb@ti.com>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>
>> Applied, thanks
>>
>> BTW, Kheerty, if you have time is it possible to convert the 
>> k3_bandgap.c with the pre-computed factors like the 
>> k3_j72xx_bandgap.c, so both can be merged ?
> 
> Okay. I will try that out in a couple of weeks time.

Great, thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
