Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43F6B1241
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCHToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCHTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:43:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665174DF0;
        Wed,  8 Mar 2023 11:43:37 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiZqR010397;
        Wed, 8 Mar 2023 19:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OP0iftNoe+o8auXQn1MhCGwSpZW8MVxMVSou6xismLE=;
 b=23qSBHc9If53IPbfcBZx0qriIIZKA80B3v5wzWE4w/JzsY5KJDETR0Zf1de0k3lrdbgu
 JWbh0Vhrao0tFu9tM+rG8Yo2Zk8PY7b2Hdx3DP9W5M1MJ91HwZikkfs1C5csJFMbUMxi
 hSc9fmVriuFvUdzvY8Uzvu82cGRbejMnoMXt1nNHen/A1PZbn/c3puNCkHW+7Ny386Sr
 luv4JNWrmUdqKs/bGpadBcdJtJvRtLuda3J1s3PFCy8HnS6OMKJkYnxiR4PWwbE+TI/B
 crwduerN3UOJsgixbo7Vrh0b9TvZl/dGZd2/b+O2lCVX4vgCKnlGkRb/xF4Yh3HvgrO/ Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416ws1w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328I7Q8M022398;
        Wed, 8 Mar 2023 19:43:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr9808v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8+/1flFhPrJgcHRQMCjQyZ74QJACTGnI20PsxGK0tFODlMoA+pVOQ5iGMt4NZ3RPzASVbq85zu0JmkfJZHgpoSboJXk0REGxwIqHGtQMRrVQKHTG/RBANCcQqB2XYHa8yqxffg4Kuexyf73+rqO8EK1+aNzpq6+kBJ2YyMc0nDmp+BnTAjfHVnY5YxeaYkstx2v92DJ0QiN9yjQcMbYyoL+oub2c220htNBGTFj7IhtpJ/qstO8g4xDNSMrnKq/C6uMCalddd6Zjzau0CoTGvt8L8iAecy5W/jz5kI5m/mZ28OgEVvSIOn++YIjHkULJl+CzNv1wUEoL0pGT9p5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP0iftNoe+o8auXQn1MhCGwSpZW8MVxMVSou6xismLE=;
 b=ZlSn2fYXbueH09JUYpkGiWWKo3OD7xI+EUpQRUWAAq4GUMsmP0NBG54l7ti/2j5mxjANUpLHojBskX297je+kfaNNJuEVRQsAClqEuSrKk7UqMQ+Q/NywTqfICKA32v8QViaHVma3roVfN7WaO4J/E4kOorrj62EKkaZKLNvQU6gPbDzwjbGH8nkrWwkbkIsPj/ysJOUzaUfl3rq5V3Bqd8JK7ntHbM43HqhYGZBDuIZaIFZVP25eqh5/ZmcU6Jj7r0DPC/pxGfn9NA5kL66aAH8IdYRQguPnWlt0vNyWsSwwjuGCdVAPw6uH0droQKzUTe231IySBr8Awqbjg14ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP0iftNoe+o8auXQn1MhCGwSpZW8MVxMVSou6xismLE=;
 b=slx1CllKLyRm8/Wa1KFXnuSPpsYE8lt/7FfNf0ING2oTh3hx0r10sf+YWc70bgdj7YXABn6mTD7zNE8T4M50h6Q+93jQXMFACP9tPsJx9IdEe5WAOjuQ6mFXXE0btY7cpHX7KU4ilIjpS05MRqpbFWu1XLTYm08WIhebzPGqcXA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:28 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 04/18] mfd: da9052-spi: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:53 +0000
