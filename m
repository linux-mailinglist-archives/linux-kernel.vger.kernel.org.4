Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DC63139F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKTLWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKTLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:22:35 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0811B2BCF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:22:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s24so11694062ljs.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufoSlXchpv3+JWv90+bHohtuyaEesYE37/HIrF+TV84=;
        b=ziHd7IrY7/y9j2KB4jF8XNyQzzz85uTKo0fy9g6BYsK5OcIaENGpaQfbNiXGXD/f2Z
         SvKNp+I6eiHHlW0e2IecxyL/1ErjYldkSfoZ/MzRoCMalF9+ojARYjckmIM/0i/eYbo0
         qoUQ5LdqrkgYMonInRD453rlhN2wYx/aJExRCDLXKexhlSKr6BdR51HVSwe8rww+uXqC
         VWtYw02VKUGjSnwzSD727hsAl93yWcuZP2phfcYvB5Lwn8S9KTme5qL63mQG3LWU6kfA
         5sI5kF1prMf860HSGk6u+nkBiBRm4ol+ND4WWEzYjOXipaSeLGaIgKjN5K/wKqaV+vRg
         ySfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufoSlXchpv3+JWv90+bHohtuyaEesYE37/HIrF+TV84=;
        b=I8JkOt+l250d8XRDi6Ax4oyxKHJz6K+3wW9fRS4lPVkdBTB00X42rCHJuATmXyhQ7i
         irdms4rP9rgsxp+od90mejcxmycebhY4JS8OUh1tKqo7yb0D1v+3OH8oa6tARyBrxwUR
         A8IVRC8jYyiKCyvbgjymwYeTyK0OIviCGuNJAenHF49mXC3wZVUmDJ9h9mHrcdm1qN6w
         zn1AI8ibx3xiRghCcGHzkOLgaL4Xu0lwC69wVTaCODiZVftHBemcxNqJvgWduK0C9J7v
         9jWW7gssUQ4waaX+uY8JJr3Nxe8NzBUdei+ZEwxnBMzBLBSlXUk6YmfHqbV/nqXd5Iyh
         uWng==
X-Gm-Message-State: ANoB5pnJ/NuH2C633BvQlNHj+vjvmOxVbZcOVUxLsYgv7YcPReZiSx/K
        e+/sbxC6P78kciV5CbcsYw3vqg==
X-Google-Smtp-Source: AA0mqf7lr/kWHjScfpUNbE9IGMgO50C8GEWxPIFLJo3Yran5pebBBM8zljWoA7jLKUAOBo/dozmTiQ==
X-Received: by 2002:a2e:9c51:0:b0:277:e8e:8d90 with SMTP id t17-20020a2e9c51000000b002770e8e8d90mr4680122ljj.243.1668943352426;
        Sun, 20 Nov 2022 03:22:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b00492dc29be7bsm1504431lfr.227.2022.11.20.03.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:22:32 -0800 (PST)
Message-ID: <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
Date:   Sun, 20 Nov 2022 12:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: s3c: Fix a build error after the s3c24xx dma driver
 was removed
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel@pengutronix.de
References: <20221021203329.4143397-14-arnd@kernel.org>
 <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
 <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
In-Reply-To: <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2022 11:31, Krzysztof Kozlowski wrote:
> On 18/11/2022 22:54, Uwe Kleine-König wrote:
>> The linux/platform_data/dma-s3c24xx.h header file was removed. It didn't
>> declare or define any symbol needed in devs.c though, so the #include
>> can just be dropped.
>>
>> Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
> 
> The file was not removed... or it should not have been yet. The s3c24xx
> dma driver removal should be part of Arnd series taken via SoC ARM.

Also: I don't think the fix is correct. The header was used in mach-s3c,
so removing the header should still cause broken build.

It also fails in other places:

arch/arm/mach-s3c/s3c24xx.c:21:10: fatal error:
linux/platform_data/dma-s3c24xx.h: No such file or directory
   21 | #include <linux/platform_data/dma-s3c24xx.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

I think that commit should be just dropped instead.

Best regards,
Krzysztof

