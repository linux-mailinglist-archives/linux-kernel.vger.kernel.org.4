Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD0685DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBAD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBAD04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:26:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25842BF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:26:54 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P66jZ0T3QznVm3;
        Wed,  1 Feb 2023 11:24:50 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 11:26:52 +0800
Subject: Re: [PATCH v7 4/5] Documentation: add debugfs description for
 hisi_acc_vfio_pci
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230120032930.43608-1-liulongfang@huawei.com>
 <20230120032930.43608-5-liulongfang@huawei.com>
 <20230126122805.1e17d08b.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <4df2026a-51b4-f9a9-463b-0ad9e38d054a@huawei.com>
Date:   Wed, 1 Feb 2023 11:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230126122805.1e17d08b.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 3:28, Alex Williamson wrote:
> On Fri, 20 Jan 2023 11:29:29 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> Add a debugfs document description file to help users understand
>> how to use the accelerator live migration driver's debugfs.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../ABI/testing/debugfs-hisi-migration        | 32 +++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
>> new file mode 100644
>> index 000000000000..d644a497c464
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
>> @@ -0,0 +1,32 @@
>> +What:		/sys/kernel/debug/vfio_mig/<bdf>/state
>> +Date:		Jan 2023
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	Read the live migration status of the VF device.
>> +		The status of these live migrations includes:
>> +		ERROR, RUNNING, STOP, STOP_COPY, RESUMING.
> 
> state is added by vfio-pci-core in this series, so the documentation
> can't be limited to hisi_acc.
> 
>> +
>> +What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_data
>> +Date:		Jan 2023
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	Read the live migration data of the VF device.
>> +		The output format of the data is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio_mig/<bdf>/mig_attr
>> +Date:		Jan 2023
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	Read the live migration attributes of the VF device.
>> +		The output format of the attributes is defined by the live
>> +		migration driver.
>> +
>> +What:		/sys/kernel/debug/vfio_mig/<bdf>/debug
>> +Date:		Jan 2023
>> +Contact:	linux-kernel@vger.kernel.org
>> +Description:	This debug file supports "echo" command	write operations.
>> +		The command is actually represented by an integer number, and the
>> +		specific meaning is defined by the corresponding device driver.
>> +		For example, three commands are defined in the HiSilicon accelerator
>> +		live migration driver:
>> +		0: State save
>> +		1: State resume
>> +		2: IO test
> 
> I think the goal here is to create some sort of standard interface for
> migration, so these should also be documented for all devices, and any
> device specific behavior noted.  Otherwise these should all be prefixed
> hisi_acc_ to denote them as device specific implementations.  Thanks,
> 

Ok, the ABI file name needs to be changed, and the internal description needs
to be updated, not limited to hisi_acc.

> Alex
> 
Thansk,
Longfang.
> .
> 
