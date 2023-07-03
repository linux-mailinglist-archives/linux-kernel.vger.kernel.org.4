Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDC746274
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGCSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGCSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:32:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AFEE76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:32:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8YS6011543;
        Mon, 3 Jul 2023 18:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KsmAWPlZ+E4VE4g23/gkZXya7W6kGsQSkpi3ZzZOfF0=;
 b=zLz+ksR5iO7/ixn90b1BYv30Pjwef/YmmOpMU9l2vOcBBEsaUMvPYuqSRuCGSiCDaLfL
 ROZHibFc9T5msRozUhc7VusoutIaiC7z0+0jMKayE3V7++fpx+SBt0DSndclUaOBhWqF
 H/6Nnj2Nnbe5bluaup0tybpbdzmhOl73E/A2Qbh5PoJhxRQElJF0EqZxR/Icuc5zQz70
 QD33DH8s7Lu85pjHe2nv+yW5sDS+mmSZ3SIppD2ATHCEXOy2+DwhO2staPuqOhKdMoiv
 cXuis/ViJHgth6YypD4Rp618gHrkbllmNPQpOAHlAGVUmXXniIuR66BODB4k1NjKAlxU MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpub5xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:32:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363H2SRM040228;
        Mon, 3 Jul 2023 18:32:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak9dxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 18:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq3b3oCyLR7DCQQiEn1so98+uZ6L74cWADsLtN4aqeBw7IF7/yNoOVE8s377JCBmSA0TnvzOZh1wpUKmNhWGXk+wPjMlkYfGQm1IrMSixMBXGxUv17QgXgn++DbULXuypnJ0Z6lfXuhhB6pjnmzQjhLPR7IcfUsR+BD7UyPvYwPhh/b3Q771wkERP7ciZ6tU/kaa+AIfoV0HepOzTMvdSh/5S8MPi1CbamSwGD173x8u+SLzynmx5SupiKEaJVl5maJmKoOgv9nHBHPOaPMnPntdyKRKmohv2lF1QH9IF+ISmpkIFWhajm1NKo9PKWyVxK1oXsVf59Q6VOg5Cc6GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsmAWPlZ+E4VE4g23/gkZXya7W6kGsQSkpi3ZzZOfF0=;
 b=VaIc2XfYMCtA2zFjqBH5H08nvULuERemKnTnBiQMRZTskUepoGKj7j2w5LH22ixcifksgWcKCg8n+4k0aGugqp9aON1L9Jsr2Xw6nYlXqcR5QpY3Bg5qOIrC1yQayBnV8wbZArV2u+mD0bxVV0jgJOuLdKtwduu60Nkkr4jjQ0/ccPLzByGoYjQkfteHAgoRh8S2ZXwxRo1dERUbZi37fxjDORn4hIqtwspgV4fs1qjPXatcd6S97liT40RZmM+TodHyrfOFcS3QZrYTUPbR1Q2EERzfQ3kWHdRRprc7OWY6M95fVUWRrSTs+LIfftmZh44SLR8WEy8JrX6B5n91MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsmAWPlZ+E4VE4g23/gkZXya7W6kGsQSkpi3ZzZOfF0=;
 b=z5lQJvjh7Uf9LBQ7VncZPrzB9PZC430qlGH3MASDeZuuXkKH5LvF35E+gvu8VMkCnCRJ4KPmENGX/RVIspHZj2gJUmbMeh5XUronnM9qrMKTZEx1vNk+hPFb8/cGM6d6bhiILJVJotpChYg0wMF8JPRFKFeQmDXl1sTOykp9x5Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 18:32:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 18:32:41 +0000
Date:   Mon, 3 Jul 2023 11:32:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tsahu@linux.ibm.com,
        muchun.song@linux.dev
