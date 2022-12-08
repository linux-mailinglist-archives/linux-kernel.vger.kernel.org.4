Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19049647A42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLHXn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiLHXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:43:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68128E15
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:43:06 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIcBB028547;
        Thu, 8 Dec 2022 23:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=bp0i8t3YWgAcZD+38dbWQyGEGviuBkGV0TOK+TFm7zA=;
 b=heHi3nbMsgnkCyaSSvnEzVv/uKASlpuk9fMeVhfohh1nrGUFDSXwf+mHELcmLZF420BE
 8i9Y5P3XPc7fa9aaPOxhRQ3skGOlUSRnsMLMl5EFBuYTHFJqqNYqV4GR4PproBE5xU5N
 K3gDJZ7h9VV8nLmFLPlvnIbBJIVzy4tVbP0SvVinUOtc6qQV2nvED14K58wHo7KVSmbe
 SOys/x8L20wXuPf9JkkN64u5Jip+ZTexT9eDQ+eq2waaPqO8bX63E+AlTOk5rihr9pAl
 wGh00125ukb2GG0+r19NeeOsiznN5pvQVWH8psHm4nhDwiTLE3YHCu1MgKFkob+LRGLl ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauduv1j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 23:42:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8MNbkF019588;
        Thu, 8 Dec 2022 23:42:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8jjcya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 23:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxwfsceKjXC6ogP4gOk1HQvV8ju5qKMiBfgmF4FwKN7tCNofFkhwurauKcpFkTwe5M/0dcLWmyRgFR4ynPKA9d8q4U/cy0I5lWS16sFAHD2kbWQIZZMog8/1k3K0ebabaK/UZjwKfK4C8StaD8ioUXid/n0WYRj/TiR9udL9WD5U2hK1sKQEJw/cKEkBhGPznSzj64K7M+c37vMcjYSq2zR4n4ndwQeDu2MuQrPmvlyXUyps+HtkuxUWk/NZiwmMofjjJJ3OYlzxg0yqXvXI+RqxtlfQ6hxfyWgw4ngxD2LIPhn5BFy6WfnE/fgDhLkvEBABVLK0qw6Hn2aIA9eQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp0i8t3YWgAcZD+38dbWQyGEGviuBkGV0TOK+TFm7zA=;
 b=Y1wi1OPwFVJPGS/2Bcat29gR9GRNhZTsuvNCfAvWD1KomfSp/dlXA0pMNe1aJWAOSdf+KOxRBZzb1Elcmn7uz/jnKK+hPT8k6Qh8jk2To8O/w5xZTP4Q1FVh+y8oA2f/Tz9pZJRHbLF+j/NIakMEZs6D+a7hmRiHaCQcFqqQatv/SEsuFGtMz+VdUgRphSNwRd4Z8sghGjUgMf4Jx34+ckaKKoOC5tnXrg5J4d9km955RS8dHxt+XP2GuagSV4tI4uIt69X2WqbfPUCYuxYJNvyDYlpnpOZLXHmwjZamL33IPB8fHYLE3zDjLr87TqX9Jc5Wd3WXJT/Sir9meEldbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp0i8t3YWgAcZD+38dbWQyGEGviuBkGV0TOK+TFm7zA=;
 b=zMIfdDY3j1D+fsudAy50MxvRHkkZvaHJec+4dwEUYvmPzeYkePwW8jvtSt5bPGUSxqbwbg6yrrFBfk+UmJc6rsRb/CKnKvrXMajE3KvGj8Cmzwu3gneNHMrM5rC2cn4jJFI/m4EKv1iFLb1fqtvAt8Fw+K33qU1acKU3fi6uSsE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 23:42:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 23:42:27 +0000
