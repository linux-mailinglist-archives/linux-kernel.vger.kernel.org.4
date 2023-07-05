Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28622748035
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGEIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGEIzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:55:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81381719
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:55:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99364ae9596so368222866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688547306; x=1691139306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdnXLK7qXLON81pPPrHpzO/9z7s+rm9QJ6FuVbRQdbs=;
        b=bQVOCTRLHSWl3pJ/aG3YOm3LoqJo7lD7UF8wSJdcUBzA8ywgE0ThA+Qi8SM1g3hvWj
         hhmd6nSlFhTugGouHtRnBPXyQcVhXkPtdxwGnvo0foz1ctz5ZYrwTeJncUn4iCMC1gV5
         BdZ4sp8EyYztinmdKrS2ISk7bcr6hh5CvbSmvU26Fves47jjy547Wpj0tUZdLpbTvRpu
         bl1CSqthUc3FXSifcMk8VMmy+3JmquUL/k58DZB251hag4i0v11hSaeNQtxzwIMcRfmA
         I8ui84qB/VmIOwh6ZEtRoCB27JUN72/+eT9MKwl00JxnKS+sCmOVm/R8N/5XPp292rRU
         +NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547306; x=1691139306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdnXLK7qXLON81pPPrHpzO/9z7s+rm9QJ6FuVbRQdbs=;
        b=NU9+y/cijNzkwOZA36PYGikxKYmNiOLO0tUciv4mfTnIv6UUSOPgg5ehYXKbkolTJi
         5Acm3anZCTkhuY5uqUpbNnZ0vAs3IQtL3ud6pdl7A5YU3QpMHXHz3z8uYRUXQP58L/zN
         tUGN50mOqH18KeOvAJ/q8WTxg13QjEAC9d1oTI74kH7wTmnxxnhqc4lcPtIKqUTZkzF1
         tFQMgtVdCQAEzewnbC2ezBHItGd2CivF33f+bWXF97vw8rpU7r9nyMyXKzwkaZTpOs+o
         UxDbccuD4Aa8tVdI5rHQ4m7Ou54RsUOqzlmoxwebQvgOOIA98pbjUMQQBmUJYQG47WQY
         Kwcw==
X-Gm-Message-State: ABy/qLbXrALE88VWNMvCarRvnwJD5cx735B0he5RX1heeHdOgYGexD6D
        sBpIW1FK7grBUqTX/u0C64D3Bw==
X-Google-Smtp-Source: APBJJlF18nZ62Q03EIuvQIs4j7WBKWQva+whWpxRMq7n8XPt8oxM94B6qxAs5mNE01oHizT5YtFx9g==
X-Received: by 2002:a17:906:3bd3:b0:982:870f:9e8f with SMTP id v19-20020a1709063bd300b00982870f9e8fmr10500224ejf.62.1688547306173;
        Wed, 05 Jul 2023 01:55:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7de8d000000b0051a2c7f5b0fsm13076264edv.88.2023.07.05.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:55:05 -0700 (PDT)
Message-ID: <e684d1bc-f2bd-3505-3d8d-cf108e2a1586@linaro.org>
Date:   Wed, 5 Jul 2023 10:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     alim.akhtar@samsung.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628164759.67594-1-dg573847474@gmail.com>
 <b6d3a872-f32e-bfcd-b603-c08339737045@linaro.org>
 <CAAo+4rUzusAyyffkCvEq+wJQacqfrcTx-SviqXaTzPsqOkjB7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAo+4rUzusAyyffkCvEq+wJQacqfrcTx-SviqXaTzPsqOkjB7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 18:10, Chengfeng Ye wrote:
> Hi, Krzysztof
> 
> Thanks for the reply.
> 
>> This interrupt is a threaded interrupt. Therefore the
>> s3c2410wdt_keepalive() will be called again from process thread. Are you
>> sure there is deadlock?
> 
> Is it really that s3c2410wdt_irq is a threaded interrupt? I could be wrong
> but I can
> see that the interrupt is registered via the following code. It is the
> third argument
> of devm_request_irq but not devm_request_threaded_irq or
> request_threaded_irq,
> as far as I know, it should be an interrupt handler for the interrupt line
> wdt_irq
> executed under irq context.
> 
> ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0, pdev->name, pdev);

Yes, you are right.

Best regards,
Krzysztof

