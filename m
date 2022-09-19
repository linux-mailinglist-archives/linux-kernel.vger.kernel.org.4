Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06B5BC4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiISIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiISIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:50:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D38BE39
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:49:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6kVG5014702;
        Mon, 19 Sep 2022 08:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+LExEAD9pCdjROqW5iUAtbvV/MP0RnidH9HS6koM6cY=;
 b=gXaul2+Yvduy+y52hO4SobRGA75crWOP4CvJo+N3nRHbqQJI/Vh9gpihdaDVI2vpJyeC
 tWQ+djfsAwy2Wvzhu+XlVBVZ0pCq1fqwrbkUliiRhNaJZBGEIH1H+pIT+4pM7ciSngCr
 kFuFMJ5bl+rfa/dzR1umFZ1TU855/6J4iBqwS2rZnzT0Xg068plkHHu3NbKq9NAB3Cd/
 Tqn+DqJ6WY9UfODr0JLl668lpjJE0lr7rwfm363lovWwsihwv9Q9JLhfemcwsnaGu48t
 VGLxOkuzVa3zxcKJTtvm7j7YziEm7Y3Pyynr7qrm88HdvDatnSNtx0XxTCoXJ1CZng/1 YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m352q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:49:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J7Po73019076;
        Mon, 19 Sep 2022 08:49:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d0jhtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMx3Y9wXmRSyDKiKtAXVGv0K3ESRIYLvXrMHZCmhXN72s28HJfYq4xlZxR7a9d1niUXwUJ+aquZRX+XOJ6kbDVqx7CB4xvEve7wCSGqHXRSNd8Aunbhy3hsfYjaJdnh8iRK2MQj7Sb5dBbJjPZlPyqJnx9oKgr07dhLI/q4EDD8XXr20NRLQSBRfTp0RgQ14WHVx4gvKWRBaUxgZdkTumlrtTJzzUdt6Q6W5lmptkW8UsiJHdMnwDbLcoaPrRT6mrNog6eQpDZ1xeVpEBwoRRGCfk2FJixel24sp32HpyG2TdL6DVgZGd467uaWRPKhj3vK4LJCM/CV5ZEDOc+MSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LExEAD9pCdjROqW5iUAtbvV/MP0RnidH9HS6koM6cY=;
 b=GI15jHWlLhySPvrfvhqwg7PNtZRAYbyEH/BMItLKAJgLzm86vGsXtfHxa7wccj2GsJrYiFFqd6mjyZ4QP+kEUYk5B3HWOmF6ETuURs0t2765RN6Jo59nkOxzg3ckUFhshsrTpUtzD1iqNq09Q0FNUKp8dOxgKbVIpIjVkk9LfIoxVmf4F/DNcmVrN8m2tZaScp9D0hxcOTLfR/be1jo317XZjWnr7l76/iAcJgF+nyj8xAjKYfEsaASqm8QYSiMJo6bmtJ2goz5q5tUHsH3csi9YgtvwiGZLKJhETcOKkx+rzpu1LBGKX1lyxtmmMKMeX1Opf0EOIPdA0kfqBjAm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LExEAD9pCdjROqW5iUAtbvV/MP0RnidH9HS6koM6cY=;
 b=S6NmtBJoJHXrWhgZQ41vqYBGd0599K8fr3BUQZzCjrDAWlvMKVtWPkSzBBgmwjU8xM9BLaMXJWvmFsmYwk0MAB1qYxssvqvyRiuJvnN42UNGy43a74ug5ujY6P2lz/mcJ26zMOBIcHGdh/PkDwtW3g2dzCukzCzCkcqKIHlD+lY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4989.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 08:49:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 08:49:07 +0000
Date:   Mon, 19 Sep 2022 11:48:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8723bs: Fix coding style issue in block
 comment
