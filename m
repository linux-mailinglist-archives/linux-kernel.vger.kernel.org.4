Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E412764ABCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiLLXvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLLXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:51:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F4EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:51:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwiYa020892;
        Mon, 12 Dec 2022 23:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Qd2W6cROuqO6F6wdHNJZ286gKemBi3/hAtZZm4fB+2M=;
 b=LEEI5L9Zw0IPp7m18TALzhSO1ia/5KBC/9DpvTjIpiNvc+fsiVZiXbKwYIUtj1rNPO2H
 6X0iLY3snxaAI8/sPfSEu0Aba4+jaLb77FrHzNiZWdW2UFsex1yxaUB0jx49oAvLkwER
 fp0g9qk7qddvX9Fco/7b91hjePZ9IiAsHAy4PSGHLMIZ3XpAZkYg7UrC+K0sI35Sc9CX
 MdLKXwlmEJxOOcvpkZwtGTJThQ9h23DMI2XlicIsouwhXGcRH+3S4qk1QhDur7aPD/8l
 I02vJqEcPSnL+gJKuKJ6l5FUhwvcgYwhMzVBecUem9YyQ1dgx1w2GTEEO5bhMy8RfDaO sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mchqsv5rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 23:50:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCMQbbg031734;
        Mon, 12 Dec 2022 23:50:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4tjh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 23:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri/SRwj5WnReEND4ZVts+gpLKVJ9/Zxa/nlpdXFM9za9NN9w03ZUfiR30bRoPmI0Pzf9jdTcZreA4tx4RnjraXfPKHx8Nv4ivgpKmegs55+hrARhRxV/IjamibwQZi4RbCxq3BiHZAySb0kxOc0AVwdhb2wDDI2jtHQFX777F5vjbGC0/vbK+cwGrcxZhPu9Xyo8UwPmMWTFFTJg2dv57VrWhu/RvSC46Ln5q0pTExlSjdUITOSLWwKwjRenaFX66Cxrww9HJbEXOaL3i3A+eqGix5x/X+mhZvVzfu5/tYW9eg1sFBpGo0R0ekms/34FVL9TIJN8262UlnPti/C34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd2W6cROuqO6F6wdHNJZ286gKemBi3/hAtZZm4fB+2M=;
 b=QVs5V2yvGF03Tm//Du5Rvnz6h/z2ppCzY1w4Bc/ukmZITp0JEwLyC+ETwy73qMRBmwcn1CTX/wNbHy3fDNooqbOP+sOlmgH7ovBzLhnaCCqDcfdEzl2kw4prJ7yXMFXTI8nRI/f8y/uxtNsGbRBvjHraQvRmgIBSyMr0ExvM0CUaytTX4CUyzXzmd3ZIdKg97EaMoVohKh24zpayzwy8Yj8LysxF7k43nDvpabvefDTlmIPlgS+AIWDGAKWViQ1IdVRx8GHMGDdyLqzrg89/jHY9N9Li2DaogtKMi+X3wkjvSW6/7HXfgtmyXfXYLNAlW2NdtmLR2E3quKoj4MpJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd2W6cROuqO6F6wdHNJZ286gKemBi3/hAtZZm4fB+2M=;
 b=SMVjZty4wc78JO7aG1pyjCVx7mhsppYbLOf7o4iQr3p1XGlLwk+Dxmq/eZUOSgz+LHBS8SaAXcbKWp0knuN1HIi6DUVaIcXHFucD9DrQnvfOEZrU5P0SsudFWFU3JnBqVrfA8gpPSBExUGe85fbXNE9sk7VVmU9U2+5z5bmssUU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 23:50:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 23:50:49 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/2] hugetlb: really allocate vma lock for all sharable vmas
