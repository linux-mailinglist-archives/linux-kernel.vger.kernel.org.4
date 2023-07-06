Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0274955A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjGFGJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjGFGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:09:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B961BF2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:08:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so504279a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688623684; x=1691215684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7nLQR/B3UQbt+9uJMAZJaX6K0uXW7cxqOcVTi+nmsg=;
        b=ZUKbME848xiV2hktdav+CO31kzq1MxpYSRjHlbmGTy7PBC9j30cY//SQZEm5FrXI0P
         xSRk50aUQ0CnfXXy6O6S6z6T2LNIVIYwb2I4iwwZmHZbtgZFXpD2N9QOfSqDp/GbI2Hk
         YAQdq+vjLAG9dz/oC21JBMx80qUiw9KBedwJK/rer/IlPSBLsiAliLQjKSGfgTh5lO7z
         tA1DNyXmETftvdu9kmXKLPIDEyBJ5/NFBtVOKsYS6iDzG+0n/aNQ2Gi5YVDEIN652OVQ
         hyPP9aRVTJpByJt5QExCPE6KYnaHGV3Dp/KsnsNAuhDeoQ/tmZStlWx3/nPA8drurazx
         03lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623684; x=1691215684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7nLQR/B3UQbt+9uJMAZJaX6K0uXW7cxqOcVTi+nmsg=;
        b=azoBIdC+1RTiH1Vou5Lmymo00jvManBBj+L1dDWZYOKdj0fMYSVTxENWMGUSXg+t82
         YQkqASlHp5U5zM5hXyn0WD4Fx6YvD/k1IgJnu0QVCClRju0ZsT5oIf3L8hMeGHUe/+3Z
         RUeGcg3QVPdEqchUeAw8dazFfhMojlzvS9JxTZuJf5qTIRr7lI0dDFfeOPthhQtmwq0c
         +/BiX6skZO+bSJ910xozdMWalYRxgTZ9476E9dmwJYDKKwu7CXXED5NRbAwyvmSmvW6z
         WDkkv34sf5CSREayyoCVcORT1NvOwp2nqf4IAjdVPhabb9MAjDx/Y9S19IZmhmTle7Q6
         cWRQ==
X-Gm-Message-State: ABy/qLbgTdqTBo/NW3li+4YCcCL7+J1svq5NBKTyQPxhhZ2QO91I6mZt
        l3SZcGFo9k2A1FhxMWOEBEAF/w==
X-Google-Smtp-Source: APBJJlFDMJFx306FrGg5ohS3BhEzDqr0yb6OoJZbHqbX+RnUydpRx11+NP5dFtOybSs3/zqB/5U5Cw==
X-Received: by 2002:a17:906:212:b0:992:a31f:f584 with SMTP id 18-20020a170906021200b00992a31ff584mr670671ejd.31.1688623684073;
        Wed, 05 Jul 2023 23:08:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709064a8b00b00992dcae806bsm368577eju.5.2023.07.05.23.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:08:03 -0700 (PDT)
Message-ID: <7a08dcf4-e6d4-ef60-48d2-81275a7d7a6e@linaro.org>
Date:   Thu, 6 Jul 2023 08:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
Content-Language: en-US
To:     Valentin CARON <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230627123906.147029-1-valentin.caron@foss.st.com>
 <0815474b-a8fa-f486-fc6e-a85df88ed9b9@linaro.org>
 <c232e3f1-b703-d8d2-7e2d-19ed3f5fc3ad@foss.st.com>
 <79505e19-c5ee-36ee-c8ae-344c15f8b108@linaro.org>
 <ec4f025e-680f-2145-7ca8-1ee6b38baa43@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec4f025e-680f-2145-7ca8-1ee6b38baa43@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 19:16, Valentin CARON wrote:
> Hi, Krzysztof
> 
> On 7/1/23 10:09, Krzysztof Kozlowski wrote:
>> On 28/06/2023 18:21, Valentin CARON wrote:
>>> Hi,
>>>
>>> On 6/27/23 15:39, Krzysztof Kozlowski wrote:
>>>> On 27/06/2023 14:39, Valentin Caron wrote:
>>>>> STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
>>>>> Stop probing if this case happens, and print an error with involved
>>>>> compatible.
>>>>>
>>>> ...
>>>>
>>>>>    
>>>>>    static const struct of_device_id stm32_spi_of_match[] = {
>>>>> @@ -1798,8 +1802,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
>>>>>    	struct device_node *np = pdev->dev.of_node;
>>>>>    	bool device_mode;
>>>>>    	int ret;
>>>>> +	const char *compatible =
>>>>> +		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev)->compatible;
>>>> The goal was to replace it, so drop it.
>>> Is is still needed for dev_err, so I can't
>> Why do you need it for dev_err? Isn't it entirely redundant?
>>
>> Best regards,
>> Krzysztof
>>
> Only to have a clearer error message. To let know to user that spi 
> device is not available on this device.

It's obvious from the probe error.

> Right now, there is only one compatible where spi device can't be 
> enable. So I could use a static message. But this is not the best if a 
> new compatible is added.

It does not make sense. Compatible changes here nothing. It does not
matter whether your driver supports one or two devices. Not mentioning
that errors are printed with device ID.

Drop this code, it's entirely useless.

Best regards,
Krzysztof

