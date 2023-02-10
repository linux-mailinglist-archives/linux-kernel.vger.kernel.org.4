Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B76928BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjBJUwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjBJUv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:51:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812991BF2;
        Fri, 10 Feb 2023 12:51:50 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AKhe3H030061;
        Fri, 10 Feb 2023 20:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ff6yqt6p5KoOUHHXhDUwzeUoz5jQIRom3gJ638+WxMo=;
 b=BY5l0qbBLnoXcmUqoAZVQh6Ge7sN0o/bUufZLZ2klm8X3fC+QsYcrXDef/qWsTRQZ/1M
 4DVfubbsQLp3OjtFrEDy0DmrsAyzB1YUa9nDGmvXAmrVd0ipm8L/e+HjbRZSD8ZuKz8N
 RT3uWFAmyOmJBLDdBoIqJH3q9YwnOtiTgRchIhh3Z0jhvOe7BeHeU8Q6vyMO8bG/BNFm
 /e0zVmDjqxpMkDwWtq1+goDky6F0T39qnS2/vDkIY9/N9he9sfeGCRRTuU2XShUACLCE
 8pN7oo0PnY7/2XQ8gDeeRoGSztIgEQNsWUWYvv7flZD/xQw1PagtvEPGRSPhF/oqc+MF 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnw75r4gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:51:40 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AKlBIX011163;
        Fri, 10 Feb 2023 20:51:39 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnw75r4gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:51:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31AJM5Zf002578;
        Fri, 10 Feb 2023 20:51:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3nhf088vdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:51:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AKpbFH31916496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 20:51:37 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9E05805A;
        Fri, 10 Feb 2023 20:51:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AF5E58064;
        Fri, 10 Feb 2023 20:51:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 20:51:35 +0000 (GMT)
Message-ID: <d8d2e5de-54bc-b7c9-a2e7-44b95cd28bb7@linux.ibm.com>
Date:   Fri, 10 Feb 2023 15:51:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 05/26] powerpc/secvar: Warn and error if multiple
 secvar ops are set
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-6-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230210080401.345462-6-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _YKx0a2GHE93Mt-hKQ0DEwanCOilhMcQ
X-Proofpoint-ORIG-GUID: BTxle8nPE5RwwadIQInKd2o0CyebFpXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100175
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/23 03:03, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> The secvar code only supports one consumer at a time.
> 
> Multiple consumers aren't possible at this point in time, but we'd want
> it to be obvious if it ever could happen.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> ---
> 
> v4: Return an error and don't actually try to set secvar_operations if the
>      warning is triggered (npiggin)
> 
> v5: Drop "extern" to fix a checkpatch check (snowpatch)
> 
> v6: Return -EBUSY rather than -1 (stefanb)
> ---
>   arch/powerpc/include/asm/secvar.h            |  4 ++--
>   arch/powerpc/kernel/secvar-ops.c             | 10 ++++++++--
>   arch/powerpc/platforms/powernv/opal-secvar.c |  4 +---
>   3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> index 07ba36f868a7..a2b5f2203dc5 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -21,11 +21,11 @@ struct secvar_operations {
>   
>   #ifdef CONFIG_PPC_SECURE_BOOT
>   
> -extern void set_secvar_ops(const struct secvar_operations *ops);
> +int set_secvar_ops(const struct secvar_operations *ops);
>   
>   #else
>   
> -static inline void set_secvar_ops(const struct secvar_operations *ops) { }
> +static inline int set_secvar_ops(const struct secvar_operations *ops) { return 0; }
>   
>   #endif
>   
> diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
> index 6a29777d6a2d..19172a2804f0 100644
> --- a/arch/powerpc/kernel/secvar-ops.c
> +++ b/arch/powerpc/kernel/secvar-ops.c
> @@ -8,10 +8,16 @@
>   
>   #include <linux/cache.h>
>   #include <asm/secvar.h>
> +#include <asm/bug.h>
>   
> -const struct secvar_operations *secvar_ops __ro_after_init;
> +const struct secvar_operations *secvar_ops __ro_after_init = NULL;
>   
> -void set_secvar_ops(const struct secvar_operations *ops)
> +int set_secvar_ops(const struct secvar_operations *ops)
>   {
> +	if (WARN_ON_ONCE(secvar_ops))
> +		return -EBUSY;
> +
>   	secvar_ops = ops;
> +
> +	return 0;
>   }
> diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
> index ef89861569e0..4c0a3b030fe0 100644
> --- a/arch/powerpc/platforms/powernv/opal-secvar.c
> +++ b/arch/powerpc/platforms/powernv/opal-secvar.c
> @@ -113,9 +113,7 @@ static int opal_secvar_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	set_secvar_ops(&opal_secvar_ops);
> -
> -	return 0;
> +	return set_secvar_ops(&opal_secvar_ops);
>   }
>   
>   static const struct of_device_id opal_secvar_match[] = {

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
