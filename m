Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636672D531
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbjFLXtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjFLXt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:49:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2E1718
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:49:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9823de726c3so10690966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686613766; x=1689205766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdDi50ZcI/FLwaJCGeRMVNgmMDqblajVGcvGtWq/rU0=;
        b=h14Y/off+2kKH+CZ9xuEqnth8dkIR68MU6fTRlm6+a1ccdcM0M0IsU1vvHNgsK8p2Y
         0C3NyMHNpdoVINJwXJ2UsLvgZ4NTbFLvy78i26qPyTkArpsvqQO8P3rqJaQrm8rGzPXS
         b21ZAicO32Ry1R7mkMJ6NNUImtgdcpa22tAe3I7ZxvHegVAwZ0w/UvF0S48EVuSzeqn9
         b3JjK1ZAX8STmHG870Zb54I4LTDZcNLOHVNCHnZhE6ryjThlXIgkPKnQSaTbHbmt0aPo
         YIMzeRPPStNBrG12bFe/IsSOLZJnGkaCG+swAqxSi4tHTnfqr5byW4FG9+MbQBtCjN2v
         e6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613766; x=1689205766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdDi50ZcI/FLwaJCGeRMVNgmMDqblajVGcvGtWq/rU0=;
        b=fVYm43+OBQZdgXYs18Z/mCfl3XlOsbrfWPrOnFoXDFey3ltcdQdBBVLi9IXMRgPqNJ
         BsNUhAgI88O+WcdmkhSlh7TKhWvXgsgsUin8h12RoWWkNLlUsqSxdhalu0WEmoWR4dWY
         14K7qfnyLpokNAHveHqfSZ9ZkKFZ11Zjya0USXZ1fpdYBmVWDr68Iw05Kl58rlFcjZtg
         IzHzLmT+3RHYYvWqFn+soIqq/RlWevj57dRikhFn9sYlXKmofSE0VztcHtVTZGrRMGo/
         HhQNO4Yf59+kueEZr8Qj9C6t7hI0924dOGEstLxrsEU4pRPsPXagd78RPnaX9DXXvBub
         8cig==
X-Gm-Message-State: AC+VfDzf1beqCgXu6nt7fFVB9LRFFdoVCmcZRAMxqTuD7EBjPhWKNR5/
        pbK1mQo4MgQi02zLWRrR9dfntw==
X-Google-Smtp-Source: ACHHUZ5d+tF+AAPixk/kFmtV+CtWpDVmOxGFS7Q1zOS4cdYHHVXnx1KgJdGHPbzDoYU+p/rh+kAXUw==
X-Received: by 2002:a17:907:7207:b0:978:9e92:f903 with SMTP id dr7-20020a170907720700b009789e92f903mr11221800ejc.46.1686613765790;
        Mon, 12 Jun 2023 16:49:25 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7c854000000b005169cd0edffsm5568532edt.35.2023.06.12.16.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 16:49:25 -0700 (PDT)
Message-ID: <94b05905-df3a-4534-a28c-fe9e3030fc4a@linaro.org>
Date:   Tue, 13 Jun 2023 01:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [patch V4 10/37] x86/smpboot: Get rid of cpu_init_secondary()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230512203426.452963764@linutronix.de>
 <20230512205255.981999763@linutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230512205255.981999763@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 23:07, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The synchronization of the AP with the control CPU is a SMP boot problem
> and has nothing to do with cpu_init().
> 
> Open code cpu_init_secondary() in start_secondary() and move
> wait_for_master_cpu() into the SMP boot code.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   arch/x86/include/asm/processor.h |    1 -
>   arch/x86/kernel/cpu/common.c     |   27 ---------------------------
>   arch/x86/kernel/smpboot.c        |   24 +++++++++++++++++++-----
>   3 files changed, 19 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

