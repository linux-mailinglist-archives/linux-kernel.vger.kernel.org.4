Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A2C68CD10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBGDEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBGDDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:03:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E361B2;
        Mon,  6 Feb 2023 19:03:37 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9nxz6qR0zfYyd;
        Tue,  7 Feb 2023 11:03:19 +0800 (CST)
Received: from [10.67.101.98] (10.67.101.98) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 11:03:35 +0800
Message-ID: <08a68444-efb0-9d2e-7e70-0e495ad6ddc1@hisilicon.com>
Date:   Tue, 7 Feb 2023 11:03:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH v1 1/4] docs: perf: Add documentation for HiSilicon
 PMCU
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <jonathan.cameron@huawei.com>
CC:     <zhangshaokun@hisilicon.com>, <shenyang39@huawei.com>,
        <hejunhao3@huawei.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <suntao25@huawei.com>,
        <jiazhao4@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
 <20230206065146.645505-2-zhanjie9@hisilicon.com>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230206065146.645505-2-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.98]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/2023 14:51, Jie Zhan wrote:

> +
> +2. Profiling with ``perf-record``.
> +
> +   The command to start the sampling is::
> +
> +        perf record -e hisi_pmcu_sccl3/<configs>/
> +
> +   Users can pass the following optional parameters to ``<configs>``:
> +
> +   - nr_sample: number of samples to take. This defaults to 128.
> +   - sample_period_ms: time interval in microseconds for PMU counters to keep

Spot a typo before causing any confusion. This should be "milliseconds" 
rather than "microseconds".

Jie

> +     counting for each event. This defaults to 3, i.e. 3ms, and its max
> +     value is 85,899, i.e. 85 seconds.
> +   - pmccfiltr: bits 31-24 of the sysreg PMCCFILTR_EL0, which controls how the
> +     cycle counter increments. This defaults to 0x00. Please refer to the
> +     "Performance Monitors external register descriptions" of *Arm Architecture
> +     Reference Manual for A-profile architecture* on how to configure
> +     PMCCFILTR_EL0.
> +
> ...
