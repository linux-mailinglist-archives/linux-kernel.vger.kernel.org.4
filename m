Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55872D51F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFLXpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjFLXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:45:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1F171D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:45:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso7301114a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686613545; x=1689205545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6RKBwJ1snfOShsMKSa/kdTwHRc2sX8E52+VmBrW73M=;
        b=d3xgiOjtTog0mLVt0UUF6SYGGd8ZNr4HF7QbG3ANNB0F9pm2Mnfq6cMKvB6sbMuSRV
         QgWIqQPT0Bz/c6PzgCrCP7PjhIQEf53F9Hq1ZzRfje3zYm9eFWGopD2mOQlyY3W6Ct1C
         diLMaiEHR/d2lY6XdYCuUVT8MxiBw26YRbJ+vLXKhx4eckjH/IBs8Vu650PjnGgHLZfm
         F+52i+6LlG/DNA9AL6mhi/Ytu30a/yapXnU8e4vUqRcJdEh8s8OFO1YXOUJadub+iQHv
         z6vbdQtv6OfPN8ZdleCLjbUevHZa+Wcr6lxGX03ENnGWHZ1Zg+XQGmkr7kxiw7qx+njU
         qXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613545; x=1689205545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6RKBwJ1snfOShsMKSa/kdTwHRc2sX8E52+VmBrW73M=;
        b=UGjOejJySzFKYuB0RPnFf0US56bMI6zCfvN9lkH2UOaynLePEmca8UiO7TtSfcEYGO
         DEUAMQd2fgiVfBxPlo5Q+fFH0T/o6lfl0llSNSXkYVp8XZVIbO5DI57zjYLxrEvZ+CN+
         v2jLyJJXakA/tXth+Vs3ce92PmFdi/ewJ8F/8WPyc2utJ7zgm3X3Mflujk92jjquNpYk
         LwCaZByEQ+/tUIGNx7q2XqvtiNBQ959g1IriFle96jX4VnZ2W59hrZ+ZD95AK+5tBpr8
         rMu5sdwlMJ4OFPD6wUTYV8lu9PLzbSQ4Q+f+LMibLPf9z0fz2ChkHkRr4q4OayihPZLt
         MTOQ==
X-Gm-Message-State: AC+VfDwegizaVADTGyDJrQ2ytDiBEFJwxPf7sSwbMECVglONuDevyMhg
        oHCN3G5CFNZZvGkkdtMY/jMU3A==
X-Google-Smtp-Source: ACHHUZ6dtuV5DoYQYE0R52xSIR6NpJYLC8VAvw2sPNu3DqvDkPqqCuCfv+mCrhCPNNxlAI9Ns3XUug==
X-Received: by 2002:a17:906:dac3:b0:96f:9608:da7c with SMTP id xi3-20020a170906dac300b0096f9608da7cmr11947868ejb.36.1686613544905;
        Mon, 12 Jun 2023 16:45:44 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b0097457363fc0sm5849378ejf.33.2023.06.12.16.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 16:45:44 -0700 (PDT)
Message-ID: <41b22e82-fd6c-5bcd-44ae-e5b799ed0175@linaro.org>
Date:   Tue, 13 Jun 2023 01:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [patch V4 04/37] x86/smpboot: Rename start_cpu0() to
 soft_restart_cpu()
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
 <20230512205255.662319599@linutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230512205255.662319599@linutronix.de>
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
> This is used in the SEV play_dead() implementation to re-online CPUs. But
> that has nothing to do with CPU0.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   arch/x86/include/asm/cpu.h   |    2 +-
>   arch/x86/kernel/callthunks.c |    2 +-
>   arch/x86/kernel/head_32.S    |   10 +++++-----
>   arch/x86/kernel/head_64.S    |   10 +++++-----
>   arch/x86/kernel/sev.c        |    2 +-
>   5 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

