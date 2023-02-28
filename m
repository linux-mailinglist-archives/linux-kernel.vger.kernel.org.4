Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B846A5E95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB1SGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1SGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:06:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1C22A3B;
        Tue, 28 Feb 2023 10:06:10 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SI26in018800;
        Tue, 28 Feb 2023 18:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hVktTuDzbdnCEYqkslltKYwTzBv1mpYfJVOt2DKa9qY=;
 b=UXMozoPZvP/ISehujz8YpZ9+hHc/qHKmIfMfcuri2WZ/YPfdpFZrm3A5r+LeiGBap7gp
 BNeV1WGYwKgf43LzauYsr9YdQStwrzf8O7QMf5kEYd5p0bSQbSNrPHA5CP3XfmE2DGJR
 5rvv9Yx31jxc6wbIaJWtv4EnZRS5WX20ub2At30vzIp8WbbhV1Qo5ov7JjLY/fdwM/fo
 jc/DSnRduFnm/Sg91OiwKbk7Nb4L7ZpcgGemyo0kwIkO5TpMH8NadhrgSbTjvKTzJCr+
 HZAUqASEJayB5FTzjyAh6Lc1kOuet0sqibReJt+cRGck5xp2lot5sgAf4Z7fEKtfgam/ AQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1pg4g7g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 18:06:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SCtbHr021478;
        Tue, 28 Feb 2023 18:06:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nybbytgh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 18:06:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31SI60N73277388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 18:06:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A27520040;
        Tue, 28 Feb 2023 18:06:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0699420043;
        Tue, 28 Feb 2023 18:06:00 +0000 (GMT)
Received: from osiris (unknown [9.171.64.87])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Feb 2023 18:05:59 +0000 (GMT)
Date:   Tue, 28 Feb 2023 19:05:58 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] s390/zcrypt: remove unnecessary (void*) conversions
Message-ID: <Y/5Chi/JhrSoI65x@osiris>
References: <20230223011212.13045-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223011212.13045-1-yuzhe@nfschina.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: elmniAKSCf8pBBed_WnnqvhNx09CDqq_
X-Proofpoint-GUID: elmniAKSCf8pBBed_WnnqvhNx09CDqq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_15,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:12:12AM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 5ad251477593..09b714c6adc3 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -926,8 +926,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
>  		.type = TYPE82_RSP_CODE,
>  		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>  	};
> -	struct response_type *resp_type =
> -		(struct response_type *)msg->private;
> +	struct response_type *resp_type = msg->private;
>  	struct type86x_reply *t86r;
>  	int len;

There are many more of this. Please convert all of them, or none.
