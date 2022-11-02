Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5717F616B83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKBSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKBSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:05:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646C2E6B4;
        Wed,  2 Nov 2022 11:05:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2I2QNd004942;
        Wed, 2 Nov 2022 18:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9QCqRyX7/rpCsjusa/miM3akYsJyOGsIlbhQcQ2O78A=;
 b=ouPRegq/ErIfIodhVe5NoKl/MlZl7bA0uAIKPQ694rqcmsHPry+XtFjd9EbHmTawTUKp
 ASJqBapoX31lCJ5lNuUCTfh7hePsWetY/oi+b0AL4kwpZItFOAzQ2lYO93mfUPc8DVNV
 timt1Xv1fyZ3YpJ7TGzw4enNMiXFLpvVg+OeiAwTu5vn7gGjHhLErwGWx0Vhy4LJ8iUC
 8UORUFwgOxnnlaBlEBJfcHfqo81WC/oypx01cvfzk51zGGaM38qHkk501TCXljo7z/Y+
 kIAXUZ16TyiNevFwe3sf6xYX4NT/R0LzmoVkIlxZulj4BeUnyE24bFr61lufTVM833EK 9g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkwfu806n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:04:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2I4DBO006128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 18:04:13 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 11:04:12 -0700
Message-ID: <6b035c6e-087a-8fe9-d1ba-3e0c8a0c2130@quicinc.com>
Date:   Wed, 2 Nov 2022 11:04:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 21/21] docs: gunyah: Document Gunyah VM Manager
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-22-quic_eberman@quicinc.com>
 <Y2JrA2rXJuRrFALF@debian.me>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2JrA2rXJuRrFALF@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e-dSAsNRMptKzn7chKnN5jnv4T69jBlk
