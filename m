Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB0675A84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjATQxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjATQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:53:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ABDC17B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:53:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBaTM003300;
        Fri, 20 Jan 2023 16:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tAofYiKY/5eWtbKC4qKbyIdy2EeQhljnbYHikZec/us=;
 b=iHSGxUdckrApKvXsv0GLVtFWlb/npaWm2X78p6KpsqAzkKAQq3+1WxGWmXIBbWzmBGit
 E4P6hNoNwvtaJZvc13YOCWNf8kq218ICqML5QErC89g0ldIQfUBsN62yntVDNtRk6QzU
 kaXN6jDO1JcEOO1ZsMLQKn66bYteiySohG5V04awdsyInPV3UPFP4PXfLdeBTgw8aTIf
 03KWmhwhZyH2MxmColgdPXJPBfXarxxvAbkZoMe8OZLyI58/WjHMa60/hnGx8opgdoY+
 YmBBGShZ3dkThSVdB5iDayXaBkE0IdlEb96KpTUyHBC6c+0/u0fLZxmaDsQGOqJwSZ4y yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFCTZG000901;
        Fri, 20 Jan 2023 16:27:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2sv9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsTdmttMugryjpGn5vmkDC2Ivqqb7IZLVqNn2BZzluLrGCr5ij2xR/XFHXf+QyurfxasN69Cu02mNud0KjP+CApJslxliWM7+hxJlvNvMJE5q+Kq/aNfsp5p36GgE6p8Yi6cReUqDKL2WALrgy7tcwo2Zf7oDM+VzDoYGpt5qEFFiMN7t+8PuI42gCkKpM2z/7lytbSpN7p47HVvVAteYDyMtlvRZsSLUfKQfRWAOezkDe0wsKooOiYJQHAScYTNuFc+hux6mL3p4bs3M25Aq2JIQrjJ5g6UaD+Dm8CVtz944U/qmWYLsAkwYU4aIDrj4uYbksBqgSZuwlK5golDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAofYiKY/5eWtbKC4qKbyIdy2EeQhljnbYHikZec/us=;
 b=QJuQrgRZIuuFzCFE8iCENLvaVT92ow8yRqzd84ikqh4gnzDSRww2vMdfFOH6vVXOvi3gBtMHIHRq8VWzLPT7mZiU9FwpQjo5VZEjxVspxEP+HdFV6pjkkghdIH8ReBtrwOR5Z6n0sQ7r1K30BczQdsrd1qFEJdM6sBBLJxYUAaBY+EJfQYZNguWOV3lVub0jLVXkTfzqLyTaauuySEVauamPMijlwdDHaUIkFndvjLKC0loSgogLpTw4Ly0pBSDRTH9+pPZW18CyVUckj2QeTXryWgFYA4cQji/7vWBUl3Rzw6T6hZ+7ymRq59fTuW0h1J4F4JWS8QtCmM3UqeE30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAofYiKY/5eWtbKC4qKbyIdy2EeQhljnbYHikZec/us=;
 b=ySteJgBtO3Mh4ZQvQdDYd8N12fIhLHMX7exG1PpZSwbvqAuHUWPBAk1kgp1zGDBho60bsNiaBSP9gR/5SdIvIEOOxnABh6uQIqaCckhi8rj2xwcg1mPVhkXzR2FiMhlKmehujUJ9hGRf4XriMlwq+9J/d9LOclzsaakDecBxQgc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 16/49] userfaultfd: Use vma iterator
