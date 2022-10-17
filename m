Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6E601B03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJQVI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJQVIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:08:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0AA792C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:08:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKd6xv021323;
        Mon, 17 Oct 2022 21:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rO3diyaSNb6O6hnlUO2fD+4bqyU4KlXOyPZ3iJ5ebzg=;
 b=KXU/X8Jp+WSoogBSWNeOKSjEIye8TedX2cmENMP4Z1jcMcGHw3kRD5pilgHK3wgoMuLQ
 i/5owD7mdWFYdcU7vzmkdKbxV4SPX+BoqeQWsJJeOh88VKmGQUn6GSItHQr/jnhKOT4G
 5d7bv+w3KCOImEC6i7O7a2Cb0uMVobVrnvdZytTt/eWX7mCrg3txHLkSmtKsul0JN9OW
 NrCLgiItNU76IzBCByKpbRTlJVSIjvbY0kAlUPGC4WH0LgVJc6YU6Kcn1eHjc989KaDf
 4G7JZbd860IwhsBMUD/LEn/QajFUeRNqYH+CQiz84YjuyznNYY4KPGiBzGlUD0muQIao mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyw02h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:08:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJh533019242;
        Mon, 17 Oct 2022 21:08:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0pq3ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 21:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz17xONYYN6MipmvECtjRgz/7pnb4LoXreenGznwxL9+S1ohap3RRMjShfchtrlUC3Miux8pNtTZyi3E+xDW00I7880BNPLZYDSxvZj4dfJdlTardGLC4ap/Dqaj7xA5V6o31Q5E0av+QnF01FK+kybnMOgyd5rm6tlTMrxxiTJDkd++g0AQJFpFJrwmXCytcVmGOkCvq+MymcDP2YMUvYFcIg2zb+sev90BJtH8cAUxYKNFX0aXn8eyv8t7uGa5xPYI5zNDVd1uV998Knlx3knogTCapba1ytl1GA+tTsQAf95rPDQV7h7H20zQHfzJmPPgEDWgVwp+3+wSOj9/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO3diyaSNb6O6hnlUO2fD+4bqyU4KlXOyPZ3iJ5ebzg=;
 b=ULaazeoS9aXj6mOdn0/Str1lmn50RVvTjmcM6DldEpmYg47HCTq4xaFQil4KJBpz5cVzJCEs6yqiRH2n2M+x/hGPNDBTjBB+a0IDcDa/FeXv7k8hU4ORWnBuxlTwXSTQmAAk5mnrTc5X57yyVhsFy78rjPp27FWRR8bklDvVyLVCsyczKCHkWh2C8SLQTOP03vUsegWAG30Qr9h2wZ5y0CAFrDSc+pjM+yKpvXoBKnGAg2/+Cl3Mt1luksEwnsJUJj7fFdIu3msRJo2H+OSYj886A+Cr6dOC1yqJHoJ+CbR/gTJzFCEjTDbDhE0mwjQp6hByJXHcWdqu4pMZLzST9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO3diyaSNb6O6hnlUO2fD+4bqyU4KlXOyPZ3iJ5ebzg=;
 b=gTctDHFryYbrzUL6kdDxWOOUvrgxk7Op/GKcU4gS0VGphKZl3p9Z7W5PxCjPTH+G4XTYrPrOEFHebv8WyHiHG8x4mh23GRw/upR9EK+NZ+BBDT/iZqWz9cwQgt/23mMCJLie/ypQpjKJlVKdqru2DDPbDPr/ugW28f0AFJDSQAU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH0PR10MB5323.namprd10.prod.outlook.com (2603:10b6:610:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 21:08:21 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 21:08:21 +0000
Message-ID: <700ae03f-12d2-8c01-2e20-8db797b4d5ef@oracle.com>
Date:   Mon, 17 Oct 2022 16:08:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] jfs: remove unused declarations for jfs
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220909065055.1154080-1-cuigaosheng1@huawei.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220909065055.1154080-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:59::18) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH0PR10MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c8dadb-36c9-4db8-af99-08dab083b89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZ8M8M2M2rhqvYrFgdXP0EgfamIdT++UeJP3unyYipGaZ1rpJh/AwYCz/fiMbiy/y8c6M6kXuzCx/0+PzPeGA4pAF8Xkw1dB6caU8r2kREZ6KHvMDj1Ztpov0Y8vZK2Eso5KhcM4oAXo6q1nYMxlwjB68G8qI1sPvWcHsiZ7Qhb4Tadl6moE2NeZqPUp7rSgEn7jch05iX27Z1ERNaOPzJmnsZjWe3qcPji9JYTwWuIKp0uxhXLPcl7B9NjNd3bj+Hdk5k8WynMrjMGQPNQBh27WEYvVyEsxiiTi5rKfQQMfvRztXCo/q92KUzaowqkZMw5IIP6tohaA8XkAR2NyyHHsScoAi8UOdjDCUDFO4mvEwc8NaxqQ2wnz2mCpVqGUd8jyx+o3QNoFliFJYM1VPBB3zi5Q599yFb0Jl65A8mj/MQkNMHfB2GovFtGCMbrD5ZnZe5rIVN5nV6eAnI8SqbfoYCFq0T8tn9RGsNGgRPZ0r6D2lPy5bsN+j/fGTSUcpmq1Mcq9kZ8HYtcWnqmqQ1lUSDpQ+aVs4K/8ns27MYOJ0eWshr4bn3PlEoG+gA7OKa5WP4CdTkerOqQcNqmODuZzlE+VFVAjWrbfEu6RISnVO4ONc7VBrNNcHlML4iCwqRW7YUVo6e9Ve9PDUfdmyrHmpnBkVNPUg7v9OeTleaoJXddR43ywut/qbjDf7a82xG956vaUtYojfiBierX9/xhuIDbk5eeQsfD3iD/RoqD4HYDSDDI5US4CaXh09cH1C0xSkWmbGAbAB3L6ii7JOSL4U8Db5HQM2sOGVTrOK7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(66476007)(66946007)(8676002)(66556008)(4326008)(6666004)(2616005)(316002)(186003)(44832011)(2906002)(86362001)(83380400001)(31696002)(41300700001)(6506007)(36756003)(5660300002)(26005)(8936002)(31686004)(478600001)(6486002)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhVQnJPY3oxTDhJMXFYY0o0a0hzdVN0YklqZVdJQUNKUW1wbWNkempCMXI2?=
 =?utf-8?B?M1NRRVpHMWREYWtjRktjd0F4S21vR2tEOWxoeXFqazJqOUMwZEZzR0Z0QUVV?=
 =?utf-8?B?dnlHeVhIblRQenY1ZURES1FxMFE0dGZwRURMUDY5NmtWSGQzVVRvRW10UGFl?=
 =?utf-8?B?U3ZlTkNuOGlRSjRHcER2WDh1S2RJaTFNZGxQVnhmT0VlaU03MXVuV1RyZUlO?=
 =?utf-8?B?RTFnbTc3Q2RnZnVIZkRGSlo3RHowSUFnOHhWc2lROWFxVWJDUDFGaG9HK2JC?=
 =?utf-8?B?SWY0MFpyaEM0akYzSXpPOFZiNVVZOEdUMmZmYTZmS2MxM3FsdWhWSmQrQk5m?=
 =?utf-8?B?L1ZZdmVHQ2V5VlIyb0pZWUR3WWZZN0VLcU1VRGFpdXJITVY2OVZlNGdtb1dC?=
 =?utf-8?B?c1l0RjJDM2liSkJ5VTBiZVFIb05HVWxyMjZ5b1RaUDdIenh5VDZ0UE1ycEpN?=
 =?utf-8?B?NytEeVA5clZqalpneDNQUXBqWFIzNDByZXpQbi9ldEhnRnBtZXArVDFjK2kx?=
 =?utf-8?B?Y3BvRDFyalJnNkVxZkNOM2pzMlh6TExZRy9yKzRPNkNRRlRsSGFOeUFGM1ZZ?=
 =?utf-8?B?OS96SysrWTBGeUpZd0FFREM0ZjdkekRFOC9CTHFDSkNVSmFmQTJJd25WakVh?=
 =?utf-8?B?NFBGZlRjektMUm8ycVJGcmVCQzZwQWRiYlF5UlRibE9tVWV1N1grUmRvVlk1?=
 =?utf-8?B?ZVlKeGpQaHlhODJMSVYvWmtvZmdEME9naUdyWGt1enloU0hBY2tNaXYxdjNF?=
 =?utf-8?B?QXExeG5ObzRFZzdJK2Q2M1hJMVdaK3M3VHViUForeG9pOGUxMHBxODRhNXpW?=
 =?utf-8?B?bndMYmkwN3FKWGVDSm1ybVhNVGhNd0Zkczh0WlEvclJlVXlIaFZ3ZUVBSzl4?=
 =?utf-8?B?VkNzNGZ3bXZCWlVuK1BaOWhlYnMvSlhKOFhCNG4wYmVLMDRJR3ZDV1MrRFl2?=
 =?utf-8?B?KzJWRnM5WTlOQnI5Q01ObUlzYTRubzA2SC9FSEZKRjVCNVlEbWJHSlhMNEl1?=
 =?utf-8?B?QVVTWVRpVVpQMnAyc0k4NnV5MDlzdXo0SjBPYVpZT0pYZExRdnIzS09xSHJa?=
 =?utf-8?B?Rlg1Sm9wSjdwTUg3YWRCY0dkcjg4TllULzZVK0V3TVJQVENTNURHV3lhK0xF?=
 =?utf-8?B?em10QWFYT2pFVGhpNzliTFZPaUZCUFhRY3F2cEdiKytoamp1UXc3TnlCRlpZ?=
 =?utf-8?B?aHJCT0FhL0JrcStVTnhJTDdwZHhBalIvRk9HVy8reCtwb2VnR1dsRzBrTUo2?=
 =?utf-8?B?VU1xTThTdDVpdmdicjQ1TlR1ZWgzaGdPMDhmUEtjRGJRRG9YQlNuUnVBQUIx?=
 =?utf-8?B?YmJGUlFJMzlWL0kwOE5EOHllRW9KcG5RT0drZ0VqSHZWQWtWMFo2VldKRVFS?=
 =?utf-8?B?MmFLaW1Hb0dHMSt3ZDdXRkt4TjhjS2lmalljelNLYjR0cnBmUnBpSWQ3WWdu?=
 =?utf-8?B?WTVhcVd3SkFpSGVNTmtzWFVOUkxCREZucEk3K3hESUQyTWd4Y1NjKzFlMjhI?=
 =?utf-8?B?UnQxMnFZeVd4TytFbnNBbXpWKzdxU1RCVUExdC9sQkM0WXgxNUZpK3RPRUZX?=
 =?utf-8?B?SG5yWjNocmQ3MzRSeE9xbEJpVXVvUEk2azQrWUt4bC8rbDRCOTFZSlhwQlhj?=
 =?utf-8?B?WVpnQUxoc3d1d3RveVlYODN5OTZGYzNXVGhpTVNOTFYyY0VpNnhOVHh6aFlS?=
 =?utf-8?B?Z2V4WnExSGRLUWh4cGYxVHZGcndmanREcGw1NnhPNS9TS2VtcU55bnZqcGVp?=
 =?utf-8?B?NDNXWHJmZWMyYmhqSEdlbElXVkZwNUNyY0dkVDdJdEwzYTUvclF3M2RVSmow?=
 =?utf-8?B?Y0xZK0l2d1lLUE5GZGg4c1ZoZzhycGhFMDZtRzBvK3pUS1hzWGl5ck1Yc1F2?=
 =?utf-8?B?ZTBmNGQxeElPM2h1TG40c3pKSk1GU2VhREdNZmQyNExmQW9mNll1RWpkYzBV?=
 =?utf-8?B?UjZ0a3MreUk2R01tZ1cvNitaSUV6alEzTVllclViY2NHckdYRVQ2WkpYRkZs?=
 =?utf-8?B?SVVzb04xNmJZdndwVGJhZGhZQXZyU2dpQnE5TzJwL2F6ZFdsVTMxdEJHN20r?=
 =?utf-8?B?dDBoTW02U1JLZUtYdDM5M1BnZGxBWUhKYWZ6TDdTN0FPZFVEMTJWSmtSRmtZ?=
 =?utf-8?B?clZZZHR2NmVPQXFWNVdQU2N3S0pyREtYUFJPVGZZbzEvOWhQRDMyektWbkRW?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c8dadb-36c9-4db8-af99-08dab083b89a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 21:08:21.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+Ofl6Pkyestsots6WRtRifa7aW2JkGvraBjP0zHil1O/3Ck0Nnv37RPgIC96VcfqJM6r1WjLhY5CRptUQWph3khdUSOhlpWcmwepmmDhlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170121
