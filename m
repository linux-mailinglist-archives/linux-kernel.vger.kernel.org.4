Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581F4719072
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFACRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFACRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DF1AB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKAx0q021961;
        Thu, 1 Jun 2023 02:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5QJYR8C6Oei1oSISVfXvwbAAhAE+CkJSWTpENeGDljY=;
 b=DNDJfCM4ONt3vjsCH8mkaDo8ADhZTOK1GOgvPZbhtsvpFj0ceWxAPAf3PX46p40AQ8M/
 ZE6oT823T/eNbXlB2J8+hAU6lGjSFnmsa/6nMg+zt/CO3JIeYF02r8r185uhxzvPc2jF
 gqya1Yw7N1qBhhaQ45ZKXxaHvxvWm/01ruQzeDX7ULtel5zsTrbGoFod2o/bwgK2aC/i
 ZkhiEMfl3bw+Us7x+O7rq8PxmNxUoQZIyZ4bWY6KLelbc+n9ORXG4jxVbHm3fpFw3Csi
 EGNrKoL1qSGuwjAOzjmYZJdPlDXD9/eSptgGBULneSUuxpPFj8BFP+iIsWKwFGVOpsSX jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjqja8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3511YC8b014618;
        Thu, 1 Jun 2023 02:16:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6grag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqDQqNr3n1MitCb7P5+EQwfbog+qnTSDsC1BZ5y3TXdloa5yG4X/oUx/SL0dy01d/Vjj9aYPQiSXBC5HUBOg1bhE4xqy0I7Cr3mQhvp3dBh5GwlLNiUzVTURF8259ku2/Ckwlxziaa0lRcuAWvaJhyJdwANCJuVVz98Ja8Yo9Ji86wW9t0qrzwhdPLWmcazbmfhrpS0+PuMRJSFLa2s81cf+ODHc3l7vi416gyv4zEc+chU26MeAqxe0UAmqWKYWyLxwF06DHii8YLPlcFMUJu0H/fFfFk0K1gO3+ub+vj09LcFQ/S6/nmdqnPuvnou1IhPa1BnPUWOokel5bRCb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QJYR8C6Oei1oSISVfXvwbAAhAE+CkJSWTpENeGDljY=;
 b=SXKjPBnU+z2V5GD7wUMkUFJZMWveGsTmRIzypDGnMDYXSTULLRCcLzwXsvTa4dP29EDjgnje8IHg3Ii1vP9HARlghc5wybVSdYZmweR9qsIhgozSeerBllBAhhzT07k7ujKfK2GiGaQXbhYxy45DdEV1quNjI9eJYMwMB7z8iLCKiQ34k8InSvGXemME8oNdYDqbJMsT8TvjJv9jmO/LmxvWIoZof9vaKJsHEBEPtdPFRNdikffdZHUUwlrHYwSA70YJ9fcYuRuCyakNdDMDFh4g7KgKpXBu3x3I88HL2dU4Dy4zgpjiD+flEIHjO7STakzPIh5yg6gtfaSY5ij20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QJYR8C6Oei1oSISVfXvwbAAhAE+CkJSWTpENeGDljY=;
 b=Bpf4l4OvTDyp7bMZ5wvyNAA2a5Hsew/u6Dxf/s/rIKhX/gegHKNxSP6XourpnHW9bIQ7Xw5uo53boySCzPG4o1+DWNi6xhSClBmoAJTzJ5e24MPqkFJbghKKVSGREU4qwIH4veRi9f7ugoLhJ3WM66mrebmX2iAtSQdPUg5Uf3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 08/14] maple_tree: Re-introduce entry to mas_preallocate() arguments
