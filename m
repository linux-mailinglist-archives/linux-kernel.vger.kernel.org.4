Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96AD613BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiJaQu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJaQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:50:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DCA46D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:50:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VEu0uC023908;
        Mon, 31 Oct 2022 16:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=obgwU0jx6OwN1ARkUxsvjm/rLBBAMlGzy8TQl57qDHI=;
 b=2oIVFMr7TQXVjhhrJhYIakvfsawJ1grdn4/YHo8LT03AM6++/xuu11GDBXi8dNzuRduh
 ZAGYUe9NdWW5UAzm/I62f1pu3X8kJKStagpRuxFt1bytj2jAx6p5j8ebNbQLIfgR2Gda
 hQSjwOLl0x8p3KkF5bsUfwONG2IOHh5r66U9+vbGVuZMorgp7UUc2QopY0RrNrfARCy4
 JUjscxFvPyiZ8hABMcIiQ55i6FRhVy7BTxDhBPra1UK5jQDx4OBxRqAKzvy26/QKGg18
 wCBxSFHNSccLLYOwgBNcRxplv0XlgTyafP92HizPUQM2ZefORHM5n5rVUqrKqLGNmaNZ aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2vcb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:50:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFIvnU039596;
        Mon, 31 Oct 2022 16:50:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9hm9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 16:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyC1TvRghxhSAnm0asWYLVeWtTwGBBAe0cmeHklEgJXBXgtLGdh0Cj1jIqipVZqR9KdKj0AbzpxFUeEKl7yBoAEBn4kLxhWnDbas/6OPzckBL90+8mtYT36OeHKG2PGxkxz4GeE6RLlo7oqfBsYlTzq4h0Ue365ddLOXjfSLTBOMciNJdzl04uOaX2d0iKJcX/n4EEqvopjiecPPpZjjEpK70XINeGPZEWKFKZyDqq/HDmj0IXj1EoTlY0x7XVMsuDKMVZze0FX96cbPSNKkV0DI+NuxxmHDyQBVhTS+xR9QGAlQSYQJ0PIe/plSTt9XoybCwD61RT7dQx0//jN0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obgwU0jx6OwN1ARkUxsvjm/rLBBAMlGzy8TQl57qDHI=;
 b=TwGm4tIhNvwcBleraW6U3QtZBJ1vJs6/wdz+DqC2LgMxP4xbyUrt72GnneYLcC4yXN33vgfZl7Sje1VX6ydBzc8tZjgI5jltGKoSzs3c51VC5odW6Fh3mMjXv7PGFCXHPaFCXgLKKM4n+PX1m6kKyfe+uNd1mjNS7Xb3sbfyvJS/YVrf3lahiiCilLON241HQ/hcPW7w+69PJ6HkdEtsZuGVVd1gbj8+xBDPxYFjLuxEYrnLzrsCMCG6YZaxAZFi83zGA3IPLaLq3i53VwTPza8fF6pIgmmETLqE2BT2gdpLjXSXaRawgJTW5MVpUnmfgxxh5x3tw/uIOOEllgXUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obgwU0jx6OwN1ARkUxsvjm/rLBBAMlGzy8TQl57qDHI=;
 b=LAf4bhcNymdR2FkKWajO8kf24rpmz8Uwld2oZnIcuLknuXtw9hgZQ50w8iiMndO4Irxvg4S85yH2zy0piEqYO60MGzzXfKMeSBw1Eh6Mt7Q6PAk284TN8LKiN8cdxh9nRhgqwGdA2gf3qTJDH3GhJObAvQ0BCYI/u880Gr+AAa0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5625.namprd10.prod.outlook.com (2603:10b6:510:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:50:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 16:50:36 +0000
Date:   Mon, 31 Oct 2022 09:50:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 4/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to
 folios
Message-ID: <Y1/81iL2n5vfwPcS@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-5-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 519da050-6c6f-4122-c0c0-08dabb6008b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gB36ThdSbc/WRdD5/nvQnDc8C79s9R36BNedwf7Rquz/E6QHcL985CIYyHwnyDUnI2kS2LJ9HInvhNmFwqpDi9U3V3ksLz8g7UExfkmw0wq/953xIsNetSp6PjscL0maUy/UZeIDyK5EQokjkFjuqWrvQcNIv0gPBldhgHVm1Xhhp6vOW0lC4RvVKKDgJvu4KIy5TEvto1hNKx2cOdIdPyyOgwUuzgBRItQ2de1xjgDxrJQnwiK6FztTj9Vw8riMp/nCJudISIH16newMdAe2+H0lT5FUxDnCmpEI80hGFXnj8ln1fR2Vbq8nt6gXk4LBJU4T4TJ1m+ftOH3TT9yvrVIVuSc4hGcqoBjmzn80JthNJpIiL7PqWhkcpYsF237kUdbPRvoKDNjZAbDILbznMu7QtjZmHV6ipZ7DpYxEVFWU2do4mWVJYSK0G0SpQX3HAM9ws4Cz9XymsoxpduWwCsLCyyAol+fMx+bGCskYT3992G9leBzRVUrPr6cRge0JP7fAgQcuqEV6qdfdptZJYmh2NR00hbAU32fL2EnjXGKKhhwhh3xLJ5opIxx/JMvPZrRc93WBz6Aq7Av345yJxAKKV5MB76AWp0vImzLONnQ49xQ0+mxEvHB8Sft4700Yzz/6FEiGYt+vrFgfICQ6erGEllIaOVNhdRpI1yFp7cW9H162rbqPK7wj4aZ/z7TrudfNQWi5h0E4B+r7KBgEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(86362001)(38100700002)(33716001)(2906002)(6486002)(44832011)(4744005)(6666004)(4326008)(316002)(8676002)(66556008)(66946007)(6636002)(5660300002)(6862004)(478600001)(6506007)(8936002)(66476007)(41300700001)(186003)(53546011)(6512007)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Som/aDjXNWafbnTOtEMMH+W2oMR46FduB4fpCYHE4jvds9ihDdiroLCpfOt7?=
 =?us-ascii?Q?wPCIG90p5MG5qiP8dZCjIBPO6DgcQrahEUEAjhyhSfrDbp7StRFZKp1J7feP?=
 =?us-ascii?Q?d7O9bY5HpUU7IaF7b4c5D5T8y9ZoPhuHNrbFsoc223Onk/SJNSiLBZq2iUXq?=
 =?us-ascii?Q?lv+sSLYlEnKDI1IqesFofdtWe5q4bmE0trhorYpQrCR8xfGyGiBNEDQSnZaU?=
 =?us-ascii?Q?4hneTvZ3N9L6Tz4xJn2ly75REkJrLt3y6lKPApkrlREusP/mxZOJ4st8vBji?=
 =?us-ascii?Q?P99Z2nv9S0sciMp1C4WjTf/nqjUljzJBKeeHNe+R4Rsc4EAmC8nualPjEu3h?=
 =?us-ascii?Q?Q2VfinIqPgE5S7GLn+M1b/bZTwe5D9fYXGIa65ksHdx/2lP1F1zTsZbBXWlc?=
 =?us-ascii?Q?mIClLFR6mFR44bvG9rNYgHe8ARpgHskI8ALrSrbOQpfnVwIXtg6/UcTXzs/a?=
 =?us-ascii?Q?GWjgFXdqU3pS3ki0tEKcBD1UJ83atfdt1qnlff1Df1zdu7Of0LndU3dVb8Ag?=
 =?us-ascii?Q?m+dAH2wElKdJl+FOTwrWH/tqqfQZcDQUbNHkmibDwumN5NdNqJ8UKvQhME30?=
 =?us-ascii?Q?J9bwJdUR0H+uJRnnPOVEpYKh07H69QNeMd5RxcuIxvyigA0TdMXkZREddAv9?=
 =?us-ascii?Q?+6bKilgFkK78PnWonsEjzhbVnM3vGXE62BqNbsEujl8SICDpH0HsDAeWJKP4?=
 =?us-ascii?Q?16ylP6M+VG+qPGXT4dns2WTUsFB5pH175TfAvhH8UxbnoMPiG/DHevh5Rcqf?=
 =?us-ascii?Q?hKzmQRx3q4PqjvrPMvgksJ1pEa6fRJNO4GWi/El79Z8ZHyA/8wtqDO2+0+h3?=
 =?us-ascii?Q?z4Sk3Zd1wsse9/i4Xnlx26+CuoRdJuOtic6+ikmnkuAfduoE82H/W0+iLV+G?=
 =?us-ascii?Q?xHV2PINgXqVEXlsey9GDQr2KmpcfPz2B0fOOQVYQyAekeKaahBqJTjlsvv4B?=
 =?us-ascii?Q?yLhJkLLGMRtpC0bc6X4e6Mt3Cm+W0PDON6LRQQPu7AikE24aLiY/QDC+nsmu?=
 =?us-ascii?Q?nd/oKN4rygie51N75xRYDB/bQZPn0/djxGzvDYk6mNpQfRlHMEut1NDO1VKM?=
 =?us-ascii?Q?ADrScZjStHymq00XrLnhoTS5mGL13h9BRR4EMjUJStU4kl62Xv5LHRnPySeT?=
 =?us-ascii?Q?i33bEXYaSK+xdyvdo7A6TvMzazJgnkXVkbJYxVuZ32vONEHykK9Qdo+FQP/a?=
 =?us-ascii?Q?3h9fqr7CFvz+M1xaRCd2PxTivgbPAGKEeifo7QaIpttO5vMNMefkcgKdZzVO?=
 =?us-ascii?Q?0XYZxzmvypNU0qEE6rlf0wNAJ/eelJPPAPE+tm5UvuTRvp6BZD1cweEY6lzg?=
 =?us-ascii?Q?HQ3n5OhrTeQwIzM4tvwOv+P2qg3+lPhFNN/6c8amq12qumlqTw1G171YsWyk?=
 =?us-ascii?Q?xDWbCO+Cj36KKpwt82XisMmTjLTfcQ/Hr9urGnsMvy6av0CeJIwMYqxvH3ok?=
 =?us-ascii?Q?dIFV24R0WaIhnAfF6A/4RDgp4rSGGwPeev8ANP2Z2J453yd2QC8QJB/g1rPp?=
 =?us-ascii?Q?F1HF5iH84VjkgktB38xgbZh2tXngOlK0P8y6V9NtX+G8fLYKMCvs1PH3TNAJ?=
 =?us-ascii?Q?pZT3FgJhGSTsZU7Chcf1z0hnmRP6vvTMIDqcuiNum9xBMA4e+RiPpFi3R8o9?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519da050-6c6f-4122-c0c0-08dabb6008b8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:50:36.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd1ESHGyB9w3aeFfH5OLDwbWpq4U+BxrSX5kYKUjc+HmhtobTeuje2J0aDHui63jIl08juvfYGX2JjkW/FRRXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310105
X-Proofpoint-ORIG-GUID: eS_LvnYyjIhF7rapYAwXObYsM6dy3Hda
X-Proofpoint-GUID: eS_LvnYyjIhF7rapYAwXObYsM6dy3Hda
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:12, Sidhartha Kumar wrote:
> Cleans up intermediate page to folio conversion code in
> hugetlb_cgroup_migrate() by changing its arguments from pages to folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h | 8 ++++----
>  mm/hugetlb.c                   | 2 +-
>  mm/hugetlb_cgroup.c            | 8 +++-----
>  3 files changed, 8 insertions(+), 10 deletions(-)

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
