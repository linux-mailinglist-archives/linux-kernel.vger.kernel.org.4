Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F65F7B04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJGPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJGPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:51:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DFD01A2;
        Fri,  7 Oct 2022 08:51:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e129so4983203pgc.9;
        Fri, 07 Oct 2022 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m0zPufVuyy18WlA7p26iPZUG0rUtMRETzx+/B0dB+2Q=;
        b=oNjKMIGDzkjaNQpHE8Ko6JWG3mtYkvjEP0VtiOM631e7l6tSezIrRnWwbuIzjZ6FP9
         Vrj8meW/rqShvoXX8RSHpePTYb2Mal+6e6R1Xz8nYNWUY3NVZrnBo5jssr7oim/AUyWp
         UyhLFL//DMPe/3OGEc5JQ4UQxhTnmz3beRz/pqexg9Xu8uriCIigPIb4HzFCUfPfpoxW
         L8c+rtZWPwhynf41qXOFxIcSokihn+ml1bisrVUzgELdC1Y7BGR/yby5z4wrGNY75YfL
         X7xphuRBxv+ppsCFQaFmHJbyqaus2WDiOrktINf4LgDCNcYNqiGUTg0omn/h/2kzCaLg
         8s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0zPufVuyy18WlA7p26iPZUG0rUtMRETzx+/B0dB+2Q=;
        b=lYyFQQzbfPtLMQbrT18IHls2jT5eN5VhJzjExFWv0su8pYNQXoVvt/ck87djv8ltVX
         OnXluHxGikumeoGM5Zhm4K7Gc8FJVfzTJkW5e9pXSV2FghHNAU7ZOy2s85aT3RBtdVqK
         boiTcG0Yt4ztMppVfJxeW++WAQhmKIv7YOKJioNYJPK0FOUstUIGfWPpjA8BioORv8UE
         SPGGFIWt9GTtUJLTtORuLrfUfsfpnRAuBOF8bl35ydyvrLgcw+2kyb3PtyvBJq3DUR9Q
         CH82jaKNHjhB1cxhC9fV+CkqRg5sDMGSSXYHqfhOPfeBg2JW2fNIQ/UIaRsidFF3tiCl
         3L3Q==
X-Gm-Message-State: ACrzQf17CcGHQ9Ektc2tkFBc4laxByPN/ARn2ecyv2pTs6IA2LVyI40v
        pcOkEmEEwvZDc+4GX6mhJ/A=
X-Google-Smtp-Source: AMsMyM4mVvzYKTSxFf+jiZu5zmHOZoCmBeahPWu5D86njDJJ8KiitF6wGEkR6nSPHTdjMFCnF2SbQA==
X-Received: by 2002:a63:8742:0:b0:45a:2ab4:3b05 with SMTP id i63-20020a638742000000b0045a2ab43b05mr5065840pge.305.1665157870555;
        Fri, 07 Oct 2022 08:51:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b00176b63535adsm1680304plg.260.2022.10.07.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:51:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5262ef1c-ca81-f25e-e072-d39e9f5c9e53@roeck-us.net>
Date:   Fri, 7 Oct 2022 08:51:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] watchdog: w83627hf_wdt: add bootstatus support
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824152448.7736-1-henning.schild@siemens.com>
 <20221007173607.5c15c18f@md1za8fc.ad001.siemens.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221007173607.5c15c18f@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 08:36, Henning Schild wrote:
> Ping.
> 

The patch is queued in my watchdog-next branch. We'll see
if Wim will pick it up in his pull request for 6.1. If not,
try again after the commit window closes.

Guenter

> Henning
> 
> Am Wed, 24 Aug 2022 17:24:48 +0200
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> The status bit in the status and control register can tell us whether
>> the last reboot was caused by the watchdog. Make sure to take that
>> into the bootstatus before clearing it.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>> ---
>>   drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/w83627hf_wdt.c
>> b/drivers/watchdog/w83627hf_wdt.c index 56a4a4030ca9..bc33b63c5a5d
>> 100644 --- a/drivers/watchdog/w83627hf_wdt.c
>> +++ b/drivers/watchdog/w83627hf_wdt.c
>> @@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable
>> watchdog at boot time (default=0)"); #define W836X7HF_WDT_CSR
>> 0xf7 #define NCT6102D_WDT_CSR	0xf2
>>   
>> +#define WDT_CSR_STATUS		0x10
>> +#define WDT_CSR_KBD		0x40
>> +#define WDT_CSR_MOUSE		0x80
>> +
>>   static void superio_outb(int reg, int val)
>>   {
>>   	outb(reg, WDT_EFER);
>> @@ -244,8 +248,12 @@ static int w83627hf_init(struct watchdog_device
>> *wdog, enum chips chip) t = superio_inb(cr_wdt_control) & ~0x0C;
>>   	superio_outb(cr_wdt_control, t);
>>   
>> -	/* reset trigger, disable keyboard & mouse turning off
>> watchdog */
>> -	t = superio_inb(cr_wdt_csr) & ~0xD0;
>> +	t = superio_inb(cr_wdt_csr);
>> +	if (t & WDT_CSR_STATUS)
>> +		wdog->bootstatus |= WDIOF_CARDRESET;
>> +
>> +	/* reset status, disable keyboard & mouse turning off
>> watchdog */
>> +	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>>   	superio_outb(cr_wdt_csr, t);
>>   
>>   	superio_exit();
> 

