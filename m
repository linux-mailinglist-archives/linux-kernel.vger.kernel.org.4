Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8D719070
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjFACRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFACQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A051A5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKlVlo020034;
        Thu, 1 Jun 2023 02:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=pESqsIiJAkTxZZ5yDpeG3vcCyyDMibUrXt5NMbaAT4g=;
 b=E6BhjPIO/S52ZpP5QOBZsk3QqpmDjwOPnwba3bUCyVk9JE8INVr7Bh/UQyW7DBLte3Z1
 NpF8TgDjok9DP31pSeOCmAkt9AJ+8bHuIpIdGRBUi+rdcpNaahl18yqmNzEV/ksGfJ6y
 20RfWQbaZNXxokNqNZBAmwB75snl9TkYd9hslQPmOHhzSLzDkIGlX9GCkDL0u329oKGE
 6uKdtIiCzK2eMiaOTXqfuZDtbh0ovDTIDhx2PVYCgzFOzeDwbiwQGly5vrvTKZYkQ4d+
 5haRQBBua8THc3elTMiPDAwGvaHnhPh6coykmtACzsYdAJ4IXC51JipD9AADNVrIlpPW 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh7hb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5Vb014631;
        Thu, 1 Jun 2023 02:16:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/rckNNAjZCW8/Ozm1KFrsqqqeZBWwAJ9vlLx2AhM9p9gVEgWVd70iseFoZZVW47kFhbmz9LmksLvAOT9V8j6P/wR3tGEOXZZM45EEtYN6VcArBybQoUmeMzGTkIC5rNyYvb118dfTJTtNxu8ghk/ZU6zRQsSR+/eXeODeq+xWW6yFWdsememiHEOnVUtXq3QPyEB6qtthu9aZuc3agwvQ1d7Xt381xFsMBGhACjgCsCo1rlkSZceNIW8dpIWIcCdIJGXgJ9ooRO8sLjIRQFhoYv+FilRsj5CS0x9gedOmM/mlGl8Jxs6+6iQ1ZaxyI3zWbQag+mBaCEwJltld7Tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pESqsIiJAkTxZZ5yDpeG3vcCyyDMibUrXt5NMbaAT4g=;
 b=VTz75tMEQtgIrN53BUmSTu7NiUiJpreFTo68QmbgStogd0eHvwOOo0MMHOYl3SgHV9SeK1hsu6gIm26uKquFM37/HXu+aXCFG7mgVrJq3RYsd7LIOHKowG888bhcb8LWDUaKTLx1ORc8JI6UVcr8g3ZUOTfUV0SLglojPMJ2biTXUtFC7psAwbtZWZTMfA8Kq72YSRMC+fyzWaRebXLoomECO7D1cCGrrYffmT6EMT2mXsEN0mARXWdiU8X/3OOj1KqxULfg8wdRFum2Iuyqha3JxJt2yQbDSKfpL4FKqEAVtyNmiVJVWZpx9v9hNhTpOsrf+EhfLoYrUVgTjiRudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pESqsIiJAkTxZZ5yDpeG3vcCyyDMibUrXt5NMbaAT4g=;
 b=OhoYky6FLr6OEPE34CoNgbswyDceet+N9pp3EWkh2+keQrXdBAS7eAQM9Ytb82lTNh48J5cifL9Nugrk70NP5fg5DldavKuQlKGHZQV4MjFf6gwQkjb6L7DpfhdPN0xuGZ562zfkuYdMow2iTaFjQzV+qyFPTVAqBjMWRI0PhO0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:26 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 04/14] mm: Change do_vmi_align_munmap() side tree index
