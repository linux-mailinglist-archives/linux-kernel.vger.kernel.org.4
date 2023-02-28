Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51BB6A5AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB1OQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1OQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:16:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B40303F1;
        Tue, 28 Feb 2023 06:16:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S699uc015567;
        Tue, 28 Feb 2023 13:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=k3VoSFFXACdl6eeQw83tcfL6q0OiW9Rd2VN2dKn45Cc=;
 b=FqDgJCYL4jBSSPSSwa8LXEtUJ0rANV8tjEj6Z9flp7Q6NhOOL+hpgY3pbJJf77g5IXwT
 l6Z8e/5h/EcFoGzK72TCSPpJKhJwNC8/2CQauRyza61g0yLhVA63t6+xhqOmy5sg6Lgy
 xyWZ6UkhBmM04X/2aiCnQVjBmA+MLvnF2YR8MrnXUfdAlY5cCJ/R2wli6aMH+x18Aegj
 8F0IVG8yTCuHfH5UEZDPXRpW2CXvKhvM7+7Hz3vYnVx7PUr9GU+7ko6j3IWWoP9XYZo9
 WgLWtVoOx08jOqGMsjnYGtQB3ndGVcsb+ygXtvyRawlV/3JjH1QnoiWGtrLOu5A0Qd4z pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakp6cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SB61G7031525;
        Tue, 28 Feb 2023 13:03:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh7qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlItZKZ1C+hlBYgiTRT9/u8JQzCiB61hNawiGVuFBM+Q9ikBVctjKDKTnkXkQvMUfBIvF9PEhYX3thTGVXtzg7exuUM2szNB8H81eoQH8kEaBG/PqewxIWME4HcXULxw0kwKGxlpQIC9Wds2UyDGoHymZ7lFzNaWHx8c1fUechcFWn8w/ieoYkCA+CdhVBqbsNxGKc86kO7QKQ8KtwcFAmEEkNIa4666BuvbA8rxk21dZ3AkTYJAwxPPdJv0d0FRB/XcAuGqq83Odc9ohzfAJ2rSMGIMaGhGrnN/jBG5Td+8IKR6Q9VsoNe8RtGp/3OiRwvw7mca9TbzLJhCT6WW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3VoSFFXACdl6eeQw83tcfL6q0OiW9Rd2VN2dKn45Cc=;
 b=CV/KOob5K6fvf0cLPjl0EC6AtXUqVqEjPNEEm/y7MwpECTLIeysISO66OLzuzP3Kx0dr9OoVy/qO2mSioAcccniR2UBV9fYTvt3Bn4OarjHyqwDRCJdfMBuRGebCeLiXoWLnunkTpzHfGcP/zrmSISmjJIP2fBtScJeeYOf5lc89fn3SYJFSpJmOnb9oNbBh6Lt6lzK+lYKW46R9TlA7zz2aYJgpvBfsg8V6eVJIe0cpYi+1zTnkSpIwn0um6vL2Qb0g90rcklLL+oNVaMMyPs/lMbKSS7JGsiFFVXjm/0sX6F/YZH5WMnE/L7Tfd8my9PId3hY5x8kMg3dLf5/ldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3VoSFFXACdl6eeQw83tcfL6q0OiW9Rd2VN2dKn45Cc=;
 b=mA/iJ6NSFlzJMzdDVEjKhk5GyTyee/fv77jjwgToYwHIWBoX2hbFrOCrgZbL0Abx3NH6zW3qVyDVFDo1VeqSd+2BhRy2MDdyunJgL3yrRe3zMIDKlInai5ivSzQeANLZf7vguWczRh7JX4nIvdaPVI4bX8W3fS9xTtqgkrznkIc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:15 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 11/20] reset: lantiq: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:06 +0000
