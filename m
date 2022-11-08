Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36C620B07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiKHIVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiKHIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:21:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4637644
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:21:36 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N61Jy7001zmVGh;
        Tue,  8 Nov 2022 16:21:22 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:21:34 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 16:21:34 +0800
Subject: Re: [PATCH v11 2/2] Documentation: Add document for UltraSoc SMB
 drivers
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20221107130624.59886-1-hejunhao3@huawei.com>
 <20221107130624.59886-3-hejunhao3@huawei.com>
 <20221107143354.00001324@Huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.garry@huawei.com>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <rdunlap@infradead.org>, <liuqi115@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <ac33c37f-16f6-9e6d-c168-78f5676431ec@huawei.com>
Date:   Tue, 8 Nov 2022 16:21:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221107143354.00001324@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 2022/11/7 22:33, Jonathan Cameron wrote:
> On Mon, 7 Nov 2022 21:06:24 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> This patch bring in documentation for UltraSoc SMB drivers.
>> It simply describes the device, sysfs interface and the
>> firmware bindings.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   .../sysfs-bus-coresight-devices-ultra_smb     | 31 +++++++
>>   .../trace/coresight/ultrasoc-smb.rst          | 80 +++++++++++++++++++
>>   2 files changed, 111 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>>   create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> new file mode 100644
>> index 000000000000..7804aef4b40b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> @@ -0,0 +1,31 @@
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/enable_sink
>> +Date:		October 2022
>> +KernelVersion:	6.1
> Update to 6.2 as this will hopefully go in next merge window and it makes
> life easier for the maintainer if they don't need to fix all these up.
Ok, i will fix in next version.
Thanks.
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(RW) Add/remove a SMB device from a trace path. There can be
>> +		multiple sources for a single SMB device.
> Rest looks good to me, (not an expert on this stuff though!)
>
> Jonathan
> .
>
Best regards,
Junhao.
