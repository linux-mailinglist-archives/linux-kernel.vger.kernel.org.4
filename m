Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88553675A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjATQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjATQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:41:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451217CC5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:41:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBgk4011455;
        Fri, 20 Jan 2023 16:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CavP105CED09rOPI666NqLVlmX/aO+nkvBl07Qjw2x0=;
 b=r+HEluIxoYlEzD1nTU4D7SGCuNPIAr9H/DV2RJRngsxLReKecna9NH9rp5u00L/N5B4C
 L55ZGL+ynd5BrNR9/zruJXE+TFb9LuSb/v4K6fWWa28YfeMAI1RO03hjPsJ/QzggL5PZ
 LV/uRUX6kaF6gX1TY8EsuKCGoxr1lBykvaLyKi96U6Ko6jMrkNZS+h6WCxE9jBPXLMU8
 E+wpvIcMc4gFTuit+q9bbHZObyP8HeB5+pZyjjWA2iz9J3P9gkppTKQiAVSzWStExuw8
 UYe8wgO4LFHOUE+cCIwvoYFVP4iXGDSD3bNa5TQNXOjAEL/PdZK/YfV5gPpBORTBBylC pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFaTff004734;
        Fri, 20 Jan 2023 16:29:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1hc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0G46sPZrrczCLWGCDnMLodUYjuGNoIYF1Un+yYm+DPi0CO+lS8lOY6ww8mwuzJEqgQyDC6UDaU/fZhrBl5R0eNwB3a697i6AnSPeMT86L9PRz3810bsoRRmdXrYEEJqELNZLpaueOdxKdUl8NetQOJtjR7EIAzuiSRAN5HvXK6YyRU4JrnoHInqQM/+plPeV7XvmPWzWp4Cxwaf+cgZkthzJ98tI0933TzxcJlJFkgCpt9xVqf8TzjSE1Dw8mdaVMplb6TdILmXRzN7jNfLcEoBjek3MtM66cp3P5w2mPVE+RmNr5G2DwJ40MKCP1APgk79YFEa+s+zMG4IxGP6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CavP105CED09rOPI666NqLVlmX/aO+nkvBl07Qjw2x0=;
 b=BsSQvT8I84Z1SiAQmF4ZtK1Ju1qjQ9AubFrj1aftQl77TSOtvFN8lLiWFkCuneSerKilKjA3lfd2yiqi+qr9EbBQI5ogF4ufxorZYOfiZ9lZqnPz4qUZuLVRclfJ5zxMX4zCnjQJHRhSPTv3HRz5VxjpC6T9qOQK4aIqaXruglWXk6nzA94544wGJmTxO5aAeKrYAsLDiDCmnakoqR0eGNgajKZhfpezOGs5yQnZwQ/ODXRdB5SpddvpMbjH1VTGmyc+lnI0qRqFfyRjZunDfaLpI+Qt40j9uMNdVA9ZCewCgGvwkaHFcKnqhMwtLkbEbeJXTW8Gb9x9AFAZ0xtahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CavP105CED09rOPI666NqLVlmX/aO+nkvBl07Qjw2x0=;
 b=c/57vkTrLvCVPuQqAFF/myxrYHOtc//gd7fBXsSvwRm5My321VRgKP3L7uoGzHpiUDNzJsKayR2w4uFuiPfGYMcLz+jjnYsHMCbAf+xkDZuNOsU4RG0wBlhQELu2GBYWjkgP0WGhzvjrCWaft2mx6DJNrCtkBL5jYzBQF38JRAg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 43/49] mm: Don't use __vma_adjust() in __split_vma()
