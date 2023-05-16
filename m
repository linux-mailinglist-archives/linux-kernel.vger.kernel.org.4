Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EAF705ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjEPWxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEPWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:53:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8284D40E7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:52:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwq6a019718;
        Tue, 16 May 2023 22:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jkeUqBHDu41qdjmjk4mr8xNz0NrmYLPq+a+N5WQV+6g=;
 b=MhaC+t9o5zKM6ArmwMSmvAXHdh3xoUIfgiJXySMeacBtJ1oF3HEGdFt+Msc/5mGKwhNi
 fi+KCzcXVzsBgFfd7f01jdkIkxIablI8yDtXUTFNyWjhJr5X2n5uoxRz6FWzrxCDG/kO
 hOEkZ6GHIoHWQiCCEyhfWxZvt84az7OtF9zJgmHK7Y0R+BEJi/FL6V1+Nx431bluSCx7
 YSy/1C2YbG5W+GTV/nzAIl2t0IkYheZNrktjw3fLlsMqJKEczF7gMd23UJrsI9yQOfse
 BWuSYJ2umtTS4vfv5Ur/LkHrC+fx7MHHhkcLg/WpM1Ln0QZZslbjbJN8xM/11K2oldDP Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmjpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:52:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKpbmN033897;
        Tue, 16 May 2023 22:52:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10566mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRQJzsPpVa7F1Vz+aK0gk4Wu7clVK1zFn3puWEB6+vTG0mCvcza3NPEIb7S+k6Jorq7lCMOTEwHgMl4VCIGuTDpxFTCG9yKJ3EdWWKe6tFvr22lpxX1TWpiH4L5DgwkyQYHVLhicTedcmP3NGWkBseEO4epMxtbjG4EgWcZEvktVWsloRp76qQufuUevfF4FmWbExDKoXhzsRA/DJNOvN3ICWn2k4MfADQ8Y36U2L1OILrvzux5dSz7HZQecNzK7eOh8WleCG6ndQKzHfnpAI52XIQUvA+WA4IZSdOBJGOVKVya6GvxXM7MIASJhJJnJG53m6ZG2meyYc0Wm6fx1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkeUqBHDu41qdjmjk4mr8xNz0NrmYLPq+a+N5WQV+6g=;
 b=m6jpmkK4Kxzpz/X1zsuhVTh3y2+jOUXkhFXUkUkeuyM9y2P4hEKC03cX+SwlNPUZewyuFpptjE+Xh6wcoqxNmx08Ggmb3qkTRAixElITPBVw57BdtQ3zv+zW8D2+6TR5xXrBxU00QcBwAM24uwEVj35Sq4dbqsB8Z3OAswMQ0SMND785UKbNyfPdBv5LC/iaoa8rw7ovVWSvW4PBvWJ/x7S/IrnkPinU9cYqa3qJUfUOVARAuFoIk6TYnKbZNGpub0NjMcAPINik59Yj1Atn2YME40wBthvPg9KxFiuB6IEKis0ggn3XZ5TlrH1M9UWCDQKAw3JgGfAinRWALrpSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkeUqBHDu41qdjmjk4mr8xNz0NrmYLPq+a+N5WQV+6g=;
 b=fI8w2vZiY7VuTsBx1JjfrGTwdfdqDk2ZDJzRMIqDH9DpD0IUbrM5CBoCALbGCxYRPiHlSe7VO48mLfoqfI0xVx4hja2Hm910td6N/u2I6+1eKIRFymOWoRsIUVMYwdxR21Z/N9pxJRWAOTKQmmWLzPsjcaRNsPOqePEEkKY4Vn0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 22:52:21 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%3]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 22:52:21 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: remove hugetlb_page_subpool()
