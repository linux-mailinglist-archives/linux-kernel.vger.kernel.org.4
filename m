Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0766759E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjATQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjATQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:28:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4551C49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBY6o020107;
        Fri, 20 Jan 2023 16:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=B5Z5xAaQgDVV9z0byqWdmhL/iAXJ2kbicI+Hv5SYR9w=;
 b=P80KpIu7qQAqwCO5RQwC6MU8aL7WEOGG690WbZYA3wdYD2kATAjdZ0UQ0CYNZtEg5ixz
 wA5pYePAQJH8seUOn4mfGQPcPnpseFDC6Cu2y8tMYyv+bQDZI0ymR9PkDDI8L/Q+hjv4
 wwjeWPv+LmuSdKTs2X6Ws5oughfavcp41Gahgpz7/5acB9qjfZEGSRFMGD+tas3pO5Vx
 TwjE8jNXqLj66RLeKl9IPqBTZKRev1VWym8os21utRSrYtmI+vO1uw8LpbXTzOKooEdh
 KJqWu8AM8p4G6yYrbkhFPsyMU1nnbu6ZQ9TPYYfVLtP0L8VZ+JdG73URN0K2zaKK9JHn XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw23d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFRFt7004673;
        Fri, 20 Jan 2023 16:27:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1f5n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XthdC7JqIy4z54BXO1ljcAB+Wnata9Pqp4RoydpQz5aXhVxOiB1kPA2HTlLoUSImuROaPz+B8zHuazrDzqp7J4jVoW37xxAXyTjukpQQxQoxTgzY/OhL0fUFPi27VxF80ZkluclPpnEaO3LC5KLlqUR7ldqIC4T3x0PJowZw0nNdDqvN4IXYuaKEymZYoooNNyEZuu2MRWe/kBFQLZxnea3bCP+C+1UPqJTJ+dFXu/30GbSP2kyf3KGk1AFaSwt63+A3+i0YkIoXQeYQhFluKo39kMqQ/sdn4zaMJGdCKHAjrzIFbQEVDBuxL09kVNsJ2ofTKBRg0JyvZYlN9nywZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5Z5xAaQgDVV9z0byqWdmhL/iAXJ2kbicI+Hv5SYR9w=;
 b=Jo0RV3YBDzIzaSHDbkusvS+71hFlVs+/gzIO23oQUcBUYc1RCORulRm2z/qaEzh99Xq5BAiU9VcC5Hu3NOqKqibzMWrbDCSHUTYjhSlzLF9xttv5IFsVQqirfZdYDGHzLKsoJe0ICnjs6OFwd6HQ+6RNBpD0JLcLLa0rMu+ouWl5ZCWVZSMdxnQckU0QLceMMA+2I8Yv1xmLBPrbJBYhluOOs5o640kDkBMAVVUWqULGoT7Ff5HrfOm9ee8LN25/uimOVucDt7MhIkydH8NDFCrodYE7PhYx9nKiSY/7Yy2+xTXTbOYyMzLj3BBvgNxfASGZ1JgQidUZzQ5iYWBO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5Z5xAaQgDVV9z0byqWdmhL/iAXJ2kbicI+Hv5SYR9w=;
 b=cf8rKDbSW0sAZFXrOmIheI/eYmKXvy4T8Cep5/964MTzB1Sl5eFh67j3LFdjyMYYJdXIKtFKRfRWxg9X+e5CYydV6sbHixZ3nfyccHBGk14lu9N9+6dGRWhGyozjTxD8Uquw6o2TsMRuNpIDgGW4NAeVIcTIjrV8jGNGs2Z38hs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 12/49] mmap: Change do_mas_munmap and do_mas_aligned_munmap() to use vma iterator