Subject: Re: [PATCH v2] mm/hugetlb: remove hugetlb_set_page_subpool()
Message-ID: <20230703183239.GA4378@monkey>
References: <20230623054948.280627-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623054948.280627-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: eccb2cb6-d0a4-4ff0-8af0-08db7bf3e2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHAOjzSxG7zt75+ArLmn2rfHOgE3gQfo94cC0WZ0Ds63rKtU1vPuJg4KH3ugf0B7YvdAeuPBKYuOzLQu9nMkstSI08va6wfjNFgVsrKkN8Jv+sSXgvs7Cop0SdUqo7obD3JPfN4go+p8tzHcBAyfrKMY8qX4pEvjisXkK3SpJ7S9feEPrHM5CGE3WYbctQy9dzGpH5gBIr3MJ294PpPr0iXda+p9i8KJKk3vCa2sioWJS+ZJcm3/3xd7ucA9Adnpn8x4/w0ixKvmFfUCYQPz8svAMIHAztRFmvH9rHBFy7IyMUpRTI7RPSDqt7EYYeykYGolwpkgALLTnVx0BYKmRmrYyuD6LFQ/B2QbNKx3Kfh51a99mrAwQs2N84jhocxHfm0I/uQw9SyAPLnh36rPn99Je3u6qZG8bSpzRDr6F7eiaOJTPHMPCbVH4iXS2ScsGvkpARYPK5u1+UBKblMgoFCdRJNhDHsD9fuyeLxlw4yPlz+fLeqR0FK903fSDIbeH1QMBUzcSSdG8Npkb4HpdICjzIZdpIx9eSXUF2dDMXNTUk/CBqfjHNQWzL15uwAC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(41300700001)(86362001)(38100700002)(6486002)(33716001)(83380400001)(186003)(1076003)(53546011)(6506007)(26005)(6512007)(9686003)(478600001)(2906002)(316002)(66476007)(4326008)(66556008)(66946007)(6636002)(8936002)(33656002)(8676002)(44832011)(6862004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVxhr9SKvQBrZQA+3VHct8POhTIul6fyoBypIPGyB5c+HEPlTvKeu+TTNufk?=
 =?us-ascii?Q?5WQsTpQSOZuia+WqbpLjJ2CjLopSqfh7AE0v2Jq1YER0dihBWUq0AMvU3bS6?=
 =?us-ascii?Q?gvcELWu9eEcWpI38XZH5QF8hjaCTFi1XQ84GGf8LucMqGMmdAikFjkGxJ8db?=
 =?us-ascii?Q?fHpW6PTJDrFvmFQZwqBobjlcFL6xRZAtJC8QCOLHciecwg1r65apKpZHUVDq?=
 =?us-ascii?Q?joz43C3GwQb4kKLquLe+X/EAX7VQc+2ynOep7P8ypfApZYLj2BCv3bqGjy0G?=
 =?us-ascii?Q?HFjUTzV3L3vsbV5CjZiiSXdUGgcdS3BpXPYV6ZlV/haEHw5aPxzIo6mPssVf?=
 =?us-ascii?Q?SEMebcvtSjJUhdfLkazls8iPF3TMNDRAonN1Cry3nv17kA6Dwqc/06SLHcR4?=
 =?us-ascii?Q?RXzRXu0KXLqdZo+sklmfqen8vWwW8C7ei4mD30p7rHhgvQCdDPg4D/yS4oOl?=
 =?us-ascii?Q?Z+QRSm6sYqc2Yon8kIobnhzzoVwTPOQpVQkVUwG5THxFX9FshdLmOukprnBe?=
 =?us-ascii?Q?X5Bmt+JVD5xICekEa5tFnV92W9EArfmUs3fBNLeufq2ePdJQNR8KeLk8mjW5?=
 =?us-ascii?Q?YKwggc3sKJ9lmEuwKeyqWBkKEjITa6jq7v6QEOIIQeSlMxoOFofpnLrCAHcc?=
 =?us-ascii?Q?EZOwHTE3J/fGolMfz2cBLpn8zCS7ZY6iJhG6lymZjOjUGKgAN20I1MpYxF+m?=
 =?us-ascii?Q?eikFQ/tN3dnVKraoDnST379BmTGRszgnVjhXMP7cQdltR6Rbo831XkGHAaN5?=
 =?us-ascii?Q?G8PWAsW5s6VS9cj1N+N1zC//9cuUM6cImY4h/oVw5eyt5m51szvehdg5B5W+?=
 =?us-ascii?Q?7CDTYqQffFOqzM/D5SLVQUMktdE4buHaAJqttC28ts2uXGOBGqiu8nDbVuFY?=
 =?us-ascii?Q?zpx+HgBjH7Qo+sjiFN1Vo2Em/82hvycfMfz8hI5q89bgUeo3tNRT11z/uTsF?=
 =?us-ascii?Q?OA7CAagCwDyRw2rj/0coReNA5F5DOj7D9hHTpsPy9svyYDuygWaB6iitDL7Q?=
 =?us-ascii?Q?ZxH3t8edJx26kDsjxIJqXOK1x8KxCBoL3Ni4BIyoFsagSfO1yxALQkDh80HG?=
 =?us-ascii?Q?qduWupIOmitoiLW7sLstXFGR/ggRdjsWH0YPcrYRtuIeiwzxCOn0EYPP3dw4?=
 =?us-ascii?Q?cZfW+FJHExnYHY0P6kmpo/wDRkIIxLyZL77aOOMBiqoqru470Lho4YEFhtaN?=
 =?us-ascii?Q?Qs6xbFGQrJsTiAY7ax2b96RsEGls97oRFER3J0ZW+jX041ldXDiR04ifDfbR?=
 =?us-ascii?Q?TSXmws1tPSjODsQvil1Knz4Xq5GbLCJ7bQ9PX7AiZteNSxiVg1dEraZBYfnH?=
 =?us-ascii?Q?PGdeJ3b31x1Z6mKFjE/goHUXdmVl2YnbnxABvRvfD6PdgSrFvLZDfI9OAcI/?=
 =?us-ascii?Q?IwHE0oRbEL9eWdOfqn2Nzuh3ZbhstZcAz0CybDRP0E9tLtO09oY4T2IkAOhF?=
 =?us-ascii?Q?t6Cb/iH3C2U0adCkxpmjPYXdittCIa1g/d10MIRdMlKAPReOExXzXoMI+UE0?=
 =?us-ascii?Q?XohMDU/5qRMXqn/xDkl+c/NgTME8ToHXjT2vlOEzTPzb4LN4pydDUFK54Jms?=
 =?us-ascii?Q?vbar4U/TSGxCcCqi9RhYPs0g7xYkjETi6n0PK0I2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qMiz1pgDzLH93dcegMll4aEwxWCg/DBHhtyhZyqQNGWYyjwAUj4eN9d7VUptNbTAF0Gw5/VnTJlhtTrEtzvQx5dgeqa8Qq6bLkhuPevYLb9VaLwk+uNDnfsinTsd4CXc0eaYVbrSp7ASjMmtoJoLfn2m2OMH4+arUBuCEOdmiq4APCnmJ8fifHAC+alagY87k9kDTRaSQiN7Yuv11SDEpWtDYTAF5bdkga5BTub8X/b2kWTVP/SPgrxjZ4KPiIkZdQvt2a9oM6mpgl5Yu6K/7/EDPYydifwNt965dXZ/zuL0L3Aok7sp3wBWOQlq6nAsvSOA7tY6ds5FJONXMGA5s4GxR9I/3UzJ/f4/+p/Fi3qpTsqS3CxDIR5wbnniQ4bOCvzmxBA36A5f5+wl3HHpt/Wko3J8ruapNUCdIHzscGUoIAwU3hPpJzJaNLIKl7FKDo9W8PDg3PyvjpJFOzqjv4oIWka4c5YdEdwfV+HFgh7WRsBqNV9HBSJCJJUtCwCMqE+oZEyMKYs4pyXYxY/WrAzBpEp7FOv5ZWy09n+XZIfL7wiJkUelKXEyUVew6dHI1rAmFfChf2wMEueHT+qbXgLHsjLVWqjNUgCaeudyJ0oIdYYU0p3j8253RsDkEPt2+q63Kzo0cl5A9DQGP5FhTR3M3LViGHssmE9Z0AAN71M0QuV5leusbfdn4DyKMUr93RHmSos67r5poocdghPfFlvkP0HXepbEkKYYQ6IjcY6FjM1iRa4k3+SYG8wkdtKeCNXKkegpqkC5ckB5Pl73YRAop7fkwqzuTJeg5khhE3Pd/SesAE8md3nrlkoWDBqn556pWFHqfGwTFWXlWfFWHRCTrkuWaPjbMiVuUyOdvAPmdnSbbBRda1zA+YV/agTr6x+HVbEsbynCHAs0uizCQw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccb2cb6-d0a4-4ff0-8af0-08db7bf3e2cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 18:32:41.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ2T7+DJkbZ6XDE/pEKtR3mQ31rpM+edR7mBdLDFlvv1PkjuzZRn3AQP3iDbeAUdbc5mVoowv4XJldUyNgW7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030168
X-Proofpoint-ORIG-GUID: 1QhlQ27RYtaRfsG-yGF2YAKS7gmBqVmN
X-Proofpoint-GUID: 1QhlQ27RYtaRfsG-yGF2YAKS7gmBqVmN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/23 22:49, Sidhartha Kumar wrote:
> All users have been converted to hugetlb_set_folio_subpool() so we can
> safely remove this function.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v1 -> v2:
> 	get rid of extra newline
> 	
>  include/linux/hugetlb.h | 6 ------
>  1 file changed, 6 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index beb7c63d28716..ca3c8e10f24a0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -761,12 +761,6 @@ static inline void hugetlb_set_folio_subpool(struct folio *folio,
>  	folio->_hugetlb_subpool = subpool;
>  }
>  
> -static inline void hugetlb_set_page_subpool(struct page *hpage,
> -					struct hugepage_subpool *subpool)
> -{
> -	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
> -}
> -
>  static inline struct hstate *hstate_file(struct file *f)
>  {
>  	return hstate_inode(file_inode(f));
> -- 
> 2.41.0
> 
