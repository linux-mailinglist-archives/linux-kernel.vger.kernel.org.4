Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8373704A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjEPKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEPKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:17:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4144A5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:17:37 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GAEZjm015805;
        Tue, 16 May 2023 10:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm7kngp2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 10:17:29 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GAFbfh018353;
        Tue, 16 May 2023 10:17:28 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm7kngp1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 10:17:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G5UiLi005778;
        Tue, 16 May 2023 10:17:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sjd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 10:17:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GAHO3o38732252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 10:17:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 945DA2006A;
        Tue, 16 May 2023 10:17:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9BC20067;
        Tue, 16 May 2023 10:17:22 +0000 (GMT)
Received: from tarunpc (unknown [9.199.157.25])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 16 May 2023 10:17:22 +0000 (GMT)
From:   Tarun Sahu <jjs.tarun@gmail.com>
To:     Yuwei Guan <ssawgyw@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yuwei Guan <ssawgyw@gmail.com>, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH] memblock: Add flags and nid info in memblock debugfs
In-Reply-To: <20230516020645.160-1-ssawgyw@gmail.com>
References: <20230516020645.160-1-ssawgyw@gmail.com>
Date:   Tue, 16 May 2023 15:47:20 +0530
Message-ID: <87ilcsr367.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nIWvXz9dR5epq57_e9VXgjA0BjCEgX89
X-Proofpoint-GUID: FAlfHxlzAjqnYoKJk5QwReglLVqG9-5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 clxscore=1034 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=759 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160085
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guan,

Looks good to me, I tested it on my system.
Feel free to add

Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>

Yuwei Guan <ssawgyw@gmail.com> writes:

> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when the following scenario occurs,
> the information in the existing debugfs cannot make it clear why the
> address is not consecutive.
>
> For example,
> cat /sys/kernel/debug/memblock/memory
>    0: 0x0000000080000000..0x00000000901fffff
>    1: 0x0000000090200000..0x00000000905fffff
>    2: 0x0000000090600000..0x0000000092ffffff
>    3: 0x0000000093000000..0x00000000973fffff
>    4: 0x0000000097400000..0x00000000b71fffff
>    5: 0x00000000c0000000..0x00000000dfffffff
>    6: 0x00000000e2500000..0x00000000f87fffff
>    7: 0x00000000f8800000..0x00000000fa7fffff
>    8: 0x00000000fa800000..0x00000000fd3effff
>    9: 0x00000000fd3f0000..0x00000000fd3fefff
>   10: 0x00000000fd3ff000..0x00000000fd7fffff
>   11: 0x00000000fd800000..0x00000000fd901fff
>   12: 0x00000000fd902000..0x00000000fd909fff
>   13: 0x00000000fd90a000..0x00000000fd90bfff
>   14: 0x00000000fd90c000..0x00000000ffffffff
>   15: 0x0000000880000000..0x0000000affffffff
>
> So we can add flags and nid to this debugfs.
>
> For example,
> cat /sys/kernel/debug/memblock/memory
> cnt     flags   base..end
> 0:      0x0     0x0000000080000000..0x00000000901fffff
> 1:      0x4     0x0000000090200000..0x00000000905fffff
> 2:      0x0     0x0000000090600000..0x0000000092ffffff
> 3:      0x4     0x0000000093000000..0x00000000973fffff
> 4:      0x0     0x0000000097400000..0x00000000b71fffff
> 5:      0x0     0x00000000c0000000..0x00000000dfffffff
> 6:      0x0     0x00000000e2500000..0x00000000f87fffff
> 7:      0x4     0x00000000f8800000..0x00000000fa7fffff
> 8:      0x0     0x00000000fa800000..0x00000000fd3effff
> 9:      0x4     0x00000000fd3f0000..0x00000000fd3fefff
> 10:     0x0     0x00000000fd3ff000..0x00000000fd7fffff
> 11:     0x4     0x00000000fd800000..0x00000000fd901fff
> 12:     0x0     0x00000000fd902000..0x00000000fd909fff
> 13:     0x4     0x00000000fd90a000..0x00000000fd90bfff
> 14:     0x0     0x00000000fd90c000..0x00000000ffffffff
> 15:     0x0     0x0000000880000000..0x0000000affffffff
>
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> ---
>  mm/memblock.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 45f198750be9..34230b258e21 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2045,11 +2045,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	int i;
>  	phys_addr_t end;
>  
> +#ifdef CONFIG_NUMA
> +	seq_puts(m, "cnt\tflags\tnid\tbase..end\n");
> +#else
> +	seq_puts(m, "cnt\tflags\tbase..end\n");
> +#endif
> +
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
>  
> -		seq_printf(m, "%4d: ", i);
> +		seq_printf(m, "%d:\t", i);
> +		seq_printf(m, "0x%x\t", reg->flags);
> +#ifdef CONFIG_NUMA
> +		seq_printf(m, "0x%x\t", reg->nid);
> +#endif
>  		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
>  	}
>  	return 0;
> -- 
> 2.34.1
