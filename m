Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05E56460F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:23:23 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1783FB80;
        Wed,  7 Dec 2022 10:23:23 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id ay32so8779898qtb.11;
        Wed, 07 Dec 2022 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqV8Z3CejC4gM8mgMLeA4bf48l9B+DBUuSHPJZEt2rE=;
        b=punNcy/XVTLMQCfvuz2BTh05uSCxzMrAI5GCcuPI6GuE8UgT7VOfLoAwIL0rxlXtIb
         scaA6M07S3nAxoa6z2x5qweK5/g66S5BGT/guhKtuDJZVo56S1Ob6oNhsyOdZiYI8uCb
         XuoxR3nwmNmyjDfZgoKfPIBd9j9KlS7dClrhcRVvyYiWMiPEyDazRSxgNVBfCNioBQ+g
         lNsAji3YzUWCkFzMOknnicagQaGUK73dEEnwzcJwnM/ijtn6NFUPziP62VREXlBBuoLl
         G7E4l4gX9KWvYM7PoIAFKISD50O1iCBZOnwxBrLuDyuLwsCkw5VAp+U8J8XgiEzNUTdq
         oaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqV8Z3CejC4gM8mgMLeA4bf48l9B+DBUuSHPJZEt2rE=;
        b=JD3UoCNHTQfoFfAyx81X3wL361k6hTesNSiEYRg0K2EvS+S1GF/44ip7s3IXLMSWpg
         CmHhG1qdyWpJa4wypyNIbrbxMV2H4QYOUhBYNi01hUXzAWztq4AUob2oG4F3PfRBZaLJ
         adIk2fQFkHCnKug98YIJ/N0mZgnSIszVNzJA029/ZBwEcE+zarSFw/uwQvsQ1gA7+uoo
         TAMf3wxQc6HLgzQz9qzy4Tv7v1dIKJ3hSkXiIB86GLwFjd4tQWAwuPaGp6KBN47WhFUs
         aoCGllBAsWpLoze245/w0hfhQ8yHN49P0RVcxPwUGNaP/Expuvz4u5JqU519Ubce8T9j
         +ddw==
X-Gm-Message-State: ANoB5pniqtYq1KB5jV4xuhEdZwgwIabcXCMLra4mDsvOhN0IYw8J/NTc
        bbmOyIGZilgQ8VuOo5/4SCM=
X-Google-Smtp-Source: AA0mqf5SwX7LwgxgBHyVAxIdeOS/0duODo1rGd9ETRaKxJVSiCg8TAsdK79fMZOLyMUE9dcqDmmySA==
X-Received: by 2002:ac8:5645:0:b0:3a6:90cc:75bd with SMTP id 5-20020ac85645000000b003a690cc75bdmr26455594qtt.633.1670437402105;
        Wed, 07 Dec 2022 10:23:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hf13-20020a05622a608d00b003a5c60686b0sm13479465qtb.22.2022.12.07.10.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 10:23:21 -0800 (PST)
Message-ID: <29f1887f-bce4-2065-8e0d-2faef30e38db@gmail.com>
Date:   Wed, 7 Dec 2022 10:23:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [lvc-project] [PATCH v2 2/2] MIPS: BCM63xx: Add check for NULL
 for clk in clk_enable
Content-Language: en-US
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Anastasia Belova <abelova@astralinux.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     lvc-project@linuxtesting.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        kernel test robot <lkp@intel.com>
References: <20221207142824.8706-1-abelova@astralinux.ru>
 <20221207142824.8706-2-abelova@astralinux.ru>
 <2f2047d6-64ec-3602-a115-cde06855e2ab@ispras.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <2f2047d6-64ec-3602-a115-cde06855e2ab@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 07:53, Alexey Khoroshilov wrote:
> On 07.12.2022 17:28, Anastasia Belova wrote:
>> Errors from previous version of patch fixed.
>> Check clk for NULL before calling clk_enable_unlocked where clk
>> is dereferenced. There is such check in other implementations
>> of clk_enable.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> ---
>>   arch/mips/bcm63xx/clk.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
>> index 401140cf36d9..cf303d6e6693 100644
>> --- a/arch/mips/bcm63xx/clk.c
>> +++ b/arch/mips/bcm63xx/clk.c
>> @@ -362,7 +362,7 @@ static struct clk clk_periph = {
>>   int clk_enable(struct clk *clk)
>>   {
>>   	if (!clk)
>> -		return;
>> +		return 0;
>>   
>>   	mutex_lock(&clocks_mutex);
>>   	clk_enable_unlocked(clk);
>>
> 
> Keeping in mind that the first patch is not applied yet, it does not
> make sense to fix it by the second one. It is better to fix the first
> patch itself by sending the next version.

Exactly, you would to combine both patches into a single patch and send 
that as a version 3 now.
-- 
Florian

