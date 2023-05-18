Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BA708477
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjERO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjERO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC73D173F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrCb028533;
        Thu, 18 May 2023 14:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jgzmmTEKWB0i9WIDRw5vqMkC751jSozh6uHq83GAlk4=;
 b=VC2L+VcrC7WzM+4LH4i8df29aNJ3iplg8P8ZbAOqAkBELEb9Oz9A1O/cBgj1tOAhWzPw
 mO4Ejk6QUEdFNqsYVD341lM/NUUlDShibj1eF/Fnua+/eBaYMZWu4mDVr3b4fO1cHuO/
 +ysgPLCIGVl1zIbZ/c2STX1w9kV5FfARbvCcuT9iMnU6DmLhmTLsUAAzbMKhUzuMo691
 uYSjpHyJWnXBoEM76MJOyxdEPFRGwVAibrnblKtRx+TPak0kPKOG4SSpg10cVbQZU5bg
 fiARZzriec3xOI8tQ/BTSaG9ln1P0DmfvNIh63uWmfELpaTS4LszUovjvknGTSUx/5nV Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc8f9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE2jRt025047;
        Thu, 18 May 2023 14:56:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106vmg2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqYkF1GKeYgayPmn8YAtC9CXx3d9PKt0yT1SPHbSH15iMOsHcrsXR52N0i6X4X3DegpKsE0bSKF60gEzFInnUNGAouVEFPoroYHBG1HO1aYbUGd7ikmhZ5ZjcsLXESg+8iQVBzOph+SPdGq/o4dMXeebNRr6Q2QomIwNWzHptBs569/bjWAhNZzIy7wqln1pcYdC0SN/mUURJWTnSpVEfa3pdqFnrlAk6cQeZCS7UOBVHoTGDO6XcufyLminaVsq2uWPFVDCmxchEVeDlt/GOaqfyQoQ+GRn/CbRASOrLyONkSjk2uzuMLstFruc4z9jpFo6yN9/v03sjRuTYoDSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgzmmTEKWB0i9WIDRw5vqMkC751jSozh6uHq83GAlk4=;
 b=f8maN9mvqxHhKFko/bHRuD3WWmmo7y5JbdaRrsWXa612QAO6gc/Tiq0KXfgpw+L62/hZjdjIGYNVu6CTV0nyB9b9G1jwpKPsaL3FyYxL5EKB4+UVtrhxmLbDW1v4m4znZTmIvIvk096qDXJWzZOVko1U1tM0E8z5MjyTGfzHjciciLo1HwRZWJ4rLOahnu/cspShlJfFkFBc81Y66PeQMHnbCJJsTVFYbnHnbEwrLn+fyh7rPG55WTHoYtUpJurWj6hh4JCByu/OqlDaIyJ6Suet5I5vw4q7W8IKO2wW8LCP+YdKhYGs2tLaiOSWvnxZn7tTDJhAmn20JhBBZVUxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgzmmTEKWB0i9WIDRw5vqMkC751jSozh6uHq83GAlk4=;
 b=0R8BP09wa2lZAJmKXApwO6FiUIOU1VVCQeQ/fAV0aBv+MVNoEpYhvtShVlbyWr+cuHzjy5VhKQxSdRYq40HVjy6BiFHB+jQDjOv7VQYyGd/sTwFsyjKuWkRaExusQut52uAMYAMUNCp5YwT/f+mIpLbnnlFjuUDEd3eQj+9FooA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:30 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 17/35] mm: Update validate_mm() to use vma iterator
