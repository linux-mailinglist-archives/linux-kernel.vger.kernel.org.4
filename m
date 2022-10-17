Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEC601AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJQVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJQVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:05:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34BE2FC00
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:05:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKXTkI023769;
        Mon, 17 Oct 2022 21:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mIn3cZZbpmlcGAuNmLd4+sWdqyJNCY0paEHPVgBLvH8=;
 b=MN3Gje8FDDpkS+DWYfahzqBqpFxKbGe3Th6OLteK4vEqjv3jYZdlky7LgMuWXqlAYVQf
 /KoLuFM4MzwC0uAFP1XrOGhn5ytxN3MlYCY8oKNCFS5T9GKL2bQ6tLGFA5WfS8T7Xu+s
 bUjZ8UwsCz794qsI+0lZy9EhcWSu6CeCAGrt8djq4lnOxAWsv5hMwKAz+ar/HTpFdtwr
 n/Yec4QCcF/P1hjq+4K2mcPJXCrN7PC9m8UvtrxXeLkObcgBYA75pLFzBvcWeM9Iy0UF
 57l2k7zLaG8aF8A1jAZMO39hl4bBcaTtaaJWGb5U+e+O0JvtAtZ86iwqs9n6c4pLGmQu KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sghpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:02:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJQXcx036409;
        Mon, 17 Oct 2022 21:02:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htf867n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqMCCs4T3MA5vd5Vnz0mKr263hd+5zYwPtXWqxxWjCopJJhvPzC0swhbn38xGe2H5+QDREanCBgGAknZmHjfkMwv9Vh+Z27l6gotCjvIWZi5dWsjvvZb5B49L0V651ts2A/fymyRBzvvAWXNBNKeNToU5Lv4oqmBAMv4IgRxqjjWVCNWF4VA6tam9p/iqjDaN4wGqXLOEfXkimTZj7XKb1G9fqulA15eaXqRQ+A3+ztq74ZKHEBT/U1x/4E+hujeq0AGo8RT4MupzrL9yKM2nPnsZmBBnoB61q4FgNVlkvOkaHDp/qAFClVzh7V90UYlaf8hlRM/xqVYUE/7G70HRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIn3cZZbpmlcGAuNmLd4+sWdqyJNCY0paEHPVgBLvH8=;
 b=ltxxcsfjxcll3fqyL/DB/EU4hkHShfLesRCVhhGynHNrOhAYp7qVxUUQm8eTLfB80cYdUH529Z/WpM9YZsE2dvWLqe80dnufHIzAXl9vm4Uj9vhgLUDQF/WL/4hxlTq6qK5Gtlls1dWtA3Yczfj5dsI/OgvEWKetjnqVbBYwfaIGM9A8jP2peHWUDbu+1hl1uQdncaEg4w0Hn3Pa9m6+ExQPsE+wvtsbvbY1v3DNJF1b1A/CquQcwGPlH6iYUSqBjvM80dq4R3s4l5rExdDN0YpKl55ZOTPsLM2h8UAfnb3pNyjstE+CXQLZ6Rq2Y2mUPsRavyq2ipJp5wUkQ3WooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIn3cZZbpmlcGAuNmLd4+sWdqyJNCY0paEHPVgBLvH8=;
 b=KHdhAqWj/a4hwKnAnHiw4XHLUJoxiuj9jMn2Fgz+DvD7ijHQXYUvsno2ZjSONtjKcte30gpL9EUO3y7MZk54Xx7tk5SxdXTBt6R9Gie/8iSUBS4fEY1zLA1dYf3nCNWTj8t+rgeDshNx6q9ec+xhLJLAPzcBfsljnd106k5+tJI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM4PR10MB6720.namprd10.prod.outlook.com (2603:10b6:8:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 21:02:36 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 21:02:36 +0000
Message-ID: <0fd1269d-9ea8-15b4-2b40-6d8a2838c866@oracle.com>
Date:   Mon, 17 Oct 2022 16:02:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] fs/jfs/jfs_xattr.h: Fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, shaggy@kernel.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220902085338.2536017-1-13667453960@163.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220902085338.2536017-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM4PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddbf8c3-0482-499e-03d8-08dab082eb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yXaVC15/pxNQOXXPqwgmOThWSDRNmxtRJ9735/c0x6mYQhZeqL+8VL+GvzlXwW+BreFKd7fSXX3W05rB6Q9AQ8ZMzDNU1ThD7AdNP6cgZefWSNnawyT/fLq1t0rlbMDyMIMKUAlxUmwr1JuZSnBpcRHABX3mi7cxT1NIWeKox4zfqh6lGsCFMsOx3m6lybJrc7CfA56NGvb5vd7Ps8Gm1okB8BVN4owcROkoTo9QnKDjHas6DNuvbrdzYEGUBWumytrqoASeR9HRY5V+g9NvOsTdLCB8m6OU8eG+Pgqna3jbmPaAgNzvW0Xlq399527V8e4xjHiqk7nHDUNwESQYL6EtUfKmKAbLbPgaENhMM+TUdpyOvhz8GvqkWwgkJ2Z77b1bm7/5wvcVVYrsnXdqCpJr3wzO4VXe5mbwAQ3QriKCn2/Rys0Mz7tD6LzU0h7ghSB9lI8XlnyU8pT5enCqjVBVpvDUYa8REgZKV2Nn/80zy4CavB1mdPbZeiSxp6dZ6iyYOKTOvxyftRX/s8omvWDqD7/QEP5XvL78n/9FjkJrlftpPmJ5XgGVjp+aJVlOHQgjNPxCDwARvoegRVOC8hNDS+jXJy6T+6RBM84clv2xBacujZ8Ny4WTRSKtevtinSu3d9RPZtBNjGyrHXFZmBdz6L5njvxyt13Q0t3+GJug9VGDRrSh31JOo1JtR03se0Ldpa7pnLLHXZx2eOE8BuOjAOPObbDrCDtB81gAC+jeMVtKse7YKymlfvikPpEwp08oDMe4i/eqekZntmb3C4gLwbWKNBawIp1RhLWJ40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(83380400001)(2616005)(186003)(31696002)(86362001)(38100700002)(5660300002)(2906002)(4744005)(44832011)(4326008)(41300700001)(8676002)(8936002)(6666004)(6512007)(478600001)(6506007)(26005)(316002)(66946007)(66476007)(66556008)(6486002)(54906003)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNiVHU0M25OZU41L2xRSUpSRmxlZ3p4T0NuamxIVDNpeTNiWWtlVHpRaE5n?=
 =?utf-8?B?MmZFams0K0NWQnVjMll2VS9IZlF1Ynl0WnViYklCQ2JXYTliZ21pTm9ta3NO?=
 =?utf-8?B?ajJnc3JjRThJVEV0czBCNWZDcStZWldVcitQM0M1SmxZdkdIdDA3dGk4cVJO?=
 =?utf-8?B?M2FTU29iNkZaL2JPdEVQM1RPaG9xeGVMWlVwWFQ3RmlmdHFHVE5jMFVEMlgz?=
 =?utf-8?B?U04yVFJDOFZhZEtHeG4ydXNFTWVRMGtqNjVZZTBDQmdaL0gxU0MybzhuN1RO?=
 =?utf-8?B?WEZ2aDA5QlcvZGJvc3VGWmNTbzhYRTlUVzJuSVFvdjVyR3J6VUg0ZkVzT1Rx?=
 =?utf-8?B?MlVjVGtFa3lQMGVzVHE4N3JSa2RhS3NZeUdvNzE3WlNWOGJLaGxIK2dmR2d2?=
 =?utf-8?B?OUpOWThWaFRqYVhWZmVVc0NLak1jZXlHemdpUmVKb2NqQTcrMlB5YlJzTld1?=
 =?utf-8?B?bkFPWmtGUjhreWZHZE5tLzUwTGVqYldoaVY3VEdocmNqQXZOYWVwYzZUbUNP?=
 =?utf-8?B?ZElaWE56UjJoclJYenV4bG8zK1RxTERnMG1NYlpHQWJZeTNhbHhKcjZ1aVE2?=
 =?utf-8?B?V2tSTkFPNVExTzJYUjFkNUJiaFNuU2E2STErMjVXcUVQNnQvdktHSzZya2NB?=
 =?utf-8?B?aWhtRnpyUExRT2wwVEZWTzdzZkxPaExCKzBrbjBxSGxNTFNmalRtMHI2MjBM?=
 =?utf-8?B?YTlvZzZ1S3F2YThpRjQxcGdIbWJVbFVrOFN3N1JRWktIb0dlNjZUZVo4akQ3?=
 =?utf-8?B?SSs0Z2s1VkxpdGNZRjFINkErbUEzcjJEa3ZsWlgyZDM3WEZzWit3dm9pTmY4?=
 =?utf-8?B?dXlWM3FQdzdxTWtsMEsxZk4xR0xhRVlKYjB4WTNZczJJcW9rNWpGbW16NzFZ?=
 =?utf-8?B?NmQycHhZTFFPWGQzdm1BdkNhNjJXUUdSaFVSSGxpNDlPbGJxTytaVWx0WVBY?=
 =?utf-8?B?bmpoR3ZJbFpvVnhCKzcyanVZY1g5WDE4UWpaSzczcXY4Z1VpTWM2eEtzS3hK?=
 =?utf-8?B?R3VBUVNCOWs0ZWJJNC9pMUx5NHlMV2hGbElVYS9CVUZzdUxXbWhhaGp0alV5?=
 =?utf-8?B?Skg1MCtEZFpNTGFHOU1odmtBaWoyT0IvUGh6aWJsbS8rYVB3cEtja1Q1Mnpw?=
 =?utf-8?B?cWNuTlUvR3p6TFFYOFB1T1VEK3NWR20reWVLUkhaUEtid3BlYlZmMGRWUU5T?=
 =?utf-8?B?bVowNHEwVWZuRnBHWlgxZ2dGRDRDbnVrNnlyZ1Q3ME1TckhtTFUzQWJHRU1o?=
 =?utf-8?B?MWd2SUw3c2ZkQ1RzNEl2bzJldTZNK3gyNFQ3V2RaQVdNN0JYTUVVYmtic1E2?=
 =?utf-8?B?ZTVwTzNrWjg1MStudVNHWkh0RXhUeDJOV3p4Zjl1U09KYmFjNEgvZVJ3Ty9n?=
 =?utf-8?B?bkV1c0xIcXAvSlVGQm8zMkkvRTRZYTJ3UmsrREpUSWRhMkFnamNuZWFPK2R4?=
 =?utf-8?B?ZDRKdEpuVmJzaVVZWmo2Mzl0RldWTnFKZENTTTdBenJST1kydjZ1VG40Tnpz?=
 =?utf-8?B?Nm1mMXJkeUc4WE9HSTN1ZzZWcUgzcHdrdGFIREswVFdmdm1YZTFsb2ErTmdC?=
 =?utf-8?B?TWNpU2J6NXpkN0c4VGpIT1pVRU5GTGhBV2hrbStFLzMzck5QOTh3WE9ETlQz?=
 =?utf-8?B?aGpjQU9xNE16cGM1eStmWWcyWUQyWWFycGZoRkN3RERDZUlMVjFkN3BzOXg4?=
 =?utf-8?B?VndCcm05ZXp5Nm1hN0dWQnB2WTJhcDVGVVBpcExjbDVwQkdaOFlCL0RtQW53?=
 =?utf-8?B?NHUvT1lWMnJIVjd1QjhTazQ5L1dYaDFET1IyL010YTdJRjJnWXRJYlI5MFBz?=
 =?utf-8?B?RXFVOGNucy84aVdpUHdUckxZbzNvZmZKMjNGZkkxNmJYWSt1NjlDMDB4RVFa?=
 =?utf-8?B?QTFuTkVubVBKMWh1KzRzaEhVMitlYTYvQk5HRisrWW5BaTMyN0trQVZ2Ujc0?=
 =?utf-8?B?MGpVd1crNzIrVFYxWmk0bU1UVGFhbFdVZHNQUWNVaUlWT0NrQWJRNnpmVWNo?=
 =?utf-8?B?UXBJbzlJQnpEZ3h2QUhNbWFxTFFBSmJJVFZHM2dCd2ErTmFmUmdDa3Rtb0pW?=
 =?utf-8?B?aGNwNzlKRkczSnJablhVUStPbkZydEpidTlkajF2SkZWaE15a2Nianh6bE1G?=
 =?utf-8?B?dGJoMUVPaTd4NzFXUWpHVXJPZHNGbllNTkVlVkQ1bVp4MVRnbmQvRGlGZzFL?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddbf8c3-0482-499e-03d8-08dab082eb14
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 21:02:36.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB2LvJCYg09gZZMBmMYDW93LF/Cuxa8p2s/cOavRUbAy9UDNXj6IuQpjSlX10brMneQkPHNU7GXY5Yb5WzMFkwDi2gUckP0FsJSNr55igm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170120
X-Proofpoint-GUID: GNdldTXXRwra0p3a7pItr0adV34XHEYq
X-Proofpoint-ORIG-GUID: GNdldTXXRwra0p3a7pItr0adV34XHEYq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I finally got around to applying this.

Shaggy

On 9/2/22 3:53AM, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>   fs/jfs/jfs_xattr.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
> index c50167a7bc50..0d33816d251d 100644
> --- a/fs/jfs/jfs_xattr.h
> +++ b/fs/jfs/jfs_xattr.h
> @@ -25,7 +25,7 @@ struct jfs_ea_list {
>   	struct jfs_ea ea[];	/* Variable length list */
>   };
>   
> -/* Macros for defining maxiumum number of bytes supported for EAs */
> +/* Macros for defining maximum number of bytes supported for EAs */
>   #define MAXEASIZE	65535
>   #define MAXEALISTSIZE	MAXEASIZE
>   