Message-Id: <20230228130215.289081-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9961f56f-d85e-4373-19cb-08db198c2733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4H0hTQJHQNzfUKjeMd4xKTBGMrP8AyifVPowYfXBKR9D+c+IM0UJYtLE1481+oz9/dF3EElCyQkdn78XQB0gDY9Ni+Pg7V9tuicGZRO07P+ERoStudfpx1c1qr59cHS/SJK76/DPRlVYXDnCYTfbGNwKbBefmAKSC+/5Xv6sCHTAA6+Jbes5gxsfNdib2LjVJ7Z3MAidJSsmHytxNUUGJ9sI7uV7q6SFcCz/VjeTY7+svsCwYo/MAJrw3y01HmRlsQXguthg5MLikIaqO8fLgpQw9yEdEUkDHIiSBYHKqdP3ZFc2P0ZTWbHUackmopIOnaKk64zdqUeY6SGQRI6sh6oHVmdoonJFi742rBZkIF2P9zNkcqELK9DO3UWJXVSD1e1IFCQxzw7PVXvBzfqoYdZOD7fiqwFsqHvX/iM/OHkTak3DvPzSiGmtBJQsbD7N6vdhQBi4PKGyZRfZ/Pqu2NYzLFfDbK+rLCiX93zB0I9UxERvxhoEj0k7AgbCuphpZURQeMCjz70b/lTajfNNYIdB0XkLak19c/UKR/FmL8jpG9KBb3VMnwV3AmbWfEUdV8a7xR0ngOZ1uXHOG3mqu68ueu5uSEM2BKCwUtf4Ft9xNt5C9M2zqjpqQwV+A8DAFMTn/BpZlEC7VVuq4GcA3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4HO0OeRk6EnVDMA6k6PRWD1Z8CtxXO8Syihr+FtEv6DZlsU8n5Ej/8uRGER?=
 =?us-ascii?Q?QH9dPBrC7XPcjmst7nF8kcKWO6Q6vVeFoQ9l10VUZhTEPvGL0jBlcGR5qVhj?=
 =?us-ascii?Q?zMvZBzyYSODVNSNR0BoMg1LDGruL5vgiWRSum1RSKsqxrUZAiMr26LmzeF5I?=
 =?us-ascii?Q?fiu5U2qiyeJNAOv3xwEu6wOGsKg/fRFWNRboo2A98m30mO7c6+fZHBMALSA5?=
 =?us-ascii?Q?YThq/AZ+XsFi8ku7YXZYuN7JPgMoNZBowuq5bx+3TZ7Z5NRTDWRk11Q7tLoP?=
 =?us-ascii?Q?QNSO6UYUIvo4QXMmklDWkyysjayw3tgVioi26tejpjifQbNT6DLPPZU/Ticu?=
 =?us-ascii?Q?ZIwfdMaustOGIRL6Lx7tg6fCAidWMVPe2cTTsoqlp60JKswvI+RX1C3zr7jQ?=
 =?us-ascii?Q?YSgun3zCvalf3OpGE/6e5+BJ4Z5unHeD3ogbfL7RLE7UvP828kKZa7d28Vxw?=
 =?us-ascii?Q?Fx/FIr5d1is8MdXHn/UvSCzvVCO/KwvEHVPo55HfJb5gUlC+QF0lt07B6HmO?=
 =?us-ascii?Q?wg5eNPbMY9z3lG2dMh1lKYxuhK9Vf5SYOdp60Dw0l+z3TbuI76B6/QU551Cb?=
 =?us-ascii?Q?5uv+6uaFVdOP5h3S7TZv3Uds3FUAttLL0/sd+E1IvstwEkw1rmWVKHbfRR5Y?=
 =?us-ascii?Q?nwuLk7ctpWqlEhpgpAAOVk1yW9OUYfeBHpJ+OKAtHz8pdsRjkGpr8XRCi9sL?=
 =?us-ascii?Q?j59UQp/JhNi7+wQxxr737TIRvf8s2cXuXppQJQ4lSxZ0Y1lnYbkl6QD2N0Wz?=
 =?us-ascii?Q?eUqkeDSSPVE88q3cp/rYShhS+RAgE0zEVVMuH8nNPZImK5oGP5zqkKLQ38fw?=
 =?us-ascii?Q?8uhnr2A3cBPxj6vEzRJAyMIsWb8NBkSzTym1XqU7rTLI8zvJZgRKqYtvLQmx?=
 =?us-ascii?Q?tn4Jv/DzHBgSTC3CJbX310dtrJvQehKu0GoUV1D/baJAxRSPxzL7iKHHyM9B?=
 =?us-ascii?Q?5j2+alhLwm2NSIPzjkNpbHCBzJhVYlccWofzgBaTiK/Rsz9THr1yf25cbz81?=
 =?us-ascii?Q?kOSOgyIeehEtVIyyswgL1cs53RJnVKjdXOaZX7XYpOrdNwgBfyxIvYPnD5zs?=
 =?us-ascii?Q?8rEJYFwK2PLUTVg2Q1C5SZRYm+ZiOK3GQZFBpK5NcJSh173guHywdyfA0nNp?=
 =?us-ascii?Q?WPWnel/Bsqs709wLfXbdPVRNjxpX6OyNZE5+XQ1/NFPN4cfzSxo+ILS3qw+I?=
 =?us-ascii?Q?XMMRjK+KcOSCGhRZDAnhaWgPEDAZCTYa5a5YgBPU6KMkb0MM9Ch/VPJOyQ7Q?=
 =?us-ascii?Q?OcbT8C9EgVumA30BXwLGDkwCi3+07MihRjKrhomht1zCYIHSykMXe+ckW1lS?=
 =?us-ascii?Q?fh19Oj6ULtZfJPoharxgg6XKcZ8/pGEeFbApJ0EZ4857PVi0JjHsElkxIea3?=
 =?us-ascii?Q?5OgYMRYtSCvlBaYvPnUvLtKBtEoMT1C+MF6BYYGvsJNm5oFwFzo5u5uPN0eZ?=
 =?us-ascii?Q?UO7XZCEcQYtR5rYwnAAHVgO1p2LvAWn3H8aZ0OpDMCNIlQ+R1XEKJMJ8NHzk?=
 =?us-ascii?Q?Qqs+7NvA/GLKFu/FpdU8e7uHGHcRkOw40xUhf09rVOloNnbqWL14qWn44VIj?=
 =?us-ascii?Q?Gnkek4x1b96CMjORKYkIq/Ir68kz7tC6whJvCeyqFh6VKLdtiDkrY0H72laD?=
 =?us-ascii?Q?St6MYL/j50jcDqeOKUNqa0Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5ZMuPfxIBO6mKx4R98Q5fFcmU84L1pJ4hdpn1LxAswI0zxzghH30yuiB3BbOTXAuUxJ0cK+zVDcEsaZIuKC5kI3Sgme7n9MqwI11gsN7SsVrUTjNcCi4haPS4UcJRtlfU2nVDKCGzsimxX+1ZBeqW/ohOljP8S1g55DYTtFwp+PlAwH399uWAU1HRx8t4pwgDo6Zd09DeDjdUyoBlvsBkcI+pmPPq+N9byjQK9UdffdzBgFQyb5z4OxjP3BvBkiNRsP2hOuhH73iaujUcgtTU1CU7VfSSkv7n8ig6/8uAtpKtVvdPnRdRbD61h8WoLGOLI/12t1/IxUA9GYwo0Fgjh/AJVhFQJ0k40ZEsURATHXjKMhBAjY/miRCv6EXxRlYdPpOefdtX/c51VR/ViyzVqyTFGbZA8LqLvAlBrfNROHrUs/Rt0thxsSESe6nCbW6v3zyHxe7JIkp86LlWUseXQngMI+Sw3msUjwh5MCZ3ncKGI7e3zVjFDRLa5srXsQ7WlwpBrUNimdYVVtTxjqYYE5egdjwGLdKfiy0+5c253lKSkfJOtGZNY3URJLr/gFJSpqdz+2uLl7KcFWwSU9iq6gB90Ctr9qZd5AUOCnX7MAup2231FrrQp9NC3odVpcQJKSp6kJxjWggGgZ1z/kJFgMn0FNJcrpKf8n+EueO8rf+TLhZ5rLEaxMHpKS62D4fH88unCm+tqvyMtS5IyVu3Qd2U6UzoFIzDFinQ0EBicxChGfpK7m2uu6hpcvmjbSBA0D+waXyWaxsqT29DVIQ6Rkyr1SZQlhFvuK2t/7+QvqdCHChPbNTqOBbg3de7vMvTQ7AFBcpl8/0ML8kCbnQJChhz8hWTUQnj6XxTmI7EWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9961f56f-d85e-4373-19cb-08db198c2733
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:14.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok9F2D1e1Vl4+d02sKvzyiITed1cNPOfm7YNOlEhFNv6LG1Nzs4XqJErXTbBbK5SC8LgYOBn7P1FL8uft8LIkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-GUID: DReVjHQi8o0LFWof75ZK3UnutscopiFi
X-Proofpoint-ORIG-GUID: DReVjHQi8o0LFWof75ZK3UnutscopiFi
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-lantiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
index b936cfe856413..549ba45d85971 100644
--- a/drivers/reset/reset-lantiq.c
+++ b/drivers/reset/reset-lantiq.c
@@ -207,4 +207,3 @@ module_platform_driver(lantiq_rcu_reset_driver);
 
 MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
 MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

