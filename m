Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FB6759FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjATQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91170291
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEC4H006224;
        Fri, 20 Jan 2023 16:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=n4Gq67PooHV0kmg5itzjmmVVXM1ySWT1cdfJ2Ul+zK4=;
 b=vYCxmGm5u8GNn8vZt13JzIFyKorWSf9ZUIsnfdMr0uXhNmCIcDeRLykpdfXeRhKospCv
 tLADKVL0QJ4QPkEbTo6JBHu5Zon4gGo3h2u/wDqdhUsO/UIPeFZiQmpHM+iUpVvGdHUg
 QknKNdiImssl2iXP3aP0DOZUMUwD/9/oo6tOdSIHIxEOUmtR/luBqdFg44+tdH0prEdz
 7mh0kdfkskcHW80rRDoGvQa8P1N9NyUQ8zu0GAdCx+dc2WrpFcMDx4/8vLn/cOHzU9QN
 LQG6C0lqcS6NJvlXVMMgeZ/hoPkYG/9VUGIO/Y2FyPlzV9NFkr2SgJBjJy382umhvbB3 +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGN3LC007681;
        Fri, 20 Jan 2023 16:28:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgeq8e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loAUDjiJZ7GP1iI0gMk2/DYhMR2n+X/ce+FY3TbQjWq7RgvMcZlLvOoviPX6Ltk1rtG6aswn1gXnhiCcgiPiS6P3LegilTcTOsnjW45gu4l+7B2QA8UQB/8GDv8JGU29Wf8xrGbx11wmaQdzjp4xr8Ls8BCWfva1PQzEWaCrksJK1MQ2lQVt6WMi6Q2bdVM8knWBBqmZfOnzrdwJq3r8XjvhaopOD8RO/MMBVOQEUxod/Zd8iH97H3q2Crc6DOUSrc5rE+G1zlnZnYI1pntoCtbGzwygg2A/sTmuEYZG9EB6bEXe6muNwW3kx2ZZm5iK5fn6mFGB1B9zvGMop6eysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4Gq67PooHV0kmg5itzjmmVVXM1ySWT1cdfJ2Ul+zK4=;
 b=k144uyDkfQh/sPukgqukrrXc4XWZUr76InZX9qOj34Yu/V866j6Q9piJxOdsKecX8f8cAgo4z5s9TzEjdwTg3Roa0r54x3GmirEgOG0SLkzo8d2r2b/xwcmel6IJwEOvzTOKiSegvGTYhQNqWwXNo0TTsyqF2X3dGyp7RWVRqioFjmKDp5VgovHlKWKzmmzTO8UlgiWTmWPJcIDqQfEXFUoMwUFGKFSVgRUlCCGjNY7VBAcz12o3mHYEXOOAoaGt5ptSYkYtyOskOMTNi6awev/+I/ebyh39q6/YDDQTkIlGaHGnFO7Nsg7Q+2Q1IBLYOb6UVg2e2pzQ2gTXbHSHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4Gq67PooHV0kmg5itzjmmVVXM1ySWT1cdfJ2Ul+zK4=;
 b=CIrJG/DbORZ0q05VVes+KcCQIodDsPDdeR2PrfcIZenENpmJykjALzHKvOmAH8TmaRJAHPpR+BfWDtmsBbItUGAAjRo8tkMQBxBjmkvNJOr9u1061vd69mJgp+0q0UXyBgdS64VcNY8vsYcCngybDpfY8Pb9solzsuS00ZWnf9Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 40/49] mm/mmap: Refactor locking out of __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:41 -0500
