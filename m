Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC2653D23
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiLVIqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLVIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:46:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262B656B;
        Thu, 22 Dec 2022 00:46:29 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nd3mH1yKpz16Llj;
        Thu, 22 Dec 2022 16:45:19 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 16:46:27 +0800
Subject: Re: [PATCH v15 2/2] Documentation: Add document for UltraSoc SMB
 driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>
References: <20221220092945.30722-1-hejunhao3@huawei.com>
 <20221220092945.30722-3-hejunhao3@huawei.com>
 <a44a57c7-0ac9-bd5d-4c92-225ff9a6c361@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi6124@gmail.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <73126d18-b66f-2894-0b95-02626a368969@huawei.com>
Date:   Thu, 22 Dec 2022 16:46:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <a44a57c7-0ac9-bd5d-4c92-225ff9a6c361@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/21 18:21, Suzuki K Poulose wrote:
> On 20/12/2022 09:29, Junhao He wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> Bring in documentation for UltraSoc SMB driver.
>> It simply describes the device, sysfs interface and the
>> firmware bindings.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   .../sysfs-bus-coresight-devices-ultra_smb     | 31 +++++++
>>   .../trace/coresight/ultrasoc-smb.rst          | 83 +++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>   create mode 100644 
>> Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>>   create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> new file mode 100644
>> index 000000000000..f6526882c627
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> @@ -0,0 +1,31 @@
>> +What: /sys/bus/coresight/devices/ultra_smb<N>/enable_sink
>> +Date:        December 2022
>> +KernelVersion:    6.2
>
> This is not going in for 6.2. This must be 6.3 now and everywhere
> below.
>
> Thanks
> Suzuki
>
OK, Will fix in next version.

Thanks
Junhao.
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
>
> .
>

