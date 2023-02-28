Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EEC6A59BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjB1NDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjB1NDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:03:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED42279B;
        Tue, 28 Feb 2023 05:03:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5umWN016799;
        Tue, 28 Feb 2023 13:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ww9cW+67AsPP5+4h8UJ+Jr5vdo8JMB+oUDwzUIVN/SQ=;
 b=PjKKxFtSCk/LBEONaL+U2btjF3KnSI+8t/UFtFSkp/MVXpyu/447MGPmhzR9q+jX+GyY
 3nWMA8WPyfOEEhy44nufCmh4BW//2jeVi0TR+oAC/ETzu0co/YecDHIUqXT1lDvMktD/
 O+ll+a50tN0uXPut6xQWs7T/v6Lwjo25yEOLQpJAx71zqcxAdQ0VUEd4+Q67TGaJqnw0
 lc7RX9bA5jQycl76AnwG97aaaMKlSu7jx6fD67FYiZ9l3YcGg7Vpr9KJ0QSJtm4vakFN
 9hXlZPWZ17TByGT+oRG2jnB8tHZgsDWAJX8AasOH16WZWki6+3WJE8vfbw1xKKxZP5kS aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakp6c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBSmsB015883;
        Tue, 28 Feb 2023 13:02:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71n3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIr9UmFUYYJ5DAI1ahGAhEmRlzphZ1Tq/9MbQK/6CIbPDs9I00BtVGURBRliHu6zZXiteSVu/2b+Q8762TVwedS5M/dmJ1NKCe0sYztGjgjLG49At2lanBOM9rvNQvmjqTeGiJKXzs/9Dvasdz0Rc0aSzaOEO4kSnZito/saej5eLHNLwCapT/hUfi8ymPunEQPnO1Cs2eFcjwl1v/i7lbeYnVphfXdj/PoPMu1TlJ4vzjMMR9iVSO394+3kL0toBjtN2iAVf1nD5QwSvR+vkHEEUhza+WFTd/Hzrny46nQ+lMxZoHcR84Z3cwMTvD8Af4COMMtDqxSB4GWAk3nFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww9cW+67AsPP5+4h8UJ+Jr5vdo8JMB+oUDwzUIVN/SQ=;
 b=CO8rQF09BiICha4dYVDH2j78hlLqLWLhdxHIeVCnVQHOLqTjcl2T4Gln/LBstXnklG2gso+qVJGUDTLhr6lQ5dHp9ZC6vkkifIOqjm2jdnxgwLwxzweTupsAd3SJXV9Zr9yog+nCB0/S+qTU1ccSj30px7ll8Z/wHfdYaJNXC0Utv+pq+zzCIeocNh/ws0zC9yt9YmbtjFU+HdVdBIfRu8eyKUbTB7RkW9bxCayzPDzX6FD3Y2Q+1HfLceTYsgi2lVQZ6XLc9AMnUkLee4vr2VHQIwQA8ETfWUcBqeNV0u1kFeIcL8Q/B9ScXx6nrFkq8MGrfC/37mWgFNQsf0jiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww9cW+67AsPP5+4h8UJ+Jr5vdo8JMB+oUDwzUIVN/SQ=;
 b=XjFcuyb49spVOCJ7SJtrfQ7pvwwYHwvAUjijHzroliBcqVIyHb6wzazPcUJU7J98I+QXjooTUm+GoG61JiH7glgLmotWTDhw5DFsMUwny6+whLYOc/RSk4jHrJWvTiXzaawom1h/dXJMg48vy0jWxMW9pwk154Rb0OVU7lDPUUI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:56 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:56 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 07/20] power: supply: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:02 +0000
