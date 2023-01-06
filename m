Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937F5660A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjAFXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:47:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB73C0C9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:47:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306N5gul028092;
        Fri, 6 Jan 2023 23:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=7bOU/1rMRojUL+9O+ZsHeALRCF+79gUCRmXRC8S8dmE=;
 b=L5vIC5x49ZmLR/KWYXOW7kEMm9N9cqDBnHXJF4FaJ1lUNPigTQRHBXLPdLOutmXPc9xJ
 lp0KG1t38P7G8bC1dKUpy6Ilfy/P0UAoiYlXoEvG5X/DNS1yuIcYB5kWAJ7wEq4fl+Dd
 q8Z7Tz/8w/1f0e8O8eoP5sxApa0/k6kpne7f3EY4mzM3UGenRJIo1tWwEKjrwOu9anjb
 Z/atTrvqfnMcw/WNy9plHdZ6DtKwuFO9o/q53prs5w7aYCWMNP/z1Qk/U63SZgwBOtqr
 G5c9v1zA/pPfHN4I38HfneEOfmIMr/8JMQoofm0gjlKuP7Oepst+sacMiYMRUb280Mgr 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtv7gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:46:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306NdOUa023332;
        Fri, 6 Jan 2023 23:46:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkgst6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 23:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrR6RfPWGf+IHbiiVpjb7QoVyDTfMhRkKVR29isXyU3dT4DrbiacqKAPlAhitaGMsulDKbeuhAQjd7ZRm2FtHlzHLeJtEM/SN4wdojswBD/oa2Zr+JRpaIN2cWfK7SQolNiucX5GCpoUSti1dnc5xnmi9g8ADIIPGPBNWUPiU1cSq+D3+dHA5hNyJB50/j8srhq9SooT2UQ1CccdRjwk3kc8DDTs8HJwg3RBVCxwPvHgkT2p4arWiLBElxqjswfVgB1/t8QoWjqj2nTKAZ1FhaWVngZ9+UwzNxlqM5+h2sLNxe8dIkm5wsp97fIUZ6nYxuE5lZM+uAK78TnRiqNVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bOU/1rMRojUL+9O+ZsHeALRCF+79gUCRmXRC8S8dmE=;
 b=RmRhd4/0zXVQNbQfFdI4BC67ZUfdTLyHxx27LarJWX3nibxlD6LPinzVjt/K+1hePK1jBccGcnXt1ehZX5yl2W7eJ2dRf6OndLJXIds3Pc5ucyn8csgPDx9OVNX1uES1B7fjO/iws1rztjNlU/rRdxrLjkEMaptzykJiYWiaB76aErQDQtqwuLl2fmxiZFwFnB6J7IrDX52oQIqLudIzPVahBHejgP7t2lPLYYWkANli4FW5XFL9RLYqj2pwg7aUCjh8Horxff5gEEqddoUUWAKo9I8llXWw6YpQKHeA56JQN+bQI9TGXTHC28AuR0xxaN/9MuJnZb4MbYmNx+MA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bOU/1rMRojUL+9O+ZsHeALRCF+79gUCRmXRC8S8dmE=;
 b=ZKJz7FH4kurBqrm+z5D+g4H9q4FQqeVq82CbJAyKKT0RymKOUbZbdtVitzhrNUYJtN4s73mroWcf+nLJ/LazZZhKzG9GFzZ7DIpJafoJuCKATITXgF+1Fy5tELp1jf5L8tCbBAYk/by/CgHXmTGsgBghHo57qSLjwnYw1jKkgn0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 23:46:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 23:46:53 +0000
Date:   Fri, 6 Jan 2023 15:46:51 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 2/8] mm/hugetlb: convert
 __update_and_free_page() to folios
