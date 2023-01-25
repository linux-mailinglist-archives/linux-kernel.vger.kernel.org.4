Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211C67B7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjAYRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjAYRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343DF83CC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:13 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNkq3030139;
        Wed, 25 Jan 2023 17:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GihOQ5fsCQtG6jJxaROz1R0G4aMEaawfbkY9vobb0oc=;
 b=weBAscDqaZV/8NAMqJMNfZOp5wFLCjfImg8Dkcv7A64J1PUt1qQj2ITGpdaCJFyUS+PR
 aTNX/PfVx8/AbJrH56mIXvH6BqU6qTOrwLVHK6zpQAoiuflQbtIKDHnIfhjVHwycc23g
 ffXYldvMh2cMu4MyuCAlFaNFdmu4zfdkuWnjk3H/BW/jwNu0AqaGu21iZAWYvGO9aCkB
 nWaaGsxDyyqxYKkqzhDE8kmxRWNPHQ+c+MaD4wMEb5Zh1Lj0IiE2Zw76ocDpVNXhQ9ZP
 9BWKwks2Q0Ry8fnLoKLaaGf/l5Y3KTMf9AqMw07hpcxpAXp4dgdWdhXyWh65jcSJWkmW lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u30hmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGC4Ur025091;
        Wed, 25 Jan 2023 17:05:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gdnbf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiRTkGqsWH51E5mo04DLC+Vj/7zYmwcQBme1+OeGjBU5C6QN2o0jx4kkH/zUu3thJqozKPrQFlt18uND5D88YflAPwOZW/1wGA/FpQEkRp60JcW3xA+gxOzJfqlms6fRERrxj+dgMzYaon/haqZ7C4EmChZR2ZPM8GGiXxQJIVBnEhWEcs5TU6lJLqDTlINUNTQZ2ECtkK0ONsLWt+5o/pyY2vofs6/nKm7gCumzzuhK60kYLcKdTBQi74bNJ4KHAjQvX9T3UHuit4/VQe7uaDLk2N4+CcoDIoecW4DA6um86SPYgAL0DAb7xfINRA26IwZm531SN1PxSxb/fm3tuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GihOQ5fsCQtG6jJxaROz1R0G4aMEaawfbkY9vobb0oc=;
 b=iOnpOwVAMU2/R27Al7uTUaTjngv21mC8KTP5mnwXhutu0OpKn5gZOJRyayp9IrqiRcIjfSsPVXltyqphUo47fG6LgxVV+VcZVZ5M2lyKN2SJqe2Met2XhE9xUYnOZvjQFHJUksaDuC/uCYDxxZQGJHUvoqr772wKt2EqY5U0DklxNy/jv0dR2NjEv5qID/JrIKNRX0hqgnwrc9tM0nEpNfw00GbCeiwKZBqiwDFMl7Kj1KmEdqGowdf7fLgxNmNV2E6pbnUB9J5EMh4p9U/StzLWHSM/bYfx8gxLIf/7NPnwr37SMptH2jNHsVHPAcyy6vrp0h/r2boNlp4tAwkKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GihOQ5fsCQtG6jJxaROz1R0G4aMEaawfbkY9vobb0oc=;
 b=pdR7EP4Z21NkbT+Nwx6V9q4hJFgneZBjGe3RNQ8FY0vpfZdZAHgD2/Bcl7W3LtdjAzD7J2Iyzo+eGPjp0Pbw7q6QARFCry+/slJctg0L9rTouH0B69/FcTE1ivxuyvZYkOGzegPvI53wNTBYQEvBn8fUoQCsV0BGWn8BTraBr8Q=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:05:49 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:05:49 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/8] mm/hugetlb: convert hugetlb_install_page to folios
