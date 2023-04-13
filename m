Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69CE6E0A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDMJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:37:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7F83FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:37:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s2so10292961wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378651; x=1683970651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qmRsOqjOUeFEAObOHM4G+xJcIEgvL4vfHkv/prXzOo=;
        b=WZhODdmsBmq0DDpYW5QhnP8UogRsjl3uxILhG7rzMdzvOaPrFt9vMZ/l05hsyRcjsM
         g41zMBTGZvqX7hyFGIFDenwO5z7v6pE++aQthO0EU4G1d2GzJvpABGSLqurZuS+3ExdT
         +rGiJF1aN3cZsb5JYgJhgTqhl70ZXt4zyrCoUmp+5vhTohyftdzsSp9ycF6sKoRDHkSF
         3VQvFTlsH/FbG+nZtuUL+KfSGXSOv7aNO3kcZvCGmBBqkFJN5iGPCQS+mfKa5/6mZjuX
         Jx2orYPy+oK4nCygJeIoTB60mGh/uxV3t21CAVkQWiDqEu8AtMYIwFmZDcn9TOw51VaN
         RSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378651; x=1683970651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qmRsOqjOUeFEAObOHM4G+xJcIEgvL4vfHkv/prXzOo=;
        b=gS1SguBxzzAYU4LtK0Pum1kdTs7pwY54klZ7kQo3AYI1rX6i7zL+eYj09+1weRCSeM
         bz04z5Dl2GeS242FDeYrLXAzsfoR1GNQi/yVDQxuICyw3oERDyQ0vC9TcMxGCQxbjr9u
         prWUXitj0iAKVWEfPMU0iVAEh8krzmdF06/lqcW4zuRNIRX2UcwotULLf4yt8Q5ZinXd
         /5u7JWMkXYRRumu0UtK4wTn163DuH8GpoXeeVIeXhGZy9I8bIDCLh2j4k70/Y8qmXfba
         0V+rEFcOEm5K7x5jBvLtGkWXQLaNiWu7nv9kiVjebQUKh7O7eXH7DgKLe6RaklXd9izn
         5gSQ==
X-Gm-Message-State: AAQBX9d+dPzGHc94z/ZVx040SHBxpo4vdsjzCJDXbjIpGg9t8+7YxmdV
        cfmeXK33c0BEv84b3+3nfvIBMUyTt6gOig==
X-Google-Smtp-Source: AKy350Zm5/ATFD50uFkvJSI4h7GVs83srZ2sleq5RncSnBnC4X7VSxN0NN70mOhkcAIMMl0GJDBRIg==
X-Received: by 2002:a5d:55cf:0:b0:2f5:aadb:4642 with SMTP id i15-20020a5d55cf000000b002f5aadb4642mr945310wrw.41.1681378650844;
        Thu, 13 Apr 2023 02:37:30 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b002e5ff05765esm883268wru.73.2023.04.13.02.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:37:29 -0700 (PDT)
Message-ID: <a311d52c-a07a-fdfe-5b48-502d05f70737@gmail.com>
Date:   Thu, 13 Apr 2023 11:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: mediatek: mtk-svs: change the function
 IS_ERR_OR_NULL() to IS_ERR()
Content-Language: en-US
To:     =?UTF-8?B?5YiY57Sr55C0?= <ziqin_l@hust.edu.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230406024200.3126080-1-ziqin_l@hust.edu.cn>
 <1b48b0ec.3b004.1877971d059.Coremail.ziqin_l@hust.edu.cn>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1b48b0ec.3b004.1877971d059.Coremail.ziqin_l@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2023 09:08, 刘紫琴 wrote:
> ping?
> 

Please be patient, maintainers are sometimes busy and can't cope with all the 
patches at a time.

Please don't top post :)

This was already fixed and applied to linux-next via
https://lore.kernel.org/all/20230202124104.16504-2-roger.lu@mediatek.com/

Best regards,
Matthias

> "Ziqin Liu" <ziqin_l@hust.edu.cn>写道：
>> nvmem_cell_get() will return an ERR_PTR() on error or a valid pointer to a
>> struct nvmem_cell but won't return NULL, the check function should be
>> IS_ERR() instead of IS_ERR_OR_NULL()
>>
>> Signed-off-by: Ziqin Liu <ziqin_l@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   drivers/soc/mediatek/mtk-svs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>> index a7eb019b5157..8127fb6d587b 100644
>> --- a/drivers/soc/mediatek/mtk-svs.c
>> +++ b/drivers/soc/mediatek/mtk-svs.c
>> @@ -1726,7 +1726,7 @@ static int svs_get_efuse_data(struct svs_platform *svsp,
>>   	struct nvmem_cell *cell;
>>   
>>   	cell = nvmem_cell_get(svsp->dev, nvmem_cell_name);
>> -	if (IS_ERR_OR_NULL(cell)) {
>> +	if (IS_ERR(cell)) {
>>   		dev_err(svsp->dev, "no \"%s\"? %ld\n",
>>   			nvmem_cell_name, PTR_ERR(cell));
>>   		return PTR_ERR(cell);
>> -- 
>> 2.25.1
