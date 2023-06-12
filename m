Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4072D0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbjFLUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjFLUkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9210FF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO1a9029054;
        Mon, 12 Jun 2023 20:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=e9UPiz3pEKMXIuIsvPDaS8Nyli4ACB+wguzwvJ/2XbE=;
 b=Xj1n/67ee7v/XwH3hZ90ZbVK3FhQrpbHgAI3vRIWK5jvLyej4vnvR50UvL4sspbYxC00
 TX+crmVXqL9cWXrXGSJd2otYNJ/z2YvQlMLx4Nw2mnb3sr6yfpil6AjYth00iVwyMmNu
 zMGCwNcjD1rf5+b/0GFr2EOZqH6W4AxvbaZPWKrxXW3uBEg6Ik/ZERwEGIofNZbl8mPE
 RLm0wYV0IqAAzHjIlCMx00ea6TgcfHDvBt/1yCUvQrLZdWhHf2v/ltucDn9+OYoqvtyi
 z842Xrleu3mF7ZKA2mmD19q54M+wmJ6UJF9RglaecMzHJSckcf3NAi3HERxGQQL1YHFu 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bkxa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CIeJDX016265;
        Mon, 12 Jun 2023 20:40:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm399pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjO6ZrgvBQd31QQ8whjqEGk73v0juDHubKVN/1pSZJOu01gryb1nmQeI/K6d64HoCrSgHWZGd6/wpf5BWmOzLLuaw4YNh4AydQITZ50Endz1sCAvGhlB6/EEToWbhoO1S1Y+PgAoiTTb3AspTA9HL1pnXaTtRKy81JRqAA4b40/kMEQkavro+IGi5wm136u4UWHTRGp+uq4FEosJrDTG6Gt5RGfln6hYq9C4yX83bPePIbwGXWoDiWBwcMbAiDtcf9eIoS+5wzFhMow188QL3/rBfijJkHwhIa731PLE9K3euT53ROZaYpvqUQUftttD+KU0b0gC08+0ambEZ1VL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9UPiz3pEKMXIuIsvPDaS8Nyli4ACB+wguzwvJ/2XbE=;
 b=iuDuf8r0Oj9Oq+zjwiigF/lPE56zD8tRlPouVqeuU+EnLQCgDD3wLqFTtwMRBCTPvlydpgWdddOXsq/ubTPvW9lB4vKFFKNEL9g5WTRLhe6pZDQX6RwB2qZi/G9pBstFN01e9MNrYhowzE5hxPcddEfXSWg40lcMiW71SoW3ixFGiU0nXoVwKRtBNNH+gb62ijSL8EO7jVOb6RCpUESi/5e+IGSHi7k1ZHYhulQouFL/7l8wddFIJA4quML4KBJxMynAtPJzG/8UjM6Xqt0PuDSyZnnS6j9dCeRH9t0gNljvTdwt5jMVOdSmhNzvF/HTN+7lrg9FABOgitlFPqUEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9UPiz3pEKMXIuIsvPDaS8Nyli4ACB+wguzwvJ/2XbE=;
 b=WBG1jNZErpRfwcQoqGPTW0GX8i1VtcOlP2tn9yoOhUlouiJjk4L+1UwI6b5nF4lxpRqVND3fXr4CiuHu9I8znbxYegRu1DqHYuURB2w8yvzChDYmcJWacJGqsGzaD8x43lzNKDf0vMUjE/znnfFwdnVgqELXx0/Nx2TZWgrQZsc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:09 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 04/16] mm: Change do_vmi_align_munmap() side tree index
