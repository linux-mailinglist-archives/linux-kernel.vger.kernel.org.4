Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A726AFD99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHDq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCHDqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:46:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BA9547A;
        Tue,  7 Mar 2023 19:46:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c19so16896965qtn.13;
        Tue, 07 Mar 2023 19:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678247204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdrBc7q0BBfVTxoZqm8OhZOgpSNqHyPneh+aFDixsSE=;
        b=dI9BlD03sT71teNdjiUUPqpbib3NOwpxEtklXv3sZMUMJlcWLZ7qam1rxP75zHZJ2G
         itbv6Mxlud4XAHvG4KLJ4dkw9tbP22IRlw65krNI32mWq3jlmQ7HAp//DK7TCC4M8REg
         YEN/UBWnxAJu7aXuGia/Ka99p+quTizb5oOwIrm0TLz9mopfv3ytmVUgGiStZhOc44Wg
         4ySxiQwlgQvthlbrQjMlVzStMFP4VEQSiB2ioGBDH3qrVrWLZwjRET7QVw6vHDb3+hVM
         z5Oy6KAIH4AV5IGYNbQUQvCKa7muG6j3jGzELZKsX50OkQUPHWU92oZhPJrrt/LJlNH+
         Oq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678247204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdrBc7q0BBfVTxoZqm8OhZOgpSNqHyPneh+aFDixsSE=;
        b=Is+fOkesKdXo9+9iQEJZdH1Se8JX0pqiJ2AkdIgCLpq/VuKHVAgAwv3zOPk1UShw1+
         zYTTZWahNXSTmUsNdiswdJnWpRN+etYGOFcVO8v1JgkJgUWEhKAxsySjZ+gbFvxRx8sN
         KBrbJrUxq7DgLBYSC4/HrrS7QnZyte3qJAFKW9XKB4tQzGotPA8gzySaPb8JH2EWjnOa
         P9oSMScUHn9ULvmVAQ7WeB0TDp63fJPtalO2nEZVvgaOHMbUIzFnwMeZUF7g5kKOmFLh
         fr6UZXYecrwEOH/mRyjXPn9h27OenWvp15aBsXTGbpjnqzNJTXekg+qNzC6PXbQP3FCt
         E4kg==
X-Gm-Message-State: AO0yUKX3pzKZ6sk5Y8aYRfpbLX11UwmzHNFzou5FlxYQEbD2WB5CzpK5
        Kwm9YRbGj4J7GpPAJ1HdCNc=
X-Google-Smtp-Source: AK7set/3yLyTf0njU1qukUMOneYpRDNwsD+VfUmK62hIzAvf0Z+tipB5Cf8zcBdRKreEuSvjLNaARw==
X-Received: by 2002:ac8:5bc9:0:b0:3bf:cd81:3a31 with SMTP id b9-20020ac85bc9000000b003bfcd813a31mr30189786qtb.65.1678247204238;
        Tue, 07 Mar 2023 19:46:44 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id g186-20020a37b6c3000000b007430494ab92sm10613604qkf.67.2023.03.07.19.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 19:46:43 -0800 (PST)
Message-ID: <416e27cd-0826-9bfa-8ee8-cf70dfb503c1@gmail.com>
Date:   Tue, 7 Mar 2023 22:46:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
 <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
 <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
 <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
 <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
 <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
 <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
 <7280914e-59e3-ba6d-4324-a29c1c0b4ce8@gmail.com>
 <2ebe4bc5-c11c-89b1-2644-358dc12bdfa5@infradead.org>
 <d3fb242e-646e-50b5-7dba-17b228bb32aa@opensource.wdc.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <d3fb242e-646e-50b5-7dba-17b228bb32aa@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 22:42, Damien Le Moal wrote:
> On 3/8/23 12:23, Randy Dunlap wrote:
>>>> OK, I don't know how it happened. I cannot reproduce it now.
>>>> The failing .config files has CONFIG_MMU is not set (for RV32I), which
>>>> appears to be impossible.
>>> These patches add `CONFIG_MMU is not set` (for RV32I).
>>> But no worries it seems to be a non issue  now.
>>>
>>> Your thoughts Damien?
>>>
>>
>> Thanks for reminding me.
>>
>> With these 3 patches applied to linux-next-20230307,
>> I still get this build error.
> 
> Does this help ?
> 
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 2527cf5757ec..7796c5f1d109 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -4,7 +4,8 @@ config SOC_K210_SYSCTL
>          bool "Canaan Kendryte K210 SoC system controller"
>          depends on RISCV && SOC_CANAAN && OF
>          default SOC_CANAAN
> -        select PM
> -        select MFD_SYSCON
> +       select COMMON_CLK_K210
> +       select PM
> +       select MFD_SYSCON
>          help
>            Canaan Kendryte K210 SoC system controller driver.
> 
> (just noticed that there are whitespace errors here...)
> 
> Note that both the sysctl and clk driver depend on RISCV. I think these should
> probably also depend on 64BIT, and eventually add a "|| COMPILE_TEST" as well.
> So something like this:
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index b6c5bf69a2b2..657a36d2640d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -431,7 +431,7 @@ config COMMON_CLK_FIXED_MMIO
> 
>   config COMMON_CLK_K210
>          bool "Clock driver for the Canaan Kendryte K210 SoC"
> -       depends on OF && RISCV && SOC_CANAAN
> +       depends on OF && RISCV && SOC_CANAAN && (64BIT || COMPILE_TEST)
>          default SOC_CANAAN
>          help
>            Support for the Canaan Kendryte K210 RISC-V SoC clocks.
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 2527cf5757ec..1745a614d2a7 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -2,9 +2,10 @@
> 
>   config SOC_K210_SYSCTL
>          bool "Canaan Kendryte K210 SoC system controller"
> -       depends on RISCV && SOC_CANAAN && OF
> +       depends on RISCV && SOC_CANAAN && OF && (64BIT || COMPILE_TEST)
>          default SOC_CANAAN
> -        select PM
> -        select MFD_SYSCON
> +       select COMMON_CLK_K210
> +       select PM
> +       select MFD_SYSCON
>          help
>            Canaan Kendryte K210 SoC system controller driver.
> 
> COMPILE_TEST is optional though, but I do not see any reason why not eventhough
> in practice these drivers will likely never end up in 32-bits SoC.
> 
> 

Oh thanks I was in the in the midst of making a similar patch.
Do you want to submit it or shall I. Also thanks for the help with this, 
was using tag 6.2.

