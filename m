Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1206C237B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCTVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCTVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:19:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EC4EFB8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:19:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so52291686edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679347167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=re7TiJqeCbSUaRdCloCtXvztCWbhKAf+laHVsbnE85A=;
        b=OPA0CGlYz6Lx1Z5TkSTqcRfskHhs15sHVyCcD3aoDOm2ayy0QirKlroxrche6VuSRj
         IUJ/1FYHEfKBsUR7hknlHpgNpeFXPtVTBMrZdD3+3FObItuYjXNSXrNj6iECufUtettG
         7lQUM8RitYICzuQcTX6ZMg3WDqgcYm1+Zgq6VeyzHlpmzyN572XbNoAS7n6qLQG0kQVL
         YIbTdjy1bqgiWiiRT1TrjIOMdFogjTvBL1q2l+OIy5aOlwGOGAjnnc45+RdHeRLYHk5v
         rnwKkcrT617o9VK6aN7QRT0KfhHXlU1CkPG5KGcMv5rUYyzICVVckIb410hf5VVWSIzC
         /MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re7TiJqeCbSUaRdCloCtXvztCWbhKAf+laHVsbnE85A=;
        b=X0aXRtuATErJnRCcq2OLrpkLQaYIYgHLOuJm4/amu4vzaRKxcr/Nb1eKt0/hUertbt
         ogUbTHLpFbcRTgt7RyHcJamfVEkAdwEIq4ObglTJXgBQDzt3OOkZdSqGB3+whyVJRgPy
         u2smLYSAA0JjoV48A0nHFsLjTOsVfB9V+QiwqYe6nLlou2l49P/q/e+Mg55ab+VkQPnB
         HSQOrstWsCUC1YX2rAsywHOs+peoNPukOWiNvA3Q80MWV5N+WrNGmarUYM+DhqdjCIyZ
         3H0uXlbCzzhWm4GpbexaVeySHKI0iJYuuk8ZRRIiLZiC+JfxubMnZ20USnI16Mer5aJ1
         JG9g==
X-Gm-Message-State: AO0yUKUMgTK2xw/Kk21MDD2WuMK/M2cxglpkHJTjFmbtAY5YcR+20mtr
        WTw15XY0jVp/tMCjSr+qX7qfOClRxZE=
X-Google-Smtp-Source: AK7set+fgu+fiUg5TbsaAFkrWf+8ogVfbF9xmEoNK/wPpcrtX/1kzhY3Bk1Y6KtgIm0dKqckm9okxw==
X-Received: by 2002:a05:6402:517c:b0:4fb:395a:6aa5 with SMTP id d28-20020a056402517c00b004fb395a6aa5mr946951ede.9.1679347167464;
        Mon, 20 Mar 2023 14:19:27 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b004fb95f51f54sm5368798eda.12.2023.03.20.14.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 14:19:27 -0700 (PDT)
Message-ID: <0bfcb878-1886-b838-cea7-3256d8024ddd@gmail.com>
Date:   Mon, 20 Mar 2023 23:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: most: use inline functions for iface_to_hdm
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
        drv@mailo.com, dave@stgolabs.net, yang.lee@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230320205207.20062-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303202217110.2906@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303202217110.2906@hadrien>
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


On ٢٠‏/٣‏/٢٠٢٣ ٢٣:١٧, Julia Lawall wrote:
> Maybe "define iface_to_hdm as an inline function" would be better.  "use"
> is not very precise.

Okay, I will edit it.


Menna

>
> julia
>
> On Mon, 20 Mar 2023, Menna Mahmoud wrote:
>
>> Convert `iface_to_hdm` macro into a static inline function.
>> it is not great to have macro that use `container_of` macro,
>> because from looking at the definition one cannot tell
>> what type it applies to.
>>
>> One can get the same benefit from an efficiency point of view
>> by making an inline function.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>> change in v2:
>> 	edit subject line.
>> ---
>>   drivers/staging/most/dim2/dim2.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
>> index b8bd01ca1f11..21d1c9f24c3d 100644
>> --- a/drivers/staging/most/dim2/dim2.c
>> +++ b/drivers/staging/most/dim2/dim2.c
>> @@ -108,7 +108,10 @@ struct dim2_platform_data {
>>   	u8 fcnt;
>>   };
>>
>> -#define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
>> +static inline struct dim2_hdm *iface_to_hdm(struct most_interface *iface)
>> +{
>> +	return container_of(iface, struct dim2_hdm, most_iface);
>> +}
>>
>>   /* Macro to identify a network status message */
>>   #define PACKET_IS_NET_INFO(p)  \
>> --
>> 2.34.1
>>
>>