Date:   Mon, 12 Dec 2022 15:50:41 -0800
Message-Id: <20221212235042.178355-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:610:77::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e750283-2837-4f3e-4907-08dadc9bb171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3w8W4epZ5Wvp4fXGMp+/rddHWDGpnGZKxOoM2VbU8ltyB7TyO3wvC1ZhGNzx/V5Hxx9pO+8znaeM+dNYU65IrKySaWo0IAHULMtlAloImBhBFHiMKR+tJysIsrfioMkLnv5QuEOPf7Z0t0Ub6OzqXj8mzvApnM3frQiU4ya6EIFBllrvCE/QabHBYf/5+7glYtDcPlH6Km63iCftqyytpO8i0Y2k3ypAt5cgAEKSdzNxDxjWLKjItO+6NPNjSnOQ1FQNCAIOWRCDtuwGNp4jXkwv9Naf9uee0d5wiLlwSXo1SJYvVciPNDPwLe/VjKqiwFWYD+3xg/nhnydnyvToS312+nrhhC/sCLQNJxJuqOvgwo/pxDureBwn+zYwdw8mhbH7ooHTu/Cz6GEj2JW1xyzenaWdic/1lFq6xIviPlG2IfdYlfTQhXHgdYRGrRe0g6C03YfYgE8nBfYHcMk0i/imm9TAUp++mQ+aW8W2ISj6W5x8aTeKw+IhpyR791YHF5mqs34KupSBuS+z8CG1w/hoPVVB4tger4K6gW1Zma3w+Twi+IZDPgr2McyJshXLZvymZzOIOQtxZuKoJIuF/1TAVQqozOGnnCFnW9n4d/Y0nrmfWZELssmDJT123f+Tl+Lpp67HoIXDyJTx1kCseQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(6486002)(478600001)(6666004)(107886003)(2906002)(6506007)(86362001)(36756003)(44832011)(8936002)(26005)(186003)(2616005)(1076003)(38100700002)(6512007)(7416002)(4326008)(83380400001)(41300700001)(5660300002)(54906003)(30864003)(8676002)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQjucrGEoDoO4I4mbGI4/qjKC+Ljw3Ba9wYOn1eigdqNdwYuOyTqKixvlqRn?=
 =?us-ascii?Q?PtuyWDwoakGss+GP6rYy53mSLXLdo088xCXdtiwXHw75/rj0dUcfEjPx13xk?=
 =?us-ascii?Q?r3DgpBE+5AYhpAjfXRJybwLxW4ygBZbfzKzyxbAy27/TGlEiIfCU+spjdB6B?=
 =?us-ascii?Q?To9iXsgMyF+T3VxszhOBKBByb0CDZBDEEZyzIDdSqiyf924dwV73dZNWPj1k?=
 =?us-ascii?Q?d3AVx04umQn4MfbEkmnSywAHZszyhqcOc5LXX6kHjT6paLssFxXgLXXtyHPe?=
 =?us-ascii?Q?FGNW1/nY6cdxRv7qZQHNxnNAOv8K5ROK9xtw3DmDi9szSPhU2/sG1pb+CURv?=
 =?us-ascii?Q?s/znvDvEsLQJFyz/ddxZoW4OS/mbV6yPZk/OpPIiDW3s/A98p7uRfGNXIja7?=
 =?us-ascii?Q?mv8CO4YO7gkP5m+JEyT0wAVOIgxoZhrRGB8x00kXEhg5rB7qRQljZM55kOf9?=
 =?us-ascii?Q?nED9pULGZ481cVWmkLFlTe09hwcjMoUF1X/GcGR3YfoVFJ3FKzVoMS5VbxYR?=
 =?us-ascii?Q?Bc968b4DYt382GULSkA47vHqvY5NB2MCF1dHE5AXlxv/j0pRHl5d17KuwbwC?=
 =?us-ascii?Q?F0J0c8UnYbllrbgsXoHOZLGcFdFakNu5Lt+LtcnDrqNLCuhfGI/c7PbZHy9Y?=
 =?us-ascii?Q?KV5ksvs24afqds8derSYZ8yRwlYJWBbv/YC/qSD3fV0cPKB+qBKtQNKp6ba6?=
 =?us-ascii?Q?5VkwkGA7T0Uo1lcFyrQ9uItpAB5Ovd4tKoas/I+n+LgcJps7c4V0T5QFRe+k?=
 =?us-ascii?Q?cTpUJyr4kIoFREWW4L8Xk+hUoZRMXt+eT9YyLp6CfKjnK9QezFLQe34+vgqg?=
 =?us-ascii?Q?Gy9kNJScZgkaXBpRJYpscwCNdpUaOpq9bjZ6MQytjeUev8MtPHovdul6ilga?=
 =?us-ascii?Q?EL6wLKb33MPb1IkxTuU1Wd6eUjPAFKrDXRMYHq8iIc6FhEgi3jpuulnqLjf4?=
 =?us-ascii?Q?T6P/Nabyw0QAjuYpRuc8hywTsx1LufHbn612CLz5pWOGeJsQklTtD4kw5uek?=
 =?us-ascii?Q?xRJ9XTPvBFEP/2ZC4B/lfaxCVi8FtyY67UnoeRtcvX+dOoo2b47KDCjJWPXL?=
 =?us-ascii?Q?p/khqZvBZcRcXkozkZ6FD8HNinA/YuU4FY3kJ/kXYhXSiEM4h3NLmZ60QyxR?=
 =?us-ascii?Q?Y+SXPrEVZBh2SceUv0raeEmodWLV8esvHAl4Psh9fUBxlkAb5eu1S+Po12Ac?=
 =?us-ascii?Q?8TfRII3RxaWBn532W6ILHL1mbEhRfwsqo8awatYrV+8Y+i1qPzHD2B3dIDvx?=
 =?us-ascii?Q?G1gAzwFM75s5rhIirTxFgumHGhOvsZ1ZQposuUaGpISPcMltDulYoDQyqLAB?=
 =?us-ascii?Q?Smzk1gf4DfeS6f87BIl5+zPlON8pki6F5OyAvd2D49H4li1E3O5j28Z9c2nC?=
 =?us-ascii?Q?T+5Ztpzf5B1WGZY6x7ESZYvXagEOdgjnv937dYyEdgoOimHvi0+u7iHmz8ct?=
 =?us-ascii?Q?kZMSo15mE8KwBBtWeSXfAbwdzeqzwPus3lnT3mXkGhqHi+zzbOolXGnEQUCT?=
 =?us-ascii?Q?2dUvah9HDLCYJTZf4JMWCUIFt2Q71pBRXX+6M36MmnHvksdxbgL/3KVROBg2?=
 =?us-ascii?Q?oxeD97ti85+pAtoJWnMRZM1JzzdHYvTo++4Yn+GSv+4DvVsfP1Zy5Gp3soUZ?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e750283-2837-4f3e-4907-08dadc9bb171
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 23:50:49.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaUxx9ScDX1AM1V/7sDtjSC4KI0aba7lBXk/FRqU/ei8Tnptjup06CnEZm5jOoKTsazeMrZj9YCTvnsgWOtI5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120205
X-Proofpoint-ORIG-GUID: EN3FQn2shrErLAeaURxwEzdCcq13IfjE
X-Proofpoint-GUID: EN3FQn2shrErLAeaURxwEzdCcq13IfjE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
removed the pmd sharable checks in the vma lock helper routines.
However, it left the functional version of helper routines behind #ifdef
CONFIG_ARCH_WANT_HUGE_PMD_SHARE.  Therefore, the vma lock is not being
used for sharable vmas on architectures that do not support pmd sharing.
On these architectures, a potential fault/truncation race is exposed
that could leave pages in a hugetlb file past i_size until the file is
removed.

