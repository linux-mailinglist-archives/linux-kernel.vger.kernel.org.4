Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95AA73CDD4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjFYBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFYBic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:38:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255AAA8;
        Sat, 24 Jun 2023 18:38:31 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QpYV32r8kzLmwb;
        Sun, 25 Jun 2023 09:36:27 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:38:28 +0800
Subject: Re: [PATCH v5 4/4] perf tools: Add printing perf_event_attr config
 symbol in perf_event_attr__fprintf()
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230623054416.160858-1-yangjihong1@huawei.com>
 <20230623054416.160858-5-yangjihong1@huawei.com>
 <CAM9d7cjzzmjQnJUvE2a6bqDao07o9+mSyJH4C4xRq0zEZJwLnQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <2654189b-0804-305a-be06-3234f39f0403@huawei.com>
Date:   Sun, 25 Jun 2023 09:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjzzmjQnJUvE2a6bqDao07o9+mSyJH4C4xRq0zEZJwLnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2023/6/24 13:28, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 22, 2023 at 10:46 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> When printing perf_event_attr, always display perf_event_attr config and
>> its symbol to improve the readability of debugging information.
>>
> 
> [SNIP]
>> +
>> +#ifdef HAVE_LIBTRACEEVENT
>> +static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
>> +{
>> +       char *str = tracepoint_id_to_name(value);
> 
> This makes the python module import test failing due to the
> undefined symbol.  I'll fix it by adding a dummy function in
> util/python.c file.  But next time, please run `perf test` first
> and make sure you don't break anything.

Thanks for the correction.

Running `perf test` on my environment has only one testcase for python:

19:'import perf' in python: Ok

The result is OK. The possible cause is that some libraries are missing 
in my environment. As a result, other Python tests are not executed. 
I'll check them first.

Thanks,
Yang
