Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252745F9CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJJKbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiJJKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:31:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD5531208
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:31:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id z30so6369171qkz.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VunDyilsBs8iIIuWswAz6kxwpnH9e1owhUViXJTSdw=;
        b=UR6JaJ2c+hSZWdh69lOQMttQ8BgXFKQbmfqKF8ORQXSnzvNclExA3iSS/M+Fhsv2WO
         MDCFbcCj4YlyUFe1ExBMAOasCTnGqnaoc6Kdr+Au5uZCOGre6vhiNn81BupaeMpJhxW7
         bp30bzi/U1psjPWgR5mL9I47iPscm9Nf7gH1m/2jOss3XqAKy73IDrbjHxAt5gy2mits
         nTHX+wrwmmlQ2D+yjxrANENe+iyXfIrlrxmwoySPnBAdoHvlMgfrOmhqpjkUjaKPPX0u
         7m3a7yU5HuxS6zU58dHW5Fu8PE03xA2rHSvphqUUkVF4tKhmLVNI1AoxSECOHZa6UVq8
         Y2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VunDyilsBs8iIIuWswAz6kxwpnH9e1owhUViXJTSdw=;
        b=J7T3XyhxP3w5PBf8F/mLLujK32MqUgwZE2Dm5uffnjBtbTBs+EJ2NknhSI9S6QuCA2
         61TatDY5fqc44tMmnSdRPdX/OCUDbPT7U2/KJdBOJNJ589pxe/zfFAoC3/K7auYQGB+Y
         AzHmjIgxLtfHDnFr8xlTJAEnZCGtL8Lt1vJ01EIGF68UuWw02ut7YAsDwus8ymEgPwCw
         Wxn96REBaLrbMPwrEHbI67M7sNOoum1qhYM5tBMzRjV+S2x2DdhhnnjloPMn8XWQK7tF
         Ed6Css0nwJ1+/lV+R0negE/moXXjzOr6DGPcEI8ASW1wSlci9/fFncLUyJfmBIOrlpyG
         BXAA==
X-Gm-Message-State: ACrzQf2gPfYG2k70nkqZw+010kuHHsqK/oGxDMOA5bIYD1qzA410BB5c
        ElQ8reprBIXyp+x4wXkANSHB1g==
X-Google-Smtp-Source: AMsMyM5J0hXv/spfMvpZyV0JbqF3O9+NYzbLLJpG8PRfXD3fx3TxnGv9PDMltGHGzzQDmqSzg7IwoQ==
X-Received: by 2002:a37:64c9:0:b0:6ed:6530:63e5 with SMTP id y192-20020a3764c9000000b006ed653063e5mr1437865qkb.771.1665397873696;
        Mon, 10 Oct 2022 03:31:13 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id k23-20020ac84757000000b0035d474fd797sm8187666qtp.23.2022.10.10.03.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:31:13 -0700 (PDT)
Message-ID: <6d1aad81-97ee-8a95-5c09-9f23e638c5fb@linaro.org>
Date:   Mon, 10 Oct 2022 06:29:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/8] dt-bindings: iio: addac: adi,ad74413r: use
 spi-peripheral-props.yaml
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <166497632690.3268685.6335632613671776795.robh@kernel.org>
 <20221009171605.12017856@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221009171605.12017856@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 12:16, Jonathan Cameron wrote:
> On Wed, 5 Oct 2022 08:25:27 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Tue, 04 Oct 2022 13:56:35 +0200, Krzysztof Kozlowski wrote:
>>> Reference the spi-peripheral-props.yaml schema to allow using all
>>> properties typical for SPI-connected devices, even these which device
>>> bindings author did not tried yet.
>>>
>>> While changing additionalProperties->unevaluatedProperties, put it in
>>> typical place, just before example DTS.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml        | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>   
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Series applied,.
> 
> Kryzsztof, thanks for your continuing work to clean this stuff up.
> One small request for future similar series. Please add a cover
> letter with a very minimal intro. If nothing else it gives me an
> obviously place to reply to in order to say I applied them all!
> 
> Also works for anyone who wants to give series wide tags.

Sure!

Best regards,
Krzysztof

