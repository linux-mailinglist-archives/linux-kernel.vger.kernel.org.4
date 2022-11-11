Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355C625557
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKKIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiKKIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:31:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F67C8D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:31:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so2547253wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILQKPbjyWoRxHDAqSBL6QoJBaVHzXKbksM3KezorxPM=;
        b=e5FxWUo0+SMymkxP1MLNhjSp9cJdwZ7MeUMHkMKh63YNS5+AdO8Udkzgi9LsuyZnvR
         bK+Ut6bfeRkUyIP0mIDGF5G3XRqUlJCeXsmGxdEigqWNGxg1awwuJXgogY/FvHOQNAkT
         IlisjD6vbInlJSgvgf6H0itnPwJGTw4wJnNRyFQXCCNGa9hO0cbkeF2nVYdwyboJt9gH
         vjmryJtc+BnzZ6z/PMNi/HWGysN3OHKrcYqnpR2VDMFOHdXbNf3hT3NdvB/rdU32qreD
         TFMxIJmIFZo0J6/d0IifY41aWugbFZb6WQ/yAMdBPDojJU48fQFH17c1ho2KdAh4fvFK
         SUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILQKPbjyWoRxHDAqSBL6QoJBaVHzXKbksM3KezorxPM=;
        b=q57u6H8+NOeKzFGXTY+LoZRmkV5yyeq6l3PUfTLp5Ft0JnB8kSVPf7wV3g7HB5wgEW
         6RUhOjWzIcOCvF+fKiLJwr1Wmw36D5Y2M3+DbDxPnf+ZZpqwnxz47q7KfLnbHskElca0
         +27phDRVmTaE1LY2tOVGkyiAA1ikARix3p45fna25AngFlbJ+alfe9GQ6wZ5ealN62c7
         WAr8lkbQW2FJAxDn3wSIBt4v9VUKKMF1e2TckVhSJkVaUF6rltIuGC4R/9NFbfjaJST/
         kPh9wH8Lkb5UVp+LHWpos2zUTEwebSGR6rwgCwydtEs7BAdyAQtZi5/bBFvqb2t/fqxO
         azzw==
X-Gm-Message-State: ANoB5pmgd+OWc3WxuSYg1zz1iLlFJkvf53fRasNWRXXhtMuANztoOR5v
        rlacK0tUQXOR/IvMxoKRDH8=
X-Google-Smtp-Source: AA0mqf4JkVa8kzZkdsc/bnynW+tiN56YWEa1BtHBq+7CkAFwiL9Bzu5gmXucv0j0YY2W/W3ccnCj/g==
X-Received: by 2002:a7b:c447:0:b0:3a5:f600:502e with SMTP id l7-20020a7bc447000000b003a5f600502emr501296wmi.39.1668155477990;
        Fri, 11 Nov 2022 00:31:17 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003c71358a42dsm10048391wms.18.2022.11.11.00.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:31:16 -0800 (PST)
Message-ID: <465810f6-98f0-4125-179d-dd484e5ac09d@gmail.com>
Date:   Fri, 11 Nov 2022 09:31:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] soc: mediatek: Add deprecated compatible to mmsys
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221110120222.32297-1-matthias.bgg@kernel.org>
 <eae90e1e-408b-4f9a-9211-649da28b0358@collabora.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <eae90e1e-408b-4f9a-9211-649da28b0358@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 16:03, AngeloGioacchino Del Regno wrote:
> Il 10/11/22 13:02, matthias.bgg@kernel.org ha scritto:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> For backward compatibility we add the deprecated compatible.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Hello Matthias,
> 
> You forgot to advertise that this commit depends on [1]... and I'm afraid
> that you have to push a v2 anyway, because...
> 

Well yes I based it against mediateks for-next branch, sorry for the confusion.

>> ---
>>   drivers/soc/mediatek/mtk-mmsys.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
>> index ba2e79b26993b..47106f557c574 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>> @@ -303,6 +303,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>>           .compatible = "mediatek,mt8192-mmsys",
>>           .data = &mt8192_mmsys_driver_data,
>>       },
>> +    {    /* deprecated compatible */
>> +        .compatible = "mediatek,mt8195-mmsys",
>> +        .data = &mt8195_mmsys_match_data,
> 
> ...mt8195_mmsys_match_data doesn't exist anymore after [1], so this should be
> 
>          .data = &mt8195_vdosys0_driver_data,
> 

Of course, should have compile tested at least. /o\

Regards,
Matthias

> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
> 
> Cheers,
> Angelo
> 