X-Proofpoint-ORIG-GUID: 675wuKcpu_GlYnKE6uf6LH28rSOrzkAE
X-Proofpoint-GUID: 675wuKcpu_GlYnKE6uf6LH28rSOrzkAE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

Thanks,
Shaggy

On 9/9/22 1:50AM, Gaosheng Cui wrote:
> extRealloc(), xtRelocate(), xtDelete() and extFill() have been
> removed since commit e471e5942c00 ("fs/jfs: Remove dead code"),
> so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   fs/jfs/jfs_extent.h | 2 --
>   fs/jfs/jfs_xtree.h  | 4 ----
>   2 files changed, 6 deletions(-)
> 
> diff --git a/fs/jfs/jfs_extent.h b/fs/jfs/jfs_extent.h
> index 1c984214e95e..a0ee4ccea66e 100644
> --- a/fs/jfs/jfs_extent.h
> +++ b/fs/jfs/jfs_extent.h
> @@ -10,9 +10,7 @@
>   	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
>   
>   extern int	extAlloc(struct inode *, s64, s64, xad_t *, bool);
> -extern int	extFill(struct inode *, xad_t *);
>   extern int	extHint(struct inode *, s64, xad_t *);
> -extern int	extRealloc(struct inode *, s64, xad_t *, bool);
>   extern int	extRecord(struct inode *, xad_t *);
>   
>   #endif	/* _H_JFS_EXTENT */
> diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
> index 142caafc73b1..ad7592191d76 100644
> --- a/fs/jfs/jfs_xtree.h
> +++ b/fs/jfs/jfs_xtree.h
> @@ -96,12 +96,8 @@ extern int xtInsert(tid_t tid, struct inode *ip,
>   extern int xtExtend(tid_t tid, struct inode *ip, s64 xoff, int xlen,
>   		    int flag);
>   extern int xtUpdate(tid_t tid, struct inode *ip, struct xad *nxad);
> -extern int xtDelete(tid_t tid, struct inode *ip, s64 xoff, int xlen,
> -		    int flag);
>   extern s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int type);
>   extern s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size);
> -extern int xtRelocate(tid_t tid, struct inode *ip,
> -		      xad_t * oxad, s64 nxaddr, int xtype);
>   extern int xtAppend(tid_t tid,
>   		    struct inode *ip, int xflag, s64 xoff, int maxblocks,
>   		    int *xlenp, s64 * xaddrp, int flag);