Date:   Wed, 31 May 2023 22:15:59 -0400
Message-Id: <20230601021605.2823123-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: cec4d59d-3a1e-42a1-6281-08db62463a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jH4N7B/4/TXtr9dgBpqMVWakv2D2YV2WxVm6x2wbQ7EC/LMquwIzoJK3O5V0xGr+rHBgWK2iYi64FHGJ4Dn12lBg6xIp8EEqk6d+8LDiWy8xTWyeHJph5gonUe7HcfeAUf+WD4GFi4FXFG0znk7R1TJ+y3wrfp9kSxgCevyshk4HNusEWkoj9x9VYPIkZNEEDUV3bbAJ5Cq8+d0hwmXK432NUgsFgB6dmOretUwV6yss1xgFAYA6AOwB/GBbY9iHxT/3kXWDbJo/iIuYc5ktIns3irXPupvbWAg8vPdzlUE91t3v9ddIzdxQ/kLrWIVVfeLxXRJZkjZIqKHuTqPOcIHXKrTkMpKzelxp8f53/vfsw+AoPH4I7lqAc1XuJivOCAtjelwrAGnbQgQzbIvwAvXYxTFMh1cQ6tE1zwUXw0ZTsFvt4MmIiXrZR1yDo1Rq7nMmuknHODgGXCM8agefu89aUgAkHHwRR0jGK2cDX6jZUvkkW0I5C2Ho4B4G+AQXi68DjiZKZIOSbFA9P2zR3n53WFO8HdaAdfMdGRQylaBA7UPLmF2/RG6LW/ClzOxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkSzHga2t4SJ4OpmT4ZJ56jUij1OUXHlAR4Wmo6sooAqQq1Mgv9lnFk+Gg4Q?=
 =?us-ascii?Q?EABD8zdvCsZNEXZwBa2TvE3h50dQGLYscAB6wEHij7hL84lxHQIJZzlbcU+4?=
 =?us-ascii?Q?gt9ktIP3sAv9EKwg7SiEdEHmhxXMuKlZk19clnS1i3DlN1aanGhxR3q1eSBV?=
 =?us-ascii?Q?JkjJFitFaekYt+O4KDnJlSBPUqyGL2V4a0Lg89zcBI6YGdzu8dKtvbk8HIzK?=
 =?us-ascii?Q?LK5nqYsCpOgbUDJMtad1o0ch76XlarknGmdNa3DzHyxl39g7hx7ufH9238+H?=
 =?us-ascii?Q?HKMXaAFkH8kg+FBVtKh+zg0SCbVFjyvO/eoirF33T9rVyiN5sin5BzHl9J9B?=
 =?us-ascii?Q?obMhkQuhabKw9/MWTj0YORLh1qEM0tSw5f/kITZ7fPgrw8UH7nT4vX9Utvq7?=
 =?us-ascii?Q?gb3M5JJ2jYTnUZ4kw3luVE3NS0IYLV5+JcK6u3SmFCUnmjbDNxIeqeFC2/cv?=
 =?us-ascii?Q?Q5O/Jy1UNrHxlAu0YPe2xPhr22ZekySi9Ew6Q2iX2SHP9jS2WaQ440fTD85z?=
 =?us-ascii?Q?y6LFlPUKXB8GvYn0XHT7rE8p9YNPG2pA5z9eGrZNvnLs62eu/0Wksyjci7RE?=
 =?us-ascii?Q?opFGAa7RSnmcgA8XcnxbWjAmepTMfnUJE783Pw4hkZ9LvduQPrQLm9Eq0AIs?=
 =?us-ascii?Q?3tXJikqFmRJUXH/AzJLbGDn4K9+Vr1me8ku+5HR7p8YFL4O5ax+HJ+Mo5d6c?=
 =?us-ascii?Q?Az++pVnmln2lA5yWsJwn/vLjUulzJcpYA2OQ64bBSt3AfYW3XuEY+uF1t7UO?=
 =?us-ascii?Q?lb8NmwHepyvGM9o3utlEujquwYJNMq5/eQV0VUHt+rPzyQMs87CThRxqcURF?=
 =?us-ascii?Q?JMMPecBi9fKxw+6P1x/q0230LzcxlYL9ZuSFXa7tbLB7UvIlrHRSUB2W15lw?=
 =?us-ascii?Q?qoqWRy0YsHvktElk5cvf8kvJr+kPPz57UJ4jfHLA+JDw6EeWOax0+pCM9J9g?=
 =?us-ascii?Q?L2U8TWTcz2IipdHbKElnsxZIl99PUJ/1GnXwty9WUuhCRKk4+HS4Kj4k8zIz?=
 =?us-ascii?Q?NlVYG2mA6LgIJZQ4t2rjgJLoHx8/OWxMVPZriZvHJsHHwT39uURcnlwWbShq?=
 =?us-ascii?Q?5M8J1BLlyr2V94FZPOfjEct/tUqaiyksmvXq+djKwqY/8WJGgKWxO99R63Sx?=
 =?us-ascii?Q?Pi9LcMhzR4A0pjJ8HC6ag2SvrZrSbX9nv0LZ+TLs4iFwvinlh34qnoJUhe1Y?=
 =?us-ascii?Q?KQVKvT1kWt/PqaRFZXrYghejqVRAU/88D5zzvxNGcMAzrsO5IQb3H+IsetBB?=
 =?us-ascii?Q?QpqqaX+GgNtxvWyeUjH6Of5rhXZdU91W0H7k5sE7LKOtS8P9v7wfTzAC209E?=
 =?us-ascii?Q?SxdzzMe6BiNEYVNFn8Lhsa8zN6FNVf72pRoWKSdbT9vQrcPJk5FbBc8yMV+q?=
 =?us-ascii?Q?GQysRm5gqu7Qwppe8a28rR08I1OYwB0E1KBBCYAGGKcDYhkdmL6J4FqdNkts?=
 =?us-ascii?Q?AmC8gZsjmj2fkMpSoAhxvm7hwrTxGnQIpGZT1MnYmoiftt1iPSNAz2/Cn4gn?=
 =?us-ascii?Q?QhyWHdz8GCJvsZJz2v2yTtwhwStTsJDbF6jXsrhlj5c6NlhPSc/owGNHp+mX?=
 =?us-ascii?Q?NsOe09N/zTfSPr/uYoAP6DxxeC4y6ltZgb2h5A0tdsnPq4xKO/of/oS5ZKZM?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yv7rRJvAVR5VBEwp7FG4jeoHKKkSbI/MuAkBEh4TUvk4tjN8cCPUqmvnc5/8yqUWPfIjZcBQkuyw0YdAeSRjVFf1lAFt4uELBCCfBDPuOiEVxDiUevJb2OUGhGeKKz5WJ1HS2jKdkPSb7eAADhpNu9JV4vPCfRjqArlN2kDeuNrNlK0j3zTuHsrrqULklgP33EUMyygoLAm2BgyQ2u1dIxEjx97Cm34wCxrBi4WsUXBHsESY2hoNitvvc3/qhEY/BCd+c4pi0sIQ+PXB+iuBCjkHilITs1PIkZftJNR9cSw6WOjgsgQ1XyX8xxmmzrVXh8vw6Ft++KBttkW4/QF4G7NuEqHtcU6IC4CjqOwuegW4pzdMZYEwQNFynbKDIKVyI3aX2lQoUcDIiFcfRogKs00DQbHlCLtWFn6fANb1K22uoMlsPgZiYpVc16CwjAAlDkJA50MQTlJ+owiYG69sjEifdjCON5BSRMTWyaVLHhPz2wbikCmjn+Mb/vrYgVY0WJ/unERQJ4SRMwxKihJ4FRyQM+rM1cK5AVkspSH2ngSPxkwPlZ4XP3uUJCIz+SODVz9JfxGA7icMEkSvWV24tzxGGn0MH6ZPSF18NFlE9kV7tQWlXIyQFdLah85swV5lGFYc9meMtYSX9t3B5nqXNsALUMNFSRyNbPUpJ6xv2MrH7DHoQ1dhfui5ZFMLHaji5hv+F0ZmE0og0H0BvfgnWFPSI8mYMvDv/G7ueJispE7edyLlH9vPquEN4O9+UMekVi7BUkwLUIymzSptqOUIUE7bkIel/hnB1J9K9URGP2gPzkyCERfXRph8DcjDKJYx5LtHnAw7lTI3Th9AVhJ476w0pkrFEjiMAPEbmrqRXPcA+lGg33yi407Wm+MQDaBuOHPCM8uW+4N5JcxpBcVWww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec4d59d-3a1e-42a1-6281-08db62463a0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:36.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y63BrENuFU4Mvevt5h77JMyodALECCUgqZdEMgaeHTGeWy4p6VzBmwHZWP2GzDKNcXqiu3Uby3OiPBu03+ohqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-ORIG-GUID: DIFzhmCDkco2r01SE62ZRXspyZbAP9cn
