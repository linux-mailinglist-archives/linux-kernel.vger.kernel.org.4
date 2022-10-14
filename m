Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD85FEBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJNJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJNJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AB1C69FD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:31:16 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E8iPFG020587;
        Fri, 14 Oct 2022 09:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=83O4CiYMmCZaLA6j45bwJZJvj0eE7PUIgTtTH05BV5U=;
 b=O+Kdp1MCnEoKJh25JzoQN3eP8CA6DO3Nz9wYOyQ5d63o/vcf6j7jxbmcPi3n6Lg+/jeY
 +xpR+fOkT3dfTFcdyeNpuMV3SpiALRYBVXb5AuVGeIXGqVR9qOY9i/5Xx7n03uW3yJPd
 bc5mQyefhwPyHuPW81KMI2/PIZ7LLbgbgK5OBHDV3AZAsKvhJaHJGCYp3amwDbWilMa8
 ol9194WKhyCROAhGXmhkF8q9UQMLt3+71exn7QnB3kGxidlJQmAguAnOuwihtbsIP5tg
 tleUtNLfHdbfDZiDXajxZ8ATCMf65Wnr8uhKzdbzhsO8OLlRZ/JIhqf+wJZrqiiVrEB8 KA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6gw1tpss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 09:30:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29E9LANx021738;
        Fri, 14 Oct 2022 09:30:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3k30fjgx2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 09:30:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29E9VNrB52363554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:31:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF960AE045;
        Fri, 14 Oct 2022 09:30:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AD2AE04D;
        Fri, 14 Oct 2022 09:30:51 +0000 (GMT)
Received: from [9.145.12.104] (unknown [9.145.12.104])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 09:30:51 +0000 (GMT)
Message-ID: <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
Date:   Fri, 14 Oct 2022 11:30:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] gcov: support GCC 12.1 and newer compilers
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
Content-Language: en-US
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -jEytvD5xtEjyBZHqMe7yQfzyCGaD1Az
X-Proofpoint-GUID: -jEytvD5xtEjyBZHqMe7yQfzyCGaD1Az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210140052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.2022 09:40, Martin Liška wrote:
> Starting with GCC 12.1, there are 2 significant changes to the .gcda
> file format that needs to be supported:
> 
> a) [gcov: Use system IO buffering] (23eb66d1d46a34cb28c4acbdf8a1deb80a7c5a05) changed
>    that all sizes in the format are in bytes and not in words (4B)
> b) [gcov: make profile merging smarter] (72e0c742bd01f8e7e6dcca64042b9ad7e75979de)
>    add a new checksum to the file header.
> 
> Tested with GCC 7.5, 10.4, 12.2 and the current master.
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>

Looks good, thanks! I successfully tested this patch on s390 using GCC
12.2 and 11.2.

Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you add this patch via your tree?


> ---
>  kernel/gcov/gcc_4_7.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index 460c12b7dfea..7971e989e425 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -30,6 +30,13 @@
>  
>  #define GCOV_TAG_FUNCTION_LENGTH	3
>  
> +/* Since GCC 12.1 sizes are in BYTES and not in WORDS (4B). */
> +#if (__GNUC__ >= 12)
> +#define GCOV_UNIT_SIZE				4
> +#else
> +#define GCOV_UNIT_SIZE				1
> +#endif
> +
>  static struct gcov_info *gcov_info_head;
>  
>  /**
> @@ -383,12 +390,18 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
>  	pos += store_gcov_u32(buffer, pos, info->version);
>  	pos += store_gcov_u32(buffer, pos, info->stamp);
>  
> +#if (__GNUC__ >= 12)
> +	/* Use zero as checksum of the compilation unit. */
> +	pos += store_gcov_u32(buffer, pos, 0);
> +#endif
> +
>  	for (fi_idx = 0; fi_idx < info->n_functions; fi_idx++) {
>  		fi_ptr = info->functions[fi_idx];
>  
>  		/* Function record. */
>  		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION);
> -		pos += store_gcov_u32(buffer, pos, GCOV_TAG_FUNCTION_LENGTH);
> +		pos += store_gcov_u32(buffer, pos,
> +			GCOV_TAG_FUNCTION_LENGTH * GCOV_UNIT_SIZE);
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->ident);
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->lineno_checksum);
>  		pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
> @@ -402,7 +415,8 @@ size_t convert_to_gcda(char *buffer, struct gcov_info *info)
>  			/* Counter record. */
>  			pos += store_gcov_u32(buffer, pos,
>  					      GCOV_TAG_FOR_COUNTER(ct_idx));
> -			pos += store_gcov_u32(buffer, pos, ci_ptr->num * 2);
> +			pos += store_gcov_u32(buffer, pos,
> +				ci_ptr->num * 2 * GCOV_UNIT_SIZE);
>  
>  			for (cv_idx = 0; cv_idx < ci_ptr->num; cv_idx++) {
>  				pos += store_gcov_u64(buffer, pos,

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