Date:   Mon, 12 Jun 2023 16:39:41 -0400
Message-Id: <20230612203953.2093911-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4baec0-ae91-4fd9-1aa9-08db6b853683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQH3Ehb7vtadDOYcyTMovH/MdiRMdwbmdtCOnVaTUCmCuesx/8pcOBjkQFD45500e4ME4EeJvyjw3pfyT5LdCmYyTwZ5uI5tGMtRnLSJ+zg4xzPOLz/AaD1cFgLnmLewJHkKnFqIwoOkqynH1zEYAaI9x7jTb7Mfaf1zhunngGWh4ohZ89MT2elu/025j0LpIxGC/LjTO4KCmRBW6RUsJyA4eRdEwrv5NUXZrK1EqqJRpU5K/oyB+hsoyd/LWhlmr3nNmc7rZ+mDvQWsBYp4aCxppHyX5+S2hMdQia68aJUp4zrv8C8AiuGOt1aPaCh8i2GdWeYluf4jo9V3l9oeVDjjp5+ljGmrxMqN6tNB7BZy9jv5Oexyvpq/LtGEAewMC4NaGHd7U411Rh4R5S0P2M6XmZXFeoARD+c8A7jUkdzTn7GJ8PFMYuYVfNGJQ583fNMdl34OyNsHSCur5Q+Zo0t736NuQXxhXafJMZXB2UnOUDZA+fSAi+Ji93CjqoYVBCdYRNuIrvEkDBe0mJxlWS5bh6Tz7gCebp4ubJuxUxx6kQcCBnY1jXjx+Zfadlp4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?va1RbSbVHQ8QF3qKI2l1vhk6m92oClM3YapOLBycpvDAxJNGc4zRTZJJbEv4?=
 =?us-ascii?Q?75Jcy+8L6GB6KlP8uVz2uJ/dDZ55AajHc3Qo9u40LBvqWVBfk0z/c5BT9XJ3?=
 =?us-ascii?Q?4IhpiIqKHO6QXwmEMk2i390WY4tc9Tw6ZOybR5drQJO/8Yauek4XQdYskje7?=
 =?us-ascii?Q?xLWI9VzYRWiSz2jy2KwYp8uu4+HTuopT9MHMMBlxjzzHfu4yK6Zv6H2aTbGK?=
 =?us-ascii?Q?+Ss/FnQtKhkjSa76hhvW8X1q5zU+3Wlcpk/UcFnIUyIgpiAsx0474rLu/w7b?=
 =?us-ascii?Q?77kx2JKpnrsGEvZuWdgbRx3kjpK1Ne8BHv0t7sQuAnIoETF02BTb0UmPkl2Z?=
 =?us-ascii?Q?uTWP7R44kz/faBNrdPJ0KWVNYlC7auufoCp39v2SyV/r6C8wApYbH6p9JuXH?=
 =?us-ascii?Q?EnPl+b50Rq5L67fyfgTfCPZuiVFnkGV1ldM3TzAxwRAmwCLlRvMUV/Ov1WOm?=
 =?us-ascii?Q?5W4snVWpFjsCq2FMIFpbfOfQVsBYppW5W7q5BawcaNOsk3+/15CYWFA6V7pX?=
 =?us-ascii?Q?J4dZgJsa+HQS1NaFYn5B36fM9++vEJGVhJs+2k6KRLJbDKKCAzOq8iiUfGka?=
 =?us-ascii?Q?zyV7LQ7ZuE9NjO7+UW/O0bgU3yvVVVQHUjDPVGNGuNTnrAAfcCt5jwpNMWR+?=
 =?us-ascii?Q?ZHGLfpZHy32FUzS6Xvlc/2z3JbXs+OYghRtabK8yHGoFYIwRrr2KPftE47ij?=
 =?us-ascii?Q?yEu+AIP3anK9TrW3y2esxPOvktAy3iW5qFvnXWB41PcA2n+Ck9IcxCuFQc7z?=
 =?us-ascii?Q?7Ih2xHZkxsKoFP7jRTmHt0nvO1d/EpEGT3QSHH3D1eQHai6cW+u3Dqnowp14?=
 =?us-ascii?Q?Nu/DYlvOWUIdBpm9ir7H5q+sey5OPLqr3FPIzsSqlnYaW8+NIV1RErG5tRIu?=
 =?us-ascii?Q?30GzEGAP5s3DprsYkyDsTt37+97Uiu2LqhsuRwKU//STM4qBkujIOr9BTdH8?=
 =?us-ascii?Q?GGejira9jRVCOP6uPPP8R5mx2TXyMjjiU9eb6qWTdH+iS9Y+DhfKBMcqjRSS?=
 =?us-ascii?Q?LPqjManxgywc4RV1PCeEuTs6AMOTG5OnK9Vw4SfjMbzmognibyo4r6o9YSYi?=
 =?us-ascii?Q?Q2+jKG1XtrlTLNdP+dvxPEdqpzFZnLxWayTcmdUzQR+G1ZWMpve3ovyjbN6l?=
 =?us-ascii?Q?nMjjbs4PIgKaLkM7sW9aUkRtt3rjffEzTpe8WxtIKXE1jQcLZfAab/fR5AIu?=
 =?us-ascii?Q?G+M/ucd0KHZdkeTHPnU0SetpIxatxtkZiww0xbCnndP6LZXfZfofCp29QtHQ?=
 =?us-ascii?Q?IAW1vOukKySHTm5/4fgjwJ3YT7OZbd7FopocIPpOunZOrnDbvXIPLlm0DVAp?=
 =?us-ascii?Q?xYxInXft7tnSMFzFQt4LetVuE3M5z/puSQdc3pq5ruXe43fLe054lHVB2JEz?=
 =?us-ascii?Q?f9MOnGbpTe8psK3ZrSXzhgHI6jm/MkXGuWJcmKgLyz9C1rO6Mp3Q4YiN8/hF?=
 =?us-ascii?Q?7oIpnGqvvROVKboMp65GYHiOEeZ+JAweqyZFI58SsoD0uCIqOQpgqVvxvV0E?=
 =?us-ascii?Q?Z4UMTc1mJ9qWXBd4lK8tpQHfX4UdUGbvLnq0WiLqecaZh/2mCu1ovuL3M/1H?=
 =?us-ascii?Q?e2o1ceQIY6h8SjCV2ilD8Wah6v+N4Knx73hY97RGvpANnHzF9Tm4umgILyHm?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K05mouawFNO4tQCn/8IPwE120feBDWozmQ4nWa7MqRzZf+yHsOlZjH6iEciW?=
 =?us-ascii?Q?dlXnrlZRgxsjxBrW15gxJ5Ra6VjUbrjtf53OrgxlmAhKUbSdcy/mQdQAAKoO?=
 =?us-ascii?Q?SN+1ixAHrMxbNLmJvAvHzEjUkwmx66+xlAcwzJiT/iSG+9Nj48emQGcN2yRX?=
 =?us-ascii?Q?ZDFE3r5C1Y059etM9PZ+Q9dg517nEcRo3QwXJ6/HBdCgRjQ0picbc63XvVrf?=
 =?us-ascii?Q?EAICGDVSgjai2d09UDoHvWm3T9hILtLAYvGT55V1E1nx324IDfRcVYmrgcTH?=
 =?us-ascii?Q?OqA4etdcGRaXyOzye2EOCvgaS8w4Sit8EcPjwpI/zs72hBe2b5Jrvfa42NC9?=
 =?us-ascii?Q?Ew6WZuUqFydtNVYgJ/uXEv0Pk2nIK9/4x9l5PU/O7PUSRC/yYi/ng8o3bmPz?=
 =?us-ascii?Q?T1uwaLC2NyijQYzIJuFKHgmRpZmedZr2RbeGNv2WwKx/7nDZOxMEUepo4csu?=
 =?us-ascii?Q?0HgdIlTP73MJd7ONeqXskKFA2J7sl2CQgzHo+54sVz/ptQ4gLv8EBreK1jkX?=
 =?us-ascii?Q?vmaiJKdNOEzWp9B+buzwQks+037jaKLHljXWmhVR5hULHUwvGhI/qU2P9QEg?=
 =?us-ascii?Q?Kkeu/ueXih6sxfERXfRadNntr2UVGj0tOxDDlN0KIBrXId64Vi9RXYsIg1eu?=
 =?us-ascii?Q?buGKYBmMCAFCUDo1SHuoNd1yVorcDVgyNZDsCi0jHw+XhJuahcLcRASoDC3L?=
 =?us-ascii?Q?uEKboOViRH/rBIZ1lRKgxrGyjP+gw6kNBvt1g9b62UejJy6tcSYmb9lmOleg?=
 =?us-ascii?Q?BRaBfDJ4YQRAl2QnrmD8hzEG4MRxJomCM1jeQfvhn8ZjMdou0ltrSwnhNAFj?=
 =?us-ascii?Q?IN/+5WqTf/NSxeTwCzjGChL2vI7gVmJ6xQAf203VgvnuTfGSM/uLPTWZugl9?=
 =?us-ascii?Q?rx0VO5W8WH+KcQpBNwBGSwWtnC1ap7btBnHD8gP6zOsqNPEJM3Bbt4RNHCrS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4baec0-ae91-4fd9-1aa9-08db6b853683
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:09.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcTFGSo8PWSCsG7wKfY5NYm7MrRQxlcy6+8aM+rnzRIsQXajvhuDNmhvf5TicqOOF5mGQkPMyPwoQIYjJT0/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: oUOySkaVcwxAB0PYIPSN6hjvFas6u9US
X-Proofpoint-GUID: oUOySkaVcwxAB0PYIPSN6hjvFas6u9US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the calls to munmap a VMA is for a single vma.  The
maple tree is able to store a single entry at 0, with a size of 1 as a
pointer and avoid any allocations.  Change do_vmi_align_munmap() to
store the VMAs being munmap()'ed into a tree indexed by the count.  This
will leverage the ability to store the first entry without a node
allocation.