Date:   Fri, 20 Jan 2023 11:26:13 -0500
Message-Id: <20230120162650.984577-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5d099a-db31-4587-289a-08dafb033fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZOdZuBN/cwXfCZ3bHcxG2oBlsuax8wzlKFrio5cVulUlw+oG/TYtLlooPppKlTOArhrspCAsPBY7p6SWfOHabxZu2oXyi3NDefiyHqyR2GwU65E/nJ1vdD+RupE6rBbj125nvPHfAlrmBL1zaR9lMXFzGhn5uXEiE/yiPGhSl+/voUZBKJGbtocxWOTxolEONpxwBeUUNK6VC0jsE84DxXzFbk2XSV8CHiOoWL19Fu+TCzL30eJ+Q8Ki6VVpTIah2gR0SL8XRgqOtLENbhIcx0TN1eeG/NQDEy5t1iM4+RSkOJbVASw1l1pbBG5pPO6yy2SKMP6feWQiCRQAUep9lU+oHYCEOoTL4vSw4oEG1a3Y+ynNawRxi8vx5khov6NKwfPnSYqO7WCLga0e+/7C9+MYjPR5Ad2l0wI7D3xvdBjuTUEkCOWj5NTRmtmEhUb5pq3Xj34f/6l68eCloGM357cgxlwXm+pmVFlhb4Sl9bnQBTOdVffNsqofVU/atLM0+uFQbKxA5fk4PQIQCVspqiEYqKX7higGu3H4INDqdvelXUq4tKmhWh03ytCyIpUX5jk6QrMCEddbNN5MU1oB0nzYRcWy4fpnvSY7ueujtP3kRylNBss3pMqLHST/VG1fZ33N+Yjs4yXSCBu1ShX8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(30864003)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(66899015)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Q9GdXWS5EaWpi21tzlMKVBsmoHtEDfVQKQmjhZ+JJLOgcsxowx2TRVsArZ9?=
 =?us-ascii?Q?0xUmMkY+/InrchUpwtQ4S94d++bugx4nmsLvdlH9wspNPSE4vPV+h5dih6Vh?=
 =?us-ascii?Q?qRQv6TaZxf/XpXYqKlQuzxvT+aPMMFmUsRm4HlHBCxzScva28xj9NKpfh2bG?=
 =?us-ascii?Q?BVIhJmCyFLuWzVdS+HngC/VM+YvaoGHaYpl/qUBe95WPtPtP1NODj08fyYW3?=
 =?us-ascii?Q?vXZtcR2Hi3j6PfHnPfwnqe5zwPHkcpgcxin/OXhqO4owRtkv/uPSirNWeQHc?=
 =?us-ascii?Q?EGNiNyy5mDqZISsFEjktaIqAAqz2zUe8HV6oP52u1Q1ao4YmkItfXFFl9cl7?=
 =?us-ascii?Q?5G4nvEInF+1m3mjnzyMYOmBLjdq2SeFe5jeQyEoPD0L+d8ecOBUkiiGrMHAH?=
 =?us-ascii?Q?LbafMS7F2UszlHRoidloe6iBXBMh2c2Amt1izw/9C+td6Npewwpa1pTXI36b?=
 =?us-ascii?Q?cST3pFZkoKdp4T8l7oKwBqDYnRE6OEMFgdluGIDVJAgnj6uSX/OvDdUuLdgP?=
 =?us-ascii?Q?aJJD4DHmtu3I9KiNDPOUsCKbmJdKUDkzkcxa6slyCJiMpwSzjJTV/DtgkBVz?=
 =?us-ascii?Q?2MswGJj24QEKquRb+QZYnNYslJkf5YIeB6ilnaj+8fALygNZIMOzmIazzeQR?=
 =?us-ascii?Q?CSA4NKj39eICPCR2VQmz94WyhZjnfbKJMJmvwqM7cwk1uS9lAvKoGaQ+DjpA?=
 =?us-ascii?Q?kAxdw6ZJ9ToQ/RyyOAlb2p5XGmPE3E3JD34RbitMc10sw5vNvLKPb1o3ACgt?=
 =?us-ascii?Q?Zo/sQSlxp/Swj3gTNdOTo65L/jIkYXuyfT1WoYYluzUN/TVjs5kFPpQZ/DwD?=
 =?us-ascii?Q?nGlwRTIcqIMkkxHIuvHBoJRtKGISykgFCSyLabVFPaPQfyhCVtgup0+vqsqV?=
 =?us-ascii?Q?O6kkURf6AOP4i9OVrTcUIdxzVuo98Clv39Z92eSijAu8BRNqQmoUkT1t1v7p?=
 =?us-ascii?Q?nQbdZa0DYF1UkssDTtSEOmpmJGWhvuWfkkfqJZCBnUgbFHP8OJPDVhM5KUi0?=
 =?us-ascii?Q?iBFywK5j6ttGxOoWpSx8dkGfLdaLgZr0kDIYyhfC/dMjyLoSBd7yVny+9WdS?=
 =?us-ascii?Q?olq91o/04/1p+P3LhSQJDsBZAu2cjbXFlXWiPAKpuOjFoJMteqmxF3WZw9i8?=
 =?us-ascii?Q?N2aW6NNyY81ciTlo6sABasm5Y5XY4ZyKFdnfpr48sEwyFua/4u8LuGIMHmWJ?=
 =?us-ascii?Q?SLcGjxfSS/Xr5g/sIQmL4VPRovPV+Wy/h/v741fUtulJoYUGsacGqMJHtx+G?=
 =?us-ascii?Q?ZmMFwq4LnPvm/e5SkskYi9c53aJEbboNqNwLp1sDf3ATmkm3wRa5svKE6GPD?=
 =?us-ascii?Q?FbHaIxleqJI9gLs6cOyPL+NYzwbQb1o2xDdxxE3T2YQ2PJICsU4u+EOusZOc?=
 =?us-ascii?Q?nCdeE7TwY30YZWXikUBDmWYTr4lWqZ8WJ5Cu+TZyYHq6LX5nxUKJrz5eCPap?=
 =?us-ascii?Q?C/uMc8AKG0B5htyPGZo7/k6S7J71s+TrdcODfn/5dYnrun9II+SbN0xt0Xkl?=
 =?us-ascii?Q?aw0j319KsbR+OpmdgMbNUWOQOBx/b7wElkA4i4x7jX4pcNwx7K79hgoe0eV4?=
 =?us-ascii?Q?l1pSfidkda/20lYeyBXmJ9zuoWjFPYgiptuSxvB7OXdxee1BnNEd9VP91XMQ?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7G/Ac6jo3dgnMBb/AYMxDanDg8Kovy7txhcz4LtBHGvIwz0aM2X4r8hWksKhtB2hnp4CErdbyb3GiNOh1bkr8XVZZYbuJ7ghionBBXC3kLrhxPSCkEqPIYE7JY5oaJPdLNUPlrMDz5Ex2cWz7Dlw+Zuixo9E7EarHPikG3y+46+KxleiPMVmjYrV5MRaWfHux8ytNXKSq1KqNcmZQj63j2K5/S84qkUnZIBtfdPSH7IgZY58LMdJZhsgu0mUr72xbW3Bvc/fE6z0pAUsKsHFq4eGO0HMdxZoOZtMpZAgTwxpWDi/CSqGquswRJlMmV5sDEe8jZ2NG3M+b102aKBQuXTH/thAm5443aj3WZ/YhRekyj3LcSMMBejTOYD1u2HauDlxRR8HTaC1GLGn3+UWYcelfnf37d8djuGZRSyfBl3nxH+WS1l8tcHgDZejHTFfrvqm2gy/lgYPqaD0YbPWlrpSQDzVuTidNZI4tIUwdpYsZFdVkZOze0ifi/Q2Lauhp+7GCaPS+LDMzGfM8prALN1tp3/DRV+R6TTOu/A45JempqL63whV2wo2R0Ssq7+TvC2oLzVjov+d0RgVgwAu1W8w6Vsj1VgjreIKd/byEm2IVz4marpBGd09thut9Ud4h9YVp4HzcTO1z2TPk030Rx9FZfTSS3R4TcDDmBteDFqWG+BW9tJurslAhx9/KoBAqdbIhyOySLn7yWs3hXfrYwpYcxTe8xgGXrMQRg5KqeMYma+7evvR8dfJ2J+fwaARgxMz508QZgtEC3flJom27xPiNMyE3aGLYe9GFP05DPosQiPKnwQVVWT2Xdlx24OeepL6OGPVAws+f9ySX9neSwwfLPMZ9Gsn/Zj9AKkZaMc+nv8ejpG5iLwdoMP18OuZBGzjxdyxg1kLJhqZo9gYSg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5d099a-db31-4587-289a-08dafb033fa3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:40.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDuTPwROr5slTpbKbbc+TAhpLMM+uX1wbgH9eT0PcJZw/rDj7wYp8uwFfiZN+HS5r6NYGs2sg7fTfh2Fy3Ua7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: QXcwfQ5UygSGc6xtdKXAjO8VJWIewBQV