Date:   Fri, 20 Jan 2023 11:26:17 -0500
Message-Id: <20230120162650.984577-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e487da-3ffe-4860-c6f0-08dafb0345b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCcsM9bBXxnzZDQTZA724Qv2KM0U0Y9BzFLtsge3cm0HCKn8tlg7rlCA2fznXcusNH97Ba7M6KflnmLgTeqQtlpvyRzCVZjE8QqsAmfL38vI9s/vHVU6LRv6HCQfpciZW5OdEA3UggkfP4+uI/Q9y4kmLJ6SVhZZjPX3YceGOums+Rb8SyblN4w3rp6YwaunySKeVegou8uME45DpXJkKifBnrciV91/8HvTFmntKzd4ByhmXLEsGAiL91MWffuzT41edE9IKefK56qmyPgwJVxh+A1OTPtVyB2gsIiASxRGC5Gxdybe8Nsy+jpZCMngRfgT/I/Cp3FzcE0z1s6DcsLLhL5vJ7JZTD/cF/ceqpfWCK0Lq7JIgrjwtn7FLw78o0jfbQ4p2opH3KkNRDCBm7z1XA6xMX+hMjtDHCcRryVThj6l9w/ZF5MQrTAYF7pFOL0ujjj/VmVx9usUiPNWGgGgAxyU5LB3Mk59++eQlLakkp8b1f4pELvdDTOv6uHOLKyLkrOUqMsKpgnSKoeZZp8qNBgYZxlm0f1spSmCeWm8HiJ6NvV/Cxrx5bp2V9sWi+vZNBHFO98PYhyCTG49qYp3Kjto5wQ6lMLv0y/33NGrrRY0Oww9gUPFDSSjWr3KeU/Y7x6tK6w058d4A1b3DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUS2bpkaUvCavBihyojFf1gp/hWA3b5xQ3ezCaI+vqngc9JxBNyPIIpN5z3T?=
 =?us-ascii?Q?LcPcan9bQW1RpWc2uHFTfDXpjg41rT5u/StCsTlS+7yx0Qq37oJhL3RXDLZW?=
 =?us-ascii?Q?R9xVGs8n1HDpktxSgpzfDs7tEfRA098ocP6FMDqvZ7u44f1A1KsXfBkPmYOX?=
 =?us-ascii?Q?BwtpaUTDL7iqq/6iNbIJ7uLkR4jTLlqjhftjH5voQ3aUztMBqmMdx46BH36a?=
 =?us-ascii?Q?dayC9YdcIkaCLpl/dMMttkX1C6068+7GOMwpMPz8NKnB+oHtoCQvRBKPOJoV?=
 =?us-ascii?Q?aK5aWVgRl8B+WIlDFm3UeaK3G1GhyKYroJ4OkJG19LOS7q9u3YjRqmEZ+eLW?=
 =?us-ascii?Q?JUghaeC2pVX6cdXE7dGUIMHLvJviY7JolRIPjzKyDcNIPL9B27DbyeY8xoda?=
 =?us-ascii?Q?GLanMk0BfsoINwiu3wZ/nmY94mzmZ08PNz58tTKbSQakotBQQ/dL7HQIm+NJ?=
 =?us-ascii?Q?LDM/b9PT7zJJ41Is+V/vTcHCO72+gr3yFITLFndnwmdyw39erdCdHFG4JOfX?=
 =?us-ascii?Q?oXhw+MwZxa+ox0ySnwlDc5S7cPWl7G4Wk/jRpQKKPqIefNq+dSMO0LhhmCjI?=
 =?us-ascii?Q?GXD2Qvai9/2w8TK5bVFpMc75xPtZ+wGSSiQqRGPm/9iJN/4AzmRSK0oP0Nws?=
 =?us-ascii?Q?TMpeADFhZoI4abhhi/KFpxOPsoENwIhlYYlNIAtqIC5S1Es24j9GXwCa/0Zd?=
 =?us-ascii?Q?fZTcdNi+N2M0J7uGSgAxPDsuQA/reVEBos5T+cXBSBllUIQVJabFIy1U4ilB?=
 =?us-ascii?Q?SwCY0AAAKO2sAFCnGFu816L5i6F0gvu1t+fOqc2XgsE54A0yaW8PS5ULSOrT?=
 =?us-ascii?Q?Wo4rU0Z8bqPcLIYmSU3YEngdhbRz0rz0p0I5urL/dVrqYfzKc0qHufYXP7Pe?=
 =?us-ascii?Q?sJP4uYh6oWwERnCZ2FyY3DIUP1G9r5b4V1Ew7L/xCyEFoBSmkvtpxmYKdqyi?=
 =?us-ascii?Q?+7EsST1PktMpIvxgyrzYL5cc/NzUbtB6uZRKWD+rGzo/9oNw798kd18sPy8r?=
 =?us-ascii?Q?kvB9OFCCoLZuG/iRji921wMsJgqn5J/Jxcox7zEE8/5Ecvx8THNXtR2qcxW4?=
 =?us-ascii?Q?w1fpjHpywYs09RHUPc9PBoiLrt+YkwvqxCs/NgZp26TnuGD2vHcISW85g8jj?=
 =?us-ascii?Q?dTQnEDzEykSmNrjdytenX5VD/rIo/Ats5LjAxqwuAaxtr1bEtuw81pZXfR75?=
 =?us-ascii?Q?cvNKyaLYNqRAlCdarbstLOi9/FSvbtWkeQWO9PPCLL8FdNVpM0RIsPqW9AB+?=
 =?us-ascii?Q?E08iPZOMy7ilVnH8aqzbjBt0UqaAl+wJ4MGhPQJP/dXQ0FJjT/NsSCemcm+b?=
 =?us-ascii?Q?XxGSkBAdkA+SaszEkPQWdLTKMGFBTvdEsOmzNP5bNCMYM0qgss6CD352835w?=
 =?us-ascii?Q?m1o9jLtReiWQ9mDKZWKjxPM6CWA1+KoVls252G7ehapZftXiKCXoa65b5XQc?=
 =?us-ascii?Q?NhYHPY/ZslpJUg0FqCr8X/3TjpKAX21L1mao3G3B1GtRMlQtJiRxkSdBT+Ac?=
 =?us-ascii?Q?zm2HSYENIjdOb33GTBC2itA3MS0fEHxd3iD5lrbYkpMtpXPP+H4gsaIIDrdu?=
 =?us-ascii?Q?qs1YF5LkJNVMNqfgwglHT4fxBA0/BzKJ1Ab6VS0cnhXkai4VTL+qSQschzUQ?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IZnH9MzEPZ0TLvdLGapOr/teJqtaRkYhmBO99PUsj1z5A9Fqu1TN16hHvzPPVrWyEiULr7vU1QTBVIppCDxqeqrjSUO4xsabPZhyjvabN36z7cgTi5W06+1yQgCfyDEOJgoQunK9zAwvYPQr3jCG/7+1UAX65vdbLp0ZXXjobo3z06MgbIvQOi9YgxZ9zx9uTv+wUESoTaH1U/Xp5nlmumhFvTXt9x7jcnOOvEyW58XTtnvDLIyt6vEietAsrO0WSEH6Hg5bJqCC1+Zrq8hulV+BbPVYQO77j10q/hTm9sW+FoPyPT02XGODAHXYXerO0w2EcZDrroTX6ZCR5spT2F6iMoJRKYYvG6U45IywC9a/qLr91iKfUHJmHX8E1oAGWt17V54Iygh1t1ZL047/MAcP47eza7V0qm4V4tvCgKaJHBKWKQvvbtRqtxAok7j6yBhIVR7b4PS8RUHlOF6ugYzBy/dQ9xw3WU65WVoFStoCcHl1SuUkE28Isx+iBZrqF7eApOxYhLfeUcyWb836LxL2XrGKNprgUioTA2XR+41Cc6PACYK0AuzoPnU7UHjLrjxbr5hxzmQBkLjORivwNhHKNe9VabO8tKSbnDappICndcdaTpq3527zxfqt7N5dHwCh7cZV/HKLz/+jIjzYttHdaEQiMPtnEJXcTydTacmiDHxhpJKxA0CcT62aojZgpg2+M51/jGWl1SXflv1YtYML0ukZ2daEM3V+fz0AsEe1P3lG/f4hIfH1Nn4e8WNz46HscFYWpAQ/IgZ8QfXvFiJKEN12+gwLj/1YTiywGJjeGYaGRx1CbKJYI5TeGddms+PxdqRrk9NmAS9MEs03QHZurmg6cxSSFktskTWcliY/Jmf5DVXOyap6rCa/ufIIq+wLDG9pe3BO1CfbuPq1jQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e487da-3ffe-4860-c6f0-08dafb0345b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:49.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaarXdrwG/R2oWxCkJfktbqcNROqpgZS9tKmb4Ztndpqhp4/xW0Ke9+peJUaq6W8nQyzS0qMJUk1WNVYfS+1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: DpK5mQl8fIAI_Q4l_12eSvfuL_La6Udj
