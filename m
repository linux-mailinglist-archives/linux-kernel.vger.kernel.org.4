Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEC5BD739
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISWYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiISWYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:24:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2864EA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:24:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMOEZ6015093;
        Mon, 19 Sep 2022 22:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=9vbjMFtW/jhQy+Jc5bt+g1VX2utDlOrI0b7150JvRME=;
 b=TX5hV/ZsOm3FcflR57HgONS0OX/UHPbHvErkq2Vh+o0UgyMuqeHErQACsv1+GkaV4LSz
 ajX2uZWilc6ZsTFdI6sQzp8yBd6/knMM/4kXPHtCfJ7f3m7SowabMHqltocz0aqV3lCx
 A8KSZX4bus/UPzA8c6gnnUWOpxZ9vIm4tSd+moJuTuY9u7GpTSysvI11DTX7BA+GJi5s
 TIPXY2bnzQ92LrLqHl9oRdecZRmcHPhGNwexFL7zH6Kv7MFGFRXnPsK/4SW6NUbeY4jo
 qfIQw/UdudGABaS67mvhhPS+CR/FpNe+tI0/2w/Gd/TLxgoewtNqOWxqR8J306YB6NzJ /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m55px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:24:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JJRmSN016552;
        Mon, 19 Sep 2022 22:24:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cmktw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hweNoIM+3UIGf1aT09c74JORgvjSdIa9DISt2zv7iutx3A3blmYATz1/iI3LvM+Q8+UIB1Dw2ZF79CWTKXWT6m7d5qVjQi21AsIf7Evut0ABSxS1VHB5mRssNTg9WQtM9RHppWYP3JzPFMt8NOLuGnoW0BY81a+QOVOzVPVBZBXYiedldBkVpdBxagstlOu3nd8vaZ8EGW/T8OmdOxDBrJez5fTJotUdrm8aBLE5rlOaMhsX3psw7hIPOYAQXHqLtGRhtJGjkF601g+X5ZMFOT2R7rX2wJCiEnessKx8Y6MNZawcLuTMiS9QH3bMKAOvcg/cy78rfopZI34oH41AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vbjMFtW/jhQy+Jc5bt+g1VX2utDlOrI0b7150JvRME=;
 b=CUEX/d6zKusfCTPpJZnyxvif6dEwlBhgqxIt+PxiR/RBeavucROyUtJ8Ha26tScEAq2CiYvEo3xnkCUpG9nNlrMPLtLxV8ROp5LrK8NKeEMYEgKslmiRbwhZX73+G2Du8nyFYXs3EuZPztabkLVuCtUypG5WrzIsVRJJv0b1eZNrP/I3wstC0pa82r5H+9/xEaePRegFiUZyrhQJriypXNLaRU1cgwRdP7KlWUrOTOyd5ZDZMzymHeLgY4rGLFM7OZsVdunq5ynsubPzo3MMcsJbTQRg0915L1LVKMe7+mcF3nVLSuJwYEFTOOtzIHeBktZSR2CSK79pwNWY1e8BnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vbjMFtW/jhQy+Jc5bt+g1VX2utDlOrI0b7150JvRME=;
 b=Y26jMbExUSw3kEw+sGoelaA3oYj/KNodUPW1Imy2mtSZfIRhK5PnQPWMm+1vfIHkpvkjsGGZ6oVHrQVQK1THWOUN8FFIFvy5u2Jv/Pq/ZehhoWbonCHAyMKUDbsa7zapeEEjTWbp0LSEo96ykceltO3sdzemVL9UN3JGikFD7eU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 22:24:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:24:22 +0000