X-Proofpoint-ORIG-GUID: QXcwfQ5UygSGc6xtdKXAjO8VJWIewBQV
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

Start passing the vma iterator through the mm code.  This will allow for
reuse of the state and cleaner invalidation if necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
 mm/mremap.c        |  6 ++--
 3 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b977a90d9829..152a1362b800 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2905,7 +2905,7 @@ extern unsigned long mmap_region(struct file *file, unsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
diff --git a/mm/mmap.c b/mm/mmap.c
index 83d25fcc2f6d..18f5f71a9202 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2305,8 +2305,8 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
 }
 
 /*
- * do_mas_align_munmap() - munmap the aligned region from @start to @end.
- * @mas: The maple_state, ideally set up to alter the correct tree location.
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
@@ -2317,7 +2317,7 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
  * If @downgrade is true, check return code for potential release of the lock.
  */
 static int
-do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
@@ -2329,7 +2329,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
-	mas->last = end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2349,27 +2348,23 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		/*
-		 * mas_pause() is not needed since mas->index needs to be set
-		 * differently than vma->vm_end anyways.
-		 */
 		error = __split_vma(mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
 
-		mas_set(mas, start);
-		vma = mas_walk(mas);
+		vma_iter_set(vmi, start);
+		vma = vma_find(vmi, end);
 	}
 