Date:   Fri, 20 Jan 2023 11:26:44 -0500
Message-Id: <20230120162650.984577-44-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f08ce1-7b22-4c9b-2b2c-08dafb037042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/30+IoJanNT3oj2Rmc0WOVGeu5ekAKW2PjzmT25fRkBtlQJJDl/euFNlHF11LfcSjtlxN/r4NhRSQZD9PPf+W2QlVdpogpftv/iUPOT1kDRl2Pck/iEt26itTOUuohBSrDHooiXJTKHDM9Y9dNv/BR0YFmh07H+bYSLlQRK2hq5ikY/y9M6rn5tIkh57Lr66/X0b7P/fOa04QG5l//wRiaoimqVSbn7Rt6Sl1kAmfhLn2Xoz8XsffT60iYzEuS0Tk2nwGoLPaJTvXm4YFO4u/4c8cZXkSrV8nzZ57FVIVzaaLOd3X0WHgxJ0J572p2o9zlZE+vc/VOXpU4EQowr+u1LFVdtMSQ66UErGDN7wKY/ILzo7ROa5yNwfzzI247RXLCf9YdRu/YNlW7T+tPpV6nRk2rMOuQBO4dSkk6gKGWQ6xQCTim8lMqtdwxSUGpL2AVq+LQi15i3KK4WG4Z2FBAxQsr2KKn0Z4rJzn9kuRoLSliaSJ4KgTWfD/0mr5dNiM6UoNifsRJjT3e/hN9zC7+kOrY0kpV6xkH+pv2YKcic/StnuAcZo4h4lumE6iRo2LFDyg6jYzBfxJXP2EjFqPUCF03zo8HBq4gEQyadWejCOEUG9Dn6howA1O9d85o1cgkxfmGB4YXADfQ+ai4TuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1B/wlkoRfOauOaCdgbiFTaj1gSJ3Kfq/CFU5DP328S+N79Y1ITJuCykw/rFA?=
 =?us-ascii?Q?Ui2QarfoumdRAGCIIm/i9TypIDhoWGy6r+VpLKofE2ZnQ49X4UctHMS4choO?=
 =?us-ascii?Q?fNSQCBv40UINMObBZv40d/lcmTiplXP5rBwWfRKs8uirHGh+ahqm4NQ4V8uy?=
 =?us-ascii?Q?EuH+R4YaVFqSy1vb+OIzqAbhcZvWJ3r8CDHSjac1WucE9ewDsZZB4BdEEa9w?=
 =?us-ascii?Q?6p4HHHbda7jlR0ooNL5CJlCJhXRd4OqcZ00GAEGhYsTq8qExH8zs6HU0AAeO?=
 =?us-ascii?Q?cEbZHW5K1rHA2fbPU+kfW5WOkIb+LfyJKHfHJjGSOlzBDrgbLw+STCeszeZv?=
 =?us-ascii?Q?e9hqddzZdTU2T6QaL5tNYrV6b005LpQ3HLImtZfpJy//CvgBvoi0HApjsdrQ?=
 =?us-ascii?Q?Vcfc8FkIop3duu8CLJ6itHhJXcmmFnf57Tz3D4N99b/yCla0i2g300NYbPoa?=
 =?us-ascii?Q?ArTOmkiurN0o/vCZKgOzF1pGeIPP/d3Qzk6Ed2GgFB2L1EJyH0kqrC6j1B8Q?=
 =?us-ascii?Q?DQozoe7ohPnTYu4HqjobiYT8GTFrtJw+S5eLEd3COJBzBssYcgsO9Y+qBoGY?=
 =?us-ascii?Q?YfFMNgKfRFrsoBKzc6uIax+SKdzPKzHMr8LRKirpKkH281oZocb2gplPKy6f?=
 =?us-ascii?Q?fRFlTxoJDbZXFiip8O0Ldc/fOuHat720iUKYbHzyeF+aWlozV5upHRIyteDM?=
 =?us-ascii?Q?EzeHqhIPPFYLqH4ZKPtkH3F7b5HJlzVOcgsDVr8Bck9SQYpPbkd0FZPkbe4h?=
 =?us-ascii?Q?mRbhSc6B/qyHo+59YyfiOx47yexmVSXMnvbQEImifUJn7KFsXA+opCB+Byl3?=
 =?us-ascii?Q?SQi2cOo60hpU0re0tIZzj/lhko5ShajdRe36xtFySDrIpfVLhpxr574Efc1z?=
 =?us-ascii?Q?e0FmTAO+uPbLT+wOiwlxw9/MCD2J7znM6B2vturQn5plk1Wd6ayIu8nHfHn/?=
 =?us-ascii?Q?/l/FnaDxxcSdRgSJTcrVxS7bKHE9jCSWSNUlKb8+iJPwPiKqR2GXBVJrT3j5?=
 =?us-ascii?Q?/pbVJSh6oxPsCSRxpEtZSRzQah86kne+fCATNN302JQQ8F3tb5w8ar1O94Xn?=
 =?us-ascii?Q?YralV6B5Xf9p2HZX2wIe1Z486/rZ5+IgNui9XYZ1QqDUu+0FJxLYXwCjaQXx?=
 =?us-ascii?Q?6Xc1Sl9neH02WUbEa8QwcNliKZxF8vi3OMtElBJD2Hd5jV0kmC8YHyAgVp5b?=
 =?us-ascii?Q?xPl3EPPEds4uNXS8ONY7j7i+qhDvY1K1RlLl69sPessjvamteLoOMRKeKGhM?=
 =?us-ascii?Q?AT3zaeqJNr+P+hBHlxMyiVZOW4FgywcGEuU6L9rBGeO4OWzVkUheNU4jMgDi?=
 =?us-ascii?Q?IKKPgW0N8MVQdPOBBiy1CUO65aXUCnd14V5gsfW1hW3KRSlzd7E2TsAoY3+d?=
 =?us-ascii?Q?7/ie9ahjwwH8Yp+Lai36qUTatEcpxrJyxl9JQQ7Uan23BMI0kDYnQnn+NxCE?=
 =?us-ascii?Q?BrH3xDz+3BIB0Jcev4p94jDLkWCCx6JeNrHMO2zsnhxxwkMksAj3eUU2nmwD?=
 =?us-ascii?Q?RRECsn+8kCHcnAtwLYzH1wTd6OfI1CKg9nvuBQNwqHUNR989B9AGmMizW7Ks?=
 =?us-ascii?Q?G10Wm3ckp5uGxPs3NZrlUpLfHhPDyNfD6Tyw2HjT83V9O50AicBF7qj8MvL4?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BHfvVCkjDBBxWcXsTGmUPL3nJkXfTRRHXzZsE/cRKINVGLLNW9/cuDeFc+plpE03xwzdSW+wc+TUVRXHN7W70XsBTB/hNVVGKCnYBp+U7LaD0JOhkid+fCoSxg2Qe4z6uBok9sDmLOvV2xgXr2nf3UkYzjLxTZ/v7dILVtgdb1Av9V/xNeGnnJ6mOsIdTD3e1s/oila19quEpzRaX2Bu+3/wyeW6TVJTRQBF92D/3a6snERl+hen2TqtFiTCkvxF/UoxYGQAdYH3y3I1uLk553iwBwe8IMrujCyC0p3wSBTfWK7LyFV31W9nj59NEmtSYLD/Ini8UauomwWzr79YH2vsDdu5hj5Sa2v45A60zQxzcKd8pLUVIw7Ybq1IV5mRPnmyylYZPSE/K3MCJvfr7RKfmCFZxsQGZk52hoisDdBljs6xYBEe436kuX+ZOdPLDYdYEBW3Kgkk7bGouLlbz7Y/SbXVe4axQWyktWMURHVj2nXmoQezwxUli7spvBIHrySbpawlZK85MdIhHGlahV7zHgOepXn0d4Me03u87CosSixJff2Xp7m/6HtIp/5C3RcZQWh9xe4HfdVPshCkk5wJQEubD+XsNqHuwyxKuWYDwbS+dEy2Qkr7hIT3dDVGW1R3GgU95czGWGsn2kACK5cArRYP/R+tUSz7kIfKvfNs0vAJUdgHim8NzMA69qHrwtIi7jbEq7CG+c9msIWvox3F3kKcu+E2D6V+3ceNar5VI67Ghb2EwevqQljQK5fveGuez/O4b10aA6LGhKFVrrzzZMQJIT3b6lFyREn1DC+5yN5zFkeNEBm2jwEPnsU90ZGyg5YJUXp2BZ1DDXPYPfMnB86CRT1dEq6RVO/SPzABCN3Sav9AeEMVITBXYNkHtrKihohfNnAs0K/M+w62Hg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f08ce1-7b22-4c9b-2b2c-08dafb037042
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:03.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLW828rD/eoKbLrLVI6P+MHhKZkHyJ2QIrFpiiBkTmOnFRl5MCKu6f3R5sJp/Bg4l2HfkDZbkedZlbkyZZVsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: cewSGlLDCS9zTe6bMyiyFp4j8v_ksK0b
X-Proofpoint-GUID: cewSGlLDCS9zTe6bMyiyFp4j8v_ksK0b
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