Move the functional vma lock helpers outside the ifdef, and remove the
non-functional stubs.  Since the vma lock is not just for pmd sharing,
rename the routine __vma_shareable_flags_pmd.

Fixes: bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 333 +++++++++++++++++++++++----------------------------
 1 file changed, 148 insertions(+), 185 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e36ca75311a5..9c251faeb6f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -255,6 +255,152 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
 	return subpool_inode(file_inode(vma->vm_file));
 }
 
+/*
+ * hugetlb vma_lock helper routines
+ */
+static bool __vma_shareable_lock(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
+		vma->vm_private_data;
+}
+
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		down_read(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		up_read(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		down_write(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		up_write(&vma_lock->rw_sema);
+	}
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+	if (!__vma_shareable_lock(vma))
+		return 1;
+
+	return down_write_trylock(&vma_lock->rw_sema);
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		lockdep_assert_held(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_lock_release(struct kref *kref)
+{
+	struct hugetlb_vma_lock *vma_lock = container_of(kref,
+			struct hugetlb_vma_lock, refs);
+
+	kfree(vma_lock);
+}
+
+static void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
+{
+	struct vm_area_struct *vma = vma_lock->vma;
+
+	/*
+	 * vma_lock structure may or not be released as a result of put,
+	 * it certainly will no longer be attached to vma so clear pointer.
+	 * Semaphore synchronizes access to vma_lock->vma field.
+	 */
+	vma_lock->vma = NULL;
+	vma->vm_private_data = NULL;
+	up_write(&vma_lock->rw_sema);
+	kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+}
+
+static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_lock(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		__hugetlb_vma_unlock_write_put(vma_lock);
+	}
+}
+
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+{
+	/*
+	 * Only present in sharable vmas.
+	 */
+	if (!vma || !__vma_shareable_lock(vma))
+		return;
+
+	if (vma->vm_private_data) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		down_write(&vma_lock->rw_sema);
+		__hugetlb_vma_unlock_write_put(vma_lock);
+	}
+}
+
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+	struct hugetlb_vma_lock *vma_lock;
+
+	/* Only establish in (flags) sharable vmas */
+	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	/* Should never get here with non-NULL vm_private_data */
+	if (vma->vm_private_data)
+		return;
+
+	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
+	if (!vma_lock) {
+		/*
+		 * If we can not allocate structure, then vma can not
+		 * participate in pmd sharing.  This is only a possible
+		 * performance enhancement and memory saving issue.
+		 * However, the lock is also used to synchronize page
+		 * faults with truncation.  If the lock is not present,
+		 * unlikely races could leave pages in a file past i_size
+		 * until the file is removed.  Warn in the unlikely case of
+		 * allocation failure.
+		 */
+		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
+		return;
+	}
+
+	kref_init(&vma_lock->refs);
+	init_rwsem(&vma_lock->rw_sema);
+	vma_lock->vma = vma;
+	vma->vm_private_data = vma_lock;
+}
+
 /* Helper that removes a struct file_region from the resv_map cache and returns
  * it for use.
  */
