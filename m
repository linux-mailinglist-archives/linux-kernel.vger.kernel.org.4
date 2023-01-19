Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00116674442
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjASVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjASVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4329086D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:41 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKwkjO010065;
        Thu, 19 Jan 2023 21:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GHxPmvKVHX3NIeUTQKvpfBxCyfCEIpn1BvmhiZqKnxo=;
 b=gYgoXoQSH7r/euiZWS4oPXh5s+c5OofsU106xRjb5P27nd2+V+1uQjFVKm0eyuQczNJK
 SzJKTiDPqwq6YYNjGJe1TOy92fuh+Tee3U7kf5HTWM/LpIy8/u7wYezja6ulx+TNDSt8
 Nv/zc9EohjXEY2d9N6xTFQBzImcSqZqCjirdmEDmMKMhPq4pIgUC6MtExRyC868yucer
 xu+e33WE6FfEJTWmERRUcGwJoZoFbJa3D7oqrg0Yx72wHJY2lszrLWzxKIzKeT7hTKcR
 AQyZn3osythOsNG61ju/X4dk5LKEVwp7hj5d3GSntFMUvkrsWQlE/iraKhS6qmMExREe yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medkdvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJZFcA000860;
        Thu, 19 Jan 2023 21:15:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d1s0h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVbeGsv50Mywd/K7OJ49cX7buOM8ioVvcppnKO7xM06rJO1kvD5x4wZI3kcu9E3WzHJ3Z2jDYvQOn+yT+F6X0S/ZIz+3lbkkVTMTsQp9U3LznnKG/SZFe9pqO1j40R279zFaRA8qFY7qEoD4np4oi8v9DcurgF0VhH469rKpEOy9RqYXh4CgY+sIAa4gCpnHI9JfvsG6jq//LsGo5SS7O5KWTarT7EiNBzKs7gZoYIEPg+tKHjM3CSX60Fwy7rc3sZepvzCY+jPIAE76Ihmdf/YC0f/MgBI+gcQkG9IKep269w/hbs7osT1daQtg6GbHl0gKcz8UehT8rTBALZGxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHxPmvKVHX3NIeUTQKvpfBxCyfCEIpn1BvmhiZqKnxo=;
 b=K6YRKq9faOebPAycuIJl1bD9B5K7K8m9plxC8QtsvZH4De2v1t4fnINKLxcZVwodlqmDLNsmXak0zgczYVo0V84cv2EnHKXMP8Kza5pnEI9YtwNnkpg4Ycr0wtJ9/hbpZdLnrC6lIcDzCKr63PZZAitPasr0qCqmYq4PHi4eAJB9zYUpcM1f4PSdTyyqsCiBA6w1/PfhwWBuDdunak7Q90f2rPn3CSygK2hAfqz50rXNSfR1biapEVhcWXsgbvmMkw7oQKXAhQtYRMYXHwDTYm/KTptF9B7DzNXJRjEgpTQwY4CJxrwyCHi4zbc93WCpLVs0BWtOYDQUQE+tAFfMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHxPmvKVHX3NIeUTQKvpfBxCyfCEIpn1BvmhiZqKnxo=;
 b=FMl+i2cwH59ZYP/hVFViBUAfLoewb1Z4JkfW0r3PRxa4mZZE1kBf9jI2G5nut+yZrGpOY7bnaGYDJDzVk9wpYGxLUaJwImURE/FVccObmfixzvbgExv0xJlz2QsQiTca+EuSboW1X3oeq0gSKxa0aRC13OwJR89JptokQrdJqMU=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:15:20 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:15:19 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 7/9] mm/hugetlb: convert hugetlb_add_to_page_cache to take in a folio
