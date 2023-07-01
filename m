Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF2744A86
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGAQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:22:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16066135;
        Sat,  1 Jul 2023 09:22:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b852785a65so18746485ad.0;
        Sat, 01 Jul 2023 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688228533; x=1690820533;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqUKdurwe6L/lCzL+nDfeInRljPuUHPLpXkXa64hvDk=;
        b=Yu6rB9zpV2iWzMFz2uX0HZdqH0Pl2/8o54zaJG2YsxZhs0H9E46zOk+5RFz+CH+HFe
         C5lxxVmoyRIBmr9MYH4tMYF0dUGnz3hYvwGcfAXQbQfvZZkizPlP5CTNgP6vx7bUNhAu
         PHOlQ/XacJPR9M62K8dxJILm0sRcumDIGr2J3yFcTk0pNvEhNpzuH3v5UoaAb9e/cHyW
         XNcDCBAsGf0UcyVJoiPXroP8uI5BqeXpR4pWaF8OT/1kvLn5P9ocww2hBvauT+NixnPq
         72vrW5plPqkejIVKgJfBm3RtbKTAl9ySfLfdLWBNK13aXiM/a1nQlCOfN570m96SKPIJ
         W4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688228533; x=1690820533;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqUKdurwe6L/lCzL+nDfeInRljPuUHPLpXkXa64hvDk=;
        b=cmB10vTC+Z1fztquZnKyBAK9aH4GugkHbi6NTq1ZBDW2LZRyoUdkUkgrerHTeue7VH
         SQFd7+7UCLLB2ZuqR8IouPJvHGB/QKiM1nHkoamVDfH6BraonrskqzoQgCZOIUAKbphx
         ovg2DcO8pVyXtrFchc3ApFbsEBPTZSlCtrjz+DlZu9oArvHyCwyTVgI4bQ48x5bS/w2n
         55TskUw+XYLvNXUsDslvXhzceQ6h1po+t1hF36P9t8F/tvos76a6oHOfhg82vvRd1jxF
         3DRt6ZtPFb802rja2kmk7b1JMggLtthoEpjWz4pPkLHvlF5g6s0ux+wu+9VKfOMjrY5Y
         iucg==
X-Gm-Message-State: ABy/qLbyPwos5UklBOe6jJnbjQ7SbMzdWS72wx9EqvEl02xiM0ahrbBM
        OB3oK/Z7ikJlnTNHTqcUtUc=
X-Google-Smtp-Source: APBJJlF4DRTk5B+Ly7B1ketuD+8ABWyitJniEAI9zJpbQnWojtqCLeVtBTxW3tg6hE5OjUySzLE1lg==
X-Received: by 2002:a17:902:c406:b0:1b6:783d:9ba7 with SMTP id k6-20020a170902c40600b001b6783d9ba7mr8807226plk.27.1688228533345;
        Sat, 01 Jul 2023 09:22:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001b6674b6140sm12524647pll.290.2023.07.01.09.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 09:22:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0025db66-545d-c52b-1c32-fa86e17ff0e7@roeck-us.net>
Date:   Sat, 1 Jul 2023 09:22:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
References: <20230616150618.6073-1-pmladek@suse.com>
 <20230616150618.6073-7-pmladek@suse.com>
 <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
 <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define
 HARDLOCKUP_DETECTOR_ARCH
In-Reply-To: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/23 09:08, Doug Anderson wrote:
> Hi,
> 
> On Sat, Jul 1, 2023 at 7:40 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Jun 16, 2023 at 05:06:18PM +0200, Petr Mladek wrote:
>>> The HAVE_ prefix means that the code could be enabled. Add another
>>> variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
>>> It will be set when it should be built. It will make it compatible
>>> with the other hardlockup detectors.
>>>
>>> The change allows to clean up dependencies of PPC_WATCHDOG
>>> and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
>>>
>>> As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
>>> on arm, x86, powerpc architectures.
>>>
>>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>> ...
>>> --- a/include/linux/nmi.h
>>> +++ b/include/linux/nmi.h
>>> @@ -9,7 +9,7 @@
>>>   #include <asm/irq.h>
>>>
>>>   /* Arch specific watchdogs might need to share extra watchdog-related APIs. */
>>> -#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>>> +#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>>
>> This results in:
>>
>> arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_partition':
>> arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declaration of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watchdog_hardlockup_stop'? [-Werror=implicit-function-declaration]
>>    753 |                 watchdog_hardlockup_set_timeout_pct(factor);
>>
>> with ppc64_defconfig -CONFIG_HARDLOCKUP_DETECTOR, because the dummy
>> for watchdog_hardlockup_set_timeout_pct() is still defined in
>> arch/powerpc/include/asm/nmi.h which is no longer included.
> 
> Can you test with:
> 
> https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid
> 

Ah, I didn't find that one. Sorry for the noise.

Yes, that should work. It is a bit odd that including both linux/nmi.h
and asm/nmi.h is required, but as it turns out that is actually quite common.

Thanks,
Guenter

