Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD868B71F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBFIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:12:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604574C18
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:12:48 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31671vmK012620;
        Mon, 6 Feb 2023 08:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y89c849cSYlHvFiu9BA87H+ZSERrKbEwy7438FK/X74=;
 b=lCe7vAd+MmWaoIcAUkomWAExHPTaxFaSWJ+0dVGAfKhK+Vzaua+IM7jKNpMNNIBAmWXX
 KvK3vIRp8Q6NPQXtAVTpPnKKYcclZcnp4j6WrqLeujXgABUr+Pr7ZwcD5sfQ4gSvguKI
 UHiBNGFjsxMy0wi4U2mKnoRc604qdMnNOJbtK0VnuBWx0kuWBEavZNmwrDe5tPzlyPnV
 HDowdRxEuTCiGGOzFTFyw56mYLoOwQbij6nOMyTdnmJvjDEOvG0Anu1qU+wSVKAtHUkP
 kKLQcnCcnplcWRN/KpmnbJbOlvzMud7lYsEO3aosJN8JyNPG+TeKcDvQrJyc+doAmEwA cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njvt8hf8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 08:12:17 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316777LS026333;
        Mon, 6 Feb 2023 08:12:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njvt8hf8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 08:12:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315IGAIK004425;
        Mon, 6 Feb 2023 08:12:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06hgrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 08:12:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3168CC7i26346184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 08:12:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 424A92004B;
        Mon,  6 Feb 2023 08:12:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D313320040;
        Mon,  6 Feb 2023 08:12:07 +0000 (GMT)
Received: from [9.43.108.31] (unknown [9.43.108.31])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 08:12:07 +0000 (GMT)
Message-ID: <8308e930-6b55-5756-d653-5c623a8ea758@linux.ibm.com>
Date:   Mon, 6 Feb 2023 13:42:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <87sffpzkle.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 26WIOTk2qLYUvWgjFNkb4KVWSD2qH_um
X-Proofpoint-ORIG-GUID: 4faGc41Qo86coPNIcmqyfvBs9y_qX2H2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060069
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 01/02/23 17:03, Thomas Gleixner wrote:
> Eric!
>
> On Tue, Jan 31 2023 at 17:42, Eric DeVolder wrote:
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -366,6 +366,14 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>>   
>>   	/* Prepare one phdr of type PT_NOTE for each present CPU */
>>   	for_each_present_cpu(cpu) {
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>> +			/* Skip the soon-to-be offlined cpu */
>> +			if ((image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU) &&
>> +				(cpu == image->offlinecpu))
>> +				continue;
>> +		}
>> +#endif
> I'm failing to see how the above is correct in any way. Look at the
> following sequence of events:
>
>       1) Offline CPU$N
>
>          -> Prepare elf headers with CPU$N excluded
>
>       2) Another hotplug operation != 'Online CPU$N'
>
>          -> Prepare elf headers with CPU$N included
>
> Also in case of loading the crash kernel in the situation where not all
> present CPUs are online (think boot time SMT disable) then your
> resulting crash image will contain all present CPUs and none of the
> offline CPUs are excluded.
>
> How does that make any sense at all?
>
> This image->hp_action and image->offlinecpu dance is engineering
> voodoo. You just can do:
>
>          for_each_present_cpu(cpu) {
>              if (!cpu_online(cpu))
>              	continue;
>              do_stuff(cpu);
>
> which does the right thing in all situations and can be further
> simplified to:
>
>          for_each_online_cpu(cpu) {
>              do_stuff(cpu);

What will be the implication on x86 if we pack PT_NOTE for possible CPUs?

IIUC, on boot the crash notes are create for possible CPUs using pcpu_alloc
and when the system is on crash path the crash notes for online CPUs is
populated with the required data and rest crash notes are untouched.

And I think the /proc/vmcore generation in kdump/second kernel and 
makedumpfile do
take care of empty crash notes belong to offline CPUs.

Any thoughts?

Thanks,
Sourabh