X-Proofpoint-ORIG-GUID: e-dSAsNRMptKzn7chKnN5jnv4T69jBlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 6:05 AM, Bagas Sanjaya wrote:
> On Wed, Oct 26, 2022 at 11:58:46AM -0700, Elliot Berman wrote:
>> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
>> new file mode 100644
>> index 000000000000..c232ba05de7e
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/vm-manager.rst
>> @@ -0,0 +1,94 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=======================
>> +Virtual Machine Manager
>> +=======================
>> +
>> +The Gunyah Virtual Machine Manager is a Linux driver to support launching virtual machines.
>> +
>> +Summary
>> +=======
>> +
>> +Gunyah VMM presently supports launching non-proxy scheduled Linux-like virtual machines.
>> +
>> +Sample Userspace VMM
>> +====================
>> +
>> +A sample userspace VMM is included in samples/gunyah/ along with a sample minimal devicetree
>> +that can be used to launch a Linux-like virtual machine under Gunyah. To build this sample, enable
>> +CONFIG_SAMPLE_GUNYAH.
>> +
>> +IOCTLs and userspace VMM flows
>> +==============================
>> +
>> +The kernel exposes a char device interface at /dev/gunyah.
>> +
>> +To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a "Gunyah VM" file descriptor.
>> +
>> +/dev/gunyah API Descriptions
>> +----------------------------
>> +
>> +GH_CREATE_VM
>> +~~~~~~~~~~~~
>> +
>> +Creates a Gunyah VM. The argument is reserved for future use and must be 0.
>> +
>> +Gunyah VM API Descriptions
>> +--------------------------
>> +
>> +GH_VM_SET_USER_MEM_REGION
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +  struct gh_userspace_memory_region {
>> +	__u32 label;
>> +	__u32 flags;
>> +	__u64 guest_phys_addr;
>> +	__u64 memory_size;
>> +	__u64 userspace_addr;
>> +  };
>> +
>> +This ioctl allows the user to create or delete a memory parcel for a guest
>> +virtual machine. Each memory region is uniquely identified by a label;
>> +attempting to create two memory regions with the same label is not allowed.
>> +
>> +While VMM is guest-agnostic and allows runtime addition of memory regions,
>> +Linux guest virtual machines do not support accepting memory regions at runtime.
>> +Thus, memory regions should be provided before starting the VM and the VM
>> +configured to accept those memory regions at boot-up.
>> +
>> +The guest physical address is used by Linux to check the requested user regions
>> +do not overlap and to help find a corresponding memory region for calls like
>> +GH_VM_SET_DTB_CONFIG.
>> +
>> +To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
>> +memory region of interest and memory_size set to 0.
>> +
>> +The flags field of gh_userspace_memory_region can set the following bits. All
>> +other bits must be 0 and are reserved for future use. The ioctl will return
>> +-EINVAL if an unsupported bit is detected.
>> +
>> +  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec permissions
>> +    for the guest, respectively.
>> +
>> +  - GH_MEM_LENT means that the memory will be unmapped from the host and be unaccessible by
>> +    the host while the guest has the region.
>> +
>> +GH_VM_SET_DTB_CONFIG
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +  struct gh_vm_dtb_config {
>> +	__u64 gpa;
>> +	__u64 size;
>> +  };
>> +
>> +This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
>> +Resource Manager to allocate resources.
>> +
>> +GH_VM_START
>> +~~~~~~~~~~~
>> +
>> +This ioctl starts the virtual machine.
> 
> I think the wording can be better:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index c232ba05de7e96..772fd970b91d7e 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -4,18 +4,15 @@
>   Virtual Machine Manager
>   =======================
>   
> -The Gunyah Virtual Machine Manager is a Linux driver to support launching virtual machines.
> -
> -Summary
> -=======
> -
> -Gunyah VMM presently supports launching non-proxy scheduled Linux-like virtual machines.
> +The Gunyah Virtual Machine Manager is a Linux driver for launching virtual
> +machines using Gunyah. It presently supports launching non-proxy scheduled
> +Linux-like virtual machines.
>   
>   Sample Userspace VMM
>   ====================
>   
> -A sample userspace VMM is included in samples/gunyah/ along with a sample minimal devicetree
> -that can be used to launch a Linux-like virtual machine under Gunyah. To build this sample, enable
> +A sample userspace VMM is included in samples/gunyah/ along with a minimal
> +devicetree that can be used to launch a VM. To build this sample, enable
>   CONFIG_SAMPLE_GUNYAH.
>   
>   IOCTLs and userspace VMM flows
> @@ -23,7 +20,8 @@ IOCTLs and userspace VMM flows
>   
>   The kernel exposes a char device interface at /dev/gunyah.
>   
> -To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a "Gunyah VM" file descriptor.
> +To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a
> +"Gunyah VM" file descriptor.
>   
>   /dev/gunyah API Descriptions
>   ----------------------------
> @@ -51,29 +49,28 @@ GH_VM_SET_USER_MEM_REGION
>   
>   This ioctl allows the user to create or delete a memory parcel for a guest
>   virtual machine. Each memory region is uniquely identified by a label;
> -attempting to create two memory regions with the same label is not allowed.
> +attempting to create two regions with the same label is not allowed.
>   
>   While VMM is guest-agnostic and allows runtime addition of memory regions,
>   Linux guest virtual machines do not support accepting memory regions at runtime.
> -Thus, memory regions should be provided before starting the VM and the VM
> -configured to accept those memory regions at boot-up.
> +Thus, memory regions should be provided before starting the VM and the VM must
> +be configured to accept these at boot-up.
>   
> -The guest physical address is used by Linux to check the requested user regions
> -do not overlap and to help find a corresponding memory region for calls like
> -GH_VM_SET_DTB_CONFIG.
> +The guest physical address is used by Linux kernel to check that the requested
> +user regions do not overlap and to help find the corresponding memory region
> +for calls like GH_VM_SET_DTB_CONFIG.
>   
>   To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
> -memory region of interest and memory_size set to 0.
> +desired region and memory_size set to 0.
>   
> -The flags field of gh_userspace_memory_region can set the following bits. All
> +The flags field of gh_userspace_memory_region accepts the following bits. All
>   other bits must be 0 and are reserved for future use. The ioctl will return
>   -EINVAL if an unsupported bit is detected.
>   
> -  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec permissions
> -    for the guest, respectively.
> -
> -  - GH_MEM_LENT means that the memory will be unmapped from the host and be unaccessible by
> -    the host while the guest has the region.
> +  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec
> +    permissions for the guest, respectively.
> +  - GH_MEM_LENT means that the memory will be unmapped from the host and be
> +    unaccessible by the host while the guest has the region.

One side question -- before, you asked that I add newline between the 
list entries. Here, you've removed them. When do I need the extra 
newline vs not?

https://lore.kernel.org/all/YzUUaIx+azyzFDNX@debian.me/

>   
>   GH_VM_SET_DTB_CONFIG
>   ~~~~~~~~~~~~~~~~~~~~
> @@ -91,4 +88,4 @@ Resource Manager to allocate resources.
>   GH_VM_START
>   ~~~~~~~~~~~
>   
> -This ioctl starts the virtual machine.
> +This ioctl starts the VM.
> 
> Thanks.
> 

Thanks for reviewing and providing all the suggestions. I've applied all 
of them.



