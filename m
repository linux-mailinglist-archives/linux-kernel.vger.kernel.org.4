Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77959627510
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiKNDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiKNDtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:49:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF151116A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:49:32 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AE3UAAF007246;
        Mon, 14 Nov 2022 03:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fOPRTCVq/gTMWLKyEkuVYoSabDVF/6GqURdh668LRog=;
 b=QtibTekgyqmJlpkbREEDwDHZhqIApCApGAyH/s+cZxPJOO45/4d0sRQP+HxwZUdIvb52
 6m4usGtjQ8Ei1984cclb0mxob9GQxpY3Wu/Ps/wszki1ofqTHDMKNbkOjFEUACh+kgZi
 VmAQwNU5JtnFT2OOiEIJ37wLMf6o22NvpaGKi0l+HRqFdixnlDTfz7MdILmfHCqcIZRs
 JYux1rrtj3wVCwUR1PdnRgxD2ZuDR4uV5g+sayBgCkL/1wHLOWgviB9ALKwKQLiZxb+6
 7+wmFsgJ52JZ1bxg6zsVWBX37JDSWqv7nzLt6MQbdQ8BhGjHSRDFH+OqqObIEgVLzcn1 Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kudtp0867-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:48:57 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AE3cJNw001146;
        Mon, 14 Nov 2022 03:48:57 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kudtp085j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:48:57 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AE3bDWX029350;
        Mon, 14 Nov 2022 03:48:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3kt3499d8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 03:48:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AE3mqnQ27787850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 03:48:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87DB411C04A;
        Mon, 14 Nov 2022 03:48:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C83E11C04C;
        Mon, 14 Nov 2022 03:48:49 +0000 (GMT)
Received: from [9.43.84.159] (unknown [9.43.84.159])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 03:48:49 +0000 (GMT)
Message-ID: <278ef11d-f85d-512e-e7e8-0685653a2e45@linux.ibm.com>
Date:   Mon, 14 Nov 2022 09:18:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20221028143346.183569-1-sv@linux.ibm.com>
 <20221028143346.183569-3-sv@linux.ibm.com>
 <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
 <Y2OAdHBIGXVnN5Ud@hirez.programming.kicks-ass.net>
From:   Sathvika Vasireddy <sv@linux.ibm.com>
In-Reply-To: <Y2OAdHBIGXVnN5Ud@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YCP34-w-7o1cFQ_eCzZv-J0pBgYGEWSy
X-Proofpoint-GUID: _MyTUPw9BeN567E8kZwIhGuJEFX6MUVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 03/11/22 14:18, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 12:35:07PM +0000, Christophe Leroy wrote:
>>
>> Le 28/10/2022 à 16:33, Sathvika Vasireddy a écrit :
>>> In a subsequent patch, we would want to annotate powerpc assembly functions
>>> with SYM_FUNC_START_LOCAL macro. This macro depends on __ALIGN macro.
>>>
>>> The default expansion of __ALIGN macro is:
>>>           #define __ALIGN      .align 4,0x90
>>>
>>> So, override __ALIGN and __ALIGN_STR macros to use the same alignment as
>>> that of the existing _GLOBAL macro. Also, do not pad with 0x90, because
>>> repeated 0x90s are not a nop or trap on powerpc.
>> By the way, do we know what the instruction 0x90909090 is on powerpc ?
>> Is that something valid or not ?
> Please also look at the version that's in tip/x86/core (and next). This
> stuff should be gone now.
>
> include/linux/linkage.h now reads like:
>
> #ifndef __ALIGN
> #define __ALIGN                 .balign CONFIG_FUNCTION_ALIGNMENT
> #define __ALIGN_STR             __stringify(__ALIGN)
> #endif

Since the above mentioned changes are not a part of powerpc/merge branch 
yet, I am retaining this patch for this merge cycle and will post a 
cleanup patch (to move to using FUNCTION_ALIGNMENT_4B) after the next -rc1.

Thanks,
Sathvika