Storing the entries into a tree by the count and not the vma start and
end means changing the functions which iterate over the entries.  Update
unmap_vmas() and free_pgtables() to take a maple state and a tree end
address to support this functionality.

Passing through the same maple state to unmap_vmas() and free_pgtables()
means the state needs to be reset between calls.  This happens in the
static unmap_region() and exit_mmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  8 ++++----
 mm/memory.c   | 19 +++++++++----------
 mm/mmap.c     | 41 ++++++++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9b665c4e5fc0..24437f11d3c2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -103,7 +103,7 @@ bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
@@ -1099,9 +1099,9 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
-		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, bool mm_wr_locked);
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 /*
  * VMA lock generalization
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..fa343b8dad4b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -360,12 +360,10 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr = next, addr != end);
 }
 
-void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
 {
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
-
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
@@ -374,7 +372,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
 		 * be 0.  This will underflow and is okay.
 		 */
-		next = mas_find(&mas, ceiling - 1);
+		next = mas_find(mas, ceiling - 1);
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -395,7 +393,7 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
-				next = mas_find(&mas, ceiling - 1);
+				next = mas_find(mas, ceiling - 1);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
@@ -1684,10 +1682,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlb: address of the caller's struct mmu_gather
- * @mt: the maple tree
+ * @mas: The maple state
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
+ * @tree_end: The end address to search in the maple tree
  *
  * Unmap all pages in the vma list.
  *
