Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568C6EE3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDYONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjDYOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:13:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3F15462
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:12:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi1SW008675;
        Tue, 25 Apr 2023 14:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zk1NC2fG6tYl5ET+sXVIUCMom8YlQoKAotPxuETP2bE=;
 b=cMq/7R30hNd7CxCX+HQut/Evm2eJoDydFZYxRBMsz7EHue2Qw9VJHrDs7Stjpl1vk69O
 pYN4Wnl9dUHjql19zzlJd7OeBdnWh2Dit8USV1JOtM6vgfOS+oI1xafFffNob/yq/yJ/
 ggBEB3RrgD57dDJZHNM5Ti5jYxhmikGD7u0eT3Hg8iJtUeWrU0WxYuDEhPhltg6r7VGi
 31B+Pl77QWU5pWH2/laIJPLKhgVYWJ11W7yOtKjWBbT+T9rV3aJ+sTXzOVvmeLbX0ETR
 iw+6H9Rkf8uxew4SwnS7h/t4JTvJi+Hk0Mhm3EVt3C9c465/bc3YPKu8emMOHoAhD1pG JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5e6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDXeUe032632;
        Tue, 25 Apr 2023 14:11:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qtmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+yfTqRRhYxW86E0jI0E1srfJBPTYoz2vIR4X8LDmJW7ResI1jQaFbcjidbInjxmZkpxgcNuzUhjhAI1zNzgeh7IzhcUkR5j7tt6Zughf9FAOfc3M4YEkksDWUCtNEQw4fEJAWdxb9F6oMUvYOBMk4E1XRNaFfhdaNAWiMhHL6r7zlK2pz5Ibiur0xoAbcsLeN3QgLiTLWTwQ9sHboNfkmOL1dFgjFLK929bdrYFIpFeU62tUc8BzOWTHrc4K1VuhqjLMNxYRkS9L/FgVQJC2xCxG+/mW+N9QTuGkGuYNcOZSr+cFfIOiD1Y2q0Cw1cAbOWvWkIwDFQhMvWYV5xRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk1NC2fG6tYl5ET+sXVIUCMom8YlQoKAotPxuETP2bE=;
 b=JpuZ6+i8sIca4M7iDUhyI4W7Y5lmkvAyynQ+49WqNX2ea4rgm0by8xzmo3GXnlIpdx3zqvKCXtZRbXYqBkNtZ3AoVl499YmHPRg7TxEmXDQ14pAwnK0o+sR9r+dRS09ruYSjpbRhCYhiaAhR2S29O8m023SJd90oe2mS1t6SqlvRzkCPp2RYW1RBObzEg5kobcBjHvHxUwSfFI4oc/6+tbydoUxUN1XoSEEX08LAKM2CvWoyhtJjTddl4U5vFB0RI/WXsTezTetXLfevPIk+y2UtUrsSAuT2tOpOVXxHodQ5rT3SOlAbMbeylHWSm86S11Ig4plVnjiiISx0uC9syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk1NC2fG6tYl5ET+sXVIUCMom8YlQoKAotPxuETP2bE=;
 b=OMCljb0GTlhdG3KLfeIU/WcViSxYopQab9UaQH8K86PG1gVHebRdprxjeKtIt8zQmCGRbCyfjBYkYJZwi0pbUXC/WL2dREf2I2eMyRGIs1wFyS+PyBvnOZRlKbGCkI4CYxC6FNFTstllUTPWWqZfPj3A4EieWaG0SSQqZAFqmg0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 21/34] maple_tree: mas_start() reset depth on dead node
