Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770673650C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFTHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFTHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB731716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:43:53 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K7f4JD015190;
        Tue, 20 Jun 2023 07:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fjrabIf4HS+xzHGwit1Rg45PNAxZkLQNHIOhQQVNugE=;
 b=n3WrWDETlTbShH8SjKvcY+TjosLZdL1eXtLge/wbGHiLDKdfr32XWzIGNlK/3p6FNl1m
 Gj/3MoGY6yi6Mogxwnxj45jek4EMgCSP6emlZ9wGVMEJ7sJC2IHrqguvCVM6jZvJR+S5
 CE4UB9wG/FWbvQsT7eMKWPR51AFE848YSBYPQWe+BU1FATgKTmCzNh1ZWQj14YVE0CMY
 H6RR9ZJ9vIofK9+V8HDqPOusJntbbmbUDmrgp0zs39VIPMuS31WsjhulbXfwxJ5tg/1w
 oD4Srn+xv5Wegbvf+LsYXj0DZE9TY2rkbq2zBNcCqHoPEAF2hR0GEG2qDM4nVylIFkBf bg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb7kt8r7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:43:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35K3S3J1028011;
        Tue, 20 Jun 2023 07:43:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r943e1x3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 07:43:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35K7hRq810420824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 07:43:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1B72004B;
        Tue, 20 Jun 2023 07:43:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BBB220040;
        Tue, 20 Jun 2023 07:43:27 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Jun 2023 07:43:26 +0000 (GMT)
Message-ID: <b75bb8b1-6d55-8062-00f2-dff4ff59efdd@linux.ibm.com>
Date:   Tue, 20 Jun 2023 09:43:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH] cxl/ocxl: Possible repeated word
Content-Language: en-US
To:     zhumao001@208suo.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230618150648.1123-1-dengshaomin@cdjrlc.com>
 <787f5a712a0459bc21d83bb388770b58@208suo.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <787f5a712a0459bc21d83bb388770b58@208suo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fgj1IvywEEuKdP1K7-hS11tDgkbwWIGL
X-Proofpoint-ORIG-GUID: fgj1IvywEEuKdP1K7-hS11tDgkbwWIGL
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

While the correction in the comment is of course ok, the patch was sent 
as html. You may want to check/fix how it was submitted.

   Fred


On 18/06/2023 17:08, zhumao001@208suo.com wrote:
> Delete repeated word in comment. Signed-off-by: Zhu Mao <zhumao001@ 
>  208suo. com> --- drivers/misc/cxl/native. c | 2 +- 1 file changed, 1 
> insertion(+), 1 deletion(-) diff --git a/drivers/misc/cxl/native. c 
> b/drivers/misc/cxl/native. cindex
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/PjiDSg!2k-hI76VihO6WgXx-IHFLxDVOAL2DdWMKjPu4ApiehtDXYjNrTR1Cj6nYDmD8SP9M8AZ7TpWUloL0Ixn_2IX60uI2MsuBkM$>
> ZjQcmQRYFpfptBannerEnd
> Delete repeated word in comment.
> 
> Signed-off-by: Zhu Mao <zhumao001@208suo.com>
> ---
>   drivers/misc/cxl/native.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 50b0c44bb8d7..6957946a6463 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -920,7 +920,7 @@ int cxl_attach_dedicated_process_psl9(struct 
> cxl_context *ctx, u64 wed, u64 amr)
>        * Ideally we should do a wmb() here to make sure the changes to the
>        * PE are visible to the card before we call afu_enable.
>        * On ppc64 though all mmios are preceded by a 'sync' instruction 
> hence
> -     * we dont dont need one here.
> +     * we dont need one here.
>        */
> 
>       result = cxl_ops->afu_reset(afu);
