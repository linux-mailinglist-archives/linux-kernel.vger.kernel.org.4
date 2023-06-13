Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6071572D6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjFMBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjFMBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:32:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590BE56;
        Mon, 12 Jun 2023 18:32:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qg9vk0XyQztQr4;
        Tue, 13 Jun 2023 09:29:38 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:32:05 +0800
Subject: Re: [PATCH v2] perf stat: Add missing newline in pr_err messages
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230610094441.221525-1-yangjihong1@huawei.com>
 <ZIdqHeZOWCztKVe2@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <cd1d5a4b-e69c-84c9-3e27-d197042df904@huawei.com>
Date:   Tue, 13 Jun 2023 09:32:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ZIdqHeZOWCztKVe2@kernel.org>
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

On 2023/6/13 2:55, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jun 10, 2023 at 09:44:41AM +0000, Yang Jihong escreveu:
>> The newline is missing for error messages in add_default_attributes()
>>
>> Before:
>>
>>    # perf stat --topdown
>>    Topdown requested but the topdown metric groups aren't present.
>>    (See perf list the metric groups have names like TopdownL1)#
>>
>> After:
>>
>>    # perf stat --topdown
>>    Topdown requested but the topdown metric groups aren't present.
>>    (See perf list the metric groups have names like TopdownL1)
>>    #
>>
>> In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
>> have the same problem, fixed by the way.
> 
> Wait a bit till I push what I had to perf-tools-next, as it is not
> applying right now:
OK, I'm doing the patch based on the mainline, and if I need to do it 
based on the perf-tools-next branch, I'll reissue it.

Thanks,
Yang.