Date:   Mon, 19 Sep 2022 15:24:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v3 3/6] mm/hugetlb: add hugetlb_folio_subpool() helper
Message-ID: <YyjsExTN45XUn4TE@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-4-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-4-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3229e1-f950-4612-bcb8-08da9a8db3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifLbgYScd7G2/ujpsT6qpdT3wP3xylfdNVXVURXutFCw6ZPpGaYrPfA17fN9GRTr+P58ZLsTQDGu+fgWejrovbCMoPVA9GFAe6gI2tH1ZVQHFf9vS+sMW3pZa192PHh0zyVLRzNm4PK+h9CFwCBlhFoVxEavH5pMJjiMTtusRg9A1oO2HjnEyyanNVQonmb+ylJRUN9DJuTHU26MFtlNzPdo66iRlU/n9gHw2LMdt2ALVJqW8P4tE8Kd8knTUH8LJlbSJahq7s/RaA/Lp/+/028fvHq788jewdVM2Y/tD7s9UVSasTxNvv0sg1BH77XWKih3WtsQy0a4QAsK9bH2gfCHVyS5RZbsBXMVHXgKedb+pKfqSr8a/in66cygMU5U5r/9d5YmQGlc+L1zlI8tTRl3koiHWjyNDvkymWOGFs1wK2opYuBP990ba/jScJsPkftSrBbDYMGADNRj8Bnch5j/CHv65ViIVzaKmIWdi8I0gXFOnKWXulMp25/cd1KcwOhoEE8Vx3P6sjvm+gv0LzcKeRCqsxEMCscivIwUOAlt2JpYMaA1wV8wV5O5hhXbZLGXl7NiV1DJk79gZMnlGxEqmhCEX/g2chW+U4Oszr4VbqTDq/Pnl4Q/ce+//DFUw7WzJci8jbqYaQfQBZBmM7VeFq3JFj/FnYIMNTXVdRk1V4O758k+CbYBZlp4mhNgPdIhhfVQKuTSOiNQVdCQBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(7416002)(8936002)(6862004)(5660300002)(6636002)(316002)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(38100700002)(6666004)(83380400001)(41300700001)(53546011)(6486002)(6506007)(478600001)(186003)(6512007)(9686003)(26005)(66899012)(33716001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B93DaDUn7kBUsrRko74fbgw5ma5uPp40uYUObCkwKo2cPxe1n5VNg72LvIyD?=
 =?us-ascii?Q?VFA4bz5TTipHuFIgSdMQY32bUPQ4Z2iGsT1OzlwVLuQ5v3EK9KOHkhtwwwZZ?=
 =?us-ascii?Q?A4/9Zq7TD0yjaSLQOkq48xD4bVViKXpqKAf8RFbbY1pBA3Vo6UBNaX0YAVkx?=
 =?us-ascii?Q?/N/Y86xd2F46b2yr70dqroX3IX4rrcl/t+VrXWi3W6jmQzPHdrIAcUjwN05q?=
 =?us-ascii?Q?nuxq2ZoLe2P8JeoHMRbdFB0q4DTP0o63i/bt6ZIAFnPuXAi0Hd+La+E37Cen?=
 =?us-ascii?Q?hivC0sl5upPoEjPe4Bj7YXdZqNk7p72bBn81QW960uXKmydOO02V9t6IHTtC?=
 =?us-ascii?Q?AD6IJdzNb/L6f8oGbkrzEUVYN/VjWLP1NdIwW2mtM/JIWBFs7ESAo+VOfjSW?=
 =?us-ascii?Q?9G+oiZzUqQ/bwu0+iIE+qOF6uMePIaIen0aBtmYly52VhOvy4STb/FvzCf+c?=
 =?us-ascii?Q?EoABHioOOR7ysaU9ROhLEkiThXtrBVsKrSl//ZaG1i0XtCjJjV4PXltDSClF?=
 =?us-ascii?Q?g5VvF3o5c6tObOo5LNteasUVu7l00ME89ayCiS3jU/jMuCddCB8uqWRvEjhF?=
 =?us-ascii?Q?2DF5PMKoCtNsc8fK3CvZGCL0vg1CotqbnWH5xH9qIaEPAV9yNr6duEa2xFSm?=
 =?us-ascii?Q?27VCkEljzLA8hiFu8Fjr85HtdRKXtaV8hzCHzocCu6PiJ9g4o6PoZs7GG8HT?=
 =?us-ascii?Q?QXgvHPT0CD2nnm8VofNRoY5isIO7+qMLpe+kgBWfXA6NRXferh5bXVSMj+G4?=
 =?us-ascii?Q?h8GPYNKi18cC/3QlS8az7exLoAqvn2TLpW4VY/uu1ibj0fHcKDrOJ0gcoynp?=
 =?us-ascii?Q?mkefk7Xb0/Cx6X7HLiAoQAc0dXbq653A23WX+b/+YeXojmiUX4CXK+IJ8MwC?=
 =?us-ascii?Q?ewJvzAUJHNGN4DwnhcNfBDaX9Wo3JrGVbDuOVJVpWVxF/CFuAxLYvunjwy5M?=
 =?us-ascii?Q?hHKhTEloB+KVrF+ICbL1KOdAwETHOeRTGX36etVI+o5IY3kgUuMolg6VIA9D?=
 =?us-ascii?Q?zlQ6kzPNI1KW+JnSPPOOL+b5TQ06YlVGDrOgW3E3ozos5eL8Pe0Kl9dfah/3?=
 =?us-ascii?Q?csgzhLZXojXZCt2bIjAB0eTrb/9Ignl3DNXV9ipX0JHvZahvDND7aBHZONNq?=
 =?us-ascii?Q?bUqvW9UBgAkk/avUgE3uxwBZYG7sx2n6U8QmsrPkQlxCYx9q96nyH0pKeDOz?=
 =?us-ascii?Q?g/xCf6LUP7bDJPgkV1I7gkWfs9mYD9LFP+cVNqxjQxs3tVNj+cjk7KITMusD?=
 =?us-ascii?Q?AMc/vIj09C8xNsEy8y05DQhKwRxu/6EiAFMvBw0Q0fGKFvoG9o5+7YRxrdEo?=
 =?us-ascii?Q?k2UR4X5rWW9+gIXW+HhQLoR5O0L6lB/OkX2R/FXhvJ9maRaF8WS/zbDXDcok?=
 =?us-ascii?Q?q7X7AHmMXKG17mn72Mtv5rEi7yQb3Lzz6h19+uq1I9IrPOOVVn67tSoB+g7V?=
 =?us-ascii?Q?kxffui+ya1aZ9DK6tgsZMkuY8OVqVoTRUWoyx8wPt9E3Ftwpm+fyrWby0L1l?=
 =?us-ascii?Q?ekFphzoKsVwNxgScoZUKGe4iCNeaSpZU1DPODITksHIFUFgrexz9vP2e+Txx?=
 =?us-ascii?Q?qJ65XkSNFZ/O8IognJNrseNeeOWviHiNCiaJsxG5OAKqqfs/wkzHUWVHu9Jb?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3229e1-f950-4612-bcb8-08da9a8db3a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:24:22.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upbyPLgQiAVtoFIzsdfWRPcOaupyc50Zqqx5fkEE/aFs7cZ7lbTwKVnvf7bfoqULHIXPxALPjWM2A7ZiHeWs5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190149
