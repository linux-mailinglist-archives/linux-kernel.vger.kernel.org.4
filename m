Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7982D60754F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJUKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:47:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40B25F1E4;
        Fri, 21 Oct 2022 03:47:20 -0700 (PDT)
Received: from frapeml500004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mv1Mb2jFBz688Yy;
        Fri, 21 Oct 2022 18:45:31 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 12:47:18 +0200
Received: from [10.126.168.107] (10.126.168.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:47:17 +0100
Message-ID: <dcf5d62d-8163-dfee-a6b7-e75207650551@huawei.com>
Date:   Fri, 21 Oct 2022 11:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf vendor events: Add Arm Neoverse V2 PMU events
To:     James Clark <james.clark@arm.com>,
        <linux-perf-users@vger.kernel.org>, <acme@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <nick.forrington@arm.com>,
        <al.grant@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221020134512.1345013-1-james.clark@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221020134512.1345013-1-james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.168.107]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 14:45, James Clark wrote:
> Rename the neoverse-n2 folder to make it clear that it includes V2, and
> add V2 to mapfile.csv. V2 has the same events as N2, visible by running
> the following command in the ARM-software/data github repo [1]:
> 
>    diff pmu/neoverse-v2.json pmu/neoverse-n2.json | grep code
> 
> Testing:
> 
>    $ perf test pmu
> 
>    10: PMU events                                           :
>    10.1: PMU event table sanity                             : Ok
>    10.2: PMU event map aliases                              : Ok
>    10.3: Parsing of PMU event table metrics                 : Ok
>    10.4: Parsing of PMU event table metrics with fake PMUs  : Ok
> 
> [1]:https://github.com/ARM-software/data
> 
> Signed-off-by: James Clark<james.clark@arm.com>
> ---

This looks ok. Out of curiosity, do you know how the naming works for 
these neoverse cores? Were "n" a predecessor to "v"?

thanks,
John
