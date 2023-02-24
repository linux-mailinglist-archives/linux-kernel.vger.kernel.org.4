Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A36A199C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBXKJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBXKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:09:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD6168A9;
        Fri, 24 Feb 2023 02:08:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1736910wmb.3;
        Fri, 24 Feb 2023 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgkQ7FqOSlloctVMggiZsiO3hLNNWVgNpW5kNJL0DOo=;
        b=j0kqpQpYFzCR5Z+BF9xMDOnF1O5Tpif9+PJ9M1E9tEZ3IESQy9kASW61VmUALsPnlM
         Dw9cSyeG8Pds1FYSL3U8V2B/jP3ykEUoO0vryItFZBmQzKfILSmC1eObDjjTrgDH/nyh
         NcgSi63sk/45T2E0evvkRtsOg1qDTVXKzONSZZZXE7DOs13dYzBXvm38/Xy5Rz7wbqik
         bvLNQ9hT6JLs4AW0JuePgQdI0yg9YiqP4W8bN9mBs6dOgtX8rNZLFpSJaLnQOPEARuDp
         zxXzsdHtXKWq9mA0CYu0wvCItsDf3YekqSmT+1UevTRjHtzzvTKhYwLzG3XLoIFf88Ve
         Sgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgkQ7FqOSlloctVMggiZsiO3hLNNWVgNpW5kNJL0DOo=;
        b=S8zo5KrJsNVf14t29Q/GD9H5Y0rOn2W/2cl57zhAo9EOjVeNNOkjpnBgq9pRUXq9pA
         Ik74fPg7rVvmgxjI/4pfIxMD+h2F+9x89SBD9JFuHQ4cizjlYVnpHJBBAE2Kscdqs3M6
         6bXroGb5PGtT75Foj8GvpJWcq8WmbEreCE5YiROFWQICMwXp/RRwzhXgJhSqL1qm5KU8
         ZoxK4aQo+O1D6/BkyeNlNcy9B4LsShG2bVBF/wmECdHfjbhkHMdlVuJp0cRboGQfnasN
         aRMmq1LBlqutsHeuLNJSWwNL8rF86xxCm1JsYr/C3B+NPZFwEIBcd/vd+i1BsX1j1kd5
         UAqw==
X-Gm-Message-State: AO0yUKWYmEjO73tUl9xpLmRnkRC4feAOzL43ZMZ9ijpxWXcNW2WKxUSB
        OYpXYp9WoOlXkPHfi/fUU4s7QRUOhqG3sQ==
X-Google-Smtp-Source: AK7set9L7gy2+v4ilecS0Z6ucu2iTaal4h7/I00hSRjFE45mksm6NC661ZgsuwU8/6chjWPgjz47fA==
X-Received: by 2002:a05:600c:1d92:b0:3ea:8ed9:8f03 with SMTP id p18-20020a05600c1d9200b003ea8ed98f03mr3823677wms.24.1677233269287;
        Fri, 24 Feb 2023 02:07:49 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id fl24-20020a05600c0b9800b003e9ae2a8cbfsm2345630wmb.2.2023.02.24.02.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:07:48 -0800 (PST)
Message-ID: <b0a37773-5e5e-daf9-a6bd-2768476119ed@gmail.com>
Date:   Fri, 24 Feb 2023 11:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] pstore/ram: Fix crash when setting number of cpus
 to an odd number
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Weichen Chen <weichen.chen@mediatek.com>,
        linux-hardening@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yt.shen@mediatek.com,
        angelogioacchino.delregno@collabora.com, tony.luck@intel.com,
        keescook@chromium.org, darren.chen@mediatek.com
References: <20230224023632.6840-1-weichen.chen@mediatek.com>
 <290b055f-9fc1-2580-244f-24663fba171f@igalia.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <290b055f-9fc1-2580-244f-24663fba171f@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 05:00, Guilherme G. Piccoli wrote:
> On 23/02/2023 23:36, Weichen Chen wrote:
>> When the number of cpu cores is adjusted to 7 or other odd numbers,
>> the zone size will become an odd number.
>> The address of the zone will become:
>>      addr of zone0 = BASE
>>      addr of zone1 = BASE + zone_size
>>      addr of zone2 = BASE + zone_size*2
>>      ...
>> The address of zone1/3/5/7 will be mapped to non-alignment va.
>> Eventually crashes will occur when accessing these va.
>>
>> So, use ALIGN_DOWN() to make sure the zone size is even
>> to avoid this bug.
>>
>> Signed-off-by: Weichen Chen <weichen.chen@mediatek.com>
>> ---
>>   fs/pstore/ram.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ade66dbe5f39..fc57ac97e506 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -528,6 +528,7 @@ static int ramoops_init_przs(const char *name,
>>   	}
>>   
>>   	zone_sz = mem_sz / *cnt;
>> +	zone_sz = ALIGN_DOWN(zone_sz, 2);
>>   	if (!zone_sz) {
>>   		dev_err(dev, "%s zone size == 0\n", name);
>>   		goto fail;
> 
> Thanks for resending! Feel free to add my:
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

I gave that yesterday, but Weichen Chen seems to have forgotten about it.

Regards,
Matthias

