Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C97700EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjELSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbjELSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FB30F4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4aDW021732;
        Fri, 12 May 2023 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=tHdypdjfxtTCb7ZQrq7ZCqT3syUAiOyyJqckKW96gb3UGOg6POudK6FoIyncam9J07RG
 C5DP2brJ/f7TLPEJ1hR9pBOsuABhYNElVPP7Iz322mV73vrqRohpJzVKhiTqouTagKTS
 mLPgM387MLco1ZvA3wKR0jrHYxoS/m6/XLb83NSM3WMRG1hmC8XtPdaBaJEHvjAymBSc
 s3ZGmcm0y/+Rqupb3qUninVi/tW1FrjeOCP8yZo4zS6SLfsS+n+OYp3dbLAf9eQSAo/8
 CZcTJmy/Knma3dLol5Y1u6UGAFg27cfo3pGwjxGROhqRh1K+PiIGS5fdyeU1pZUYvUo0 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793gxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHZraK011640;
        Fri, 12 May 2023 18:20:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156y66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJZfUKZXlolKtu0zd4uz4NhTXVvYXYOLzMIz8rhzFe1BUib1lXB5u2dJ/UOz//6II7cQJehntYdnbeFPDy2OniOP2SKsjfV7JzFcO338/EgnaIZC74hU7v+/3N9s5N9hka07RtYJnjxfz/5Kdt7h1ek8ty3DsrcZ4nvVuUkOl1cax7889YI2oK3yNrsxS8JdLHQShYD295qJBODHfsI33gcZWEf5zf3tzVlKglBG5LR7m99jikB4rfq5xVO4RBFn3iI9g03Njm2K5IcsxK81zv54gCxScsFnwdTp8nJ8zQNWyMhk4C0zNh5PmL5JjY+yYQbhxUpi/m9sNNODX370eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=J57IqNZZDD2x+xbwYkLG2HxJdtvz3pjaVi1xU9VTJohwh4OouuUtD6S/+SqVaJe4Hu1X5xvsp50gTX6Um4Uh0KRMAmM5nVdkAYhwoY8yA4Ghm/nVzTxorrl4jH28NyFJKwoIzmSZiZrt35VEGNlZeEOkm0SxmScMDGrkBiKOvCW+pdsT+MTF29RW6ngZceHjAtuPbvEjSqsPpqMQFS0jgVvwVC58JiHhBfqavj4Bm11wem0SGWzZDpd6zlR0St7z73Wo9oVDbQLiMgk+rLHxIzGr7iyKgC35SpGKZBRvavWvyHsPGynl/ilTAiMkZ1OwFNvqrmeJL8P56hVeaLnYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrIdgrVzXbrkBEQdhLJQ1jIQQYwRAY8yiv0L2JjFINs=;
 b=UDPo/VWpzA1zBTwXkkp9FgiotaebkGs8NmdH/c+VV8wZMFZbfxlqZzbZxMZrazyDtO4SimmJdyILHZJFMxqDkgjfq7+xArA/kHQeyb5lhWhuEsep9YJ1T/G65c9py3oEmp+7Z5W5vsUOm5tg7bVVOTAGQaUyIoPUnZ7goMBLCvk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:20:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:20:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 03/35] maple_tree: Avoid unnecessary ascending
