Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA07129BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbjEZPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjEZPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:37:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28DE4F;
        Fri, 26 May 2023 08:37:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QEbxv4025620;
        Fri, 26 May 2023 15:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kZNtTCCv0u/7c3//dp1mIaU7SU4oaIwEAQwigVk+u+M=;
 b=exMgJ9BaZc+guin1FQWgrIs9DEAHWZj9MNVXacyEDmgnL0LPI7GNe4YFYu+5OwvHCLNk
 nXp3bhZIEMzecEi7Yr5Ky5llRnyY5W37UXUSM5Ew8UErW7/+Yltj4VOzY5yZVinF9lEU
 gAdmRUz8xno7X5IyjgONwxtpTgLYeHsD0XnztCbXOwxhrGNx1fWjZbH6HBdlBnZYk9Zy
 5+VWESLdjG8j+En++AgCIjyEHVOJ2VV474UnY8vWeMo57FfXaw7qK6NLb2Yapu5hRLVX
 hxX5EyepaJIsNbH4jP19gACCdgFxXCGJCCn7Mx9uTrxTchqy/U5Qtw/qYJoJaYc0+URS BA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qttejgqm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:36:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFaQOo003018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:36:26 GMT
Received: from [10.216.41.197] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 08:36:23 -0700
Message-ID: <ee9c0ab3-028f-cadf-c577-e57a139de5ce@quicinc.com>
Date:   Fri, 26 May 2023 21:06:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] smb: delete an unnecessary statement
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Steve French <sfrench@samba.org>
CC:     Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <077d93ae-adbf-4425-9cc4-eea5163b050c@kili.mountain>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <077d93ae-adbf-4425-9cc4-eea5163b050c@kili.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v9vSqF_tcM5W4jTL6G08fKyzXQS3qZlO
X-Proofpoint-ORIG-GUID: v9vSqF_tcM5W4jTL6G08fKyzXQS3qZlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=995
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2023 5:31 PM, Dan Carpenter wrote:
> We don't need to set the list iterators to NULL before a
> list_for_each_entry() loop because they are assigned inside the
> macro.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   fs/smb/client/smb2ops.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 5065398665f1..6e3be58cfe49 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -618,7 +618,6 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
>   		 * Add a new one instead
>   		 */
>   		spin_lock(&ses->iface_lock);
> -		iface = niface = NULL;
>   		list_for_each_entry_safe(iface, niface, &ses->iface_list,
>   					 iface_head) {
>   			ret = iface_cmp(iface, &tmp_iface);
