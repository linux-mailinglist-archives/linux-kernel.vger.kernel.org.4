Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4415675AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjATRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjATRPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:15:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DDBCE09
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:15:09 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEBVE006199;
        Fri, 20 Jan 2023 16:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jvGRonmR88FIxOII41yKkB5nFfLvuceSsWnufY5SqV4=;
 b=lDqybG+ygqCgGZNplUZlHIzlqRSPZy5ET1BEOWSEBXzJrnm+JKDxYFsULDp4lVmzZaie
 uEIsa9wJaMV7HtLe+9t7bZZCFZZWA0Boh6AJbKjQDZRIzvFSiDsJZcqePoLfHl+crUZO
 jY6mjMi5TDkf8V6U3mlUYTq7OEzW4BQdL/Aw0CLClU0XPgpjUPmxFGBSuHMNb+mCuKDb
 dRk2JleD49ODR8UIb5w94tp0Io4nA+bQx7gFdhHWQr8WBNkdSpKBSin+AxD+kxEgtefA
 5mx7QP88X9eBoWh7yrKfCpYWugCAkgR9v1Nf8QCi+Ix6tPrjGk1yqU7X7lqb3/dY/06s RA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFOoWF000777;
        Fri, 20 Jan 2023 16:28:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2svyb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpHL4vWnstRpavEh10ICJa7PIJS+NLubl9sBGYLh6NBQOKdpoNf0BE5wayglKl/25riaK/yrBlAapGU/kMhhDDppiRtMH9uWQpSCIUf/AAEnSkyqyIEj0nzWMjj1bX1wqcwCzr1FuAylALwVYC38qNoCIKucFwHj+FbIMuTeIyhKzud5u+8Rk5GeGU2PFyjKLjbucBgjTOEVDfeokaHJnPJGTqkBDvzG8y3e9sMshOVfQ7PwSArTDXKPHX/B922OKSYwwyjM3Cq2HeU0DYHAxxsPRi2YFFU4PtRtDO68w4sjrvNlfcYYXsn0u0cq/M9d2FbhgVALyCaKaF+egCSeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvGRonmR88FIxOII41yKkB5nFfLvuceSsWnufY5SqV4=;
 b=AZg8VBS6gor3ZsNOzNceAFzh2bw1/Gyo/tcPK2C1iCFRpYbKHZFb//Yn7WgJgUahFJP/dgongXoe+3wWZFRHhyaXVGs4C4ZLTulY/TmVblvh2cfdGJW77VLvhp2yMQmpxBimiNKax3h2C7joIn5Rfwq9T20sYyrlnGm77t8MWg0CCbEG6RxwqlgcwU1oRu+z6ob8E7oSlbG1lERUSO7VXorVA4WeShyIdVNmjGqpGFz6dSS14FI0WEnEJsCeRLXu49zeltvNja3sXmysXhC6RrtfYN8ZaGH/UwwGKi3yuSUuYMQSS+ZRcoPPH8XXpDNK3D3smfZ5UHvnZTJf0hqBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvGRonmR88FIxOII41yKkB5nFfLvuceSsWnufY5SqV4=;
 b=fhhmYn29+fQNuP014iRl/ooKeQCopIR4cfwzwUMCFwZlLY0q1/ytQT2H1OslPCO49uTfY6BlYI4tdV4ucUHJ+CDVJdFX7XkNkZg07J14YcHSuZoDpbJROjDpykE5lLjEsLRZxe4hogFlbDg+2J4KYcMO29h+NnMMUXmXur6D+Wo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:20 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 27/49] nommu: Convert nommu to using the vma iterator