Date:   Wed, 25 Jan 2023 09:05:30 -0800
Message-Id: <20230125170537.96973-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 612d9d1e-082b-47b2-160f-08dafef66831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVYIDJKxjxX1ITFVMbfPZh0tHM/gIPi/lSsQjnZv0N9QK+7SoPly57I4GlBNdf4yuYBM+Si6l33yv1UqdBQRaSLVvq7zuAgwsrN1mAAW/MAF9vFwc2ifEB7fTflmBHq+H8ZeGCBxRPPwkw974Q1R/gfKq89GCiuXKdiVlomQW0VHG1nHyYAP7TCccMHeAK4Nx/6ONG7MYYZ407/X0CHBEe1rd4MbMGecB6bSqrB8pB1q2Xih0Co5tbEaMmUruvPMRA8BC+dV4UEGdAA6hfObSBiUP9UfZA5N4r2UW74DN13gTWl6cSkims+APqK0p0wFz81YXqDFxTxfZJb45lbkSRhdN9wKq06bmAzd8Gu0I9M66XtRCJQGiY0Pr2FT+UiT/G+kse0C6SOS1ddRF974e0U/qLoeEoRek9diCk4/SWUC27QsQ+QmrQJxwtPrLCf59DUK90ES/m8XpNOjJxIu7HVAbmMnX2OOmZ9jzOtdzfaMyxEarBFCFQkYYGMRcrvezwdORmS9CIMhrtbqiD1EXrIelTc5p0cxVrL7yV9U5nTDOSDDpBa2dVHLBlcLBjn/sJJ3UMVQuYa1eR3gV+DLKT/Od1a8MVvE2f28PIvhAB9NdOE4ib4FfG9Y2eKIUIQuS9P2s/eqYvpR2C4Ka96gCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdYH2L9NW2lIHJSHRXOEz4gUWJ02FiE4oEtOent2Nb0F7blbmTpeZ5wMP8P4?=
 =?us-ascii?Q?bvNulgS55AhZhWUTDcSMlZGQRiqXyzR/R/YqgJ47gw4RwkeQbc69JOFjMCnD?=
 =?us-ascii?Q?5QSKu34NdEb8gMo+bNcGDReMM8QpEHSRx5dJ4f+ksk1Kn4ApV7I3EDlcYiX3?=
 =?us-ascii?Q?9lWOW0oYSMtP6+J7sap1rXZaCUjD88c7Rgum9h1hGd+X9tXQy54Ew8+XGOc7?=
 =?us-ascii?Q?nx8eRNTEaFoig2VVkMy1sjRZiPZ4KHTq3RRn/iUPazeFgWU8nL7qkM2jZE/L?=
 =?us-ascii?Q?fZgAWiBqsLGgHyNVGej2ZmCUEuCz/jWdZ4qOzhzAr9oppmtlwg7ZaoMc/51M?=
 =?us-ascii?Q?dZbivW8CDDnR2vYItq30tH5Lr+uAyqilc8mwF0p8vwHb2yyKAnFqE3urJf9o?=
 =?us-ascii?Q?2McbsUVHAZcO9gwpk4FTlBlidUZSmljSZgCTTUXUQiPCuOghh3tZmJwcX71v?=
 =?us-ascii?Q?A99FrX3LYF7g/AEw+gybE9km6bjZXLqjte+0fER45Qx5k6+vHYqf7/cLaejU?=
 =?us-ascii?Q?D/l9yIsl0TZ3Ih6fZl4z8/u4OqMYgn3G/h7nFLv24S5f718oTlAFFsQCROIr?=
 =?us-ascii?Q?X2L76SESvv4oR7B3hypemX1Fc5YHt1wd/RXJw1aHFaaWIhWRhmxzeaoR8Ja6?=
 =?us-ascii?Q?dUgSMyscP63QnXbasorM1nP4RnqfkF7Z34uc21XJiDrzC8cDquD6Gaj/M5Kq?=
 =?us-ascii?Q?VjQ41AQt4qv/Yf0eQSjGu+3V59SI+6WIIQYG5yoRhU9o4whEy3vCImwZ6Lln?=
 =?us-ascii?Q?/SiQ/Mgnqevpp0S/V2DqQwMAwjBFS8FuJJ5wdB+FakYfkRGGbMxLi8cgJnb7?=
 =?us-ascii?Q?j1sIXTKv2mYjyLpISgHk4JyS/a2TTCg/NZ33RHR+IfsKpMagS3t4gOi4YmMv?=
 =?us-ascii?Q?0sbcNhtmwf1Io/yqEM/bincyw5Jdt1cTvCiDSbKZa4cZqR7p24XUJyY4Kn7L?=
 =?us-ascii?Q?LN+Rohz8bPEFkS+tnvxI0IkqVkXqxY7rx/88wyn+xVyGE/xu1ZY/K4U7rTeY?=
 =?us-ascii?Q?i2R/CcBlyNTINsWjziy8X/5xyqJpf2wmwBk79i9FaLbLHQjITHT85CGf16B0?=
 =?us-ascii?Q?btywZRlLi2eFrzGcWKFhROLy7wByqrQgq8rSte6Pjixu7O/K3t6f11XrqQxQ?=
 =?us-ascii?Q?NpUTLeMkg7OpMvVYNf8Eq+dTQ4EdvXSJBfZQgfQdXoLYo7gYDkw7AnhtT1dy?=
 =?us-ascii?Q?zwoGI6xumn0zVUh1e+U2SestZtRzHC0d4XN1oV6ZpNFxyGS5Tm8d0qrvOvWK?=
 =?us-ascii?Q?GjMZcS6rrDnGdhIld7IaIe5vYP5/oKnsuGyh4OpZm+UXus2ie830jd5it7+p?=
 =?us-ascii?Q?HNSHPX8ALyx+QOkLT9RqloEZrRGaYfUcQEKQuGF37JWdAVizUXr2ZtTnywrZ?=
 =?us-ascii?Q?32wao7Ov/Squi7121qRm2criKoAyBPlrzYNlQlHF+hzCnU6ioLoGXD+gRVyC?=
 =?us-ascii?Q?BCpbc0v2Z6GdfOclZbguCoBA7MF4vF1E9MloWnQGP5NDdT1uSRHrOwvn8+pU?=
 =?us-ascii?Q?TC9DDJSYqCA82zK5dsFc3baiGQ30zh+D2X4DvB7VqibKT+1faWLMgq8Y1H4m?=
 =?us-ascii?Q?YxFbJiWNlo53gmW0+XpzIEAVKjUTq7NLKaEEAVXKhhntLz8YRI17y9h2fLpL?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VPhzxu5h04wnzq+3efX8zVHK3M9gsUSsUHvyS6uIwqgWa1MTJ/AmSv/WtiHg?=
 =?us-ascii?Q?wPcKteZcXJ+5tdo1IeYOcZWJ905TVUcUV1iIJJYd3KScb3i3bNpukeT/ntFD?=
 =?us-ascii?Q?7M86+O29QHDBO9wS0fxfNZxKBNt4wHb3zSu4Lp4XbGBZ17qE9WgSt+9n3NKH?=
 =?us-ascii?Q?GAu0f8X3J2VdRK3HJe8uFLRTxjBHedP8h6lMDJNubRDZgk4joP8614OUC2vp?=
 =?us-ascii?Q?ZqVsVrZkYK2c+hyem4z6MCTTDWuwNIOcbwdACJybvPpSqG6KVMVGTJhB4LLq?=
 =?us-ascii?Q?S+2IsgtXRqp5mXP2/mBLiHOz+DrHxBqCINcT93l+Ejc6KpztYXFV8+mOCPGB?=
 =?us-ascii?Q?scac3uQ0zqHvm9q19p3qESUBRJPniDV8zXTzed/iKllBbApRhuoWHONy1yC/?=
 =?us-ascii?Q?vQmNZUPXdM/ZsN8w7sc9+jzOvpWrXeP7wzLBK+kmUXeTCrKWJC7Is4fZyLM8?=
 =?us-ascii?Q?nVEw9IG0gW00Ce236hOh/41x5YPabu5x6P4diayY5/XMTdrpcEGjHPtcsQH/?=
 =?us-ascii?Q?s3GOBidKnnPa74RmdbxdJv6W5Y/+TixKa+Ycy6DLvEXV5+VkRFFwpIXOsodB?=
 =?us-ascii?Q?h0g3QHwryUDxuUaED5obMcp6qkk9gYQb/zbxgZQXldS+xsTQLSeSguKy7tcv?=
 =?us-ascii?Q?dqNJVP0JpguAlfJ8d8ZVgXbjZMcx2p3t0sCbxrWHGoapwUjAZCk9vDRZI6Ln?=
 =?us-ascii?Q?1ex9RlApRlWoTrIabK9l2/GNBwFsIs25MSwNqw5bp9fjQgoM9rZJKpLkNsWJ?=
 =?us-ascii?Q?H9p5XwaFrXjh4Rh6GIoKA5W1nwmZSXUwaUG34jDT91XezxXoTF+/SkqwKRsd?=
 =?us-ascii?Q?712gt+wbYNRlHrHNyyFYYACs34sFW8yWtck7zL9VimAijjwdAchJ1nNu8OAj?=
 =?us-ascii?Q?rD96R4i4jE46lDBvFn2XjNVywYhowL214CVOk8BdvB80fclqVtt5KJwjuhxc?=
 =?us-ascii?Q?X4ZkB/gnJ+PFT2fx4uR5RhgPmrwyQsUOPQDsSWtSFfI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612d9d1e-082b-47b2-160f-08dafef66831
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:05:49.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK9CZ+aXwKBidi7Tto+6eXjw9PldWKZTvLOI9WxmGcY5U6JmNpIcm5YxvscjczIz7yhjUiOVMNgFtvan8p130CzU+EGGu3K2dbjIMVv2vv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250152
X-Proofpoint-GUID: IcBZ1j0OaSwGt-kMqukEJkwn7--uYOsb
X-Proofpoint-ORIG-GUID: IcBZ1j0OaSwGt-kMqukEJkwn7--uYOsb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_install_page() to hugetlb_install_folio(). This reduces one
user of the Huge Page flag macros which take in a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d20c8b09890e..849206e94742 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4946,14 +4946,14 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 }
 
 static void
-hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
-		     struct page *new_page)
+hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
+		     struct folio *new_folio)
 {
-	__SetPageUptodate(new_page);
-	hugepage_add_new_anon_rmap(new_page, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
+	__folio_mark_uptodate(new_folio);
+	hugepage_add_new_anon_rmap(&new_folio->page, vma, addr);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
-	SetHPageMigratable(new_page);
+	folio_set_hugetlb_migratable(new_folio);
 }
 
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
@@ -5107,7 +5107,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_page(dst_vma, dst_pte, addr, new);
+				hugetlb_install_folio(dst_vma, dst_pte, addr, page_folio(new));
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
-- 
2.39.1

