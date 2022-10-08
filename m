Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345E5F8269
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJHCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHCY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:24:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C532DAD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:24:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2981hj4K030525;
        Sat, 8 Oct 2022 02:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uqeBAiWjmUTqL2Qle75/wzuSglXcaqQQLgfPjjchQsU=;
 b=3FvkGBoLjJjAaDxQPI411vNmpcajBFZQ/Jkrtdo9Eb8DJIqEABoioLZyZJ/qUoMbkEdy
 CPy0C6cBMnc7q+OgYrX6gfGCzLHlZWrN5DJhmFaHELbugYT3k3/uURpRyhBTL7i1UCgi
 CI5CMDkdYr4bfneuHt+NpMnkb7BFb4hrFQiXzgFb0goWBuCI06OjAQmmeEvqG9f7frcb
 BIaD1kPJcXSEsqVcmkX1Ay73ZjKO/+vFMbd7pj1iImoDxo+CZjDu6sdE0boHCo7nrKyE
 S7bZEI6h1dh//3zqX9CmYQHoZX8OTyPz5DIas9VZrao/BKNuys+9ZkQpu/Nol+/IMpW/ sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1815v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 02:24:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2981XWNP022181;
        Sat, 8 Oct 2022 02:24:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn80mrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 02:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrXkDjJgjbqR0ofS96GzB1NoP1EqwSzOdZpQbBc7REktTRjYmrkeNAvNlQKGLzBFN6Fd0zDFlr4+AA1HFK+UQJajn+0kW+zOcm2Xuim4Jqu9vqDu6VzddlzZ7/jc1I/YdUNVxkimptcgPsIb8SPZZjtDSAt1X4uh4/rBnmw8SnnqGpycYRcUz0WPRjsLtng+DuvCoBnBt8xGTmTh6jxvqYyJUm9sad/v5CPV1KYFWNek5EiKICseJkLzoopXrYRt+CJcrrA1URwGS/Q9UsDTe5y4OILNYHtKrGuBYwEYz2ZPcLorCu6BzDA8GnyxVtCj+6pr+ijiCwyUOnGAG3U1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqeBAiWjmUTqL2Qle75/wzuSglXcaqQQLgfPjjchQsU=;
 b=csgKEwMPQcmVlkH0hX7PwwSmyj4PvEbEVtbHGi8UNNdFK/E6vLTZuVs9L01+h3YlQHQlYOBYe8VCz9aoGr4bfd7UP43/Lx+K77P11jwmHYyV7/Z+ro5EaMOe+kiJA5pDYPB2M0RW3LtGAQ63B0sIw95oawXcQoRUPoeZbUA5Ou3CU9WyQFFG72sz6L5URayC2tMawm4G+OExTDYeZ3LpLClQgkZml5fQDhQcmAU82m5/V0mOncULRCzK/312aNNbLlV5g+wTBcPhLYb5TIpVSqnLSqgK7KfA6HD/iTTA5KgvSEJBbE2p0Rox5Yt3fuQFzCz6ulkSUvLc/wTDrHod+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqeBAiWjmUTqL2Qle75/wzuSglXcaqQQLgfPjjchQsU=;
 b=FGv6fYZu2Sva6HWpkVxTKRcHPwUNx7CMmEPg6n+CnKXe/g3mMz6HfTxVC8kczRBWzIXLQABAGXJmMK66+edxA35sTlYQ+rviFP9blaMU1MecR/CbtdJmAi/NwvJoRPOOoscxvzIzZsdNaNHPrkvZn2gH5ycaEjLlnD0tak79E4M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5309.namprd10.prod.outlook.com (2603:10b6:5:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 8 Oct
 2022 02:24:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.040; Sat, 8 Oct 2022
 02:24:49 +0000
Date:   Fri, 7 Oct 2022 19:24:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master 12548/12775] mm/hugetlb.c:6835:6: sparse:
 sparse: symbol '__hugetlb_vma_unlock_write_put' was not declared. Should it
 be static?
