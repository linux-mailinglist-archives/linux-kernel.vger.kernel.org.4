Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35865BC588
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiISJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:36:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2625E9D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:36:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9EPRl020982;
        Mon, 19 Sep 2022 09:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mri/Ozzh1D6QEvL4YeMkkqmFikG1V4ui7Dr1CoNgmXQ=;
 b=xS3cWvOksPKvzlDDEBjweiMfoKLYGWAiz7kgErjJnyA2X2BfLbgtRWCQTrx1vGeKlKWO
 utCPhAM3ykoomahhIWi2ZPdj+JO4utXwZCD5KqKWaYj7jRgbuHjjxC/RKqqFmqL/l+o7
 lBJcyxzJUY79OVwV+UUNfaeLffGv7pqGRPg4xI4UnygQVLAo7L5Zk3ADon8G35K4y4bs
 f52NDI8SmhymUTq1BFBA4QAmb/9fNWEQacAG+2bQbvN5zibrhVm24CyIGKbbt+j56Yam
 W3bYwXi3jTDJ5d/KbyOxLWf68MOLPVHbqv8gBjb6pMjiG0G1jbhs9TYcjTGrLIe0irGL fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rb96w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:36:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J7rLq5036352;
        Mon, 19 Sep 2022 09:36:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39c3rak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9HRGrRUWxUJfNKOxeLSvQ0IQzyx/lVoE3f/X7/6dreqVqgkseDp62fLNwDd91WUA4Zhg5Lw88YbBwmcA735xP3koOPdXHS123oi+k6iZNW83ZB5l0f5K5TLMtuaDPf2EpIaxIrNMca/gX2yLaHlMPKNbC+7sdatEsmCqlEB64/ITUZP5CNzOtwzTndVtd5l6rojE12YutSa9ebiJNp6l64OwvUDJOqMJJH6f8mAhXFyn+QwbNKwVXsQtAljqQfOMhtQHVZVSGTPSzi3PHSQbGozH0jWkJ7iPJ5L4qbdFf7gYEwMvSEfpZm6HnnuYokAIl1B/GcszJXTf+p/OhsrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mri/Ozzh1D6QEvL4YeMkkqmFikG1V4ui7Dr1CoNgmXQ=;
 b=SRnRo19b1+6rqrrFNL4fApJzn/PcRwDrSmn/lNbJwt95FItQj3QZcFkMAxi59sD3VVPCdLZUG85vjmnBZKNXQ9mjt+W8gBDh2+qZmDlwEf/lPMOyof/M4ogepuBaEla+DvxKfjrUk1wASrCKvjr1rJ+cjPQmS6Uei5vEeiKFuk51lfla9QkH6LvAipB11hCqOTCNB+8eU45vheif7WAmq29sIepQ8IZgyUSa9wuPcrq9AJbuWKezBQqxFwhvKrIitQ6o3J3Vkfg/uzJ+5iUR0H9DOar72+kR6ABpgySovTQIMkp1Udx7NJomAFwqE458UGONu5IMahmnHtmRI5xFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mri/Ozzh1D6QEvL4YeMkkqmFikG1V4ui7Dr1CoNgmXQ=;
 b=BfwIP/pzVqz+noL+MVI0vYf/tvSLfrVNGwopO9itn+3fxLYBG5aBYhYOXQWLGyjgFtRBBOheTv9s8syS3+Ovzq/Cw2fyPsKqdBQ26PyS2DurAJETyNsO6HVgJiaZg15s6AiDj7QUJLMb5TJC632MRKCabGX+d0HYdbyRy7DeJkA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4437.namprd10.prod.outlook.com
 (2603:10b6:510:3a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:36:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 09:36:30 +0000
Date:   Mon, 19 Sep 2022 12:36:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] staging: vt6655: split device_alloc_rx_buf
Message-ID: <Yyg4BTymed1fEzQx@kadam>
References: <cover.1663273218.git.namcaov@gmail.com>
 <311eaa7dabe12d0baeb0af6f85c2b43b20b230a3.1663273218.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311eaa7dabe12d0baeb0af6f85c2b43b20b230a3.1663273218.git.namcaov@gmail.com>
