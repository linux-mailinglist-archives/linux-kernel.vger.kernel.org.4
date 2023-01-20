Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA0675CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjATSfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjATSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:35:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E96603A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:35:49 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBrB2001476;
        Fri, 20 Jan 2023 16:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=30UW3K4uY8BKAFFhXpEES3cePI4stCSyAmJYk/U8JDk=;
 b=yqH5Z1EKnEPVgENY+B9cCm8+/AVADqJ6Z7zzoSAsecHxSVKVdu3N4wGmNffJnoDLyQVE
 de8tQkvRMl7pUUCbP40DpZjUccxKb7YVhksh6kSGgJYxdX3F/DzfGLET83rI+La0Xy8r
 b9NpNMxKHjU4MPRNfALpybWP2cL45VHmvKASfmigPlWz4hpt6pCTa02QO2gLHyLntUJo
 hTwyAHkCE+F5AU7Gs5HAYxCE8ACc+XLOSVLDGA0yzWxcWVdpHuv9WgmZP008PVAB1NQh
 fIzwSltd7d5H9as6bj1rJxjYlwZzy5rJf4DYRRLveIALXxfA0FnugR4Zak6PBqPlSelw zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaan2xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFHZDE018746;
        Fri, 20 Jan 2023 16:28:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quja07e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht97rT7zuTgKVLy5kwST6K1yAFXcY8JuQlWOTZrzV0J2gAhDc07CRHju2P7CR38EKCTfUp9dvF6UASMff4tL/dzmnMGVIOj3/y1Ltb+Rf5VWut7gefXal8ehMwfEFUB/G3HIo60TqFprwLMAkdZe1r1AWYTe2AfrPaUYFtEUdGZ6F+FCrpgKOpHhVqhnJeQlyImZIzLMPzcVaRNrBWgP8vYVMGlkk+yiPz6cFdFGw59R3Brq6A3TXSiqhd6ubXMvZTJT5PJkZPvUZyfsu+1Uu/QZgQry0JhVnyDA9uJiKvMtdDMatufPVuWwgpF1MF1un4lnFbm82bubw2xYhgcpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30UW3K4uY8BKAFFhXpEES3cePI4stCSyAmJYk/U8JDk=;
 b=MAWrNMVRSgwgluFbJoHeitiVZwnHjgKAG3JOFVrI8M3NpFF7FnZ6RjCxwBg/6HY8Xpglt/dnyLPJssmv2Gp2ujX9EmuquG7ZJdnPBuiWz7Xb5eHdEpsHTDFQ4XHoivzONAkQOxhwD+T1hdXYywAr7Yip5p1w2TvDx4+eMBld7tn8BE/lQSjy6cOXKVGGhBbgNE63xPkZQLr2f+u7x87d8QaRuVcWg0OSg3USz/uFFyKxCAltXdWsQPj+0Ca2Di916uIzkh9Pit2IKlxZYEgxDBbC09NfNnL8MhKztDdFNYe9v2QupQ5clcYDqpuVFTvbY8LliE+6s5uoqTLZwx4PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30UW3K4uY8BKAFFhXpEES3cePI4stCSyAmJYk/U8JDk=;
 b=vR8PoSt2RMnEQ+Uya5Dk+GgI2aFeE8j1TenNq6ZfyWMy0ARe+JDUQjyZi/ii7Rro95K04nArW0N1kC0aBOJh0PCPZN+5NCene/GtDOh+eCkLC5Oppn5T7iBCgLlUODRfLZ4LNjrGKqBMzMS1l00h8+2tQbrN2a019EuFvMJLQUc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:07 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 22/49] sched: Convert to vma iterator
