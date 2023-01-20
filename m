Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE2675A01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjATQbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjATQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790671BD4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBY75020107;
        Fri, 20 Jan 2023 16:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4gAFhTxYv3cfusEPiCd18HJdTaepqn4d9nML2OnEXmQ=;
 b=rJ00e7qdzPQDdCzEnXlmJHqGJIywNBw6Ow0sULlDbtcT2ZaJ15yDYyQJntIe+VKe7VHZ
 QYZ+1uggtVW7y+ZpKEh0hU2PcIK5MChiiHIQGlMEzgPpOr/e79S8aWsAe5K07pCf/1oI
 VB9QA3uehTAorbprpdZM4gEvPnrReNYDt2PYjJzpZ/Nd2Yfk3c+5bleNrNqV9pTg/1/8
 uzqhv9M9uRa6i8LJbtWlFGoh5L6UUNpqBi0KF8TR/FcPlCEVli4M70dMewNPkPfvWTsB
 dk6pHXJ3RhgQAPFmhqqKnIfgbOdOyzLYV42AyoEOcdzSvQ/nPZQNlqePXerthwtadXvI PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw26g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFXQiI004636;
        Fri, 20 Jan 2023 16:29:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1h7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvqjUWldJKO7DK6iRJtijOAd5eyQtGRu5IlLPUK6m9vAlL5KDaZkHKmJZUABJsYkJ6esZwesVI7EGWgfVMWUVtKaqx8cyJtqbusPxKCmld/74nANTdxXJm64vki7ZsptaOvp/ZEbEsxFasKDtL20D+LfBrZ9jziF0BLPK6+apFPFbytx7FAn3iMVWO7l83ouwZ3MNA9j3aMEmAJRoj7IZK7JrYcPJmTO1dYDR2AiCrnF6veCTPZI2+Ekhbuh1U406WdJdRkTb4ozs82PzvgPJQ0NRTU07hwJO4z/bRlpSrW5SdB/FKNL+V/xGTV/B+RLiX5P18VHXpjwbFjRyF9X/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gAFhTxYv3cfusEPiCd18HJdTaepqn4d9nML2OnEXmQ=;
 b=PTvC9W2JAKz2ua/GQ/7mnwHReyj04VK8E6vMbNE05Uwvgg1xnfNudNknSFUzqiRnR57TQcuGRx/FwxHmPfn4bbeJj5QvrtQ7+PRsaFYP2j9dGg0QXVstWVd6pAq6MiQ054g/eBhRdqQjLk7XKWV8Cg8IGPisxsnq3U0XWg72L0jcrtKtw2xbD1m85E8FVuKTmvdBxAq9z3F9iY+N2vc7e1aBtXjshlautxDPArhl2l8A1DuzanIkRkORTa4FIDbAPo1VaBm04/Bu3rpMvy4S+o36h7LJiGfwMUU5CBSpKII+Zt2J8xgSqUeASAZLnAwe9SWx5CPvDhW99UYE0vOSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gAFhTxYv3cfusEPiCd18HJdTaepqn4d9nML2OnEXmQ=;
 b=C/HmJzayr1VJ3A8U2dMlYY89mZeUAS6Ca99JB3raRRixGlc6xOvwzVtw6SAZuxLu0WVK/XbQqBCoCl7fs4AfG6okGh7CWSDTxTVS+C1gxvty6YYL3CRS5nOSTr5naUWFX0GWwOTo6B2X7/RUQAOKX0GrhVOO5SWgocVon8gcJl8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 42/49] mm/mmap: Introduce init_vma_prep() and init_multi_vma_prep()
