Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF847734C04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFSHAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFSHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:00:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740BC1AA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:00:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-985b04c47c3so439496666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687158037; x=1689750037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMrqhOmlYjr3CsiKOPMApGZVFUdNvXXzMH8RRQR9SBo=;
        b=gRNXmtBtp53/JI1qbjCmW/EGDGt/iMPRvcxCm+fL38zqAjrb8riGH6SdDR8ZFXh8+s
         +g9KmmTgErl4NyhYnvAJ226EPktiSPSNPH7DgA7kF3zHw/4mYC/6TQzgP1Xg8FLKtkkD
         CmIj6nnjemehAP5fQhc26wYEzk+3X+5wS5D2qokJe4LU4XJ9go+craozn7QkmOur458L
         pKkVcsO2B6m7Ojk8m+pldwODYC9bdtqPhe1Q1AzT7Pn6IMCqvQxTlD9wONR3f/NJh755
         YyYBEAbG3xw+wjm+Vr1yFatM+lXblh+gTB4hbpQwVDZMtEo0guLFiV35VtZczPcmNRi5
         zO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687158037; x=1689750037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMrqhOmlYjr3CsiKOPMApGZVFUdNvXXzMH8RRQR9SBo=;
        b=k/EGzJAF8SXxRIc9TUGWAl8GNiE6sIy12yio3uz8ZMMhZxWTL2S8WDUuryiQ4tpsaH
         gItJ/gSPsagydcqf/IvctBdpjkBXYKop1HclJeyhvykIZehL3/+9s44ojdqr/OIwRd9V
         K3m9mFdy6RYU20xclo1spySQE4tkUeq216BfvAzjF7HJ06Z9l11WMaunttHsphe5CXNd
         +/qmOPCCVKZVZ8SqOZqBM6nZMSMJwuZFyENkPCcKFmkqyuR7SSgYD73X9M7GOA09AMMY
         Dd0BH9uplha1kxtSCHQuJ+QqqqVTgBrFvxaQ+bc0XqIVnB9GWLE4mh9nEYt8s/szchib
         v9Ew==
X-Gm-Message-State: AC+VfDzabLrYBrnINotZn0prUVT3YL2FXPZnJxZLzxPezc5WYYOqev0n
        kvy/YX5Z/N56uMz9X48DhbIB0w==
X-Google-Smtp-Source: ACHHUZ6AlPAXtrfg+1lhoD+C0v75gcko1YN92wwqTA01JUafHGUycqGUdXE3+R8QqBTqZqCD1FCjBg==
X-Received: by 2002:a17:907:7243:b0:986:3783:2949 with SMTP id ds3-20020a170907724300b0098637832949mr8506222ejc.52.1687158036982;
        Mon, 19 Jun 2023 00:00:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n25-20020a05640206d900b0051a594b4eb2sm1103917edy.60.2023.06.19.00.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 00:00:36 -0700 (PDT)
Message-ID: <bd4da934-72b7-67f3-0c9c-c18d3af16e7d@linaro.org>
Date:   Mon, 19 Jun 2023 09:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
Content-Language: en-US
To:     Yingkun Meng <mengyingkun@loongson.cn>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
 <6901166d-387f-24de-6ffd-1c8eea724718@oracle.com>
 <325dd825-6fa5-0ebc-4b7e-7acf2d2840e4@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <325dd825-6fa5-0ebc-4b7e-7acf2d2840e4@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 03:45, Yingkun Meng wrote:
>>>> +    tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
>>>
>>> Smatch detects that tx_data->irq and rx_data->irq are of type 
>>> u32(unsigned) so they can never be negative.
>>>
>>>> +    if (tx_data->irq < 0) {
>>>              ^^^^^^^^ This can never be true.
>>>
>>> Should irq be of type 'int' instead?
>>>
>>>> +        dev_err(&pdev->dev, "dma tx irq invalid\n");
>>>> +        return tx_data->irq;
>>>> +    }
>>>> +
>>>> +    rx_data->irq = fwnode_irq_get_byname(fwnode, "rx");
>>>> +    if (rx_data->irq < 0) {
>>>              ^^^ Same problem here.
>>>
>>> Should irq
>>
>> Should 'irq' be of type int instead?
>>
>> As fwnode_irq_get_byname() returns a integer.
>>
> Yes, you are right. I will add a patch to fix the type of 'irq' to int.

Run smatch and sparse on your code before posting. It would find such
trivial mistakes.

Best regards,
Krzysztof

