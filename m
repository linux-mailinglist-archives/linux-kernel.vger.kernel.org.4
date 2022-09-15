Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E95BA0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIOSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIOSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:48:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAE19AFDE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c24so18109755pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=h5DTL7oH+KVv8W9OANhLDq/eEU8+rMvltJTQ0sX4/88=;
        b=ptRUiqRv6pME8tf8IehTSm6eyeTK1pWfLivueDJzy2ZeV+SnLfNPhxce8bDYX4xmaB
         RfaYVaZ5IgMFohUnhXsaIvCWtbvRR4+kuzBYNMTYVNpgYPkww76pl1YGga1oQ7De+NoT
         nEeE9KtCvlmNmdkC1eu3JKJwqZ1zPDKQQwrnNLzoYOkhKSf8UB748dTR0Yk1A3PNekn1
         jxwF+GA+MzgrqE2qctcRstNJqLmVFBS7nHnnnVGmMedpw+sNyezu4sb8VBa0vP3C5eHo
         V7wgjBh9E3X/iH2JwiLDgEAAhVHPgGkEWnmTiAsSxuEqpJ4mu/hTpBOE18BHfpJWpcan
         ChKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=h5DTL7oH+KVv8W9OANhLDq/eEU8+rMvltJTQ0sX4/88=;
        b=aIPuvhekLt8ju1zkgrSQ72ddWRm0kB632CeOMouADMqV2FRCmW2mfcQa98RgPRdVpg
         sVg9UhQQyGpqS7J7xdGVeaZfAuMTxrvGDXIi6AUJFFZ3CiN+rF7kMIjOK75ew04Z4Ls5
         mJZNpNvg4dTSvCShZqHPQEWYO/xIczV3BFSmU3VZvwUXbP9MB0E7JgTM6yAce5rNEb5f
         WaakxANcMXKvBUn3rH1ugw3RbUKdMXAiEbiU8IRAXSrGxgj4rxjAesvodh/r/pHFioAs
         j1WOb6SAfB3EJ+1zRWkmLAwk61N1ys8ql6PyllOlVWV6EAvKrZz0D1vyu2lDBKQ/jH9O
         sMTA==
X-Gm-Message-State: ACrzQf0FLCmmkBww+JvnoRXiAJ5YIGY2W297xYURmZStPmRD7ojBX0C1
        ik/st6gvwpZlj/HPlIp9kvtxc9s7X6H5zw+Oo3fGWQ==
X-Google-Smtp-Source: AMsMyM5UV3TrmubAJVX1TGGUkZKk1VLk+6jJeU7s7s0T92cTpmf7yEMkLPuVeAcbI5b3SclEX1amdQ==
X-Received: by 2002:a05:6a00:b42:b0:544:a61b:75e3 with SMTP id p2-20020a056a000b4200b00544a61b75e3mr1212077pfo.26.1663267696990;
        Thu, 15 Sep 2022 11:48:16 -0700 (PDT)
Received: from localhost ([172.58.176.196])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b0017870f471f6sm1914488pls.226.2022.09.15.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:48:16 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:48:16 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Sep 2022 11:14:57 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
In-Reply-To: <3122575.5fSG56mABF@phil>
CC:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        rdunlap@infradead.org, wefu@redhat.com, liush@allwinnertech.com,
        guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-92e4749c-ea48-4fb3-961d-581e948e1bf9@palmer-ri-x1c9>
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

Thanks, this is on fixes.
