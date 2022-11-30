Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5763D331
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiK3KVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiK3KUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:20:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D4716CB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:19:46 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d6so26189068lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiaeu6so/JEUCyxFsov3QLl0htfR+LKERk9Hgh4VTlw=;
        b=kD5ZCep5RjWDgp9hUNQaRv9efh/c+wlvpv2D0Qihgf+vSTPLu1jOANVsckyL8K7D+x
         VLin/M8CHeJ/fSFxLI9k84Qr0OooWQq7P+PBGBU4jUSGTR9NUOTfMw0aSaevXvllpT7H
         l8wNpZrdvBNyC6CuMdoOOZkaGVVp+DfUxAD59Cmt8j7XhjId+dJW4XZUqZkF4HxkyNQ4
         a454+I6fapZDIC+1qd3M/t0QZnAvszbL3C7virphIvH6k1rCcgpcldi+RJjptdpUbHQL
         JvfYHaW/hzJ/8SVkGCO+3bvxrgwL2ZfoQxBjT+5jnreFxf1/5pIo47wDwO/64axX5H0l
         Ki7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiaeu6so/JEUCyxFsov3QLl0htfR+LKERk9Hgh4VTlw=;
        b=2MVXGSs7SkISTV18HNVWO019SIdAqcZWHw3exzaGP5ElGZor0A9UxsbVzXSPobqutS
         tG5yePVb26adPykHM9UrK2aYkc0z8hee8aMB4xTSeeK5fAM+iMoU4AAbDeM1JHoBT2SN
         sGI2v1oz83pFAeJSOpVfM4JpRE//vsHizHe5W+lovLS9FIELzRPFE+pWoaBmxjEpUf3e
         xtkCzIbjE9oMTh8Nx+TDvwO0LNADymJ1eI5iddZYi4kAxxhJAeZlYJ2TthmL9CJhOKO0
         zoyvgDQbxOe0fw6pedWDjncMzjK4yynOQyLXfD/H/uKsriJymrxppWTYahc1V9lDpgTO
         Gl5A==
X-Gm-Message-State: ANoB5pmoDRbEQkQXUbYWJTBKOuSs24WUDpzTx73EsSUodidwhJCxmZK8
        8Sz5od6aaaRwpXZJUHQMv3luyw==
X-Google-Smtp-Source: AA0mqf60Dm3uosYFvIZVTMXVXEJ05pDusHdpqM6oBBjUX/nmAwPOZXrf/sU6ZspM+cnaS9eawsGW8Q==
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id c8-20020a056512324800b004aa148d5168mr19338500lfr.561.1669803584655;
        Wed, 30 Nov 2022 02:19:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h21-20020a05651c125500b0026c4e922fb2sm96011ljh.48.2022.11.30.02.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:19:44 -0800 (PST)
Message-ID: <07ee65df-8585-c151-f834-6e6e0f9effbb@linaro.org>
Date:   Wed, 30 Nov 2022 11:19:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-2-cniedermaier@dh-electronics.com>
 <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
 <Y4csBBZ3OnpXS5TR@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4csBBZ3OnpXS5TR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 11:10, Lee Jones wrote:
> On Tue, 29 Nov 2022, Krzysztof Kozlowski wrote:
> 
>> On 22/11/2022 12:11, Christoph Niedermaier wrote:
>>> Replace the watchdog file name with the name currently in use.
>>>
>>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>>> ---
>>> Cc: Support Opensource <support.opensource@diasemi.com>
>>> Cc: Lee Jones <lee@kernel.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: kernel@dh-electronics.com
>>> Cc: devicetree@vger.kernel.org
>>> To: linux-kernel@vger.kernel.org
>>> ---
>>>  Documentation/devicetree/bindings/mfd/da9062.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
>>> index bab0d0e66cb3..e96629eb9f48 100644
>>> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
>>> @@ -85,7 +85,7 @@ Sub-nodes:
>>>  
>>>  - onkey : See ../input/da9062-onkey.txt
>>>  
>>> -- watchdog: See ../watchdog/da9062-watchdog.txt
>>> +- watchdog: See ../watchdog/da9062-wdt.txt
>>
>> How is this related to LED patch? Don't mix threads.
> 
> Que?
> 
>   [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog

It's a response to a LED patch (single, not thread).

Best regards,
Krzysztof

