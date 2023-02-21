Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF169E879
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBUTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBUTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:41:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E02CFF6;
        Tue, 21 Feb 2023 11:40:56 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LJUxK0028060;
        Tue, 21 Feb 2023 19:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sJHkJ2+KfEf+APTWfzsOwEWtjLO+lDYbMW/GVXPVFrw=;
 b=faqxAFuTJU+tmX1xoIK79LntjUZHHIe3/eyYMTgHwescjpt9geCprlwYS9kuVtLZbNhk
 XY7vmWK+N5Vn6yusi2u0uV1RzPl+Ke7XNf0Fq4CmsWXRo18wXZUV++S4eFUXkumeU3Y8
 9cTFSvSENq517Ecx4d9OAsAK1CjsS6bw8f8/eM/NDmc8f/oed9t9E/jpprX6mgkydfCn
 m02eyZucG+l3lVyx24InxG4Up7eDcOso/OhcenYULDQr3O8DJEh8Ej9Zfl6yFVnUAEJa
 xLg3TYdO4sNw8L0eOIMx8kSKUxtav5la8VuD42eMXZHWwuxc2URgrnAIbfPR1BAUvtgp Ow== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw46ar77y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 19:40:50 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LHl8Yv014128;
        Tue, 21 Feb 2023 19:40:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa74cwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 19:40:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LJelJK54984982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 19:40:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AA8958058;
        Tue, 21 Feb 2023 19:40:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D124E58057;
        Tue, 21 Feb 2023 19:40:46 +0000 (GMT)
Received: from [9.163.50.38] (unknown [9.163.50.38])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 19:40:46 +0000 (GMT)
Message-ID: <6180bf1d-265e-8e77-c507-967ee103f80a@linux.vnet.ibm.com>
Date:   Tue, 21 Feb 2023 13:40:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] scsi: ipr: Convert ipr_probe_ioa_part2 as void
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y7rvQyMOGcPKPTv8@ubun2204.myguest.virtualbox.org>
From:   Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <Y7rvQyMOGcPKPTv8@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_eWofi1reUCKiSBfNNxofTwgJ-2Q_-X
X-Proofpoint-ORIG-GUID: Y_eWofi1reUCKiSBfNNxofTwgJ-2Q_-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/23 10:28 AM, Deepak R Varma wrote:
> Convert function ipr_probe_ioa_part2() to return void instead
> of int since the current implementation always returns 0 to the caller.
> The transformation also eliminates the dead code when calling
> ipr_probe_ioa_part2() function.
> Issue identified using returnvar Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v2:
>    - retain and update Return value comment in function documentation
> 
>  drivers/scsi/ipr.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index 2022ffb45041..dfb759fbbd87 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -9505,11 +9505,10 @@ static pci_ers_result_t ipr_pci_error_detected(struct pci_dev *pdev,
>   * This function takes care of initilizing the adapter to the point
>   * where it can accept new commands.
>   * Return value:
> - * 	0 on success / -EIO on failure
> + *     none
>   **/
> -static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
> +static void ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
>  {
> -	int rc = 0;
>  	unsigned long host_lock_flags = 0;
> 
>  	ENTER;
> @@ -9525,7 +9524,6 @@ static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
>  	spin_unlock_irqrestore(ioa_cfg->host->host_lock, host_lock_flags);
> 
>  	LEAVE;
> -	return rc;
>  }
> 
>  /**
> @@ -10568,12 +10566,7 @@ static int ipr_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>  		return rc;
> 
>  	ioa_cfg = pci_get_drvdata(pdev);
> -	rc = ipr_probe_ioa_part2(ioa_cfg);
> -
> -	if (rc) {
> -		__ipr_remove(pdev);
> -		return rc;
> -	}
> +	ipr_probe_ioa_part2(ioa_cfg);
> 
>  	rc = scsi_add_host(ioa_cfg->host, &pdev->dev);
> 
> --
> 2.34.1

Acked-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


