Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621562927C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKOHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKOHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:33:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33CC2BA;
        Mon, 14 Nov 2022 23:33:41 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBHw60Zh8zHvwR;
        Tue, 15 Nov 2022 15:33:10 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 15:33:39 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 15:33:39 +0800
Subject: Re: [PATCH v13 2/2] Documentation: Add document for UltraSoc SMB
 drivers
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-3-hejunhao3@huawei.com> <Y3JJSfVoatl5yKlm@debian.me>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <a6adaeec-182c-140d-9925-45f659b4eef2@huawei.com>
Date:   Tue, 15 Nov 2022 15:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y3JJSfVoatl5yKlm@debian.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hi Bagas,

will apply the fix  in next version.
Thank you very much.

Best regards,
Junhao.


On 2022/11/14 21:57, Bagas Sanjaya wrote:
> On Mon, Nov 14, 2022 at 05:03:16PM +0800, Junhao He wrote:
>> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
>> new file mode 100644
>> index 000000000000..b7fe3f5c7f53
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
>> @@ -0,0 +1,82 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +UltraSoc - HW Assisted Tracing on SoC
>> +======================================
>> +   :Author:   Qi Liu <liuqi115@huawei.com>
>> +   :Date:     March 2022
>> +
>> +Introduction
>> +------------
>> +
>> +UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a
>> +way to buffer and store CPU trace messages in a region of shared system
>> +memory. SMB is plugged as a coresight sink device and the corresponding
>> +trace generators (ETM) are plugged in as source devices.
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +The SMB devices appear on the existing coresight bus alongside the other
>> +coresight devices::
>> +
>> +	$# ls /sys/bus/coresight/devices/
>> +	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
>> +
>> +The ``ultra_smb<N>`` named SMB associated with SCCL.::
>> +
>> +	$# ls /sys/bus/coresight/devices/ultra_smb0
>> +	enable_sink   mgmt
>> +	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
>> +	buf_size  buf_status  read_pos  write_pos
>> +
>> +*Key file items are:-*
>> +   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
>> +   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
>> +   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
>> +		     BIT(0) is zero means buffer is empty.
>> +   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
> The key list above doesn't look right, so I have applied the fixup:
>
> ---- >8 ----
>
> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
> index b7fe3f5c7f53f7..5d0fa1a76b04d1 100644
> --- a/Documentation/trace/coresight/ultrasoc-smb.rst
> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
> @@ -30,11 +30,12 @@ The ``ultra_smb<N>`` named SMB associated with SCCL.::
>   	$# ls /sys/bus/coresight/devices/ultra_smb0/mgmt
>   	buf_size  buf_status  read_pos  write_pos
>   
> -*Key file items are:-*
> +Key file items are:
> +
>      * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
>      * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
>      * ``buf_status``: Shows the value held by UltraSoc SMB status register.
> -		     BIT(0) is zero means buffer is empty.
> +     BIT(0) is zero means buffer is empty.
>      * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
>   
>   Firmware Bindings
>
>> +
>> +Firmware Bindings
>> +---------------------------
>> +
>> +SMB device is only supported with ACPI, and ACPI binding of SMB device
>> +describes SMB device indentifier, resource information and graph structure.
>> +
>> +SMB is identified by ACPI HID "HISI03A1", resource of device is declared using
>> +the _CRS method. Each SMB must present two base address, the first one is the
>> +configuration base address of SMB device, the second one is the 32bits base
>> +address of shared system memory.
>> +
>> +examples::
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
> The rest of wordings also read a rather weird. What about below instead?
>
> ---- >8 ----
>
> diff --git a/Documentation/trace/coresight/ultrasoc-smb.rst b/Documentation/trace/coresight/ultrasoc-smb.rst
> index 5d0fa1a76b04d1..eee32cbf90d2ea 100644
> --- a/Documentation/trace/coresight/ultrasoc-smb.rst
> +++ b/Documentation/trace/coresight/ultrasoc-smb.rst
> @@ -9,21 +9,21 @@ UltraSoc - HW Assisted Tracing on SoC
>   Introduction
>   ------------
>   
> -UltraSoc SMB is a per SCCL(Super CPU Cluster) hardware, and it provides a
> +UltraSoc SMB is a per SCCL (Super CPU Cluster) hardware. It provides a
>   way to buffer and store CPU trace messages in a region of shared system
> -memory. SMB is plugged as a coresight sink device and the corresponding
> -trace generators (ETM) are plugged in as source devices.
> +memory. The device acts as a coresight sink device and the
> +corresponding trace generators (ETM) are attached as source devices.
>   
>   Sysfs files and directories
>   ---------------------------
>   
> -The SMB devices appear on the existing coresight bus alongside the other
> -coresight devices::
> +The SMB devices appear on the existing coresight bus alongside other
> +devices::
>   
>   	$# ls /sys/bus/coresight/devices/
>   	ultra_smb0   ultra_smb1   ultra_smb2   ultra_smb3
>   
> -The ``ultra_smb<N>`` named SMB associated with SCCL.::
> +The ``ultra_smb<N>`` names SMB device associated with SCCL.::
>   
>   	$# ls /sys/bus/coresight/devices/ultra_smb0
>   	enable_sink   mgmt
> @@ -32,24 +32,23 @@ The ``ultra_smb<N>`` named SMB associated with SCCL.::
>   
>   Key file items are:
>   
> -   * ``read_pos``: Shows the value held by UltraSoc SMB Read Pointer register.
> -   * ``write_pos``: Shows the value held by UltraSoc SMB Write Pointer register.
> -   * ``buf_status``: Shows the value held by UltraSoc SMB status register.
> -     BIT(0) is zero means buffer is empty.
> -   * ``buf_size``: Shows the buffer size of each UltraSoc SMB device.
> +   * ``read_pos``: Shows the value on the read pointer register.
> +   * ``write_pos``: Shows the value on the write pointer register.
> +   * ``buf_status``: Shows the value on the status register.
> +     BIT(0) is zero value which means the buffer is empty.
> +   * ``buf_size``: Shows the buffer size of each device.
>   
>   Firmware Bindings
> ----------------------------
> +-----------------
>   
> -SMB device is only supported with ACPI, and ACPI binding of SMB device
> -describes SMB device indentifier, resource information and graph structure.
> +The device is only supported with ACPI. Its binding describes device
> +identifier, resource information and graph structure.
>   
> -SMB is identified by ACPI HID "HISI03A1", resource of device is declared using
> -the _CRS method. Each SMB must present two base address, the first one is the
> -configuration base address of SMB device, the second one is the 32bits base
> -address of shared system memory.
> +The device is identified as ACPI HID "HISI03A1". Device resources are allocated
> +using the _CRS method. Each device must present two base address; the first one is the configuration base address of the device, the second one is the 32-bit
> +base address of shared system memory.
>   
> -examples::
> +Example::
>   
>       Device(USMB) {                                               \
>         Name(_HID, "HISI03A1")                                     \
>
> Thanks.
>

