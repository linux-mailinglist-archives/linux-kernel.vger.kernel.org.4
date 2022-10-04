Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD725F3B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJDCfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:35:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B115A24
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:35:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2941E110007075;
        Tue, 4 Oct 2022 02:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=gqHVk7uLITm2IBBA1Av8JdPwRd2+Dj6Y/Qj23WJzRG8=;
 b=wkn8pbOlaQwsfP5mK5GqtuPwvWTDC0TaDexVIWwOm+FG5wAlf49k1dgVYO5WKXPNvn5z
 7bvflzoYcdcmUwozXfoHoj0Vg8LlBcVRaaAssEtM7yQkBBdjHHBlppDhuTatfJTXdDxu
 j0YnWoCcUrIhooVMvjqDi+ESdUF8/w1GwZHeUWUqeu7mPd+wjQBhUkJxxjxN825KNiAv
 iUK7xRjuEyhQHTG0jHdkPFUXqswPknmAzT3g4OYIjxMmLSjc6wJOiuHLjF9zbuOPoxBc
 1CGNFwtUyYctpZjhGG++1GKd9p8eRMueU8uu4AhiBg4bbrRbjr8sR0Ox0epmMV3Dhnyp YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2n8jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:35:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293N7xTv014852;
        Tue, 4 Oct 2022 02:35:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc049h71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irKF0SNxcdySnYY5SS2zFpxSqa7FqF6YLgB43HBVdzBFJbwnbR7TYguWwreJwrGKoQ+PnvDAAYzDiDsMHQhmEcNDRjudI7hGJZv8/srQostse3h1jTWfNpouAvaO4U33jmoh8HppvelHP6gN38lQ8vTLpMLHGo9ZmWdZDDwkBYrOUCI7sPzpI+1PSlpTK3d5/rE2TYPQqrqyv+fpKoUUNqq0PrDFViyMYlInkTs/cKre+VT5ZuvtqcX6cXZreXO7vG6Er9TTlu3v49kint7Lh0RaynrQ9HdK1josMZQrC+1YthkFCA4aaKnB4F0Nbu19++sG8pugL0Ptd7j05Jml6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqHVk7uLITm2IBBA1Av8JdPwRd2+Dj6Y/Qj23WJzRG8=;
 b=IUdJPCvnvhvFCMdmJntQ2QbMG6C6vULGgnnAn9TUyQT25PqlF0dG5vKrYY0ADZ76FG1i4a/l75tJnyOXqmgcD51X37DoAGo2cLdN2EL7TN6f2D6ReGGMN7g8YzETtc1NGrW/Zr44ekth53FWumdN4QKTWDOwRhyhF1i0BJfUDrS5P9WzXgH1bSGz25y4fzGwF83OIkeZZqFJgRXcrNxId4kGAn9eR+TI+mU9WGb4idnIWYwbWvLhpTAA8TGqljAVQNUucvtvLJ/lT+F9IoNflbPhLyjPzDM/NHp9JoxMNsB1DRLxkWg7eLZJTyMBsOt6Z5vA+dCzap+Bo9ApWD+V9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqHVk7uLITm2IBBA1Av8JdPwRd2+Dj6Y/Qj23WJzRG8=;
 b=D+8fTRuN64D3gM1Mos7Oxd7/bxjdTqoAHojRRb9TddLMWsy/Hy+/O7AR4IdWxLvTYJF+4d0DS7b9SGEnVmOOxbdAPnj60dVdxByJ1dOg29WDYBSQuqwBeViRQD2hmLviMCJ33vMdacrQuGhdkt73Q+GFNEWfv4wq9QACA+P/6oc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 02:35:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 02:35:08 +0000
Date:   Mon, 3 Oct 2022 19:35:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/3] mm/hugetlb: Use hugetlb_pte_stable in migration
 race check