Use the abstracted locking and maple tree operations.  Since
__split_vma() is the only user of the __vma_adjust() function to use the
insert argument, drop that argument.  Remove the NULL passed through
from fs/exec's shift_arg_pages() and mremap() at the same time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |   4 +-
 include/linux/mm.h |   7 ++-
 mm/mmap.c          | 118 +++++++++++++++++++++------------------------
 mm/mremap.c        |   2 +-
 4 files changed, 61 insertions(+), 70 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 76ee62e1d3f1..d52fca2dd30b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
 		return -ENOMEM;
 
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 75b6d06d69d5..c372c09e11b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2832,13 +2832,12 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand);
+	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
 static inline int vma_adjust(struct vma_iterator *vmi,
 	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff, struct vm_area_struct *insert)
+	pgoff_t pgoff)
 {
-	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index 7eb93c311d8d..c1eb353c16f8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -694,7 +694,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
  */
 int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *insert, struct vm_area_struct *expand)
+	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *remove2 = NULL;
@@ -707,7 +707,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
 	struct vma_prepare vma_prep;
 
-	if (next && !insert) {
+	if (next) {
 		if (end >= next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -798,39 +798,25 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
 		   vma_prep.anon_vma != next->anon_vma);
 
-	vma_prep.insert = insert;
 	vma_prepare(&vma_prep);
 
-	if (start != vma->vm_start) {
-		if (vma->vm_start < start) {
-			if (!insert || (insert->vm_end != start)) {
-				vma_iter_clear(vmi, vma->vm_start, start);
-				vma_iter_set(vmi, start);
-				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
-			}
-		} else {
-			vma_changed = true;
-		}
-		vma->vm_start = start;
-	}
-	if (end != vma->vm_end) {
-		if (vma->vm_end > end) {
-			if (!insert || (insert->vm_start != end)) {
-				vma_iter_clear(vmi, end, vma->vm_end);
-				vma_iter_set(vmi, vma->vm_end);
-				VM_WARN_ON(insert &&
-					   insert->vm_end < vma->vm_end);
-			}
-		} else {
-			vma_changed = true;
-		}
-		vma->vm_end = end;
-	}
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+	else if (start != vma->vm_start)
+		vma_changed = true;
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+	else if (end != vma->vm_end)
+		vma_changed = true;
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
 
 	if (vma_changed)
 		vma_iter_store(vmi, vma);
 
-	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
@@ -849,9 +835,9 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * per-vma resources, so we don't attempt to merge those.
  */
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
-				struct file *file, unsigned long vm_flags,
-				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-				struct anon_vma_name *anon_name)
+				   struct file *file, unsigned long vm_flags,
+				   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				   struct anon_vma_name *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1033,20 +1019,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
 		err = __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, NULL,
-					prev);
+					next->vm_end, prev->vm_pgoff, prev);
 		res = prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
 		err = __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, NULL, prev);
