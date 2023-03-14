Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDD6B90C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCNK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCNK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:56:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B267EC62
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:56:47 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbVkj1tdFznWtJ;
        Tue, 14 Mar 2023 18:53:49 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 18:56:45 +0800
Subject: Re: [PATCH v8 4/5] Documentation: add debugfs description for vfio
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-5-liulongfang@huawei.com>
 <20230310163957.60e9bc36.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <ca371848-f91c-b9d4-d8e1-686f63070045@huawei.com>
Date:   Tue, 14 Mar 2023 18:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230310163957.60e9bc36.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/11 7:39, Alex Williamson wrote:
> On Fri, 17 Feb 2023 16:48:30 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> Add two debugfs document description file to help users understand
>> how to use the accelerator live migration driver's debugfs.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../ABI/testing/debugfs-hisi-migration        | 28 +++++++++++++++++++
>>  Documentation/ABI/testing/debugfs-vfio        | 17 +++++++++++
>>  2 files changed, 45 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
>> new file mode 100644
>> index 000000000000..0f45f30ff6d4
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
>> @@ -0,0 +1,28 @@
>> +What:		/sys/kernel/debug/vfio/<bdf>/migration_data
> 
> s/bdf/name/ throughout.
> 
OK, I will change it in the next version.

>> +Date:		Feb 2023
>> +KernelVersion:  6.2
>> +Contact:	linux-kernel@vger.kernel.org
> 
> Is there not someone at Huawei willing to be the contact point for the
> hisi_acc specific attributes?
> 

Sorry, I misunderstood here.
Before, I thought it could only be the contact information of the public community.
I will add my email address in the next version.

>> +Description:	Read the live migration data of the vfio device.
>> +		The output format of the data is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio/<bdf>/migration_attr
>> +Date:		Feb 2023
>> +KernelVersion:  6.2
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	Read the live migration attributes of the vfio device.
>> +		The output format of the attributes is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio/<bdf>/migration_debug
>> +Date:		Feb 2023
>> +KernelVersion:  6.2
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	This debug file supports "echo" command	write operations.
>> +		The command is actually represented by an integer number, and the
>> +		specific meaning is defined by the corresponding device driver.
>> +		For example, three commands are defined in the HiSilicon accelerator
>> +		live migration driver:
>> +		0: State save
>> +		1: State resume
>> +		2: IO test
>> diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
>> new file mode 100644
>> index 000000000000..e22531d16674
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-vfio
>> @@ -0,0 +1,17 @@
>> +What:		/sys/kernel/debug/vfio
>> +Date:		Feb 2023
>> +KernelVersion:  6.2
>> +Contact:	linux-kernel@vger.kernel.org
> 
> These should likely at least be the kvm list as the official list of
> vfio if you're not interested in being the contact point.
> 

I misunderstood here.
I will add my email address in the next version.

Thanks,
Longfang.
> Thanks,
> Alex
> 
>> +Description:	This debugfs file directory is used for debugging
>> +		of vfio devices that support live migration.
>> +		Each device that supports live migration can create a device
>> +		subdirectory under this directory by referencing the public
>> +		registration interface.
>> +
>> +What:		/sys/kernel/debug/vfio/<bdf>/migration_state
>> +Date:		Feb 2023
>> +KernelVersion:  6.2
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	Read the live migration status of the vfio device.
>> +		The status of these live migrations includes:
>> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
> 
> .
> 
