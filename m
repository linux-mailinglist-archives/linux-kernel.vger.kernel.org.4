Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1E5EB9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiI0FrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0FrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:47:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03F8E4F7;
        Mon, 26 Sep 2022 22:47:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R5iTeK002319;
        Tue, 27 Sep 2022 05:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=P7KrxF62RnnerM2HxZ6cCjnRG6c/qbQvf8hziWiGcMs=;
 b=mXRUKcIcFa1HhCnCGvXPvGhhYug9Lsb71+8MU1DC05mp3t+WtrO6nuY6P6w/KUu9s2Ul
 UITpPgTp2VaWlILmclxv250r8G/pZuVom3y4v2PR0Kx7wUiSlbMBFaKvnjTj8h9wmS6G
 xypCDeBf/RvD1AFhZiHrGCBMJi6gweckoJ9EaO/ov+7gBhz+pQPpovLaaEm523/EEA1O
 /ZW7ZZVa9HZ3dQlK8hb1v8GHEfXEDO6wePEfkzOUMXtQaDRSt9Ew1f6kmEK9pcJJeSl0
 VTmhk0OUoR7QI1yFoaP4HNJLMs/rjm8Sy0ptoFIqSdESSZKxN5yfQid6AYuFv4rv0wpM ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jutgthbna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:47:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R5LVG0007948;
        Tue, 27 Sep 2022 05:47:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jutgthbmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:47:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R5as0R012861;
        Tue, 27 Sep 2022 05:47:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3jssh92g15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:47:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R5kv1D4522616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 05:46:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A146A404D;
        Tue, 27 Sep 2022 05:46:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1903EA4040;
        Tue, 27 Sep 2022 05:46:57 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Sep 2022 05:46:57 +0000 (GMT)
Date:   Tue, 27 Sep 2022 07:46:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] s390/dasd: Fix spelling mistake "Ivalid" ->
 "Invalid"
Message-ID: <YzKOT6+oP4ckWBxh@osiris>
References: <20220923132103.2486724-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923132103.2486724-1-colin.i.king@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SmM9pHXfc0VdsYB_w49t18rK2VejN5Jm
X-Proofpoint-ORIG-GUID: lKoNIGf49kkdRyiC-UAh010TzMUjnsSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=936 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:21:03PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/s390/block/dasd_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index d0ddf2cc9786..484de696839c 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -401,7 +401,7 @@ dasd_ioctl_copy_pair_swap(struct block_device *bdev, void __user *argp)
>  		return -EFAULT;
>  	}
>  	if (memchr_inv(data.reserved, 0, sizeof(data.reserved))) {
> -		pr_warn("%s: Ivalid swap data specified.\n",
> +		pr_warn("%s: Invalid swap data specified.\n",

While at it you could also remove the full stop at the end of the
string, which is inconsistent to all other pr_warn() invocations
within the dasd device driver.