Message-ID: <Yygs3Vuuglp1EmcZ@kadam>
References: <20220917181130.3237159-1-tegongkang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917181130.3237159-1-tegongkang@gmail.com>
X-ClientProxiedBy: JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3d5725-7cb0-4088-425e-08da9a1bcf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nv/O3C75ry8YwzEDsNrJLebL7EIvOiA7wuCoa/VQ3yEdtea/r+H9LH2zzqVjEopwo6xziN/h8jvDsCcPFUQQ7tKLYcWb5FyjMR5aywWHhalDKNZUaVXC2Fe3cC15jXNd0hvHoja9CG1oLvoFbBRIOWchQSZYqDG2rTbNC8Ps4xUsX6CKG4JRoIx8cKodQzeoKn6JsxoOYm+06OhFveF+F2POqUOEkzFBtWOo4R/dla+SXN35x/WAKvfchqtiNHKoSOJbjtWrboxfZgu6+mkwDXnGsrmvV7p8hYXhqmaBmfePK0omIIQDSgMjTHvYdTtyyzM0HjhouRQSZ++W4GFnoPgXov3VtQ42Nvz7VTa4F0J1THzpmxiLBtKv56RnXprpf+ocoFKYndsiNDN5vU7NXRrXtgm7EnJ4cfJ+DqyFzLONJ+/QViOoOizFVTHvL0z4X9ZzPIDLyUFJxwuYyPzyH+ZqauPURRUv1wRRPKwE+6OKCd1lWmaWp8suQNys6x+/FSsvzLMndOU8TFkmYAg9qYNFlABmdGvd3uPdfUDMAjsiAR17IKB4lLNpIVMm6I82wc/pNNeItjhjkmjLSwp2mhRLPlk3yawtZvMnqqrQdvPFlyBflB4kFHVcjQswY9n9OmArjcPe1CPvZyp0uCNWQwTEwy17ABLu6lWKTTkMZ09orfv6tmxfd3VnK2MGg/9wny5YxCMBjGLEev+0eyvALA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(38100700002)(8936002)(186003)(41300700001)(9686003)(6512007)(2906002)(33716001)(26005)(478600001)(6486002)(316002)(6916009)(54906003)(66476007)(66946007)(6666004)(66556008)(4326008)(6506007)(8676002)(86362001)(44832011)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCc1SPxT/ezZjZ/KpwznDA0OX3qEK4FesnlolTlQneAEie1zMkVEPD/howuI?=
 =?us-ascii?Q?iQfKqunGDYP8HvWoWNmliwb8PU8fq1/qI0RgNlD4gGBwVU88ezRnsrbDfuZP?=
 =?us-ascii?Q?DDNWklPUKWXv6MVE3n9lNHU/uSEsWBD6PHEPY5WH7keLLww/Lrh5zFXCLznz?=
 =?us-ascii?Q?YTcMZ/OyuN0fQiQ65GKah5MfOd89vKJ0M7eKTA5tvyCeN1t0B0L/xL0q3zWu?=
 =?us-ascii?Q?bEMgAy29PJsIXSnt6Pc+YBfJeTeyFaBkSAIHh5ntEJBqDMqTaNUC/5cLscvX?=
 =?us-ascii?Q?5rO36SUuAZgFbudnglo+PHm82PD0y706ilRCoADkWIbBsmHRKf/c+vnEyyMk?=
 =?us-ascii?Q?PdNdfJlqAOti7ubmVUDmZ4Tv7pt3Hc/dphAlJDUK7OduSLjr8PwHltHrJiKQ?=
 =?us-ascii?Q?mxBbOiAQBVuDmVuNNxejHgXJV0tuKqjlVFTZ2RTfHjUqJsDo0fXCYHo4VGoq?=
 =?us-ascii?Q?k9z9UMltPI673h0o0DCLbLr8htiRwVHphdbdcO9exUPToX22JVJnEE2bVBpa?=
 =?us-ascii?Q?NGHSIxdhMrL6665xaqfbw1UI6diN9NXyic4epQVKSWKEUnPC0wlM/ZdCig/Q?=
 =?us-ascii?Q?TZe07dcDFlIlYXogqjPFMi8lZkIEGlfJAyDS6bsDlRQp578r1k9ne7P0UjJf?=
 =?us-ascii?Q?9n7hEInalKKkYlT/xj0/LLWrkuyPC3NQ7EdwD6Xv9ENCd4G2SbXch1dqetBZ?=
 =?us-ascii?Q?+2uMG8RsC+mkRC83SX+o1t3nH7d5rc0zu7VjXDsUQ251EdsPT4Eluxb/4CwF?=
 =?us-ascii?Q?EQ38jULGmIRrVNqEFcjqcVfztSncpeOxvIvMVFPK20MjXT4uJQdKpQUSR/en?=
 =?us-ascii?Q?knv6S8IHSISGE1JbHwmNepftuFzhtX1EX04EzoTtSXd7tWqCyqClcY8cjHmL?=
 =?us-ascii?Q?uWUJF7V4fkOvMx2kkIeCgMPUYrk1JAwvknFzQNQJEXwH2/cXC2SXMV6yaxmc?=
 =?us-ascii?Q?jZtFa/xykGU2qgiGP7PJpLW70PFCf1DNaiMNwP+C0oRFfYKacqT10a3OYQnh?=
 =?us-ascii?Q?5qs/txpd5EVFAI6tPPZSf0lXgySA4PBhRm92fPEU2tC8+zfKZmXsXVbhO4R9?=
 =?us-ascii?Q?2MdRK0T9vluoTvfWFjJuPPTJHgNsOW31Ywq+fg4SYUc6463BNL4NRq3GT5R1?=
 =?us-ascii?Q?lRNFbxc9xi7CPnolofHlBoP9XHV8FVKrh3IO9Zi8UqsSlmZK1Nh4dpUscMCh?=
 =?us-ascii?Q?62iFD+avZC496/K9MGA1Ucz1KAlXnCHunMaoafcK1dxE5eAKhD+hnrjJ8wAg?=
 =?us-ascii?Q?pvF4yrK1mcg2HzlzSE3ny+AURGcDjBc5DQCUZUXYsrbsQJmOA7lmEwVdOI9M?=
 =?us-ascii?Q?lkuPfePwZN54uxlZFXEujZRBhEa3t2n7lIwS0jhxaAYMLru4iMi40NDWc+zk?=
 =?us-ascii?Q?fOGiA9KbH8xzShSb8X9eZRAXvEXbi/cAaDBJp+RNKuPQ6ZJD0qZrWsuE/wxn?=
 =?us-ascii?Q?NDLcb8F8eKtJGu/fuwyO86DbCp7AVVrUZntBw8mdJ//bQhrK8dPyderZx9wT?=
 =?us-ascii?Q?TKj8ZVgsoCFpuwzRQWr2RxWUY6Bk72vQnUZ0AXteB1UgtqUg2XeeMkcTcs5d?=
 =?us-ascii?Q?LopEaZ+sokSdiOU6EryDffLjy+QKDv/kBLwS0UWYAzQojbBN4qCab8mHjYek?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3d5725-7cb0-4088-425e-08da9a1bcf9c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 08:49:07.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgNkmxIXyfkWxgf83icQxuG4chivrnKWzBvmruN287uPrgfko/eedTGj7oM1RWGC9AB4sSOdx/MIUdRsBDPGhyGTIJLrRR9KLianeWkI8bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190058
X-Proofpoint-ORIG-GUID: jJlWoCD96nWcJxppCV7SZ0f5gu6A5E86
X-Proofpoint-GUID: jJlWoCD96nWcJxppCV7SZ0f5gu6A5E86
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 03:11:30AM +0900, Kang Minchul wrote:
> This patch removes the following warning generated by checkpatch.pl
> 
>   WARNING: Block comments use * on subsequent lines
>   #206: FILE: rtw_recv.c:206:
>   +/*
>   +signed int     rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> 
>   WARNING: Block comments use * on subsequent lines
>   #216: FILE: rtw_recv.c:216:
>   +/*
>   +caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index d8d394b67eeb..ad6fb6c3d1f0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -203,22 +203,22 @@ signed int rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *q
>  }
>  
>  /*
> -signed int	rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> -{
> -	return rtw_free_recvframe(precvframe, queue);
> -}
> -*/
> + * signed int	rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> + * {
> + * 	return rtw_free_recvframe(precvframe, queue);
> + * }
> + */

Just delete this dead code.

regards,
dan carpenter


