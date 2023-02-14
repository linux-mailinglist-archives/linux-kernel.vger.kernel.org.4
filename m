Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C59695F06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBNJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjBNJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:26:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DA4241FB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:25:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so14900079wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDxRPg0tzmSlpSdGNasFtKDU/RizntlcLVEvFLg/3J0=;
        b=NES+X0jitlSFN9CMyxtOBnwXvr4UEkpCwjSf8ktPB+wXMhbktMrNUflH+JM2ssaH9K
         1szwzK+H0w1R1obMWrGYq2h5EqmbiN8TzRSCSDfQ0xIRnMtUM0YXe0sOqWpLCMwXuGjf
         pq5Tp+btAH/Jp2UMc+IUaq03lyRqROMWnwZHj0SyNjg2aEHISp2YzMuCIH2fFqgRFL2C
         nh8rUW+D8G8ohs7qk9rK8//cKtczB59ooJFvWHa+cMfxk4FIJRL/sUbUY+TwB9aq5oQ6
         5XNgdahaS2tg0VmMYr3n7xy9L8AkuRxwtGbyTzFH3A9vsOSJ49wrhdrqe9fR4BHUPm/1
         +QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDxRPg0tzmSlpSdGNasFtKDU/RizntlcLVEvFLg/3J0=;
        b=mSEw5W+jksaN6USjIfxhthNzDj6b1ssdQG/LV61TQP8TtmrVDfpAWGhJrZlrRCUTR1
         jfURQtzXtiN7CC8nk9fYd21aKhfb+BGAWfnmNaYZDVN5jbY/uDNNu8mBr1N80ZWe0SM6
         z2ezZjKnTej8U9Z6E2RkDQUh6EWqkbaSt6d6kcGWE46zdQtNGj5oSCnSYHSPdblvr9c8
         RR/Ja0w07R7nUlCsHd8MmELU/1BlIsStkPSlhZ/XGjQLHfLuxvSxllooTJQjXw5FMl8R
         145aemTlqQROxFuwNciT8h0BvqPa+ZCIQIr2vw2eQsuqCxaJyvLPflGeQxrRlHLJkC5l
         STTQ==
X-Gm-Message-State: AO0yUKV1KvQbwzpwYDP4rthFOxSRASFq7eL+wmTHxdkVTpZ3EK0Z8+jg
        d5jl2U4TSGryuWgg3LjgjCDptg==
X-Google-Smtp-Source: AK7set/9MnT573XDoeCr+EYDww6Z0dgS8IXweDvdGBdO2qa8Cb9d8o+MYY77g+qurwoNXDnWtaacEA==
X-Received: by 2002:adf:e9c5:0:b0:2c5:4dbf:587 with SMTP id l5-20020adfe9c5000000b002c54dbf0587mr1635221wrn.57.1676366753443;
        Tue, 14 Feb 2023 01:25:53 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d6dcf000000b002c3f9404c45sm12906865wrz.7.2023.02.14.01.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:25:53 -0800 (PST)
Message-ID: <a48ebe98-82b5-8f7b-8327-4e60bdb231c8@linaro.org>
Date:   Tue, 14 Feb 2023 10:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 00/24] cpu,sched: Mark arch_cpu_idle_dead() __noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> v2:
> - make arch_call_rest_init() and rest_init() __noreturn
> - make objtool 'global_returns' work for weak functions
> - rebase on tip/objtool/core with dependencies merged in (mingo)
> - add acks
> 
> v1.1:
> - add __noreturn to all arch_cpu_idle_dead() implementations (mpe)

Possible similar candidates: panic_smp_self_stop, nmi_panic_self_stop
and kexec.