+					end, prev->vm_pgoff, prev);
 		res = prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, NULL, next);
+					addr, prev->vm_pgoff, next);
 		else					/* cases 3, 8 */
 			err = __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, NULL, next);
+					next->vm_pgoff - pglen, next);
 		res = next;
 	}
 
@@ -2190,11 +2175,15 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
+	struct vma_prepare vp;
 	struct vm_area_struct *new;
 	int err;
 
 	validate_mm_mt(vma->vm_mm);
 
+	WARN_ON(vma->vm_start >= addr);
+	WARN_ON(vma->vm_end <= addr);
+
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err = vma->vm_ops->may_split(vma, addr);
 		if (err)
@@ -2205,16 +2194,20 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
 
-	if (new_below)
+	err = -ENOMEM;
+	if (vma_iter_prealloc(vmi))
+		goto out_free_vma;
+
+	if (new_below) {
 		new->vm_end = addr;
-	else {
+	} else {
 		new->vm_start = addr;
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
 	err = vma_dup_policy(vma, new);
 	if (err)
-		goto out_free_vma;
+		goto out_free_vmi;
 
 	err = anon_vma_clone(new, vma);
 	if (err)
@@ -2226,33 +2219,32 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	if (new_below)
-		err = vma_adjust(vmi, vma, addr, vma->vm_end,
-			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-			new);
-	else
-		err = vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new);
+	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	init_vma_prep(&vp, vma);
+	vp.insert = new;
+	vma_prepare(&vp);
 
-	/* Success. */
-	if (!err) {
-		if (new_below)
-			vma_next(vmi);
-		return 0;
+	if (new_below) {
+		vma->vm_start = addr;
+		vma->vm_pgoff += (addr - new->vm_start) >> PAGE_SHIFT;
+	} else {
+		vma->vm_end = addr;
 	}
 
-	/* Avoid vm accounting in close() operation */
-	new->vm_start = new->vm_end;
-	new->vm_pgoff = 0;
-	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
-	if (new->vm_file)
-		fput(new->vm_file);
-	unlink_anon_vmas(new);
- out_free_mpol:
+	/* vma_complete stores the new vma */
+	vma_complete(&vp, vmi, vma->vm_mm);
+
+	/* Success. */
+	if (new_below)
+		vma_next(vmi);
+	validate_mm_mt(vma->vm_mm);
+	return 0;
+
+out_free_mpol:
 	mpol_put(vma_policy(new));
- out_free_vma:
+out_free_vmi:
+	vma_iter_free(vmi);
+out_free_vma:
 	vm_area_free(new);
 	validate_mm_mt(vma->vm_mm);
 	return err;
diff --git a/mm/mremap.c b/mm/mremap.c
index 1bc81afd90de..30eea37f9fc4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1053,7 +1053,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 					vma->vm_file, extension_pgoff, vma_policy(vma),
 					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			} else if (vma_adjust(&vmi, vma, vma->vm_start,
-					addr + new_len, vma->vm_pgoff, NULL)) {
+					addr + new_len, vma->vm_pgoff)) {
 				vma = NULL;
 			}
 			if (!vma) {
-- 
2.35.1