X-Proofpoint-GUID: DIFzhmCDkco2r01SE62ZRXspyZbAP9cn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current preallocation strategy is to preallocate the absolute
worst-case allocation for a tree modification.  The entry (or NULL) is
needed to know how many nodes are needed to write to the tree.  Start by
adding the argument to the mas_preallocate() definition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  2 +-
 lib/maple_tree.c                 |  3 ++-
 mm/internal.h                    |  2 +-
 mm/mmap.c                        |  4 ++--
 tools/testing/radix-tree/maple.c | 32 ++++++++++++++++----------------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed50d8f459e6..e18ecbefc7f7 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -458,7 +458,7 @@ void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
-int mas_preallocate(struct ma_state *mas, gfp_t gfp);
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bfffbb7cab26..34eccddb0b47 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5535,11 +5535,12 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 /**
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
+ * @entry: The entry that will be stored
  * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -ENOMEM if memory could not be allocated.
  */
-int mas_preallocate(struct ma_state *mas, gfp_t gfp)
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	int ret;
 
diff --git a/mm/internal.h b/mm/internal.h
index cdf06f680d6e..2691deca9699 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,7 +1047,7 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
  */
 static inline int vma_iter_prealloc(struct vma_iterator *vmi)
 {
-	return mas_preallocate(&vmi->mas, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
 }
 
 static inline void vma_iter_clear(struct vma_iterator *vmi,
diff --git a/mm/mmap.c b/mm/mmap.c
index 8b3e58d6ac40..75b2a86e1faa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1982,7 +1982,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2064,7 +2064,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 03539d86cdf0..cfadc4b75d51 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35383,7 +35383,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35392,18 +35392,18 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35412,26 +35412,26 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35440,12 +35440,12 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35453,21 +35453,21 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35475,14 +35475,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mas_destroy(&mas);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35490,7 +35490,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
-- 
2.39.2

