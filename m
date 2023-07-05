Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C2748E25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjGEToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:44:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C659F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:44:09 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365IXhUR022240;
        Wed, 5 Jul 2023 19:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LDBwrKukA1W27s7eOaMHDH+8erEXbwg6C6gQbwSy+P4=;
 b=bhgIPPYRK10fo5YtD10ROB3CrvG71mMGxSZ30PYwAc/kSXVDUElFYZzPC/kx0vrW/p73
 vCJbVphj3VvBdVU366TQwizkraM2jYnwcZTzDjCNEX0VjhUfOSjUeU+fOcs9Vk4rAgHS
 Te9UJPF7lqbfv3P4y1ZROyX7LXwvoCnrtDLpOISK6hadYyjegEl4+K/kepD1wI6x024E
 0G0HYFNOD9yfz7HqXMR/gir9rdu9sxnQ+yApktwue9bvePR6UPrmsER4Scln1iP1irWi
 /RogqzH9FGuuJqwbQjnaKerupqUPFnf9Cy/F9m1yAlOuAnNoEosoxlgyCkaiTOwwWDuv eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cqbk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:43:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Ibtu7007290;
        Wed, 5 Jul 2023 19:43:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakc1rvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsJ/hrQimeyRZJNPgJgtMx4LXDaXayXIrmlAHaw/FLXmBSyCFUNWh786x6gB9SeFT/RIA35P6ZzM93GETrvN9gOrcuz3IR/7nbY15llvAe71U7DNH2xKgCjZYDAa40g2PjALgyKT4R2eRZDU0r2FwEyX0YQ3/z3H2B87VyBKRhEeSGNP5nDyn8m1F44espcOV0B7s4ai/J5aO4ji9MZLSqjYs0MhtGYATBp22HxgGDuDYyBe9Eeg7go5iBCd3Qf9GgV7PO86WG2ODi8BWg9Y9xnyEx9PzbogHVA6B3mJsXq0KrEh7uAjV5neuyMkFWO6KNRvKa6xt+VEXpaLAaUCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDBwrKukA1W27s7eOaMHDH+8erEXbwg6C6gQbwSy+P4=;
 b=RurhXM21TtBlnB9f3HU6PYNoJPc6IKWw4AJUlE9zQEYTKqs1UgwlygVfDzT3haDOSraFL1Ol8YvVq5NarN8RraGeH0tYEjYzQVhpoDN0GAMZPlX70A/fPtLN6u6C2AgEvPwgcH/z9h9Eab+dQK59U6l0Zv/UxF4a6wukYwg5r/C5ooVEToWZ5wpqBgEI1WzZmUx+NZdHwtpsJZ7yEWLRPM88NsJPH5boH9Cso16U42FiL8WmrBZXqpXxMCeEQAUhxkG1LxdwFC7ZUSioDxYqkRMTVwsAGKTbgPlcB8UgEX7mrctUXx5aEOdossa4a2yki/a2bkyOsPomPzc4Fqtuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDBwrKukA1W27s7eOaMHDH+8erEXbwg6C6gQbwSy+P4=;
 b=i3MucXkzYyDrwh0ISJ1VGP9V3GiTrFwNBSRtHUZUEnIypPIG7Wo//LWM37nDdAg3QXWp5AHUHuY3YLi9iCr/lZMwnRbCsiEYEcQf3zdbNgJJeEBcVQkknvGKUN7+oEa1/BGaf4kvNdqu42nKJMtTk/k9It4zH6CtKz92uJX50bE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:43:54 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:43:54 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/4] mm/memory: convert wp_page_shared() to use folios