Date:   Fri, 20 Jan 2023 11:26:28 -0500
Message-Id: <20230120162650.984577-28-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f10b2b4-b637-4ddb-53dc-08dafb0357cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nlTZRVaxCHxoFISU0sXcfQ7SnHrsYk3UL1all/30q73BVgKJ+WK5aZEOF/tf0OZiA6bnTULThdCC9M9VbEMuYBOySGyK1YmvRtNlhpofpkwwdQhfduKUGpT4ZC89iP+p3MCGrUk7EvQMQJULF+U9eY5vCbt3zdBOh5jjFT0aeIwZ1WHu2SriwCzJBnK2KH3OmHqLzOLT+TpzSJUenvN8+NmIqxOTGE8kNgOiPo1jMX2oNXZ5Hsho2aeMjKps/6apt1A3rxg4uGzg1dwmwE/DpwWRaPwC3/XyF6s7Y2POb4F+lep6vmV2cat6Jr0RewS8GNthIPzhLS6eyoMNCC7ObDAqHbW/0kiH1NMGJPfRSqsxRS4Lhkxxf91IzBGt/34NWMwqZRlJ5TEPNo5N02eDD9TnQjRfEQVbXQMcbpGBUELpnkXXaoMeogVJHlHzaLp2R38mQ3b2ktwHhDakRQfs5vuhamt865Pf1xW/TJF6n+MOSS8wKzwflisKOUXtvjjo8VxcpQep3ZS9742L7YT33FmDe3H72mZrfp3S6qUrXS0MTry+nHY+nz+O3SuHqeeClAnyyyBdmsZHukKDNIbaAnwqkwbOOHnIhbxaN2C4Q77lz/ZW/6DpxGmyAY20jS7dlm2KoirdlXpyT4k5/p0TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgRc3SozPIyr83I1ojbVWku6//SVQSBNJ+LRoyQnCdSRSU3fn51oojjKaBBx?=
 =?us-ascii?Q?2TCV4jB2GI5ZdEDr287/G/nsa6rRLLdMMV/pi2GCi46AomJ2AslkI5y3Ehk9?=
 =?us-ascii?Q?vKWEyPDEt65LDQF/J6gY0CIyhxfaapCdP37sVVBVFjpJflLcyYfgnHu2AIni?=
 =?us-ascii?Q?E6kUqg2X+2H9t8JAnVziq6wd0gGESRCfh1zbdLIxcgR7xf2UnQ7T8Vk4OTWU?=
 =?us-ascii?Q?5t9p8DhWK+6/9VF5v+EokE/YrZlpJLoHSyEY9gFvq0/VvJQfybOeFTF+h+BG?=
 =?us-ascii?Q?5txtv/noK1KZpvG33Kd7PCehg6tY0cmCzjaZUisUfPMljyS2YWneJAR7RUWS?=
 =?us-ascii?Q?tDY2KModnpT0ZvLuKuvQagqg4rgkVzeas9/U9tFO38YHAaPQ21ib0LWb4GWq?=
 =?us-ascii?Q?S/6FCXgq69axZrj2NjU4rjwEdotFZ+IA5kW6fbwkvC4N/iug38A68l/WYylT?=
 =?us-ascii?Q?ZsGoXML/eXG4MtHXGMpt+SIICqVBM2CMHYRvfFpZio7Y4CS7DlJDN9Cj321g?=
 =?us-ascii?Q?nDPEyT/hVrqM+Qr7XPz+FeF2i6weSnHankimjTmxeoGmhaBzQXSuQglOftX1?=
 =?us-ascii?Q?rnVEuU4TpeasoNmPJTJd+Jzy1vQNQ/aoT0cAKnsr14/rGacZFKHqtkBLYYo2?=
 =?us-ascii?Q?SI8NQChdNwhuHXYwGcfOKnAXT9ag71WLQrDXZJRTsVTXY4KWgdEg8qu/S51a?=
 =?us-ascii?Q?IiKzZ1E3EDTLY5dwTKr87cinTG9Yata9xw2iTkU0ZgD/7HOc1rcsrYGEwceg?=
 =?us-ascii?Q?nUy7zZKbuCEbYw6vmnj3KDfT1t9tfCy4kVuAZQKeDsdbUqXPTkV/8Yyj/q+L?=
 =?us-ascii?Q?9t137a5CEPNEcytH8fVSrxi38SMFFOhUEw7aLNYTaSL8g5gCx9VOVlNE+ZOT?=
 =?us-ascii?Q?R+JIj9QwgrAPQpZsPlVaL7osD+7+/YqWHli44PJIdzgMUaWPQOAcDydOKSUG?=
 =?us-ascii?Q?blgfzFPMLIIM/1raQ2FQLPMp6wDgaeJrl8wazaTvbh0f94v+sv7CDVCVTCoB?=
 =?us-ascii?Q?Bo/18nqrKuX3MnXv05ertMpmYYAKiXTEYpZoocc/5fNnxFidxPM48MOEYpLF?=
 =?us-ascii?Q?ANhEiG4bGaBmeQU33VpufO4sbCgpkwVn2c6YA43bS/3azD6OUqy6a23rDshN?=
 =?us-ascii?Q?Z+zoNsZBXh8ep2fvgK0l2JiWbpdtgua4TPP702A2OJ3PnhgcXO0A4rPIJUFG?=
 =?us-ascii?Q?Hi3tOBTsBoh6hHM17lz6+y6ed0vuCT0oPu4fwmy1pux3II9ibTvdPHh7Mgec?=
 =?us-ascii?Q?JBkmNHLTgy0zAdrn83mjRayu5C5iHuKX9x0sjaDmgJ3vWQOVH3CAVlUGf3A7?=
 =?us-ascii?Q?9ivgIi8SGnqGahRR4zC58HQRl/37LZJenSMCmO7cVSYxVJwIpEHfNty69N+2?=
 =?us-ascii?Q?PLhI96ysiXuXFDcRFSysYsP0bPJYRQbPbxkRBfMBMRooGLMSG8xQ1Qx652xi?=
 =?us-ascii?Q?OXmCG63OqR2/HZDfNHNbYJez8i+WI8ygZ+/spsY66TVsqEpXfcnRGx0VBL1s?=
 =?us-ascii?Q?sBYQUty+EWOavqRKdmxqtw31Vzh34ReVXmgCmV8Gm9NniMAjiGmB1+ZL68a2?=
 =?us-ascii?Q?dNjflntlRMnijQlksXcrwgrSOtxWd3ui+aIcON0gVuU43qHQPjyHsBzHs9fo?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V4rL4QTyOXtvLnolSpwVVg+cv55hP4ufyU8WTH7tCS8EoOB7atkx/NmCFwzPS7f38B6/+ADuXA7H3FagMd94EZzYFrAD0x7m0teI5kZaZ3H3feYtAMd7R8x9eaJ2IVQzXs6C0RGpvCDlZWaZMg7tQpMGQnDILbb6wvomzhGjsh80LbFxlHlS94Do9EesTzQy7k+Ziwa/jKjtZr4utZ/8ncRAxv8LJqkQqfWyiwHcNo6q1FsrJE+kuNbQIJs2NudiPOXUXkI0oJeOj846VWRbcll6nktmRq/P1qTeTEsAAXY465vyx8E3Cv8Q6tI1cxoakpLZmQ3ORM7ervomHwJfsOnWaSSnHDM5lxQgc14Z84GtyDmg/2nVFoO4FXKyDl7DO834f/mflawgyakWmz3ghFqytqk8JkJTf8zzA2mAW7pwui4R4SSzzva9O/Cz3bUZ4RYE9LVT6JnjauHDdIUcE+O6cPH3CPbddJSjSCOEq/YyEiuROryZZPVppiMd/ZwTIV2/N8F7HYv0bZ0AwpqjHyrkFHOwQyOuNaGUyM2X2Nw9nIEA5Zw7zsh0pdG03OEWvbnsggOsiNoB60Y+HWhfysUlQaoSBIlcZ3PltDgymSWbKPSfF/63A5hT533fxyFi0TeSjCSO/Z3ELu0MBDqQ14dTroiS1aGkULPgBEKorGhRwCS4bRZU1le8r1JSOjwXdgvVE5EYfD6LVy93qYhprAR0wI6lwoFpDTk4mC2pA8R7UGyHtZikpTUjwoAOcAudB2p9eB1GwUZk+8G6lJfPF7gc1CsWfpP/T+yR92F6TdRIyQbJpNq1KQtxKL+A364CO2MM01wSG+QW70D5Xit4MVSZKK1i/bGNlVKjMoJn6ZcplMgmNEaIKRligN8PTMrTcb7GOBRPqWwfgmG1q/wXRw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f10b2b4-b637-4ddb-53dc-08dafb0357cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:20.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCMZ7nSEivtOmEXQebSVA51Ldwwlut3UUP/CI/YnFhmcS1OzFdqOAhuAjjejXmhu3QTH9tlqtyvAhGtl5vJ/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: YXhcoNP4VdbQESVrmvjN5A4EIUQ-089n
