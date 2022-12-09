Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A548647D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 06:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLIFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 00:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIFQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 00:16:10 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973F8742C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 21:16:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so2825091pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 21:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TNCQdSlF+qsMghK/FM4K8rIWZD0ncbkYlLlxttfovI=;
        b=suiv9qug5Adb0eMaIprUh9NKoS/B+KQyfcJI7OYZ/zf81FqIIIL1VZU6HxxomuHzvI
         iEIA7fjtmzYPo9EnLHZcNpHdXvvZbfEgNAJrj5D4BIW9gZ1dCYGhJO8vJzuqv1BYaoby
         tmpLQQPeVpTK5PKU0oK6PcxSYvLNkLcVqlE5oSSAfGwLBRktfF05dhP/tOuX04b/85u0
         hypBKWMmn0geGAsxmepvy6s7I2NgqliOO+Of3Ez995nOfGa6aRrbVyYMZ3vpEd+dDExA
         LM79ti2lm2qshfDCsKPQba9vnvodXKkX+XzvT/pEh3OInKDhIPVhgNDhgJD2YfXLnLLu
         mXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TNCQdSlF+qsMghK/FM4K8rIWZD0ncbkYlLlxttfovI=;
        b=nTTU1XzshW73VVcxFcUwRZ9/DY+pPQC84gVknB75H+qnyKcHxXNPosrEFQ53xI/MbD
         GyjkyRlPLUERabW8hWkrMvPFelDyFVCkftPTPzUmSjMWAey8QjmD6BEFRS9byW85ia0+
         RHTYTpEIWCr7xxyqkZZm7XKBe19sghVKc9KJ53FxdZfNE2BTu74oYAtZcgHHCCBZjHhB
         RLqVv0gdFiMxKsTCyAWZ5WyZbxcKteRS8IWiS7fRYin2SQWaVoLN33KEcJKNq0tLSA6/
         dsJ0KAfbJ4ogyCnJi4XzyScBfezv/aGQ8erwQp7eUPKojOG5mgWHXdHk3yM9FwKQoOzi
         bh0A==
X-Gm-Message-State: ANoB5pkJMFKD8k9/n8mTfW2HNAKnBaheiCf26Uv0TEBGBT/I7s4l7zHf
        ul0fXfPRbxv9btVAWRy0nR/Cew==
X-Google-Smtp-Source: AA0mqf7l7oU3d/2VxdeXfJvnF8MqC2v+sx+S7UVRsn3hq8tf/RxnvOplkk1cnP11s5aAbL44ozs/QA==
X-Received: by 2002:aa7:8589:0:b0:56d:74bf:3265 with SMTP id w9-20020aa78589000000b0056d74bf3265mr3720542pfn.19.1670562969384;
        Thu, 08 Dec 2022 21:16:09 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id x11-20020a62860b000000b005623f96c24bsm368221pfd.89.2022.12.08.21.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 21:16:08 -0800 (PST)
Message-ID: <b1dae947-d52a-d28e-5ddc-c1ad6d29828c@rivosinc.com>
Date:   Thu, 8 Dec 2022 21:16:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: RISCV Vector unit disabled by default for new task (was Re: [PATCH
 v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>,
        Arnd Bergmann <arnd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?Q?l?= <bjorn@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-17-stillson@rivosinc.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20220921214439.1491510-17-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darius, Andrew, Palmer

On 9/21/22 14:43, Chris Stillson wrote:
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>
> @@ -134,7 +135,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>   			if (WARN_ON(!vstate->datap))
>   				return;
>   		}
> -		regs->status |= SR_VS_INITIAL;
>   

Perhaps not obvious from the patch, but this is a major user experience 
change: As in V unit would be turned off for a new task and we will rely 
on a userspace prctl (also introduced in this patch) to enable V.

I know some of you had different opinion on this in the past [1], so 
this is to make sure everyone's on same page.
And if we agree this is the way to go, how exactly will this be done in 
userspace.

glibc dynamic loader will invoke the prctl() ? How will it decide 
whether to do this (or not) - will it be unconditional or will it use 
the hwcap - does latter plumbing exist already ? If so is it AT_HWCAP / 
HWCAP2.

Also for static linked executables, where will the prctl be called from ?

[1] https://sourceware.org/pipermail/libc-alpha/2021-November/132883.html