Date:   Wed,  5 Jul 2023 12:43:33 -0700
Message-ID: <20230705194335.273790-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: bad443fc-e510-4d10-d13c-08db7d902a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gkX63AxXbKqBDK3TzYKFiXmbFxica8FqxN1axuLAht1jXk2ODR1nDRuln0dQPmXe/uIDiLmGf11Mc6R8woucMA3VP7MNtAsevW/NTAAwCmLoWEcRXOJhATht7cWt36xpuN7CleLW7SdgJrT1lSiOTrzGjXNjsTpbHDyLzhQGFTiBF3tf3NPket0nHxRcK3NmBgQElc4AVGY6HY+47wymCjrMdrGdjPmks9Qh/BbSSn61ZTt4/PxgfjocFyYFptj+mvtUTWpzo4F2BCOxxPT8sR7zuuDRkIVHGeW2edi3t0FQ2ZP4aefrLnzqWkhjtTBx0zXy3fC9zs+WNY/NcN+IpZEbb/DeZS+CdWglGjZLTrym2VF7pBn+kemm/rhvK8V3AwG758+/qUDVViBbjzY1rvp1DYatkQQo6cZJtvLUdEag+/19kts6bjwaE12qy78hojQHtSfsSQj1vHmeTkN2LZMzsX46KuYibcURKrxVgmyhKj/l06xdkB//ZtNWOogoVz/CtsP6SNNQZoLjf9rlkHxFALl9vk3I8nUZz2nCtIGz6zvnWCnGZJlVUb2Do36
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(2616005)(2906002)(83380400001)(38100700002)(36756003)(86362001)(6666004)(107886003)(5660300002)(316002)(1076003)(6506007)(41300700001)(6486002)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(6512007)(44832011)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F348Z0bOY7/ZSPXyhq286c3S3afRi87AZkWLG7UZXxZGU9PXruT97cdGa93M?=
 =?us-ascii?Q?WU0VdtnMGgG0eGRQ/awGsHJMqIQ0QqHWoPSGE3hDfsYCQnDCPLemS+51xtUc?=
 =?us-ascii?Q?4c+GMm6YF9l95viK9GPagh3+X9Af0nPvq3wO04rodO6W28PqJVKBCd1mSMY8?=
 =?us-ascii?Q?GVl11Vgoao3l1VLGufI+5IYr2F1wYcLLyaRARaBKsQPQwQlRTXT90mxEmpLp?=
 =?us-ascii?Q?p13kpF4XXGXesFi1h2vp6feLqo9J2v/CZF4RKCM0NhHoU0cIr336HOQ7VxZA?=
 =?us-ascii?Q?cPEr5vTe2EwiLALMXGjms3OnqDi3vFM1Gzm4wCJKhylTmJajvXIhQEqW0Kr2?=
 =?us-ascii?Q?BtL0iYqKa38kQGy8oiFYubGspbfjSeCMfnaBBFujPrVQDf6rE0F01bpTO817?=
 =?us-ascii?Q?mJbPij6dW4AwYfCrTHXJZsjUaVOx/kSHkl2+GLoZjjrUp6OTHAVRqnlo8Jbr?=
 =?us-ascii?Q?f0HNO3gtfz/Gf+6bWyfYWZofuJgNxuUPSSHvmeiEmgjxFGWpM6+ZLkWO1dxG?=
 =?us-ascii?Q?f2NUFuU7yllY3Ylrzoq9jRT4qjRTj3BeeT4YFsSfdtDxwYnpv2dpJ4yZ/Oui?=
 =?us-ascii?Q?gTaZFS+RCrZeYDoxF0eDt4HSNlZD7d+yMr4zD2h9+rc+r2k2lVE1ZoMosN4Y?=
 =?us-ascii?Q?5/FS3BCtXJmL32cnlB7nnAu7nyyxgef6/2yMcAGr7AKuFQRiXHhhX0KkP+qu?=
 =?us-ascii?Q?GaREspROaPJRnYQ5PtgDVHHNiblvGpCk1bQYL9eC9jvwjz25k0B/7GMQmsDZ?=
 =?us-ascii?Q?zUMLap4E5vtGLmOTYDzwYiRDXwzy5raI8OfhQ+MNTGTpW21Y7Swuh6AUmcUi?=
 =?us-ascii?Q?SP6fBQJTdk0Ox6I5KPojkUvFtUahu4W11Zw6KDxFUwwMbUi+8fG/nT4N2vHP?=
 =?us-ascii?Q?bEqfSZB2e5PjS/6qNEyO64kNNYhf2XCNQGTuheoEkao1JEn9QPBFIEUNVfZa?=
 =?us-ascii?Q?p0yNZ7TQ7FDsgkVzB1pKM4pXxvj44xZLh45cpLqpAVjZH+9d5DMSIvze4dQZ?=
 =?us-ascii?Q?pIEPOEMM/9sx+V3nkTzlPZXYnUAfAeERbcf52JiU56MYaHas2Y/Du8Pqd5zk?=
 =?us-ascii?Q?GIN+Ew7Nbv8t8EkUGInVmqeYbN9I/MDkiCDQ+BqHk17YUNADFnCmDIKoze5Y?=
 =?us-ascii?Q?ZQQfxOYifrxOQadwlrfaJ0nvFfsGjiVyHA/6fLxSBLc509dKJC0k3onb3P/C?=
 =?us-ascii?Q?+ACvcooMnfiTBjG4u3oLI5YLCHKbSQqXnzc5bIqVScU87eweS6CYQmvLdXFO?=
 =?us-ascii?Q?IDihJeN043SjnnBvrLKattE3OA2lbxC3HmhkmwHAtgn4w2eomsyTfwz+Rwk3?=
 =?us-ascii?Q?rdrYu5urbyin5IllOQdLaj+fnMyIqq4FY0NhCxihFj0HE6bzCLHrSrzYs7X5?=
 =?us-ascii?Q?uwDxmEsxvrG1q5APd6peYpoDgNXCBbciA2PL2Pff+165H/5jKL8L7AC1/PqW?=
 =?us-ascii?Q?fHWC3E7tV+dEIxErLw8r1PTs24O5I7mHIW4hA6KUwr97YlTJ5GBPxhMIO5Rc?=
 =?us-ascii?Q?u0c8GlC51auHH02UWk4iSQbQg12AcFnqyvpvL6rfN3odbehMb3vTcMaVWqQk?=
 =?us-ascii?Q?LgvMdQiaCtw/tuuosw68fsfzmADpJvhtHcJgxxNKl9M1DJcdFOuc5kWtIjfM?=
 =?us-ascii?Q?BTY7/+Dtdjx4+bL9vz7ZkuE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dmg2IcRqslgrDrKXeshwXvJOLr+AhKnj120SnZbEXVfZeSKKjpLnnBeRXXu+7G2IjELIC1yyT4Tjiqj+aff6Fta3Hp6ST6b3kdQFcctHQFw3cG64fhAlXvn+QBENZh96BFS//4/afABCaN9UmaCD2M+ahyO7FViuSLcZDpGQx04wG7CMUEXMD1JvoNfJR6VH4kLr7G3dugQgfiK1m+r9O+7cCanwWH/ctGHzOG0OgVKZCOG8Ky1lR5gOexTAzfNMRU1QRLJlTvnpqMeyLclwooUvyBGJRqhA5sBYDJIIyd6XmdGBCVdDCNJAm5IrL0s0z58po4iEVAiWOEACQG9yivTWHM9z3xw4UCdVYpNMUSDpbpD1kdB2EBU7rzZkO8sd6i6PEIMWPZkxkJ2hXfPB54ABuLqO44M46blKMr3dqurILkcU1EUfKP/ZBuYQaCvPk85tUbP6wVPGGPG5bKTZY5Yk6zRhRsrzicLMu9Wdvuv8ZzI3qKllJI96vYmVmOGfIioHfzFw/anIVlPb2MSWIFR4xsnD4uR7nKoeVfbisnQo3MoGuRF3SQ9co2GRCQs44+ClfjYRosSHzPsFWOzWQc7/0aVAi787C2eFzLMng2RjqZjmbRWKIR4JLCVB7iQLqUp6Hmbk8ha2DRrdOObEfQCsRf9fGLJZ/Q0iHtDzP9ddHwa4MCM1+mOQnBjliH0BOl5Xg2cHa/5dVwFLOU/zX+ydKvGMf4nzpwIU0HRWZsZE4f6T00oji4919u7XZgGHyDRJzfpmK2JUDFkgrmQercu37ZnoqDaptKCb6ZYLMEL1M15TsrbBGdSgnevUltygVMToSWDVPcYKbctUVNh6gtPM6jUUH4KGK8wjPl8Ck0HGohCq9an6Rqe5x/Se1f3E
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad443fc-e510-4d10-d13c-08db7d902a52
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:43:54.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxjNFEcEwLGVLWayNnil2kseefEOWWfKFgRhNLsZZQ9J3f8hjG00k+cG6e3u3NymfyRg7a9EeALfHa8sIqf0lU7wk4NCXOtLqwJccD+Z3Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_10,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050179
X-Proofpoint-GUID: V2fimosQar6boSLQqZVsYItvz9w4-VGG
X-Proofpoint-ORIG-GUID: V2fimosQar6boSLQqZVsYItvz9w4-VGG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves five implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
	v2:
		- change function definition to pass in a folio

 mm/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e73245b791a7a..fba33fb55a010 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3281,13 +3281,13 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 	return 0;
 }
 
-static vm_fault_t wp_page_shared(struct vm_fault *vmf)
+static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
-	get_page(vmf->page);
+	folio_get(folio);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 		vm_fault_t tmp;
@@ -3296,21 +3296,21 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp || (tmp &
 				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
-			put_page(vmf->page);
+			folio_put(folio);
 			return tmp;
 		}
 		tmp = finish_mkwrite_fault(vmf);
 		if (unlikely(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))) {
-			unlock_page(vmf->page);
-			put_page(vmf->page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return tmp;
 		}
 	} else {
 		wp_page_reuse(vmf);
-		lock_page(vmf->page);
+		folio_lock(folio);
 	}
 	ret |= fault_dirty_shared_page(vmf);
-	put_page(vmf->page);
+	folio_put(folio);
 
 	return ret;
 }
@@ -3375,7 +3375,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 */
 		if (!vmf->page)
 			return wp_pfn_shared(vmf);
-		return wp_page_shared(vmf);
+		return wp_page_shared(vmf, page_folio(vmf->page));
 	}
 
 	if (vmf->page)
-- 
2.41.0

