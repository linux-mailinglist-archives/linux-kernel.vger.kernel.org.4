Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35719705AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjEPXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjEPXE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:04:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5008A50
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:04:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GK01E4031751;
        Tue, 16 May 2023 23:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=HCIc9fU1YvTnTPTumccsocj5qqpjoyKBRK4fUTV9qRM=;
 b=qOXoW8SgYgffsDASnOpK5uFBdMpdSVQABOSYrXPAkGGL/ao5CIY1kR7pfwHjd3zLF+or
 br+idmYE3s4Wsy/JmBDgaB7scArzSLV0Zl/NWlw21o9ZJzEAm0wQgeToA657hk/Pgd+f
 PRvi7b+EPWKjbUPeB2EeBxT2vvtZ0eVSqOI2jwv1/cRa0Umk5PVXBtISX3T/kzmab+9r
 YaPDvCPQFRC66fmMvBCRyKpxNOA3tPUDxq0waA0zby2mprgU3wn5CxqYt2QhW9te6TnG
 4sRP2INlAHAJtJlbz/IOVgP0sv3t53nrTZTjWMQjAq7J5ertM7I13R7I99E2x+5YXJCW 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb40rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 23:03:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKd2YO039975;
        Tue, 16 May 2023 23:03:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104f0w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 23:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZIJy9r56keAPUohNDfLL6okl8luLODapHyb34Nm7nc8EhPxGdCKVtZEunIjqm0pe2rNXlNKbldmK/xNUOGEgbsqjvquAtqLnfdIYzyZ0xv1NFjtvfp5o2wp8kfdifUsnJuq1NCdhCfGN0yB3fA6pGxgQbBjM4WMGbxg3GunIh5QeMFJLnlYqt08ImeijgfTyO9lcQIpm/tsjlTgWS0YBR5Qst53yJ7bIFfytiYvthKgoRYS3i2rBMoREN5WtFfKdULfZAr53/g+WOIb3OB2STWdQJylZT8nMImvmC9H87J0fd2B5VLdwkPPlCbvxf6pkQ5U6s/gUQcbDV4AERx57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCIc9fU1YvTnTPTumccsocj5qqpjoyKBRK4fUTV9qRM=;
 b=iPETtVVzNbbQhjho3yiSh4tg0PqEgUEV2b5TvG0yAKf8yl1vgNsI+PbyMvPDFXmZm4PVWS0jcWMaDm/edoUMPz27WnUuP7AbD8NVUNq8e9YJBzREjgpD/nncOjuSuK178+p9G8ZrH15DQTe10nSb6wCGW67gx9ANeGv3xxivdXzjhlVvTHQWdaJ9yNPmG8DDY51InPEqNbk6WwRyTc+5A3PyVi9mDjxYb8FbZTmObOnD7HEXMDAtGpsNFHyLe+tLFlJPX1/6uPcE8/evmc0VDMqt4RF/mvOgkuHEOp81nLg4Lv9vCt4IxfVA+Tc+i2SEZrj9uWFDzuFOSAm2SPaodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCIc9fU1YvTnTPTumccsocj5qqpjoyKBRK4fUTV9qRM=;
 b=heM51+1ck1XmA8kakoePq2B1wcCJ0VgWMEOYU8IV2+bVzl5L5x4EAUHdi5Vy7QsJrYdvPa5/p+QtncHJM+pkEj8q4WTUjeUXULDV2Ds5Iw+tx6lmK1SeznpXuQdQsSKcswJhw2oQMgUOrOuC8vKn0H9EgY2Cdx9HDdByTclvc3c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 23:03:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 23:03:34 +0000
