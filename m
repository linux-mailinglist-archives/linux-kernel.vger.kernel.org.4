Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB2610E48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJ1KV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJ1KVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:21:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971C6111E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:21:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso9483162pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqdm7wRWhZuHaCk2KrCdOw88pP9TeeCM5JGbiZSkavs=;
        b=bzjaDeoKtCBF2LCxBdZjqfEmx06nUguRtnY8CYaMH/CLYIkuU3ow45g7dXGWfAQ8Os
         5XKYGVZwwurk8Sg+iF8ieCZijwdjWjZ6h9GNksjAaGUSNjHdQIP389mHJDGbkGaagSar
         otdpDnZPvYvcdrzfTcVQobtpuGOjGvUNAvPw78sdX2avG55bl699HHlqK3hxtBAEEHve
         CMpHjDo/FEA5S+RnHDmKVDHkq/Asb4/jC9h7W8A0hehEttOyOXRmJPe0Cy9IkkWwXbxs
         tDyR4nd9hruvYNF519hl4Pdla96UrJEU3TEHesftjeqqJZu4omaNhrJFRBuvlI1faH3s
         r4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqdm7wRWhZuHaCk2KrCdOw88pP9TeeCM5JGbiZSkavs=;
        b=wi6qFdehs40hgF7FDjxhodjqSBOezU/23Rb0n2E35CHC9EQKM3NaMzTyxkLZStm6dp
         VIfl87VTHKizdhwFVN/PfaUgCNuqeOuc33t5H3DXY1MnnK0I1+VadyJDzasLUrztSOOt
         6AgbRys5YCTZtIMOeQJ15afPPrL6Q6CHPc0f0RYALy+bvDKro3lyP9RuHQXe1lpfTD22
         de58iWYS79AQnHtjVrN9F6cl0n2/9vQz/Up/0KhakIpPsgkFOO3sKfmp3f/W+CvIm+gN
         kQ5IZ4ei4FeLEiel45tsF3ASAmZ/GNqtPZ6puSdYHupHLUeuZJ2TnkOFG4xdJK65nMUu
         gxvg==
X-Gm-Message-State: ACrzQf0uhW7KZmyadQGaUI0sNuxlzxvybOOA3CRvg0RmN8PXs/QOKYL9
        I/uwA9D8s9zFMKKQ6dEcnK+1oQ==
X-Google-Smtp-Source: AMsMyM4zW7mA5EXn00j8WljYIS8NIyzp8hGR31q3ninFTGJ1kZ93z/RgFmxVUMO6TfIlSogFbwOmzw==
X-Received: by 2002:a17:90a:e7d1:b0:213:1db:c87f with SMTP id kb17-20020a17090ae7d100b0021301dbc87fmr14642726pjb.26.1666952479318;
        Fri, 28 Oct 2022 03:21:19 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id t5-20020a654b85000000b00460d89df1f1sm2415680pgq.57.2022.10.28.03.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 03:21:19 -0700 (PDT)
Message-ID: <625ce99b-8ec3-f807-99ac-1dc32695deca@bytedance.com>
Date:   Fri, 28 Oct 2022 18:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: Regression on vcpu_is_preempted()
To:     Miaohe Lin <linmiaohe@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rohit.k.jain@oracle.com
Cc:     dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
References: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

On 10/28/22 4:48 PM, Miaohe Lin wrote:
> Hi all scheduler experts:
>    When we run java gc in our 8 vcpus guest *without KVM_FEATURE_STEAL_TIME enabled*, the output looks like below:
>      With ParallelGCThreads=4 and ConcGCThreads=4, we have:
> 	G1 Young Generation: 1 times 1786 ms
> 	G1 Old Generation: 1 times 1022 ms
>      With ParallelGCThreads=5 and ConcGCThreads=5, we have:
> 	G1 Young Generation: 1 times 1557 ms
> 	G1 Old Generation: 1 times 1020 ms
> 
>    This meets our expectation. But *with KVM_FEATURE_STEAL_TIME enabled* in our guest, the output looks like this:
>      With ParallelGCThreads=4 and ConcGCThreads=4, we have:
> 	G1 Young Generation: 1 times 1637 ms
> 	G1 Old Generation: 1 times 1022 ms
>      With ParallelGCThreads=5 and ConcGCThreads=5, we have:
> 	G1 Young Generation: 1 times 2164 ms
> 				      ^^^^
> 	G1 Old Generation: 1 times 1024 ms
> 
>    The duration of G1 Young Generation is far beyond our expectation when gc threads = 5. And we found the root cause
> is that when KVM_FEATURE_STEAL_TIME is enabled *there are much more(3k+) cpu migrations for java gc threads*. It's due to
> the below commit:
> 
>    commit 247f2f6f3c706b40b5f3886646f3eb53671258bf
>    Author: Rohit Jain <rohit.k.jain@oracle.com>
>    Date:   Wed May 2 13:52:10 2018 -0700
> 
>      sched/core: Don't schedule threads on pre-empted vCPUs
> 
>      In paravirt configurations today, spinlocks figure out whether a vCPU is
>      running to determine whether or not spinlock should bother spinning. We
>      can use the same logic to prioritize CPUs when scheduling threads. If a
>      vCPU has been pre-empted, it will incur the extra cost of VMENTER and
>      the time it actually spends to be running on the host CPU. If we had
>      other vCPUs which were actually running on the host CPU and idle we
>      should schedule threads there.
> 
>    When scheduler tries to select a CPU to run the gc thread, available_idle_cpu() will check whether vcpu_is_preempted().
> It will choose other vcpu to run gc threads when the current vcpu is preempted. But the preempted vcpu has no other work
> to do except continuing to do gc. In our guest, there are more vcpus than java gc threads. So there could always be some
> available vcpus when scheduler tries to select a idle vcpu (runing on host). This leads to lots of cpu migrations and results
> in regression.

So you want the preempted idle cpus to run gc threads to maximize the
gc throughput, but available_idle_cpu() keeps them from being selected.
In theory, load balancing will help spreading load to these cpus (and
make them VMENTERed), so have you checked that the gc threads showed a
tendency to stack on same cpus?
