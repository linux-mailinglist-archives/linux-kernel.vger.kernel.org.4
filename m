Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB25B9306
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIODWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIODWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:22:48 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB967E828;
        Wed, 14 Sep 2022 20:22:46 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n81so13487533iod.6;
        Wed, 14 Sep 2022 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pK9t17xtunBZyDnxdhq8e4Wf/xgHD79G1kAgxFswKRg=;
        b=pgvsWuzGmGb9gZpccw0+JGkqwtoeRUGcV4LbJZoUIidU+81H8xnEpS734m+8wevTZk
         KNoMAHX/Y6EP8QdbV49rY9xIGHpV6uIJVMntLYsPT/zqk18/AWYVj4KRdvS6yiRn3Na6
         HdocumoEb1/ehvOOd9FqSHRbkHaMOF/mCibZABTMpC5FlnTIaeAZ7w78wdEydKY1vHkY
         8ssCgQQYYDEHYlMziPky+WOj6CI2ht5BKgQfDmFa11CRe//zsolqW0xg0L+kwdIvkTHx
         j7+rbQ1SZ3yFDxdXe89QlgwwlaKNEYkxuYX2RNPk9O6OtJDH81rG8r0piIug7Gmtxfwo
         q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pK9t17xtunBZyDnxdhq8e4Wf/xgHD79G1kAgxFswKRg=;
        b=K29oXQuowGx4XbbdnWl/diuVPCCeffYGx5W4tfqXS8vEDcgiGlH4xGSDKGgko7g4ym
         dBioD10OyJgp/t/V48zpXUGznh3XjSkn+LjwI0o147APl+oL6boqXn/P3SEj1EDZ0JLb
         y8ab5nQEHBj1fIEJOhIZ1URPEBSkF5v9qg9xh845ClBTHhdPBi40AiHOv4J86qNTmgmY
         dLEQEq86+63hMukAALSi3Bw0eO70CQ5uAhhEVagiXhBk8+AE/q30cDO+IGIuEuBUvjm2
         SoOOJny0CeDzJazc1z5UH2vyfz+1wKWD9HGUBJXUxMJON+QrlcH6uwnbX4zZsaw0TPHM
         Yg8A==
X-Gm-Message-State: ACgBeo35YXWbaxkCt6ClCrCPEHe6LkeHI8M9fph9/fiHn72UYg4Cy4JS
        z+rRFuSw9fHHdHj/fDfXOzaodN2xrKfboPnv
X-Google-Smtp-Source: AA6agR7yeOgtt0zNKdCXEJYL1iCrIpRLz7cdEpVTzlfmqjRvO54jSpMKB+AyGMJKTW1Gwaf2IGXi3w==
X-Received: by 2002:a6b:680e:0:b0:69f:ee36:3cfc with SMTP id d14-20020a6b680e000000b0069fee363cfcmr12330302ioc.108.1663212165301;
        Wed, 14 Sep 2022 20:22:45 -0700 (PDT)
Received: from [192.168.50.84] ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id x10-20020a0566380caa00b0035a143b451esm512230jad.128.2022.09.14.20.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 20:22:45 -0700 (PDT)
Message-ID: <d7241682-fdf3-4ef9-f262-de26dae12c9f@gmail.com>
Date:   Wed, 14 Sep 2022 22:22:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/6] acpi/x86: s2idle: Add a quirk for ASUS ROG
 Zephyrus G14
Content-Language: en-US
To:     Philipp Zabel <philipp.zabel@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-6-mario.limonciello@amd.com> <YyC0u0nedouZemfq@rog>
From:   Matthew Anderson <ruinairas1992@gmail.com>
In-Reply-To: <YyC0u0nedouZemfq@rog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested and confirmed working on my Zephyus G14 laptop.

On 9/13/22 11:50 AM, Philipp Zabel wrote:
> Am Mon, Sep 12, 2022 at 12:23:59PM -0500 schrieb Mario Limonciello:
>> ASUS ROG Zephyrus G14 is affected by the same BIOS bug as ASUS TUF
>> Gaming A17 where important ASL is not called in the AMD code path.
>> Use the Microsoft codepath instead.
>>
>> Reported-and-suggested-by: Philipp Zabel <philipp.zabel@gmail.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * New patch
>> ---
>>   drivers/acpi/x86/s2idle.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index 9ee734e0c3c5..4bdc7133d2ea 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
>>   		},
>>   	},
>> +	{
>> +		/* ASUS ROG Zephyrus G14 (2022) */
>> +		.callback = lps0_prefer_microsoft,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
>> +		},
>> +	},
> Tested-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> regards
> Philipp
>
>