Date:   Wed, 31 May 2023 22:15:55 -0400
Message-Id: <20230601021605.2823123-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0061.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a223105-c74a-4d83-ed1e-08db624633e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9j2OQW3mjLaA0VUNpIU6UDdMuyGcNfJsS17oTA3iB/Aa2csKBeNValMxclOoQpjMxp4S4nxu4wu9k4XtBmBHe34VgPC+pPko35BEL5LecnsJPEIvQODFX/ft20YmrJSO5KkwRP/Vq4SJtYF5h+hPEvT6849u4RS8zuDtlUQ5sGTkTh6o1a3JwJABHKJ4AOyR+im92YPa807qohsA42BcAGFifysREPmOU2vUoGf7gX1ne/Qzkdy/N7kt2AXG9two1jVVI1xgei1plEsIw4KuMctwNJCTzDOiJ3IxsGb8b1puaFHQfde4EKm5sJFAPKQv/aKatGcXXkTOPVk2duztVX6K/kju3sFo8BkdcCrlk/7RGH56T33cGf03VRMvKuJWkfPAuLaaeyeC71ET3nKrlL3EaPNLT+VpXPJbp8ltDfcxy933ikqOTYOzzh9i7AqSRVFeuIvcAgpvD/spY6PRQPNU1tn6iRPRExCVx+v8ihyVc0LezR5ISVcx6FPKd3FyhUx+qSAgIwn5LMxamUc6+vNcZPpQOgdh2z3uguoK4rjbvWNBELtNb6in2vsH8SU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?omc8ROJsA/MNNS8Uk00fT8LR7/9syPwoxqcoL5D1QhGJ+NeXHGGdF0HLTpsX?=
 =?us-ascii?Q?Q/vPEZFabxAdqJurf/Ppf/qVtxttBFpz30kxDd/u0oAv/uK9gnGUMq6fHO3/?=
 =?us-ascii?Q?VAloI3hQhp/Y4E4hc73yMbeCBOXoUNSqtXD+4JjeTZNrNfhPEDEj/1Jv6XhY?=
 =?us-ascii?Q?zI+OCyYdqDhm5KIZFuO1FA7yQRwvzvUSslRqNSA7en+Z9dNa1Nym2xr6d28l?=
 =?us-ascii?Q?Gn2p3R1G+SBEhnca3282nep3AVRsXOwdr2z08LH2mWYp/je67KcUrEiD5El9?=
 =?us-ascii?Q?gRqyfYmI/DT68/KMkNMNfvinnKJDRj8BCYL+GABfdyTW6f2dRnc9FLDE68uG?=
 =?us-ascii?Q?KfrkjAbJhseLW4zNXCeoP6Il5kx6y0m8IZy1gLkpownph5nF43smgcIasSfT?=
 =?us-ascii?Q?KRnPU+9UCp636rFjnk5iuy2FAxEG1OFesiwtesAaoo7nYsqxrCG37pETu2Io?=
 =?us-ascii?Q?PpJvukUo639hZV0xHsFSUi1xwtHmmTSElcdF/4xjd70pR6eLCc8/PHviGSMI?=
 =?us-ascii?Q?5LJ0APbIcqj4hyppzFhH2Wn5chBDnIaSkyeyjG0NFBZCFf1m2xmD10veYaPH?=
 =?us-ascii?Q?a7X4j62NjaJNPvOGP2ETk2/2ElxidMoo9InrlgxnZDED2uyY1p7GCwdJAL7x?=
 =?us-ascii?Q?a2TYCI4yS1sx+4eLb84A0eSd0GugctsyvnA8qoKYFIiiD1dmoZcdPIzDy93Z?=
 =?us-ascii?Q?FE9Kw0SNz1UYd00tE92Kc70elP0PtQMlBYAc/gJ6zt5MRaq9sYXuPAMlWrg+?=
 =?us-ascii?Q?DrYOQM32EhwiVnuVRtu+mfkgZN1ajn4PV/ytPbNdI3RiQbSW/22a2Wi21LjH?=
 =?us-ascii?Q?X9VxAwAPO3qT4vRoib7nfylYwNrBxPYk0FN4262i5VsMB0+agSowVq/blST8?=
 =?us-ascii?Q?YzGsmityD0N9ZdPcVelDSf2gkoklfmtAgHP7XdxhMkGYmts9ZhrcNGJ7/72s?=
 =?us-ascii?Q?ZmwAy6FbZEdjwPOB+Ve/Ep6ZQu6bpzBP8qTxyKbFwnCl/2kPzy7rmNuQKevL?=
 =?us-ascii?Q?W6hQFBOJCV+vy9wEA0XrpGhasnaLQmsRHnobKTbjCwXmQS3MBOg25s9Fso3S?=
 =?us-ascii?Q?oZZjR2ldJQ5Ey4MMwvlyXAjj3W3emi9H01i/WpoIDOjqLVxheSIvpaq/dCyT?=
 =?us-ascii?Q?9cmkvD53na69rrpM3PO3vVTJfBKPrGiPq83pIUKtorpoUM50pDZ7N3nW5AjS?=
 =?us-ascii?Q?rBKzY/Rc3Yg3pf6fAXIKdk70PuBOmdKthLtlgn/RrUvy+hm3iNzFLy8O+nUA?=
 =?us-ascii?Q?gxzO9BRI6XFD2QnIZ5lY640GAx97ZRDtktb/uFMYYfO+m0FGVkdY46LwBPub?=
 =?us-ascii?Q?zMVpzNOJfVlrqdIH5nLB2+edP7Dm087W9ZBFKdKBiAtrAeZiVwBFySVs2Ikj?=
 =?us-ascii?Q?XgQPEs12Nqdl5nBeLpPIvOuaSKQumVMeeRUUzMvlByvFk3AqgYBMfnx4RY5L?=
 =?us-ascii?Q?XROVV3NY/JIpiGrkC16voz3hm6u0y1mZDUpEr0pBnpLl92jijAmu1er31zDe?=
 =?us-ascii?Q?SYgIX6YLIQQ0R+V8tbaz0B+ynvshvYGaGwM/PE2D6SHItdsDXrUKL3TwXiEL?=
 =?us-ascii?Q?bmaRV779PWyve7eGiAXvaz6IEUz4iC1e1t87MWnabKgyyNbDHENjXdn8jHeW?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fIZA8E7u56fi2Ke0dzLmFGjDpiXnq35WO0J06ZzLsAaP/Gc2dMkknXV9d18xLO9D7AMoWKVMLDzUlXQNpldGWZyP4vAbpc7kyyrb1tYINAxYKnWWWfmHK/kjgDTPnJ03qJ3vpDlGOSt5Q8MxkSkPajBkBynQ6xHnj0Jx5PYjdJ3cjPOkujA5YAHgyk+FECc1/p4Ju0QEaYloOuJXQQJv8u+Fw5EgDcl2hCQ6l1l9I5t7o5BP8RKmmjbSA8ichFnodwbzMNzMMO/pZ0xwz8OUib9S/IebYlSSIYN0BDy2P8qId+mnFPQ3YkfhADoigJxb8WHkBp/tb5yDuwxIHsH/qhePHPsXPs+wwGX4HNW1//T30KF3qqR8OrWuy24B1zZGPHU709e0iKMbFvtiJlJAqx9wUPrMMgOJ1tBl9Z0qo5m0v4QbwOzR6cX1dPr4FjzX+7pp0lH05ip2fhY0agaJvNFNjY+wdM+Us+UfLOliI58MJm0ASSupJtPIfvFME4eCvn0Kn/7AjN6ve5/HHHiZ7aoJZOqKsMtBsi6EJomPzlQLRmfqn1MGka/ZErpX6TmZCzdbDhqachZ5tuZVE2EgaGVUa12+zZZTKVGbE/NY/CmjcQDRmz21Fo55pnge+IS2Egsf29nu1zUuiG1jT+h+EZFV50j4XR4kkOmBhgY1mB9kkyDyJe0kY0CnQURkN/UmdxHAAHregKYA+ZtJJOtPD7Y+7CWUITI1wFVGfBa+dEIfe5ctcjv/8oocDtbzBb981frvWCzvn/cU/A6EVBx7+vlMu5JEk9So6JjeBrZ3qPmUeoTWi/C8yqUhL0B3NEI6pxOUhqVAFxQzJT4Mr0Xmti0k3Hgk8hi5fcMvT3ByKyDKUwBltWnY/Jw6DaSWqGB1fg2RdcQ7sOsDv14lkv0PWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a223105-c74a-4d83-ed1e-08db624633e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:26.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGka2kKz8cM1j/OTtuTC2hTS05k8CdsSOqvYFGg+WlK0gFPgxU5aTWS3atwsS/cloMIatT1Xght2RFT4uv9dyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: 3GXuOFaYAgYbKSG7Mw3u7w936KSpvCTP