Date:   Thu, 18 May 2023 10:55:26 -0400
Message-Id: <20230518145544.1722059-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: b43756ac-f4c4-49e1-bedf-08db57b0102b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLRnoW39v3Q9ppxPaQKXOWfYQSlOGmWrly3JVcTga3lKimcA7lq3Z9e7BdGLA7WCNt9oyoHRvmUFKRoN+N1v2/N5zKFQofp6xdFkSJz9V4l1+dwXVjYtTxcEPSMxP2XgOc3fhV0P6FAFzort/0AzyfhuhoeI2E858xnqV4hIucrl/ISmxO0vMiceUwVT/4lB/A5k3JK/dwTJwpJFiflmHsu00ram/4CtlOdzuBAwZBm3S6/HiCNN3OhijNL4dAgRXouy0AMpCFalxclcctd4NjGFrSRgo+PChKs88venurnZf5CibxTpDpsAsT6C2GeVVpwkCRCNgSDNn+88sscs3S0pF94xSNxsp1Hz2GtYTfLiFqIYtGi9/rTVwj3CzneSw/LwF+C5qAGc2OW5NDAJhPjnrV4q0hmX68apZbRjhDCunm6ZIn2q6iUCCdkov/qvM5qSPa+zuUtkWYXb9UCw6sIwzoyk/lVim2tofUKhhOFRJWOG1LNsgUt/O0r4sq143H/V+oKR4hlFVlMc/2Dc9lRg2bHK2m7MfIlgWuu+C/1+lJp/f3Q5a4qBr6727n+g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JO3nxuezhTFc78H7pJw7yssS43h6TSe/rKZp4PZ1LigUguiL4sG8lA2516tB?=
 =?us-ascii?Q?zI4ljq2Uu1gchBS8C8OQe6KCgHqgQqU6ZAVe7STKd5+pG1G8lTWJ30c1itP+?=
 =?us-ascii?Q?TJLZhF11ex56hYHK+a4pvD48nu0sLRINhxyDbyrDLt9RcPyuop3P4OtCwfQh?=
 =?us-ascii?Q?YobSbmGjb2Ain+RrnVIpJOoeejhnrC3rJjLC79AZ+2sLoe31OXka3+ZRzyb5?=
 =?us-ascii?Q?6K2R78QCB6JdxR9QLIraTfNntZDL2SwX5AHzctC+VbrA4bPpk728R3NY7xa8?=
 =?us-ascii?Q?VEWNJwvBCBH/0yhybkG/P2EJ883J1lFvXcjQh0esHDtvZGXkZtzYOkmEgT3C?=
 =?us-ascii?Q?9uW96+QJzLTnNC3+hyWpGDIOxTvmoUhWeFJGyh87TFpdpZT4rO5QGewEPs1S?=
 =?us-ascii?Q?hSQoKn3BQMwHv2cTBhcXl7InIOSSt0Cf3xlOl+1qRYFCedLx08oxbS5ZQ883?=
 =?us-ascii?Q?nGaS9PmXrrDowOLkY5eo3+bQ5jHqt6f+rZkuMam9LxTHSIcr/OAxqj524ngX?=
 =?us-ascii?Q?rYQbafUXAHsmmxYp9EU6kL+8QlnZ1Fo/CaGZt5Y3OQYmK8Y8yQphDQLe9e2r?=
 =?us-ascii?Q?PaDa20iWMVj/aQz+BqoIQNBcGqSd8cN9mhlXdSDBJgx3DUIppAtETztcalTb?=
 =?us-ascii?Q?o3aCVhaJNeFqWNAGra+lpIVU6+CFm+HI66BeJBeWaAqHDmssFBq6/eFwlWkZ?=
 =?us-ascii?Q?6nyR9hCcyUSy5F5Z2zn2LzaW1o/e9/mhM+Ejl0sAoOvIQUQoM1kHTMkviTh3?=
 =?us-ascii?Q?9NCXJKdnoXXl9iUFswGWo3gbx9kaKjMONjdiC5fJazZY0Y3/7v5sGNhwUy+V?=
 =?us-ascii?Q?wHBU2Ss0GGhJFGQOwuwakgk3iUnew42Hd8IzOJpAqyra0KQCiaGQLNK7pjAM?=
 =?us-ascii?Q?GFJ+X6AH4UwEliwroS8iDNFg0tC2/kt2IeU4KLRbekMG6Y7wZyKkTn9bQx7w?=
 =?us-ascii?Q?VuAJ7w6nDCfgXhQFNLX8QLw+fKhexafbFe5HMvSAgVdruv3QCf6grSGfCYix?=
 =?us-ascii?Q?MSphFrLiktiTLo8bcT6XeMXAQB6Vk3GsJkYAO9b+9w4NUAOni/uRmp8yItcX?=
 =?us-ascii?Q?okaM7kq/qJmICDafccBI2IL6h0SMj0pb3HUM0B78RObtfO0y7AZp9PIR0f08?=
 =?us-ascii?Q?M/aRDJGgrN0TwwkBkH8qiRXRxlAXPpOLnV/Dcb3SCOY+nHCsaFqchN0QmzP9?=
 =?us-ascii?Q?bWWy8efuSEfwJ9x+37j/8fKlzhts+nijBhJ67EvoJr1ldPa3Rs+yOTGDjdpD?=
 =?us-ascii?Q?sA+QsvMIP6c2Cd3fRFqj8h4OAST73cPrbMsVWXWjJHBRi0j586rfUiNG5KxC?=
 =?us-ascii?Q?7Xo82b7ls9FtDY5BuO6bGIYTY6JEzPh05MDRy7Vtr9zGpe+kGNClPx28vgbF?=
 =?us-ascii?Q?0SKMmEXND/GTG4SJorp3BLMyGftbHhouJvvFZeiCvFtfotbj9qeHfJs2H5vx?=
 =?us-ascii?Q?vUAEFoAaOi9TCl8NCoPBb5XFBRMXadh1KxrzHONSyVhhF2k+M/fNqDGxZe+8?=
 =?us-ascii?Q?o6N6i4uSD9qqQLgsg026PDuB5Pks1KtRiGqHgz88F5qvwYWARwD4IBGvvQQz?=
 =?us-ascii?Q?KylbugPXcM2itTS4zlpQma3CgqqVzHPGc0iobebR9XsVYiE521QtOFdpAE/A?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mGuAUgGs21mawc9a4GbGtQBT7H//01Es/wUVbgzRa5lZkkEKez+M7kOZsxtgPt08l5YG/w0+DbgArkW12fqMgZ/RL5WgBWvTOh5XYpjVp8O2XxlUWgHWcgiOvZqz2PkjrkWYbQ8FeKVEoYlKDPzOTBGnNnIFyCaXdHd58k52cPjJFD1LXPnA3VBhSQ74m6QDjZhvyEl9yrghQLe0MEWe21J3qbz7JMOnO8hex29Ylm1YIGwwUuF/ft4hM2uPZWe1WDWfyB2TM1MGnR3DTEmeQegyZMh0/lLd0Q9brft6jxG6QIGldC1+3enihDKkOiSibM4U2pmcgjUkAo1GnEhV7/F8m35BgOVIuAPqs+3SCorIsjl2s+QkGaeSbF0v+fEfIWM/Gu8pNEusUq+qraWl9/C8iw+ivFjHZlDbvE5b3GmB3FKtbU9k6q0YUJer4YBuhT67uf3b6pLX0LonEFQhq41pmtUFA+Zy4cWTfXAnJG6UxH1JufdCDJ7Ee3jTmeHTrQNeJJnzKwBj0MiJo7cu7oVmyHShL/8PAZFRuSTyigTA5dzs/1lpSvTxdcLaUtBplSueLXiGCONfBoBjZ8KQqLf7MJxAReHmjHeTCgH7fZMMVjk7SG50KxRHJThe9UQ7lkBCRbVG3ohr8bsE7JrnnP9+qptngb+5Blr7hcwsJzx3D9o8CMMXEbiChIuZwrlkT5FQ+t1uvF8UVLUhptQEs29JOXeMCPvKcmB1Xa5Ks+XUV6ivmTWbfmvPS4+0OV2M41VOa4Lzmub7FxYpT+K8Pt3YpCKepoEcPh8t0HpYe4R4Ht8frplMzgfAbSv2nrQcAViJ35JqBzCWQLBzMhc/WjfEkichybu9X5HuNp9N9uIvYJX3ytB96svqTkR+dvb6/yhvEoYYsW46LZ204M+0Lg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43756ac-f4c4-49e1-bedf-08db57b0102b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:30.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVCvdD3lTANcAh5bcTyM9xQIgeFMsVAz4hHoH/n0vUkG340bcApVES86ftSQbdnnevz7QtXxXSPeTVuBjCgowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: CggSIR-pyJfj6SW50aFit6UDWGN4iRpe
