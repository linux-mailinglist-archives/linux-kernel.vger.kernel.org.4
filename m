Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28718675A02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjATQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjATQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:31:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471571BC0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBYmA029935;
        Fri, 20 Jan 2023 16:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ze9CQLzhnFHwEl5pGWEkfDnwGB29tne9wg0CTYEfFM0=;
 b=MTm6j9DyZOEWZ2oYsrpAEca8ui4fekkUOn83ExBf2Ga+2KDYvh8tELQ4yisc1NrM4FDl
 lNnobgY6E51FH8MiZpMh0DbropE2MjuvNklmsoNLu8s8hYn3N2MnOU/vQc2bSu2w+E1u
 +K/2uuQCIhoyoB6RRhSBZh5tasBMpikNCLhoxebEzZRWwYYtFUUDohMUrh5A/gicoP6y
 6miolRmkACctopcaSxC/Y7Ao7j0f6LtO8Y59Btm3uSw9yT2K2R1JEnL2Kv5H1tWacEIj
 Kn209zMYqO16UrhaZlkiToWrm0Ih4DBPpprBvUHOY3oLLhZLlh05XTPz6KtLhkVipRM7 nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cd3gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGDla5007833;
        Fri, 20 Jan 2023 16:29:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgeq8w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1rnr/9xkBvOgt+tT3hFW7uoG7WdvA02/W995Uo06+AU2pxv5Kxomjn1hw18sYlIdLOVsi3EbeuKj5p35NUiakDOa0l9jPDJXRFqCRBIdh+OHw/Rz+9DXa8mUy/cmLyRXCq59USarAg/pI3ED3H2f/sGEHBypOP4M1to3bCgjicfbo1GvvfAnozPpcZhtF8ncV69zxGZ2+7zKqTbkZ05SqAgq3yGygT7T6tKBRzFBcCVCL6MXRrkuzPYf+u0QDKyS2yrwI9PBuM1C0lk5sJd2v2oKEWoUN+VTAw4GyE3wogQMmUqS7m9xzaF16mz2bxR0sm9klYY9Qp7xVnQjWc4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze9CQLzhnFHwEl5pGWEkfDnwGB29tne9wg0CTYEfFM0=;
 b=mIZ3yVzJet0RTaW8asAVWQDhKlz2izctXFmC3ZiU3BRn80SlQFR1VrS9yjwo/aK6AB4+EVSlnY9WOhOVyZ7h6q8rNyQPJ4zbyA1ib0bPSqAbo+nmPt9kI8aM2CkjJWulUv0Ut+CbYW4tnaTHbjsyfa/4+TtVB2t4b6SS88arT1Hpx/9AVV08GG6t1HrOXgnpnzWGEW33NkfgQuNwNkGIl9bER5C1Uo960NNNCOVs2ySbD3FzyfPuLYcLX1fG8DCai0IKiXdDB5s/6WVWnNlbXcLG8F5UW4MPiu1pdijE4DPVAVzcDxoVOXJSqEvSNeWVAqrNBB6kDODfp30aszVyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze9CQLzhnFHwEl5pGWEkfDnwGB29tne9wg0CTYEfFM0=;
 b=INxhmvNFHurbvhln+XNo+rRkOoo1Vepn3PCRSJGCaECnabS7O5jiPmmNFvlPgOdv9mrq3r0ab0W80OZ9jTBU9tlBPIRZw2CAx4I8Lfet+5DvkS8D1Zc8Ca0c3gpeOD3ETkBZqDYvBkgJHB3hBe9BBaupd128FS0ThMP4cfQt9+Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 49/49] vma_merge: Set vma iterator to correct position.
