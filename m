Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0559A6FD75F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjEJGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:47:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEA270B;
        Tue,  9 May 2023 23:47:56 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QGQTn0WDLzpSyv;
        Wed, 10 May 2023 14:43:41 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 14:47:51 +0800
Subject: Re: [PATCH] perf bpf skels: vmlinux.h uses bpf.h and perf_event.h in
 the source directory
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230509063649.239942-1-yangjihong1@huawei.com>
 <ZFqPKU0p73sMb+IG@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <427c2d97-64bb-ab0d-77d6-547bd73947d5@huawei.com>
Date:   Wed, 10 May 2023 14:47:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ZFqPKU0p73sMb+IG@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/5/10 2:21, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 09, 2023 at 06:36:49AM +0000, Yang Jihong escreveu:
>> Currently, vmlinux.h uses the bpf.h and perf_event.h header files in the
>> system path. If the header files in compilation environment are old,
>> compilation may fail. For example:
>>
>>    /home/yangjihong/linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:151:27: error: field has incomplete type 'union perf_sample_weight'
>>            union perf_sample_weight weight;
> 
> 
> Can this be solved in the Makefile directives for building BPF targets?
> 
OK, will send v2 patch, use Makefile to specify path of header file that 
is preferentially used. Pls check whether the solution is OK.

Thanks,
Yang