X-Proofpoint-GUID: CggSIR-pyJfj6SW50aFit6UDWGN4iRpe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in the validation code and combine the code to
check the maple tree into the main validate_mm() function.

Introduce a new function vma_iter_dump_tree() to dump the maple tree in
hex layout.

Replace all calls to validate_mm_mt() with validate_mm().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mmdebug.h |  14 ++++++
 mm/debug.c              |   9 ++++
 mm/internal.h           |   3 +-
 mm/mmap.c               | 101 ++++++++++++++++------------------------
 4 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index b8728d11c949..7c3e7b0b0e8f 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -8,10 +8,12 @@
 struct page;
 struct vm_area_struct;
 struct mm_struct;
+struct vma_iterator;
 
 void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
+void vma_iter_dump_tree(const struct vma_iterator *vmi);
 
 #ifdef CONFIG_DEBUG_VM
 #define VM_BUG_ON(cond) BUG_ON(cond)
@@ -74,6 +76,17 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_ONCE_MM(cond, mm)		({			\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_mm(mm);						\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
 
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
@@ -90,6 +103,7 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_MM(cond, mm)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
diff --git a/mm/debug.c b/mm/debug.c
index c7b228097bd9..ee533a5ceb79 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -268,4 +268,13 @@ void page_init_poison(struct page *page, size_t size)
 	if (page_init_poisoning)
 		memset(page, PAGE_POISON_PATTERN, size);
 }
+
+void vma_iter_dump_tree(const struct vma_iterator *vmi)
+{
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mas_dump(&vmi->mas);
+	mt_dump(vmi->mas.tree, mt_dump_hex);
+#endif	/* CONFIG_DEBUG_VM_MAPLE_TREE */
+}
+
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/internal.h b/mm/internal.h
index 4c195920f565..8d1a8bd00124 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,14 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
 		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 76eaf12f1390..bcebfd926632 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -299,62 +299,44 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
-
-/* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt = &mm->mm_mt;
-	struct vm_area_struct *vma_mt;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	mt_validate(&mm->mm_mt);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if ((vma_mt->vm_start != mas.index) ||
-		    (vma_mt->vm_end - 1 != mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-			dump_vma(vma_mt);
-			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-
-			mt_dump(mas.tree, mt_dump_hex);
-			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
-			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
-		}
-	}
-}
-
+#if defined(CONFIG_DEBUG_VM)
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
-	validate_mm_mt(mm);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mt_validate(&mm->mm_mt);
+#endif
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
+#endif
+		unsigned long vmi_start, vmi_end;
+		bool warn = 0;
+
+		vmi_start = vma_iter_addr(&vmi);
+		vmi_end = vma_iter_end(&vmi);
+		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
+			warn = 1;
+
+		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
+			warn = 1;
+
+		if (warn) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+			dump_vma(vma);
+			pr_emerg("tree range: %px start %lx end %lx\n", vma,
+				 vmi_start, vmi_end - 1);
+			vma_iter_dump_tree(&vmi);
+		}
 
+#ifdef CONFIG_DEBUG_VM_RB
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
@@ -365,16 +347,15 @@ static void validate_mm(struct mm_struct *mm)
 		i++;
 	}
 	if (i != mm->map_count) {
-		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
+		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
 
-#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
-#define validate_mm_mt(root) do { } while (0)
+#else /* !CONFIG_DEBUG_VM */
 #define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
+#endif /* CONFIG_DEBUG_VM */
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -2261,7 +2242,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
@@ -2319,7 +2300,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2328,7 +2309,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -2963,7 +2944,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	arch_unmap(mm, start, end);
 	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ret;
 }
 
@@ -2985,7 +2966,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3226,7 +3207,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3285,7 +3266,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3301,7 +3282,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return NULL;
 }
 
@@ -3438,7 +3419,7 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3461,12 +3442,12 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

