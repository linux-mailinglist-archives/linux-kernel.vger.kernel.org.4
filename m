Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE37395AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFVDBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:01:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535E171C;
        Wed, 21 Jun 2023 20:01:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b512309d18so35498875ad.3;
        Wed, 21 Jun 2023 20:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687402885; x=1689994885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D/ohZ8gW5mbp6/IBtkD8r/oSawNtp6lcTXgmllygMQo=;
        b=KOhlP+tvcjZI//qQeKRbgVYdFUKFXwlPIXoZxxhXZxDbAH0jW+KMnGDGw0INZeKvua
         aEf0+j8ehlGypsvZQ5PiJuhwAx8rAW2oWthq4h7o7dbvVES09PRy6UdBelZUyN0KcveF
         rbJrFiM0YRWuvcRbCMgXrFl/uKafmcVKx9vFCntFbhSFUyty+JOJBUk6TC9Ncp3bslbH
         lpnoKwRfNRvjo0EsVxjK9ZoZcf9YniWVPJXKnxAbq+TBuXWDl7SuvTwkxnkASGxYLBxR
         0LbxY/QnmOUQ6hd3gNtAHsT5jj/MGchcYtzK+tsibgtPpoYcR8CRi6IVcNz/AhhWXTBy
         djfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687402885; x=1689994885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/ohZ8gW5mbp6/IBtkD8r/oSawNtp6lcTXgmllygMQo=;
        b=BkaiULak+wfu6X5RKYDjFqYPlsk8J6w3VLfQr5uTxxjprQf8WSCMIoE7grGhygDuFv
         qmPihLA57L45t7XygNUdZmMKwyi9kB3xHV45/2NfYOtTq/Ba4QezVzHjoiJfM5PacWXM
         a3z0fO77ih8kw+sYtcOjKzCQa0xjmpQlaDR5hDjAinW+iTs3aEArjSqjKK0P9qKkRdLF
         jgsA4lfRIs+oRRmBR5o+04mxuzJLuURajp0l3vUMWMvS2bGBseD1JuYtkG03VKWDQ0iP
         WZg0i+8N+TBAoInZyY21xOYp1SaCZtweat2Z/ywDmhkCBgMnGl0/mLaD5uqRZesraAMb
         QYpQ==
X-Gm-Message-State: AC+VfDwyPry7MWD5quyP3Set40ZlH84FUVnLXtFK4Xb2l0jHmddNc/ku
        0d7BSrn2MVS3AY+tFZMCL4uipZKJz4g=
X-Google-Smtp-Source: ACHHUZ5AMtZhQpL4UTMDTbP3cpAMuNUQ3DamGmvDbZEawwuHA1w+JNzKx+l/w+KZRLtaXIjJDQUqdQ==
X-Received: by 2002:a17:902:8bcc:b0:1b2:450f:9b6 with SMTP id r12-20020a1709028bcc00b001b2450f09b6mr10411709plo.8.1687402885233;
        Wed, 21 Jun 2023 20:01:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902694c00b001ae469ca0c0sm4119062plt.245.2023.06.21.20.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 20:01:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net>
Date:   Wed, 21 Jun 2023 20:01:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
 <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/21/23 17:57, Damien Le Moal wrote:
> On 6/22/23 01:51, Guenter Roeck wrote:
>> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
>>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
>>> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
>>> so other arches can't be enabled.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Tested on allmodconfig build. Not sure if there's other MIPS configs
>>> where this doesn't work. We'll see what 0-day says.
>>
>> Odd, in next-20230621 I get:
>>
>> Building mips:allmodconfig ... failed
> 
> Indeed odd. Given that this is an allmodconfig, I would assume that
> CONFIG_CAVIUM_OCTEON_SOC is set ?
> 

No, it is not. CONFIG_CAVIUM_OCTEON_SOC is a choice option,
meaning only one of the choices can be set, and mips:allmodconfig
selects a different choice.

Guenter

>> --------------
>> Error log:
>> ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>> ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_cf.ko] undefined!
>> ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>> ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>> make[2]: [scripts/Makefile.modpost:144: Module.symvers] Error 1 (ignored)
>> make[2]: *** No rule to make target 'kernel/locking/locktorture.ko', needed by '__modfinal'.  Stop.
>> make[1]: [Makefile:1933: modules] Error 2 (ignored)
>>
>> Guenter
> 

