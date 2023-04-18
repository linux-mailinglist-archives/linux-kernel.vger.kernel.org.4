Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8B6E656D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjDRNHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjDRNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:07:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A4EE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:07:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so1904020a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681823261; x=1684415261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AOLhJAEQTI21tHDt5iL3GpDHZ2TzKg+M92LI2cgLe4=;
        b=roRqrhX9frNPq6BXAhUQix8S8kdfvO1UYwf6muNZatuo5DwUz3dE2Jy60Rv2u3o9JK
         2GyOsAE2lJgyJeNvsEDwSKW1rJT4Vq7CDkX8HiCjeI9pPwXFB9nojFLgmruqd05+dc+n
         mzs1MwGHqnTI7+w8VjynzB8CxQ/E5s/kC5KFEmoYQO5z/zhsYnkuUTPT9ITqfdnAzror
         KLvXKHOdZpI1/3pqzNc9ATApeB5798fr/v9WyvayRZ5OUYYi1ol0dnkhY5enuKC2fXfj
         lVenCj9bY7VW2kwqcffrNI22GkC9kfOJjeCaqHm02nMo8fUQKzAAMcvJOFKDLY9mNGED
         E2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823261; x=1684415261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AOLhJAEQTI21tHDt5iL3GpDHZ2TzKg+M92LI2cgLe4=;
        b=JWSDfbV4Wsz425hCPV1QNU1FDyPD+Bjg9nKy3p2F0/RU6WFlukMPQWXgMrqG5UP0Tf
         sBnp7icRB8lvv9TXe9PACArrJBtNo8ImF5fn4eedZAiLw6W3zFZTxqur3xDKT01TRJrp
         hc+2ibBAqjf3RTvMEsbLkrpKzZR8ZDheU01+j2yBgD8i3KYVSsrW+nzVzJITm81M4TQR
         S7l+ubwRB/N2k4eXYbkvhfBURDBaL7EpAFizlU0pgvPzgEHN98kcxHaUydOPwd4KzfKl
         9X4wNJj/jjg/QPtrmGaOydTzvn8JBVIlHeuppMfdvLetuBsiCcAfB7736Ppz4OZEEMtm
         TgOw==
X-Gm-Message-State: AAQBX9fKAV9rD5SEeo7Sym5D8RPk1f1+GjDka9lmMy18jccuVm9xZJ3R
        a9hfX5nWOvhEyr3T/Ai3T0fP4g==
X-Google-Smtp-Source: AKy350a2DhZtENu9a+/b5zp2KWG6AtoXMkc+JM6QjLKZm7ZsfHEa6GZ+N+9uPzcHN3EO2/CzFOoJ4g==
X-Received: by 2002:a05:6402:518c:b0:506:bbf8:5152 with SMTP id q12-20020a056402518c00b00506bbf85152mr2280249edd.9.1681823261597;
        Tue, 18 Apr 2023 06:07:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cb87000000b0050687ca0c92sm5156757edt.84.2023.04.18.06.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:07:41 -0700 (PDT)
Message-ID: <ff0f4871-4d26-e671-0239-fa47117381a0@linaro.org>
Date:   Tue, 18 Apr 2023 15:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
 <63a3b1c7-a68a-496c-99fe-9c936f4ebd94@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63a3b1c7-a68a-496c-99fe-9c936f4ebd94@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 14:55, Mark Brown wrote:
> On Tue, Apr 18, 2023 at 09:46:27AM +0200, Krzysztof Kozlowski wrote:
>> Replace dev_err() in probe() path with dev_err_probe() to:
>> 1. Make code a bit simpler and easier to read,
>> 2. Do not print messages on deferred probe.
> 
>>  	 */
>>  	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
>> -	if (wcd->intr1 < 0) {
>> -		if (wcd->intr1 != -EPROBE_DEFER)
>> -			dev_err(wcd->dev, "Unable to configure IRQ\n");
>> -
>> -		return wcd->intr1;
> 
> This is already not printing a message on deferred probe.

True, but the other places in the patch don't have such condition.

Best regards,
Krzysztof

