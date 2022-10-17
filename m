Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777AF601881
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJQUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJQUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:05:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D7C69
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:05:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJi7c8003700;
        Mon, 17 Oct 2022 20:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v5eaK4iHCiP8/TdOD8R4UGP9gFYltB9bFhgFY1Qe/vw=;
 b=11SX//uhm7m++UDVeKxpnajgcrajytG31s+dY668LbJNG5lnXQwrOJoHsEiWuHoVC92y
 zb79Z+a19dVjhRTt7u46Ie0Py48InQBJFc5hDXdlnaqa0xBDexVyymTbIWCYpwINQ7GU
 uHl4l+H+cst/GjgQzmQWiny12tNzmjIpfwyk137nPXK/+m+6fxvpvwKOJQ29rGZj4LJO
 XbTU9jv0F0Jnpff1NKy8XKZrIOUVfThKWYMBxcMLiJtCbg8FFrMPVGGVF8dhotqXfIz3
 KSYfh2GtE4VTbGJ3sCn0gZy/zsv1x0m/FveNhBFD6SzTx/DxQ1ZInRdmOrT8Y1Gx8Ukb rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sgdna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:03:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HHfIDV015933;
        Mon, 17 Oct 2022 20:03:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr9dwss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 20:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEp80cPpZR5hmGm+UtBKHOtJMh7CZ0QbwdvZxRfXDvZ/KfNRr96VL/8rfjRqvB7iRf3WltETtj5LcFqRj5Vv+rW7hJbwTl7u0cjRoVw67D6IntA1clY/VAdC3GwM8E7bWw1JTYmI4Zwft70EjxEhVMGor94VUDGtOpdKMYPhIlClI9y+BcYl6Eiycrz0aNa8nFaa6ry9AaxpqkxlJg3h1ye4vzuxLaTcG+mD+Z1LJ/mECOmnPN0ApA7A+erbsrWTHqqyx7Nxguot8+6VOSvdtkxHMVSggJb4DfOoyOo4iFz1HfSiRM19K2ipAPuqLjOIDtHJKbmrUFAeMRx9WvBTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5eaK4iHCiP8/TdOD8R4UGP9gFYltB9bFhgFY1Qe/vw=;
 b=IhpZeWWh//rZjvJbKbXPda0mUwIfDPc+EjNxtiejzfx7QWBT5Joo+uJuXnn9Q4lxv5VuRkuH841/0ZaIgXCgc16J9pKuh3FVhTiX9PYCBddWoLF6xrSJ3kI8BsE/vTDhA9P02vtk9JJgT/qS8vDt4vShyJDVpF59hItqGoFtLyqInk9mPjJcSA030J709YzVVH72k1X44emSp2WUq809x2uFztVlHVGzJ4BBCa4/xGRib0Lf9FxFwD+a3YRVS5+HKZmyYQoHnVoJa8Dfg+Qb1r1Jy60oJ/EaivYXargsGr4U5zRSZ0pN49h4QMJ+pn5wf4Sj3N30NbO90XvvwDkKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5eaK4iHCiP8/TdOD8R4UGP9gFYltB9bFhgFY1Qe/vw=;
 b=bQx7tDS7psju49xXmYfwOTSZOHAfAi3gdm4ed48kLEsDQE+AZAlplkYWBbeteHwUJV/7UGdCEi3Bja32+gEAzcADV6wWLAKrvmL0gZgHjFFz4l8Gy1Strbd6WRWg42gCLYKujfjrtYoYfoJzGXP42iDLXgIFa+lKpQQaLvaBbWI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 20:03:17 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:03:17 +0000