Message-Id: <20230120162650.984577-41-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff07b04-c058-490b-9487-08dafb036c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3gvwZ+fYsVK1YJRE0qIS/XIdu10kZRIBg55xvx27Xid4VHNQaS3Bfw/Htnk0uK+umrA7yV8k5KCEWEFa4lWldUot+m/n/F5g4US982vINmYYg+q/EfsCtcabmhJtGQZUIKg0h2vIQuTW138YCuoNC4bBiOwZ/zjDS4+9NFckMPxdWXYbzDJUwAZLXH2AYtR/kZH1Tp05kjK+mJb1PLQ0ZmC+o2lgUapcC1JGVeovIbUVRXxa/n4+lJs3m9wD3eOd/VcbagpzSGD2g6suNlnDJ8CWPCqTDZPIElBi/87iiIIDoIRCbOr7r9IBGKWIyAKeEvnZuZScUAkxmP2pp+ZTGF5kdu4uhN2zv2KzrbTxLpsJPpYZNHMwPpwijgHWCMtROZOvp68YNex3u9ALU7MIas/PrwzxVjyJBgQ7fe1ffA35iI1J1IBecSIVNTvhI5tViCEi4LVJhjnku3N1XbgwNI36Ei/wA6ZIA8h/eldTGi2mPeCbyHWfuoDMsiDyeWGRH0FhriO1Vo8sZTJm1SnCdZxliPGpVHN8zHFDYrLC0w45ykTwMV3rqL3Bo26J0IV94S4UoCRZWD0A9D+QhTNQ2pg8V5spz3n/O5P7swhN32B0jKKyoxpPvLmUFFm6GhKY8NbChhXtMbW5Gnr7pp+Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i66D8JMZ4Y2BkUGBlHonX1Pb/zXs+dYT13ULAoJsOy+ICjkrPRuZRzkJhHl8?=
 =?us-ascii?Q?rrOffC3xc8lHxHbrryfEgsJ+y8eV5IPIfyrTfYg8svE8u04m0Ou7vBQVoFZ2?=
 =?us-ascii?Q?sR2NOAUebKZ4388w5/QFD54FUUrTsACgZSoLiGedKNBwEa7i0d0+RZ8JT4vd?=
 =?us-ascii?Q?0HZ/yO8kr+0KUrCRNXHfmExhmURmB3XkykZbIwOYF+YHoi2lZ266l/CULWgA?=
 =?us-ascii?Q?LzGDIeULo5i2V+tJQH2FiFnUGZBVM+4WXpz52Jw9idue7B+dvW+P05njxwEa?=
 =?us-ascii?Q?AI25SkNRoLnd9No5LbGFOUhsBVgcihoBhlXHGf9bkD+Mo/k/e1htAR6JeNjE?=
 =?us-ascii?Q?TyYD4lcSZZa+7/IWFmbDwUBzZIoeWT6zZL2/w0v3bR6T9/t/qcYkD9TIW5yy?=
 =?us-ascii?Q?LY5/e46f/Zm0iUov79ximJuQ4z7xQjsqxJAljVhFV1CNZcml6KYUNgEb1u2Q?=
 =?us-ascii?Q?DNRRnxnk6LdDta0L7N0RddjIldcGTafYP3njYHZ+Z7KhzGYGm3kQUVSFyM9z?=
 =?us-ascii?Q?LKMk0aG8Wd1x6s1RC6Ty7YeBlEdOC8YixbNYnDgq5GpirOaBhrQb9oPRpCle?=
 =?us-ascii?Q?UBIEaBqi1j2x23Sjo29ItB8yQVbAUwZJzBzo1NoOYwp2+kdD6ZuiSRsDRofl?=
 =?us-ascii?Q?tWfOlem5JW15OtHkLYeMGcmAEffm0otnjYmGhrszMnwb6gfIIbBcZp2Uctp5?=
 =?us-ascii?Q?RaI/+bJtqtzbKyTVMXO0m4YPyodhzYEimaEpMfnWfJbLXGI91rRSgylVo0uM?=
 =?us-ascii?Q?izZxs7NFRp9jlq05KsRuw0RY33lbuSAewhELXQsp3EFH3OFBQZczQQW+3icj?=
 =?us-ascii?Q?TBLjmcV4dWPj1bA/b3mD3px+SijUJSHufxrue6BQ9PcGncAeQZc8fimuUOoO?=
 =?us-ascii?Q?2EVkZKNQMaeyNNmlCHlfuQE9n+OZjwVHp1wgn9eZTAfB22PRmfaxVtJVScUy?=
 =?us-ascii?Q?YY0OAfq7TpMZsr+h9mqtYldQlvD7aTduiLCi+WE7BjrgCtil73vC7qwvDWLy?=
 =?us-ascii?Q?oKMed2156zrmJf8p2lWAZ3NMgLG5Oq730MmjPWoxwylVkDsWyKgtosSlfYUC?=
 =?us-ascii?Q?dO+azGz+9vN3ip2u31LzCH+S4ilXBjgDfP0d/wAA3KrEksbP4c671D1vYC6M?=
 =?us-ascii?Q?Uqgu8P0x6gFQxCNM2aKPBAl7bJDCvuNOhxLZFJBBhUS3jaadJe8yAGIfYeY3?=
 =?us-ascii?Q?Lg2EWncNs4jr+xFhLk0khtHvYRyYKBPSXwwJruZslN+5nNhW0yFyLXNO5nov?=
 =?us-ascii?Q?Oa0jUCBEL4N5TBalmInJSV4+880lARyjVp7Jia7aqkizZjafgLfayfCSRD9b?=
 =?us-ascii?Q?VhuG2YaNh69pKbs7PM5sKKfXfTdIY+aBMrupFZhLFJp5E4bnOtvqJ891EI2O?=
 =?us-ascii?Q?Z5qhohe7f3+E1W3n3VmIqCSRtSIFb4uFcQeeTAPkmwCqHDcoUZ8cOzWR5Yd1?=
 =?us-ascii?Q?QvHvn30M/i2yzkGXX9kkF1Y1d/CQ1C+QeUG4whEyibyJ9gV7UGOvHXM/rWyF?=
 =?us-ascii?Q?L1AqCpAHbz3SoxWNzVfA98qo7JLHiYpYu0bZgUeOaJ+fd/F6iZhyId0j7j4K?=
 =?us-ascii?Q?HKzGLv+xG4Ou7BZO55eEGbK7Ur3b1vTfYiFMl0Jn3lFZjcgFi5Gng50kYXdq?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kxvq1DFtuI2qsA5iT5DW6oZD/R4gW5opalYxeCll6B9aPB8/cpx+6B/jN4qKemMRCLNLLUyjMTgvpvC4mSsr6gvDd+Ws70p+r7Jq/MUk56tTKqL3rjc4I/Esak5a358tzEdSvs+CI7qoUXHyk/AuS+lOa7z0EYezO/Aup5IIvlS1tiRh2RrG8y98VHUfLviiVMpo4jcE3BV8riUxo0ezNlFBMHinKaossNqSqkbfhg3BSEnMhtlT4Jnqz9usSiYuU8VP+apHzdchuO7qgDsmazzD1n3Sx3Q6+JLk9YJKaStmmmLJqa1zv1/l+F/RXKEelPveZF0Xugn1W+NKMHonFeWRz0LgW7gcpTKDVwerS8d92zpwOijkPDurYsQqZX1YKy8IVLLiPCeoUuQOs3OoHR0NjnYRFTzC5T1MixsD9GJ8VEh8fFk+ate6lOEMudhbGki+6mfBM3OXeiPlwFOtlXfRxGseGkehZdLiuxSnCqf7TcFi/x1m1yUfRoCuxh5qtWbA3x6V198TrC3Z6ih1MP5syEsd0aBjPxcR2zyV3g1RJ/2UqW6JguQJ5j/uLZHZPEFHBUkW5alXHNNe3vwswQ3QxYpLbMeglRDv2zDJFMgxpFxAAh3CDfsElqBxDA+BWIbcET5AA5fCKRZPpYV9kE6KZB+Wuk5ber4LI7jdrYVkuxuEAvqIt69WSeluF83ccfTvFiDjunYWYl4RbDdCkp4ZfFGEnMIH4H0oO7qJD42OGe7pPUFoSiU74CK17dJt1O860fy2ugXd2+b8V4Q1qBQE3Eq+1zt3jEPFmeAbwmSPPEwg+IPXI0RkiunKUNCaupi9pttda8bQErx71SEes6Wlk206F/AQmAmLuCPpGDtiQxJIXSwVKedQu8Ot7zT4w8bWvyx1er1J450ggBz9cw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff07b04-c058-490b-9487-08dafb036c2b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:54.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsKzSINOIjdQY3biHl1aagx1xuiDv0XowuS/mia96cO7MJqC6z695GlXOhHgpBmdl1dR4IJbQEeoIjhY6Tj2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=953
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 1O60DMNIhNsUlQW53mADoXVdqrNPCam1
X-Proofpoint-GUID: 1O60DMNIhNsUlQW53mADoXVdqrNPCam1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move the locking into vma_prepare() and vma_complete() for use elsewhere

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  14 +++
 mm/mmap.c     | 231 +++++++++++++++++++++++++++++---------------------
 2 files changed, 150 insertions(+), 95 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b4f66efc912d..bcd01a6e8ed2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -937,4 +937,18 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 
 	return 0;
 }
