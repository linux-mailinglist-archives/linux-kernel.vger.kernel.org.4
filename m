Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370D5BA0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIOSsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIOSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:48:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913F9AFAD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so23289689pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=4V4RnQIqXfObgERFxnXO9I4wxN/7f6punHSf5ZIJLT4=;
        b=kEU2PZdbKL5Q4rNVJReJDPmAkSzXWOnQac5Qkc/oC3r76O30/K3sa0VN5xLZKbl6NY
         U0qr8f/9292y72fzItvB828icVflSNIevAEgyXdof/IrWnT7rzOk5TYHolCjji2/ViwQ
         NC5Sa2BDIlML5YVLOPh/cupHrLBS8ArzWAeROg+BB2G1KM3vgC5Hh6jXYVY52soT6EeO
         lEqDYJwYk0+3gcjPjnxm20orMM7zwuhFU3anaK2YhEGgqMnVdTr7h18mp1ANf+F5xk/n
         m0OWYCeCSD8P+KPUYj9K0VEJe1DF3yFhCGXXq0l4Plhyu9tbQFIUHycZfILo/qXngNwB
         M+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4V4RnQIqXfObgERFxnXO9I4wxN/7f6punHSf5ZIJLT4=;
        b=bfiiSd0z6vyG5Ox25HZq9lhsJAjXhVRnVFMMAX+lloT3Zi+mPWk8XSzReLESSjRyPE
         SzqVAioJabIFx+ExmHRaZy5ui155uMGIDTtcvUNy+rngmLVxRuAlzT8/QAFzuLosm2iQ
         jS3MrRoQXzFl7M2e6foSu9g7iXpSkRaEXhMiG7qSxWDLygbmrb9+SQoRckGhHGuq1DNK
         K1aT91jBgCf9HTW6jo0y1t/70UjimPZQeU/GTaVIzT/9GitT2+ncUizGsph0sfnYMgwx
         6lrbG0F1VYXhlEpZFsCEQi3MMEJnRkytOcJW41+lnzY48QYhPv+K1vIuFSz2oYAnNCc3
         76uw==
X-Gm-Message-State: ACrzQf1dBhAzR65Pqy5EL7gncsYhD+YRJI7MZAIhfgLyBQ0anDeER3sN
        14nYij1XajHjUqbkD/UzXJaPaBMSW7MGQ3y+yt7IlA==
X-Google-Smtp-Source: AMsMyM4MPo5iwnt9/uyZUkOEyDODYfwFPfvtZhgVldwit6OvWYiICMAApi9FjrsDpUuDakbUev1f+g==
X-Received: by 2002:a17:903:41c8:b0:178:3128:b58a with SMTP id u8-20020a17090341c800b001783128b58amr817759ple.118.1663267690635;
        Thu, 15 Sep 2022 11:48:10 -0700 (PDT)
Received: from localhost ([172.58.176.196])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13278432pls.33.2022.09.15.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:48:10 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:48:10 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Sep 2022 11:14:55 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
In-Reply-To: <3122575.5fSG56mABF@phil>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        rdunlap@infradead.org, wefu@redhat.com, liush@allwinnertech.com,
        guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-9664ec71-ee9f-49ac-8bea-0c36a574f60a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 05:00:08 PDT (-0700), heiko@sntech.de wrote:
> Hi Palmer,
>
> Am Samstag, 9. Juli 2022, 03:49:29 CEST schrieb Randy Dunlap:
>> RISCV_ISA_SVPBMT selects RISCV_ALTERNATIVE which depends on !XIP_KERNEL.
>> Therefore RISCV_ISA_SVPBMT should also depend on !XIP_KERNEL so
>> quieten this kconfig warning:
>>
>> WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
>>   Depends on [n]: !XIP_KERNEL [=y]
>>   Selected by [y]:
>>   - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]
>>
>> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> I think this should also be applied as fix?

Thanks, the original seems to have gotten lost somewhere but I've picked 
this up from lore.

>
> Thanks
> Heiko
>
>
>> Cc: Wei Fu <wefu@redhat.com>
>> Cc: Liu Shaohua <liush@allwinnertech.com>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> ---
>>  arch/riscv/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -362,6 +362,7 @@ config RISCV_ISA_C
>>  config RISCV_ISA_SVPBMT
>>  	bool "SVPBMT extension support"
>>  	depends on 64BIT && MMU
>> +	depends on !XIP_KERNEL
>>  	select RISCV_ALTERNATIVE
>>  	default y
>>  	help
>>
