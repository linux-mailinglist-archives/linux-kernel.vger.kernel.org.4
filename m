Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75765C0B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjACNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjACNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:17:16 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047A11146
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:17:13 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id q2so31774430ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FI/7QHfOajTdVOFx3npU5LTfbLBIpMx67ZW4jlbDII4=;
        b=Qm8nhinte/zhOwvr5PeUAjahL3rIkDxvy9KfKJCnjDHzK5p052c2oPoNZPlsmnuZDx
         tlRkQWr4NR+5v3DMDnzul9blhVLy72dkMlNhkaGexrAJbm9q13wYwrKuWLNuMM2jSAL1
         NzGMUsSJrv4ZJi3Irur8M1OfqstoNxeYfOfh0hZ3w9dR0uKMyNNRFkstHWBsFIZMVwMa
         gsd3w8dxLiU6WCfTKltbXX/PO8aFbJ3kKRpzfNa39ibzG2RKDzUsZdoPDkuT+tBgmWAx
         EFXVsYLMBDFioZA3yPr3vpDFrsSQpMxTnjncqlPjWERUxAl6ynf1FOItEGI6U3y33cU4
         MSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FI/7QHfOajTdVOFx3npU5LTfbLBIpMx67ZW4jlbDII4=;
        b=8CU83mYKzXQ/ph7dBwP4KTEh2ZoEMcvNOoaVAZRhGekVf1WEp07Dh/nc2IKYUJIJMI
         korX3qMfQKhIgn654dshoWAwLD6HDRrzysJUMf1sFHQOGoyLhUs0s5raWUm7x/Uu4jYt
         nUoi+6K7qQKvTXvosF8oUSjIJO4LA+xFovYZ3NmOPsnZls4TemRytuIl2y6VGvJ6Ks0c
         AdJqDhF0V5t9aP+lzyDOsD8oy7FkpRqFyGrp77qtr3dcpSdT+/gEQvh8vl8pHQFYFVmn
         DTA2wteH36psjQx8CYKgRsH4WM9uDEN7FSYOYp1FcLWAiQj5Y7XjRlLXVOhBromXz9AP
         ahUA==
X-Gm-Message-State: AFqh2krD+js/8NpXWWEw5L+qVB1fx5EADaKL1VIL1dij32YALnKgcv/9
        UWxIDGujlJ53LhbDHzjgf7FAhQ==
X-Google-Smtp-Source: AMrXdXudwYsveyPqJ9OtE9wMlSXqrSoRIdSLjOph9VCasvn7M5dZ4SWP2QEHTP/JSYo+s0snvLerEA==
X-Received: by 2002:a2e:3211:0:b0:27f:c428:c5ec with SMTP id y17-20020a2e3211000000b0027fc428c5ecmr10757597ljy.28.1672751832263;
        Tue, 03 Jan 2023 05:17:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9d56000000b0027965d3cc9fsm3498226ljj.47.2023.01.03.05.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:17:11 -0800 (PST)
Message-ID: <414b2785-fba0-1426-d059-befeabe9ddac@linaro.org>
Date:   Tue, 3 Jan 2023 14:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
To:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
 <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
 <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
 <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
 <4632f71b-2b67-b634-1cdb-69ac741a8ef0@linaro.org>
 <92347fcb-46b3-d1bf-82f1-960f69300a29@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <92347fcb-46b3-d1bf-82f1-960f69300a29@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 13:45, Claudiu.Beznea@microchip.com wrote:

>>>> Uh, why does it depend? I understood the changset is bisectable and
>>>> removal of unneeded driver will happen later. Otherwise it is not
>>>> bisectable...
>>>
>>> AT91 devices will fail to boot if this patch is applied and 1/3 is not
>>> there. This is because clock framework will disable DDR clocks because
>>> there will be no consumer for them.
>>
>> This I understand, but why do you need this patch to be able to apply
>> 1/3? 
> 
> To avoid having AT91 devices failing to boot in case your tree (containing
> this patch) is merged  first.

But this patch is not going to be merged first. It will wait one more
cycle, so the dependency is there.

If you need to make it in one cycle for some reason, then I would need
stable tag with the clock patch.

Best regards,
Krzysztof