Date:   Fri, 20 Jan 2023 11:26:43 -0500
Message-Id: <20230120162650.984577-43-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 315ad98b-703c-4c04-e253-08dafb036eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFv7f2Pn9w5oWQZbfQe6cepU5jI3uSj9ypL8KFbvD0MVKmexCr49YNr3KrIIBuMacJh3zdgkQPW94DzC7iKFfvrbrc9WxYjCbgZLCHPr/XTehyap9kU3ecqL7I9LVG5T9E82EL/ehnxq/nKqwNQJly68OGDWYmX2bgYyNblDGQGxqgKL+/SICQL4SqlAd7Xfq1kZIWOPIheikyVNMHIjtDw9wrJYzLo8NDHavM//JMrTStFeAme//FUPcNICVHyc4vguEty65k2Cjpu41FXkhdTs7uvBAPvYwD8fVUDLy1Va5gvfAc4rpzYqY/aMQ1DOqIahmJv+iSElKQrEcRRZvZ5R1W64h9N/U4q8Tr2gY3mUZXrxEjnC/pciOYHG108oOv/14Sm17I+acNtu66ehYMzp2ISUnO99KJahiuAMA7puVXZUQsYwTaD6q5vIf/BsotfRY+esBQay9j1hsyuZcUtK1IPAyQjOEP+O2fcEXTNCIf0wKAtXRLPjXVXiyguMCGqW6F4/dz+HK4L4NlZiwre3Q4ozEguEnZSGs5+v4UYhXWMe21AXI3ptE0/SIldpqJRSWsuHrSA99zlnmov6h4Xjv6dCtbfEFBsuwWtJ5G68glH68UpcIM/+UIetdt2fLzN2/jND5gcMcCbhQmyu7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYg5PWSHWJAFuJB3g9qipH3UsKmL0gq3CJv9HKne6//YmQaXFmGgxGMHtAq6?=
 =?us-ascii?Q?h5HxVxx7jVUwDzlzWCZM/vEzzujI2i9M80+K5DcJqsnA3+OeIbBxUFmYTTAH?=
 =?us-ascii?Q?DqNE3B16cOcPFiz5zHKYPbjbDFkbAqoxvTbdmD9xsJHZhAQuR/VZw3Kp+aNX?=
 =?us-ascii?Q?HN/6ZDW7Aj3P9ya445cr15IfqgN+gPKNLT4q0fgTWDyxHtguiwehwDmnlP2a?=
 =?us-ascii?Q?cDxJJM6eiQMU0xNIICYI7NaGeVQKGMP1NuYuuPFAPtI/F2c+W43ZPh9mwxz6?=
 =?us-ascii?Q?SWi56yilpx78y26v44c7kBrdu7e+E/7T/91h3oRMafIKV7q/jLAS2PrWvP3s?=
 =?us-ascii?Q?y5gNcIJ5qLLvZcl1KHvLX0gjoyFpHZM27PIpJdAsSSro4Jv55Js0tYu134Np?=
 =?us-ascii?Q?225HiEnQeNn29PFom9Aot9Iq11LrSmZWzGjZ2Xhv9AbfKJbwfhL6Y7Gh+KzM?=
 =?us-ascii?Q?i+T1xUtbWcoi+lX++EoVQf6T2aXi6m1UhopdG/lR7YMlQXWGRcIkFLmQ/LwA?=
 =?us-ascii?Q?SeDwZtkPH7xik3GVQMKAb7ogprNk5Vh//NEKrzIvJaGdBGpfjE2G0ofSj3yw?=
 =?us-ascii?Q?DpE1j0RDjKDAB+cbl7fqRCvHt7TB9iJ5yOGWr9ryAVsWlgWF27IxlMHMCPFn?=
 =?us-ascii?Q?QA0V4/k7FSQt7Ttldx6mq/OhG3uOnsBUzFQKdmpaiM1PWoRxlN7sywywWqL1?=
 =?us-ascii?Q?lg6ErO9H0WjlCZOy22uGuOfD3qT8fjkDr3na4Jt+kjUkSyoACePWVj6WHZ8h?=
 =?us-ascii?Q?2LCYtbNmhWNv3KiPJSYCxSI/NgeBmyguJzIJRgfmTiBL8LmsWtNM07KAgf6j?=
 =?us-ascii?Q?YwgiaeWYVqGczg0YMAA+0GGBpnA5v4+9g+JiHwjXOc4+f+lrLVWrnEfGLMDk?=
 =?us-ascii?Q?J76QuMhOsjfw11YxbdFBpH/gk/hnlgK8mdixaulIkd4jVM6VPm16HrAg09Em?=
 =?us-ascii?Q?iADGCd36AqqFWwIq2bNwR23V99J0q6hZDisDTGCvDMVCna6FqEU5lwQ7polI?=
 =?us-ascii?Q?ib5jeFX9+KiFkNP37UJEtvaXfA6WbLR8UWiGO/S3SXU8ignKpzVDZSQoI1TS?=
 =?us-ascii?Q?mcCHXb+mOsr31heBHn58yqteK43UM/LTf3j8E5qsmpFDpnR05AeTTyxTwQMq?=
 =?us-ascii?Q?kLJwf751MXNtVNx7q0aXupoMWD6BSOsGL987MulZw0Ft6ALdBYSrEjkqQEO3?=
 =?us-ascii?Q?zTgUOe8O+eFz4eO+MUeLseNGJjsppCmKc6yyYxXg/maQ7/M6oN3zz5jXqHd7?=
 =?us-ascii?Q?KSpk1brnb0TspBDlBNXezWawsoHbkUdxjVWGKM4e9wP601ivgStxAFnaLk3d?=
 =?us-ascii?Q?Z83ZWUEfjsTRcILHb4dWYg0pukFX4F8h2A5D/oEIRLkiNeSWaJIBdvFLkakQ?=
 =?us-ascii?Q?xCJwEvRve+iI31bf3ncVgXIu3sCl9ZBBscBhDuld5ZwLehVHOwF5b9CGT8PP?=
 =?us-ascii?Q?g4Hqj1xgkh+iTVR7aphMtrBKCT9jADzxX0+8XmVJIzs+W1c5LI0mpd5vHo9x?=
 =?us-ascii?Q?lzFoW2d0cPvji4oZqWEDfh1S5NNmczhqizRK9dfSVHIDSPqlqGB0XNcQQaWn?=
 =?us-ascii?Q?lOb1uhgnzF/Q2HYycqg0m0n5i48Qn/ZcHKFChx0BwXIXXHUpd88XUAYEcxkY?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tpXubT5r5+ZKDl2n7qNVzueiLc0G3Q7zqx8HeFuGBIBfoL2vOiQ8hu13bxjiSiiQFI9mlLTMiaEYpF3g+oczgEj1UKcFYq1DWt+zlF+UQgAA5QnyHZpJypzftXlmJx1I/c+j2vMgk2aZBwXldMfdxP8eeUqh01W32Zl495ALF/wqVX1e1zx0hMgh5yLgyLPk7KKo9qlL/8lCsHG12PFe6kCDm86ARAsdTsgIjTa06clRcSCaY1OEPMILMzwyYmcBWD2o426EL3dfwsPz8tKY3Gv+zuXPdcgs0QnPqITctE1+vBpAuOFlStOFJ/OEKUXmYOS53d8v7x7LRxuUDhOSyQPTNHZihIcqVOgpGxasyklf7NDU/V4aPyJMgeAZAoAQ/cHs7xLn8cpJEhLc+D81XlAanfZXGYiuLsl8dGdfWt9qfk3RwykBErmOAennhqj/gV7nACE9f/zsF+EW84Q2vZiB0llVJWCcK2pSz0LvUrsDyN9XfTFUO5YrtJKZPdl33dyEsRUp8o2eFDg7F+tnu0JeOWzJ12JqPGLBqRAgAFEdEMsT2yN6n1otIcx5+gBAH1s/tnHPfW/JVitWJkTPE4gybhHkbWUIui3fXs4m4RkOzvj+i/cGF6B/RUzfMTZGzAyvAUAeKEuiVp1sNFDhn7WtLt9nFPuE02cToNLHkAZotsQ+EwEjQ95ilGwbKbLrM8s3ALt8fgfjD7C4AsHIriW2kFmC592NzidIGS8u3AcvdZxlDZ3ssCkAatUC+4w1uL1CIwHPEjMoFnUNkord4UR50Xk8AcS7Y18+1ezP8QpY3apZDWG2OxTxpNdGXbT6menuLlhA8yLWrXaM5Ba6Y4wo3aaWTTFglRKxEyjenCLzfDUQ0RJUvcKhK6Lr8DgFZBjk08/D1bh4nGihvDM7AA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ad98b-703c-4c04-e253-08dafb036eac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:58.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOviOk3N7hR1BFYYMlI0nPzl0uNsn7MBS1GMsI8frHJsLdqYix18YnILHz7n+3DUwF/KwZFgTImL3aHiBBSE9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: X9zMEY_xuXkXyi4MTc8_F2EQSDUDjJBr