Date:   Thu, 8 Dec 2022 15:42:24 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/47] hugetlb: remove mk_huge_pte; it is unused
Message-ID: <Y5J2YLW6UWtowZDM@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-3-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-3-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a05731f-2f32-4fcc-7651-08dad975dd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZDHB97kWD7XqQ75YrU+5F324tEhEkR5zsFCMJ867rOj87SoD1FjDRFU64aHzvojUKxNo1BV13J0JWpZ2eD4xVvdyixF9PMWItOLOBbWijjJOddMazO5HOQrcCA7ouZ8OeOlUzE4EER3yxAP6QHmAqVF7vKa6cy9X/p8rOhltIJ1vHJ+KESQy7tbtV1i2WAmwTW7K0kKsRAmIv8f4B8GOOIJ3ebDLZ1hNSXqKudkfV+gJ7aJPlAs/N6+s5rqIpzXTIP1h8SOW2arwsvjiHSCZNw2OiYEo/YMyH1edC/wJeSRNDCce5kocCGVJJOIvquWTk3uom4O5HO/VFUYo3BDmCEHu0rZ8N2E+CtKEaNbYc0yWTVsGCGp1f5oc0Ld3uTgZ+eoIRNyjgQH1b1Q7iFuxPKOABwK5RiwUu5AoLu7YqvtnoNy+kUw+iRhcZs3UpNJl7ThsX0+f61TfAj38XEWzYThmEQIEYCf9XJGpo09BYX3hxrlrhu3uAshE5gV2eNaGgVyuOLfJ6MMbsb3k024xOPZ60FG2qUVKN5UfX6zDYJ7h2FiNTCxOVwiogPjmomsjHj+bFQA+uwvpXaz+PL1XX5iO+khGl26HKcvIR15c2z6lxhow5hsLPmcJ5QtyOEP3qXQNxtRYiROWk8CBdLQ1x/YGnRm3yzWVDKgEJJJ8XIc+QWZLzn+Ust1UZ632PJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(478600001)(6486002)(7416002)(6506007)(9686003)(6512007)(53546011)(4744005)(66556008)(26005)(41300700001)(186003)(83380400001)(4326008)(8676002)(66476007)(44832011)(5660300002)(66946007)(8936002)(6666004)(38100700002)(2906002)(316002)(6916009)(54906003)(33716001)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s06ABgm+WqmENKB02I/NuCSoGBPxC3ef4padHFVlgJ4L15qKAFDkEHRiQgjj?=
 =?us-ascii?Q?+dcWzyQ3k7hi3WGw/KCG8OIosKWA+nrig2W0sDpvrmXV/NZ9WpivYD9SZZsf?=
 =?us-ascii?Q?kbfrvL4vQau2ph9oaSs5qyYVo4iGtTaNQ3lnmalch39vEx1y5xz6OmLwpA2r?=
 =?us-ascii?Q?ezFdCQ4hb0eXEVpLbxN+EI1oDYw9NIqTpEtfxDoIKqXi7mg/zIAzyYPzaBGv?=
 =?us-ascii?Q?vC9unvbH5yTLzzc+91z/iwC8+DhTQ046VnNnJDq1J/KKkPqyox+1Ta1r+HTg?=
 =?us-ascii?Q?OzEQQlk3eytIBuQ+WagR4itzR4CjLjU44NB5FRfxxf05FfD7zuqI3/FDexzv?=
 =?us-ascii?Q?bkrxV4mQ0bvp1QWarZDS6ChBDiowbd3eUrtxr1d9su2P5OeVYc+LMOyOWb2F?=
 =?us-ascii?Q?ndpiux19+Rt3OOwdk4L0fwEgnssLbO64+McBEXV479UNWZso6DlrRNhk6JEA?=
 =?us-ascii?Q?MBVuoNOZTRVtM7TF551Bju3/ELyTccEsQJ4QBzmZCWxJtpAknkD5cM94qKE2?=
 =?us-ascii?Q?mvnTLzN3FKAKoYuEqMG0UiVVIDQU+fCt9tzyK/G332Xqo0YxIhzoltqn+8Z6?=
 =?us-ascii?Q?5pOHM2/CZ7RCdURP3BFV1nexm+PFbHuotJ6Sn7SBp5idJ64HKf+fCV57wlOF?=
 =?us-ascii?Q?5ArvgeNr69ceEIxvdmyMusqHCWdUlJv/eTwDCObeT3QdWmcPVboL7+ovxRal?=
 =?us-ascii?Q?+x+MrdeyZQB0N+uwxaLk1Uj+bTD8owQfFtcE08xbwbRX5orChnEI0jhuwZfU?=
 =?us-ascii?Q?zCU0Wc0gumFUeRTpU+S+gG/kaB0H08bqkf7BGbfwQcR4QjE5m+ipQVwrpXFK?=
 =?us-ascii?Q?6CzQl2DyiXtkiAk0N0lD88DsyesryvXd+wVeXGPieittndoCvnZqc27NvNga?=
 =?us-ascii?Q?vl05a3C/Jva05zZl3GRrObSup/wjgD2JrfmjY/IMs/xfMuv8G7kgXI4GsrMH?=
 =?us-ascii?Q?a/DnEJ+e8AKAClNK5ht8N/qH7Xh/rsK+Qk64AEy+HWaHUT4W8s99oISLN6Sc?=
 =?us-ascii?Q?dTS9u7PTU1wpVqzWSay0BjtPdKAh89pArV7Sr6KqaFGbnR3tOJGWawHJutjb?=
 =?us-ascii?Q?KVH8a0KWy77RhNeDxG/M1KY8auPZYy+1M1TRGnjScEHI75iz2iv35O5Zwkde?=
 =?us-ascii?Q?Nw1Sp7VJ/L7fWMNJpmaoRIc6AeXGJN5X8Cd7AosCQavL5MeJQ70ov+hd3YGf?=
 =?us-ascii?Q?zv6deM9Z4X3Nx+Gftdo7oyo9h6HEGYDjK2UErRce6bi3wktQ2ZbbGFr1UoHw?=
 =?us-ascii?Q?bsrGLL/xb9k63QyROYcawkOALInuUlrQacCwqxauGbw2VLjCoisYbdoLIl05?=
 =?us-ascii?Q?rsmNvYcYzYofs0IahbRdSSVPO+eopCceWagLBeR3RtXy3ugzFRXJG+LbCdAE?=
 =?us-ascii?Q?RrWfHbxzO4HP5BckzDgVB4WkroDXOQ51NXeMje4sCldgoUBoQ+7sBsuA+wFk?=
 =?us-ascii?Q?pSFb0eXehfjUQvH0D1jWs8qdlfWODC7+HcOtQtf4toQztiXNCVsMGCVd3jfs?=
 =?us-ascii?Q?13M6SbquYSgi9JkWMRO6I+m1iwh8rYezaD8q4AtiIpPwn39uWUUlAecsXGYc?=
 =?us-ascii?Q?WvNwk/oT293um5d8MHOfIuO8Dj2wzfIfLx3zEzuJzwZQrBMrxd3qVb7WDvB9?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a05731f-2f32-4fcc-7651-08dad975dd14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 23:42:27.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URq7cKaDyeEOXRrZudtiGsjcg2c1cWqDmitHqUi2R6WPojKviGDCSYEc4B8NyDMbVs5LGdQh5H8wQM2mqTrsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=881 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080195
X-Proofpoint-ORIG-GUID: nHO8d5uJwwiuxsF1CaG7lnFyVetMWpMr
X-Proofpoint-GUID: nHO8d5uJwwiuxsF1CaG7lnFyVetMWpMr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> mk_huge_pte is unused and not necessary. pte_mkhuge is the appropriate
> function to call to create a HugeTLB PTE (see
> Documentation/mm/arch_pgtable_helpers.rst).
> 
> It is being removed now to avoid complicating the implementation of
> HugeTLB high-granularity mapping.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/s390/include/asm/hugetlb.h | 5 -----
>  include/asm-generic/hugetlb.h   | 5 -----
>  mm/debug_vm_pgtable.c           | 2 +-
>  mm/hugetlb.c                    | 7 +++----
>  4 files changed, 4 insertions(+), 15 deletions(-)

Thanks!

I suspect there is more cleanup of 'hugetlb page table helpers' that
could be done.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
