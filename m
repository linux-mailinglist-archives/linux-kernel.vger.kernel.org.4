Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B236DA0D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbjDFTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFTQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:16:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204DC1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwndeTdFLYL/wa3tazqHElQil+0C1rMZGH+qrlVTCfIsLzNqxdyBPR2E9oSNYa+3/7j499ogBd7Oq6Viy08t8DXIA72bfNK00c7D2jhbtpPPq6LKsBZU7eNk7N2opJFciNaF3qOr1BPg8OlruOmaPiLFnWARf7qTShXVUbTsHotPc5hN07aIXxVXQ87GhaABFMEXyfXpJbJy0BAxlAdQ1Loh/hHesXzAzfIZLWh1YTWm0wKV6ZcAbRaaRNGLLTtnw//J+3h9FnPlQNbhUF3Lz8c/svc4dFwRzzL6nF+uVOk7I63onCDuOs7F6pXpfH/P6NHHks2fa9el0R/J/00T+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGKRuEfXxBnhxjicdg29Vd0+Y75IprFSbwIwScu9Asw=;
 b=FdayeYJ261q1LljUF2NKeSs/RJ1frEHdR3WHFUtdWSqQbO4iEWnCVUp1s5wH1Qjoj3Z7Emffh0rjaIZ1SlQ6a4OUE7nPMIIdFBIAJXJzgQzi+wQKG1RYmUAJB661vU4pn9gceAbKg1m7LtyW+h86qBa6N0uxf0it5x6PWTeI9EYHi9CbaVYlFByFpkWfWRdew1xs5x3hhrkiI7tb7fzAJNetfaibbJYWBNZHy3CfFvCKRPNzlJ9rfdGoXYYn23lbPtgdBr0XzuiiOjKt8q1iKGBeoKvxh5k7omryfDoVbYSmHN+nq96Lfx1ccfbW1tGLnxnayYZgkKSlrJYyh4NRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGKRuEfXxBnhxjicdg29Vd0+Y75IprFSbwIwScu9Asw=;
 b=Lv97awEk/6+EnuKbZvlSpfrskOxtjsoEx6BKDQHd1holiA8OSTSoH+bE60M/lNiWGuO6/uT8CWBZFVTntkdAKTjG9O+LvpkiBi3lDZiz+byguiNATTDbuyXjDY3Xgove7w2dVZeawCJV6DbBNK1xcwS3TG5oA+6Y5KOEOXpi5LE9OcDP0/x9YkusnDu+ayfEQ8ehZlig5resLkDGRbTCAmNwZLdQZmBGgmE0iyDvdbUleNdUKkJQHy5Rl+NQYSlOTFGxPQjdsgk2JGzYPS6cyqItBMI5Ha5caqxItCi25jjZjd8dq+YCxRz0WNDXIZtFrUo39PrNS4q+eo46oQaN4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4354.apcprd06.prod.outlook.com (2603:1096:820:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 19:16:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 19:16:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: remove bulk remove_proc_entry() and unnecessary kobject_del()
Date:   Fri,  7 Apr 2023 03:16:29 +0800
Message-Id: <20230406191629.63024-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c93997-bbbb-456b-eab0-08db36d373ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICHg43sJ9+LcWjsFORKnhFEYvD70Qv5m+KRFqSf3+fpIu7Xlyf57TV7jXWXvYBf/MHPA6wOizbN8PG90/birM/IAip1dq/20yxJmJB3l3kEM19XXetZLqaswdSCq4QBxZ835bwsC4xU7ynBZ7T+LkYh0JYjC3kIZDZTdRpCu++QlsLp5s02t+jjHdpnbMcDH5NgehXwR8uWtopjQ5O20+GDzYid3ZHxDuukQ+qrOpawcWEOTGBoilfq5sNAvJSQSlzzLEFhpKE+Tlf7osPxJBJuNMvpFwvd13uw6b4k5BDdKxLRupvO7B9ICbjghi9tieKyXHae2DDPX0nrlOVuOE8VZxZvLCU4GHAymzdNg8rME/aJjP+7nebbip7wpTRfZouKPf5qSF55M1gowuN8tGioZvqXruRFPp+xBMNnZ2lWBnNci9CXhi3odHhRE5XhDcDWeKhuFd5QPPdEznNmtrLL333Lm00f8PRvti3z57BMauwZC8pgqompTU2mmm9p1lFpG0xFHugOtTBtfhOqu1PuHbxksZqI6nN6bX8p3AT/pYIt8TltG5yHZoxtnezfJNs72n37Pnr8b5LvjNRQB982i5uKYIs9fs/YZRZXYEgF+47/nZuUGEpKXFPdiRY+F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(36756003)(86362001)(110136005)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(52116002)(6486002)(478600001)(5660300002)(8936002)(2906002)(38350700002)(38100700002)(186003)(6666004)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VDLJC+tX6LIC9F938yiaWq6mIh36mb5oRD/c5v4i/ddFa6TIFnFTtZ0qEBUh?=
 =?us-ascii?Q?5tnwNTL5PLvjQE+I6F+KExP1TpueJn5sMZQfZ+76fdXl/JLNsf9wRDls4E1c?=
 =?us-ascii?Q?CZCrgT8DycV8ZzHJpm7/A37Y32InEa2iVyxV3XRFIv+ealdLWrVmj2knQGhF?=
 =?us-ascii?Q?WsV9SasPc13MSEgldfahAJ9oO6cax8HxBFc5dJFoiKXJBeHXN0KMtgH4W0yP?=
 =?us-ascii?Q?LyZFfahMzLxqLW8l4d341SvUI8AwuKEsBjfNxlsnkz/Ezdf13TCSMj9Ggl7Z?=
 =?us-ascii?Q?Q8gMtzkCqTZNo8857UXl8aIu1GVChqiEqo2AyVnTm0X6FfA0B4VCu03m9Uji?=
 =?us-ascii?Q?8s07umkCORFibDtji6Tu5yNCbh+B10QDDdPuMejyZz5WtOc2CNroqKGY4Zeq?=
 =?us-ascii?Q?jXwchC9uroPWTV3kuvd2NmgFM4rxCfBQHBL3nnUWWL9tDnM91yU/egNHo/iG?=
 =?us-ascii?Q?/pbwVCOVMSdB9UU2JD8MD/aadbk9O2q9cX3fEs8cY9G8wjE/YxqB6DCf6fKi?=
 =?us-ascii?Q?Tg6aFpxI4RIj6iMr1im64srtEEENGeJ1Zt30VOjR/LXmFIwY/dg3sTVn6zAd?=
 =?us-ascii?Q?+PFneQA4DPVIPnaaD0AkHlFhev6FvO6qZsiYhgLB6AEYwPYdGwAM/TMIJKla?=
 =?us-ascii?Q?ZyvvCLYyzUDgCCtDVw7MuFaqeGHSJ9/R3Ch9NV7DblpF/Ra5+QhmxwXaRv26?=
 =?us-ascii?Q?nL+IZ2S/5s2SHx932m4UV0oCTieMSsAjMm7HaciUqM0WDIoVk5T/dqlRBfq6?=
 =?us-ascii?Q?oI/ZA9RwmDroifiOJBQg1wer0jDWiaSo5PKj1t9s9IPlCpRHWVBplzANnEUj?=
 =?us-ascii?Q?OtMN5cr8HN/Yqqaf33I4bQwsxXBIBOWPSmIcJqiqB1GX4po8czwGY++7oNd1?=
 =?us-ascii?Q?FPpL/h25TIupgtEf0By5lxqd476p9HycQUNCX4Ngp+EtZ4VEJX6MMwBCzaCh?=
 =?us-ascii?Q?U1gF8yeLpHg51Lk5lR7BSN2xJAdvU6Y3pG5JQWjGfTvEBes18VpeWCvUwfPS?=
 =?us-ascii?Q?hjVJdAiqCJOw/AU929RKjUgIFAZw7YlLNxDUgAasLK0O52RAO6F0V6Kh0Ogr?=
 =?us-ascii?Q?ZVCpIyXbK5jEehYqfzOt8qZQC5+gbiNZIgSpCwMSIDZgDiesXXb3cYMYu/BS?=
 =?us-ascii?Q?F0aqZSgq1A5lS1YH8WlECUZaSd9GCRmhVAGsxZuFc1EODHX9LkQ7nopHKamJ?=
 =?us-ascii?Q?x/3hJJsEo4MvaBNyEdBLMFIO+14lLHZm3Pl/f0m+1bqsIJ/n1CJHX15aQul+?=
 =?us-ascii?Q?swGqw5VJH4NwVcQNH9DXXAq5piVVy4mHbBf84/DkvoQulLzd5I3aBZ+X10aV?=
 =?us-ascii?Q?crFnOyJkRbzLf39gYpBog7CtmtC46fPGKcfp0R0QNtlQlpLtSiFH39EUS61I?=
 =?us-ascii?Q?n3knAUagOLAvSBnTO2kSjb0kL3koAOVIiAlJhUsbbkOeaDh0ykDvi+t55waq?=
 =?us-ascii?Q?ppFS+twY2c2ASVmIxp72PIZFpuatvM5mQ615mKpXV9rvsp8phrwwgO19mT+Z?=
 =?us-ascii?Q?1v/Zeou67rx2Urydt2uf3VBPZpl5wAsB5DPcniff5vzEniviQcHFUN7Y9NO1?=
 =?us-ascii?Q?9a01lPwm0rORdfa4Sfk+0fpmq9FY7aVGGIiI0YH6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c93997-bbbb-456b-eab0-08db36d373ab
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:16:41.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTWjOcyGrTGu3bbgvu7uA96dO+fiRYD8MlMTkCvo37OwH+vqFla/yjpvu5G3n957mI3LEZxfdd9d11Eq9xP6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4354
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use remove_proc_subtree() and kill kobject_del() directly.
kobject_put() actually covers kobject removal automatically, which is
single stage removal.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dfbd17802549..3aad3500a701 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1461,25 +1461,14 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 
 void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 {
-	if (sbi->s_proc) {
-#ifdef CONFIG_F2FS_IOSTAT
-		remove_proc_entry("iostat_info", sbi->s_proc);
-#endif
-		remove_proc_entry("segment_info", sbi->s_proc);
-		remove_proc_entry("segment_bits", sbi->s_proc);
-		remove_proc_entry("victim_bits", sbi->s_proc);
-		remove_proc_entry("discard_plist_info", sbi->s_proc);
-		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
-	}
+	if (sbi->s_proc)
+		remove_proc_subtree(sbi->sb->s_id, f2fs_proc_root);
 
-	kobject_del(&sbi->s_stat_kobj);
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-	kobject_del(&sbi->s_feature_list_kobj);
 	kobject_put(&sbi->s_feature_list_kobj);
 	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
-	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

