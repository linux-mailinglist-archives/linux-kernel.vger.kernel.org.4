Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED7167253E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjARRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjARRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95859565
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:41:42 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IHQQSD023668;
        Wed, 18 Jan 2023 17:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jBwWYq5JoP2WpGpN2uC7NrBWP1TgUG0Eso5jkrBRj54=;
 b=YlZT66HYi0+yMon5DzUjAPzRDBKFvJl3mca61WmNfC+3OYrlVLm6XCrmM3+0YayXqyy0
 JZfTYWbpe2ZD7qAtPltSHGSb4PgMgd7Ce7tvRJxUsntBdnOXZgdnhd5wPrkRtaTy9e+1
 +q5gPzGG+I2s6djJ+Vzr96OqszRSg0gq8NLlO5ZsixQq8DlH2DtKpYt9ph07GtcmctU2
 bBe3uyBsDGMMapHBsHHzFsRLy1GeVWRtoDwOHJvumPpVVsIBqblgdD+JaoY8gEH/AgDV
 ydL3/09NfhEHmfv10LlOSNGqJr2og/1Zrb5O/HcQsGKu0mUkarW6FL3VmTqI5x1Ix6zI 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medg77n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:41:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IHOTqo019525;
        Wed, 18 Jan 2023 17:41:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6n500t58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 17:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/u3EQAQmEFEHTocR+3gdBfPRLznOjG0gOOSFXRL+qUCXjm6mEsOKQ1KFuPnWPRqcP5h4EEdEXa3F0xSb/94Rpjc6lk1WrnIdpMpaG1xvP/xqfGaz5m97jOFU7O8fHPTKQRr+JZC59blWpcOyIi8kIsR2ldkDn422tFu9zVlj1M/Buklx3zeBtyaJtTXMbw9igf5ZkCI0cQxTMDYvFOVIOposWaOMB1MptdAVPXvZ86qS3lG5eeOrweaxXYM09x87GvtPX4vVIkCJSdXcwcawhe+5+cOQGt6q3CopS8mdaWG+LjRvHp+6QyVzuyDhHXlDy1hDnoyGUqR+UBi+K5RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBwWYq5JoP2WpGpN2uC7NrBWP1TgUG0Eso5jkrBRj54=;
 b=FgWsz3ndIcBdP8Z6xJ/Ofujhuh8kTYEQBwuLEy2f42Dz7hubJGwwqmNDkB7xE8Q5VCEZampruaN/c6gGwG48H5SWoW1W+PgBOZkwhQavMBP6PQpHZSMQga8hMZqbtoQtdK9Er5oh66zPictsM4c399fZnX/dnFCB4T6XEZ8mEcSuOKxZ5HiA+U0FzC57rAMD69RBRep9eRnccTZzSB3/cu9AeeeiHXzE62vBG8w5P7X0u4H8u6JsbpJEstrhM6VGVL+HEVR51qGh+mwcwfGVMtWgbhyDmpZMalidBfWLRJoqd8M+1ueYe4BimyeUkVlodtz8/QLdnEsXmrtGzqUx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBwWYq5JoP2WpGpN2uC7NrBWP1TgUG0Eso5jkrBRj54=;
 b=Taavt5Fuo8gkipQxxgY8H8pxtCD4t3/tNiX6cnLFavDR8nQ1DKX93ELa/BqRumh0fX56K14lDN2yaitu/55nre2XNORjUnhSdg/VMJT7PBB9byUAsgHxKF+7lkAyQZy1cteWl8BgjiE33fKZsDqPxPTawXh6bgs0kiKm9bEcfEw=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH0PR10MB7535.namprd10.prod.outlook.com (2603:10b6:610:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 17:40:45 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Wed, 18 Jan 2023
 17:40:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        naoya.horiguchi@nec.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Date:   Wed, 18 Jan 2023 09:40:39 -0800
Message-Id: <20230118174039.14247-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH0PR10MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5407333f-eabb-43f1-6421-08daf97b20ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwPM+Zk0hM9I6/+zyEpnw5rTD37Cx6qlA5vlp1Zc4mi2MoXCVIq/CEPyWLl+NdAyM+C5Tp2t9US4l20e7I3TQogXl4dlkpCDIYJL6eGEf/DyvjIA2EKcCBaR3d2t4mDkKNbDWd1Qx8QlJEAB8SIukOdrTk1xdnxKUlcj9+jXJMA4jI2gggOOxeoLihCkyqWKKSzOcTPeA/BJfVneuG9NQ4JNmyKdWiYi4FKJA1omV8MWg1ooL5ayok2zpl7EFxLMgsZToN5BAkLA0/wDdtKn916rO8KE0LlgyG4UN3iB8USB3XKs8dxAmVC6J/POHuScZvPhY8qmMEjb19JPhV/pStsggpjrgeKz33DrhcYqy4nAY1hcKt5/8RvqXHZR94umUR3tKafMgtuM5apucqCrkh3R3I7zJ+JszoAVNo4PsR6ChAsjyPrtQOj5GrroMIpJreykGpy2dszkb2jcKVZo1wgYWCnI6QUhzwWO/+tU+KhPTyiQOZQ0Ub8ZNyA5cuQG05ZuGETGROFG0BvCTssBLse/Dar0bF78PW0+rr6PQHFEtgt9Jngb0QBHPk7rx6P3QkQMHgLQamB9hXTqMazACgN/KPpVHlKCboWdUhlulLUf7Cx1pT1Z/SRkVoqHEnH8/ioGyyHzXVRe/+3xkLUq6Aww3Cq7Pq1adOhf60gJXXw61cM+D9FEOUY3opwaXJm7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(2906002)(44832011)(6486002)(478600001)(1076003)(86362001)(41300700001)(8936002)(5660300002)(36756003)(66476007)(66556008)(66946007)(8676002)(4326008)(83380400001)(38100700002)(6666004)(107886003)(186003)(6506007)(26005)(6512007)(2616005)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkn3dFlQJOIwNwalbutM5nHYN5hV+1xeNadgjSvxeQsxn8kFFHPqYfq784EN?=
 =?us-ascii?Q?Abae3AysvgL443yJIAKQlKenf1Z1tKEzUmxUFcu8eEW3jWb6s1pDy6so6259?=
 =?us-ascii?Q?6I4l2Rma4xlTEdekEPmUvMxe/iOCMq+Te3Iz67iHvbbuly/JbPdNgA4gP3SX?=
 =?us-ascii?Q?HtXahKrSbA5ttiwfIq7x+JhePRkDy+7hvrhfUE1sEKdRLeRoo8XdwxATyoVa?=
 =?us-ascii?Q?AtmeMcRQCOeNK7CGopO7wLA2SbFF6qGMfcHGPzlWM6aoCzE16E8hExbVxlQg?=
 =?us-ascii?Q?ny0Ka2zyj52i89Y8wyhcQJHxgEmrHqO+wnMz7u3GIJc2FhFFuuOvYCk66i5I?=
 =?us-ascii?Q?VcDbkkRobf2hNpLtCj4shIE4g/IuRx85p3hooXvChaAOHFU9mHv35fZqaa1Y?=
 =?us-ascii?Q?WLPsrZe9je8xVR8XIVlfFsIFwsgt1vgfvHHAzYy36QUFtUTWbih6BgnAzWBX?=
 =?us-ascii?Q?ttOdRcwdSftJJ0x7o/ae1t86kXlEQ0epGb34gDphj7daojve3X/4aiwc7GdS?=
 =?us-ascii?Q?+z+tAApufQcaZruvv/s0SoJxhOCQLiGRyM/W8FGtnkta8+5aCGg/0s99xQB3?=
 =?us-ascii?Q?kqPYV73XPZ3i3h1eDDJGIwDt2nSrlhfvrmU0nFOmWaDJBVmknJSBuxyhKrMC?=
 =?us-ascii?Q?xrE/e72nxw3OTJtUeWt/rPEkG7VFO2MKgnCcuhMxl794zZWFIhNTYYYnU/mr?=
 =?us-ascii?Q?eJvxc8+H9TUxZAM/FlXr1xs8LQ42qBShmSBZArUh7JgCiciMrFsMWTAwYFz0?=
 =?us-ascii?Q?O6l8xjbgvI1tMNW62ky4e6hS+nMSfVrPj3xrOSbo3CcV/eXQxJ51R0iw1seH?=
 =?us-ascii?Q?osRmnubbKyM6kVe0pNC2CGqN8H7BIoHwyf0lZsiTSH3VXuRM100SSatZqKMH?=
 =?us-ascii?Q?l2d7VDYgHsB/cR96E1pKe9gYCFWE7ar7OaLRTFjxv8qZhJfQwWaqo17Lwf/v?=
 =?us-ascii?Q?PtP4q9w5MB+9d8eBP32AfS68m+pKWmR3nRq2mXIxdRCXSto1KxG1xQSX92lO?=
 =?us-ascii?Q?Qd4NHbZW/EsdVdszkJxJb4XAMVGuBfNV5c79tMRGBFx46st3yWR21wiuxY8L?=
 =?us-ascii?Q?IzLaBRzNGPhjU48Gk+94duwqlsMnSCLLA+vH+NHfDwo2VOLDBNpeVNG4rEuP?=
 =?us-ascii?Q?oAwvIll4b9Lcf8mH6GZiWy2r0KtUo083HTJbnMnxzFOTh16Bum/LcDgXOpdt?=
 =?us-ascii?Q?mv2unZtfktp8ioLXLAoDon3e9XD4ohuQED/ZaEausj63MBEyh5RskLwfYaOh?=
 =?us-ascii?Q?U5h0ARFBk5MB5Wsaldg3Dy5IHrOZN/a03QjM0/AeYhDYgdvTyC6vA7yfxkOx?=
 =?us-ascii?Q?toys2UFChYzvw2FjWvpz6yvS/E1u/IHwx1zzCVkcIXiHGfUlTpK+Fh/lxseJ?=
 =?us-ascii?Q?vf+DU/RKr5k1kPpalXYmog35jasfTyEwILY6IfFj9L+WL1cvofRilDRKSXId?=
 =?us-ascii?Q?hna5xl+uR+Gge07bRM7eMxGxxACD1DANlI/sDp17zflPnFrBnYD+nnw8N/F9?=
 =?us-ascii?Q?xvEDFt8rRw+LkxTjUsWPtoF47/eLzESf8iv0QAxNwd87OlxjcY3Ovf7gmykA?=
 =?us-ascii?Q?Szc5Ow1JdGIFunkgcFFHQqvGj8MJJB/PsT6F2ejGBrzxkcWn29qwr3UNGJb7?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AyKZEVlWUyX1cQjA+ntCxnPiYEBhpApy39Eo9a+3FxnSQuYYdDwV6tEXN7qd?=
 =?us-ascii?Q?NeRAgBDNlE0LKLJ7ABdXbijVzJulN47mRDIEacW5OWYDcDDpUmRZW8KKlFEv?=
 =?us-ascii?Q?u7EPdVtV/zL/TJmI5AIy9x0/C5gH6wZtEcz4MP9u4pXAP+MZr3L1oLssPqUc?=
 =?us-ascii?Q?jcq/RSuTr+wy0lSGdlVE2y+AHtTZLONBWw3uTf5uW1LlbOhGgT/11Fwxlaab?=
 =?us-ascii?Q?9sVYv7V/sKIPC8FHhj+Kss1yMx/cpwa5EjsDcSSIw9BwyxXy62SJ8VhAQR5/?=
 =?us-ascii?Q?reCDF91BfnhIW7DZfzWa+Td4kvgKq2vv1Y3/b0VTiOvYyNjiQ6RnfO1hDPxO?=
 =?us-ascii?Q?iWv+zoSi/h2KYqsCiXFIiTSTESVoaS1J6C4LS+jnute/2wwJrDV7vbBTePfg?=
 =?us-ascii?Q?vQ1e42xdmeJ5+i9f1wqvEPZLXY2gApRW8ZVxlu3TBF6eVX2T4QybuDzgNTdf?=
 =?us-ascii?Q?g9bTi5iTqRjdts0Q6yNLdUgF01f1aJs2R7BBwg/wuIX0ChBrOgP797LCa0uR?=
 =?us-ascii?Q?WugQCHVMmA3qWjarlqGWUskkzjjoJRSzVQqECt8UTf5JiLk9MrQFazu6g1md?=
 =?us-ascii?Q?xETDb5tHbylqywVCa9WfmZvHf1HhKpMRp7LLVrjzbHhY7rEuaxJQFLV3k1yB?=
 =?us-ascii?Q?FreX8PdTQMK7VUcTEBIBCTqkUK98r4a+PzXlGe63E41mK6huOmGPvg0mgGV0?=
 =?us-ascii?Q?z63m6Jz/pV3BbYURf1mYk22hbRQSG5yGxu+jDf/tG0v/B7wVgSjUW147u/3d?=
 =?us-ascii?Q?VnK8RjfrhF+/dGbGIjDF+JDyjiFoOI/vfjB7+IRdo0zWqnMyTKamzLTNGbGK?=
 =?us-ascii?Q?8jMTY43LZ9d8gLdSx5OET2JIkAtFpzREQ4iCiXTGmXCE86pUAD4+/TZVcjeL?=
 =?us-ascii?Q?rQDoDTzOytBbm+8ujTkCSZJOS0sj40aWcRwyzIVdQum6jiM1Ca5xkiN4Jzja?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5407333f-eabb-43f1-6421-08daf97b20ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:40:45.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2OP2TF8U55UN9G7UGi0PmR+yzOke99OIEHM+F/T2pYn+vXWsCiIULXVHTaETiriw0t0IAB4i39LQdqlJQMkCFpiGVVBcZB8OuPCxVrXQuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180149
X-Proofpoint-ORIG-GUID: THzwjUO43ME8hpL3ZyS2l1n0jTiUE0ed
X-Proofpoint-GUID: THzwjUO43ME8hpL3ZyS2l1n0jTiUE0ed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straightforward conversion of get_hwpoison_huge_page() to
get_hwpoison_hugetlb_folio(). Reduces two references to a head page in
memory-failure.c

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
v1 -> v2
Change &folio->page == compound_head(page) to folio == page_folio(page)
in __get_hwpoison_page() per Matthew

add a-b

 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 10 +++++-----
 mm/memory-failure.c     | 22 +++++++++++-----------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index febc36f6c595..c6854fc50690 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int isolate_hugetlb(struct folio *folio, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
 void putback_active_hugepage(struct page *page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 856d2fdffbb9..c37a26c8392c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7272,18 +7272,18 @@ int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
 	*hugetlb = false;
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHeadHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		*hugetlb = true;
-		if (HPageFreed(page))
+		if (folio_test_hugetlb_freed(folio))
 			ret = 0;
-		else if (HPageMigratable(page) || unpoison)
-			ret = get_page_unless_zero(page);
+		else if (folio_test_hugetlb_migratable(folio) || unpoison)
+			ret = folio_try_get(folio);
 		else
 			ret = -EBUSY;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0b0a36afd79d..eb8c3cf2ca36 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1328,28 +1328,28 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 
 static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, false);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
 	/*
-	 * This check prevents from calling get_page_unless_zero() for any
-	 * unsupported type of page in order to reduce the risk of unexpected
-	 * races caused by taking a page refcount.
+	 * This check prevents from calling folio_try_get() for any
+	 * unsupported type of folio in order to reduce the risk of unexpected
+	 * races caused by taking a folio refcount.
 	 */
-	if (!HWPoisonHandlable(head, flags))
+	if (!HWPoisonHandlable(&folio->page, flags))
 		return -EBUSY;
 
-	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
+	if (folio_try_get(folio)) {
+		if (folio == page_folio(page))
 			return 1;
 
 		pr_info("%#lx cannot catch tail\n", page_to_pfn(page));
-		put_page(head);
+		folio_put(folio);
 	}
 
 	return 0;
@@ -1418,11 +1418,11 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, true);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
-- 
2.39.0