X-ClientProxiedBy: MR2P264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 27adee37-e191-43e7-1308-08da9a226e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70j5xOdNk0TNCY0rIeKPstL4V9CZb8+0I6b95YnzqxM5XjkeFuTQPTDF0MHSnBkJjSAWvpMbuztyFLp/RaZnVZDrRwofJQdJLyCzLC0/qPAQeskxRbw6K436+GY/MovwmTnI9BKEm0v0Too0xksfzkIGXL4Gj7V1omIJ5Q679n8N186OoDpcLz4LRFVmGQy1A5lFs89rPLe8lAbyETO2kXQqF/eay1ZOIIr+Qvqo51wuE8VT+aGWNvuwq/DWCz2gvrtHfZc7ekqDEuAVhJM8nl/Hhtlb+nKpZriM5ClA4DilUBIHopmwiuNPjDcNQlcxkmNciv99bD8F+HhR/PP16VJ8iHxH+P1CbWvGlHYCuM8l8siw/vIUn4jKVDLvrSdsUUZJ5cPk+EA5Mj0hdAqX5sfEUiLdkQkWgCeDPv51LfjGRPXlKyJRHBf4+xxieFrKjZySxn+Bl33JcMXjnqM61z8bFqV4OhiTRotfSnVu6Wxm9M+/iszTIke0mt/vrKcZYBahbBZmXpdABXjZQIg2eV7BhKE/WaVDqKBXoY3qyQlj/zwYY5Dop/K4kj3hHfHTvyxjdD2FNsIyjAOP2HLhv9UffiOpo5mlncN+SDK8880Y+qm4jpOoRItLN96cCDuKPKu9P3utiLjB23ZTEHKOro3Zh2l0ti8R/zgv7D9p/sNUd5im3WlXrDqKmye2XQ7Zn14lMzDxwc4j+O4S7dslQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(6666004)(8676002)(38100700002)(9686003)(6512007)(26005)(6506007)(478600001)(6486002)(316002)(6916009)(5660300002)(186003)(83380400001)(2906002)(44832011)(41300700001)(66946007)(4326008)(66476007)(66556008)(8936002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCMVLkRfIhgOVQVSTCQBYOc8LptieN5fXU4Iafofq5uIJzS6ejp3lX+YlNdC?=
 =?us-ascii?Q?Vvt0aBX3WsSZlsLYjNI/7g8upxaVsRoyx5qPJm875r5/ayhJ1cb8CxyS3faW?=
 =?us-ascii?Q?TyrDTn3dSRRStKgJlV//3LHCvMR6RzedHQIIMkG6pIGsuv8AUsjZvGOUkPao?=
 =?us-ascii?Q?1KCDjYwQ19JKgNff0KxHcpKGoJBZ/BmeMsHAWoKS8D6Gqb0MMbzm5dfZUVRW?=
 =?us-ascii?Q?9Kgb9WBRskpnbyto+U7diKwme0LQVxf95/kL1Bp2demWzGsrsJgH1wGiZ6IT?=
 =?us-ascii?Q?tcjPbQ7rRt7XWZm1HRIABpLkKfE8Gdp7R52h4pkVkQLFLzfpsHgIvSvt9I2e?=
 =?us-ascii?Q?JImi5IMRtJpw0Q/Hrd7oOQJXffsDfDigNPEgy9OUgxG55OPFpdCzJ26DqH2Q?=
 =?us-ascii?Q?Qq/xzvFKjoAzotqhyM+WF69NQE3puAqhe9P4RUbCOmbu7FEVO6aqdswQe4Cm?=
 =?us-ascii?Q?yGwQWMFoPFuzGbm8TuZAaKvc6qlWj18uZeUho6uTFRlFXhzEqbemqV48anjw?=
 =?us-ascii?Q?9GXFTNdA+6RD0yobmg2JwGQMLmBNsz122p12NefY3fjTwieqkiC6Ey/FeO0P?=
 =?us-ascii?Q?MbDW5DHns0u5HQ1H7cxIZLpvQT/hIlhruOVrBmpMgUXBtUauktzUxvM/jXxt?=
 =?us-ascii?Q?AWLGLb20tySImReVNPdLQs+8iDFeEdFIWa1dAza5c33h8Nwd9aQgJiIB8Fek?=
 =?us-ascii?Q?rVt4RLHy9HFfFKQnmC3UvzX7JN6cN7X3c0q1JGslg9tLVTOuqUKS+gUEUKx4?=
 =?us-ascii?Q?IiBm15/iMN9dhROBbu1pN/J6DNZhqKdhoI2V9eUjj5JnnLd5g0mWL0kg42Ey?=
 =?us-ascii?Q?wArhNCHPIW7a2b7pOxaSe24Ncxx5xCv0OkYuh/vtDf7PpxLr6HvOcG5tEyc/?=
 =?us-ascii?Q?GlKogo4RsDfQgfz8tkR3YnNNx06FDPV9S7rYTmojHll1TXX+Me3DvT5t7DQG?=
 =?us-ascii?Q?qSQcN45ZYFlO6n5swFZc89dnObVhWHCydkypXX+Rt+hbnFdHnVtcgagCrbtR?=
 =?us-ascii?Q?WvTsvSMpCQpbfnp6idtS3cXCUGIfPHaJGy9Sz+lX+jt2w+dtFLGUkDNAAaql?=
 =?us-ascii?Q?oOL537Pmm2k++vvzyNoSdE+Oe24uEe9jcoGzOadIEe3GGhNDLJgGUf72igtT?=
 =?us-ascii?Q?dcsqiaffh7hzQGFcxdbCcfWwh4olCRjz+OHC/ffDrBhQqGl/nF4p13WkKWHz?=
 =?us-ascii?Q?SDJ8pDIcu0HkltHky5WtButQRuZshkfN7nHRSIfveSwWUsuATXkaoisn23gp?=
 =?us-ascii?Q?NkEpj3i4JvJMvEpQcm1FJv/nxeQ/8bwIzq8pnRgwGMC8tde9gBY7ZWhHPJyV?=
 =?us-ascii?Q?rpZxidBU+56XCgPmunwuc7L65GElWEqRIFsIpfHMJW/Ry3fdoyYqh1pS3G/r?=
 =?us-ascii?Q?2Y25npbdG4/QRg0OEyqy9+94pAcEJXNmUrjpnSAAh5lHwjOdKVocrnK4HXPk?=
 =?us-ascii?Q?Gn33PdRVFJ4qVji/NKDFv9quMpqFYMxfY4dQNlsdLyhkmCjPoP/ZbmoA2wWS?=
 =?us-ascii?Q?TdoYrhQ6Kl0S3ddoQM6e2cjpwEJtwkdy0+cWOHsN5IRWFzses+rYvLxw+vW3?=
 =?us-ascii?Q?rjIy9scFaWYAy8xEo+S51wbIYwukjjWInsELwvEBZAHfrvkg0nICBHmwPhDI?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27adee37-e191-43e7-1308-08da9a226e85
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 09:36:30.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJDtksVKrcaxIJYCFNdxWz/udMnsubo3QK6uEZD0lp9aARB5XXeQc+50F8PBZZVndGJ0VVOR/SL63zgflI21o/zS9+OIscy784CP8oFMbFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190064
X-Proofpoint-GUID: m4Su0JIbQEVq-E4raEm7osLUcbE2CdmV
X-Proofpoint-ORIG-GUID: m4Su0JIbQEVq-E4raEm7osLUcbE2CdmV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:29:34PM +0200, Nam Cao wrote:
> The function device_alloc_rx_buf does 2 things: allocating rx buffer
> and initializing the rx descriptor's values. Split this function into
> two, with each does one job.
> 
> This split is preparation for implementing correct out-of-memory error
> handling.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/vt6655/device_main.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 79325a693857..27fe28156257 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -133,6 +133,7 @@ static int device_init_td1_ring(struct vnt_private *priv);
>  static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
>  static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
>  static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
> +static void device_init_rx_desc(struct vnt_private *priv, struct vnt_rx_desc *rd);
>  static void device_free_rx_buf(struct vnt_private *priv,
>  			       struct vnt_rx_desc *rd);
>  static void device_init_registers(struct vnt_private *priv);
> @@ -615,6 +616,8 @@ static int device_init_rd0_ring(struct vnt_private *priv)
>  			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>  			ret = -ENOMEM;
>  			goto err_free_rd;
> +		} else {
> +			device_init_rx_desc(priv, desc);
>  		}

None of these else statements make sense.  It should be:

		ret = -ENOMEM;
		goto err_free_rd;
	}

	device_init_rx_desc(priv, desc);
	desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];

I haven't reviewed the patch totally.  I don't understand why it's doing
this here instead of at the end.  But then I don't understand why it
needs to be in a separate function at all.

This patch does not make sense.  The commit description says that this
is a "preparation" patch.  Maybe fold it in with patch 5?  The rule is
"one thing per patch" not "half a thing per patch".

regards,
dan carpenter

