Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558E472D743
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbjFMCLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjFMCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:11:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043D131;
        Mon, 12 Jun 2023 19:11:09 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QgBjw0w54z18Lj4;
        Tue, 13 Jun 2023 10:06:12 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 10:11:06 +0800
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
 <ZIcqmlHIfBbyZFDl@kernel.org>
 <20230612150553.GM4253@hirez.programming.kicks-ass.net>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <47f5ddbd-f1cb-1da7-cfca-af67962e6797@huawei.com>
Date:   Tue, 13 Jun 2023 10:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230612150553.GM4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/6/12 23:05, Peter Zijlstra wrote:
> On Mon, Jun 12, 2023 at 11:24:26AM -0300, Arnaldo Carvalho de Melo wrote:
>> But could you please spell out the use case, why do you need this, is
>> this so common (for you) that you repeatedly need to first taskset, then
>> perf, etc?
> 
> I'm thinking this is due to big.LITTLE things where the PMUs on the CPUs
> are different. Intel recently having stepped into this trainwreck,
> there's now a ton more people 'enjoying' it ...
> 
> So what people often do it is affine the process to one type of CPU and
> then perf it so that their measurements are consistent.
Yes, it's a scene, the purpose of setting affinity is to ensure the 
stability of recorded events.

> 
> It all sucks, but given the situation, it might be the best option :/
> 
> Ian was working on improving the whole hybrid thing, perhaps he has more
> opinions.
>
Thank you for your reply.

> .
> 

Thanks,
Yang.