Date:   Fri, 20 Jan 2023 11:26:23 -0500
Message-Id: <20230120162650.984577-23-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0028.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b1eb2c-0179-4172-601f-08dafb034fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAW8YAvfm6NfnAsMzVphp4eD6rw/qDjls1QbZ8CMXuFAT3VU728ksmScmSM7rknLfZA5QIu/7vz9xcPYGNsumd/aQTu7J72rCC3IwmbJm45oaGZSrNUrHbQm3EibuNRnI7F286sxWudhcfhqrUMz60Q4ykqBPH32/ALL3FXWrgYMp9BcHQdDxyt/zLPyEdN7pFis/w2nCvNKMLm5uPIRg20na9XoGXOAGxiiPKhBdr2YrIDGm7nhX83Ofvvcy8G6yqMewStT6KaUvc+h8TOumEV646mSxg3Yx8CAXHL9re06fjLnCMUvNSO3Ll/wOqsJOO3+8vv6Tc0eErEjeaMPcfFpqvJg3A6/GuY7ufwvRojAlahi/bL/+N2a83wgVCXWNkkc8FASEGDxFsDJpXrSWeAh3LlBIULUlKOt+RpVqv27s6F1wgYyUBQ9eKdzC+0dfuNzVQHnaWhcHGb4J9zVI/1GZ0gimzaLnWK83iROztnn1znwzHFhizT2DfSZPK3aEEBq0SNvm8MQRNk6z9Jk9pAJEi8JRIALBet52LonBSR4QCqBgjOVnhwse/zEcl1QF6epYqYjn3HJ7WtFBBQUvoWoasjEzHPISbvWH2YsvvGb1BINIOe1/XAvnvsqkK5wCLmD0dus+rfb3HEMkYw3wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IEeGcSnpCIwYmS0g6wl0aOccf0WOGxXpT8DdqsQze3FqcJ+QGeCPeoFMI4qY?=
 =?us-ascii?Q?MSF/mclX9nooJ+OoJJ+yYd/j+XXVlHhNBlqjag/klkGMVMlqrU3VhFmATQrN?=
 =?us-ascii?Q?YOxvzq5JDU2xsbBeKFeVsDHXyjXR7XrghGqQMYdTaoIKzaTTOiJDd5uo06KJ?=
 =?us-ascii?Q?C+xrUpFedHPDmrQ0tFgUz1g0sP8MX5FjhjgeUbTv2vw/LrjNyLkIaw+6M8Yw?=
 =?us-ascii?Q?xsIWWQKk7UwOgWLStOsSNmfyXKXSM0VdAEMs2bPUxfprJoyoClyM+1DLymfW?=
 =?us-ascii?Q?4SR7Z90IZj5lZ2iBiKP3UZEHZmOCMIWbOlEVQxHc+dfXrAn8qgTCf3GvRnbN?=
 =?us-ascii?Q?aapyJZpxL3Vykv5rDXoE/ddHO///yTl6L3Ee/6oFfAcS1k6M3lr0yYIpYHcH?=
 =?us-ascii?Q?0EoYqcGtfjXRtZzTtoK7UQrqysIb0u065/7FEg268Mao0FoXJ9zwN6RnxfOQ?=
 =?us-ascii?Q?VUXGoT9Tm4spTgAELbkfUXBYOPRJoEOM1/pml3mAfPmm1vVO+I4gT8r8nf78?=
 =?us-ascii?Q?sRIEL8O2piPTYZ1AHAyXNPCKnM+UqtYt9uprNFfMKxVYTy8OS8+rox8QLnyW?=
 =?us-ascii?Q?6Xe/CFtHaBDyrqVTAjU8qVbzwe5SR7kLfqenZdzq4X2NlaWSJuWg3h+Irr3k?=
 =?us-ascii?Q?8xU9fhZnWmdLQL7cp3A4yHIzeaypN1s+soc9bKg+QHMpQcIeKwR9yu42E5hF?=
 =?us-ascii?Q?eRD93GYkXtPJvBzR6KncGr+iUQfr2OFuONXYFsmHVVMni+NaeWGV/xVlfSZZ?=
 =?us-ascii?Q?V+YcIc8/QCcTq3AVZbv/mpOV2uz0WdaxURLLRFnZN4eBfO0RtBsZmsZEEC6c?=
 =?us-ascii?Q?6hTPL3f0uvm59d6otdw1gGQoDpC6ij36p4jwze4IZpn7mmErQ4MQ/A0AIz2X?=
 =?us-ascii?Q?XZw+VvCQoWpPnlq1+SIz2Yw4wQ3MJPY3ySmqPS0UF0ueGohCdAZbiaNeLYQb?=
 =?us-ascii?Q?nni6aycNQ/feXjS15oUUD9qdqeECxoVX5PwUOlpYIJN7YjfVdPUBnddNioEL?=
 =?us-ascii?Q?c3f1MH2gJ/azdWdWMRAJMCATjOo5Q14a/VtFlA/IKLwbAJwIAXIgf/okyfzE?=
 =?us-ascii?Q?SE13B+ytJh5yvHZloC1T56Ikt23erpy6DgxZ55HKBpGg3LUySMsrg8q6cVCz?=
 =?us-ascii?Q?dDZuHG6YxwGZs0y/cuKY/4wwZpFKoL6s1KM3i3wUoWD9gPePZxU11gBVTIO5?=
 =?us-ascii?Q?Fi83YmsZyUHJ8IiPhsRty/RAV7Oz3gETerfjqJKBlNPKo7TQsou5kUX7Z4WH?=
 =?us-ascii?Q?EzpUHcPAcmtr0KL8TyBkwdRkleB1PpXKOVCE5r/WHoREOQ7dc/siwe+w+jhP?=
 =?us-ascii?Q?mGIsg88tkuwCamsyIW48qBDdCdYa+xLmmZgL4x6tac+uXvAzDzH75G7ec+PW?=
 =?us-ascii?Q?zPLu42uYRTd1xnlslC33UewjVJeWeQflkqZABcZJaqvIDbF3z3cKGFrqtXRp?=
 =?us-ascii?Q?MNgbbkY4PuhyT8cBPh7/ZpP+27WRIzT+/TUVIt7ZggDm2XkvyOPaTmRaTGrs?=
 =?us-ascii?Q?tyMx6zGc8Cj9VDYHLsMVEvum+Ag4qyTuRsjUCzpg0mNw8ck0fDi5nN4aaCU/?=
 =?us-ascii?Q?gzzDSIn1ipwkcgRtJ5xnLpuKvwHRY4Bn8xpe+JklP97bf8vzbEpWBGxYcRaH?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zNcRx8mN+pgzvfY2O6iHcUK0m2m2yNPuD6yyTOCRT3VAfVSle7fhzaF9O0LxPhc/ngnbaB/2/1n3CgkHtveJS88M+RAh0hiSNVIzs5hqkBaKYlyBmqIUbTkTk/UZVyGEGnf8czYFPqIWBmML1CstTZJY5iKTZYdygr6pk/OH9+Vj0TD9Iy0RdF/BWgUnDmwDkuFgpm5cWuqcRfomh4UxMF9awxNFzIiZlG7e5tStnRjuBl4UbkF6gGhBnWVEOChMdqR1Mw+0hRy3BhvYW8y/pw9EHUITeOWPHnMojMntOnRbk5JmP7PmTSeUq/cNf9KnLyUtQpIEHHtz0+YNkJHVZb+fRY1I8c5VQ78cUXHpNV0JOTC392ZKgZ76MqmEa/Vpa8mkeQg1IpSBFT//giRmX/Osez4R8RA+VKGLXR+uMD2KiP7x/GWHrLb2t1COvfbswGMHba6ArAbPB4TNUe7U38dorI0L9OXXScNOLWKIDsYdYp5KuQJ5MY8n2Ti+3NsMDlv/GW6TunLRSXOcSQ6Ygibt3bljxU+99PQdsTMkSJiO9CGNsFIzK5d4EkqF9OT5Qv1XQts0L9LZudJTPcygSmbvJURYxrSBU4CkVVbpnqi06Me+ahdCIRAFoLcZN1gdeKzrmnmWmB5sn56DNu1jdBIAhgR9zsmsQTgVGgZtmYUs2anvAyL9ZNUHvdbKMx9dqq/mm3gOIyQdC494eQmmPUJ3vvxKiEqRk8QymRXUqHjzgpGyIf4YksErr6U4HBNL3yU9pN1PnS47UMyfhsMo2j9jfoFHT4uS/QtTE9+JeZlIrdXLurMoT3wSyo1u3AcUS/ptoFqBrn7SMYWUTeBMFn/ndBaQPYSY5Yl96W4z6g4Da0LRLZQILzqw85K4Jvf8TpZLeMo66O37vGfBjK9GJA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1eb2c-0179-4172-601f-08dafb034fb8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:07.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQsXwzQJT1ooLVzp4YhW2RwPUDY+QdgZN0gJsslMKva6AWVCA+vnXirZDT5tR1fXVU7R8BjkfTh/acxOacf+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: LAaaxzGMVOjS_PAlRyu1z8fc3aL_t3xy
X-Proofpoint-ORIG-GUID: LAaaxzGMVOjS_PAlRyu1z8fc3aL_t3xy
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
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..9c9950249d7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2938,11 +2938,11 @@ static void task_numa_work(struct callback_head *work)
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	u64 runtime = p->se.sum_exec_runtime;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
+	struct vma_iterator vmi;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -2995,16 +2995,16 @@ static void task_numa_work(struct callback_head *work)
 
 	if (!mmap_read_trylock(mm))
 		return;
-	mas_set(&mas, start);
-	vma = mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma = vma_next(&vmi);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start = 0;
-		mas_set(&mas, start);
-		vma = mas_find(&mas, ULONG_MAX);
+		vma_iter_set(&vmi, start);
+		vma = vma_next(&vmi);
 	}
 
-	for (; vma; vma = mas_find(&mas, ULONG_MAX)) {
+	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
@@ -3051,7 +3051,7 @@ static void task_numa_work(struct callback_head *work)
 
 			cond_resched();
 		} while (end != vma->vm_end);
-	}
+	} for_each_vma(vmi, vma);
 
 out:
 	/*
-- 
2.35.1

