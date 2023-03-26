Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B0A6C97AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCZUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCZUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:02:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787726B3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:02:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so27632255edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679860961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DazWKebj2lRWg1ObnAajvsy7M56gUmUMIv5qbvT2CDw=;
        b=bNPB4Ccy5XCkx+8QAyX+sorKadLmeYghLCv8V3BcQyOu5LuL0hC5ZQB2AXH4pE75pT
         SI4pHWQve+h+TrgjM2jk7fNq/OAgs5d1mX6gu2U9CIN4T7lPJqAYilpSqehZx1OaQa4w
         QHha9kr/LML1UYrEaZ513YUlVs8LRlv3CUz+4lCLLYk6ISVaO0rVWCScM/xXLY3xUyiU
         iaQ9QWBSmmO8PtLUqQrUx1iDaqLF9In0Ng97C+HVcJHS0gWVgE2xZ650ZqKftB88fC6J
         u2QK0x2BxTsO08EkaU9N2O+zUKC+3r1vgUcIrjGOMXlmHH+VON8snF9Ety9gwuKK01NH
         AJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679860961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DazWKebj2lRWg1ObnAajvsy7M56gUmUMIv5qbvT2CDw=;
        b=WRLIkPqC7/gbxngIByOkJveb3Sk4mHdBhkwNHUrwp+eSz2bdcNmxspBdDTDdEaWTe4
         cQOMMRob9lZA3S87aQEizGAsN14em+x3gXJJC96sLpQF36zp5lAHWzenPkgd2goWzNyD
         1+17ShPXQ7j4MBmBlHHnbM3Qi3FdYKJpqa6ptNujCMevJFEVXI+qHr+lQ1WSeG/KjgqU
         JwdwUwWD943pnsPz/H9zPE6J21URoou6f+s6/EbwmWiFMWLgOGOyBJzJ5nFkBLqXfM9l
         e8/BMK8M7rHuMRhwsdpeGJMt9AMVh+Gv1Z35c4vU8gStWEekEHFvflo1Av6lCSQUNq+j
         JDpA==
X-Gm-Message-State: AAQBX9fCnAY8w810iH9G/7SYt7AuQZK2AJjQ3oFLwM/fS1wV9KHu9pQK
        zRBrlsNZzo6J4xx29XovzZk8YA==
X-Google-Smtp-Source: AKy350YQZLA++IfD8sdPFP7K0HlbhI49hKZfioV/qHbnQRL1p2eTf8fgPRmFffJsdIe++eCT8OHahA==
X-Received: by 2002:a05:6402:1285:b0:4fb:6523:2b37 with SMTP id w5-20020a056402128500b004fb65232b37mr10926401edv.15.1679860961614;
        Sun, 26 Mar 2023 13:02:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6b51:4748:3f3f:ffcf? ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b008d9ddd2da88sm13292289eju.6.2023.03.26.13.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 13:02:41 -0700 (PDT)
Message-ID: <03ec1aac-3c6d-892f-fad9-f386a5d4d10e@linaro.org>
Date:   Sun, 26 Mar 2023 22:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com>
 <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com>
 <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
 <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
 <717bfba9-1d70-ef09-9193-853a57117926@linaro.org>
 <CABnpCuA7V9ti6BOoz+3Mq-f=PwgxL2K7rOhjo6tJ4QquSZbaSA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABnpCuA7V9ti6BOoz+3Mq-f=PwgxL2K7rOhjo6tJ4QquSZbaSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 19:51, Shane Francis wrote:
>> Bootloader also does not use mainline DTS, so where is exactly the problem?
> 
> In this case uboot does load the target DTB, and it seems a common
> function in rockchips
> downstream boot process, see :
> 
> https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4859ecc94623a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70
> 

U-Boot comes with its own DTB, so what does it means "loads the target
DTB"? From where? The one appended to the kernel zImage? No, it cannot...

Any component which operates on mainline DTB must conform to the
bindings (with respect to the ABI), thus your arguments here mean you
are not allowed to change ABI in the future. Never. This change,
assuming original binding was broken, could be warranted.


Best regards,
Krzysztof

