Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8964E206
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLOT4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:56:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FF2CCA3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:56:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o12so248183pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=it0uTRBQhUXDracpaZxA5Z7G29uVq/1PiUNU//RAySE=;
        b=LeUibo5bBRVt9ARvHtnOzL8dVYOmkno+cXXhc8T9DGWnTtVq4uo3scjYpgTfG5ZZZf
         PmxQNmQQ0XTPF6MNXh4pYdHI400ISfgkAfc7pTj5cLsBDUR5nhpNPKDZRr7VdpbK0O2A
         wqfukHETveeeWyb3yUTQag7RQ/lo3X93LVksk6Qitd/KuIzmEt5CPWWshugflKYneENG
         EepsGWVPtd27YsuuBCsDnxAydFwcfktBhmI1Yxrx7ExrzLMX6YulPeIWjKY1D1pHDxyX
         TCZPIr0QvlffQqRoATrQxulIn3rFFPTc27c5DEuwNQfpJTvB9EBwa7tHxautBdVex/Re
         J6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it0uTRBQhUXDracpaZxA5Z7G29uVq/1PiUNU//RAySE=;
        b=kqcU2Ccjoy8LGPatKOHInnLvJxV2ZB/MXMIGXHpCdS8jDFhP+6qJ4CQps/dmyNSbKQ
         Fd1ajUJEfqZpneSBAB/w3AJ1oXHKfc1pvvFS4b3vJTF5AcQGLz4uXxClP8nZ5NFAH0t5
         mnGhJIJsiF+LeALV+gBHMVrx5RyoqL1G2HCcKrLKQ2ERxvJ6DlQpDWyUCXw+X9WqTjaS
         krFXmQ/COlNrjC9IwocC4HgoWwiWLgcIWow7G/Sm2btAK4Ya5a/Cn4flol+l5P15CaHI
         nadLExAOcLL3wQ5P/1+dATG1AdCmhAtNrzOjG8+8ex/kjRjnUOwaNPsDuPDBxqh13UDU
         geYA==
X-Gm-Message-State: ANoB5pnq3J5eyylszwSHDR9fZHbyui+NI4ubxVw15Pq/iRen09/d7PTm
        YICtIbqvgSW5jJDvE59HmCTvZQ==
X-Google-Smtp-Source: AA0mqf6LDsbWUosYATxNBqxNJIgG35kSDFZiFI0WxSYWYNDRcvMizdUBYVJf30FbwMW6NQPmjtfQSQ==
X-Received: by 2002:a17:902:b708:b0:189:9dca:65e1 with SMTP id d8-20020a170902b70800b001899dca65e1mr26955860pls.21.1671134175155;
        Thu, 15 Dec 2022 11:56:15 -0800 (PST)
Received: from ?IPV6:2602:47:d48c:8101:a80f:54a1:edc3:6cb4? ([2602:47:d48c:8101:a80f:54a1:edc3:6cb4])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b00182d25a1e4bsm7816pln.259.2022.12.15.11.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 11:56:14 -0800 (PST)
Message-ID: <37dbef55-fd78-91db-33fb-ca1691fe1cc6@linaro.org>
Date:   Thu, 15 Dec 2022 11:56:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Vineet Gupta <vineetg@rivosinc.com>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        libc-alpha@sourceware.org, christoph.muellner@vrull.eu,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
 <Y5qByfCtpV0uNID3@bruce.bluespec.com>
 <877cysx4yf.fsf@all.your.base.are.belong.to.us>
 <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
 <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org>
 <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 10:57, Vineet Gupta wrote:
>> The other thing of note for SVE is that, with the default function ABI all of the SVE 
>> state is call-clobbered, which allows the kernel to drop instead of save state across 
>> system calls.  (There is a separate vector function call ABI when SVE types are used.)
> 
> For the RV psABI, it is similar - all V regs are caller-saved/call-clobbered [1] and 
> syscalls are not required to preserve V regs [2]
> However last I checked ARM documentation the ABI doc seemed to suggest that some (parts) 
> of the SVE regs are callee-saved [3]

As Pinski mentioned, just some low bits that overlap with scalar fp state; the high bits 
and the predicate registers gets zeroed when re-enabling.


>> So while strcpy may enable SVE for the thread, the next syscall may disable it again.
> 
> Next syscall could trash them, but will it disable SVE ?

Yes.  See fp_user_discard() in arch/arm64/kernel/syscall.c.


r~
