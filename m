Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AAA67306B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjASEho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjASEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:36:53 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB77C856;
        Wed, 18 Jan 2023 20:33:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZrzidq_1674100437;
Received: from 30.0.176.247(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZrzidq_1674100437)
          by smtp.aliyun-inc.com;
          Thu, 19 Jan 2023 11:54:00 +0800
Message-ID: <80e8fc50-af91-3191-dc47-83940236a49a@linux.alibaba.com>
Date:   Thu, 19 Jan 2023 11:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v8 1/9] perf pmu: Add #slots literal support for arm64
To:     Ian Rogers <irogers@google.com>
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
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
 <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/17 下午4:45, John Garry 写道:
> On 17/01/2023 07:29, Jing Zhang wrote:
>> The slots in each architecture may be different, so add #slots literal
>> to obtain the slots of different architectures, and the #slots can be
>> applied in the metric. Currently, The #slots just support for arm64,
>> and other architectures will return NAN.
>>
>> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, which
>> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
>> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
>> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented.
>>
>> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Hi Ian,

Do you think there are other problems with this patch? Can I get your tags?

Thanks,
Jing
