Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5A723314
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjFEWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFEWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:20:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDECF7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:20:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230605222043euoutp02abd4e92e510c3116cace198d1c730462~l42FucyR61941619416euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:20:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230605222043euoutp02abd4e92e510c3116cace198d1c730462~l42FucyR61941619416euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686003643;
        bh=Q//Jtp2ejMvA0XmdCrXNlxI7ghs84mIgZ2iSvb24Uxg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=GccZSeDGlaOncl4BnXFtiARinNV1Z1pQc4rlstTrdDeXDGCle6vXOxic75tVeFhNa
         /xZ7r7NTKD36VHd5KJxz3beFQ+un7bpLcnrR9pe3+8nYTqVgYBFp+SKWfVqcCYhQ9r
         PazrfU9B/6uhtVQ6xwDGyKCN9K15j1Xs57lbc/xk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230605222042eucas1p217a65278e0915a30ea6857f734e4e5b3~l42FYhUPw0828808288eucas1p21;
        Mon,  5 Jun 2023 22:20:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.59.37758.ABF5E746; Mon,  5
        Jun 2023 23:20:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605222042eucas1p223d15a82ce8fad86851a97a8fc09bb54~l42E8Pp2a0801008010eucas1p2Y;
        Mon,  5 Jun 2023 22:20:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605222042eusmtrp1c368e8e2b59be845eef91088639682d2~l42E7rk4b1888318883eusmtrp1j;
        Mon,  5 Jun 2023 22:20:42 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-4b-647e5fba820d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.8C.14344.ABF5E746; Mon,  5
        Jun 2023 23:20:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230605222041eusmtip10c45b697fe130a6430d7d4a44ea5a170~l42EkUsTc1011110111eusmtip1g;
        Mon,  5 Jun 2023 22:20:41 +0000 (GMT)
Message-ID: <0e7ce2a1-12da-bc35-8582-a50ce9fb6580@samsung.com>
Date:   Tue, 6 Jun 2023 00:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230605190746.GX83892@hirez.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd1d8XUpBv/3allc3jWHzeL8mVXs
        Fsd7DzBZ/Fp+lNHix4bHrA6sHptXaHlsWtXJ5vF5k1wAcxSXTUpqTmZZapG+XQJXRsfy4IKv
        MhWvr35ka2B8Kt7FyMEhIWAiMXuuahcjF4eQwApGiZ7mJ8wQzhdGib1zFrJAOJ8ZJU6eecgG
        09F1MAIivpxR4sLSi6wQzkdGiVs/TgG1c3LwCthJ/Gg/B2azCKhInN/bzA4RF5Q4OfMJC4gt
        KpAqsfvaAVYQW1jAS2L2lXY2EJtZQFzi1pP5TCC2iICmxMq2+1DxAonrOy+CzWETMJToetsF
        FucUcJVo/riEEaJGXqJ562ywFyQEdnBIvFm2GSwhIeAisX75SRYIW1ji1fEt7BC2jMTpyT0s
        EA3tjBILft9ngnAmMEo0PL8F1W0tcefcL7D/mYFOWr9LHyLsKHF6fj8TJFj4JG68FYQ4gk9i
        0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIwTILyfuzkLwzC2HvAkaWVYziqaXFuemp
        xcZ5qeV6xYm5xaV56XrJ+bmbGIFp5fS/4193MK549VHvECMTB+MhRgkOZiUR3l1e1SlCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamKRubr6c6/RiGt+s
        +uzDsR52xxYq6uvt2zJ3X73NNK2pT8InhccFLtr1cs5yZ7eIumSeo3+vOd9qrNlQxXzogKbX
        xa87L6h1JJ+RXPrk712Gliv35bbuPfGdu3rqjyWV33372oO3/j1zSOKz37Wj6uHOTFsLPWR0
        U4X2h01vavlTuFXm4tZLgaKyvA7Ctj6PbJ+nb0yu27+gKpmhc3/OtzNyV5z83NYYJK59NV1g
        1vd8wQsbIryWs3nukH7unXaHZ9vmH6mte2t6DV9fFDk5b937M/HLLvuzC27kqzJjL/w6J5ZB
        zavrhIC5VlONetOp+/an+jftn7TK3mFZ3N33Hy60rbzi+jXQLZJ7pwDv+/9KLMUZiYZazEXF
        iQBfmZuzmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7q74utSDCYu57G4vGsOm8X5M6vY
        LY73HmCy+LX8KKPFjw2PWR1YPTav0PLYtKqTzePzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jI7lwQVfZSpeX/3I1sD4VLyLkYNDQsBE
        outgRBcjJ4eQwFJGiYXnbEFsCQEZiZPTGlghbGGJP9e62LoYuYBq3jNKfLp7GizBK2An8aP9
        HDOIzSKgInF+bzM7RFxQ4uTMJywgtqhAqsTdJf1sILawgJfE7CvtYDazgLjErSfzmUBsEQFN
        iZVt96HiBRIHbn6HWtbBJHF9z06wIjYBQ4mut11gRZwCrhLNH5cwQjSYSXRt7YKy5SWat85m
        nsAoNAvJHbOQ7JuFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNo27GfW3Yw
        rnz1Ue8QIxMH4yFGCQ5mJRHeXV7VKUK8KYmVValF+fFFpTmpxYcYTYGBMZFZSjQ5HxjJeSXx
        hmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTPa9x+Z+X8BZLFPFPsNs
        ZqShuLuxodjHbcrLDfyOMkpvOH5k8eM7nbWT/zZFTvJ0FQuZOkvqgD6HQEPFf7d1ajvXLPC+
        qKHIfGZZj8Sr3KbSv+eCdoq0L+ZyjtLdd6564afrQiJ7p124/MDQrv9N6uns8sa8xxaKO/wF
        P91k6OWtZtrJKpX51sVaq/lcytaH63VWi3yP2J7WcNWwIOirQhvbhO+MfZN065dsYf7793js
        j6cLPk755bRoi8rB0sfcOwqd7Gf4f7oQ1P6I88XshxuXmNV92pGW2n7i4KV2HqnTq2W25Ws+
        z9PWzWfZ2CzYlSnKypOxIz/9VuryB6vPnI6puTtl6UnP+RnsWe78JkosxRmJhlrMRcWJAI8y
        CpssAwAA