Message-ID: <Yzub2QMyZxCLHPpA@monkey>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004003705.497782-3-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0378.namprd04.prod.outlook.com
 (2603:10b6:303:81::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4c3d7f-a756-4607-1743-08daa5b10dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYvjr1j9hHiwpPn+p+7GJsN7zIcM/LiHOasOIoQHS8b/bsya6C4a7JxgDpWN5o46ahdDOnhTwoT4UmoiiZdv/ejUo1LTiuaSg/HsbE3+dDts/sgC5vabRmBzhiErEE5x0ur5VTODouidFVf8Tw3JdfMgNcE+udfVFisejZWja1+Eq+1PbzLTaCXXiauoIMV3mUk1djGR9JrGKq7qSmHo8XYRKaxKMs0HFpIULYwoLq9cxU8DusaabjeRQaP1ZSoqTIwKUHyYXkx0MaHLwbez+bSuj4Ltjw9gMW3CE2w5ZaeDAwyE9vG+1MHsA0X0zijWBDCLoy4PvYjIGLZmB748t73IuhrLLpiZEMsjQ989jhYxFtZEbkI8yjXxFEFEwz2K/KBJCRerF/Wq9mDjUICz1E3fBhFA+pUU7DGGU38XUW0Bg+lWdcvGopE5zDlWx8LfJ/wUMX1Eu8wmN3t2KvD8P1O/XQFhHGBrcQI9zmM1QQHYyvvim74jEE+i3tn+oc9zvyZ/iVwtpK6AISwJkd97DTDo20o9+qhIG2p7QuazPwQsSVQdoN98h/bUX/khitEKHKq7Mf3fy/9++39l3xUg+zR5peO0/7JE9/WsG3qm+GgvG42i8OJ8Yc/0GzRfsAKleoGVVnX6lRcRVUNf2bx3mvztU0FauUhkUou0NVoBRP5FdYPdmTKfrEY9//OZacau8OIozcs4o/kmk8qhcIuDPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(53546011)(6486002)(478600001)(6666004)(6506007)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(54906003)(6916009)(38100700002)(186003)(6512007)(9686003)(26005)(33716001)(83380400001)(86362001)(44832011)(5660300002)(41300700001)(2906002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMT4tg5bFip8E02YlGYt3FVDv+27411MNXHMBhTa3cuEeezVA51Vs5QJgejn?=
 =?us-ascii?Q?c+UVFAH6Zy5IIUP5EPGstsVCeaTp7CN3edekO31u8eL456WsUh95AtqHfm6Q?=
 =?us-ascii?Q?4hFRifQK3x+jTp921F75c/899cL2lBzqQjsiDEyjlhfRySctPuRtyoXWKnE1?=
 =?us-ascii?Q?kGH3XOhvDHKLCtT7hBvk7SMYJy4STAgbomSbjw118sG26fgttNu7pBGNuF8W?=
 =?us-ascii?Q?OnwjpVzvBs5mJY3JRVz9aU1uRyLGeRRcvFRhAZbgSdkjiuOlbDTZUNzbHb5D?=
 =?us-ascii?Q?CIFMBAlAAJzxqMjnIO+PMEf02zk+xDUs6peRLhhL0YYd8TqjO5ixSgsUezhG?=
 =?us-ascii?Q?PA1VsWr8QVKflm6vKC+nQNYE362bX80o8sa3ujyY6thx0eyvqWOyueSupJ+2?=
 =?us-ascii?Q?0rG9tNXrxOU/UJ4qSmVwsKgymQjbhJZHE8casd2RbFfl33A4z9OXAKnciTHp?=
 =?us-ascii?Q?poDJHrHCklA1S37Tv0n+ed3jAgUo1YUgaqF9tobR/YAAbpbG4CM1f+nIvqHL?=
 =?us-ascii?Q?pkMl70HXfanXLd02G2yP/byZjrcr+DUzN/zUwDV27a3KdCzjgUCSBYYmEQYZ?=
 =?us-ascii?Q?oKoipEtOpVRbUw6K0qFTfzjQCFTICNCnkhUFKeXfHh/D+486BVpjMGnRb/zQ?=
 =?us-ascii?Q?79c+k1sEg6qLvnwPKU422BiH7xPKO87bR4G6xwkiU7RSxig3F1KRSVbTsU5u?=
 =?us-ascii?Q?WNRtnuMpfXm8M1OlFJgW8mmWKgf34kZQPEywvre7f6hVqylvie8CYqhg8+ng?=
 =?us-ascii?Q?Whib5KrXSnkwykPNT9pTCfhHj8eet3lWCZ26Fmp/Y8A+qQi84q87KzpO/wwr?=
 =?us-ascii?Q?7qY2CkzHxoHmF2TsE/mhKEobN7Sq+k2jcNGZKHjSwLHjgnz7yqhejxMn1tEw?=
 =?us-ascii?Q?NsgjN40fyLKjOGr/D0CBt4PK04q2LuNnOV5dMhcLTbPFAymantNobMAZN4sU?=
 =?us-ascii?Q?BSSovZqs1nCi2vUUyBJsPyzT3FfoLyyHXDDyZVpS70oNz1Jco7u/lx+7V3Ql?=
 =?us-ascii?Q?38xUmN1cBQbTNDVgj8qNKp9HXva+djE0RgWmDgVgd59IPs8rKhumOq2+G14m?=
 =?us-ascii?Q?OnJzhQuDYmfN7OMaFeLhIr7GEfhrMlIS/8hhH2VNaOqndaji2e8DtYUBpEPQ?=
 =?us-ascii?Q?KyXFX3NCnIdX6EiiGXAsS3QS2Dy1kXytFuzUuG70ZCV9FZlig7sQdiG+5y0K?=
 =?us-ascii?Q?ks9vyArXKar38gpn0zjzQ8DgMZXf1+KWUyi5CFnw62ldYxEDjEC2R/vYmc+6?=
 =?us-ascii?Q?Oj0frME59m4IYGVCLwaTSrJXlJqD/y8TueaQ1L48/uqgiuCTsVefwrw2NJcG?=
 =?us-ascii?Q?sIPNNiDlvAOwcpJfaipTS5teXGffCwE1+TgA+oYLsL/gLFtaTFDhlOkSygSW?=
 =?us-ascii?Q?spYeeYsxOkjhgYHp2kzz5UPjoJvnY9KcrgCSEOsx76WCwSlWmN9l3nxI6Q05?=
 =?us-ascii?Q?m/smBNJ6DU7B/TAC3lsXfQaeju4i4+Rej5nLcY6oUZAetUZAuX4G1bEbODF0?=
 =?us-ascii?Q?r1Qi7xUNXxACH21VefRkfO74TPINp/u5QzgtTb9XXHiNOtkA7WvbEkQwlzeI?=
 =?us-ascii?Q?EpJz/hB0MGGF6LGNHPd86FxknwMMu4Ot5wg7FZh3DXjBgRWlLyaeFMym+wLD?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c3d7f-a756-4607-1743-08daa5b10dc0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:35:08.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO/OoVYGVXQznIc4YaaegtsShIuLVWfFfCdv1tfDGagaRu8blSEsUc4fJC/O3QPJROj7pHcar+xzHRBiEcs3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040015
X-Proofpoint-GUID: yCunv4Ce_83Ru6p-WFKeMBkSniM7gMoM
X-Proofpoint-ORIG-GUID: yCunv4Ce_83Ru6p-WFKeMBkSniM7gMoM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 20:37, Peter Xu wrote:
> After hugetlb_pte_stable() introduced, we can also rewrite the migration
> race condition against page allocation to use the new helper too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fa3fcdb0c4b8..e762c5369a6f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5620,11 +5620,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			 * here.  Before returning error, get ptl and make
>  			 * sure there really is no pte entry.
>  			 */
> -			ptl = huge_pte_lock(h, mm, ptep);
> -			ret = 0;
> -			if (huge_pte_none(huge_ptep_get(ptep)))
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
>  				ret = vmf_error(PTR_ERR(page));
> -			spin_unlock(ptl);
> +			else
> +				ret = 0;
>  			goto out;
>  		}
>  		clear_huge_page(page, address, pages_per_huge_page(h));
> -- 
> 2.37.3
> 