Date:   Fri, 20 Jan 2023 11:26:50 -0500
Message-Id: <20230120162650.984577-50-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3ceda6-1cd6-4e8a-19be-08dafb0379dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cn+ZwIsON3aiKZR1CyqtWbeypLmVPXHVwxENMK0Zwwk8bgz+S9s+roG1hjj+xi3uFUJwmK5e6yWhyZtAr6EfDsZ5hmD+a+VqWOfmNAyrMTR19S4JF2CRhtUbj6072jyHkCOGMMuoniA/swYDQXVl8hWJ97IAR0A4DBvro+PlOrgune8vcQfw1pEL3k0GEs2gPerChG6YHYyKUHoCPClXM4wsGMTnTDPlHlRfEubWgMK3Nf7R3sV/AkgI2nI1V+gfZvU5EC88GCSmrmMaPArbWYJudhpFRlxjVTIqWyayYLvUJ5GtCvczVKQOC5pnHEFga2Yhj/65hroe24cbwbdJ1Y1ToPdblCaC1XZVJKLqlGmnT59HVbJBGnCxajH8JT/p8HSaB0aX0FtWqjhcp/JOPPFykvBICqi+V1qBhea9HOWhby0VJC07G1ttJH6FaVhRuCd8jUMH+nEuN5I/SynvaC6YiIroBHTu4GknnP/VTUBCSPwou5pWszrWk2KoLtVjzK1jHfBLJykvlqeEN5ls1nonRnk6ozXGIB5AtOziXtQsOuTjsL2FBABKKLEkZem7uP5E7A87DwkdnnzWeg36ANbcVzuvEXddR+TlPTZkZblyM+s2fRA14Fb+iZ7oWy4TcfrOcSEPKRrYp0u9FJhKcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(54906003)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(4744005)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?orQhNAVVS1nMzt3SuGghMBKU0DhYkgb3QTXFkCpCTOXc2LJzKmxra/IPr5hg?=
 =?us-ascii?Q?BCrL1Xj0JiMWFeb7i8fUQiKoVbgC23hnC/cFCuum0s/In1FlZnQL4MJvVkaB?=
 =?us-ascii?Q?lLxcGOqT/kgVE2JshcWjHy2ioHF1ecA98AdHh0GehygYM7i8CAv4cm2kek3I?=
 =?us-ascii?Q?R8G5sgA0rem9dS7lgDlM0IQfCD7tyaytKeaahmiGL+JO6OGg5uWhynkQU0jI?=
 =?us-ascii?Q?PuKaGhqZ+bV8oe3XoCy21eM2tWQmSQPaJDfOQv4WtbJN0TOazfTLPKqAgmIx?=
 =?us-ascii?Q?rMMNtWzZYdckT5RJ0L9RdxJTUha2cOtt8ReaAvw1MXJwdc1zqZXZ5/c4h8km?=
 =?us-ascii?Q?jeHCWKW+K7jF0u/fDQ7flxHlWr0RKHYPiZCHTIA+2DPPVMIqtz/GocYKTDYN?=
 =?us-ascii?Q?exVm5LExddLzXhxPxt5M5h67C5bTVikeuRtS3XtV2Hpf5bB/gwMGOjehfw+J?=
 =?us-ascii?Q?9Yav9cKaNN6C7TGWjet/ViN2hjEItgqIJtyLkRdt+xGYCaDIS2G91VS6dKbJ?=
 =?us-ascii?Q?cCDPAPdLZbb+LkmPjkasCWMJa5yGQR3k84e37r5xbWtlk55yDz+q1jG9hpll?=
 =?us-ascii?Q?vUUlYHEAJCVhhXGgSljiPe66QGSjlUJ6zsiimZDVeOmzKIJlMlPTsp4O88Ep?=
 =?us-ascii?Q?WktTNP54YsQv+g/XfFGdUaLclVGjxFEJ0rLHnqNr4jcv859zyfl5spHB0hPZ?=
 =?us-ascii?Q?0yJB5y2rS9pjB0UlyhAUtly22zrne+A2YIAZPQ4diwMOxqYFXECNj1Kg2w/t?=
 =?us-ascii?Q?+z+9p6s5JWUXLzQUW1X5H17vFdiWBznnXbyNh4kkimkJOczsMmoOC4Haei0Y?=
 =?us-ascii?Q?g7i43lxyr6CCFzFGPSvN811ndHUtzbgUncRn43LbmLNeRbPFKgQ/+1TMpbOb?=
 =?us-ascii?Q?tQAHCAthHagKQ/8j0ML0/AWyrzXeAdJpWS6nnYVLl6rJhaHUVMRUAS9JW51w?=
 =?us-ascii?Q?T/7dg1Em4pMrsuPqJ7wcOphjUym6xNcPHseQeCdhbAyq2OtaBMmXEhpUr4JN?=
 =?us-ascii?Q?10+Xnazk9oiDwadc25GgqSxoYIhCOurIq7mVBnwrDc6ryCyEIisERsWLAxvy?=
 =?us-ascii?Q?8eap0LzRgO6Pe77MKN4nlR1m02PHBpCdk1Rh25FLpL2rktEfu4ppcQjgXic8?=
 =?us-ascii?Q?fZiOHQPqFLIHQltDvcfRaPLToEJ+TnEqUozRufEKg9KUg28yBqJYB2cE651p?=
 =?us-ascii?Q?KISblSYItsMAQx/fKb4L5iNpcl/32gxWn31RmtnMnPwlbQGrNYKVZunEvbQ0?=
 =?us-ascii?Q?BvAViFTxHNDGehmzji/mISG/BnE4J/3dj1HLP5Mo9NDqqpdcqgMrzuVVMkfm?=
 =?us-ascii?Q?Q6NK1K8JOJ2leMjm5KgDrNNCwl+i8OF3AvGuid95dHYS3TnbuIXCXECoulck?=
 =?us-ascii?Q?aAGVZGMNjuLeQuBuPghKBFkdcFkgOh5Lu4M3I31F/B/XFTjDRQ6Py8YCeJNb?=
 =?us-ascii?Q?dtF+ZRbNEnlMkHogX1Tz8NHRKixYMcvdQgTywFtLhPeG2HiBTKIImvSjKq7a?=
 =?us-ascii?Q?RSyhlKutu9X0D4LXqoYNQhxsWA5sFIZl8qpCNuv8ElRuqta51aHE5lABqQxY?=
 =?us-ascii?Q?uB5bjKeardFEiGPEgdC1OtmOGDkJIDSsGrT1Gzk1i+O7naw2Cd7pLyaGIqlN?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcXH4c+/IICVisbowmZOON32KoRH398HTyPzlfzT+Z0R+iR2fXr90Ea13tYTSio36UIKQu4frNAykdGeFhi4p6bJBAh8eeIsyd1w29wTZUhDvh2UD5pcdgJ1nGEkrJs4zPVtTW9/llJrJFjoa/wg2tOBbI5bIWBIUP2CvUioa+qlkYbJN1SIiWl1pHvB1NQAfvRns7u3tldfSz+/Wd0wHVEzM6zZYUPc73itjNo7N+i14JNzptnLrVtIlQ3Whd03NjjYSNs3ufGY07LBJE0iNFvVVNWL+hXHAnIeqCxTT82/4HC0A9BTLoHF6rHZ9KH4QUni6SK3NMiR3FT+XJef2GMB0zCHccRKyyOBvDTEFv86iWMX2xej6lCe+Ph0s3QqbjsfJKYevZbJm0o/0IUk8D1IJM5kF4QvXJMwPypX/7jjzXapO3dnB+qKc+wQVG4opBV0AGLxw1+HA1D1032nbQhRA+o3KNVy6NmkrLTayZGLq+5+b72yQsuOU008jjw8EVymJ6y8slP2ffgXdPPmF0aYo7v6KHHrFnNPdUa0vM9D1XfNmqZXhp41X8Jezld5+vQc4qWtbuAc7N6TEkH55CYnQA2faQxG0Z3NOnFWtErdwu3byZaLkAHDZXTdswCiKKRaKE8NmDeQS90qoJ8xi9+uvULgWpoJHNVatU2EsvwtM76Hht+DPWuk4Z9QX8t7TdhveH9i3KRw2O0zEQZtV/OBMVeQuQZqqCOr6EwVRcB2IeUdirwjzKo5LLl+HygkK6epFfDpdP6o1kkhu0VciQXFoS07lZK2RHV/ejW3abp7xlYesE3XN7bsqIGI4LNvkJqIArYAptms4/4QJk39LQyqZsrzXhz7zD6LT6ITlzntvHbjDskNUnV69LZVLjCvDy/aRVQ/hljI7i2dhyYcPA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3ceda6-1cd6-4e8a-19be-08dafb0379dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:17.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xld3xeomdYDL/3Kz5QLK1oiHT7gRi5dcC1nWyGmGWxujfx2syGufRKHSas6aIan6R4QRE/uBA3FxE17kphPAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: yGMlBKwueY8tw5BRPWUfn5cSzxzLenGV
X-Proofpoint-ORIG-GUID: yGMlBKwueY8tw5BRPWUfn5cSzxzLenGV
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

When merging the previous value, set the vma iterator to the previous
slot.  Don't use the vma iterator to get the next/prev so that it is in
the correct position for a write.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e227b7cd71aa..920b0c56ab7c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -935,6 +935,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
 				   pgoff, vm_userfaultfd_ctx, anon_name)) {
 			merge_prev = true;
+			vma_prev(vmi);
 		}
 	}
 	/* Can we merge the successor? */
@@ -1026,9 +1027,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 
-	if (res)
-		vma_iter_set(vmi, end);
-
 	return res;
 }
 
-- 
2.35.1

