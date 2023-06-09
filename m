Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1698E728FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbjFIGSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjFIGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:17:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866E1FE6;
        Thu,  8 Jun 2023 23:17:51 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QcrNV1sZkz18M2t;
        Fri,  9 Jun 2023 14:12:58 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 14:17:48 +0800
Subject: Re: [PATCH v3 2/3] drivers/perf: hisi: Add support for HiSilicon UC
 PMU driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230608113719.27433-1-hejunhao3@huawei.com>
 <20230608113719.27433-3-hejunhao3@huawei.com>
 <20230608142200.0000753c@Huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <7148da77-056a-06aa-89bf-25f775535685@huawei.com>
Date:   Fri, 9 Jun 2023 14:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230608142200.0000753c@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan


On 2023/6/8 21:22, Jonathan Cameron wrote:
> On Thu, 8 Jun 2023 19:37:18 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>
>> On HiSilicon Hip09 platform, there is 4 UC (unified cache) module
> are 4 UC (unified cache) modules

Ok, will fix it.
Thanks.

>> on each chip CCL (CPU Cluster). UC is a cache that provides
>> coherence between NUMA and UMA domains. It is located between L2
>> and Memory System. And many PMU events are supported. Let's support
> Many PMU events are supported.

Ok, will fix it.
Thanks.

>> the UC PMU driver using the HiSilicon uncore PMU framework.
>>
>> * rd_req_en : rd_req_en is the abbreviation of read request tracetag
>> enable and allows user to count only read operations. Details are listed
>> in the hisi-pmu document at Documentation/admin-guide/perf/hisi-pmu.rst
>>
>> * srcid_en & srcid: Allows users to filter statistical information based
>> on specific CPU/ICL by srcid.
>> srcid_en depending on rd_req_en enabled.
> srcid_en depends on rd_req_en being enabled.

Ok, will fix it.
Thanks.

>> * uring_channel: Allows users to filter statistical information based on
>> the specified tx request uring channel.
>> uring_channel only supported events: [0x47 ~ 0x59].
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> The editorial stuff above is trivial and original text can be easily
> understood. So maintainers may not care. If you happen to be re rolling
> the patch then nice to clean it up.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> .

Sure, Will fix in next version.
Thanks.