X-Proofpoint-ORIG-GUID: X9zMEY_xuXkXyi4MTc8_F2EQSDUDjJBr
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

Add init_vma_prep() and init_multi_vma_prep() to set up the struct
vma_prepare.  This is to abstract the locking when adjusting the VMAs.

Also change __vma_adjust() variable remove_next int in favour of a
pointer to the VMA to remove.  Rename next_next to remove2 since this
better reflects its use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 108 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a0883c23f948..7eb93c311d8d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -460,6 +460,45 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * init_multi_vma_prep() - Initializer for struct vma_prepare
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ * @next: The next vma if it is to be adjusted
+ * @remove: The first vma to be removed
+ * @remove2: The second vma to be removed
+ */
+static inline void init_multi_vma_prep(struct vma_prepare *vp,
+		struct vm_area_struct *vma, struct vm_area_struct *next,
+		struct vm_area_struct *remove, struct vm_area_struct *remove2)
+{
+	memset(vp, 0, sizeof(struct vma_prepare));
+	vp->vma = vma;
+	vp->anon_vma = vma->anon_vma;
+	vp->remove = remove;
+	vp->remove2 = remove2;
+	vp->adj_next = next;
+	if (!vp->anon_vma && next)
+		vp->anon_vma = next->anon_vma;
+
+	vp->file = vma->vm_file;
+	if (vp->file)
+		vp->mapping = vma->vm_file->f_mapping;
+
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static inline void init_vma_prep(struct vma_prepare *vp,
+				 struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
+
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
  * @vp: The initialized vma_prepare struct
@@ -569,7 +608,7 @@ static inline void vma_complete(struct vma_prepare *vp,
 
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
+		 * we must remove the one after next as well.
 		 */
 		if (vp->remove2) {
 			vp->remove = vp->remove2;
@@ -602,17 +641,14 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next)
 {
+	bool remove_next = false;
 	struct vma_prepare vp;
 
-	memset(&vp, 0, sizeof(vp));
-	vp.vma = vma;
-	vp.anon_vma = vma->anon_vma;
 	if (next && (vma != next) && (end == next->vm_end)) {
-		vp.remove = next;
+		remove_next = true;
 		if (next->anon_vma && !vma->anon_vma) {
 			int error;
 
-			vp.anon_vma = next->anon_vma;
 			vma->anon_vma = next->anon_vma;
 			error = anon_vma_clone(vma, next);
 			if (error)
@@ -620,6 +656,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 	}
 
+	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
 		  next != vma && end > next->vm_start);
@@ -630,11 +667,6 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto nomem;
 
 	vma_adjust_trans_huge(vma, start, end, 0);
-
-	vp.file = vma->vm_file;
-	if (vp.file)
-		vp.mapping = vp.file->f_mapping;
-
 	/* VMA iterator points to previous, so set to start if necessary */
 	if (vma_iter_addr(vmi) != start)
 		vma_iter_set(vmi, start);
@@ -665,14 +697,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *next_next = NULL;	/* uninit var warning */
+	struct vm_area_struct *remove2 = NULL;
+	struct vm_area_struct *remove = NULL;
 	struct vm_area_struct *next = find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma = vma;
-	struct anon_vma *anon_vma = NULL;
 	struct file *file = vma->vm_file;
 	bool vma_changed = false;
 	long adjust_next = 0;
-	int remove_next = 0;
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
 	struct vma_prepare vma_prep;
 
@@ -691,25 +722,24 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				 */
 				VM_WARN_ON(end != next->vm_end);
 				/*
-				 * remove_next == 3 means we're
-				 * removing "vma" and that to do so we
+				 * we're removing "vma" and that to do so we
 				 * swapped "vma" and "next".
 				 */
-				remove_next = 3;
 				VM_WARN_ON(file != next->vm_file);
 				swap(vma, next);
+				remove = next;
 			} else {
 				VM_WARN_ON(expand != vma);
 				/*
-				 * case 1, 6, 7, remove_next == 2 is case 6,
-				 * remove_next == 1 is case 1 or 7.
+				 * case 1, 6, 7, remove next.
+				 * case 6 also removes the one beyond next
 				 */
-				remove_next = 1 + (end > next->vm_end);
-				if (remove_next == 2)
-					next_next = find_vma(mm, next->vm_end);
+				remove = next;
+				if (end > next->vm_end)
+					remove2 = find_vma(mm, next->vm_end);
 
-				VM_WARN_ON(remove_next == 2 &&
-					   end != next_next->vm_end);
+				VM_WARN_ON(remove2 != NULL &&
+					   end != remove2->vm_end);
 			}
 
 			exporter = next;
@@ -719,8 +749,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next == 2 && !next->anon_vma)
-				exporter = next_next;
+			if (remove2 != NULL && !next->anon_vma)
+				exporter = remove2;
 
 		} else if (end > next->vm_start) {
 			/*
@@ -761,30 +791,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
-	anon_vma = vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma = next->anon_vma;
-
-	if (anon_vma)
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma != next->anon_vma);
-
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 
-	memset(&vma_prep, 0, sizeof(vma_prep));
-	vma_prep.vma = vma;
-	vma_prep.anon_vma = anon_vma;
-	vma_prep.file = file;
-	if (adjust_next)
-		vma_prep.adj_next = next;
-	if (file)
-		vma_prep.mapping = file->f_mapping;
-	vma_prep.insert = insert;
-	if (remove_next) {
-		vma_prep.remove = next;
-		vma_prep.remove2 = next_next;
-	}
+	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
+			    remove2);
+	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
+		   vma_prep.anon_vma != next->anon_vma);
 
+	vma_prep.insert = insert;
 	vma_prepare(&vma_prep);
 
 	if (start != vma->vm_start) {
-- 
2.35.1

