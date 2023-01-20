Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AF675CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjATSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:34:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91944CE6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:34:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGE9PR025147;
        Fri, 20 Jan 2023 16:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7fH9jEYvIL72fRiIo9twc0fQLD/WFlcNcmjDvU9soOQ=;
 b=HJtYwrjoila6Vs0/mJL7w2KSgt/cjKpaH9GcgCj0Czvp2PQJhLTDBOa53Fzr6thEIrqT
 Ip3kacNda/S8DRtO2Hsa1RoIYEcNN2JeWn8GBgj6j2SHN5Uge3ShKgKRSYMIR7Kuf2sd
 ApjrIq6ncXRE7atJFjOBAlkOjI+P2Lkxk4TX1WULpbI+COGSIsyOtyLylbPGwKGJCRPn
 QmVSKIj0Vl7z1Ajs4+DgjChf+aSKZ/1Cq0sfhp92pOkuyTQcdMpstFL/TexaUIIvuPun
 Fm6QPwr2li9+g8fBhTpiizKCH9oiL4Wi3Iu3xhKHOuhJp7BJQbvyY7qwt8C8oPlDUGG5 Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGN3LD007681;
        Fri, 20 Jan 2023 16:28:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgeq8e9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW7Yaa2MmYtHqE0AcOafNNeYTfVm9ohh6JZ1W/ZSlki5JgcWQrp5w5h6GAUo8Ilcm2Q9c1e+b8k6ljPwQ7+Rj5lLSuLvl/QMRNxogzjqUPr1V7oAdI9lvyfIKHeFMLuJLlKzErVNPRyJXFTm4/gEfj5Rm82YsHK3jbTHa8l6qax7Cu9lUJ571SbJ4RIs+G9s+YdWqceF3YXV8g/yXBdUTyFch61ejFsEKMZCD3n40IDLR0inONBLodVjoZT832ehmYOf/88DzzSbinssIeBhNhrcbQ/Jr6rjsztiG+P/eqWdllYzP/KU2J03G4I1phEBSB9essQsSfT2jFbdZ3OQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fH9jEYvIL72fRiIo9twc0fQLD/WFlcNcmjDvU9soOQ=;
 b=SiUw/MsXnLE6uFE38hGTqtfALWYsKkx3RAphe6LHSYbCU00CxqoRIZXiPPMiq1xO33SZBUM0pYtGNZJw3PgmHuL5Oth978TgHbWPcWLR0OElw/dC7zvGh2NOqnM/9WZwsiuJLPKwMHy1m+t5SkQ857PCfmb6yKruuuji4BL/t23cp+9ts7tsBi6NssbGyBCJi/e+9oUkVn8h8bcIpNi+bwFMqcEcF7juBaETSis8KL2xf68mp+e5IfYFXDu2aU7dYJ/BA7gdCWgdxTDjdaUtqFSIvEcT2ZUm8e4mdYii6CVt1UbqhHmtm1PVroYJP6rNgEiPeauNq+zoeaQvYITayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fH9jEYvIL72fRiIo9twc0fQLD/WFlcNcmjDvU9soOQ=;
 b=F28FLAzwCmphHMvHwGkPugrIcg62gMZBuHCpPbj2JBKgxa61CQf10LEG0PelrbhEVv3tvxBdfvgwYYclwrUq/JITabQj/6ww8rHY2QKDJmOPYZcAwU0o13wcvQwaqiMXtuhm0SM0I93r/QgLal+VSHGWlevpfpCA3is24cfA4wU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 41/49] mm/mmap: Use vma_prepare() and vma_complete() in vma_expand()