Date:   Tue, 16 May 2023 15:52:05 -0700
Message-Id: <20230516225205.1429196-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cd2a20-a149-45ef-ce6d-08db5660353d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb3qSuhjyq+c/FafeF+KpN+YlaQKrvAV247Tcq+rcRvOyhdvfVIwDSpUzagAEJz1rHvdsIpleHp1gp/GCPYKqCNU4VrgUEUZ4NseSwTywTiUdYwrR62NBte3pY9a3fGpixv+ktnkpijnIGCUrgDGh97pN0bnEMGS89uFYitk3vqLKI+6I+52MU4Sgden8UzeR48OWdy5b4uOfw807qFBgLqdksH/vbFVU1ptbkRrBIiSeyc0UE5Lj5HBuyytDhsYnG1PUUlBzJjtT4PFO87V/UICA1Qe16GFHso5OABhwmtvbUYo/y4cbUbyWjJOqwWwRU9upydQBKFxTUVzZd5Yfdwvj7V5wWmrCfbSXNpz2GxNKNP9vNOZcn8CXnhqj1axjzMkk54TWbcQUDuSGJpgJrNPWOesF8WnY1s0DBEoFKYzROzq1SghW1N+iZvDS7d0h3QndjqKTfYxE+j293aMDGq8bSoZxRqHV57n3ygiCVlW9pupkx+lieFvIZPxxb9ToOlmmz7KRkA2XjmwbtiKn0ZfMw2TjfCdnPZMQDoV/r8f1LQAGG7O048LSgTYxfCi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(83380400001)(36756003)(4326008)(38100700002)(2906002)(44832011)(8936002)(86362001)(316002)(8676002)(5660300002)(66946007)(66476007)(41300700001)(66556008)(6506007)(6512007)(1076003)(186003)(107886003)(6486002)(6666004)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IfkP3RFh4OoYdisG3S8S8YIj8X0Cpbr5tUL99jD2NM9joz1zjJRI9LZWl8CA?=
 =?us-ascii?Q?H+Mhv2maHTloIT4UkDOb3/XsE0qZtL+yZpV/Fvzjh1cdcvQW/pITANY3BW3X?=
 =?us-ascii?Q?HD46/KbwQiELXtosE39TsSCv9f+xPlL5wz4UB5mgp00USPZLSrR5QcIxB/WB?=
 =?us-ascii?Q?Yw9OmoeB4a9S/XbqULxzsOCkg0DhRXRL2vJJHjNRrUxcX04jRkpLg0v23G47?=
 =?us-ascii?Q?eVO5176FUIAh/nEFAtD4V5QW+AiF0WUZiAP/V7ZLXPNdOTWdQeaxD/f8mH5f?=
 =?us-ascii?Q?z21GEXYcn8/oxdYgmIKdmgxw+P3IwNrKGjP/YRHc9TYP0iFioumvEkCcPf+R?=
 =?us-ascii?Q?CJtP6Rp2bEo5iU1rKpMLIbnrBz55jnbdEAyvgWS4gQJDYfskrl44S0VBRl4z?=
 =?us-ascii?Q?mA9JJbAKu2kHy1FfobmJKuVSF+V6QblEp/o54FYROCZUqKsu+Yzyuhj4efRr?=
 =?us-ascii?Q?1BQad29BJkAweUmXUnk/57k99qatkfr02xczGfOcIT6yKUtvB0v9Q8cup9hk?=
 =?us-ascii?Q?q/2Ar9S+c5nYLmyVe3NlL+Jb7HBkNfEHZHL/wR9prgNKHYoealOD0Fd1KiyC?=
 =?us-ascii?Q?XMoe3rthg1pmVT7cISSH+le46sR5Ejp+ZsI/LFEHyeirAxIj8ed6SzreKytH?=
 =?us-ascii?Q?JdHaPd3fa0YvalcHx0+PHYpsvTuNBuTOTJSKaFPvEc4Xk47NOwen+X1jwLSu?=
 =?us-ascii?Q?RxEKl2vsydEFPKMi2vvtvuyzL0MYb0+TBt5QRApxgJNl07fPsCaNzJmsWxb7?=
 =?us-ascii?Q?FnfXrG4xVbtjYXf8uMhuZua1nX6Z3ncRaf0pLQRRMynkUBn4aIEx9w5OS7Ec?=
 =?us-ascii?Q?JTbJrvjI02Q6xlcbBtyQ0eBJxUGHiWZfEwIfpF8P0sLqtuXXlB540X2hUWgg?=
 =?us-ascii?Q?85Ls+c8voZ3ccqhFMq1KyaZYaX9v1kTLHrtslcqAmRQdiTIyTufY4WLhE+k1?=
 =?us-ascii?Q?qIkb04PVYBwQNWrLKkRLY6d1E4y2xVrF77rz/DIxTgjUpLOhYzFUCGEkibVA?=
 =?us-ascii?Q?mqPQqHLPVmqvxS0q+EITuu0AuTVpOwPTN/jmTL6gbnV5DpSecd9TiSFgpf24?=
 =?us-ascii?Q?Mdy103VZKnyc7TMiFNXO5GWo9hXSqFhRUL/zVZEfs8SGnq5Ryta2ISJxcEGS?=
 =?us-ascii?Q?Pa2BZvdRndO44cQvVn/I6C8Ni2bTd3/X8uOz/3iTWc1NPMGBb+wq5BH+luke?=
 =?us-ascii?Q?zlt9Vl704mcBEZCb8csTunYII53MaBUKK2qhOeDA+M5NIH5rgdmODqPbnKtZ?=
 =?us-ascii?Q?92DGvVC4/fZle845EQjUhCOL7PE65GxSB7JTNOwvtZ41AbbkWFIPyae4ScFY?=
 =?us-ascii?Q?c1J3bLVagyBHLiGmlCnnS/RkqUTIZINk7anIVhG+yIKuyw0knv61EMfF0eHg?=
 =?us-ascii?Q?Sb8YSUB3dxrBQZYhGd/zZgmHTC2w33VcAf7HJQt/DFT8jQ5mkg+fuiV5AuDc?=
 =?us-ascii?Q?ZrDnVnHIjxH7l7faTHTiqnhVyw9NQ4yHcdXXxI3Wq5dESQwKozUisvIDyJn5?=
 =?us-ascii?Q?UeKU1kDUnsOJnMfg2P82JBkbhvcHGuwl0nQUW9EepLaaMFgKyMW0xQnaG7PX?=
 =?us-ascii?Q?ApyDUD3a1Z9Vm5BcJMYYtLWjLJ4ch3hjARmLgiDNhLq5tItimcsXjdBcFIhL?=
 =?us-ascii?Q?LmyU7PwHQq05iMj0MPiLnoR3E2wNU331lPmnl/8tJ8gJvqS0p8a373wJ72o4?=
 =?us-ascii?Q?Ae56cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4CoDbYnRkcZN5ET1nn6K0S/7yrWZC6TYf5jrf1SgBvWerUHANkP988dFrCC8?=
 =?us-ascii?Q?Jy33nbIhmAT0OYknhh14UAtprnF9OWOfwJUjnNEJ34m7dJ7xMTelYaLwn+q/?=
 =?us-ascii?Q?XTwV6y+5kL/5K4o3cqK8K0/QderTIqKWjmWdhvUpPbiW4VMu84jvv2oPI68e?=
 =?us-ascii?Q?uvnxSRzeaAC4bGzwLxY73wTtg8mMeLe4Wq6RMrohsjZ7r7IruIIoslBkJAwx?=
 =?us-ascii?Q?SLCJ0sWuhUN6dry/DkkYha+zJ9L3+B+6j7DAsOHHCf4Rmtsw6EyycAvbRSJG?=
 =?us-ascii?Q?sTVaMCIyoyfgj7Og3YL3OdhPCJQ+7FFohLQiwmImBAigCmfS9+mcm5zkx/MH?=
 =?us-ascii?Q?pzwdV9CZeoj7qpgaml+hDvD4eXSJq4qtX1jedlsB1G0kKIlyVHZqvcDfF/2H?=
 =?us-ascii?Q?f/SIXfg6GLQyhveXis5dc9OsjlAtFbdlUadRYx9SfKMFxt/EontZdUceO0a1?=
 =?us-ascii?Q?j/Ac7Uessru6dmdEFBTF3RbY5rbTco/e2BmF867bvHJ0eI0yDTmXQtnMBYOL?=
 =?us-ascii?Q?K6DtH76tZwW8OKx4LD/Uz3t6v9rH73bF55wP0OIBakr2Zu8jIfE2U7xNIEUX?=
 =?us-ascii?Q?cEbBKRHqGEiW5CdjGiRaKHfprMmcMp02BY/15ZYEukTuKyjR5NXMNAO1jh/x?=
 =?us-ascii?Q?Oz/8F92ib4ibd7hLQVeoUBftSuJwddDoZsiPFnVY3eIXDmPmqx8mWE/+KdCo?=
 =?us-ascii?Q?zy7StrrRlGAMLlKg6OmdxMa2yBDX89m4DhgJAJIZ0p/VWaiOGyl9YdpfUgpq?=
 =?us-ascii?Q?YR8HnAEKt7ELy+lGWzxM5DOrGvUoWh3ZBfUYcMh4v7rDeZp2WRf0XT4SPrW3?=
 =?us-ascii?Q?Wwc3fS0RUFdTIM1LS0nHz8lKKQsGdw0mhzuZ5YRsGFq87XSyZS9sdmT2ASYd?=
 =?us-ascii?Q?nk78ehEc2c7rBYVSqve82h+NCCJwOAH/ebM2x7Cs2LKOKd+t4PH2xmZGXL8b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd2a20-a149-45ef-ce6d-08db5660353d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 22:52:21.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLzAFnc2FoyyO+KLGwFqXPMApPmJIREKBjBLjhylKtnZWKfKJaGLE1NbJea/QIezxhfp7ucjXttBP5T9u0okLRRWvkmITb2U2oGD175vWdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160193
X-Proofpoint-GUID: k6cb8ITS6GvaQOB_h90M3S5PlnnU5DGR
X-Proofpoint-ORIG-GUID: k6cb8ITS6GvaQOB_h90M3S5PlnnU5DGR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of hugetlb_page_subpool() have been converted to use the folio
equivalent. This function can be safely removed.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b2b698f9a2ecb..21f942025fecd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -755,14 +755,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return folio->_hugetlb_subpool;
 }
 
-/*
- * hugetlb page subpool pointer located in hpage[2].hugetlb_subpool
- */
-static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
-{
-	return hugetlb_folio_subpool(page_folio(hpage));
-}
-
 static inline void hugetlb_set_folio_subpool(struct folio *folio,
 					struct hugepage_subpool *subpool)
 {
@@ -1029,11 +1021,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
-static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
-{
-	return NULL;
-}
-
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
-- 
2.40.1

