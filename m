Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3555EF411
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiI2LNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiI2LNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:13:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAA133C8A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:13:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so1711809lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9XLTjcTfR7oKSD6FYuz8rsf9GaidwI4jkeOMp+Vcpgg=;
        b=VILJW6FkPk1WbGBiCV8qFpKI6AtDdxlKMn1nkgynaFiFDYXgYALLkde01boSxSjc9y
         VTtRPBQQuCYc66LY6UTkxgPNNKj1rBPnUmqHtovqRq/zmqOc4TmFThTC63sch0Oi2rQ2
         kC8A98Hih5oPQpZyHRoNTdbdD9tyBEMbsgU+0aMyBeK2PUPsRJy+NDr69LTA9z+jkJ0L
         k319ehu5cXosJQn++rTiqrw2IPS+PpgODfNUbhjuX9XZd1AmsSwcujSjIFjLQzjDZgE5
         XjzssLtQ4wOvCZrxuIq2CY4VM4ahQR+LS9Ksb+c1OWiAvK2jXpeYWTOQAXanUCMbMdEy
         7aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9XLTjcTfR7oKSD6FYuz8rsf9GaidwI4jkeOMp+Vcpgg=;
        b=48ewznhKpkUOXMMrKf8x5K5/tUCwLC5TvLvHr6dy57WYc6MB+CgWaTUJTqE0MOfASr
         75+yPDaNEjOSxrS0dn0mWFOH72schn20iamQPaszIhOUBOzmbx+QbiJYRvbqMpkTzGYm
         zaml4G/kLygLUViGrs+SnrndeCKRbZ3a4jOzAbgzQ3DNY1jXO5wVs0TLUEmOcRXsAd6J
         wUoBR+08IUmS5wHuUcdQc3vkRkW4ADizXoSSa5GuRzYZU0AfZt47narbZTiGw+XV2hiD
         4DSI9t4O/mGLAJaPkDyEPrRuRhvOldfH73/qUA92BMamzmcNA+rKePilg70wGjQJnobp
         J+yg==
X-Gm-Message-State: ACrzQf3G2PGFs9b82an5SNfIAF4IQXIFlkHQG0JggBZylgLEeBCDaIQ/
        51sHL9OSp3Lpf6fKYOLo6aM5qg==
X-Google-Smtp-Source: AMsMyM6Da2z1LE8/N7lc1Nv5jLptMuhM82djEkbuGMvc1Nn6mwOVTPATqxh0opJtTKeFH3DT2jNBgg==
X-Received: by 2002:a05:6512:b17:b0:4a0:13c:9b3f with SMTP id w23-20020a0565120b1700b004a0013c9b3fmr1105109lfu.91.1664449992253;
        Thu, 29 Sep 2022 04:13:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k17-20020ac24f11000000b0048b365176d9sm753425lfr.286.2022.09.29.04.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:13:11 -0700 (PDT)
Message-ID: <059dd56e-d778-5b10-0285-3555ba930410@linaro.org>
Date:   Thu, 29 Sep 2022 13:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
 <CAPDyKFohA9gKu8qwR+YUCy46tepO3k7fQqcHPvjYMznDmckLzg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFohA9gKu8qwR+YUCy46tepO3k7fQqcHPvjYMznDmckLzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 13:04, Ulf Hansson wrote:
>>> So this change will not be backwards compatible with existing DTBs. I
>>> noticed that patch2 updates the DTS files for the arm64 platforms, but
>>> there seems to be some arm32 platforms too. Isn't this going to be a
>>> problem?
>>>
>>
>> The backwards compatibility is actually expressed by the driver. If the
>> driver keeps ABI, we can change bindings so that all DTS are being
>> updated to pass the checks.
> 
> Right.
> 
> So, I should probably have responded to patch3 instead, as backwards
> compatibility doesn't seem to be supported, unless I am mistaken. 

Yes, it looks like

Best regards,
Krzysztof

