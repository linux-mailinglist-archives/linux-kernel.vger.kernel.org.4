Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D1B6A9828
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCCNKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCCNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:10:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A36199C2;
        Fri,  3 Mar 2023 05:10:12 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323CVICW014013;
        Fri, 3 Mar 2023 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=dgL5yhuvcQ2N+KREVjvh0euyafxN8QfQ3vp/FL5+ge0=;
 b=ZGIirRJ+kC/F95+oDMV5vKX1NVILUnmOdgEJ6XQAEwLEtk0YwI73xlpfYY8gOxG1La1y
 CXvTrm2NdswGs4jpbfxfbPkOfspbulCwWZaRwU7ARnOAec4kqG9kz6RYCw5jxf5/HzlG
 PirLjSZvSUoMX3QyExUFqDjCYskl0yOz0rX42in3niXpr5+OgisJW7dxCoqjudvNSsVz
 lj6hsY3MuS5Ycz6G6nv0Kn/nYiZgKmdurN0IlE+Aik01lpel0PTUeBSo3nRlzw/YD7Uu
 JBO+6qF8es8oauqdgzcyklCsVNiUXz9+3Ts46PJddZ9y1WqjCE2IzIERtOq5F7+spJ/x sw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p3gyjs0gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 13:10:08 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 323AvvIu020099;
        Fri, 3 Mar 2023 13:10:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3nybe2aw83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 13:10:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 323DA5Dm28901850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Mar 2023 13:10:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A79858065;
        Fri,  3 Mar 2023 13:10:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0408E5805E;
        Fri,  3 Mar 2023 13:10:05 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Mar 2023 13:10:04 +0000 (GMT)
MIME-Version: 1.0
Date:   Fri, 03 Mar 2023 14:10:04 +0100
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH v3] s390/zcrypt: remove unnecessary (void*) conversions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20230303052155.21072-1-yuzhe@nfschina.com>
References: <20230303013250.3058-1-yuzhe@nfschina.com>
 <20230303052155.21072-1-yuzhe@nfschina.com>
Message-ID: <98d60c395e7f66a37a22fc42ff74d700@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XFubKWaTQ-nt1gHA89DxJz1CVSEmuB4P
X-Proofpoint-GUID: XFubKWaTQ-nt1gHA89DxJz1CVSEmuB4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-03 06:21, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c
> b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 5ad251477593..a2e7fe33ba62 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -926,8 +926,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue 
> *aq,
>  		.type = TYPE82_RSP_CODE,
>  		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>  	};
> -	struct response_type *resp_type =
> -		(struct response_type *)msg->private;
> +	struct response_type *resp_type = msg->private;
>  	struct type86x_reply *t86r;
>  	int len;
> 
> @@ -982,8 +981,7 @@ static void zcrypt_msgtype6_receive_ep11(struct
> ap_queue *aq,
>  		.type = TYPE82_RSP_CODE,
>  		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>  	};
> -	struct response_type *resp_type =
> -		(struct response_type *)msg->private;
> +	struct response_type *resp_type = msg->private;
>  	struct type86_ep11_reply *t86r;
>  	int len;
> 
> @@ -1157,7 +1155,7 @@ static long zcrypt_msgtype6_send_cprb(bool
> userspace, struct zcrypt_queue *zq,
>  				      struct ap_message *ap_msg)
>  {
>  	int rc;
> -	struct response_type *rtype = (struct response_type 
> *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	struct {
>  		struct type6_hdr hdr;
>  		struct CPRBX cprbx;
> @@ -1240,7 +1238,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool
> userspace, struct zcrypt_queue *
>  {
>  	int rc;
>  	unsigned int lfmt;
> -	struct response_type *rtype = (struct response_type 
> *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	struct {
>  		struct type6_hdr hdr;
>  		struct ep11_cprb cprbx;
> @@ -1359,7 +1357,7 @@ static long zcrypt_msgtype6_rng(struct 
> zcrypt_queue *zq,
>  		short int verb_length;
>  		short int key_length;
>  	} __packed * msg = ap_msg->msg;
> -	struct response_type *rtype = (struct response_type 
> *)(ap_msg->private);
> +	struct response_type *rtype = ap_msg->private;
>  	int rc;
> 
>  	msg->cprbx.domain = AP_QID_QUEUE(zq->queue->qid);

Thanks for this patch and the reviews done. As maintainer of the zcrypt 
and ap bus
code I will of course also review the patch, pick it and apply it to our 
internal
s390 subsystem kernel repository. On the next synch it will appear in 
Linus Torwald's
kernel tree. Thanks