X-Proofpoint-ORIG-GUID: 3GXuOFaYAgYbKSG7Mw3u7w936KSpvCTP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the calls to munmap a VMA is for a single vma.  The
maple tree is able to store a single entry at 0, with a size of 1 as a
pointer and avoid any allocations.  Change do_vmi_align_munmap() to
store the VMAs being munmap()'ed into a tree indexed by the count.  This
will leverage the ability to store the first entry without a node
allocation.

Storing the entries into a tree by the count and not the vma start and
end means changing the functions which iterate over the entries.  Update
unmap_vmas() and free_pgtables() to take a maple state and a tree end
address to support this functionality.

Passing through the same maple state to unmap_vmas() and free_pgtables()
means the state needs to be reset between calls.  This happens in the
static unmap_region() and exit_mmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  8 ++++----
 mm/memory.c   | 16 +++++++---------
 mm/mmap.c     | 41 ++++++++++++++++++++++++-----------------
 3 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9b665c4e5fc0..24437f11d3c2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -103,7 +103,7 @@ bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
@@ -1099,9 +1099,9 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
-		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, bool mm_wr_locked);
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 /*
  * VMA lock generalization
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..6737263e17e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -360,12 +360,10 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr = next, addr != end);
 }
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
-
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
@@ -374,7 +372,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
 		 * be 0.  This will underflow and is okay.
 		 */