Date:   Thu, 19 Jan 2023 13:14:44 -0800
Message-Id: <20230119211446.54165-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c14585-b4ab-4e86-fe06-08dafa6244fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXrgnV4XBQKY7vcaJu7VArq8oNHiY1kLHPKp3aNTYsUuP3daXmVNrVas3kQHOenYswfXRZemWHLQpRnC5RmRo1IYM4KhtG/e+o9aVvejs59nUcWhvaWYi30TrKZ9WMYUYMkhZi9dPjDy5o/WSzsQrkBRrWUPE0/9bqwrfSDWEK5tvxkeX5oCgRh+6Dp8WmEEZ3cYAQbq0C+354IuH00hmnxtCN9A1ei2IhwhU3bvteoS0n2OPjqEsmtiaDX9U8ij8Vv5NPzdIX0d7z2fQg0Pjy+PTC0yamoV6jUuKSuQqoSCk3WAqBVOxBuQWyREWuk0J1MA273Rl/dkzw0KAQKshQRQ18ajy3fX9B7ERkivUfVAt5szRF3L74Q0TOqkLoi+jNH/5E9P4qnr5ixBNMmML6HwFMyH//WLe+3AjaFcB9jbCUn6pe83wVLy4xB/T4MTOEkOsYMYpqXs8m77z8tQDHKA3svLWIaJBPQXvWnj+HZ9VByAXE3uDK8jmXk7V51Imo7PDCGwDzga1zKuiy0OA5F2t1eUGfaIUQNTLtpg99Opel0GiKZiQO2yic5EcpCnsAIiXryUdbygJ2yiuu0qDeSH+rIe2crL93DZI4j7iotAD87oHapW++oYp+3a08JfIyytuKReudDONfrRej5uJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(6506007)(5660300002)(86362001)(66946007)(66476007)(44832011)(2906002)(8936002)(66556008)(38100700002)(316002)(107886003)(36756003)(6666004)(478600001)(4326008)(6486002)(41300700001)(8676002)(186003)(6512007)(83380400001)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lVvvUCyZ03KMSv32MLtYbA+KFkC0XLvSf7HMvLVCW2taqt9+27oZ2/ESufQ?=
 =?us-ascii?Q?tGkBNpOQE7UjzKo7zQkta5DLtlZQz9T9NFJsQ3s9UcI8oqreA2DPU3oZe9q7?=
 =?us-ascii?Q?4fD9MKRiwuDa/tjw8xIKC9IOLcdmtquH9yKS4NnI5Vwc2hmeZLWnW+qbGoEc?=
 =?us-ascii?Q?6uOfEAeO6TeK6yFG//g9uvc7tt3Zk1OjfglsieJRStrWQSfRo9iBQ/l2eVcI?=
 =?us-ascii?Q?LU7LtdHWQSMvGFzAJUH1H2tT8Ii3cCZMK8zHDyn0vPDt6fsmAZRFmglTr9JR?=
 =?us-ascii?Q?WDB8gciyzQ8kN6eiASlE55zrsXe+9wkfh3IutbSqMQRhOZPz1jbwbjK0HhlD?=
 =?us-ascii?Q?qTquVJli3+ra2v5xD22D/S8TAn3muaM2aI+IiH5jlmowZWI6N6j3LPxQVXFK?=
 =?us-ascii?Q?Euj90mQWpYWjknF4+qAxc8B60d3EnhZii5prKMHOEIsnbosoemjbId+RszU/?=
 =?us-ascii?Q?DakWrUbY7QPrSd3GzVCU3WZEq1p6oyEsfiqdRT7HT0OAWmOXLRpufAbsVzFV?=
 =?us-ascii?Q?YB0FyVhRF5wy1cwlyagLubLnGOa0M/ODXqr4nEznf0COsdaAuzjGoauxpNg/?=
 =?us-ascii?Q?xVffwSFKoMj4sUGjav0m9U2TE6eepSxXn5/cCjqGEN3SkQ+6Ns57NR7v1qmg?=
 =?us-ascii?Q?EKqKvys1S/G1Kp/M26/ZTk0oWynCjfsx/9lWyPK3wl5W38ABQD7yEjJGupw9?=
 =?us-ascii?Q?UbC9VM2u7ep/nxap4vIc07jFR9wjjPH8hpuKtKyAT939lFF+WuZOZkEKY0mh?=
 =?us-ascii?Q?Gwewh7Pb9gJdCJJ6vJ/s7Lx3LYY4BwGvcsIhxgeV+Gssar+hEe2uAUZSFj0H?=
 =?us-ascii?Q?Q8sUpFeBj0VVmFyjF2ZJMqBXAgJMYQ8894pIjKcdssFm507pl0MFyK4wGJxR?=
 =?us-ascii?Q?GVRIk8DkxDNnhf9gulKo3LySSM/zk6nv7h9Pxs5d8Zf7rtN1qodIV0BmEiUr?=
 =?us-ascii?Q?c40Vq91X//4Aui/dcufWjDiH3nCfYCu6XsWnr9UCZ2FRdAcn++UFQWlK6qTl?=
 =?us-ascii?Q?imo/geqNaAC9nCntOekEF3qwrzj9qNSsgXxGIXsW8WKF1qh93VgeaUPSxSI4?=
 =?us-ascii?Q?twkoKKicByoULRwTJGwsYYjqKzmHSGiPuZWytd8P23GDIN0BL4SaegxZtlYN?=
 =?us-ascii?Q?CCTVf90tF5ZQRE9cacsxY+t66qhaU714JefWdCXIRjT6DTvEE1y9mO4m94Ov?=
 =?us-ascii?Q?QEseyyjCPZ+Fk0oVOZhLhDXf3YreTPgqRVdHWU0LS0WF3g3EQKcl8gcZB9CO?=
 =?us-ascii?Q?J43BdJ+geqO7xRKd/4unknv7iykdNpGofPNcGyOFCqO2hwPga7sCl7aJWH+M?=
 =?us-ascii?Q?FKeIMgZog+dkfWWO3/KUsF/woL1waFQcsbkANff/3gs8qKPhYI0ivgUN16/7?=
 =?us-ascii?Q?aYo4kGo3FVDDjOOrlFT0DrcWqvq2doPwVObSIOYVWRobf8Crx9SsRWbL++PE?=
 =?us-ascii?Q?ZThMyA4UMRQCV8zn6RPV4rdJuyWRtnLUe/qHHqPBMzGIqq4PFSUB1oKqAazi?=
 =?us-ascii?Q?/uKpetpGySj5F15eW04A8R/PsUaYxyCIggw+OjvaRDJo0cwadNW0/+25jTGK?=
 =?us-ascii?Q?EgXTjPa10yH/KyBmBUAqriG9RBinjoMe9u2H5BcR+oBBEHbD5A7cXtSGwFhB?=
 =?us-ascii?Q?PifemFPR5tbU86aDBm2ZynNsBMiW66UcF2FMuacOrpWyKt7BALwl01jKPybt?=
 =?us-ascii?Q?lPhu/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xNh26DoQ38vYWrHyesRPzkqdi45yGMo7KA7/BYxByTgzPS4nzPi7IByteZjp?=
 =?us-ascii?Q?UlHDB1+whNpovOGwATGCIJ7uVmvWt3eGIOtTUlwy2Rio1o2+vtAG3JS6/EkA?=
 =?us-ascii?Q?xH6D4itOxBl02bQkbmZuaafcESUV5np6I4hXPODWK6ZafHHGe78xqTk0f+5N?=
 =?us-ascii?Q?54Uk+E2s4cuqSQDJOC8QDVG9XCjiGB2s9464KMh7w2wM3UVRg5ntx1u/JCGB?=
 =?us-ascii?Q?cjugsDyccEmEBQ1qaqI9vhTP/V5Hi5KbY8fAYxsFH+jkpjcMWgzYxtZr1tmK?=
 =?us-ascii?Q?RY63pm9P0UiwQEIkUU8QqpqCYS553ZNgOoLJANw4crFq0oUn73bFVSJD0sDt?=
 =?us-ascii?Q?8LBOmfunehiA7qiBCttiLtxC8e4g0NxPU6SkE2iMIV/UYCc6YIUAg2osj+a+?=
 =?us-ascii?Q?vJhrxN5BydR6TaQIOP4w1kYqHrDdvvo29BEpqX4+BWfVf852YYp9O3gnV3z3?=
 =?us-ascii?Q?QCDoKmu80oPYucq+sqOicipVYZ6BI408Wi5d26CCXgcNztdGyldd2W9kj+GV?=
 =?us-ascii?Q?hLvjU/J+xbta4ADNJ5NoPc0K741kDmyA9DPaTn9W+IsFlf0x5uSNxXJGbrhM?=
 =?us-ascii?Q?jMmvyg+ZBNQ4+gqyChxYliBMP1ev0QRvqPqZeUDIyX99GjUsXlEz8xbtx6Ho?=
 =?us-ascii?Q?5y715dsXuVAuZ+AboTO8gyYpADpUBVo4fl0tWihHf2JpFvzacAYBEVC1tIXv?=
 =?us-ascii?Q?aj/loaEzTp+wYnggQd5WoMvtxrY8OdrcQMu7B5sHLFg7BXD9vX+RyTnLLxBF?=
 =?us-ascii?Q?7DuqeCpsfCtZEiCfbL+Dtkh+qLEjmseU5CwU3+s4GDomz2T9AL8kEgGz+5iG?=
 =?us-ascii?Q?AnBW04eSev7Tja2pfd5MUsi8Zkp2WFLSLsLjIWY4gqPd0PSlMHgEtdeEmefQ?=
 =?us-ascii?Q?kTdMeY1YyVvr0JyYZ8rtj0HfQ0a9ZVrZjea7L7jt1JydTzlxWzABMF24FW4M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c14585-b4ab-4e86-fe06-08dafa6244fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:15:19.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t2SXeAGisKmM+7/ZbUJtd9lZGFqioPX8M8kiIKzXKKzmf9DdnwMuV+V/w6/hMM5YJyQCC4L2EcpAgU+JYmdOYq224XRnMFhy+DBWYR4Q3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190178
X-Proofpoint-ORIG-GUID: 2CG6b7mzfqCGAf3OkUnxrzOGJwckAUeC
X-Proofpoint-GUID: 2CG6b7mzfqCGAf3OkUnxrzOGJwckAUeC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every caller of hugetlb_add_to_page_cache() is now passing in
&folio->page, change the function to take in a folio directly
and clean up the call sites.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 2 +-
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 880ebc58f330..76e146bdcba0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -869,7 +869,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
-		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
+		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e76be7e8df2c..2dcae9bb4495 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -722,7 +722,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9568d49c12d6..4ab3eda6db18 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5663,10 +5663,9 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return folio != NULL;
 }
 
-int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			   pgoff_t idx)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
@@ -5678,7 +5677,7 @@ int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 		__folio_clear_locked(folio);
 		return err;
 	}
-	ClearHPageRestoreReserve(page);
+	folio_clear_hugetlb_restore_reserve(folio);
 
 	/*
 	 * mark folio dirty so that it will not be removed from cache/file
@@ -5837,7 +5836,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -6269,7 +6268,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		page_in_pagecache = true;
-- 
2.39.0