Message-ID: <Y0DfbjPdpdECTHUT@monkey>
References: <202210080448.1cB176kW-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210080448.1cB176kW-lkp@intel.com>
X-ClientProxiedBy: SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d0f41b-352a-4f82-7184-08daa8d4467d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BMVG1FuVbBamYK9MEdvcYAup0AcAWePTuKCtiZPYRW5dJfFBsj5AWpslP6blnliwZgQ7wQ/MtYafZvYjp6vsOt1QLtzKejxvpQxcZ8G+5d2kheCNYsdQr3ieU98f9vUa+tr9rBrzxPs12r077WGflKmZagIvX39CTCqEbt/O7IZC1H7urjW6tOEKdcj9NB2kdt1cQqlniBpTAqeYYSdg6zHuGX9hzlEvQx+Ng5oPJbyhOt6SQvBVVdyYZS2Ys0JElZEt0akqENQCsblifEJH2m+oHr8iJr/96a9zIZ+rxwIMMIFEY06haVPkW0/HRbTcA/fEm3g0E+/iZcWzPbuW+PRLuIeSiaKPqNP8p9vWtiycaaIwyF7gHAUHZtyFp9R5OtGEJIlDTAKRvnPAMW14OpimixcVMMLekAMDoLjiPrRMLOFx91aeK9FngMIHHjqNsf/IhHVGwZVraewKj5E/ktHJQzPTJIksfabMLvWbrujc63vlO+8OvzruoHoPDEdyVp6izVlIXx+eGtpXHHELyYxOic2gXSkeZcfQczQtemoYhhvfRelC0699eurViVaxBdsKVagTf+q2hkRGHdAhnT3cI06meiU+0Ayew+BYTAhSQaxkkKs6+x3WvYYmn75rQkupBF2eJIg/mu70zL53VU5n5BNn6sCdVJL9sHNxU7bP0+WF1UsYwAktpzyVIxTNkV+WuOJtNM+wWMrr4Bef/QqRNl4Ma7m9+/Ckgo7hPIRGu7qLrvMfWA+jAJ3Asz+qdWnwwnKy1wuR1MZLJrAVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(6506007)(53546011)(6666004)(38100700002)(478600001)(6486002)(966005)(2906002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(86362001)(41300700001)(8936002)(33716001)(316002)(54906003)(110136005)(44832011)(186003)(83380400001)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duWz0I1SJPez5t1baG/myRhNrPorl2yGZacP7N5C8E7bv0LqgVSMWgL8XJ/j?=
 =?us-ascii?Q?TCHRXdgMXZ11c6vCxHYfwVGymgoHYuG91CyhHcqwx7FSQEJCI8c5NjjKUr81?=
 =?us-ascii?Q?33snO+l4nkxjNE0CLNCfqKG7QiR2MSMBst7zzbesn25darmrF5PokebMBKJA?=
 =?us-ascii?Q?rX+MPBGq/3yWqMR0xwTLC4MMkUGMyR8Bb7eAV9hOCXHoN31NTbbtYuZ4SyC/?=
 =?us-ascii?Q?M612OGRO/svUapTyjMGVHuvj5KY/i8Zf8189EUFNJ1pylzZI66B0HBywpxnA?=
 =?us-ascii?Q?Sfk66DozxJHvrCGg3HRCAYjKfc7+HoAVL6xfwiceZGgvEmSCsbSgWyY33FmL?=
 =?us-ascii?Q?JaCfiAmJxKWzLr9ZOpgTauYkFa8/fWe2aclEMeGcPNgLJA6N78VchnR6KB/r?=
 =?us-ascii?Q?8WxF1wABvm5KxZJI43J2D+2ufPj5KHSkJDT3xy/PGKb6DAOeBNcsG2a9TU+N?=
 =?us-ascii?Q?scogc/EOl07WYvz6y2Gj5kK8co0W02Olmd21BDOXtsoKwwP+jirYT+EcW4Ve?=
 =?us-ascii?Q?DFnKuSt74rUQmCdqwdkFFitbD4Osf0zFVWY+XCy877/W+1TFi/0/p+fYgLHO?=
 =?us-ascii?Q?ZPauZjSS9uJjtngaG5NVX+Dfx01vvGnkNeaGAqvFE5meIkQkQLGkfhryaljU?=
 =?us-ascii?Q?TPpVGOZa8xnEEVWzWW2Iu+Q3pV1AiWuh50R6Qrai/RbJkqQwuF1NcTxFeMwA?=
 =?us-ascii?Q?4njDU9u83q9yBYXf/gRGdz5R8U9mZqtDrl7ZhS/22uQgOu6KrOqsWJTjPIYd?=
 =?us-ascii?Q?FJF/T7mJSq9a6l83DqW1+RZTRvvTN7xqy/yMIx0NEAGM+8TILGJOmCTkY11p?=
 =?us-ascii?Q?Z8gja8w98vVIf0WKQzQdfuw9zQPgSlCOyPPBa1A/7xO+rTnZ8z/U+OUMWfgK?=
 =?us-ascii?Q?gzW3OzCcvh6m3OP2DukXMmIjnK+I78NCUvWxMghEV/iCMAWEt56TRNKX1j3C?=
 =?us-ascii?Q?HXuPWPuLGYACGA7yDjcAVW2MpL1nXSZFMaHJuy7KMUaaDCctPS/rdOKsFx2b?=
 =?us-ascii?Q?ro6OA3UxOkDVz0YF/QHeWX2NVjGshDu9qOKiVp3flDe0vZh8sE0KgBW6muBd?=
 =?us-ascii?Q?WaFE4qRaprgFcpVrCwDkfp8C+0xcT9uTfA/QIHBLYS1yiH/9798csQcuhnT5?=
 =?us-ascii?Q?/4SuH2bZDUMOuYHBNtZyo/0VHS33IEBzhpdTfOSUu0lqBdCJhFL1wDcTeZBr?=
 =?us-ascii?Q?ZA2hEXxChDCQGXfPtB1JxeWEOpg1BAnktwdgSK3brZyb0Hi0PhXMCL33tAVu?=
 =?us-ascii?Q?HDQ7DrO6HRutY+AFHGr4dXkIFoNIyGzSNAp9JMoBaGVNSClTXSDgi7BBE5Ty?=
 =?us-ascii?Q?E/WqpLYhysy2wEAj7D+itHPxyDIrvB8Ud7L+hwYk7OL/PoKD7qUPfN9PTPXe?=
 =?us-ascii?Q?1CLj0clDNl8O/BbHn5XTpbkwFp+hKXRpuJVzm6zfgWwLKGYSoEQRQxUST8dJ?=
 =?us-ascii?Q?slnL4mauTkjI1akgKxqV4EDKo0z5e4dBlp3wMDeTVpAPHoBJ7jPuT/mjKf1S?=
 =?us-ascii?Q?WxCZlWCLbI/jXEKp0uyw5RU0GsGXVHASZI2JlUfrqTARNWH3uW8iwk6dZ3fT?=
 =?us-ascii?Q?hWlBN1qbisme6DZSs6ZAkbkYIvcRCcajNxBxTt8W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0f41b-352a-4f82-7184-08daa8d4467d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 02:24:49.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLx65CVWBhzSrkhpXuNrxdpj5N3jI9kI5E39EmiJDK8Of3280E1aKbEZVLhHvz7CLkXAUlZ1OnZK+X9kPL8+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080013
X-Proofpoint-GUID: FW51MDaspY8B2REH6RFQMIDr2FYz-e8W
X-Proofpoint-ORIG-GUID: FW51MDaspY8B2REH6RFQMIDr2FYz-e8W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/22 05:00, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   082fce125e57cff60687181c97f3a8ee620c38f5
> commit: 95b61bfed8291e54f65e1fc836c5f9b49f74068c [12548/12775] hugetlb: take hugetlb vma_lock when clearing vma_lock->vma pointer
> config: x86_64-randconfig-s022
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=95b61bfed8291e54f65e1fc836c5f9b49f74068c
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 95b61bfed8291e54f65e1fc836c5f9b49f74068c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
> >> mm/hugetlb.c:6835:6: sparse: sparse: symbol '__hugetlb_vma_unlock_write_put' was not declared. Should it be static?
>    mm/hugetlb.c:459:12: sparse: sparse: context imbalance in 'allocate_file_region_entries' - wrong count at exit
>    mm/hugetlb.c:530:13: sparse: sparse: context imbalance in 'region_add' - wrong count at exit
>    mm/hugetlb.c:597:13: sparse: sparse: context imbalance in 'region_chg' - wrong count at exit
>    mm/hugetlb.c: note: in included file:
>    include/linux/mm.h:1282:17: sparse: sparse: context imbalance in 'demote_free_huge_page' - unexpected unlock
>    mm/hugetlb.c:4969:20: sparse: sparse: context imbalance in 'move_huge_pte' - different lock contexts for basic block
>    mm/hugetlb.c:5340:17: sparse: sparse: context imbalance in 'hugetlb_wp' - unexpected unlock
>    mm/hugetlb.c:6221:25: sparse: sparse: context imbalance in 'follow_hugetlb_page' - different lock contexts for basic block

Apologies for missing this in the previous fix!

From cabb47237ecc48fceba767eee90f9b311876b329 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 7 Oct 2022 19:15:08 -0700
Subject: [PATCH] hugetlb: fix sparse warning for
 __hugetlb_vma_unlock_write_put

Declare __hugetlb_vma_unlock_write_put as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac10d7d1a3ab..7cbe4f7c9baf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6832,7 +6832,7 @@ void hugetlb_vma_lock_release(struct kref *kref)
 	kfree(vma_lock);
 }
 
-void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
+static void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
 {
 	struct vm_area_struct *vma = vma_lock->vma;
 
-- 
2.37.3