@@ -6557,7 +6703,8 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	}
 
 	/*
-	 * vma specific semaphore used for pmd sharing synchronization
+	 * vma specific semaphore used for pmd sharing and fault/truncation
+	 * synchronization
 	 */
 	hugetlb_vma_lock_alloc(vma);
 
@@ -6813,149 +6960,6 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 		*end = ALIGN(*end, PUD_SIZE);
 }
 
-static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
-		vma->vm_private_data;
-}
-
-void hugetlb_vma_lock_read(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_read(&vma_lock->rw_sema);
-	}
-}
-
-void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		up_read(&vma_lock->rw_sema);
-	}
-}
-
-void hugetlb_vma_lock_write(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_write(&vma_lock->rw_sema);
-	}
-}
-
-void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		up_write(&vma_lock->rw_sema);
-	}
-}
-
-int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
-{
-	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-	if (!__vma_shareable_flags_pmd(vma))
-		return 1;
-
-	return down_write_trylock(&vma_lock->rw_sema);
-}
-
-void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		lockdep_assert_held(&vma_lock->rw_sema);
-	}
-}
-
-void hugetlb_vma_lock_release(struct kref *kref)
-{
-	struct hugetlb_vma_lock *vma_lock = container_of(kref,
-			struct hugetlb_vma_lock, refs);
-
-	kfree(vma_lock);
-}
-
-static void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
-{
-	struct vm_area_struct *vma = vma_lock->vma;
-
-	/*
-	 * vma_lock structure may or not be released as a result of put,
-	 * it certainly will no longer be attached to vma so clear pointer.
-	 * Semaphore synchronizes access to vma_lock->vma field.
-	 */
-	vma_lock->vma = NULL;
-	vma->vm_private_data = NULL;
-	up_write(&vma_lock->rw_sema);
-	kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-}
-
-static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
-{
-	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		__hugetlb_vma_unlock_write_put(vma_lock);
-	}
-}
-
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
-{
-	/*
-	 * Only present in sharable vmas.
-	 */
-	if (!vma || !__vma_shareable_flags_pmd(vma))
-		return;
-
-	if (vma->vm_private_data) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
-
-		down_write(&vma_lock->rw_sema);
-		__hugetlb_vma_unlock_write_put(vma_lock);
-	}
-}
-
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
-{
-	struct hugetlb_vma_lock *vma_lock;
-
-	/* Only establish in (flags) sharable vmas */
-	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return;
-
-	/* Should never get here with non-NULL vm_private_data */
-	if (vma->vm_private_data)
-		return;
-
-	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
-	if (!vma_lock) {
-		/*
-		 * If we can not allocate structure, then vma can not
-		 * participate in pmd sharing.  This is only a possible
-		 * performance enhancement and memory saving issue.
-		 * However, the lock is also used to synchronize page
-		 * faults with truncation.  If the lock is not present,
-		 * unlikely races could leave pages in a file past i_size
-		 * until the file is removed.  Warn in the unlikely case of
-		 * allocation failure.
-		 */
-		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return;
-	}
-
-	kref_init(&vma_lock->refs);
-	init_rwsem(&vma_lock->rw_sema);
-	vma_lock->vma = vma;
-	vma->vm_private_data = vma_lock;
-}
-
 /*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
@@ -7044,47 +7048,6 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
-void hugetlb_vma_lock_read(struct vm_area_struct *vma)
-{
-}
-
-void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
-{
-}
-
-void hugetlb_vma_lock_write(struct vm_area_struct *vma)
-{
-}
-
-void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
-{
-}
-
-int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
-{
-	return 1;
-}
-
-void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
-{
-}
-
-void hugetlb_vma_lock_release(struct kref *kref)
-{
-}
-
-static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
-{
-}
-
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
-{
-}
-
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
-{
-}
-
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
-- 
2.38.1

