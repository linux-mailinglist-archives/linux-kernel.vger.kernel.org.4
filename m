Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EA653D19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLVInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiLVInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:43:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3429823BD2;
        Thu, 22 Dec 2022 00:43:37 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nd3hx5JffzmWnD;
        Thu, 22 Dec 2022 16:42:25 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 16:43:34 +0800
Subject: Re: [PATCH v15 2/2] Documentation: Add document for UltraSoc SMB
 driver
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221220092945.30722-1-hejunhao3@huawei.com>
 <20221220092945.30722-3-hejunhao3@huawei.com> <Y6KFQIk8rbMIglBO@debian.me>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi6124@gmail.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <d8810003-7bac-da2e-23ec-f130cc9f104e@huawei.com>
Date:   Thu, 22 Dec 2022 16:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y6KFQIk8rbMIglBO@debian.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/12/21 12:02, Bagas Sanjaya wrote:
> On Tue, Dec 20, 2022 at 05:29:45PM +0800, Junhao He wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> new file mode 100644
>> index 000000000000..f6526882c627
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>> @@ -0,0 +1,31 @@
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/enable_sink
>> +Date:		December 2022
>> +KernelVersion:	6.2
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(RW) Add/remove a SMB device from a trace path. There can be
>> +		multiple sources for a single SMB device.
>> +
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_size
>> +Date:		December 2022
>> +KernelVersion:	6.2
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(Read) Shows the buffer size of each UltraSoc SMB device.
>> +
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/buf_status
>> +Date:		December 2022
>> +KernelVersion:	6.2
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(Read) Shows the value held by UltraSoc SMB status register.
>> +		BIT(0) is zero means buffer is empty.
>> +
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/read_pos
>> +Date:		December 2022
>> +KernelVersion:	6.2
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(Read) Shows the value held by UltraSoc SMB Read Pointer register.
>> +
>> +What:		/sys/bus/coresight/devices/ultra_smb<N>/mgmt/write_pos
>> +Date:		December 2022
>> +KernelVersion:	6.2
>> +Contact:	Junhao He <hejunhao3@huawei.com>
>> +Description:	(Read) Shows the value held by UltraSoc SMB Write Pointer register.
> s/Read/RO/ and s/value held by/value of/
Ok, will fix it.

Thanks.
>> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
>> new file mode 100644
>> index 000000000000..056dd120e14c
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
>> @@ -0,0 +1,83 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +UltraSoc - HW Assisted Tracing on SoC
>> +======================================
>> +   :Author:   Qi Liu <liuqi115@huawei.com>
>> +   :Date:     December 2022
>> +
>> +Introduction
>> +------------
>> +
>> +UltraSoc SMB is a per SCCL (Super CPU Cluster) hardware. It provides a
>> +way to buffer and store CPU trace messages in a region of shared system
>> +memory. The device acts as a coresight sink device and the
>> +corresponding trace generators (ETM) are attached as source devices.
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +The SMB devices appear on the existing coresight bus alongside other
>> +devices::
>> +
>> +	$# ls /sys/bus/coresight/devices/
>> +	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
>> +
>> +The ``ultra_smb<N>`` names SMB device associated with SCCL.::
>> +
>> +	$# ls /sys/bus/coresight/devices/ultra_smb0
>> +	enable_sink   mgmt
>> +	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
>> +	buf_size  buf_status  read_pos  write_pos
>> +
>> +Key file items are:
>> +
>> +   * ``read_pos``: Shows the value on the read pointer register.
>> +   * ``write_pos``: Shows the value on the write pointer register.
>> +   * ``buf_status``: Shows the value on the status register.
>> +     BIT(0) is zero value which means the buffer is empty.
>> +   * ``buf_size``: Shows the buffer size of each device.
>> +
>> +Firmware Bindings
>> +-----------------
>> +
>> +The device is only supported with ACPI. Its binding describes device
>> +identifier, resource information and graph structure.
>> +
>> +The device is identified as ACPI HID "HISI03A1". Device resources are allocated
>> +using the _CRS method. Each device must present two base address; the first one
>> +is the configuration base address of the device, the second one is the 32-bit
>> +base address of shared system memory.
>> +
>> +Example::
>> +
>> +    Device(USMB) {                                               \
>> +      Name(_HID, "HISI03A1")                                     \
>> +      Name(_CRS, ResourceTemplate() {                            \
>> +          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, NonCacheable, \
>> +		       ReadWrite, 0x0, 0x95100000, 0x951FFFFF, 0x0, 0x100000) \
>> +          QWordMemory (ResourceConsumer, , MinFixed, MaxFixed, Cacheable, \
>> +		       ReadWrite, 0x0, 0x50000000, 0x53FFFFFF, 0x0, 0x4000000) \
>> +      })                                                         \
>> +      Name(_DSD, Package() {                                     \
>> +        ToUUID("ab02a46b-74c7-45a2-bd68-f7d344ef2153"),          \
>> +	/* Use CoreSight Graph ACPI bindings to describe connections topology */
>> +        Package() {                                              \
>> +          0,                                                     \
>> +          1,                                                     \
>> +          Package() {                                            \
>> +            1,                                                   \
>> +            ToUUID("3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"),      \
>> +            8,                                                   \
>> +            Package() {0x8, 0, \_SB.S00.SL11.CL28.F008, 0},       \
>> +            Package() {0x9, 0, \_SB.S00.SL11.CL29.F009, 0},       \
>> +            Package() {0xa, 0, \_SB.S00.SL11.CL2A.F010, 0},       \
>> +            Package() {0xb, 0, \_SB.S00.SL11.CL2B.F011, 0},       \
>> +            Package() {0xc, 0, \_SB.S00.SL11.CL2C.F012, 0},       \
>> +            Package() {0xd, 0, \_SB.S00.SL11.CL2D.F013, 0},       \
>> +            Package() {0xe, 0, \_SB.S00.SL11.CL2E.F014, 0},       \
>> +            Package() {0xf, 0, \_SB.S00.SL11.CL2F.F015, 0},       \
>> +          }                                                      \
>> +        }                                                        \
>> +      })                                                         \
>> +    }
> This doc LGTM, thanks.
>
> For this doc,
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Thanks for your comments.

Best regards,
Junhao.