-		next = mas_find(&mas, ceiling - 1);
+		next = mas_find(mas, ceiling - 1);
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -395,7 +393,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
-				next = mas_find(&mas, ceiling - 1);
+				next = mas_find(mas, ceiling - 1);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
@@ -1700,9 +1698,10 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, bool mm_wr_locked)
+		unsigned long end_addr, unsigned long tree_end,
+		bool mm_wr_locked)
 {
 	struct mmu_notifier_range range;
 	struct zap_details details = {
@@ -1710,7 +1709,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		/* Careful - we need to zap private pages too! */
 		.even_cows = true,
 	};
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
 				start_addr, end_addr);
@@ -1718,7 +1716,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
 				 mm_wr_locked);
-	} while ((vma = mas_find(&mas, end_addr - 1)) != NULL);
+	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1503a7bdb192..8e5563668b18 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,10 +76,10 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
@@ -2221,18 +2221,20 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next,
-		unsigned long start, unsigned long end, bool mm_wr_locked)
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
+	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mt, vma, start, end, mm_wr_locked);
-	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
+	mas_set(mas, mt_start);
+	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
 				 mm_wr_locked);
 	tlb_finish_mmu(&tlb);
@@ -2338,7 +2340,6 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
 	vma_start_write(vma);
-	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2415,6 +2416,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 		}
+		mas_set(&mas_detach, count);
 		error = munmap_sidetree(next, &mas_detach);
 		if (error)
 			goto munmap_sidetree_failed;
@@ -2450,17 +2452,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, start, end - 1);
+		MA_STATE(test, &mt_detach, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
 		vma_iter_set(vmi, start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, end - 1);
+		vma_test = mas_find(&test, count - 1);
 		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, end - 1);
+			vma_test = mas_next(&test, count - 1);
 		}
 		rcu_read_unlock();
 		BUG_ON(count != test_count);
@@ -2490,9 +2492,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
-	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !downgrade);
+	mas_set(&mas_detach, 1);
+	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
+		     !downgrade);
 	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, start);
+	mas_set(&mas_detach, 0);
 	remove_mt(mm, &mas_detach);
 	__mt_destroy(&mt_detach);
 
@@ -2800,9 +2804,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		fput(vma->vm_file);
 		vma->vm_file = NULL;
 
+		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
-			     vma->vm_end, true);
+		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+			     vma->vm_end, vma->vm_end, true);
 	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
@@ -3131,7 +3136,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX, false);
+	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
 	mmap_read_unlock(mm);
 
 	/*
@@ -3141,7 +3146,8 @@ void exit_mmap(struct mm_struct *mm)
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
-	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
+	mas_set(&mas, vma->vm_end);
+	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
@@ -3150,6 +3156,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
+	mas_set(&mas, vma->vm_end);
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-- 
2.39.2