Message-ID: <162aa836-339e-80e2-3d55-7e6bdcb89296@oracle.com>
Date:   Mon, 17 Oct 2022 15:03:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] fs/jfs: replace ternary operator with min_t()
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
References: <20220714025656.1685439-1-13667453960@163.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220714025656.1685439-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BY5PR10MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: b283b367-754f-479e-3e79-08dab07aa1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VdRP9R1jEG6V+c6l3yZTgknh4e7wRGFnQYO/ETstLhRvN/epm5huUZ772SZ1ulCsPqGXvo7/C9vEEDYpAnS5h9qkQQOfvQgpnBF4/sGzDWOt7r3HcU8S7uXh+iCZodu12A5AkDOqRZP3qo3XIssXxYWzSlmw2PSoXfiNSPiCs7XGSmSMF85FR4zXXmBOq7mhUP0TLHkjzxanTqh0M0o4/b9YbSJbmRlMXKUoIltoxQxaUwd79oWK/IUDTrplC8dAJVH+mJbS50W6ii2Gu08OOMManjhgM+2840nEWiAKQpY94rIp4oZrLQoH8aVDrjWBlNiOIkif6/t8kz7xKrZjOe8wpc8+Q/BG1ujtbG/tdU/oN9XiPDQleRo5BVQ1iVa92buqCIsohuCmT/lh0aX37IHUl+rgkpFr1gYjjA3mTmyR2KPlsNC02O1QFtD1EyLowL9Llsc+26i3YX4w8YBsMpVsQR8I+w51ph4YZvotedBARfx08/jB4XHQNQJszRP/NHImR+UC9ydbyDTbRHZ/dA+5tIgrG8CssR9x+jkGtccQTe+mJvSDKr/ayZCP79PsiLIoHfompyZS/UoL9k2cMh/z2WSphqe9bD48IiOaRbyPioXjDJvcQ/rrGGdrSFjAkFyaaLFU6y9kT7TBBHPkrzmXg3Mvcj7UnYdQeI1qqKjPfEPjit8teVA15srcf7rUzMqiR9Nr5fhC0lf70JQ9qdhJ9jM9dbtT01KEZS7F6JPdQ9D3KLQfhfk4Oh6Ho2laHjD096qal4YAO1ir9hgas6WD7HQHugcUSYBp+1bzb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(66556008)(66946007)(66476007)(186003)(4326008)(478600001)(6506007)(6486002)(31696002)(8676002)(2616005)(44832011)(316002)(26005)(5660300002)(8936002)(86362001)(2906002)(41300700001)(6916009)(6512007)(36756003)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNmWW9tcldWOGtmcmlTUWJVTmVraHVXcDAxY1NZL1c2MWhud2ZvK1NHWGlB?=
 =?utf-8?B?V0ttUWFuUDc2Q0l0eVpKcWFaUHFoYU12bkJUMG43dnZzempsOU5iNWk4RHQ5?=
 =?utf-8?B?T1o2cFNuVE81VW5Lb0ROcVhXU2MyWWUyTk5OeVQwazJNcUc5cHZ1VTVPS0h1?=
 =?utf-8?B?cGpQUnZsMlE1UDVWQ01DOXAzdVZwakE5L2ZoL2huY3NYTEIxMXFUQUZoNGdL?=
 =?utf-8?B?T2Ercjk5U3h6RTd4ZFRwcG5CTGhWYzhtbkJ0QTNhNG91QnZvVzNIdWtHeVFX?=
 =?utf-8?B?Rjg3amQ2MzRPVmltYzJZTGVTZWlYazNuTGdHMGt6T1lMSGQwdVdndUNVWVh0?=
 =?utf-8?B?RUlqRGNxNlcvTGJHWHl5bW9vRWdYVEY3My85NHNvbFlHa2lzR2grdFl0RXln?=
 =?utf-8?B?Y3ZTWkgzN0NYVlIvMmp1NXdRWjZRK2VDVkd0Q1FUWmR6cDc0WlFDK3dlVWM2?=
 =?utf-8?B?K2Jkd0ZRd3REd1RoVjhBSm1PRHlodkhtb1R4VFB3OUNqOFBMR0pBRW53OHZy?=
 =?utf-8?B?eWpDbHV2aDRTNzZwK0NqMGxrcnVrc08vamx4dWxESm4zNGNKRHVNWTBkaVpP?=
 =?utf-8?B?dXZ0VGhNdDFGT2JWZDZ3Nmx0WU9ONDN4ditGNmRPUTZGamhtbzNVWmZJQktL?=
 =?utf-8?B?UmVUdEZYNzhySDdyMWFZN0tac3NGV0RvL1dQRUdZQjYvb1JJZi9RYks1WXFV?=
 =?utf-8?B?SHhpenJLd09rYXRWYU9UTTZCeXJ0NlcwOE5DZ1RBR0FPVTlLT25qWEU2UkNh?=
 =?utf-8?B?UnNYWW5LT2daeWxXQU5xTmd2Z2RUdDZld29CYUFCVmVZdzc1WVl4RTRrTEhh?=
 =?utf-8?B?ZFNOU2xZMjJ3V2lxRmVLM1J6SmQyZ01HOEN1MFhReDJaandSSy95RkJmT2Qz?=
 =?utf-8?B?bVRnZmFGS3NXQThKV3hGci9xbGhhSFZPYVVPSllQRGxwZ1RXVDVFOEFwYk5x?=
 =?utf-8?B?NzZGdUNZT0l4ZktOU3NURVdQbGdBaVFGWUxYV3dKb3NLc3UyczNWWkJoV1Qz?=
 =?utf-8?B?RUFiUXlWa1lVLzg2Tm9wWEdrb0JZM0ZmYWxTc3M0ZGwrK0N2L2t3WWZVd3pE?=
 =?utf-8?B?eFAzNU85RHJIb00xR3l3V1VORUlCbEZrS0xuWC9OZkdmMTliYUpQTU9DTjBV?=
 =?utf-8?B?VEgwZWtvTEVvTEVFakJrVTYwT1JkRVkzWHVLK3RIbndyT1hwcmVWUzdWNHl5?=
 =?utf-8?B?MGRKOHk0Vy9CTG82WEtlK0ZjMVJ6bmNObE5hR2lHdVNFcFhGekVENGtsMjJV?=
 =?utf-8?B?U2Q5Q05sMldvZFA1d0xUNWF6NEwvTEpuM3ZRaGNJQ3JldHVDUnV1TmRvd0or?=
 =?utf-8?B?WUNvT2doaHBpOFl4b1VyZ3Npck5DNk5oU2lpSElyZWIyR1pnd2tlYjdGWHN1?=
 =?utf-8?B?V2tKMFhEa0lqSkQ3NVBqWU1icWs3dmtQalN6TER0UytjdGg2VDB2YTZ0RUJO?=
 =?utf-8?B?bUJzUHRKVlgveU9JLzRDSDVyTk1mdFViZmw3Q21UeFI0UUU4TlpoUjZxaGhm?=
 =?utf-8?B?TU5JWC9UQ2I4dUU1OGhqcXowaUpXNElUOVN6RUg3MkNlTysrL1RtMnNmczJG?=
 =?utf-8?B?SkFmWkpMTCtVcDhpRGNKWUtSdTU1dlY5ckNsQWY2Y0FSOEkrV0hpbnJEalh3?=
 =?utf-8?B?QnBSNUpUVHRqZDFoQWI1ck95ajQrTHVBcXhqNUV0amtwODkzTTBPYlBnL1ZE?=
 =?utf-8?B?Ym04d01ZYVpTTEpkOXJmNytYbzRuQkRza0pUc3pva0NiTk9zdGd6ck9iVUJQ?=
 =?utf-8?B?cjdvWWlrR1dqWHN3RUpVQ243OCtRTlNsU2tENUgrSWpEeVFRbEVzRzZSQ0x1?=
 =?utf-8?B?SUcxVFZZd1g1QnVHZjFYdHdBQUluK2tmajZwM3RDdExMVFhROG1sVE1FRU9a?=
 =?utf-8?B?UUZqNERURzBkeWZEK1hWS2lyNEkvWmhDVG4yRWhFTWwrVVMrNzJlWFVTcEgx?=
 =?utf-8?B?YmhrL1RSZnFkb29xWWlYTWl2bnk3eFErdHNqQkRJL1R1YTYvdW5hV3N4V0NL?=
 =?utf-8?B?b3JiR1hNWEttK2lBRlJyVDQyS0kzWUZUTzVuZXZYci9rekhwY0JkVE5Cdmdl?=
 =?utf-8?B?RlBIK2l4Q3lCSjVjU1FaNk55aHZ3bTZqaktlS0FJWVpUVGI3NFpRK2NSMW1T?=
 =?utf-8?B?ODA2MTl6QitKOGs4azlrRWtWWGtnd1JIelBPdWNCWjFRajhRaThtSzJPRjdE?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b283b367-754f-479e-3e79-08dab07aa1d9
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:03:17.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOIOgLzLvo3MQ87sgSssC+P+KqiiNivVL9Yz93t/dlkddLnGsjbOnV6QT/0DZcDsYuhj2FOB468rTDniHtf4I5t7Tned4/THgGZ+PL2bBws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170116
X-Proofpoint-GUID: xXIqvUjgGodZdOvBShtRxSdgmOSITwsf
X-Proofpoint-ORIG-GUID: xXIqvUjgGodZdOvBShtRxSdgmOSITwsf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catching up on old patches. Sorry this took so long. Looks good to me. 
I'll push it to mainline.

Thanks,
Shaggy

On 7/13/22 9:56PM, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> fs/jfs/super.c:748: WARNING opportunity for min().
> fs/jfs/super.c:788: WARNING opportunity for min().
> 
> min_t() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>   fs/jfs/super.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 85d4f44f2ac4..d2f82cb7db1b 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -745,8 +745,7 @@ static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
>   		len = i_size-off;
>   	toread = len;
>   	while (toread > 0) {
> -		tocopy = sb->s_blocksize - offset < toread ?
> -				sb->s_blocksize - offset : toread;
> +		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
>   
>   		tmp_bh.b_state = 0;
>   		tmp_bh.b_size = i_blocksize(inode);
> @@ -785,8 +784,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
>   
>   	inode_lock(inode);
>   	while (towrite > 0) {
> -		tocopy = sb->s_blocksize - offset < towrite ?
> -				sb->s_blocksize - offset : towrite;
> +		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
>   
>   		tmp_bh.b_state = 0;
>   		tmp_bh.b_size = i_blocksize(inode);
