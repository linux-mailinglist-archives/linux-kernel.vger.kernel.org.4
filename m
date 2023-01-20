Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB094675C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjATSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjATSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:14:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DE6FD04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:14:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDi0A014958;
        Fri, 20 Jan 2023 16:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NyI54cfSoAYorfZDyAa3nND4Vl4OMWtoyprfqHnoXEw=;
 b=TuPLJ7uatRmACkPVoqwPkQOGDH71D7VWuZds1OzdnFmql5XFee928uXUxvaOyRz70bDt
 t3OMoLF6XgUgCt2vAtc3IBO2HgXt2zaPPJTTDcXUxRZlWf1UOVnaAonodk/QVcXW8EnB
 uBWmUaXBDQ85m9uV6LaUUvHw58ByPmhXcdsxB7jh3kUqi8sByjusYWv80kp1f0YP8Rt2
 Bp4NUc6OTGiFGL7qOBSU/hteWerhfgFWWtCcl2LdTmYjNMLX4p2QEhst9bD1GRl2ZlK8
 7fcwzPGWuUZEskVM52ap0+N48zuocwIb2XQ3oeEqMlt4CMrelz+muYDdmC63zv2hDFQj 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd22d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFA49L013492;
        Fri, 20 Jan 2023 16:28:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfaxyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOabUcfvrscPf2yiKhWr48APgU8SVwa+qe4x4CZyDe6yWF5QzAc2uTrV7aNaiBI/XHgU2gh57TK5Ln9+QYbOrnU2OmcmbuWoonS4YOZYRuHt3Jt0wKP32eKltsl2g4/IXa1uc9A+NgWXkMkW8tlCZvwjLYo4wUWVdkOYr/U6qVXa0V6cD5LswJen92k7e0ftcKwZOHmzz5TCozDIMirapjMT0S2Prm4ytbxCe8Tf10FNfvhfqSp16KEKz0O+py2HBwUstrVGoxVqlccIcyQ9gqCNOPTDlOAuzhPSrr+H29p3M/NaqdIu/MeJaQZbTkADAVURIFQclhUVKldZircdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyI54cfSoAYorfZDyAa3nND4Vl4OMWtoyprfqHnoXEw=;
 b=a16LZVu91+Y3kpIIkAmeZVd/6loeKbWzkIuuRkrI/AyOcDCrbYA5eDujjcHVs9TCU3/xLKiMFZxa66M5nIygYZy8c3q/rrU55gmd13pClcLyZmbjrjl7MP867I388pq7tiPkvmRhBX86alAlmiQf2Ke8B5aaei2ZtwPjN+W22GOVbklK9D7CKG9oquJoGIIX870Ae7M+qoJOHXtPmHm8N+a0S5D0/Tj9VtDIRvknpUut42qExcf7o8Ttm5KiG6NnBkCL0H5LkYQU2CucknSZK1knUe4UWNJpakZ3/853ElRFaT7Cgzwx/xGuPb2Q27omI2A1+rvLHdcTrDQXxhGFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyI54cfSoAYorfZDyAa3nND4Vl4OMWtoyprfqHnoXEw=;
 b=tf8twEmWD0adRGygIGwwk/jc1vP+h6WM0WFYXVmk8f2a/RcNEZpH9PEsTXJmqPmEGpnLMMh/+hEOiwJ0LQVu3rSlyysQGShSkLS+rcsR3+IIL1oO6Soxcf/XumAovm5U0AiuqCr4iiUKpqPoOeKPyOceqrmzW84bTjsieATBsxI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 20/49] mempolicy: Convert to vma iterator