X-Proofpoint-GUID: YXhcoNP4VdbQESVrmvjN5A4EIUQ-089n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gain type safety in nommu by using the vma_iterator and not the maple
tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/nommu.c | 79 +++++++++++++++++++++---------------------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 0481922fe66e..7a52a7c37009 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -544,19 +544,6 @@ static void put_nommu_region(struct vm_region *region)
 	__put_nommu_region(region);
 }
 
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	mas->index = vma->vm_start;
-	mas->last = vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
 static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	vma->vm_mm = mm;
@@ -574,13 +561,13 @@ static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
 }
 
 /*
- * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
- * @mas: The maple state with preallocations.
+ * vmi_add_vma_to_mm() - VMA Iterator variant of add_vmi_to_mm().
+ * @vmi: The VMA iterator
  * @mm: The mm_struct
  * @vma: The vma to add
  *
  */
-static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+static void vmi_add_vma_to_mm(struct vma_iterator *vmi, struct mm_struct *mm,
 			      struct vm_area_struct *vma)
 {
 	BUG_ON(!vma->vm_region);
@@ -589,7 +576,7 @@ static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
 	mm->map_count++;
 
 	/* add the VMA to the tree */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
 }
 
 /*
@@ -600,14 +587,14 @@ static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
  */
 static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
 
