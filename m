Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480670190B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjEMSL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjEMSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:11:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5815FD0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:10:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965e4be7541so1911424366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684001442; x=1686593442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asRLFK82ncBJ7EVq/Dhl1nUHlScwu3SdKHKnttIsNYI=;
        b=XmRywTsS7onQO/3tHnBX2wyc89syRYvSX+xFqr275wpbwv8IZEPbyhhRURubwBpqXV
         4HEo8lvd3EASN8hUPKSGQTP2O4D1zrkCdrMgC2UsnnHjvm26LVb5a5c4R/1VVBd01RLQ
         6npHwWs4GWuRUY9DvCHoSqy0tXqD2bGwhVbjjNsjd1/HZNXdGquihPBZdD6akmkywnIN
         GeXA+jg3ikKDwAD90Ldg1axNDQhnxsZcSsQGW3fFtXUB2rDGHcia4ig+XyJP8MWKjMrx
         DO8UibPa/n7WWcqN8RfZ6vU7w8MFqc8hHUY0AHgJcy7bn9FvFzCdRY4poufUHdc92sF7
         x8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001442; x=1686593442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asRLFK82ncBJ7EVq/Dhl1nUHlScwu3SdKHKnttIsNYI=;
        b=InOin6QeC8TfHQsFHx8AiS6AiHT6jjFkaMSEdkXdB1H3NfD9n7u1+IOeJeZOliGMHA
         gRKKax5vn/5E9BatLIP5V4rXoARo03lJW6u9Rhv5IQB8OdcpW6VyfniI7ogpfcEmNhWK
         D9McvX+fPSb/1CA1fkJUkSTG2wDvQ4QZB6DG5aa9rr9ZBkP8Hv5fSivY9CDBiys0kUJ5
         ZugdioRpBgqlbQbWS+YPt90URlTiyI4pHkOBG/Vy+2SdGobgD+o+jLnML/mSFeRCqtSH
         8DG4UPtL1PeLTWUKsq+J3FWHiMAN2+DJKevaLH8AXRJENDkP4DVy0+68wh2zA43Ez9x6
         CIRw==
X-Gm-Message-State: AC+VfDzEq4ChVXqggQzmf5QRhbs+YEEVZy/NtA/ibVVVnZwO9gQPoYN9
        C9jfqU3JpiMIfEOvekNEFTgipQ==
X-Google-Smtp-Source: ACHHUZ4PSooit252IModjMMxOmb6oJFwPUivZyt7UuYW0HsmJinDs36UhBfIbLv1Q09qUZG09GYEdg==
X-Received: by 2002:a17:907:360a:b0:960:7643:c973 with SMTP id bk10-20020a170907360a00b009607643c973mr24289620ejc.66.1684001441875;
        Sat, 13 May 2023 11:10:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id k10-20020a1709063fca00b00965f4171642sm6908597ejj.125.2023.05.13.11.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:10:41 -0700 (PDT)
Message-ID: <b179185a-0aa8-e58c-4fe0-4b83396ef30e@linaro.org>
Date:   Sat, 13 May 2023 20:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: iio: st,lsm6dsx: reference common schema
 for mount-matrix
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
 <20230507-brutishly-underhand-48c2949eb46c@spud>
 <20230513191355.28cdbb23@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513191355.28cdbb23@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 20:13, Jonathan Cameron wrote:
> On Sun, 7 May 2023 22:06:56 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Sun, May 07, 2023 at 07:39:21PM +0200, Krzysztof Kozlowski wrote:
>>> Reference iio.yaml schema from dtschema to allow already used
>>> mount-matrix property:
>>>
>>>   msm8953-xiaomi-daisy.dtb: imu@6a: Unevaluated properties are not allowed ('mount-matrix' was unexpected)
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Thanks,
>> Conor.
> 
> Krzysztof,
> 
> These look fine to me, but I guess I should wait for the
> dt-schema patch to land before taking them?

You can grab first patch independently. #2 and #3 should indeed wait a
bit for Rob's ack. They do not have any conflicts but they will fix
nothing without dtschema patch.

Best regards,
Krzysztof