-	prev = mas_prev(mas, 0);
+	prev = vma_prev(vmi);
 	if (unlikely((!prev)))
-		mas_set(mas, start);
+		vma_iter_set(vmi, start);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	mas_for_each(mas, next, end - 1) {
+	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
@@ -2378,8 +2373,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 
-			mas_set(mas, end);
-			split = mas_prev(mas, 0);
+			vma_iter_set(vmi, end);
+			split = vma_prev(vmi);
 			error = munmap_sidetree(split, &mas_detach);
 			if (error)
 				goto munmap_sidetree_failed;
@@ -2401,7 +2396,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	if (!next)
-		next = mas_next(mas, ULONG_MAX);
+		next = vma_next(vmi);
 
 	if (unlikely(uf)) {
 		/*
@@ -2426,10 +2421,10 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		mas_set_range(mas, start, end - 1);
+		vma_iter_set(vmi, start);
 		rcu_read_lock();
 		vma_test = mas_find(&test, end - 1);
-		mas_for_each(mas, vma_mas, end - 1) {
+		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
 			vma_test = mas_next(&test, end - 1);
@@ -2439,8 +2434,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 #endif
 	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
-	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+	vma_iter_set(vmi, start);
+	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 		return -ENOMEM;
 
 	mm->map_count -= count;
@@ -2478,8 +2473,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 }
 
 /*
- * do_mas_munmap() - munmap a given range.
- * @mas: The maple state
+ * do_vmi_munmap() - munmap a given range.
+ * @vmi: The vma iterator
  * @mm: The mm_struct
  * @start: The start address to munmap
  * @len: The length of the range to munmap
@@ -2493,7 +2488,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
  *
  * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
  */
-int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool downgrade)
 {
@@ -2511,11 +2506,11 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = mas_find(mas, end - 1);
+	vma = vma_find(vmi, end);
 	if (!vma)
 		return 0;
 
-	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
 }
 
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
@@ -2527,9 +2522,9 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 
-	return do_mas_munmap(&mas, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2545,7 +2540,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	pgoff_t vm_pgoff;
 	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	VMA_ITERATOR(vmi, mm, addr);
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2563,7 +2558,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
 		return -ENOMEM;
 
 	/*
@@ -2576,8 +2571,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = mas_next(&mas, ULONG_MAX);
-	prev = mas_prev(&mas, 0);
+	next = vma_next(&vmi);
+	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
 
@@ -2605,13 +2600,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
 
-	mas.index = addr;
-	mas.last = end - 1;
 cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2650,7 +2643,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			error = -EINVAL;
 			goto close_and_free_vma;
 		}
-		mas_reset(&mas);
+		vma_iter_set(&vmi, addr);
 
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
@@ -2696,7 +2689,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi)) {
 		error = -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
@@ -2709,7 +2702,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2770,7 +2763,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
+	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end);
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
@@ -2787,12 +2780,12 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 	int ret;
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
+	ret = do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2924,7 +2917,7 @@ static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	int ret;
 
 	arch_unmap(mm, newbrk, oldbrk);
-	ret = do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true);
+	ret = do_vmi_align_munmap(vmi, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3047,7 +3040,7 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
 
-	ret = do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
+	ret = do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 05f90f47e149..3cc64c3f8bdb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,14 +978,14 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * do_mas_munmap does all the needed commit accounting, and
+	 * do_vmi_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >= new_len) {
 		int retval;
-		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
+		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		retval = do_mas_munmap(&mas, mm, addr + new_len,
+		retval = do_vmi_munmap(&vmi, mm, addr + new_len,
 				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
 		if (retval == 1) {
-- 
2.35.1