Date:   Fri, 12 May 2023 14:20:04 -0400
Message-Id: <20230512182036.359030-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0065.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: ae32d136-aa02-440a-b54a-08db5315a193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuQBqx3Dz0qwxAX+reHa8d4a8fsYEHxqBY+ncfAWm+Od0HiJioZl1W6uCJKyu8ek5LG5Jvh6pKXvNvDLZfpmxYyv8fq/cRkZTuJZZmfKhq4VIqVdXz04FTJWa82iJcGEGxRfSrDDURNsPRbUuxTbQx0a/kz16i81vpKYV5IN3IBOw+xNxtJP7vB4SCMtj14gkQXuOEwmKN7yh54zyLEiRGb2ZRRaPrECUfh4AWCTZuaPxIHJmX5PVLEEl9eKOPVxGL0UI9NaXR/+IXpio4lMhI1roVqd+CXTRdWzyOWkc/1LeFaioWRK5w6p88CssWXC5/BHbkPKQs3VSgGE2S5dhmN3XxOPP+rnwRdjMFSN2DDUwTkVHn8oMCxfJxU1UuZkz/8jAmnqFT+2+xoGKdIa3dKpu9pYmOMIy6qBR+AYuwL0bhirCs3oXDcxHAlXaeGfCTjOV42Z+azj3VF7btsD0mPOzYiK5KjDNzMGrIj7Z+S8WfWvpHtXa0iSgJS277HmWXJC2juxEJpTc4x2vGAD0G/AuIJDJYOFD6Fuvn/DblQvsv+wtleIGyledigix5hN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(54906003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZBlhnd8arDdovFB+d9K0n2y0hSt3PXVsr9rQLemogc9HAWiMCTtlz2IPHr4?=
 =?us-ascii?Q?neLQ9aZ6FHcUBW4AdqDmCf0WHAsud3Sg9vqlBbiRruZq9ascvSjyap214ULV?=
 =?us-ascii?Q?MIUp10Fc265VWV08lsZhmdixxWl6Uq8yXQ4PnDMQD8O6hhnIOgoRQmdo9exj?=
 =?us-ascii?Q?ffLzXfAKqR9sKYGkW1I1BM9Sr4j/XbmUCvX5JXxC+gJMedfAJYYBCYd2w/qS?=
 =?us-ascii?Q?FTreBAS1xf9Tt0vSKLURsoZ17EpdUJdJGFyRGnJYOAtODM5T+iTsOtGrUtm0?=
 =?us-ascii?Q?Hb/KE6gfW7e/kCGfC16H6UkxeJ9RsfjHKHFgEtrcqCTfTlXa8O7lwDPpFR4M?=
 =?us-ascii?Q?6Q1ImibYFxj1njpr0Gzl2vW6jsyCNGpDsM4EwmaUgw+2WR6LWEwsk3enJhb7?=
 =?us-ascii?Q?zSUgiif7cZhuexaPZlYs+d26bOv2dvlF0+GREBb0Ydha+oCR7KI2pkW2LatH?=
 =?us-ascii?Q?fHlsLu4GSH6vbNCdI+8P0l7nQ/4xyLRED1DpANLaMDOS64DwJaCT1N12VYBW?=
 =?us-ascii?Q?BLbS1Siompy4TKvmMYvyNUgMYeWbM09gvpN80ze56zzZIak/e4BwwPAvscLr?=
 =?us-ascii?Q?JiWApCQThfw0bQHh4a7tFAMvro0anMgM62wY+9lW1rVlWJdqgFBz+UjaFx+e?=
 =?us-ascii?Q?qsN2DPfJh6mdc7wu03sCumPUGgXiLrhvI569unDzs93RONjV+XZWlLVWV7G1?=
 =?us-ascii?Q?qcDTq+nRcy+jJz9m9ojj+E1vvtdq+LpAYHVPMMUgcRsOKHo1ly5Nu5qMBi9w?=
 =?us-ascii?Q?GVeBwP+V5OCqRX6/cULV4KROKePrEnUu0+R39VUxWfOnbEUdBTo31FlyjGl+?=
 =?us-ascii?Q?kY+udr3Wz0T5N8DMMLLP3TSB6c8pFBi/3pbBb2JylwbRNAxzeHVhVvQ0d+e1?=
 =?us-ascii?Q?6aX+nkLfKSNPzYrq4Hkusepdf1JkMqY75U0RAqtGWQeVlZaHAyUIO4TQYdhV?=
 =?us-ascii?Q?gAFxbwkdgNUm1ctd+ZxQCJ6E8SBGkWead6DqAUi8X5ROD+HsPVadvOyB2Hb2?=
 =?us-ascii?Q?har9BHYfCT6/Z5AcLjRyBzK4C2BI6KzphehLR67JNigivn9zY04r6MQJHzJ5?=
 =?us-ascii?Q?OvPCZnsWM6m4ruID4IbWy9+v/LeiUkbgvJVbVN/TQiUX1RGe7TwXk2j9N4If?=
 =?us-ascii?Q?otCL8hjqsMlzAd4fzgfVs0kpnlvDJHk+3fJAOPC3esI/rHwE9pJWj/HI0kCe?=
 =?us-ascii?Q?hzfSs8toccx3q2pSVcNWdI2R53d7R0w5oZLYXhWHVDU7kNULg4hWckPQvCT3?=
 =?us-ascii?Q?XOgbiMbd4+dJLfAExD7UilBNTbNd3WZUUP+k1U75cQaF03dlcPeNhVnvAya8?=
 =?us-ascii?Q?yVa0xTiz1RewwCjky5aQ2ciKqqTWuUDhc1PGznuU2UG7R1C4V1Z6C4BccC9W?=
 =?us-ascii?Q?4z58ZAyKRvaSH+TN4BjGoVhPS+hw704doygsARZobrhXY7wLfuggEll52l9Q?=
 =?us-ascii?Q?X7zA5mW6/mbky4sqfFmWIld1SCpVgP9EOgCCSqi2sh9ul6p7s4doUpid72Ej?=
 =?us-ascii?Q?I9g/rrIsv9nzwdU1Tvz4cUtnEY1HJavPRGyQ5ad6sgFU+W7Nzslc7Ei+Ghh7?=
 =?us-ascii?Q?HTPm+/CmF3Afal9rK18HJAQUNfZLqzQmy8MoE9XXFB2lzZLlPY6sgzwJUSH4?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GRW9Ah87ZBh+AYbTwUkz79/R3bVwWiyIDreHswVcUlUCpJAf08UC9LL3mToS?=
 =?us-ascii?Q?mKNSZB8vf6Fpitq0Tcv4mAn+Bp3n53vxtmFjdshY5FDwIoGwaxbzsupTxs+Y?=
 =?us-ascii?Q?jsoaj5bMYb48AVsLnv1d0KifWzXTgLyMhEbBIfUOQqQ1ZmVOHtytbhAPyml8?=
 =?us-ascii?Q?vCB9cKVVvcZkFP936tXBYEOWOgokYof5JzddHbV6RNUT0u8nl2eE7zstlnS8?=
 =?us-ascii?Q?rPLM55Uexnw01G/kBFpXWwHoXlc+0uP8Czb5zR3qKQWQSB+P9MCOEyjW/3d6?=
 =?us-ascii?Q?lGO97AvOXlN8jhcpHqIhnIHxTPpHG30CpkAhCdcpILippjYWi7U5rVaac9ed?=
 =?us-ascii?Q?cU1keVuIlZir1jY4s/CNsFRfiWeB8mOfcGTcf2ruJ701LAfOcRKpWsieHoEG?=
 =?us-ascii?Q?x7bvXSqpoyE88BYKKMbxh1YOb+/98+LhSDcxWMLgmexVyAGy9DEKpgKCNVif?=
 =?us-ascii?Q?ikPWf7egsme5Rmu0wvDLd65ADe5VUA8SkWlUmGGspCUFSvPcq5YSlBI7cJOe?=
 =?us-ascii?Q?OF20l3saiYjqbZqPJ/S7rQNASkN9eCbbvVHvlUebvBbVHdziiLlrkv8sF4Rr?=
 =?us-ascii?Q?ZEnbrb0I1TN32OtlmMH1lGo19s08Blc59HmTmh2Wj2PeAQ4O38IcU3q9WEOs?=
 =?us-ascii?Q?2Z0djJX3EVFOI2gnqFrOvYyisjLUBRd1n4RnM2z4dIccmGHORzrsRh0sG/6n?=
 =?us-ascii?Q?hxj/7vKEZ8Ioc0HOMeFTthszPPLuoH8L2g9hzQ10ODt5+xZeC6+L5qHhYF2a?=
 =?us-ascii?Q?wWcg47tYNXFttSFKNG8bbwsF68i4WrCelqtQa/6Hj6fFU8TvpxRLrh+/7lJZ?=
 =?us-ascii?Q?5rW181ueuPtahtWBOZXUc9NGvzy7eYqShjMsZOH7YgKKOrCurBwqLZ9T/w6+?=
 =?us-ascii?Q?E042t1+ivOYMQ7CKgr0x0HY3BhC1uX11x3dEkjvRtfpY/ZtNSJ5nINstEwHL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae32d136-aa02-440a-b54a-08db5315a193
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:20:57.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Icv4zmrDEMOWwPAvndTXDVeACceBINChEQE2/oaSm7gdNWqQUnqy8gk2N+1LIeUgZxJo7jKS4FcQK43UhW+KRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: 3HHVyC-czsEa0bkoVtRRgqWx7I2_SGFv
X-Proofpoint-ORIG-GUID: 3HHVyC-czsEa0bkoVtRRgqWx7I2_SGFv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree node limits are implied by the parent.  When walking up
the tree, the limit may not be known until a slot that does not have
implied limits are encountered.  However, if the node is the left-most
or right-most node, the walking up to find that limit can be skipped.

This commit also fixes the debug/testing code that was not setting the
limit on walking down the tree as that optimization is not compatible
with this change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c                 | 11 ++++++++---
 tools/testing/radix-tree/maple.c |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 555de3a8343e1..5b29d5a916f2c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1103,7 +1103,6 @@ static int mas_ascend(struct ma_state *mas)
 	enum maple_type a_type;
 	unsigned long min, max;
 	unsigned long *pivots;
-	unsigned char offset;
 	bool set_max = false, set_min = false;
 
 	a_node = mas_mn(mas);
@@ -1115,8 +1114,9 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
+
 	a_type = mas_parent_type(mas, mas->node);
-	offset = mte_parent_slot(mas->node);
+	mas->offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
 	/* Check to make sure all parent information is still accurate */
@@ -1124,7 +1124,6 @@ static int mas_ascend(struct ma_state *mas)
 		return 1;
 
 	mas->node = a_enode;
-	mas->offset = offset;
 
 	if (mte_is_root(a_enode)) {
 		mas->max = ULONG_MAX;
@@ -1132,6 +1131,12 @@ static int mas_ascend(struct ma_state *mas)
 		return 0;
 	}
 
+	if (!mas->min)
+		set_min = true;
+
+	if (mas->max == ULONG_MAX)
+		set_max = true;
+
 	min = 0;
 	max = ULONG_MAX;
 	do {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 9286d3baa12d6..75df543e019c9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35259,6 +35259,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	struct maple_enode *prev;
 	unsigned char end, slot = 0;
+	unsigned long *pivots;
 
 	if (mas->node == MAS_START) {
 		mas_start(mas);
@@ -35291,6 +35292,9 @@ static void mas_dfs_preorder(struct ma_state *mas)
 		mas_ascend(mas);
 		goto walk_up;
 	}
+	pivots = ma_pivots(mte_to_node(prev), mte_node_type(prev));
+	mas->max = mas_safe_pivot(mas, pivots, slot, mte_node_type(prev));
+	mas->min = mas_safe_min(mas, pivots, slot);
 
 	return;
 done:
-- 
2.39.2