X-Proofpoint-GUID: DpK5mQl8fIAI_Q4l_12eSvfuL_La6Udj
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c | 87 ++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 15a5bf765d43..4334bd35984d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -883,7 +883,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -900,7 +900,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev = NULL;
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -909,13 +909,12 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+		prev = vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-			mas_pause(&mas);
 			vma = prev;
 		} else {
 			prev = vma;
@@ -1302,7 +1301,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1344,17 +1343,13 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
 
+	ret = -EINVAL;
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma = mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma = vma_find(&vmi, end);
 	if (!vma)
 		goto out_unlock;
 
-	/* check that there's at least one vma in the range */
-	ret = -EINVAL;
-	if (vma->vm_start >= end)
-		goto out_unlock;
-
 	/*
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
@@ -1371,7 +1366,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	 */
 	found = false;
 	basic_ioctls = false;
-	for (cur = vma; cur; cur = mas_next(&mas, end - 1)) {
+	cur = vma;
+	do {
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1428,16 +1424,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			basic_ioctls = true;
 
 		found = true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
 
-	mas_set(&mas, start);
-	prev = mas_prev(&mas, 0);
-	if (prev != vma)
-		mas_next(&mas, ULONG_MAX);
+	vma_iter_set(&vmi, start);
+	prev = vma_prev(&vmi);
 
 	ret = 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1458,30 +1452,25 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev = vma_merge(mm, prev, start, vma_end, new_flags,
+		prev = vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma = prev;
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret = split_vma(mm, vma, start, 1);
+			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret = split_vma(mm, vma, end, 0);
+			ret = vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1498,8 +1487,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-		vma = mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1543,7 +1532,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1562,14 +1551,10 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma = mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		goto out_unlock;
-
-	/* check that there's at least one vma in the range */
 	ret = -EINVAL;
-	if (vma->vm_start >= end)
+	vma_iter_init(&vmi, mm, start);
+	vma = vma_find(&vmi, end);
+	if (!vma)
 		goto out_unlock;
 
 	/*
@@ -1587,8 +1572,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	 * Search for not compatible vmas.
 	 */
 	found = false;
-	ret = -EINVAL;
-	for (cur = vma; cur; cur = mas_next(&mas, end - 1)) {
+	cur = vma;
+	do {
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1605,16 +1590,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			goto out_unlock;
 
 		found = true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
 
-	mas_set(&mas, start);
-	prev = mas_prev(&mas, 0);
-	if (prev != vma)
-		mas_next(&mas, ULONG_MAX);
-
+	vma_iter_set(&vmi, start);
+	prev = vma_prev(&vmi);
 	ret = 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1650,26 +1632,23 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(mm, prev, start, vma_end, new_flags,
+		prev = vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma = prev;
-			mas_pause(&mas);
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret = split_vma(mm, vma, start, 1);
+			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret = split_vma(mm, vma, end, 0);
+			ret = vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1683,8 +1662,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-		vma = mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
-- 
2.35.1