Date:   Fri, 20 Jan 2023 11:26:42 -0500
Message-Id: <20230120162650.984577-42-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0081.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad99454-6e57-4bf7-6c8d-08dafb036d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFTPk/OmZxPa82eVtXeYaRST7hV+jBYgg0YPv+jC5GYVB8z9LxVl0cVXRjgiFhBUs0YH00JO83lhBxooyapxMfQYYfmNGPNbQYWsNp8CU9A/3H639b1tHjhiwFbwbYQQqr/O9sPjbkpxNufeLm0s/xd68DyH06T16ol4OQunclIdZwi/Aa9CrRS3zIecwV0yvAkbwsX2vFxceLViiVgVSH3Ka3+98TwR8IFW3fEDOn61jGvLHkD99sgSskTF9rKRuvbDOyeTD1nLyNkB9Ens2NNsuDElLP/L3SXPKZ/QXR3LceRW/LOSriRiInksooPHU3izqtn+80+UGr41cgcWC1upFv5gKnHQde3/UfpGAHXo/eef5y/WEqORd5MbqsChQg9HSRCkTCpfIPQikS342QU8oJh0osR7rYjgIdZ8Hia4Q42B7U8IZ1vvoXtZLnzxDFPJ1Oe/77FaCc8CYPKl+vtlBs4abN2N2qq5zCWq7HPSt5QgQmAWUa7aCGQKKOc8j8YFLXATgkV032u7WCBtNoa/Gq6nWEyLoRKDcNjJeNPs6biNcTLTmkCb5n2Nuu6QnK1xSBTreZB+GJWL2n50+k5L7Z1qrlX50QoNZPVjru5E1UQ2HzrZSCtWXknsARvqgijSXF17UNF6pLDPOOb9jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e90EkxDh/5U4soCs+P8eWyhvQzTPPucdNyixRKdd5hSam+e/LRTA2QChS/kj?=
 =?us-ascii?Q?4DvxJY7TcobHNWI38WsFOGVFPN4r+nW4iJtn76cSbfNDJzAH1uwKhcQeCAKy?=
 =?us-ascii?Q?KUWZcv1Ag61gx68CT/gaHpIpBhyAmOvoJobolY+9eAN80/D0NpzSQhBhGMLg?=
 =?us-ascii?Q?iieff+JRd5TfR3RtBddvivUUgkFuzFImPbSXR9MOrCi2ANEfyh+9mS0YucJK?=
 =?us-ascii?Q?Qudaxgof1m4sAml/V/Z0qY1xrzSIcFyWZwX7ug28q9J5ff/81Iw6vzVi0BQv?=
 =?us-ascii?Q?OoW7h/Fr8C+UF3mRMTuU0VSvauFgXSZ/PirAeqgQjqLObZbulPH7sAjsGYPS?=
 =?us-ascii?Q?B4AvJ5AemP7ulbZsOY/hwEEzJT7NUUi5hEWDEvoQYhFBZQn3i82Z41aejjAa?=
 =?us-ascii?Q?rJ/xLlrsvBpeZ/zRAmq+xjO4ZwbLfvxXXu3Za/LAflF15uFzpfgKOrevzS0O?=
 =?us-ascii?Q?BCxX+9S6ylgIohcy0I1Gf0VA0LKXS0fvAyS83TGUw8wtSKNDVVfYytX5saw1?=
 =?us-ascii?Q?RLS2WevFWFuGgXHMUxsDG3fGuDF4ZAW/NgIlVMUjI50lN4zTuFe5s30/frKa?=
 =?us-ascii?Q?2Edre4a70LBoxfA8MofD2pg2XIEIUfQYdlS84ZtIBLa9y5EG+37PNFEwnofd?=
 =?us-ascii?Q?6N7jy7hMehVyuaA/whglsHntapzfNhCplP+42B0KfsrMmFrT2Xgr+GYGHyjB?=
 =?us-ascii?Q?ZrmUlSCOEyQdZOnG3l/azbXrrVdFbPg2km/sHYr63+yAP0NtP0PuRWOVUaNw?=
 =?us-ascii?Q?jEDP7M4oUPAs2Fi2YvBiyvzfMSRcuOK1vw+OOMZFIuzrQrV+8i6KEB3t/Eg2?=
 =?us-ascii?Q?6PYn3zEK/sPgZMatVdh6pEyPLJLY8kyXPmkbYyCV5FTa3I65GuZdj9WxYjq7?=
 =?us-ascii?Q?dTVrZgcAofWhFsGOHmNl6XJWhlMsL33n7Kbn9ZrG+8ztP/kvCNbrG4+5eZoG?=
 =?us-ascii?Q?1ptvBCC8j5i914dJ+h/Wnfo720tdNsmKPWCd7sZZTjHw4ChU1DXbfHG3C8ZJ?=
 =?us-ascii?Q?xDdtk1vcJDTS87vryuSyoTkYY+lSxp9NTeiWikBlxuf3Mm95i1DO5bfi8X/z?=
 =?us-ascii?Q?HiKclQSQZ+Kzd4BXZym1OvW3YF5f8vxVbk7PgAhNjouER1hzFjH1s01vHyw+?=
 =?us-ascii?Q?CCCLdpY+FrP+cBXrsCr+xDEzniWJMyixzM3Rw0c2p8jurqf+qcV05WUpy0Ml?=
 =?us-ascii?Q?8GMfSUMe/jthQcqP07Na5yvLdFxO0AYj/AN5BJlJTVjOI2RSd8f+HVnAX0z6?=
 =?us-ascii?Q?dI3h4SuRlATx4piYrm+oi+gM9iEh7ahVjacv+5wVbdyf3HfJSbzP6VC83wdR?=
 =?us-ascii?Q?lIXaIYtWfsrd1vDxZN8TT9PreC+mxUaRATn9Hi0UIePtunleUUrilXBTtkNX?=
 =?us-ascii?Q?EpURPi18DmPQ+r8vJg1Id7pTqWlOLg5Puk5lqnjt4nkTIigcEK1vTxcG+DX5?=
 =?us-ascii?Q?nGowoleYNJUu2S961W9t9G4BpxBcxLd2xR9ugGTFAI8gVlH1Aix3j+p0N4gE?=
 =?us-ascii?Q?6/1vIpywTw0fOz+hQh7j8GPTVQERuweHrxvawOqkRXLoRLOAi3tjKHNsqyus?=
 =?us-ascii?Q?KYcMeLE0Y8J3PBfawvTkPMOIm5hUCMwCzJGRA0qAbzGINTnSi1g39xZvj4AQ?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hmNzmpcUR+UtH0OKKgzR87IekxunNgvLGGk8RpQGSqxKDNxFLF1HLUWR0bhRvXsmC8na/L0jF383oTsjrCZL6x/Q2F6I+4f154l3JToNXzAhwfX7rCedBeXyCswfdxIVmGeix9TjTY529gYtEgQ5qTFfNUd6ziInju65ZesuxJjna6Rge/jtoFDQbckEo573o/zHq8BMgWMBf3xEvy1pg44P+TizdAhCPb4koM+PluKoQB2em50e0LQn5jm9mIdN2Xx4i2C8AYhEd++JNMG0pOYfO611r8zaiN0OFyHYrcvxClVwYkkQukblCamOGxObTobWNlIDXcCNtS+IBJlcyJa3S8fXnugFJJQG0WlI96jvIVdYM1tap4op7G8MtFjDuo20QQ00T+2oVPJvG7w/VdP4LW0HGFC5GNiNZdmLhBdXqsXhKllgFf5Rs1yEwcdovlDMBDblbhyb5vTxMdIG0DVE4WloJRx5cmu7sI3TkcCgxNiMFyGzQCllVZkdlYUK1CXxYn5lAbE55lA89mHCq7zz2HKJGtBp+9n0MoMHHD+iYfrOOgPRgkDXBjOXbEFClqV24lE9dQZwKSccmVE0sWSGRn4Kb8r4vHE17eQm/NufMAK/GuXx+E0MYeJKPQ8B+USAWLv/mS9QPMXn66L1cAroaXwe4DR6yzce9MkiW7rh2+pQVxD7I1YzGqCsccjbzfnP830fyJYWjuSXrP7XQuPHGZ8XN80iQhMQrF/v9s/2NKjLCOJB1qJPvT1Byn0mKbVuuh4phayFlu1yKDcjOsIueI92Ud23m7VZ+1WUI92Sqk1gNqEveWPG6Ls/nRLZlyI/fScpSdRe5Fc/GEeK6VGoEAgUzBtb1GNTTG7ocNnqDjIhRgXyzF8qDQob01fVzZWjZZxQb/WG7Lmb8mfeww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad99454-6e57-4bf7-6c8d-08dafb036d6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:56.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTMLHZNxzAPNJ9tvwBYtLwV14dvVvMDrmoycnjM9SCS13D43d5xq98KO8aIiitTh/GACdmnikYZKNsiU2tPDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=997
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: hQ9cptZSOCRO8tYrQrGcrTEz-ZooiFPt
X-Proofpoint-ORIG-GUID: hQ9cptZSOCRO8tYrQrGcrTEz-ZooiFPt
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

