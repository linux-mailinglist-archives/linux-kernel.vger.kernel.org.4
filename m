Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7072A36D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjFITuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjFITub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:50:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBA3AA7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:50:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IIPgu008829;
        Fri, 9 Jun 2023 19:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SKlyEay909XiOp9za551/Rxv5Re8HmEauyeuNp38JPs=;
 b=PfBrWxx0EfBwvNGEXGljIb/UILwln8D8sEK6iGkQ3mxsLHNFo5VxhF//3gubfnwcordr
 VnHh3c5vhHJwF2HRZtgHyTOfmW1pIhnil2tmfBkeNRlScIF1hdwu7iDJ1bHgAyMtz4K4
 NOU2LJjG8d/Pmk5GGKaYe3M8yDPNYY50PdZNpQs+zW9b21zr1T5w1eF97TnQ84IPosVD
 9Sb38hLn+mSB53NHl0piQc4Rbcf/0UBPrv0AijsAyipX+NJazkprOG5gxFb4g0oQQWbp
 PbZvmYQx2DkV/i8pHjZPJQ7YjAiGymHZq9536axzaXnng2Y1X6uiDuqo5JUBYSdHP7NK 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ufee6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:49:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359IbKFB010507;
        Fri, 9 Jun 2023 19:49:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6tm8u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 19:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LySd5CMLFhUciSV0iiO9/Fcm6zuuQgZFAJUEeTDYQD8SSyRq4C/X13qErvZ+2MngjCVPyGRgWLpv+cyiOSbquFhgqgtSFErGrpFzt5sPW4GJlhgX5Eg9Azj4eAjKRgFzZV1wqTPW4kBarLDyopzKCcGo1wbWTvHIAHN5lpXaW5zVSawfmwBxIZAB/dhaUVdvXAY84zp8kYFChi/c+6G+VswSZ6nsRVYhfycHEM8GzIANGa4vRLg7bgLiryA4FCqtf/cunswTlgdHzc9M+aVs340MNUWx6F2hCDrPjZLlPj0LzlalkwnCkwjK9pbQNphIK76eW9zlZt0AhYT5s3JSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKlyEay909XiOp9za551/Rxv5Re8HmEauyeuNp38JPs=;
 b=OTBBaxqzh0+6ELfVQnYwanjkSGFC1k1vXrcCbP0wJY82vfBch8azbin1DZqtiwo1IiuAaO7Yl/KbVoPxHCGTt2EZ5Hn8w1xRLtN4ak1gsAl2ud4eQoSl8GpH4piZ9eIFWP35BS5bYg52pN/t1OK6TXkFDZDvwp3XnqZKh3sYaMMQeyM/PcZubnoWMIANRGgSqvFpxiGJBDhR28IDjuzR37zyE7G19BQ/3jCKnWDS8Gc1jQgzedxq04pBASM0dEtYidQgTLzrprHXy4FWvT09ENxl7VP26t2Dx+cFOh4PLiuXBnbp30vN8BiICu2VMVU0xPdMQwzPME9z/fpHygev4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKlyEay909XiOp9za551/Rxv5Re8HmEauyeuNp38JPs=;
 b=c1q8gFzeknErgfRaJs1c8bkh2PTM1aZLWM/ACdR/m7dxJyz07THo/eHajJbdp3NP6X2+CDyM5W0VdVDl4qUR8bXRkodmNxC0FCr4Bvjjn1c7Yq47lvIC1zehM0k1pVbdy9uibpYS6M5GQA6JEDhNl3LXatUN4wEvyFQ12y2ol24=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 19:49:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:49:55 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, jthoughton@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/2] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Fri,  9 Jun 2023 12:49:46 -0700
