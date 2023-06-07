Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB572652E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbjFGP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjFGP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:56:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDC1BD5;
        Wed,  7 Jun 2023 08:55:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357EqLQn015967;
        Wed, 7 Jun 2023 15:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a88kNr/48AubDrzv+pOPSNaCMMgxGL0xvHKW5olM93k=;
 b=A3XZX0z+XGrQJDNXnSIxjK/rbIBwgPWx4m2pxHrlBJbhTzw7JxjCQV3KUbjpMKaQegKP
 IfqPyWVIpjPwgrJ45z5/tC5cXDs6SM6Mj3yQmhrYic5y0FXbfbbFCa0QfZp5GrqRzpLM
 rxL481v8lagTD69xdwuZzVHV0HCFyfozetgXNcmt2Sc3qA6RMOawTM3j0pAZi58BobgO
 aVycxFZEdTzZegWcvWcK7Ot1F1tbtKbOn+ktAW3An3LCoB0vFpArn08WRWCr6wS6fRC1
 7rrn4gJc1y+0CRswp6CArFCJ871+28VBFqeSJwQwaB5p8iRMoeMZukhCbS3ZFfT8JuZs aQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a6yta51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 15:55:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357FtTGE021924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 15:55:29 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 08:55:28 -0700
Message-ID: <c90154ff-8fb1-2273-ff27-03afe233bec7@quicinc.com>
Date:   Wed, 7 Jun 2023 08:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 14/24] virt: gunyah: Add Qualcomm Gunyah platform ops
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-15-quic_eberman@quicinc.com>
 <026fb04d-6d58-8d9c-8208-4f34a287a78f@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <026fb04d-6d58-8d9c-8208-4f34a287a78f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4u9CLNjh0_UJFaodqtfYHNvJcg4YSj8D
X-Proofpoint-GUID: 4u9CLNjh0_UJFaodqtfYHNvJcg4YSj8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070136
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:48 PM, Alex Elder wrote:
> On 5/9/23 3:47 PM, Elliot Berman wrote:
>> Qualcomm platforms have a firmware entity which performs access control
>> to physical pages. Dynamically started Gunyah virtual machines use the
>> QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
>> to the memory used by guest VMs. Gunyah doesn't do this operation for us
>> since it is the current VM (typically VMID_HLOS) delegating the access
>> and not Gunyah itself. Use the Gunyah platform ops to achieve this so
>> that only Qualcomm platforms attempt to make the needed SCM calls.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Minor suggestions below.  Please consider them, but either way:
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> ---
>>   drivers/virt/gunyah/Kconfig       |  13 +++
>>   drivers/virt/gunyah/Makefile      |   1 +
>>   drivers/virt/gunyah/gunyah_qcom.c | 147 ++++++++++++++++++++++++++++++
>>   3 files changed, 161 insertions(+)
>>   create mode 100644 drivers/virt/gunyah/gunyah_qcom.c
>>
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> index de815189dab6..0421b751aad4 100644
>> --- a/drivers/virt/gunyah/Kconfig
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -5,6 +5,7 @@ config GUNYAH
>>       depends on ARM64
>>       depends on MAILBOX
>>       select GUNYAH_PLATFORM_HOOKS
>> +    imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
>>       help
>>         The Gunyah drivers are the helper interfaces that run in a 
>> guest VM
>>         such as basic inter-VM IPC and signaling mechanisms, and 
>> higher level
>> @@ -15,3 +16,15 @@ config GUNYAH
>>   config GUNYAH_PLATFORM_HOOKS
>>       tristate
>> +
>> +config GUNYAH_QCOM_PLATFORM
>> +    tristate "Support for Gunyah on Qualcomm platforms"
>> +    depends on GUNYAH
>> +    select GUNYAH_PLATFORM_HOOKS
>> +    select QCOM_SCM
>> +    help
>> +      Enable support for interacting with Gunyah on Qualcomm
>> +      platforms. Interaction with Qualcomm firmware requires
>> +      extra platform-specific support.
>> +
>> +      Say Y/M here to use Gunyah on Qualcomm platforms.
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 4fbeee521d60..2aa9ff038ed0 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
>> +obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
>>   gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> diff --git a/drivers/virt/gunyah/gunyah_qcom.c 
>> b/drivers/virt/gunyah/gunyah_qcom.c
>> new file mode 100644
>> index 000000000000..18acbda8fcbd
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/gunyah_qcom.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/arm-smccc.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/module.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/types.h>
>> +#include <linux/uuid.h>
>> +
>> +#define QCOM_SCM_RM_MANAGED_VMID    0x3A
>> +#define QCOM_SCM_MAX_MANAGED_VMID    0x3F
> 
> Is this limited to 63 because there are at most 64 VMIDs
> that can be represented in a 64-bit unsigned?
> 

