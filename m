Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6D695C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBNIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjBNIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:07:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D446233CD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:07:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o18so14741384wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ciz48yn0bC9pSOawr6J2EVonTfRljnaqRRwbx5UW/W0=;
        b=TIQ23jpnzQarzd1RIe9VRIRAG/Spi2nIIoQJ/TneQakxj6QFyv7ubfVNIbXnkNccLI
         9YHADgP0ZcuahSTpp0itHxB0vnxid9R3STW2gWzzjJJRY3KVMZwyjGmKniKDMGXJnD/6
         hDCyLOAQegB/dwr9q127CSBA2/hqxOG01KsSqmOE86OrEQspfFq+Z3AKGUE1cclZrXkJ
         f+EqgIFwlzxpbPLrsLQTru1Q/+CAIVzIK+aLJtFBqFOqcw6/nRciSXI/ohQrTMnNTXcW
         9hI2Cm3He0kpAaFodIU30P6FToJ/AvzSfa+UmY2I7DpLnZCKW3ePhquo9Mo0AfQ0lt9E
         DdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciz48yn0bC9pSOawr6J2EVonTfRljnaqRRwbx5UW/W0=;
        b=rX7Yv3r++Mpd4M2Y2Ns9hVJGVHvG2P+cnGOUCE+yNs2jHVSlfNcoP1T6T2qi4XRfbs
         U/eHq1vtusQiovbwBE5MuXf6VmVe7XZ8I0Xnbojx3HEKA6FVdRhiePndbsx8Hu0tJh7R
         YmZm9hY6TeAlQFpixjBC9HdaYYL8fSEXklCwRsky0/2iTMYEW6WSOOGzymgORpK+Lpf0
         N86aFPKaRduNCtOkZfFgGgU8a+hf5T3NYSoLGIpiCg6bVBcO5y2vBJWT6G47x9Jxkz3k
         4LorAN6bKfkw6LGGGZ/gCChJ1Rx6oFyz9opbdK+jwchHw5uLrzZafbEw7wLrfoou09nM
         c8sg==
X-Gm-Message-State: AO0yUKW1L+iMhtOq1D+2hdRPAJyvUp75Ij7gM8QlAoXpUWjrAvTPwoEV
        UgAkzOv7v879uGpZDXaogHzR4w==
X-Google-Smtp-Source: AK7set/qu7AARZd3PE61K+4RewTMhIGOBtMo65cTnHm+ATiqbV6nbjgYgV5TQbegZ2uwdy9X7E8sUQ==
X-Received: by 2002:adf:e54e:0:b0:2bf:c09a:c60e with SMTP id z14-20020adfe54e000000b002bfc09ac60emr1274577wrm.2.1676362026121;
        Tue, 14 Feb 2023 00:07:06 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm12138404wrt.3.2023.02.14.00.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:07:05 -0800 (PST)
Message-ID: <6c4fc38a-ba24-fff8-7bdd-b633a79200db@linaro.org>
Date:   Tue, 14 Feb 2023 09:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 06/24] ia64/cpu: Mark play_dead() __noreturn
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
 <7575bb38417bd8bcb5be980443f99cab29319342.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7575bb38417bd8bcb5be980443f99cab29319342.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Annotate it as such.  By extension this
> also makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/ia64/kernel/process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