X-Proofpoint-ORIG-GUID: rhFqLNtgtrxQRa38WR1w9o0-GfCPsW8l
X-Proofpoint-GUID: rhFqLNtgtrxQRa38WR1w9o0-GfCPsW8l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 12:37, Sidhartha Kumar wrote:
> Allows hugetlbfs_migrate_folio to check subpool information by passing
> in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> (cherry picked from commit cd9e187858b45b890097cfcd0b2eb4bbbb9a59ae)

??? I think this must have been included by mistake.

> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 4 ++--
>  include/linux/hugetlb.h | 7 ++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)

I think this and the following patch are simple enough to combine.  They
both are dealing with accessing/setting hugetlb subpool info.  They already
have the same 'Subject:'. :)

With these fixups,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 52d9b390389b..c2e9c0cdbd81 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1151,9 +1151,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
>  
> -	if (hugetlb_page_subpool(&src->page)) {
> +	if (hugetlb_folio_subpool(src)) {
>  		hugetlb_set_page_subpool(&dst->page,
> -					hugetlb_page_subpool(&src->page));
> +					hugetlb_folio_subpool(src));
>  		hugetlb_set_page_subpool(&src->page, NULL);
>  	}
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0952ea50251d..1e7c4007386e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -744,12 +744,17 @@ extern unsigned int default_hstate_idx;
>  
>  #define default_hstate (hstates[default_hstate_idx])
>  
> +static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
> +{
> +	return (void *)folio_get_private_1(folio);
> +}
> +
>  /*
>   * hugetlb page subpool pointer located in hpage[1].private
>   */
>  static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
>  {
> -	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
> +	return hugetlb_folio_subpool(page_folio(hpage));
>  }
>  
>  static inline void hugetlb_set_page_subpool(struct page *hpage,
> -- 
> 2.31.1
> 
