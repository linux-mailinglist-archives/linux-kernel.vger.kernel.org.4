Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC16C1FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCTSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjCTSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:34:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B83E3BC59
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:26:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so50336922edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ke5Pvg/9Rb8NrDFmi8QzBDeEQQqLN9WRKIG9dOyYDRU=;
        b=MxXJK3tBhvSIhlqyvZ10EOx5Dg9FRFzDR3XIrL2SkBQoMWlC21hgWdL6/+Aqp1wvER
         Hsen1NCwT0d7KB3yOWczmJxsYua8deLqf1I2MtCodajd5TkdM1QHVLpbg9YFx6wX3g3T
         or0sMq2FVtfoShbTHd+MSvkZkTzjkmQ+WpGHQ15S0xWOnb0JA769RxiC8f5NRfgsFZQQ
         hkxulEWcWn2MJv3mgn7IoFOoBN0r7j5ZwAYKoltLhlxO7YQKhxgP4hKcMbUbZ6yuFDvF
         8QDLYeaxgX6XotBmV4CVAFJX7dYsy/HIvOWiaLsZVfLr72wBbYtPvgVMzoGi9EvV68v6
         KmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ke5Pvg/9Rb8NrDFmi8QzBDeEQQqLN9WRKIG9dOyYDRU=;
        b=MhIZUCoGBjIVM/N+t4Y34/dBMt5vugRg5nJ1bDyiH9ipSa4m5Rgxtg7TyPgtyS3qds
         Ch37UthKevp/QK9z0cvd0Z7SgUK/HzOl62wp5VxzBmko5TkQCzs8zLPho7/yZt81UPx9
         oKaj8mgkBHt7LzD6Hia2GDqyxK4Bqbm1pnWZa0jAJsaO3PhQD6qzlC20Qsfz0I1O0voN
         Tn0eEF5meii0dPabwZ9So+gG5pyP2jZwPQE5zsVpgXjomx95f969dzluj21Yija6kSW7
         0J4OxhV9vIdoM6uvQbXLIMm2gpEvxzzQGXErxjCXzRMkSOYNV4n7Y7wY2eE5hTnyPNF1
         YA6A==
X-Gm-Message-State: AO0yUKUto3FsjpDhmYMMg99jDJ8VaYOAMX0+NRiM++RyIQdj59dy3U1l
        b0UUvuHCJ86vJ/AENT25pV/MwlXu43I=
X-Google-Smtp-Source: AK7set+lohy4Wja2XvtAg6ZPuHkUKL2VoCJocj7y2VARevzarO6pMjMjX3cmg6W8EFxk0PwMG72jmQ==
X-Received: by 2002:a17:906:7043:b0:92a:11be:1a40 with SMTP id r3-20020a170906704300b0092a11be1a40mr9276452ejj.11.1679336785053;
        Mon, 20 Mar 2023 11:26:25 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id d14-20020a1709064c4e00b009336df45226sm2354245ejw.64.2023.03.20.11.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:26:24 -0700 (PDT)
Message-ID: <d0ba154b-c975-574e-657e-c9c7098231af@gmail.com>
Date:   Mon, 20 Mar 2023 20:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: most: use inline functions for iface_to_hdm
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, parthiban.veerasooran@microchip.com,
        christian.gromm@microchip.com, drv@mailo.com, dave@stgolabs.net,
        yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
References: <20230320103335.6479-1-eng.mennamahmoud.mm@gmail.com>
 <ZBh/Yw49fubf1GDb@kroah.com>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <ZBh/Yw49fubf1GDb@kroah.com>
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


On ٢٠‏/٣‏/٢٠٢٣ ١٧:٤٤, Greg KH wrote:
> On Mon, Mar 20, 2023 at 12:33:35PM +0200, Menna Mahmoud wrote:
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
>>   drivers/staging/most/dim2/dim2.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> Your subject line has a "  " when it should have just a " " :(
I see, I will fix it.
>
> Please fix up and send a v2.
I will.
>
> thanks,
>
> greg k-h

Thanks,

Menna