Date:   Tue, 16 May 2023 16:03:31 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, david@redhat.com
Subject: Re: [PATCH] mm/hugetlb: remove hugetlb_page_subpool()
Message-ID: <20230516230331.GB30624@monkey>
References: <20230516225205.1429196-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516225205.1429196-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8045ec57-12d2-4991-b6f8-08db5661c62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwaO4XVpolDC5lcNQ3B6zFXOuwhAjZI338yppHzP0TLOTXIN361CbS/d8zwy9qTclw+EHFBRkr2Bsj6zAztiFKrULQ/7zs9NszacRYCBg8ZRKvYjYTOyA7CSzjOcrRIe7ChC8xv8vOJfcZsSk/spTjHzDBtu3mXtF5pnIce8KnlQP966OH9D8/AxcL1y0os2pNmN68jA9dEbK9ufTsMvkapl3D2fh4LGfHREhsNpOvx/jGMrbWaIh8/8Zw6k6kkch4SCVuY0skGyjJ8fGfq4OGBIi+Ixg2CbLmvdEZa0QL7RbPYahAB95rO10Kk+QkwQ0hw5cnah72hf4JEUH4zMG8yqyAJvGDwtGKyOnzpfBfljw5s4cb2f4meP6IZ7mQH5pGWuphhNDgMk/wzXs3ZO5GpWGYMhh4PHTP3JHK7D3ASVhtHHmdCvggNS8oXS7JoZPmb3dHH1FMf2aSHsMTNaCaNraXTPrPBGTYSjaIZMJLZhZErkqr0JtYFwqfiEpMvljW44aab+f8Feiw8PXRtfUpyU4KhJPgeuCJpDWDG8OKx41fc1Xmo12S5VdEbxN7sL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(66476007)(4326008)(6636002)(66556008)(66946007)(478600001)(6512007)(6506007)(186003)(9686003)(53546011)(38100700002)(83380400001)(33716001)(6862004)(8936002)(8676002)(6486002)(316002)(6666004)(33656002)(2906002)(86362001)(41300700001)(44832011)(5660300002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JKSqrn0k7vBK1MV1NEuA59BwDkGi6zA73FvYyZRb0TAqfYPg2koab7ylgRD?=
 =?us-ascii?Q?xDNheBASxT5tTMegHohRV8w99uxajPuE+Sgh6S+XdOk1zpxW9N13BWMaVyVH?=
 =?us-ascii?Q?Iy0IPKlSeqBuENq2zeV1fs5RkyWyUrmQaEkXdxUlPBBla4obs9rnNPL87IdX?=
 =?us-ascii?Q?I6WhpjLVv4W7Z4vvdxfs3WyWoZtGwB32Tto3Gt0Zp/ipCsMhaAB7V6vmaLpt?=
 =?us-ascii?Q?s1u8E/mON6i56sbi2kZVKEnV5plonTmV/WAwazFIj2SyEl2ieDlmptS9OI68?=
 =?us-ascii?Q?KkAdNGRQ131FFIPUxKJVxDKQNNzqSS3uJQmA4jnuBZa5lJ6NNi1/LG8ucjVM?=
 =?us-ascii?Q?EetpydOqN+6iXCVP75Fvdv+wmDEAgz5PGTQ4SfKRPdwl51kKH/d8y2+GN2b+?=
 =?us-ascii?Q?+f+OGJSaIAirNqo6ziohBCzG0+MBzDKen3x/zUGd2J1ac34E7Pbdfxqhrko3?=
 =?us-ascii?Q?0Cv1Q0+eprWGRlE8mgrzJ2nh0OQJooAxRiDZK/mQcerUAZrLPUciG32P2VnV?=
 =?us-ascii?Q?Zj3JQEw+v9XVG4U/cVTFSIHLcK94WQyNwXKmGCKkgb7JdT44QMbu98tfOoc7?=
 =?us-ascii?Q?95JjYNqC3wpQBX5aGBuY0WLptFbX+6eA8I0Je52kLhZKbVvyyzBzpliKhBqV?=
 =?us-ascii?Q?iv1CHNFwzISt22E2QkbLXxxhoKak/3vQ4avNRaFa51CqGGYQ3ll70YFODZgg?=
 =?us-ascii?Q?Y8KCWzqlLnuK0faDPt8lHR+LVhPctxwF7rLwQ4g3SBopjchUIA0jt8y9MPoP?=
 =?us-ascii?Q?46B5IqYFcxvVoRSrvs7Sx3lOCZinGtj/rRDU2pQbjR4n2x4Z7RcJmaJgdGSi?=
 =?us-ascii?Q?6ZS5WDA+PT65Z/RqCw/2dHi4sXOzEzFRw8WCnDb6Iwzq+1cb1rzsOLAloDfI?=
 =?us-ascii?Q?uxVjRtAHi6V2VlpyLdj7QV4r/GOD6x/PGcHZ1E39I9axQ8piNQle3KpUkQL5?=
 =?us-ascii?Q?vQTjTIAhdGbtenPK7aSKqIDXgidnZUNnTTMF2P4HxDkJLN/e4EViFDuPdssm?=
 =?us-ascii?Q?vKVJHZkgvUKej+MisXkkiuIRPZB2W+b1IMmRrpwPmBnoXrZkeBmjjEGmOcgc?=
 =?us-ascii?Q?pdHSqdWkPpe+BKcDe4p5JxeZT+LGPSKdW832M0zKDEOH2erq6fmxqd63Iy+1?=
 =?us-ascii?Q?laY5YkuXNs/n24hHFIrOfv78FxtSCzGmTBHkuWvy7KJFTOGlb3+ROKtGahUg?=
 =?us-ascii?Q?u56Gzk/ms9g2vRY/2XZFpen8n9vYu/kPQJ3r0LT1uX0y5jXn+Yj/vV3vsnJA?=
 =?us-ascii?Q?qPXrm/nLJwaGDQtqJA+aYmr6dVBlr6YyTHtYkYV0wr7jXu9hZKzRA+59iJmf?=
 =?us-ascii?Q?nO3GJUfdDlegOEfbXRQrseENr41oKG8LrOzGVG/jCvp+07EtoX5JdIsZin3D?=
 =?us-ascii?Q?r9D22Lt1TmyNOXqHNlUY1rSG2v2HN5PHP4Yxmf1qZsT0+Y1QHhKrmlkQXr9C?=
 =?us-ascii?Q?z/9SbdTmAmtxaTq74ConHUbCfD+bIMxY1S9wSrXK/7ruriCclKkN29z8vw5b?=
 =?us-ascii?Q?ibZi5v7MEhyQzpfHWpBrHmg9GCmI/PmohzPMTmbrMOGvkNTKYklerTpaAiFI?=
 =?us-ascii?Q?2tq389mBJZnULsIFyLHLLpD2MmTMkKodm0qErDKA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JCugB1uBjoMxnDwG+KmPGA28mDS4Y4wyRMckPmgs77sGHLEtfhSPZNg0mxDu?=
 =?us-ascii?Q?BdmipSh2ciZY74vtMObpvdWsh1cDe0CteeEPTaQmNLlgT/HrPJEjvcHtA+aZ?=
 =?us-ascii?Q?0BFqAqzJSjVVElau/uNQlGNEJB4/mk0d2ZCc7LTcZ+c2pl2wXz+Rc6VWVzGW?=
 =?us-ascii?Q?y+3JEAf9pjnTGMBxJJqqZ2Gw/8vYoojX2MNUm9C66CT5jbMK4XC51RoNUB4j?=
 =?us-ascii?Q?tJCRIj+tXVoMK5RnZe1XRXwUl7o0pNzwecRJn4HiGw3Npjbik+bVc0oAtsY2?=
 =?us-ascii?Q?6H0gcfWe3LzCjZETEMSQryiZntvT6ZsW7F3/i30JQ4A+XbUaihU1JgFjhtHc?=
 =?us-ascii?Q?+RRkDMfvoF+c31xsBHHMOZu7Roz/pwVunrrsdwOk+4XIgKmT8QmUsE3a4PNq?=
 =?us-ascii?Q?4NEqjq7LyeVUtcVlq+nQpS25uc1913Kyg7b9asAPFK7+lpPGRoaNJ2f87skD?=
 =?us-ascii?Q?YbOnxcr/XYSQNaIg64VosSP/zUfhen5gwMnXU3aP9UsIChwYMVjepuPqUh8p?=
 =?us-ascii?Q?B40tlbDnu94aOayy7FgyWqr21RD5e3HXqsO76pJwI/tvpkOSC4lx5btBaGKO?=
 =?us-ascii?Q?H8ZDfbrjjuAXlUGvBNfGWz6dLswrv59HOjUXLBOcJDckj4NFOBwRYPTnSoRy?=
 =?us-ascii?Q?lfUwnW+jlhiqdcUgCDJTPWGGpaKc16shGi6ekUg+OyH+yEwE06Sd1fqhTKNH?=
 =?us-ascii?Q?ULCV8IXZNLLmOCph1Ndk2tcrUJOQT4Vtp2gBxBVObk63cxP0mniUJdeR167K?=
 =?us-ascii?Q?Ifgow/2DDhDNUqVW8EFq/MbMdgSjF5tMUuUvyLOwXuNV1PpJFKXCo6mE/RZQ?=
 =?us-ascii?Q?dydDdSGL7qfPXsvNWYgqSgrn2bvgaHDjTaZRPfL8EWpZWuTZelL9M9sFbSYZ?=
 =?us-ascii?Q?8aHAp83ZQDwc6C/iz9Nlh5oj+C3xDi1oygwR6nlJWZ9zC1X3i8pNf3Z62Lu5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8045ec57-12d2-4991-b6f8-08db5661c62e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 23:03:34.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/K0W66yoz3h4KPBHPReWdoHD/Q9gHQmkslSbX91tD3by6DIbuhHkh4IqwNgxe2tGMgZb3s/+UOl1tdYV2Q+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160195
X-Proofpoint-GUID: CUi2_fE6yuhO6wD-bY2fIhH72AtLYY-c
X-Proofpoint-ORIG-GUID: CUi2_fE6yuhO6wD-bY2fIhH72AtLYY-c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/23 15:52, Sidhartha Kumar wrote:
> All users of hugetlb_page_subpool() have been converted to use the folio
> equivalent. This function can be safely removed.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 13 -------------
>  1 file changed, 13 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b2b698f9a2ecb..21f942025fecd 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -755,14 +755,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>  	return folio->_hugetlb_subpool;
>  }
>  
> -/*
> - * hugetlb page subpool pointer located in hpage[2].hugetlb_subpool
> - */
> -static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> -{
> -	return hugetlb_folio_subpool(page_folio(hpage));
> -}
> -
>  static inline void hugetlb_set_folio_subpool(struct folio *folio,
>  					struct hugepage_subpool *subpool)
>  {
> @@ -1029,11 +1021,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>  	return NULL;
>  }
>  
> -static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> -{
> -	return NULL;
> -}
> -
>  static inline int isolate_or_dissolve_huge_page(struct page *page,
>  						struct list_head *list)
>  {
> -- 
> 2.40.1
> 