Message-ID: <Y7iy60T855MZlOyE@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 171d5c5a-3641-4163-1cf8-08daf0404a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoroM2GC3nIP1fMN/vw5bs7bmS9xlK74uPKnkAKSXUft5cniT1vBN/wvSkJbaHN/OhNrruVyXuSYKMf4gxdXToG+wM5mEQ/7bC74aioPZJuFnFlDFl1OsOTj9GXQi7wyQHJADrFhi62FsofDqyJzo3Zh8RY9Ulole8eqCiagou+lQZ/Zl7yFORPSJ2btDcnjiI5iXq5b5da3PFl5fM35lXrbKGionsq4q+enQbUoqTbsNidZo2fpvcqvdcoNCSDG5LvbphJG5Lck1mWg7j9kT0iHvYzmewTbtgsj1wAp4Z0nj7ONhqFzMwCSm9ljqfEAdyTaihtv/LXizHJOq6+h3QOeMKvOk0IIlEaK4Sfw2KDqGhb6MMTsV8UjCUOuQnA/RFbFy2o4WRNPeEoAr8EuMINjJR6SRg+ad7GHENTy7fctzuwz2jboSn+jt3PMg4n/AHuAiKwv0AQKn/kjqNHG7E6N5dgi9vJK3AMmf/i9F4uwgj+zPPzLCd3mAbM8d/a6WYAC0CBW0Wq4emgWPN/4+8uhx2DiMuT4vRIn8ZydTXog0IHKEQTO3RKkYCteGmQChpdJdtYNrPz/yp9HJc7bpgnTZSPN+TRhItmrMMmuRUmbz+Ubc2THY3g/N/RjdrLbq9sRLuzwLNGY517Uk7mtHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(83380400001)(26005)(6512007)(9686003)(33716001)(6506007)(86362001)(186003)(53546011)(38100700002)(316002)(478600001)(4326008)(41300700001)(8676002)(6862004)(4744005)(5660300002)(2906002)(8936002)(44832011)(6486002)(66476007)(66556008)(6636002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVMDNdRESoYWL53ZUXwaP14UmY/wNEm+8i4f1ooDig7JvQ/9W4awpYYaGZJF?=
 =?us-ascii?Q?hNV/4WU2kYx6cB8XzauQ9yF3lm9iUnOibYGs3VPGYqVPQqaBlp559jHcmP9k?=
 =?us-ascii?Q?WsjYaRWz1fIDBL5sVfbbXXVIzP8oEwARge/b8xJfXqjR1b3KhQzI3ZDodvTa?=
 =?us-ascii?Q?++J/dGSYMI8LrC+6bpqGIOdmKCDoyAHDFU0rHcATxrYzOk0lIqFg1cNUQUEe?=
 =?us-ascii?Q?3y7bPbYl1fP7nqA9TiSboitOdyKDC4XDIIU9fkR6D4lSjAFyKM/BnP2ijHbd?=
 =?us-ascii?Q?XFO/veOli0mvK1rW+gnXxE9EWKULg5oLABOGg+DtKIsTuguGoO7fUF+A8+pl?=
 =?us-ascii?Q?EdKGHEuKUqJeQuzQBJAd49BAm7wy9X+C+89ih9iniV5UQKVM62LrfiD8iAZ4?=
 =?us-ascii?Q?fBSh97ddC8zCF7Pb9Ada8nrjx505wn0f/Du0WXYAakTEOdBP2QV+7xf+kiVG?=
 =?us-ascii?Q?y4eUIoyY+A1/3Fp+WXE9C+BW/N6i+icaSCjDjwndDCQ27VEiV2cLcEGVTuZ9?=
 =?us-ascii?Q?mkK2+ou+ntGpga4CwBUtfp94Q105bZZftMTLzpthoRdE79JmAdavGBTpKeF5?=
 =?us-ascii?Q?dXiH9A9bIyKjG4UtHkb0CuqAL4fqnIl2jQnFNJI44+zZz1QA9tgHf0XSuTgI?=
 =?us-ascii?Q?dhVnURJ3KdxwyClJHZeyliXFcRse/RqAAJQQ13hOSRBxd1HTy2aWfkcXB5GI?=
 =?us-ascii?Q?ZcJrfN7faByH9PM14AzNLDu11NK+L9r+eULkeQyicZNj8ZerN/oEfS6DrFlb?=
 =?us-ascii?Q?kCTJyg2L1/8yMUqGxdq/khnD8ycIK2ZRT69iEkLyAqthrT77cq6pK16x3jPo?=
 =?us-ascii?Q?GZBTUddrGvDB9O7/XKANZKLJCHt7PrUn0ZGoqr9ZhlzaSeYrvkP7xU9sdIOV?=
 =?us-ascii?Q?WsxvJ35Y2W2EfvLdb2GwNXVqDoh4cxxUhhRNQ18eCm78J7P6AJk2IzqgYmM8?=
 =?us-ascii?Q?PsCO9rRV1y7sWDFEAJ5hIvCIcOt51xzQes8bagChDpcNJkzRnEf1+dwSgESk?=
 =?us-ascii?Q?HTqO6mEpezHvGZkzD2P/JbAxdOaJuvBdcXCKhgEcnXT2t5PZiJUre+yQ0B2h?=
 =?us-ascii?Q?OR19nQOisFsyCLTSkvqRuxVsD+bGp/1lD9Jn1rWOpd3oO0+F9HeDEmRBj1Mq?=
 =?us-ascii?Q?95HqFQm76eOr1cp2TlHFEQsu9GT1/flwiWqT3f+Gz2jQsv2pRsc5gzxLhFy1?=
 =?us-ascii?Q?0oeMvDSKRzoQ2xQdrmLFOS2NrTNOkTRdbsJB2Lo1U3UDzq3dh7fjJAP8MXdD?=
 =?us-ascii?Q?hsDTwBc0VLh7tS8fqHI9EtK6aTneb3HDP3dzAcdRw5nMcoDK6PMr3OlxbqAe?=
 =?us-ascii?Q?AOU9q60oJt5poo6jc8noXH9cHblTqEbeS8VmH2h9bln94ZXmuiBA4TJz59XY?=
 =?us-ascii?Q?xWXzblvAhgFZYrFdKC24J1ZfxSqctZfXY+9//Y7vWo2JBeITU1/WeJDirTx9?=
 =?us-ascii?Q?1/Tqnlw5GV6rr+xI3gWTdXr4AqK6vhCayqKv7WUeEpnrHxd4/o6jsI7J4AFr?=
 =?us-ascii?Q?iZzotyzwjRF+6jzzMr6V+qDZHascl3LjuZUWGb0QiA3aMv/FV8h7klBYA6Sq?=
 =?us-ascii?Q?VzjUAgjz6JT/FE1YoDhJ+2hGa+BwryJG4GM+7aAKNsx/a+JEE0rDuS/pmj36?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?utxuZWaEeCgacRr9R6SMbGTsMNAq3BCxirvFu0V17RFrG05qa6mehOkIwUnp?=
 =?us-ascii?Q?JWGGCYBGI8sf+hFoc4VvQKQh8NhaKpR+REZ+nDkG4Vws+iDJUQbEBUQo0bmC?=
 =?us-ascii?Q?9w8JBSBssHIHIHwuhhqDHd448wbUwdYxUCu9ooTihXWpYB+pA/IV/OM/E9Fx?=
 =?us-ascii?Q?3bzUarbrQ1KfXjGc3vSMOAQLymXsG8QiW6QBfWwMjhFp215rgS0Ln9k45L2B?=
 =?us-ascii?Q?l0IV4d97Gs7eF3jjr7FNpVGpuChkPVZU7o9BpMyiSZyml2/BMw3VzrQZz/8t?=
 =?us-ascii?Q?hGSNek8LgF/8Pnx8NYRV6hiWb50uTs/8kBeFNwMAHfnF50NlRMpuuuJPWZLE?=
 =?us-ascii?Q?0pmb+TEnkms1cM+tbx8r1hcFSFLHK4BZgORK8YfJOErg2Wv1JSHGAeyG+UuH?=
 =?us-ascii?Q?BvBBuZklte0zfwACqh9f/x2GH7azsnG2GLr1F+YDtUed9p+O3PBAm3M+RZvI?=
 =?us-ascii?Q?XtfLXY+vk2b9JXQJ3JQGfAkWAhZ6fxibMckMBYt+y31XzcNyjPxeQjGJRm2i?=
 =?us-ascii?Q?4Ewd8iPtEjHxPNETA5HBzgFwPSZPz8+DskiWaLEK0z4wgL2Sg/orBeLRQYRm?=
 =?us-ascii?Q?/r0nCFuHGYJr14b45Jv0SurFsCp38igCVSWmY4VvqLjL0mgiu4lBVGiCeXtC?=
 =?us-ascii?Q?q6+4IkkipF3+Fbih4gyZNi+8JCSCBvP325jRu+Ib1cVmEVbS+kpQEvLab+gA?=
 =?us-ascii?Q?fSTnFrc+ob3ozQSSAfIqTCilCek7xumd5OM1UNRvHT8o2lf0t4cunJcUkVUU?=
 =?us-ascii?Q?RWhMZ7FYvU9nox50VMeZjmCukjZsFfN7GXXHDcVIJ+BEXbaBusxSp44iMcWg?=
 =?us-ascii?Q?uyC+29kfbNvexO4THY+yiGgjuOGtMHJpAx9E8b9NzY76u+OhVU+snXqVyDCP?=
 =?us-ascii?Q?sbPGl7Mg4lJ+N0FjyJ05G6QIvsRvp+i5IPaT0P2tlP80MiHvnoGO3sm2dYIq?=
 =?us-ascii?Q?zIYKztNZun58xA3ymik497N5oq+EooIdKfDHzQ9fMrs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171d5c5a-3641-4163-1cf8-08daf0404a04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 23:46:53.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwKiTSBvUB0EpD2GqVfnjrFo4Jp7yc0Os6sff5qiqnclC8CXUhPK0vIbVpV9V01WFIjr71HXEspYKxZVU5C7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060185
X-Proofpoint-GUID: zT66buMvylp_F4BZHIxa6IPtoqts5fr1
X-Proofpoint-ORIG-GUID: zT66buMvylp_F4BZHIxa6IPtoqts5fr1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 13:13, Sidhartha Kumar wrote:
> Change __update_and_free_page() to __update_and_free_hugetlb_folio() by
> changing its callers to pass in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