Date:   Tue, 25 Apr 2023 10:09:42 -0400
Message-Id: <20230425140955.3834476-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9b0886-0df9-416d-70da-08db4596eb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Lg989TkU5CPsptCc/e7c78db+ozSMAioF6pXWKSFA793/AR+pBK6ZVEcD9Zb3RE10YsnpORhcoLwVh0eeu3v0wtdjLyaF7pO0MW/TDIG1v+e2p8nY7AOiCdYcNzHiJXh6NlD7xp4nqYzYwybJkFVAH3TK7vipfc3LKWUif/3GWglpbDeWwzGY3RD5A50NupaPyTilJjuNU5woXR71OzeixOIciGF3wr34Z3FoR539M2FnsBvz53z2I4iuG/a9EW9LLk/MS/qSqKOjb9Td21OdCd8HYB/OgbA/BwxDJdEIoV1M9u4/dL4/KOO8CEZHzUUu6K8IrtbKlFFAey25E6UUb+j/s2/AhFc7Bh9QugghHXPFYmDibx9RdzhBQb9pElhx/46Ue+Zh4gKeW9zVYY2YPiITUtq+ag/+VtHpxRO29KT8l2Bo8lQH5CPVEiYbWOKWLRtv0IUX4+6RWzUUnD7wrV3FhqZqszciELKjoQFc20zUUSnsSYY+zZhoc7GytkEd+HC5j5y0TvfyDtrcrCmkUOkCoHo2m/hzmkBvxj0i10v6P9a6zJxyu69zXPONJI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(4744005)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxeKpFQEgsK8q++75o0XRPi3QzeX6iubDanujPc2reUJgwdrtoRHJLW8Hk8m?=
 =?us-ascii?Q?lrugWRM61zIQneXLa8hwBw2VQEoiIh5bKmWHQTt81WsRtOZHi40OwR7GpPpw?=
 =?us-ascii?Q?HRkpJ+i0AO05pZq9sIbPmBaXcNTWu5TrTFj14AcNDX6sthWU6tjFv8PzBGWU?=
 =?us-ascii?Q?W5Ckb3sVrEvual9iOknz37oPW3fxdqG7mlyUrABQoRYSrrU54JoQA2DBiaRP?=
 =?us-ascii?Q?2SAxTDaTblj7L0YyGuZl8MmNXiUxNI8yZXhphDT9hrSA7W/5f2X4FqXcYWBZ?=
 =?us-ascii?Q?o+m3K5u5NljHeTVviOXArDR/RbeKLioThb5ZTwaGnH/iiegwqYACqmhwjbsD?=
 =?us-ascii?Q?QB/kQct+ZKPy3qhaeRqwrNf/jctOCYTPmxL4y6LKdPonWEO3fOAx9UnKByvb?=
 =?us-ascii?Q?8x4q889v7qGHkb+LiNkIr1rf+n7tzHk3lc21NjV2npaNER30VShQNrg/4KmQ?=
 =?us-ascii?Q?nZWIiXscc7WJMTmD21sZ+oqHwlGI9RlIjSVwePjC5oz/NRG0qg9L2Uj6l/Il?=
 =?us-ascii?Q?v2SNHLHLhHNJ0r7K97vjxsNPM9C2tQzeVDOs+x5RRT4CuFmYAsyVcCfqDNj0?=
 =?us-ascii?Q?636r2ghPDAKA7yEt8CMx/v0pB31WnrmJAxQqoag5SvIHoMRrar067kx+T9co?=
 =?us-ascii?Q?mhD8lE9Kfgtb0PwHhiWluuWBU/OpWErfMCA7DrCpxQy3+pV1K040vx6UT0Zd?=
 =?us-ascii?Q?Wbg36HFIkr7u3TbArmABkt6sM+ZGSiMcMxEsAhd8nMJTzHxHDOvZGjZnBPyb?=
 =?us-ascii?Q?YH1hpoP+XSZnseVxy/TQ6obFCG6UX7vO4b2t45BiL7rAy6TWo2P+UGN+WFLH?=
 =?us-ascii?Q?/lMvspI7+oFReLI0WUYVJbd8wQKxU7IOFv0tKmFxVc+nzz+eJeEEPopP3yRC?=
 =?us-ascii?Q?igBYBm9VZNcX5xzNbE/TOJJ0Fh4OH8Z7YF/XvkRXa9CfhfJI0dDyuW8uglOR?=
 =?us-ascii?Q?xfdYrG/RjtZBZ+pG6NvT9f+6CCdM+KHjeA5I3Hxz0nHzIuL07vwXT8ENweFO?=
 =?us-ascii?Q?dZl+EdLaxwjCpIACTYRjsx7yAmA4UP4G7jINIup2SdiKrFxv94dqfpaNmL1G?=
 =?us-ascii?Q?fU0yBbmPTo5XG9dGXz5E66X1rKjeXBwVFWY63uPgQqHmnGQtJ4r5evy282ej?=
 =?us-ascii?Q?vlNMfxCO5yk+YCIsZ9Abp3Isic4aVAJqqnjaZktBLgGZldjrGtDXbyhzhHdL?=
 =?us-ascii?Q?PrXo42egw2kOg3tO4MPJygx6JRvWMz4wP4W+3u3T+efeF2xA8vK6ZTL3ooTC?=
 =?us-ascii?Q?vZHopkzKG1xXFhMMYoV4lPN7v72wF6De+ldsQW6gbSboPjCcLJjWMlaeNYb+?=
 =?us-ascii?Q?90PckiLt/BLv4gclKBjRxiWe5F6AOh14GjZkRp4WyObL0MD2kHkH3zQZUqNp?=
 =?us-ascii?Q?SapMsM6o+8IzlxZUcpYT4HQ0f5iRC0cr3rh5XL/z+HSXvgp8NG6lLP9y1Lc1?=
 =?us-ascii?Q?y0xlefs1jDXuL1C0wj4zu6Xk57iGfCVyYi+901Pq0oYF/+oe2/olIFF5b8gG?=
 =?us-ascii?Q?Y2ZBvXuAhZ295TkImeEJxo3FD5teox7djDHDV0Gj6IYcXGSiBpCvpg4XdTlN?=
 =?us-ascii?Q?zViL7d+oBzzzyY2TOFi2BBY6khaH9iG/xqbt6T2zW4qeT4yBk0kpRi3vytQd?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZUh2hfdNdKQwNJDv8HIzVZBD89FnqDV5ktzStler4GGaqK4hDg4WHd+7mOXaosi7xrsHHldsi/I8L6HzRjt2PhFi+sCSwK9kRPdlkcxOPLIUB7uKDGKNuJiz5IG23c1qtZVLKRLWK9YUwUBrzuz2JpyuQindpGZRcWBMkEL+99CrnEPu4kI5uIJq7oNtUYzq1n4Rhm2KUnsPQxkjDTGTlVbxs+qPULRxIbE27Gz7JVrgm1jw/LA2qaR+HbcgNGutXZw7+8rBMTTvn3q0IvZrTkXqdcTTbZrin7cH4zhOqIHds4/L8XoEmuejgG3Ec6Jf+TAaI0MAGj9nUZ+sG33gOR/tA8NfOayT1W3vFPUWTzlZexjYYNUiTdqAJhZ6lApNGv1UK7tuxf4oEzClNQPWU483GcNBuT0TdKbZEEe+gmeFIwDrVsR8zomKg5HOoBETjbECUFjY1tDg+3MCOxfPL6TXB5zhQvNyfal4glMbijRxAkuNukAPcqohRKILdGehtF4WeQH/PRFp1ZRY/I0q8/NZZASgb9UvpJe6ozO5IYnMv1ktdYow7wyU6j6NCCEhdHsfH0YcT+cQG28f+FbkVgvJhImAJjfbQyaaS1QJX1JSHN2JZXDwHUKHt3gMoguWVhxHhNm6Rc920G9TkX8hp7IzIK1YHtoeuJRG+ptHVql941tzUV0TAF3/KG9w89tAMxLJQIAlkLySEzYsIa4Gt13XyrmP8L+9np+5uBcZsDA0iOLQ3sm30P5VO8ZbzrIEG/nwhrx4LNxBoum67sJkAp1zwgArvgHrBh67DjOAkLxnZAkl681L2t/KVYDqzlFURUfoP7EoHrQ69Ij+JimkbzRfEWuUxX7ZTxbM8m5cpP/w2Ap4UzncuC0loFTrZ4vGBgh5ZweRRZZyKY+DytJ/6w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b0886-0df9-416d-70da-08db4596eb65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:10.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVi6jQ2lXihf0a/DwSfRRQC4vTRP+bb3GJoheCI2pJ/Z7fNkDfxpA4x0rWFsGkgEZmSpQ4ItyHgYf/5dRAfrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: CQ_JprCwYgSqd0-Xfigb6jQnQawjOYco
X-Proofpoint-ORIG-GUID: CQ_JprCwYgSqd0-Xfigb6jQnQawjOYco
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a dead node is detected, the depth has already been set to 1 so
reset it to 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 35c6e12ca9482..1542274dc2b7f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1397,9 +1397,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		mas->min = 0;
 		mas->max = ULONG_MAX;
-		mas->depth = 0;
 
 retry:
+		mas->depth = 0;
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-- 
2.39.2