Date:   Fri, 20 Jan 2023 11:26:21 -0500
Message-Id: <20230120162650.984577-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7538ea-4cd3-493f-347e-08dafb034c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWZkZFXjx2rRG2kiS+C88fhksoJ2Mcaydu2v8OV+9z129NCDFVAgkWpZ5Z097qX37jHJWyXIvQJzAlPUG+gNgWn/H9OUjzvzn2dbNyfEkY3Tb5pJ9UV1RIqgRxRRvtSKwwA6fy7W+Hky10sZ2Nnhj3ZyrN+YN2e1WjjueqoxYHNlJa4SalG59cT0Aj+IvCUaWPKk6zl67oAhWRQQfAVCaRwel9snpsljPveYyrpX8b7xA0T2lkbvCov1fRK9VMvzA/tHcSC72ub7XzH1LKupjqi0ykvaYMyyF2de0QtGHQexJTC0MBeTaLlK59J5dOm4la36PUyGTCfp+xHPLfVbg/X3MB2iRusiKZWWyOOMRqis5x+XCaMyFlHvIrlle3x1T5bmwNvZJG9AKggVMVeE7gu0GZWWaN9Jy22MsXO5JfSOBZEVrF0iwjDm4HV5Sv9XwYI2s0ib8wf0QMXvpl1oS+Alue4J30yVR7UEIl+0Zbt8X0wjV0gVjSjlzOwayTPipcUY8tXotIz1eqr/syjOgccqHT0lhnryfSDenc5K9bQRInE5U4c0i9CbJPo/mV8DT/ZILeWVqWJKInACR0sJak1xqrZT/pWxM90+o8gnGUsQanVyv3iijyXeAkkyd2them2grbX1Pn+gn9BJ5mOmYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3LkIb8H040rbUw1l9SoapIEHzInk+mbdFrQACFaA4jWP9wE4eq27Drgy5lU?=
 =?us-ascii?Q?kZ8K2ym5BiNp0/fOX7MvQLMuEqS7Ub5OK/5fLMQUAyq16vWh+wQNDLfm9Fo2?=
 =?us-ascii?Q?9xuNbYn2RSdKDpbbiPqdzBRFu+n+Z0LMoPlThVdy1A8wHKo2mjvyQPuI/vKB?=
 =?us-ascii?Q?nBoXueaUQcTCaprEgNNnDG7/REjrfeS/XdgUCKPDbRctTmZe8TvYs6cizf3L?=
 =?us-ascii?Q?LS1JoSpqSZXP/N9+X79M9S11hqQYa++yWs35kWdjJ5LW6RjbpaqnOiY6feYE?=
 =?us-ascii?Q?68xZ0WSWfUj58Dss7DDvSY9DcbJyjW3ua6ZnBJPqqUXhKo5UZhKQNvP7Zwbw?=
 =?us-ascii?Q?9toaPkKioAXv4Igoi5pYchjWhFF7/3VvtkXsJUtNUDJ7ULc+RrCQH9FON/Xr?=
 =?us-ascii?Q?BHqYG+rcA810P3OkVFPx4oJdWpUhFXqE0fJTSQKM9htWLrNdlFEEQNESukHX?=
 =?us-ascii?Q?R0B+H0LecqVFOYcEUTmh7ABv66MB9cz3SUdsg3HlqR6VyEFNnLzLTyjkPvd2?=
 =?us-ascii?Q?uh9Ar8MvSOPyb1kCM8mkzGKQOyBxN3azswqFLcW0y9VuX/MUgXQ6RWPyCveA?=
 =?us-ascii?Q?y0ljfTEuo66rkpCB43yTJ26PfnkiCBXB7w918gkXEVmsQZw77KTljdpZs7qL?=
 =?us-ascii?Q?CKdPyyuje2Fac0kwvknFxqJCALzQDJoLr1yRssO1i/bM4Dm6T/gf2QQiuA/p?=
 =?us-ascii?Q?5wJ4331wh5lnCC7k3+LSNdLNvb4Za6+JiXGp3YpQF8i2ykiL5w2xtjx4pt20?=
 =?us-ascii?Q?DSlcdR8hkJenSto9dGG5Xlks+Biov15LJG/c+p1+nsyq2MFCQznQQj7aUwFB?=
 =?us-ascii?Q?R4gV7yvqgb45JoW/PvKHGUUhQMFfpu6ilqfb2M2gQugTK1HyrTNkVPMyfdJQ?=
 =?us-ascii?Q?zsT5W/zMIfnWCNyiEWjkDeDycKFXziisE6F29BWaY1tbTArXYDYojGDF2HIM?=
 =?us-ascii?Q?LpihB14eMDfaMieJ8px+MY2VfX9dAtqpE6Pqn69Alfr5qi0QW0xoQlemkKzo?=
 =?us-ascii?Q?e2buIy1cLn5DshkwxirgaGNSDid0+BwfpgEy1cbWdiHvt0q3mDVnbSquGYDg?=
 =?us-ascii?Q?Vaw3tZkDzwWgOhNPzQ/LkiAOFPXc9oMyIKw3skBMvSJ93e6MoseavToXcrTN?=
 =?us-ascii?Q?reT+zk6MQzIf1OmhbI1HwsUKZ+kSuWQ9LWqjnYs4wyktNcnwCxFKQ2nrXnnI?=
 =?us-ascii?Q?jwh0//01pUm+/Xka1uNxa62ypSPmmFqM8WD8NES+6BnqOnLABm9gPnKx6yb8?=
 =?us-ascii?Q?Osn8IyqbK++h/TKyWmvJC7N085n5AIu7XS2/ZKAcNxq79mHROAtd0ojtKVY+?=
 =?us-ascii?Q?ATgfe//5b9l101MVm/Jw/S/a1OkTBIecz2CZUTbId/lNYjaB6fUkFBTZKv+G?=
 =?us-ascii?Q?MpcC5PVqZIo9POXChSqFX/CdVpw/rT1r+BfPRGiOg0fTcZq4Y88SZvCOfCYo?=
 =?us-ascii?Q?24M6HsnLQ0CplFmTl2ESbXRvJssIBfoReu5XaqP0MjFC3XdyqbMN5pxfT+Qi?=
 =?us-ascii?Q?elE/NEW7Lpqnk/5cuVFYGyuXXuvcdyKOOdD71x1w2S6xirL16a7Pmw0UOcoF?=
 =?us-ascii?Q?HAIS2HTxvqoTtkShYPHFS6BloShiM+N3Rilpnq9BmffwQv13WXwno1RZ/pzf?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cquKLitXkdoepoDxPCNEyaEpFFrGnOOXIJUEb8M+a9X5Mwo7sLu59HmGN1vxHyxm6zpFsPa+v5Y5NgRSMR07bNCN5eiF75AX/DgHNqx268LHVHhXlOXUj/OMbJwMQh0+P/6tBb/+3q9P27UhaMFYBcjUygimYG4F9dYLWe1KLq3eS9tl9yGD7/djrDH3MQr20PEX4adDRzu0BdngExVaWt2nEYLt+rqw64UbpZObltrirBeOx7dpllQcmA8anGnlH0UgibcmmLUMxtVzglGdXszYPHc6c8gSQ1aSpIZEFWfHt7M0xXMvB3I6IaY7zqB5FARihc9bNvvM4ba1ySYNs6evHXAaapvPisrVPW3KkwshJ2WeRU6XGRdzKS8qE3/OM6N6UY1l+2462wvxyhBo4z5q/eWhFEDMkNQHyYLN9bdO44wzkoh2V41XHddUY+2qR/JRHE3ta6uxWIfIwqVBNX2ljlZK0MLkk1bm0Dx5qlMx+aGuySdyTm7BLfCiR9qhg7c2qW1gBGp2oRd9PSYB+VOWedI4JcJji5hX9K/Am7ZND5AAFucb9WVGk15lr/h2bi/KNHnwH6Bz2IgRpBczrAg+6pbKMZfbfOWuEpiQPY7WUXEkApoqG18ODEqCa1n2UVpNNjNfrg7IWTnkg+m5We4wPAizNE8wa+GKCXF3xUKclizr8k2DQnYDBWyi/41qUcleWjUZ7T7vzLJsdWZHQOal03/MTbITmOI/XBOBzyo792M5eL+Ivt8XPWQGGATSZFXgw3se25yyrz2Ox7qmR9Z2W7a5FFd04wWYyegEFRwDJTJ1deCXnBHbCwkZcAMFoGnEseFNvn0npX1S+DSHU4ZP8NhA/8Ia/5Vps/X+V7RfbxHOS4ZBYk825YFHx5GUOj955MSxexw2InwFq4jfaw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7538ea-4cd3-493f-347e-08dafb034c52
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:02.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooo4p9iExumGqHeNr8M36R7YpH9bgK1dUHjS+duEBJ/hRJXvZPFXtBmnJQnPvY2XrJf2PXlMxe9JMlGfLYX1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: Sg_AcXIX_VmotX3jsWaskJdGwpoJruJf
X-Proofpoint-ORIG-GUID: Sg_AcXIX_VmotX3jsWaskJdGwpoJruJf
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
 mm/mempolicy.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fd99d303e34f..f5201285c628 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -786,24 +786,21 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err = 0;
 	pgoff_t pgoff;
 
-	prev = mas_prev(&mas, 0);
-	if (unlikely(!prev))
-		mas_set(&mas, start);
-
-	vma = mas_find(&mas, end - 1);
+	prev = vma_prev(&vmi);
+	vma = vma_find(&vmi, end);
 	if (WARN_ON(!vma))
 		return 0;
 
 	if (start > vma->vm_start)
 		prev = vma;
 
-	for (; vma; vma = mas_next(&mas, end - 1)) {
+	do {
 		unsigned long vmstart = max(start, vma->vm_start);
 		unsigned long vmend = min(end, vma->vm_end);
 
@@ -812,29 +809,23 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 
 		pgoff = vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
+		prev = vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
-			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma = prev;
 			goto replace;
 		}
 		if (vma->vm_start != vmstart) {
-			err = split_vma(vma->vm_mm, vma, vmstart, 1);
+			err = vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end != vmend) {
-			err = split_vma(vma->vm_mm, vma, vmend, 0);
+			err = vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 replace:
 		err = vma_replace_policy(vma, new_pol);
@@ -842,7 +833,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 			goto out;
 next:
 		prev = vma;
-	}
+	} for_each_vma_range(vmi, vma, end);
 
 out:
 	return err;
-- 
2.35.1

