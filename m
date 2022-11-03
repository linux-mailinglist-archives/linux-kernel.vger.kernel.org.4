Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC8618B85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKCWaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:29:37 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6B23391
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:29:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z6so2160887qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFOxZ2L9iDjGlamIRVaj5OB4U9Nq9AIrRETK9Gxb0MA=;
        b=C2eJ4D13TM4gLwfosSXDaBenjkpGC0gdp7gU+braX8AzYACLUeO79uW/5jmzeKf+14
         nwhJAvcBoJa+rTt69U7m3x+8Bw0HcrXxnDdjmYU+axkiTdxSii8jWY+f+YGl6+A3JPTG
         lRldrmhsL1SU4fFHaOHli3OX9yu0c1rMzJOlqotoPEZLw/AOBZcbwlSzakmABo6WD2Pp
         21RR4y9gUJpzVWQyz2I+tRuX4eBdhDqXHl4AQbGDU+njCug9phCcVZCBCbGs2N9OaQ8U
         LWrGTSFhuxz0sHZCDOKm7GLSl0AqyaB/qCWrm7abrpXA4Dx90H/GgqycZvXoa6kyY/TI
         H2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFOxZ2L9iDjGlamIRVaj5OB4U9Nq9AIrRETK9Gxb0MA=;
        b=yLBpe32x6ruEYLUcOc8z9xKtjEimXLCRpMrVW/gx+lvR+nPlj/RDsGfEVjgmSUNGqT
         OQd12uzgppzPCGu0PZwnu4en1Y50Qh/xVpVWbPc1XkaQBg0GEcDeoxFtGtUiBmC93cNc
         2ltOkA+YTEQSRtX0aWgzZjV8JOIb7RBvRYiXqNomfFvsbbpPxphiYaI1XmNi6oWk/d2I
         wtJUyeSoXq9DVF/WJn/Bmfa3vXeNvi11VgNxPFyA73kH1JkmgmxbMbVgp38d4iTMa31I
         Y+dYp6KfmyiCHF5ndIZfNfxDZ7F38kcsmYrDGuBfgRDN9YLP0NG3Veodd/3hMyWxMT94
         t2Tg==
X-Gm-Message-State: ACrzQf3F47SEGrBHe/+xnRk0CnP0YovGQ6PVo6kHeUz0RIvLBY38FPD3
        3m2dC11C6ExdZTSdcNCZ/foSHA==
X-Google-Smtp-Source: AMsMyM68M2Z8PFL9GK04hin6+rQ5xTzVtX5Wyu38D17D2UjoYrUpznFm6XdE1gdo7KfAjEIQ+ydNoA==
X-Received: by 2002:ac8:6e86:0:b0:3a5:27f8:f3db with SMTP id c6-20020ac86e86000000b003a527f8f3dbmr18716646qtv.97.1667514570558;
        Thu, 03 Nov 2022 15:29:30 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a29c900b006cec8001bf4sm1633961qkp.26.2022.11.03.15.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:29:29 -0700 (PDT)
Message-ID: <d1061af4-cfd6-4c39-e23e-c18d6f2edeea@linaro.org>
Date:   Thu, 3 Nov 2022 18:29:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net, kernel@pengutronix.de,
        Anson.Huang@nxp.com, linux-imx@nxp.com
References: <20221103100358.176099-1-andrej.picej@norik.com>
 <20221103100358.176099-3-andrej.picej@norik.com>
 <166747792333.2121983.3197860057328686578.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166747792333.2121983.3197860057328686578.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 08:35, Rob Herring wrote:
> 
> On Thu, 03 Nov 2022 11:03:57 +0100, Andrej Picej wrote:
>> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
>> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
>> set and the device is put into Suspend-to-Idle mode, the watchdog
>> triggers a reset after 128 seconds.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v3:
>>  - disallow the property for devices which don't support WDW bit
>>    functionality with .yaml DTS allOf:if:then scheme.
>>
>> Changes in v2:
>>  - add a commit message,
>>  - add a list of devices which support this functionality
>> ---
>>  .../bindings/watchdog/fsl-imx-wdt.yaml        | 33 +++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml:71:1: [error] duplication of key "allOf" in mapping (key-duplicates)
> 

You already have there allOf, so:
1. Move the existing allOf *above* unevaluatedProperties:false (like in
example-schema).
2. Drop the quotes around 'watchdog.yaml', when moving.
3. Add your pieces.

All above in one commit.

Best regards,
Krzysztof

