Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A363676171
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjATXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjATXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:21:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4606AC9F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:21:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJxRhC031964;
        Fri, 20 Jan 2023 23:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4t9P9OBhA5FHFAL4vf/dMRZbNREREKZ8CvTxcEwFh0o=;
 b=Cj3JXUJWCYIs0CeNYxtvH+T5aUMSCe2MHXeo6TMuKO3q1vlQURn554kB4Dqz64eYOr9q
 6TDpxaXgslA1ZTDIueJsslpMsvE4CSsPfl5ZJBK1tZSJrnNPR/kyhTqq+1xbvaOFce4i
 wDw5gs2jc11+HesFDq5+iS/Jh095KX93Q0+ov9lYrAO43A1Jr9A8utcfspTZwSUvzFzZ
 FqQcVGgznD7JEFpK3T4+ZVhmUTaMT1t7ViAxmrNG7s6kfEMQTVl34w5p5EfkIOy8TxVx
 aFItK7+t5YYepjIvMl15/KLJ+BkQQSWZR6oi9Hj/hN6yHjAd+MbrLNuCcI2TONNXD2Wh gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k015xy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:21:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KLGAw6013532;
        Fri, 20 Jan 2023 23:21:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfs2f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 23:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjoUbTqZRV1EDPvm+LUp7lVhakucQS2MNk/ahe+jM5apxD+cSNVlGVZKzf78bAgrGNu7jYHxXiv9LCwOq87cTQGlCMu7HcCjsCiFX9BCDWQIKyoyGydlLVmHX17zLpgO4qINkhpk+fujU708qWFLCHqev3grh7nb3m0uCCgq5Y70wdFIgIHx2XSpc85M2qgVqIf9NQWLxJMCQNdYI/kih1k9D3fHn6gClxxNtmSXuURO0c4cT65yBwlYLeOWfzL3gAVHip32zkUCDP2im3AF8jbzEtYCh5s1D5BiKllsb+B2uSZHLgo7GJwxYoI1zIl3UQvM1LW5uRcGb6rcPCeYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t9P9OBhA5FHFAL4vf/dMRZbNREREKZ8CvTxcEwFh0o=;
 b=Y0BW0Nw2esYunuqYs5ljjSAZGXwI6G4hdK7UFgusQJ2SmP825A1KenZMNUFSHqf1Jmv6Zaigv8TdasfPf17sfiKHYSLvoIsjtuXbA9TQdMk4FnOTxgK9INNdMfYl0jpz0DyAuNdjMAWabuLfSOrPvjrjDnYa0SpSHZRHdtURMMqdWPQxegGKGSzkp319HVwDqEuqAQCe/I5UgpRwUNr8kBPs80lhkkQD4XfGTU/y67fkLVwxUYMQfiHHnDQ8Lbhg/ZJ+Vd6UMKH8Iw4GhBJHIp53hxDEF2v6Are1vWfpIVkbKECxz5+cqwI9jEdHbhizqRW/IxW3413BrhnLIMurnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t9P9OBhA5FHFAL4vf/dMRZbNREREKZ8CvTxcEwFh0o=;
 b=wJknc0Ij2YkR8P3TbDgVVdt5V6SoTUQ4TQuieDPfcGUt3CXVcaq7HOIRMtxLkwRGMsaC+8skY5WNLASmRUKbn/VuTnzSGFrhLFcwIjXkOYBDjul+p0CYfIDZGnLe0iZCyDXrFsyBqbF76oSZJt03Jyzlk7EiclqNK+yh4QqgJDs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4565.namprd10.prod.outlook.com (2603:10b6:510:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 23:21:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 23:21:09 +0000
Date:   Fri, 20 Jan 2023 15:21:06 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, jhubbard@nvidia.com
Subject: Re: [PATCH 1/9] mm/hugetlb: convert hugetlb_install_page to folios
Message-ID: <Y8sh4mI6+nPkUwx1@monkey>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211446.54165-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da2e561-bfba-4fe8-f3f8-08dafb3d02e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1VNBGFbYKaJVBomMZ53fhj+PZqmiU8zFZO1RLo46TaM1iFqETC46d0bfxXjshFDPYKljRBv7lLe+9CZD3T2B83rlh/sJXSb/Zth73zF3GV4e9EpHn4xVGqYlXSyuxc+eEwpaStaOBhqseQfxnZlnaABUnUrnhqNyrIF240HQv7jfBZQ7MROPiksv33oc3Ws0bKxUQSl/3rd1DZfsKTqU0+HQSYRAKzZFDg/gM8PItOjTpve+KPTZSHWKHRDP6fgpFkdm6YGNcLcR9hyKucMYNFMOQ3U9KIpXi3smB6bvItoLJ6Tuy1Ydc1LAYTRnGovykCUoaPLejfmVQLnrBcGVsGg5eKKcMei8LDjZbBQypvdUDcn54fwoL9OXZUT6mUMWS6rU5/OWLlyv+YgmuztbuclXqAUyvmrR+jip4sA9RxXA311W89bnJW0O31a7AbkuJt33wr0Kdr4IU//1uFw9dg7ybvREGy6t8VpXJ5BQIT3XhoD4wITIp4E2WkYkQjQ2gz0dr66ENpxtasfu0n8/lH+h1ngc7KVWP55Fpy0oKKRtTx3P2oGGp1pM9vqIl3XuXUH0+DMZ3CI9iW5J7Of6C0NpGObG7iipDjT6FopG0cv1lC1+5d9iR0bJW87/BBXUKajlz0C7g6+5yk6pypF8kJ2btU53UW11lXpMdCmC5lYJ81chH9S5WBXGN2f1jq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(83380400001)(86362001)(6636002)(4744005)(44832011)(5660300002)(38100700002)(8936002)(6862004)(9686003)(478600001)(6512007)(33716001)(41300700001)(2906002)(6486002)(6666004)(4326008)(8676002)(6506007)(186003)(66556008)(316002)(26005)(53546011)(66946007)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/5nJ2opEH58wtvRHfgZ3gPfLin9h9x5otwlzCz6TszjNTu07DzIWAuaLBbr?=
 =?us-ascii?Q?c5J4ID2pps+rYXyQ0eFUv9XkMX4SmP8KkZR2A6hU7dzJW8V2FMQrSMMMznx9?=
 =?us-ascii?Q?dHphEiFc1TWI7maLZRP1sRIDLnadA6UZx2Kprvtv171XStuaOP3SAVbPf3r1?=
 =?us-ascii?Q?NmjIdc2bFdQejauqhi3AY8chrSqnJHxLf/RVQBH4jpE8IPMkooq9aXcZRwbo?=
 =?us-ascii?Q?u04126gEmMbYBQVwQvrGiMj2vvSp8l1es+ibxsrn2KjsFGu5FWGdBhfclh1K?=
 =?us-ascii?Q?HxzR1S7wfQNKLGH4IESjvB66OEXb1SFGmc11seZfHnjoDxg6r/FKQwMLZVWe?=
 =?us-ascii?Q?zPQIfGG1B7yHEh9THgvGvc4AxroeojbdhOczgHt4YL6zoPzC01gP+d3MJBuX?=
 =?us-ascii?Q?DPEsFWdCBTAUzfxXxqaWNlb+puWGkieseHSCwDhKrWiAnlQlXfRyf5AnstnF?=
 =?us-ascii?Q?m83Gi8ptouX6yOZVRk5PdlG2K65VoC0as/XFhVNtyty+F4T2ZrlSt7ZsbcCl?=
 =?us-ascii?Q?0sAJMFDU6UlRJC/2qF518tQU6dE/taAh7NtQba05MWokE+XzqwRGV7erh5NJ?=
 =?us-ascii?Q?UU/aKOR9jgac8QGBtlcaqm5FFcUjwgH3X0qby9mOpDVNeb8hIDB3yq5PiPId?=
 =?us-ascii?Q?jW02oI6SYYuURx3EIidyWjkfZdY+n95Z/GvDusFD9xYYIs102PMDsuY68Nd1?=
 =?us-ascii?Q?KWhan3/4JNbUzWYyT3VxIVYxLUTY2/QZxq3QbXODNooHBLrqVTJj1maJcI2u?=
 =?us-ascii?Q?hKhA7n4H7p58lm7gOFMmnfXsLTuEOXhz6EHvbtOm4Z29ueokIsOgHKtZuIaJ?=
 =?us-ascii?Q?WypHRde/DbH0yDIgHW9h+/XNuuJFrnZAjTB5Ee5zQKO4eR2zXJoQnqaDo0GB?=
 =?us-ascii?Q?EHuDz8HQ/hHccUFX9HRHPLBPtXI6BfiZzO5AOlS/APL6Y7HAXWs3eHKPTs+L?=
 =?us-ascii?Q?pZ2Ropa3SX1Qtgv0kQ0p7qrNAOjDkhEAawq6I2WuoLmEYLsqck/wBe604GKn?=
 =?us-ascii?Q?pCmmMP2UrBBj/kFncHgrwVJQm6bbxuv0knrv9rDiJkS3TXEZQyBmTlHI5Rrx?=
 =?us-ascii?Q?liiLRe/HkWp3F02Z1oaScnyM3S+nqH5sLrokt1RmIFfLGj84npvdKZdj+C+v?=
 =?us-ascii?Q?qIHFgt1Xbs5FXY9SAa+b/4C1H0T/yv7yTBWYru6J+BLE2HrjleJlZDn+w7rF?=
 =?us-ascii?Q?iVkOTiYULthuEljgRBT3Iv1EMxJpDErtTCYnEG7h5xTHu4d30GKRnNmwWi6C?=
 =?us-ascii?Q?VUqWcW11x9ksp3yg9SJn722BYDeMZE5HIuoh65zFCe8kDDdLTUqez/ymGk9/?=
 =?us-ascii?Q?S/spLkR5gXqs3clqnTmwjV+9QdaD0i4WWk2hgPQWsb1zqqphh/P3R9Ufq8DZ?=
 =?us-ascii?Q?sJE8EOLeawxcmWeXc456t7LaQFXtgLuxj5856Nkk/xWKNexnskMGIRu8owWA?=
 =?us-ascii?Q?Z5XO1cd9QLn7a6vIKJ16EBB3wxNL/ArluFxNrN57bLJBP5xy1d4HItDqK8Pz?=
 =?us-ascii?Q?lXumBPYWBmW0pRcQffBuMRr52K9LF1f3mg89bK0bvqrpfYdeQnjIkede3dM9?=
 =?us-ascii?Q?yk3BowADEGbRZRTAJIpO+2cGTdQJFMTPcl+OScCWPWcHlEtDaEM+IzLK/pju?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?p4PsUK3vWdyxOaRsypBACTks9DqX/ocC/esqU2BVly90YWzWMz8GmbUa8oOV?=
 =?us-ascii?Q?aY2XdWFeV1liMVH8q2F2k+xhHAtD79J1CVnLh6SjD0Wi4wpNTgsZamGIksb8?=
 =?us-ascii?Q?zYVX7qi3MBFGaotwyyK+J21LM0XPnckhUnk0fjPIyW3trgGOMzPlmr801B2+?=
 =?us-ascii?Q?bp9zcIDjzKInq0NHQcH6Wo9tlyL9Dqngjym5QqQ7en4TpaE8DEbL4Uu4uTQe?=
 =?us-ascii?Q?EoFqVrKmWL1wfrkP7MhUOZvAnvLaIg7V9NTah9QVbvHNywokm+2GqYCzzER1?=
 =?us-ascii?Q?NLvQCaNgNQwVwVrSOiTxKZULZSbneBCn34LWScg/waiaABbVWRz64HNdNKQZ?=
 =?us-ascii?Q?pRntCdpAKQUhZM/yl+rQNIV+10FTTLCHveC4JpFLyJUfu6k+zXlUJ2HK+ep5?=
 =?us-ascii?Q?ayluCiUx5A5QAvmu1A/4S/QQxJun9XStWbAZLMdm5YAWgOkzncntMXDovyGd?=
 =?us-ascii?Q?7VrpGppWSpAq85aDcXL7EMwwqRGAy91dIeF/BsKtG5uM4cZj8B47tRocGSDh?=
 =?us-ascii?Q?bNlDV+Yd1Wwq+i0MD3CtGu20V6s/fDkbGkA5AyYF9PWnUHd4e3yxBmSJ3iio?=
 =?us-ascii?Q?zJhAGyNhPtKGoCcX7TCHEvjg4NqemXqgVlQMXhkn42P9msGpJJ8DKywPBs38?=
 =?us-ascii?Q?6xDiXPEBCXKRO4IPEOKwYPrX2QelYWzgOqsojM8YpyRFSISQxmoK9xGezDJe?=
 =?us-ascii?Q?JG/fwSvRZRrrUvsETNI5/p9mPz+5mE6O+jfgTdpVOzVNtKjB3sTl3gbx5ckW?=
 =?us-ascii?Q?IU84wIhxcsYkYdmHno4K8C5Elfsk+x+5X2XWUdYi7EmzwSSJc108618mxJPD?=
 =?us-ascii?Q?Ah2Y8RS+UTlIWUX/EtZzTEp2lzDbPXnVtuwYHQx7JIvHXOJEBu/jyAr/Z4hp?=
 =?us-ascii?Q?JMqlQ95PrmdISXM/MhtKkLsiEddcPvr4c03ElrT+sNhLfHmkcvK+/9EBPHmI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da2e561-bfba-4fe8-f3f8-08dafb3d02e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 23:21:09.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od9T0HG+7skTEmnsm3GWsWkOb8BU3r955F7bZyqaGeG50u0MFLfV83B/ccKqmq1iaeTlKnC8vNpGASAHGN7IuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200224
X-Proofpoint-GUID: uyXFJjUQve8ivK-5NswMzh7YK4eaWmh2
X-Proofpoint-ORIG-GUID: uyXFJjUQve8ivK-5NswMzh7YK4eaWmh2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/23 13:14, Sidhartha Kumar wrote:
> Change hugetlb_install_page() to hugetlb_install_folio(). This reduces one
> user of the Huge Page flag macros which take in a page.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Looks good, thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
