Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65568C99D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBFWh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:37:25 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBB302BD;
        Mon,  6 Feb 2023 14:37:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id m16so2231605qvm.4;
        Mon, 06 Feb 2023 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2oBtxwWwjCPYyU17pu3lBwV9dmGFDQEYRoN+Ty55Io=;
        b=gbg0RnDrkEtPW9M9RcaDfqIaD3j5DMKgNppT25xHFz30aj9NTwFnwpbnaOLwXXhlRZ
         QOD2yBmRv+YeFmZkMj+FhGdSwVNXqCmW7skH37un5SuKUUfepwjqwXPCYumStY2RJP1U
         khj85lSeq3MEz8a0hbKrHO77vVv+3IJVswBqBvqaNW5v7961BQ6YJt7njEEoj5xry82G
         KoE7kVMauqpDG7hVLzqhTiqX/punkjXxIZ6ogZ0RIoBCEm7LTq4xvEybh0lsQWrxezF/
         s/gYh+8nSzJWTOnx4yewLISyuXcq+Sy89H36bl0rI5S9xupPWOMaMVVGcS6dYvPPHLpa
         pk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2oBtxwWwjCPYyU17pu3lBwV9dmGFDQEYRoN+Ty55Io=;
        b=g6ZsnFmeZMBUIWCk5STnS5oiyfq+/rS0Ht3apn0k3x1M4nRzC7wUoMvWRuWCvX/JQn
         gy2Zgkz2UKWDOml7qLU9P4aRduRez9wCYZuup6R2gdygmyXTtXKttVyqDMaZ8XbQW6++
         7+m8ho/7YktqKpXvmddm06+Cna/3LuwTzdD/CUpe6LADgGcV1w2Yy0EdVCQGBgFpKWdZ
         R9tbQd3P6hVdvdqNx7xApcKFNxoNPDBSYx+5JCwUjsxYfPdkT5bS5Q4Y/RRQJlyzqYYQ
         DIm//Qf2zXqJpEw4KsUdYoi9MmEnCU95J3nh648SwV7TeK1Ie5+oRY56osdJcEmTD9fp
         5hFQ==
X-Gm-Message-State: AO0yUKX8RtGiZPcx9qvGSaHyiNHvLSdSmex8LKU2XVPUSQyYlgH2otcE
        CoC4OkpG1zSpR55H44AZwA8=
X-Google-Smtp-Source: AK7set/souzQpPd5P9nDBDN5p287ExonEIT5vFztObwMnaHLBbSYhQ0mLbkJiRyT+L9bqtWvcgL78g==
X-Received: by 2002:a05:6214:400e:b0:537:7566:5098 with SMTP id kd14-20020a056214400e00b0053775665098mr1547455qvb.15.1675723041926;
        Mon, 06 Feb 2023 14:37:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b9-20020a05620a270900b0071df8b60681sm8243934qkp.94.2023.02.06.14.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:37:21 -0800 (PST)
Message-ID: <7a21e1fe-82ac-6285-ceaf-6450a7ee4325@gmail.com>
Date:   Mon, 6 Feb 2023 14:36:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/22] mips/cpu: Mark play_dead() __noreturn
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
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <829d68d289ad4eeac27c5220be695cfa6ace33f4.1675461757.git.jpoimboe@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <829d68d289ad4eeac27c5220be695cfa6ace33f4.1675461757.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 14:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Annotate it as such.  By extension this
> also makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

