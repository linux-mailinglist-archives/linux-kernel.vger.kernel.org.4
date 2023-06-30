Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7457432E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF3DCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3DC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:02:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302630F6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:02:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7f92b764dso8139835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688094146; x=1690686146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va3tAPpwtxEmLPxNg69OFrJC2hoHfa4rp2U1Z8KvtRU=;
        b=A67+C+eWJHOVAterElQo91+WZz+bzJSt1esSLU8WwT85tAotyuG6kRiAtWCCPxoFzy
         gGO5bRrXkxkVeSvDJXwXXWA+1YBHIS/yTMzGrA7BjZxwP8M8Wfz4DR2CZ+fmlRNN6JU9
         GW8SxlPonEpwOjzFQDTE6OVIE30cYAAMt87Awytwg4Y9I2ZNgsmsXa/vVog93RFkV4d7
         yPyUjfzUWiNSoqjrjWKA379hJRYHW1beW1C/BkHhExtl6dYhLB7UDbYx9Wyy4OyN1DEu
         oWRStgoOfWVt23isXsMsuaWjXfdvBWVvYFjeyCFYpkcGQHM/v/CI6pLl31UUJfqX+4Ai
         3t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688094146; x=1690686146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Va3tAPpwtxEmLPxNg69OFrJC2hoHfa4rp2U1Z8KvtRU=;
        b=W8G8DMeyJ954MmasY2Q7UL1AqyRlbyMg1DqiB9jhK0VVccJxCc3wGddsu2S4h+JVQ3
         bnVEVKXr4PdPD1oLnLI7jComRlY/hdAomppKwlQ77i14fLCnkpt/KXilnUP0+xEnB451
         Zh2PMFKRcydX5n70zut32SakWoaPyU9H2GcdE1Rhk1fuRdki9MTzduaSamYu9KjjHLTj
         1fJUVCLL+toDshC62hJWlmHwhcmyyNvldNd2S1ziwnVqG4i3juHrnKvwpExr9enAyS14
         M/EnTRul1tpBcuR98EHm+6LSFktz07BjjV5iFSM52ij7qcaDh5bVxFgcCFH6cWtqxtA5
         raYg==
X-Gm-Message-State: ABy/qLbVsOxEARsBxwi+b+CKtbPKQYpaQx7i45Tqxb/Gus6XEelCqfkH
        b4sat0laafgVxOYiixSP+mQ=
X-Google-Smtp-Source: APBJJlFcEd5YX9HITYzLp54d+gol3Qp11faPUNSzChKdnTHk6pnRYxsToE3fBOzdECXM8TiXc7wNTg==
X-Received: by 2002:a17:902:da92:b0:1b8:525a:f685 with SMTP id j18-20020a170902da9200b001b8525af685mr988169plx.37.1688094145942;
        Thu, 29 Jun 2023 20:02:25 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b8307c81c8sm3745102plr.121.2023.06.29.20.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:02:25 -0700 (PDT)
Message-ID: <0787532c-4520-6d01-c50c-63df207f570c@gmail.com>
Date:   Fri, 30 Jun 2023 11:02:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: BUG_ON() for no cpu nodes in setup_smp
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        sunilvl@ventanamicro.com, heiko.stuebner@vrull.eu,
        apatel@ventanamicro.com, evan@rivosinc.com,
        greentime.hu@sifive.com, leyfoon.tan@starfivetech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230629105839.1160895-1-suagrfillet@gmail.com>
 <20230629-maverick-kelp-17327f04482a@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <20230629-maverick-kelp-17327f04482a@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/29 20:33, Conor Dooley 写道:
> Hey,
> 
> On Thu, Jun 29, 2023 at 06:58:39PM +0800, Song Shuai wrote:
>> When booting with ACPI tables, the tiny devictree created by
>> EFI Stub doesn't provide cpu nodes.
> 

"When only the ACPI tables are passed to kernel, the tiny..."
That seems more accurate. We can use "acpi=" kernel
parameter to manually enable/disable ACPI.

> What are the conditions that are required to reproduce this issue?
> When booting with ACPI, why is acpi_disabled true?
> In my naivety, that seems like a bigger problem to address. >

Actually, I appended the "acpi=off" to kernel cmdline for testing the 
"off" option. That would set acpi_disabled as true.

>> In setup_smp(), of_parse_and_init_cpus() will bug on !found_boot_cpu
> 
> Please, s/on !found_boot_cpu/if the boot cpu is not found in the
> devicetree/, or similar.
> 
ok
>> if acpi_disabled.
> 
> Why would of_parse_and_init_cpus() be called in any other case? There's
> only this one caller, right?
yes
> 
>> That's unclear, so bug for no cpu nodes before
>> of_parse_and_init_cpus().
> 
> What is unclear? That the reason for the BUG() was that there were no
> cpu nodes, since it could also be that there were CPU nodes but they
> were disabled etc?

The BUG() in of_parse_and_init_cpus() indicates there was no boot cpu 
found in the devicetree , not there were no cpu nodes in the devices.
That's the "unclear" I mean.

> 
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> ---
>>   arch/riscv/kernel/smpboot.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index 6ca2b5309aab..243a7b533ad7 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -187,8 +187,13 @@ static void __init of_parse_and_init_cpus(void)
>>   
>>   void __init setup_smp(void)
>>   {
>> -	if (acpi_disabled)
>> +	if (acpi_disabled) {
>> +		/* When booting with ACPI tables, the devictree created by EFI Stub
> 
> This is not netdev, please use the correct comment style :/
> 
>> +		 * doesn't provide cpu nodes. So BUG here for any acpi_disabled.
>> +		 */
>> +		BUG_ON(!of_get_next_cpu_node(NULL));
>>   		of_parse_and_init_cpus();
>> +	}
>>   	else
>>   		acpi_parse_and_init_cpus();
> 
> checkpatch should have told you that you now need to add braces on all
> arms of this statement.
ok,
> 
> Or, better yet, move the whole thing into of_parse_and_init_cpus() in
> the first place? You could drop most of the comment in the process,
> since I think the details of how you hit this problem would likely not
> be helpful to anyone that hit it under different conditions.
> 
ok, I'll apply these comments if you're ok with my replies.

> Cheers,
> Conor.
> 
>>   }
>> -- 
>> 2.20.1
>>

-- 
Thanks
Song Shuai