Message-Id: <20230308194307.374789-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0486.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::11) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b7c259-75e7-4d7b-b770-08db200d6402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rxbl+Ga3qz2732goICBUFlvguXk+1ImiK+MCHfVqsXVd1yRwXVDRAn63/rBPW9S894MvYPv+gvzoywQBbDfjtP9orPx99DEmQ+JU1b59W6tPYKmIuLu6TrZAQSS2LMUXiqNIzpyhYvdxzpuDMKG+fJKBdskBF194waw+JYcK9YwSfVjBcQ/8SWYJe89eAtP+xgWpWnegOC4BXhXWPVUuQdVS43feEAc8LYUXpTSXKWRjyyGmXQHF44IlXh0+RzBKw4gWz5Ei+gW+7FjUQvxbQXpN8i2/YUqpstqS7EKafqgYLUEAOaaEaQyr7BFEJF3VP8PgLw5ObwqADu+OwUDZF0FA3Prcuh4+8jWGGZzkHgHCbAIwVYzbcPzNJ0bso4NU4TL8Zv+UmkbnvqVcBtwbnDghJD3bsGfYHU4lOZn8cE70SSbm3AtDnlJtoigMAQVMIV3NxfqNasOl53H1ZGkYm/CrWk5hbRaSA/LMDTWbkWtjEMzSUxMLW3V/bIPfK1rU4sA3FxGoA7g9ndIf72Ds7qki2tV+tjeJ3sFMaW78fqtKx8qgY4oQ3BQrXpdMCIpJ4TdkCOpNUyRuUGExzFhIz4DKeSrLt51WAoJLs3xZRPTRsEhpLqK+yrNPMjjby8Ihs+d4K7TL/qnY7c45L/kaXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQWgs9Xg1wI1IfBqcDGP81nJxKdgquqHtl2AGWCyPxWG/H2yDl1qexavHN5P?=
 =?us-ascii?Q?bgIHDQXKOOyNmAlmueA17irxTzVjyF9PcdGhCD9oo/rDOU6TAuVLmeog9WHP?=
 =?us-ascii?Q?OG3WWiXrLxqmxT+yGtbvQ2x3zPnN6yQMy4CBKCfI80dz9d/dyQj9J12MiVOd?=
 =?us-ascii?Q?J5PNxlryJ7Mof1i+1pc42lis+m9ntumvL3WgIOhTXgLC3iKZiqADiKqNIRV1?=
 =?us-ascii?Q?xBi98xBjtMAxr9lPg2u8tzzJydSpTT3zKL/ZXIn/X2R0GeJezlFVvy7ewZYK?=
 =?us-ascii?Q?yZbMy3laWJ8rPbG5iGBoD1rGcCzUBk0Mv7Ys1EwAngoUATPzfvfn1/DY0nHx?=
 =?us-ascii?Q?OdZv6W0PpZhXg4a0TNPxb7vkY0T7vPh2Hjx1gSXnHKihEYnkEcqrrzKEZHim?=
 =?us-ascii?Q?TCDcIVyt7Ejf5ju5uzwylMrk22sgRMcE+42UFUM51AyD6rxDX3S3qxPLpKIY?=
 =?us-ascii?Q?7/23+8z8E2//MrRTILkZg2zLe7FZ0jssBBDlvdmbaU2HZNu79Ii1BR7eZ18v?=
 =?us-ascii?Q?8ooxCzfrQQRC5iWpTH1nRdqq1jQbDsTeZe1BE/25GdRQKsmynSwKU+dFR8EV?=
 =?us-ascii?Q?kDI7PkeQfQ/ltByH1tezSYrLedAu484OD3HOj11blwe5psVyyL2oIyDCq2Fw?=
 =?us-ascii?Q?ugjkJ5T9tWpXiuiJZmi6nKktdW09HTZ05Ua3EwPJHT1rByPsoR+o0qdkRM/n?=
 =?us-ascii?Q?Ua+8tH1z5BGS2AvPhwu/BNd5mhMu2V1wXUAeyWvZL93/4R/g3DyX0Yr8XMbf?=
 =?us-ascii?Q?opqfHYT7XdUt+HDpJRyjeHg4BI507zIEWKHCF0Wsq333Qsf+rWUDCmhK/buW?=
 =?us-ascii?Q?wCgvousvkCwA3JoOHoCwKDASDbUUYzcoT4oJjYQ4iHwcpNnq5j+H/4Di6vZ3?=
 =?us-ascii?Q?aCKe8x03Z4k5JnSPEL4hgOGnswZSG3b8Wvk3EjjPYCFaBbSAY/qtg6qSlsn+?=
 =?us-ascii?Q?P57mnTr2XXLURNm5jzmlzKgBkp4v3t8Ph1RA6RZqq6csoa4KBz7CJTal8eRm?=
 =?us-ascii?Q?zpMwAssf4Ji3wg83sBfEQALRFd/lr4BBULrLKjUaYUP+HxGJYLlA+vFao/4N?=
 =?us-ascii?Q?hPyIA63wzERoiNxwDvgmwRJc+stn6xZUIMMMpZnb2iEr4ksGGFKH+V74W+lJ?=
 =?us-ascii?Q?KvOvMXUdP8EjihIy3rAAj3ECnpe2JMsp05TMuc7DMlDZ+iAK7TWY9XFlp4/K?=
 =?us-ascii?Q?xLFSz7g2WiopvRXZn1yZBGbwmwbRQuPwgWYzUdn6MLVmfvg3xDLwTp17rumW?=
 =?us-ascii?Q?/O0gQoH6zk1RNxzPPFCgqvy8t06YnfBqdHLPZsUwLjDddYXUXh3UKQu1QQyg?=
 =?us-ascii?Q?vWFf7k6/8ZQp0zU+fYos+3ScQEfO1K1H6orEdmzZdsrtNCtDpgFmDh9kUizA?=
 =?us-ascii?Q?tn3AqOqLkGQheig6RqZSnxyISVCXnfFjfVmEmLd8k/lVikUMQjsUl4CEa5PD?=
 =?us-ascii?Q?RwMBPA+hY39nOi4S/9nNqqmcRLD/oZNG3IW91ufJHFDvQzqNVH1m1tZGb4Xe?=
 =?us-ascii?Q?cgODTz7rMbWQK4CnSNDjqhFOB8091f4bf+pPgDhgJT611qkg6sNDU/JevkeJ?=
 =?us-ascii?Q?ao3d3hEB0tVe8OQawSHlTICcWVT7goWc/SWifI9nLkcAzKlelR/NwAcwjbD3?=
 =?us-ascii?Q?z3lh9+/V9boM9U98RFFKJPk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IhSlFtLIKMIX2u2cEzzSbg3pODemKL8ODwOHTc3agbLtL30L1F+SIiQqsxjrdsjZH6cpVlF2ea0KYzuqX2r6jRCeWuW6/YrD9FrsL0WuZF4GyD4QSAs/4VAoHrMRQ8+oPeN3IiOEEzgKyq5+idtImZfYBu14AWzPvtQFfCKnm6OBEP8cxkO9eEh5F4Gud4GUCTwaV3ZlY9bfMtAMRl/7Vu75iiYpb+w8E1wjJ0f1TJb0kz8Z7x8xjVUPPu4vubmx6ZJqy/E+7S88IOzngvJmCaSbzgwtC4Y0s5WJtBhZgsHodxb4ZAv1aWQNpfWPgBj85bm9eNrmC6b8gRjN+Pmi96OHrxG2+lT2B9fzx8yo5jIXj48gRQZNDE5y57u1NJK4gy7gwwEZq+IqVP5mJCqkAYOWJGg0a+fQbNskuX51dBOmV2ATQSl3wHX1/zacMkArzcyZtP8ESxwLZByjutJtNcS/yXg4E9rdh+V7lbxWTZccVvUVS1nR2X5Hje89aPVRJG4BlACJjPzAGiU0MZ/Zxa0yCPBCN7PVgiZ+H3+mtDt9CGRlp/2dvS+kFhWBlb/mZelY78mrtrAksyr7zme+AeidJVo/ugd1bZ73FlqALEXoJz+kdAhu6dRupRLq9dOlTy78CosvFnI8w656tcNElSBDAezlK94jy6b1xRBDX4mpnb1i6lHVnAf5iRdqD7NJXBrjvZ4QN0J+XpCSTK8/W+IH1XoUPcL4zY0KEX91bwZCa8BauLAuOcmXJkrQuiCsMMDjTCzinVOfVeAwMWGmJLRZ+N29C4yytL2hmkD4X7InfS0WqVC2pSv62y5hy5X6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b7c259-75e7-4d7b-b770-08db200d6402
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:28.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl2dkt6Fw/GLWneR5s+/j3SOrvZrQgiBmN3W/gk3WictwDe6yIwBCz13VzHCB4Wuc6Rywhka69CYSHX73A5spw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: Lgliuj7CaB8erPDMjaOG-T4VNRTqMj1q
X-Proofpoint-ORIG-GUID: Lgliuj7CaB8erPDMjaOG-T4VNRTqMj1q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da9052-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index b79a57b45c1e8..be5f2b34e18ae 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -102,4 +102,3 @@ module_exit(da9052_spi_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

