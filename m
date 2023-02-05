Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331B68B010
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBENu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBENu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:50:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AD18B01
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:50:56 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315BgaVP027951;
        Sun, 5 Feb 2023 13:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g8a+qgyUWaer0l1AVogvGQVTOXSfhy6Km52fPW/q4Os=;
 b=X9P9NCe85h2px4kB3AkWw8uEEBH6PXpLijUsY9Chdo1TeQNcn0hAQzKBB+v6m7928ZJo
 GtlrUl00H1J+m2qhNEnPPKGh+1mOWrx16+5bLMbMhfqLQ7XHR1LpA5H/pmVdPIUA4meh
 rA8dqTgI/8jBktYYi98QwzhsgM1nKlSXYn6YHBDWEMH1OU0PZ7ubwwEyjg7xpB6I/c4f
 2JsYXNGKMTfbO4/Ig08JI0vAa+L92LRh3K2Jp1ecXq1KFbECB375Iw9GifXxMTX7SUIu
 57//A3+2lpY7j8AIDlr7MSzkSRwPQvbGjxRTYYCAUJvhbgG8MKv2idBW0ehq5JtCojAl Iw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nj11khm5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 13:50:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31501sjt021050;
        Sun, 5 Feb 2023 13:50:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfhe4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Feb 2023 13:50:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 315DoZPq52691444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Feb 2023 13:50:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D7B020040;
        Sun,  5 Feb 2023 13:50:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34DA42004E;
        Sun,  5 Feb 2023 13:50:34 +0000 (GMT)
Received: from [9.43.31.177] (unknown [9.43.31.177])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  5 Feb 2023 13:50:33 +0000 (GMT)
Message-ID: <637cfc84-e5a0-18a7-79ad-cdf474aae6ce@linux.ibm.com>
Date:   Sun, 5 Feb 2023 19:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] powerpc/kexec_file: fix implicit decl error
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230204172206.7662-1-rdunlap@infradead.org>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230204172206.7662-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: htnR4W9iV277DBby18oLzuxCnlPKuylG
X-Proofpoint-ORIG-GUID: htnR4W9iV277DBby18oLzuxCnlPKuylG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-05_04,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302050114
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/23 22:52, Randy Dunlap wrote:
> kexec (PPC64) code calls memory_hotplug_max(). Add the header declaration
> for it from <asm/mmzone.h>. Using <linux/mmzone.h> does not work since
> the #include for <asm/mmzone.h> depends on CONFIG_NUMA=y, which is not
> set in this kernel config file.

I didn't realize that linux/mmzone.h includes asm/mmzone.h under 
CONFIG_NUMA.

from linux/mmzone.h

#else /* CONFIG_NUMA */

#include <asm/mmzone.h>

#endif /* !CONFIG_NUMA */

>
> Fixes this build error/warning:
>
> ../arch/powerpc/kexec/file_load_64.c: In function 'kexec_extra_fdt_size_ppc64':
> ../arch/powerpc/kexec/file_load_64.c:993:33: error: implicit declaration of function 'memory_hotplug_max' [-Werror=implicit-function-declaration]
>    993 |                 usm_entries = ((memory_hotplug_max() / drmem_lmb_size()) +
>        |                                 ^~~~~~~~~~~~~~~~~~
>
> Fixes: fc546faa5595 ("powerpc/kexec_file: Count hot-pluggable memory in FDT estimate")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kexec/file_load_64.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff -- a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -26,6 +26,7 @@
>   #include <asm/firmware.h>
>   #include <asm/kexec_ranges.h>
>   #include <asm/crashdump-ppc64.h>
> +#include <asm/mmzone.h>

Yes including the asm/mmzone.h will fix the build issue.

- Sourabh

>   #include <asm/prom.h>
>   
>   struct umem_info {
