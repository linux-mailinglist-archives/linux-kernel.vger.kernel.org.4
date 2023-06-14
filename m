Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0A72F278
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFNCMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNCMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:12:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9F198D;
        Tue, 13 Jun 2023 19:12:11 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qgphc3R2Bz18M7s;
        Wed, 14 Jun 2023 10:07:12 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:12:08 +0800
Subject: Re: [PATCH v2] perf stat: Add missing newline in pr_err messages
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230610094441.221525-1-yangjihong1@huawei.com>
 <ZIdqHeZOWCztKVe2@kernel.org>
 <cd1d5a4b-e69c-84c9-3e27-d197042df904@huawei.com>
 <ZIjHRfq0/IJPyhYT@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <5605beaf-e6a3-8b1a-150b-7fdda76fa389@huawei.com>
Date:   Wed, 14 Jun 2023 10:12:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ZIjHRfq0/IJPyhYT@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2023/6/14 3:45, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 13, 2023 at 09:32:05AM +0800, Yang Jihong escreveu:
>> On 2023/6/13 2:55, Arnaldo Carvalho de Melo wrote:
>>> Em Sat, Jun 10, 2023 at 09:44:41AM +0000, Yang Jihong escreveu:
>>>> The newline is missing for error messages in add_default_attributes()
>>>>
>>>> Before:
>>>>
>>>>     # perf stat --topdown
>>>>     Topdown requested but the topdown metric groups aren't present.
>>>>     (See perf list the metric groups have names like TopdownL1)#
>>>>
>>>> After:
>>>>
>>>>     # perf stat --topdown
>>>>     Topdown requested but the topdown metric groups aren't present.
>>>>     (See perf list the metric groups have names like TopdownL1)
>>>>     #
>>>>
>>>> In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
>>>> have the same problem, fixed by the way.
>>>
>>> Wait a bit till I push what I had to perf-tools-next, as it is not
>>> applying right now:
>> OK, I'm doing the patch based on the mainline, and if I need to do it based
>> on the perf-tools-next branch, I'll reissue it.
> 
> For patches for the currente perf development cycle the perf-tools-next
> branch of:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> 
> Should be used.
> 
> Hopefully soon we will transition to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/perf-tools/perf-tools-next.git
> 
> And also:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/perf-tools/perf-tools.git
> 
> For fixes geared to the current merge window, when we are accepting just
> fixes.
> 

Thanks for the guidance, I'll resend the patch based on the 
perf-tools-next branch.

Thanks,
Yang.