Message-Id: <20230228130215.289081-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0109.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6be0a6-058b-4202-16e9-08db198c1c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Lir1b3f2eHIQCsWlwFhSCk87MZojEu772nYoAZqvt/MU07/8Wy8zAh+KGli9HLsqfXyA0w4IuiBG/UP3hZ/R/piVJ3UjBKfU/mN0b+HC9lkfVqvVY3+BcI71gl7JWWuB6KQX4sWIsuG+VJr4pVqo1GSVYzRiYNvk8uE5dRASfBM4nqxUusmj4u3vygQOFVSJVnDpgjKjf92RJlQ5ift2qW3xb652ksSJ44qDd/N2CTE0qsH+fy3s2y0rZa3l6gKuuv9ThQUr/LiLeB3dMA+QGjh5A2RDD3HrKSxeFFXSwDRk9v+Xq3U3aIu1HmcyQEmeAa9L1rpWRJDXMcwg+JlAqWoTBJ+HSYFA64OVp+ONrlFgNQ8JSA2ZwRzBlecRs5xv1rVH6cXpe1Qbb2WHZmkHfCuATigrOu/3O8JR9Wde+ve8aa7rJqHWjacBEnSTx0U4SJqyy0FrzU23a+Z5kdhK6iKD3Mz28N5Kdze+UK0HsWjOVm8V8dkDKxpH943oLdzZq99LUQXLPJPy8nc7PXeEu2qSGOculTUMwmL1Z9y8HchFgeKrMgMYrbJ5UttvWF7wZBOXHmKMLveKry29ipCc/qAqY8b136DkLYVEdLEsDQU8z86D4GjZTqp2hTw/AESh8lH1f3Ldxbp8sfC/RoySjpMa4FQFA/cmCaQkHUCv9oO7JurlE5Yw+QK+rfPQzYan+3bUBB+JQL3q1n+7UkMaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002)(241875001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7gL8AwRfNXRa8nlW8FTX9GY6CabV2hxARcI54LuMu36tiZIE2m2/IYiBBya?=
 =?us-ascii?Q?hjcpURP8rLvLPRPKcWTJ3okLYCxcp2cieOIaRvU1swxorcTW3aY71gNblF0d?=
 =?us-ascii?Q?OWWbLL0qW6Q2HdHRiPJUzX++h33qAgq6JaG+jVbJfleKSooo5KMZJfP8Jjx9?=
 =?us-ascii?Q?bZW/Qh6fMwsNKzt0RvDEYm+zvehO+z1Tl25R+t0NBow4Ce7Xl+DfPqMXrOH7?=
 =?us-ascii?Q?5XExC/HscQN+Re4oZ1v02M5Exy8nFAonzhc2sQmh+ReSRvTiQ72K+G7hEn/I?=
 =?us-ascii?Q?h7iDCbjNiTPAbXhVsLBY7Qk7xG+HbR2wRcZBQ4K+ZIbgxcJYEMx7ILo5sVgc?=
 =?us-ascii?Q?n2/1kJTXnsOEH2R0b3sgZIeU6tf5q4Vtm1zkQ0C0aN734KhxdGN38jWO8MO+?=
 =?us-ascii?Q?MhyJc6Tze+ttgKFXnlyeJgzIu8RvqGBs9lYGpgIjkDRSuZ+qtcCrhs1s7uX2?=
 =?us-ascii?Q?8p2Ba+xNJbLj0v0LiNwPqUSncmwbEvdtQ9vB4obWuGMnjP9a5b9ZU9cHaTAG?=
 =?us-ascii?Q?8xPgtxuTPAsjqJ3hnDFE/3d5GECgEwjRr/toIsR1uKgw0orJ+eM3Fu6uSQDv?=
 =?us-ascii?Q?xtKd3QSTBTwWTfJkCqteQjHKYemffbPH0BLB37FDDv1UqgpX4JEbTdk1zhBY?=
 =?us-ascii?Q?tYH319qDKra+2BHQ+wBa2c8KTVMobcodS2SVB/WSjVrhHAfs1nmQKOd6geOW?=
 =?us-ascii?Q?Z++GEmx824U/N7Lb5p9ytU6Hmkneuch+5noHjRWivwmOunbfE0JbWa8v1R+Z?=
 =?us-ascii?Q?di7JBKBfqqwQYYvnh77mS9K3+mZPqs534zA/H5ONfhlzLBIXFL04pOUVCrMX?=
 =?us-ascii?Q?Evl8dG3BJrxGHvVhfCvThSjyIdZcQAMh3I3mEvcLRZdmUe/w9NcUCODnYGgq?=
 =?us-ascii?Q?qE/Cnu7b0uY5rzhYL4ZC97HWH+ta5a7UwJgeE2cJj+CbuZ0E37TZHAytgOPb?=
 =?us-ascii?Q?TG0yRYupC7PMG7/DtyIVyuJF/lTOAZYLdYndOmN4hrqEvZ4oTYji9feVCXaW?=
 =?us-ascii?Q?GHuCexDhS3rV2ZHiPZCDWBMgFPg+VLzuHhaTsX5CdsgFpdny56tybZGzB16d?=
 =?us-ascii?Q?pTAz3KjhrCuF5klDXYVFcki/Hia5IgEwEoaCAXmEfj4TBkJ2zw++5vsqaV61?=
 =?us-ascii?Q?4/tVw1nauNfNob3YSlL4U4yGGgV1lXpzNcy4GD+iMdNqUICy+vlG34sVrKQf?=
 =?us-ascii?Q?M0EKCCY1lQx5/AHpSSMH771+dnhXISPCwSHx7yvOIQS85Q/mrBOugL5eenWb?=
 =?us-ascii?Q?QkTllCHmyN3SgxtRYyKOhs5XsDptHpHkjREHv3aIUkd9pNCPmqTiDZrBlJGs?=
 =?us-ascii?Q?OBUdKXc5FnKtAj5Xo4YgadPciDbWfuom8OONzuzMWBdu8Mh9jU/UaKRsJMC3?=
 =?us-ascii?Q?utoPbJVHlySrrP4d0Sh6eusFxTn+IB1mgnudKLAkDSsiUdDTZAnupqcIplPl?=
 =?us-ascii?Q?dw/NsVSlDNTAnKWQULel2bA/HUUUH8VaTciiGHXwTNXPP80LPeKNPs6raEh2?=
 =?us-ascii?Q?RzfXaC8RrZ9ZSbV98FQBX+QWutny36rBpK5uPfz0vJFigDMaPP+Lh9VLB1ZS?=
 =?us-ascii?Q?x5o3MzpQF14osnk2gwrFxxXAHD/CFR7/GrUeG2j9svjQU9XGKeTypNJKcBg2?=
 =?us-ascii?Q?TEg0EqRopglUu2mQQAQRdiY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ipYjIFEp3MKw2ZllMPb+igPCUKzEQIJEm9qV/8JAUFEXbQNk05+AeQJszaBg3HRJKR91THl1xpwcPsgBfCfVGW0AqSLhxcR7FzzqVRKLyIIXqRH0MbVjlT0OhvJv1kLS3O+Wz1FLSO9IWdEmG33dGDovhei1glPbdjUiB6MMlN+59qNsoMVw3ADPLccGpPq9V2672gxqOcTxNB+fpW7fa1T3nrsJE4KIrLv/vju0/eOzbS/tFAvsDFAergVYYUNsvuyPBR/J8IlOcra4ZejYwDE0khR2Vi2qDP9O0bqaiurA+VyDkndkw2JbuZTxxyiiWMZiTxCE9x++ogihWxXBpmweI+LCi/iYKrza68m9qTuk/ZjMc7GlVVUtocUzoxbZ33w1GeDp+L8yLW0DCSaEYVK5D+gScrf643LQYGnV3ybZu57NL4QZUecZH7GfKvzohexxjzfVClq6Yk9lw24ObrUKA3QRx08yuzEzbWvmS2yZdvn9KAbJwQSBoO9KW3U2F1yv6QKO+hUq0H7uuNcW1CElVFDeEawveUMCHDLPzJgps57J6a4K9gkruL/eYrJFZ+JfikEEvKA9TS0vf5YA7oR3deUs5dGr7vTVbyJV+3H88cPsF+xfh3SJi+M3I62oDiGNMwBsBmLMB19fc8FDVIZlkV6sRtkFldb6rN44RF3xKwwantROSL3C8u+W1S9Ygr67/ZSflR5JYzhWrUVsdQGhUfgnZ7H+Unt8F6EZpTTfDwmjmd6+V2QqAVUUZj3znVd4b9k6TmXJt3bNdZl8RLotiVcfL0pLOwrP7bpYWxPDxNHcHCnq5nZkmVxVXW8L
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6be0a6-058b-4202-16e9-08db198c1c1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:56.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I4+OmwRT1CRlTkFWqoXYRFvIhdyX4XWXe1XJqczLTnqCjSRkYovPHNTlQbZxFKSihMDad8fsgxgemSNtjO+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: Lftj-l6HYfSjb86z2vln-4g1PK3cjbUe
X-Proofpoint-ORIG-GUID: Lftj-l6HYfSjb86z2vln-4g1PK3cjbUe
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
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/power_supply_core.c | 1 -
 drivers/power/supply/wm97xx_battery.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7c790c41e2fe3..411fb8b8945a7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1578,4 +1578,3 @@ MODULE_DESCRIPTION("Universal power supply monitor class");
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
 	      "Szabolcs Gyurko, "
 	      "Anton Vorontsov <cbou@mail.ru>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index a0e1eaa25d93e..f4b190adb3359 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -271,6 +271,5 @@ static struct platform_driver wm97xx_bat_driver = {
 
 module_platform_driver(wm97xx_bat_driver);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
 MODULE_DESCRIPTION("WM97xx battery driver");
-- 
2.39.1.268.g9de2f9a303