-	if (mas_preallocate(&mas, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
 	}
-	mas_add_vma_to_mm(&mas, mm, vma);
+	vmi_add_vma_to_mm(&vmi, mm, vma);
 	return 0;
 }
 
@@ -626,14 +613,15 @@ static void cleanup_vma_from_mm(struct vm_area_struct *vma)
 		i_mmap_unlock_write(mapping);
 	}
 }
+
 /*
  * delete a VMA from its owning mm_struct and address space
  */
 static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
-	if (mas_preallocate(&mas, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -641,10 +629,9 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
-	vma_mas_remove(vma, &mas);
+	vma_iter_clear(&vmi, vma->vm_start, vma->vm_end);
 	return 0;
 }
-
 /*
  * destroy a VMA record
  */
@@ -675,9 +662,9 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
 
-	return mas_walk(&mas);
+	return vma_iter_load(&vmi);
 }
 EXPORT_SYMBOL(find_vma);
 
@@ -709,9 +696,9 @@ static struct vm_area_struct *find_vma_exact(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end = addr + len;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
 
-	vma = mas_walk(&mas);
+	vma = vma_iter_load(&vmi);
 	if (!vma)
 		return NULL;
 	if (vma->vm_start != addr)
@@ -1062,7 +1049,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 
 	*populate = 0;
 
@@ -1091,8 +1078,8 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
-		goto error_maple_preallocate;
+	if (vma_iter_prealloc(&vmi))
+		goto error_vma_iter_prealloc;
 
 	region->vm_usage = 1;
 	region->vm_flags = vm_flags;
@@ -1234,7 +1221,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm += len >> PAGE_SHIFT;
 
 share:
-	mas_add_vma_to_mm(&mas, current->mm, vma);
+	vmi_add_vma_to_mm(&vmi, current->mm, vma);
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1250,7 +1237,7 @@ unsigned long do_mmap(struct file *file,
 error_just_free:
 	up_write(&nommu_region_sem);
 error:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	if (region->vm_file)
 		fput(region->vm_file);
 	kmem_cache_free(vm_region_jar, region);
@@ -1278,7 +1265,7 @@ unsigned long do_mmap(struct file *file,
 	show_free_areas(0, NULL);
 	return -ENOMEM;
 
-error_maple_preallocate:
+error_vma_iter_prealloc:
 	kmem_cache_free(vm_region_jar, region);
 	vm_area_free(vma);
 	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
@@ -1344,20 +1331,18 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated either
  * for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
 
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
 	if (vma->vm_file)
 		return -ENOMEM;
 
-	mm = vma->vm_mm;
 	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
@@ -1369,10 +1354,10 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (mas_preallocate(&mas, GFP_KERNEL)) {
+	if (vma_iter_prealloc(vmi)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 			current->pid);
-		goto err_mas_preallocate;
+		goto err_vmi_preallocate;
 	}
 
 	/* most fields are the same, copy all, and then fixup */
@@ -1406,13 +1391,11 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
-	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
-	mas_store(&mas, vma);
-	vma_mas_store(new, &mas);
+	vma_iter_store(vmi, new);
 	mm->map_count++;
 	return 0;
 
-err_mas_preallocate:
+err_vmi_preallocate:
 	vm_area_free(new);
 err_vma_dup:
 	kmem_cache_free(vm_region_jar, region);
@@ -1466,7 +1449,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list_head *uf)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret = 0;
@@ -1478,7 +1461,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 	end = start + len;
 
 	/* find the first potentially overlapping VMA */
-	vma = mas_find(&mas, end - 1);
+	vma = vma_find(&vmi, end);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1497,7 +1480,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 				return -EINVAL;
 			if (end == vma->vm_end)
 				goto erase_whole_vma;
-			vma = mas_next(&mas, end - 1);
+			vma = vma_find(&vmi, end);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1511,7 +1494,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 		if (end != vma->vm_end && offset_in_page(end))
 			return -EINVAL;
 		if (start != vma->vm_start && end != vma->vm_end) {
-			ret = split_vma(mm, vma, start, 1);
+			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.35.1

