Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA98F72AAF0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjFJKqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFJKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:45:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5535B6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 03:45:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-973f78329e3so456839466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686393956; x=1688985956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LaTb7IRBsiBRAwbYmjK10xmwfQeiAbbyjzsoHkO+VA=;
        b=GkqBClImyWom1VH+TSEdCIwsV0sUVIO77EO//nMDnICJaSUrrw8OCMioHFzfZO7722
         U69zcii6U50Oa7vFE57feiUXsDU28aHWILJshAx4QCkpJNdUxuzOX1nmg1JahmGtsfEX
         3SsmZpUZ2VdIyHgQw9lee9l37jyE8rJRgxieeyS5PGqlKb8Z8zHJfKvMK5nvPN9XuG73
         7H/D8RBVqv/91Ln/++kCHAdVaNd29h+I+4yaE8CleAz86aChenT7aWRyXQCNPZhDXZyz
         mphjlMMQtdEIXP5jzZXfl12KCduLXXiaq7AmkiDRxtYx22KPAIIghCVpwc3k5nCij/L1
         nV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686393956; x=1688985956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LaTb7IRBsiBRAwbYmjK10xmwfQeiAbbyjzsoHkO+VA=;
        b=Z7mVYPVNi/fJNbnji6oJl3dwpf+ZhDwBK9Bd4HG0KNPTyU1C8u4eGenJpwOPWbatR/
         jrMizng3TLNFeByQxA7IL/6MvYZ4hHUv0lQvKaiKxVEgRf4epIid5OTBgJIzueKdKNsX
         Iq3BxUacyZYxl1K4DXlNNuBKnfY4E0aLz9PX5wkrY0hqzaIk6L30hpsrCMs23Yjd8B0T
         lIfpocODFrdTiATF6tGr6Ug4UcohbOCiYiet6gkMOPWhHxp4rq8aEH81qJ5k+RTFN3cE
         KTO5g6H1r0rUt7fSTBnYxQiWC2yShfCXmrqROnZhDAGLBbCHVDZv3QZeU3WwVGZY7yUb
         0ZCA==
X-Gm-Message-State: AC+VfDyOJ+UTer4OSSKnjalaiy+PAmqQmJnagWfoIO5zSrWs0H28srEc
        MpePzrPOlubAWJlz/IpK+vbgxA==
X-Google-Smtp-Source: ACHHUZ5eqVHmQLyBpqFQRRPJI3XqVCPp7uGWNmJoXDK0Wc32tAm6CBS01HtR7+YKKBHkdtSxL5EKBQ==
X-Received: by 2002:a17:907:320e:b0:974:b15:fce5 with SMTP id xg14-20020a170907320e00b009740b15fce5mr4690577ejb.38.1686393955821;
        Sat, 10 Jun 2023 03:45:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906684b00b0096a91ab434fsm2407900ejs.40.2023.06.10.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 03:45:55 -0700 (PDT)
Message-ID: <d86a0c13-f2c1-2595-adac-71c8c6452a89@linaro.org>
Date:   Sat, 10 Jun 2023 12:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610103958.jwfe45zm52ehiovn@intel.intel>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610103958.jwfe45zm52ehiovn@intel.intel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 12:39, Andi Shyti wrote:
> Hi Christophe,
> 
> On Fri, Jun 09, 2023 at 06:45:39AM +0200, Christophe JAILLET wrote:
>> When the best clk is searched, we iterate over all possible clk.
>>
>> If we find a better match, the previous one, if any, needs to be freed.
>> If a better match has already been found, we still need to free the new
>> one, otherwise it leaks.
>>
>> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative. Review with care.
>>
>> I think that some clk_put() are also missing somewhere else in the driver
>> but won't be able to investigate further.
>> ---
>>  drivers/tty/serial/samsung_tty.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index dd751e7010e3..c07877dd25fa 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>  			calc_deviation = -calc_deviation;
>>  
>>  		if (calc_deviation < deviation) {
>> +			/*
>> +			 * If we find a better clk, release the previous one, if
>> +			 * any.
>> +			 */
>> +			if (!IS_ERR(*best_clk))
> 
> what is the case when *best_clk has an error in it?

The initial one? Open the place where the function is being called.

Best regards,
Krzysztof