@@ -1700,9 +1699,10 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, bool mm_wr_locked)
+		unsigned long end_addr, unsigned long tree_end,
+		bool mm_wr_locked)
 {
 	struct mmu_notifier_range range;
 	struct zap_details details = {
@@ -1710,7 +1710,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		/* Careful - we need to zap private pages too! */
 		.even_cows = true,
 	};
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
 				start_addr, end_addr);
@@ -1718,7 +1717,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
 				 mm_wr_locked);
-	} while ((vma = mas_find(&mas, end_addr - 1)) != NULL);
+	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1503a7bdb192..8e5563668b18 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,10 +76,10 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
@@ -2221,18 +2221,20 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
+static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next,
-		unsigned long start, unsigned long end, bool mm_wr_locked)
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
+	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mt, vma, start, end, mm_wr_locked);
-	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
+	mas_set(mas, mt_start);
+	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
 				 mm_wr_locked);
 	tlb_finish_mmu(&tlb);
@@ -2338,7 +2340,6 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
 	vma_start_write(vma);
-	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
 	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2415,6 +2416,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 		}
+		mas_set(&mas_detach, count);
 		error = munmap_sidetree(next, &mas_detach);
 		if (error)
 			goto munmap_sidetree_failed;
@@ -2450,17 +2452,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, start, end - 1);
+		MA_STATE(test, &mt_detach, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
 		vma_iter_set(vmi, start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, end - 1);
+		vma_test = mas_find(&test, count - 1);
 		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, end - 1);
+			vma_test = mas_next(&test, count - 1);
 		}
 		rcu_read_unlock();
 		BUG_ON(count != test_count);
@@ -2490,9 +2492,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
-	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !downgrade);
+	mas_set(&mas_detach, 1);
+	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
+		     !downgrade);
 	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, start);
+	mas_set(&mas_detach, 0);
 	remove_mt(mm, &mas_detach);
 	__mt_destroy(&mt_detach);
 
@@ -2800,9 +2804,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		fput(vma->vm_file);
 		vma->vm_file = NULL;
 
+		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
-			     vma->vm_end, true);
+		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+			     vma->vm_end, vma->vm_end, true);
 	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
@@ -3131,7 +3136,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX, false);
+	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
 	mmap_read_unlock(mm);
 
 	/*
@@ -3141,7 +3146,8 @@ void exit_mmap(struct mm_struct *mm)
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
-	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
+	mas_set(&mas, vma->vm_end);
+	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
 		      USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
@@ -3150,6 +3156,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
+	mas_set(&mas, vma->vm_end);
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-- 
2.39.2

