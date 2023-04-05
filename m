Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3C6D84BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDERTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDERTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:19:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB085276
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:19:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CxKiW010301;
        Wed, 5 Apr 2023 17:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oY0NZR2Ph2RmcmEPCX8OqMFCRL2BEVgxa3kpo+URebo=;
 b=ZapN9hDSETTSR4i0iHzyVTcxM864AJJiXscJFviWhX3j7rLnvO9xUA5Myu2p6gdC6vRf
 O1WrZyoOuBp5pI8TWXCXZ+luUL2SCb85ySgiuE7hJVYguvpxhP2Uzi7gakUZdpksYMoc
 JubZvGSp6s3C3wT/EGRLMxDm+3IqPM1tvQJsS0nRAuXeuOjnujOTa4KSqzN3bQsxfUp5
 g5Gq37+0iUVNDvUURDpVHTKdOqcK2S3KBEv/lt+vIGARI0f5MF+Qu8q0dWQZOFgHJXC5
 IFf4adqi/ruSruBTplMu14vZconWwLlhd5Ngbr6X8tIDFlyi2pIfcIGZEhyImFBnUOOh Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd410j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 17:19:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 335H8gIt017517;
        Wed, 5 Apr 2023 17:19:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp8x0yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 17:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQVSQ9u6Ohjm3tqT6j+wyT8xK2yXJwYzBShbWTFRU5KgqYopLghA0qsOi8Y7+xI8+XgeJ9xbUiukfOr7OeFSjdihlvNAYXI9J8ax0S6mC6RLEsSXt0yed0DYmJ3Yh2W72+ODMJy0GHj9BHJD2zOjzPM1uEFKEKcAGQsA4UplHf2k5mqbiFJ0ipy6YplzVJ0Ugg00cZAu2ZYDsLxpvbW7dFfGWV2+WUChxuPxblMpyIhcUc3tJ7sQg4hgPGTTrsZPA8wv+PTJajLN8kPBFBH87w9c65G/QKjTWAEQNe0BA1Mti95/vXkoyFJLWJrC9sa7FssibG7VUk9VZB6Y0DKcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY0NZR2Ph2RmcmEPCX8OqMFCRL2BEVgxa3kpo+URebo=;
 b=bxuZyQG+F5OuGKfjXUNcC7dcM5xmkb62A5OCKweV/gcxEFKmP4chFZtlf1qCs+hx0UITtVn8fUDnXMYg8SKqjNa9I2OmWWqpVim6IyG+4BqvvkWz85qSKyMjybfYa9rPGWrZWona1NSueYmeB7SiYJG2wGdWFCGBoCFY7AXMlYzB+urEeLFuiN6xIGPITbIYkV7BRWiYKi5LryU6WZdoY0rD1whII0Y9ThOBAUo+hmqZNA5O1dcUaG+HXVyfpR5M7aX7GH7j6ktOXICeHtYHTbmJnayI+gSEfi5pMeuhxkssZUQjOTI9FZ08eoRXOeWmBKoh0hxsISci+lmVVwA/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY0NZR2Ph2RmcmEPCX8OqMFCRL2BEVgxa3kpo+URebo=;
 b=vaIW8uAbwf1pf+cKuQIoZiYE5jIwJsmHvsjvmE8F1tlTyg7+/aEcaeNKctrF7oHx7b6H8OGDGVxyQJz1sqJ61L8r5dbp4NgkRVJ46IPvm+EfNMc2ARL2nx74gcBSC0eR1iOQuTw8aZ9SB62r9oaaSznwR4u119xcNUzE12bNzPs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA3PR10MB7044.namprd10.prod.outlook.com (2603:10b6:806:31c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 17:19:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 17:19:15 +0000
Date:   Wed, 5 Apr 2023 13:19:12 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH] mm/madvise: Use vma_lookup() instead of find_vma()
Message-ID: <20230405171912.6o7tiy6qzg5wfyi7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230404094515.1883552-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404094515.1883552-1-zhangpeng362@huawei.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA3PR10MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d065af-3a7e-45f1-b060-08db35f9e1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgk3w3mxvL0tYsDsXLzHbeJJvbVL7TaHbAmHLJdcZI3ic5yVCTyx6opqw+GN6U1HVEb+BEb6bjjS/TpcX7Avsiz/iAN8f/oqbfAw1xurc00m/oFyOtcEPmngeESNLU2YTqFPlbz2ttX3ERQBivi9gwoBny7gHEFT3IXM+KwRknFLPc5AqK7121nGkQ2PTwp+MG/79NdAFtDLkMxYaU/rInRZ6V4zaIjJmirYJ3Y+VNujhyskJ3/AN7VHo/JohtVaCXguV7KyGgk+GTbDxr6ix61EUqbIjM/VxM8hfShviMuLtGT/DXdy3GJQrgv9BZXDXMiAGqtTQKH4SRjIqejYG8NSHAhb4LxdjXGF/+6f9Grhd5fZa0NVtFqqTPDXJzytPTni58uAooFYTsumhq+jJbx93YlXBO9LN4isOJVX2jbBbmzKlxTxaBx9BwFYj3wv35PFpdGcqEdZ9Oikqmagj0suaJChvhuSef7AacIeaY+fUwNUAmRMt2XtBQEzdbTO4zae0xSm3UqCO2NOrl+J653rtEDUNDgr1wqN2Tz0uPS+hhCY2AEACjmz8p0NXyHG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(478600001)(6486002)(6666004)(316002)(6506007)(1076003)(26005)(6512007)(186003)(9686003)(2906002)(5660300002)(33716001)(41300700001)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(6916009)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EltK/RE9ISVlzC31Z+1zvSs6Ntso6bHN93bCISWxd/ta2051NAk2qja1yHoB?=
 =?us-ascii?Q?+rSnAJVloNz5cP2Rjr3J/42+FWyMORMgMO48AatqOs/iHvat258rBZgYa2YZ?=
 =?us-ascii?Q?pO2Q0nYVEju8usUgXXGxY//dB/8RvT0tK+ZNkQA8HKKl40iUMT/vpuiBEJAN?=
 =?us-ascii?Q?Li5scK6B2Hbm+jnxLC1usO+wStoJuvZbmSW84BK6Qt/cWxWbaiJDBzgkIkdR?=
 =?us-ascii?Q?NZliekYmlVep+MfDysMRxqpp0KANL7j6QCMMKHkHj7n18S4m3KV+BchGgVXq?=
 =?us-ascii?Q?pn9p0CKF2QAG2iSabyBynvudjXV8C9dX+b7oTZoQwCNPPYCoDXDnuM7nk7gY?=
 =?us-ascii?Q?Pid5MEstzwXBrS/SjttoKK6uQK9DQIvj8TZd6Ss3gyLrhi0B5iR6yrJFndHp?=
 =?us-ascii?Q?H+AleafIZd3daIElYANGepONjD6rqd9hxT07lMv/+F9scDF3xROaBbgUdM68?=
 =?us-ascii?Q?6HtdTZZlLLQVVIOQtWwcpWlVvyFhaoiJm7V/NpdcG3K9Z8jrzVOrMOwOlQMo?=
 =?us-ascii?Q?vC54AFTPb8OGig8xpRW65GiNF5DvSdOwXJ+FSyxASb247WEDtwS44KZAD0CY?=
 =?us-ascii?Q?8+e68S0roIy/GeszzreMW0H589x+K6YOWAUlm3CLdkyNRRmq92+KJIQeOYip?=
 =?us-ascii?Q?ei2UX2bYYRT7/sdROl6MpSsrBQff6B5HGEpjvw24Znf/XnzE/Wm7u7jcoF27?=
 =?us-ascii?Q?uIZOy+EuNHbl7bpBfwP9o1Nope8K0kY0bvcnkwKj3uL2FX/Mjt6LzqD7y6vo?=
 =?us-ascii?Q?MXdsYSvZazXh8zrGdpiJYRsZ4vdsh673IjhJa6oO00UkfUuTZkaaRoq8aluK?=
 =?us-ascii?Q?xCtcQWS120P9489FbxYo6rN66qlpYTQcdbPyM0LtQBy4vM9/aVVjUhjwNbUW?=
 =?us-ascii?Q?XsJYLe8MTl5iebOKoH9v+mrK4ns6Lc2Ng1kggF7NcXJElGWwd72IWuAhG8fG?=
 =?us-ascii?Q?JT7IDpPfnOOeMhQsrs4pFJP0ug3CKNshTEivBMzx8T1499TkR/Kz0hm41PWy?=
 =?us-ascii?Q?Fdg57nxStZkdFQNjkpoGv30S3GwfojwtZezO5LTP1X+gHibK8JRfsMJd1bRv?=
 =?us-ascii?Q?HB/8Y/qt/c7ew0UztadNKs0+AB5SC8A80TG/9OHP9ayQ3c4YDto44RkKot2N?=
 =?us-ascii?Q?J98BH+YthmBzpluhkzcR++YgXK48VO8SMXiXfbBShcypYJTyidIrZlCiDQw1?=
 =?us-ascii?Q?I4VVNfDjupDIAfB9hSSvvhpLjurSnGOFhR6RYwtRsB5bnNfh0J5EVn+mDPjH?=
 =?us-ascii?Q?FxtbJYF0fSRbPVFmjEt5uRzRwPNAnO4ZbyCDiIKXVdApV9y4DCpAM2Hr1d2d?=
 =?us-ascii?Q?WBpHUVC6JX2Cd9hMEw4tp3Y564tMwGtLyDKli6ZeVx67O2bNb9oSrvf1hq19?=
 =?us-ascii?Q?h4ktuO+HKxuJdVnn6Jo3BFF40Tr/qkMOoLOlFLqgnvAu0cdbEIhiEML8UEo9?=
 =?us-ascii?Q?cCIWK6rIm9yLWcq+TKlL+yYDsRbqcZFu9tpunjQ/1qtrInEnXTWfUactzyfn?=
 =?us-ascii?Q?y3c5aJJhUM4H58Hjze9jtNuLz67sjSgJBJYyOiFtSwFHMYnvdTd6mFvWVl8S?=
 =?us-ascii?Q?YU6Y3U1twWhNkkVE1hpQTgg2C6eAAAG2uvH/AdLt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4RSVGDKUxaaAjAPHdtxmtClRPZrN5QjyZ5V2tBk4z1Wy54FocOCC6+QwgpXp3LDZMTaIfjOUZ9pYSZrLQNObB+OnDp6BN6WZDVSXszfv8Gu6gJCZii5QoQFmo7+r69MI0EaDw015DJDfvK3j5Pvi4CCia2pctHLfJYAWhz5PjQy0UD8xcX2XIYjkYm0op2dWroCLQvmKBM92zMuI95TrnGcMPVFMv2ScDJF+tFAHhJl9ujFB2Ht6U/WtJNINWsmf6lMGVz/NopI178lbZ6VCmClUcUoNQXKaRgJNMuRPWTSmgNAnbEwGxCx4Ii3GNdq+HXHVG+/LUK6bKgGG+pXnaYu7xbAT64l3+KA9i8CVvRRkjKU6EuQWBtDdLnDZbLvAxAV5OKIz8bsA+c8tm2S0w/g0e79yDDnfP2YxzYTbCV71aL+0EQtoszrjh83TYr+KuRWZ5JJX2dirUWRiao3TD7JuvfmhhEsqHECpt1v0zRlD7NGn5L5sL7K4xS6HWH4zCbRGGhJpiqdpMN3s5Pa9HyCkTv/rgqFmOt7fUh/zbhY+biFXKBjcH4O0+wGUxmORTP4PmyH+a345uhqDYqSRUHF60+w/dWCycqfm1nFCrfkeC6x043TEDRna0OEusktPdsKehBdMXQY9Q/GlwjSqXpvppdcV2f11tRPCghanhscPpbQJDxptXM3OpjTRymvkIGoPiH6iL0ARstjY0n66BAxzuxzr1Pj2UuEWWXXLMnzJiZqk51Lkml30ZheTqZ4O4BwTWGZ+thGUS2gEmrFnP71yU/lOK6JSua8TQ1Z56+wHF5y0nLe62CIqil/HuUZoG9kmZGQ/VCH47NO1Hq9nM9RdzY4OzJLyc9FnXLS0h+ttlCPOgQZmDhS+jk6mb9Ra
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d065af-3a7e-45f1-b060-08db35f9e1b8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 17:19:15.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqJWahvmbegEOPGkF7x+cZYE4j1pCFByo7aAv+rW2nNVzRvGpDsuXU0uXgIyzwGU/H1ZP2Vwk2MqflDv/woexg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_11,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=603 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050156
X-Proofpoint-ORIG-GUID: z_MWH1FvXmSjNPCHl-V5-Jpg_hjrhr7I
X-Proofpoint-GUID: z_MWH1FvXmSjNPCHl-V5-Jpg_hjrhr7I
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng362@huawei.com> [230404 05:45]:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Using vma_lookup() verifies the address is contained in the found vma.
> This results in easier to read the code.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/madvise.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 340125d08c03..405a2c4a0a18 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -852,21 +852,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
>  
>  		mmap_read_lock(mm);
> -		vma = find_vma(mm, start);
> +		vma = vma_lookup(mm, start);
>  		if (!vma)
>  			return -ENOMEM;
> -		if (start < vma->vm_start) {
> -			/*
> -			 * This "vma" under revalidation is the one
> -			 * with the lowest vma->vm_start where start
> -			 * is also < vma->vm_end. If start <
> -			 * vma->vm_start it means an hole materialized
> -			 * in the user address space within the
> -			 * virtual range passed to MADV_DONTNEED
> -			 * or MADV_FREE.
> -			 */
> -			return -ENOMEM;
> -		}
>  		/*
>  		 * Potential end adjustment for hugetlb vma is OK as
>  		 * the check below keeps end within vma.
> -- 
> 2.25.1
> 
> 
