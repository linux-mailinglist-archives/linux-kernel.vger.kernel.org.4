Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9081663E65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbjAJKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbjAJKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:38:15 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47595D2CC;
        Tue, 10 Jan 2023 02:38:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VZIue7U_1673347087;
Received: from 30.221.147.136(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZIue7U_1673347087)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 18:38:09 +0800
Message-ID: <a66a81be-4695-7756-9ba1-c970d8f45b9c@linux.alibaba.com>
Date:   Tue, 10 Jan 2023 18:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v6 1/7] perf vendor events arm64: Add common topdown L1
 metrics
To:     John Garry <john.g.garry@oracle.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673017529-1429208-2-git-send-email-renyu.zj@linux.alibaba.com>
 <7f60c97a-18df-4f93-0e95-2a9a6dccbda7@oracle.com>
 <c2e5f9d7-c6d8-c70a-8eff-a8e1c5fcf0af@linux.alibaba.com>
 <758b66bb-6f9e-8a9a-8b0f-10cd79a65613@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <758b66bb-6f9e-8a9a-8b0f-10cd79a65613@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/9 下午10:58, John Garry 写道:
> On 09/01/2023 02:53, Jing Zhang wrote:
>> I'll factor out the pmu_core__find function in tools/perf/arch/arm64/util/pmu.c:
>>
>> static const struct perf_pmu *pmu_core__find(void)
> 
> maybe name as pmu_core__find_same() or similar to indicate that we're only dealing with homogeneous cores
> 
>> {
>>     struct perf_pmu *pmu = NULL;
> 
> no need to init to NULL
> 
>>
>>     while ((pmu = perf_pmu__scan(pmu))) {
> 
> 1x superfluous level of ()
> 

Ok, will do, Thank you!
