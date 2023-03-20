Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06296C0FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCTKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCTKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:49:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48A28EAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:47:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so44716292edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679309184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE4spIUhieywTPmbfU5JkyQsvGJhPjI5IlXn9hUlyMg=;
        b=kSbyDQSDa9jw+RK3Cwwnsv8iwMfCrBT5KPAbXGEUWz8YFFLIE0g5Sbj5uFYNhIjM3t
         vrspPZse/wL3z/ANq52hXK0oJjf87+AlXJOog5nWkyx0KirJKXpuSaSaqh6eZ2C12/fa
         oW+E8KVxwsjJsqeU0mdmw8DuTk8qxpcdmyXQFtfCeMp7KwgTf4qk5e/dpQR7AkfQTEs0
         dP5xc1Bi4HGuQpQdHr1rwP8P0wj1ciWgKiCDSlCWEmA3Wc7/b+4CBTVDVUfU4Io1Om6/
         3lhHRB6Ea01qo2q0oIDTwluPYBykkFUjN25QdGt7FCuiphvnFFIjpEFkRVNiQ74nmXOE
         7bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE4spIUhieywTPmbfU5JkyQsvGJhPjI5IlXn9hUlyMg=;
        b=OhE1iD7KU+NKju60k+zROMRtg2RexlPPGnKJNEKkJjjPT8LE2Oe6ztK5ZS63OAlZ6e
         zDepS59fbS2IkRIA8frmtFcGZjmEDsWA0x3qLoeJRx+DIpiZovjDd4lUrDQPC8rTi5ND
         3ksc6Ky8hDCAjp1SjCGfCt60bhmcXyc2C8hQhUAToxOy45pl/CiztgLOi0+bZSEID4QH
         EHW9ybS2Mqfr0Iowp1Tmr6abCa9zF9vaB5GfW7HvPfng+5X6tG/cfsrHxnxf22LTaA+2
         Eyrcl/76PbNXhAyx9U+tEgunIcxHQ5J77Km3SQUWO3Q7xlpncFQw6GZ3YclbpwLWxEUq
         fE/g==
X-Gm-Message-State: AO0yUKUbjqFJi9qDb6lOil+xL6Rb01HeREJsnU08okVR95hI3D6Aa79P
        1pHxKPxgGtTIjLylwXFmPHTlIeIRoA8=
X-Google-Smtp-Source: AK7set9foj5JTf3GpQW2uMkxmSxrU69hOx1A+Sbbm6/DmpdIlp/WVoyJqf0+SvMKxiwVLxIloqbwxQ==
X-Received: by 2002:aa7:c857:0:b0:4fb:d10e:d9b4 with SMTP id g23-20020aa7c857000000b004fbd10ed9b4mr12028226edt.16.1679309183843;
        Mon, 20 Mar 2023 03:46:23 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004ac54d4da22sm4726760edf.71.2023.03.20.03.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:46:23 -0700 (PDT)
Message-ID: <3d433474-93bd-b62c-1de5-7b029b1353f9@gmail.com>
Date:   Mon, 20 Mar 2023 12:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: rtl8723bs: use inline functions for
 dev_to_sdio_func
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
References: <20230320103441.6537-1-eng.mennamahmoud.mm@gmail.com>
 <ZBg4tGlY+Epz0Vhd@kroah.com>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <ZBg4tGlY+Epz0Vhd@kroah.com>
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


On ٢٠‏/٣‏/٢٠٢٣ ١٢:٤٣, Greg KH wrote:
> On Mon, Mar 20, 2023 at 12:34:41PM +0200, Menna Mahmoud wrote:
>> Convert `dev_to_sdio_func` macro into a static inline function.
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
>>   drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
>> index 490431484524..7ee821dbbae0 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
>> @@ -10,7 +10,10 @@
>>   #include <linux/jiffies.h>
>>   
>>   #ifndef dev_to_sdio_func
>> -#define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
>> +static inline struct sdio_func *dev_to_sdio_func(struct device *d)
>> +{
>> +	return container_of(d, struct sdio_func, dev);
>> +}
>>   #endif
> Why is the "#ifndef" check still needed now?  Really it was never
> needed, but now would be a great time to remove it as it doubly does not
> make any sense here.
>
> Oh wait, no, this whole thing can just be removed entirely, right?
> There already is a dev_to_sdio_func macro defined, so the #ifndef check
> catches that so your change doesn't actually modify any code that is
> used.  So this should all be removed, not changed to an inline function.

yes, got it.


Thanks,

Menna

>
> thanks,
>
> greg k-h