Use the new locking functions for vma_expand().  This reduces code
duplication.

At the same time change VM_BUG_ON() to VM_WARN_ON()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 188 +++++++++++++++++++++---------------------------------
 1 file changed, 72 insertions(+), 116 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9afaf05eb96b..a0883c23f948 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -460,122 +460,6 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
-/*
- * vma_expand - Expand an existing VMA
- *
- * @mas: The maple state
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
- *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Will
- * expand over @next if it's different from @vma and @end == @next->vm_end.
- * Checking if the @vma can expand and merge with @next needs to be handled by
- * the caller.
- *
- * Returns: 0 on success
- */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct address_space *mapping = NULL;
-	struct rb_root_cached *root = NULL;
-	struct anon_vma *anon_vma = vma->anon_vma;
-	struct file *file = vma->vm_file;
-	bool remove_next = false;
-
-	if (next && (vma != next) && (end == next->vm_end)) {
-		remove_next = true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
-
-			anon_vma = next->anon_vma;
-			vma->anon_vma = anon_vma;
-			error = anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
-	}
-
-	/* Not merging but overwriting any part of next is not handled. */
-	VM_BUG_ON(next && !remove_next && next != vma && end > next->vm_start);
-	/* Only handles expanding */
-	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
-
-	if (vma_iter_prealloc(vmi))
-		goto nomem;
-
-	vma_adjust_trans_huge(vma, start, end, 0);
-
-	if (file) {
-		mapping = file->f_mapping;
-		root = &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-		i_mmap_lock_write(mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-	}
-
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-	}
-
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) != start)
-		vma_iter_set(vmi, start);
-
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-	vma_iter_store(vmi, vma);
-
-	if (file) {
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	/* Expanding over the next vma */
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-	}
-
-	if (remove_next) {
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		vm_area_free(next);
-	}
-
-	validate_mm(mm);
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
  * @vp: The initialized vma_prepare struct
@@ -697,6 +581,78 @@ static inline void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @vmi: The vma iterator
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Will
+ * expand over @next if it's different from @vma and @end == @next->vm_end.
+ * Checking if the @vma can expand and merge with @next needs to be handled by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct vma_prepare vp;
+
+	memset(&vp, 0, sizeof(vp));
+	vp.vma = vma;
+	vp.anon_vma = vma->anon_vma;
+	if (next && (vma != next) && (end == next->vm_end)) {
+		vp.remove = next;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vp.anon_vma = next->anon_vma;
+			vma->anon_vma = next->anon_vma;
+			error = anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_WARN_ON(next && !vp.remove &&
+		  next != vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (vma_iter_prealloc(vmi))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	vp.file = vma->vm_file;
+	if (vp.file)
+		vp.mapping = vp.file->f_mapping;
+
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) != start)
+		vma_iter_set(vmi, start);
+
+	vma_prepare(&vp);
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_iter_store(vmi, vma);
+
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+
+nomem:
+	return -ENOMEM;
+}
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
-- 
2.35.1