X-CMS-MailID: 20230605222042eucas1p223d15a82ce8fad86851a97a8fc09bb54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
        <CGME20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca@eucas1p2.samsung.com>
        <3051ad44-0ac3-e77b-3178-fac7cac3b3f2@samsung.com>
        <20230605190746.GX83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2023 21:07, Peter Zijlstra wrote:
> On Mon, Jun 05, 2023 at 05:25:30PM +0200, Marek Szyprowski wrote:
>
>> nfortunately it causes
>> regression on my ARM 64bit Exynos5433-based TM2e test board during the
>> CPU hotplug tests.
> Can you elucidate an ARM illiterate on the actual topology of that
> machine?

Please check arch/arm64/boot/dts/exynos/exynos5433.dtsi This is typical 
ARM big.LITTLE machine with 4 'big' (Cortex-A53 in this case) cores in 
one cluster and another 4 'LITTLE' (Cortex-A57) in the latter.


>> CPU: 6 PID: 43 Comm: cpuhp/6 Not tainted 6.4.0-rc1+ #13640
>> Hardware name: Samsung TM2E board (DT)
>> pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : __bitmap_and+0x4c/0x78
>> lr : select_idle_cpu+0x64/0x450
> Btw, where is lr at? Is that perhaps per_cpu(sd_llc) being NULL  or
> something?

If I get it right:

# aarch64-linux-gnu-objdump -Sld --start-address=0xffff8000080e7064 vmlinux

ffff8000080e7064 <select_idle_cpu>:
...
select_idle_cpu():
kernel/sched/fair.c:6987
                 sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
ffff8000080e70c8:       f8747b21        ldr     x1, [x25, x20, lsl #3]
ffff8000080e70cc:       f0010340        adrp    x0, ffff80000a152000 
<kvm_hyp_ctxt+0x7a0>
ffff8000080e70d0:       91302000        add     x0, x0, #0xc08
ffff8000080e70d4:       f90047e0        str     x0, [sp, #136]
ffff8000080e70d8:       f8616814        ldr     x20, [x0, x1]
ffff8000080e70dc:       9442c570        bl      ffff80000919869c 
<debug_lockdep_rcu_enabled>
ffff8000080e70e0:       350017a0        cbnz    w0, ffff8000080e73d4 
<select_idle_cpu+0x370>

This kvm_hyp_ctxt smells a little bad here, because this board boots 
directly to EL1, so no hyp/kvm is used. This is relevant dmesg part:

--->8---
smp: Brought up 1 node, 8 CPUs
SMP: Total of 8 processors activated.
CPU features: detected: 32-bit EL0 Support
CPU features: detected: 32-bit EL1 Support
CPU features: detected: CRC32 instructions
CPU: All CPU(s) started at EL1

--->8---


>>> ---
>>>    kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
>>>    kernel/sched/features.h |  1 +
>>>    2 files changed, 39 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 48b6f0c..0172458 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>    }
>>>    
>>>    /*
>>> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
>>> + * local LLC comes up empty.
>>> + */
>>> +static int
>>> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>>> +{
>>> +	struct sched_domain *parent = sd->parent;
>>> +	struct sched_group *sg;
>>> +
>>> +	/* Make sure to not cross nodes. */
>>> +	if (!parent || parent->flags & SD_NUMA)
>>> +		return -1;
>>> +
>>> +	sg = parent->groups;
>>> +	do {
>>> +		int cpu = cpumask_first(sched_group_span(sg));
>>> +		struct sched_domain *sd_child;
>>> +
>>> +		sd_child = per_cpu(sd_llc, cpu);
> IOW, sd_child end up NULL?
>
>>> +		if (sd_child != sd) {
>>> +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
>>> +			if ((unsigned)i < nr_cpumask_bits)
>>> +				return i;
>>> +		}
>>> +
>>> +		sg = sg->next;
>>> +	} while (sg != parent->groups);
>>> +
>>> +	return -1;
>>> +}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