+
+/*
+ * VMA lock generalization
+ */
+struct vma_prepare {
+	struct vm_area_struct *vma;
+	struct vm_area_struct *adj_next;
+	struct file *file;
+	struct address_space *mapping;
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *insert;
+	struct vm_area_struct *remove;
+	struct vm_area_struct *remove2;
+};
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index b83c70c59a76..9afaf05eb96b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -576,6 +576,127 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return -ENOMEM;
 }
 
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to altering
+ * @vp: The initialized vma_prepare struct
+ */
+static inline void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static inline void vma_complete(struct vma_prepare *vp,
+				struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->file, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->file,
+						  vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we must remove next_next too.
+		 */
+		if (vp->remove2) {
+			vp->remove = vp->remove2;
+			vp->remove2 = NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -591,14 +712,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *next_next = NULL;	/* uninit var warning */
 	struct vm_area_struct *next = find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma = vma;
-	struct address_space *mapping = NULL;
-	struct rb_root_cached *root = NULL;
 	struct anon_vma *anon_vma = NULL;
 	struct file *file = vma->vm_file;
 	bool vma_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
+	struct vma_prepare vma_prep;
 
 	if (next && !insert) {
 		if (end >= next->vm_end) {
@@ -694,39 +814,22 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			   anon_vma != next->anon_vma);
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-	if (file) {
-		mapping = file->f_mapping;
-		root = &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-
-		if (adjust_next)
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-
-		i_mmap_lock_write(mapping);
-		if (insert && insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(insert, insert->vm_file->f_mapping);
-		}
-	}
 
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_pre_update_vma(next);
+	memset(&vma_prep, 0, sizeof(vma_prep));
+	vma_prep.vma = vma;
+	vma_prep.anon_vma = anon_vma;
+	vma_prep.file = file;
+	if (adjust_next)
+		vma_prep.adj_next = next;
+	if (file)
+		vma_prep.mapping = file->f_mapping;
+	vma_prep.insert = insert;
+	if (remove_next) {
+		vma_prep.remove = next;
+		vma_prep.remove2 = next_next;
 	}
 
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-		if (adjust_next)
-			vma_interval_tree_remove(next, root);
-	}
+	vma_prepare(&vma_prep);
 
 	if (start != vma->vm_start) {
 		if (vma->vm_start < start) {
@@ -764,69 +867,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, next);
 	}
 
-	if (file) {
-		if (adjust_next)
-			vma_interval_tree_insert(next, root);
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-		if (remove_next == 2)
-			__remove_shared_vm_struct(next_next, file, mapping);
-	} else if (insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, insert);
-		mm->map_count++;
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_post_update_vma(next);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-
-		if (adjust_next)
-			uprobe_mmap(next);
-	}
-
-	if (remove_next) {
-again:
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		if (remove_next != 2)
-			BUG_ON(vma->vm_end < next->vm_end);
-		vm_area_free(next);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
-		 */
-		if (remove_next == 2) {
-			remove_next = 1;
-			next = next_next;
-			goto again;
-		}
-	}
-	if (insert && file)
-		uprobe_mmap(insert);
-
+	vma_complete(&vma_prep, vmi, mm);
 	vma_iter_free(vmi);
 	validate_mm(mm);
 
-- 
2.35.1