Message-Id: <20230609194947.37196-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b9a241-9c82-445e-7dc4-08db6922b29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuYMREmb6vMNYaM6VT5GyS95PUlDHEn8hpGX311kzW/heJcKYU7uPcMcBYUS75KJpAQjgyKqPley8k+cjupPq1jXwl2ivh4Smwvfnldx5uL8J4fO62EjbLk9l1qzgjrFzeLyEbRlLB8zMISmySYLgetK6c4i0DBs5paDPy0F14Qoe/KEU46VIAD2Ifqap/VPVXpdnT0yC6Y8xYQqc+zFUurxhcQWUxlsYnVAZCKpGuDGJJd0qBY2jXUIbmaDKoAvg/QfXMIEdFVu5M6dfWJ4tf8wE+0ELrHBEftdMQiWNkqav2fK4gH8SEFhtIpvSI0BDRIfNh9kb5vrpC7vc31UsbElIusIo3/ZFyBz7A7LanNnAAzdVGHkqrl3JRWOYKc2sG0mkjYeXz1J4jSPjT+lCioCasuTX2eW1fyjH3BruwuDTPdT9TDA9MutwOW7+YUku2oDAtohL0pQLAGQfda6DQeKOC7XW4dpP0i2m5ERRH/bfcLiiQ0l74x8c5CSfPC1ZXRDWT9O0FUG9ZU3BLpDhNzL/ncxlGyK2S95abOjBQlzjl1AVGu6+oYEFOYT5bmu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(478600001)(66476007)(44832011)(8936002)(8676002)(66556008)(36756003)(5660300002)(2906002)(86362001)(4326008)(66946007)(316002)(1076003)(38100700002)(6506007)(41300700001)(2616005)(6512007)(107886003)(186003)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4K1etB9QAa8TW7vsou/ga9O1O9YkIDhgfjV3/QuwpOQ8pQ0siWZCALZPB16t?=
 =?us-ascii?Q?mkPZzMcGVVDoT0bYhgHejCWz2r35Fh7w3/2kJreTCr76fKBBSpOJAi9nxVlc?=
 =?us-ascii?Q?1KeYnWZ5BqVwUf5C75Bw5O8TVTlmGDqZOkLZBmbvpTxKam4WvcirYc3vreiR?=
 =?us-ascii?Q?mC8lMp/kMTSVQZwK0b5I3DnTL+RgGhZHFCY4f0Rl7GmA5+JzyR1CMbLRmeqO?=
 =?us-ascii?Q?uI8b2xK4Bhy5G1poeC3Eraa2FJEZkq6aDmGKl4VW1d+DzyvdP6dCZOO6cQAl?=
 =?us-ascii?Q?RuaPhitrs4EMa2hMobZZMf2ygq5tbfhQ/vdhQXl3qfN8jNo01YWCPvmxAQNO?=
 =?us-ascii?Q?LOPheavGm9JvqR5cZGMV9WYBW8Zl8tEAAlYwGHJSNo3Ctj58MeycH8CHTKVt?=
 =?us-ascii?Q?NgO9jks8TV9qIdVU/W7yQD3ibtSYTDIKvoY3ROj+fFCzSixhPra6nWq0zSPv?=
 =?us-ascii?Q?C3G3wsa4gDouqd/Oka0R4aAiV/9eLOME95QKoWMvcowhfAMv8DSzsnpJLss+?=
 =?us-ascii?Q?5QJYLKKtxX3MV7N38TfNdBs9maBWNlPCGSXsTxGR+HriE9aNDCVg718lVCPm?=
 =?us-ascii?Q?cTHudwZMQhDHayCc01X6FudHLJKI8GCJJj0T3Yn2uCP1m1NS9ItGL0bEZh4F?=
 =?us-ascii?Q?XNEICakRdSGjvGWU8YSbggg+WhKTwahmRFZtyGOH10PTS1fVL2UeBYXK3bYZ?=
 =?us-ascii?Q?NBHPNRu2PdtZ9zHbeiOnTUcVku8/fgLzfa5xhGw7IAUtPSWFrw6vbONpAPyi?=
 =?us-ascii?Q?qwC0MBPtFR2yi9mW0rEqpF+2gR5hVfM5Pyfh2FhWaD60L9ZHRkhr5j4tycta?=
 =?us-ascii?Q?yasXGG/ltRaonyetvNBucgoGjdGareuOgkSInWFSTyKa4jqSILUBm0Gcrv3J?=
 =?us-ascii?Q?cFJ7hDcK71YUXoK5RvFbw46wABlUvxtGbWbsDxY81Nvl0Y5ItisSOwaZfbwh?=
 =?us-ascii?Q?LToeZnCUxAHkTnnlCCHYYC2QG1wgqMOfNTOcKa1qLdwLdI3FAT2Q0SkZUduy?=
 =?us-ascii?Q?TdpFAc557xPMYUALO3+88hXqbotB4MmPmzKn7iAD2S8p9MYbOvu/nMUHB0j9?=
 =?us-ascii?Q?Hfj3jJCOURszkB2DT4Vq9KP3iCwjxZYl2beG8kz0DUHRUxFPclvyuxB5iHuH?=
 =?us-ascii?Q?IeoDnN9xN/XHiFMXZX4E50GGavoUXQN17FhbzcqlBPbz83mIWB6QtPzMiZ+I?=
 =?us-ascii?Q?TGF6JPbERh4ECmOIt8mNkBYk+Z3/ggXXzDR3TcuZm+mbJryoeXINNUI18mX/?=
 =?us-ascii?Q?e8tZ9XkY+rK3KAZ5X+itpSVqVD/MOt86+bVJNmk4QlbtXrr1lOQF3sj6zv5+?=
 =?us-ascii?Q?DI86YdMSDLJTxnhIKeC8pWAdN4N3frbItaZtCOhxAlDnbQnkHfuvQGz167SP?=
 =?us-ascii?Q?NQq5zDIbqYhq+lyS+2MRM9JvwDxGww1xATx2FgspCHKalVtWtdJHNOhD1CaJ?=
 =?us-ascii?Q?FT2lCVF/j7vQ44OiZ6RGs03xd+d0EqATRQLI6/6xLp1tOCDwnju3eIWHqzrH?=
 =?us-ascii?Q?lvg1YeD9uAS9o+Y9arLvp5XykHph7G/y2xx9QGmyb3CesLqhPzn0/zQXkVh+?=
 =?us-ascii?Q?HNsoe0rVu2BO2IO5DH7gXitT5iTi6iO/QXVLrZo6Dx90akwwZdyU6ZCDfRdO?=
 =?us-ascii?Q?ZLzFm79vQQe36XUZrjC7KV8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0+TWjTSOPtwrd0IgoS9T9drFBD17hzNdlpGtzonmGM5+P7Gb6R9+WfMzKmUA?=
 =?us-ascii?Q?8FLdsIHh1NsDTN08ozO72uRfjmSZdWgTp+BUhuadZEF7ar8g+gsuW4EbIJw0?=
 =?us-ascii?Q?+ldtwlK1j/Lc6bE5wU+somfs8EXFS3iMWA2xNR8TlLGkQggVS0moB+za5IZq?=
 =?us-ascii?Q?VXJiaH1074OhYXnDCZ5olKT5owNaUq3AkO8iTlzfWGpQlQn+5kXd43GZP56x?=
 =?us-ascii?Q?5BjZxKjoKd0W/5M1tJ82d6la/ljCqfZcrgpKPhLIgO3GEm7T+Gr1LC908RWq?=
 =?us-ascii?Q?m+IL+czHNwrwWt+8QzDoXdZNk05zp0KQ1rKAPT4l0IIYMFj4BKD+jdIDq8TB?=
 =?us-ascii?Q?kEr15Q+wlRXScHW9JlYxZTjaqXLHW2y7+9Aw3dc3CsHR+73RBImz5mtPOrgt?=
 =?us-ascii?Q?9jyAImUFBcx5Ekb4CKZkcGOODU7HWzDZTJMJjaQ1TDCKgHZ9GigRhbDyZ5X/?=
 =?us-ascii?Q?x+sFzwE810b1AMAuMcpoYI5sii5m04JKErnqpPnmlaS7dAvlp0yolGHmFjo9?=
 =?us-ascii?Q?v/mOg61thmW+kU6mUdJ3SVFs08w4k2Yg1JAtO/ZEqZPj0jG99/cfjLJu4a7F?=
 =?us-ascii?Q?6qj/5ndnAml7Pjw+iJm/chytMt+Lf7Bb7nXVbcPIOtLK5NfJCfKt6FBO+asm?=
 =?us-ascii?Q?gNvMhSb9LrhS6hc8Jyeh2vQzD7VQkRQcZMe1QozDMrLb/oShZhCelxLh6slC?=
 =?us-ascii?Q?ocxOjAKaFtizrJHd0hJLXahQ1sdPAb03YXcDeEk4VDZZmBGFoTiTJFUd9lbo?=
 =?us-ascii?Q?vN0wbpiQ124xAloVjPOJJ+fANDeEToxVqT3YuV9brVPkRuXEMW9PgXtoUyLj?=
 =?us-ascii?Q?KknHZhXwyds4FXyXybkmg+2mLxTJ7y0UpdK1fCFy2VhVeB6a8hu0mV2dMMwS?=
 =?us-ascii?Q?M/0Qs1iqC/CGHJqBzAysqwWULMYGVPRlYomsrsVv4o+gzzOcEs/HTe/9EfyR?=
 =?us-ascii?Q?pKTGxAx+LtNAz8/gZyyCdlcMwLAQSjXtpe4qFWQYqKqBQKN68gOCF4pxE1jj?=
 =?us-ascii?Q?dSAc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b9a241-9c82-445e-7dc4-08db6922b29c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:49:55.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6e6KJRpnSlpt15/lI3PxICIdtkXIm0yngHJ62fe2dtJMb0kLqZrzh+4iV1nT9iN9MrfsqRZtWFbmte5oo92kp7Fm7elaM2kz1QICvJiq0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090166
X-Proofpoint-GUID: aJjYpTRCK_KaSSfO6OZSPXJ5eqzxWvET
X-Proofpoint-ORIG-GUID: aJjYpTRCK_KaSSfO6OZSPXJ5eqzxWvET
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to remove special cased hugetlb handling code within the
page cache by changing the granularity of each index to the base page size
rather than the huge page size.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/pagemap.h |  6 ------
 mm/filemap.c            | 36 +++++++++++-------------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 716953ee1ebdb..17c414fc2136e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -723,9 +723,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -850,12 +847,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 60f6f63cfacba..7462d33f70e2f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2048,7 +2046,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2112,7 +2110,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2153,9 +2151,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2181,7 +2176,7 @@ EXPORT_SYMBOL(filemap_get_folios);
 static inline
 bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
 {
-	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+	if (!folio_test_large(folio))
 		return false;
 	if (index >= max)
 		return false;
@@ -2231,9 +2226,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2250,10 +2242,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio->index + folio_nr_pages(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2291,9 +2280,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
-- 
2.40.1