It's a limitation imposed by QC firmware, but I speculate that's why 63 
is selected.

>> +
>> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    struct qcom_scm_vmperm *new_perms;
>> +    u64 src, src_cpy;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms = kcalloc(mem_parcel->n_acl_entries, 
>> sizeof(*new_perms), GFP_KERNEL);
>> +    if (!new_perms)
>> +        return -ENOMEM;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            new_perms[n].vmid = vmid;
>> +        else
>> +            new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
> 
> So any out-of-range VM ID will cause the hunk of memory to
> be assigned to the resource manager.  Is it expected that
> this can occur (and not be an error)?
> 

Yes, that's the expectation for these virtual machines. This is for the 
access control implemented in QC firmware, so it's not that we're 
assigning memory to resource manager, but rather assigning memory to a 
resource manager-managed VM. This is done to de-escalate the access 
level of guest VMs.

>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_READ;
>> +    }
>> +
>> +    src = (1ull << QCOM_SCM_VMID_HLOS);
> 
>      src = BIT_ULL(QCOM_SCM_VMID_HLOS);
> 
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        src_cpy = src;
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, mem_parcel->n_acl_entries);
> 
> Loops like this can look simpler if you jump to error handling
> at the end that does this unwind activity, rather than incorporating
> it inside the loop itself.  Or even just breaking if ret != 0, e.g.:
> 
>          if (ret)
>              break;
>      }
> 
>      if (!ret)
>          return 0;
> 
>      /* And do the following block here, "outdented" twice */
> 
>> +        if (ret) {
>> +            src = 0;
>> +            for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +                vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +                if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +                    src |= (1ull << vmid);
> 
>      src |= BIT_ULL(vmid);
> 
>> +                else
>> +                    src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
> 
>      src |= BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
> 
>> +            }
>> +
>> +            new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
>> +
>> +            for (i--; i >= 0; i--) {
>> +                src_cpy = src;
>> +                WARN_ON_ONCE(qcom_scm_assign_mem(
>> +                        
>> le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, 1));
>> +            }
>> +            break;
>> +        }
>> +    }
>> +
>> +    kfree(new_perms);
>> +    return ret;
>> +}
>> +
>> +static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    struct qcom_scm_vmperm new_perms;
>> +    u64 src = 0, src_cpy;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +    new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | 
>> QCOM_SCM_PERM_READ;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            src |= (1ull << vmid);
>> +        else
>> +            src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
>> +    }
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        src_cpy = src;
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, &new_perms, 1);
>> +        WARN_ON_ONCE(ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
>> +    .pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
>> +    .post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
>> +};
>> +
>> +/* {19bd54bd-0b37-571b-946f-609b54539de6} */
>> +static const uuid_t QCOM_EXT_UUID =
>> +    UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94, 0x6f, 0x60, 0x9b, 
>> 0x54, 0x53, 0x9d, 0xe6);
>> +
>> +#define GH_QCOM_EXT_CALL_UUID_ID    
>> ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
>> +                               ARM_SMCCC_OWNER_VENDOR_HYP, 0x3f01)
>> +
>> +static bool gh_has_qcom_extensions(void)
>> +{
>> +    struct arm_smccc_res res;
>> +    uuid_t uuid;
>> +
>> +    arm_smccc_1_1_smc(GH_QCOM_EXT_CALL_UUID_ID, &res);
>> +
>> +    ((u32 *)&uuid.b[0])[0] = lower_32_bits(res.a0);
>> +    ((u32 *)&uuid.b[0])[1] = lower_32_bits(res.a1);
>> +    ((u32 *)&uuid.b[0])[2] = lower_32_bits(res.a2);
>> +    ((u32 *)&uuid.b[0])[3] = lower_32_bits(res.a3);
> 
> I said this elsewhere.  I'd rather see:
> 
>      u32 *u = (u32 *)&uuid;        /* Or &uuid.b? */
> 
>      *u++ = lower_32_bits(res.a0);
>          . . .
> 
>> +
>> +    return uuid_equal(&uuid, &QCOM_EXT_UUID);
>> +}
>> +
>> +static int __init qcom_gh_platform_hooks_register(void)
>> +{
>> +    if (!gh_has_qcom_extensions())
>> +        return -ENODEV;
>> +
>> +    return gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops);
>> +}
>> +
>> +static void __exit qcom_gh_platform_hooks_unregister(void)
>> +{
>> +    gh_rm_unregister_platform_ops(&qcom_scm_gh_rm_platform_ops);
>> +}
>> +
>> +module_init(qcom_gh_platform_hooks_register);
>> +module_exit(qcom_gh_platform_hooks_unregister);
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Platform Hooks for 
>> Gunyah");
>> +MODULE_LICENSE("GPL");
> 
