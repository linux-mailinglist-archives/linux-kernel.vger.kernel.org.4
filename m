Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FE673021
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjASE0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjASD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:57:04 -0500
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B75EF86;
        Wed, 18 Jan 2023 19:55:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VZs-RX4_1674100188;
Received: from 30.0.176.247(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZs-RX4_1674100188)
          by smtp.aliyun-inc.com;
          Thu, 19 Jan 2023 11:49:50 +0800
Message-ID: <b9efa4d1-2223-7f8f-ed89-62069d9d91bf@linux.alibaba.com>
Date:   Thu, 19 Jan 2023 11:49:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v8 1/9] perf pmu: Add #slots literal support for arm64
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
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
 <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

Thank you John!
