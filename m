Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF2623E65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiKJJPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKJJPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:15:15 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448346A6AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:15:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWYB4NZSXahJI5Y5cPXErj/cq3k7wMBR/V4H5a5O+kuUzdQ0+eho9A07rT9GPj9vYopHeZJ53ONnBIfOVm9j5cpc59X0Erk1DuJCfMy+Vqc0s7J13EjtVHT+n+Q21oHRI4CJogH5Xl+dotyWBbc/NSvAUWN0Vr1IxV3DUSsmxzpPGQL06XTSywdAwGhyr9WxNSFGD22olSd6/H58rte0jBJjzSecvPn02sqSciAhoPxYmG9kBu/6wgy91hwH9xGLB6MRaA/pZG00Pl6sJDkeOWc9peg/JWDmsGgI5AXchmJpc59tfAnbE0vkAnWp8JgCgWdU68h7NW/4iQZbpPxsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lolKSnELQLD9UIlg/BjT2W03GMK6mDHzGBgpd0jJKQ=;
 b=Cdu3WVOeAy4TCzdCnoRuksceF2XKTvFgEjZ1dMZv3CPZ2LoLKNad2Ypi+JrtIDxlaYKZ5S3OKggkklpMwuzHJUvXMf0z+Ts0ZGzFY9Tf/VNfCW+hR9XhXuJ/gcwHHGDRqbX9i7XImyXjeZwuEc3CeFS2oCWtnpjYLNunnHrkYPsh9VpOgkj8Up9NqaFCBJt6hy5wSB/zaT+voyMbLKcIePp4Mzg0bY83jyg4P7queXdfwBDI6p8ZeoVlzB8jucV1iux6wn3p3OkcfJ3muF7kmKVapKuJgVx+1z7lqUB+jPTZEFb3fgFoyBrYQ1O4eBcSM2gnRcMwI8qAgBRlXausgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lolKSnELQLD9UIlg/BjT2W03GMK6mDHzGBgpd0jJKQ=;
 b=iGxo3HNVgzBCK5hldEW0XyqyBf00wxDtONnvxVA/Xd84JkZcOgQB98Ay6b6xRyOTe/3AX6YanNGuomfmAVbjyu7nn/cEYCcy0QUKjkOHnYL6fpLjetppUffOSkBJLVBn9j1Wz3IxoOEwoqrmWqxEtmtGTCy+M7vQidV1aCOpSSv6zyC5vVzj8o3n35vNp9faFE8Q2Efbn5d+MW7JE6hICAOkqnPpfYcKwvYFgaqqomQOZL+GZivWWu/uF9UOdCFrrGe2Lr7LwCBZUa7YZEN/Yx8frk+bjPxZen4W7zUlriOcq4AojtR/nVTu3jr5XwgQZ/ZCVwwnerfNHZLWHv/NPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4483.apcprd06.prod.outlook.com (2603:1096:820:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 09:15:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 09:15:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: fix to set flush_merge opt and show noflush_merge
Date:   Thu, 10 Nov 2022 17:15:01 +0800
Message-Id: <20221110091501.546-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: e644081d-45c1-4436-1b8e-08dac2fc115f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9piJ6bUIlh2oUB0U6fdTRsAzLuVj4kY56difsGSkVemf8d+b2agSfdJL7I3pwmO6azEfRxChgkAr/6lDkrDA9t6YPM/VbGpoIoB2NoOgEkvMRrVMYE8bkel2nw1JnDURGa/f2gWW3PYU7I/bMSI0mKL6AUROFQ61R9O+r471QuSna9hY9QOp2rfYoy6yN5SlCB82I7Kqikpam6soYJORjFo5nGyFv6z10iXuytQbSMBfHTUA9OKGk/cieL9PPU3i+WqvIJGP+cPBDFEkspOkI4rtcoEM4xYW1WrkHRVZ2M63kH/6okr3rbpnO7GIvkbzdZ/vbUUsrqM+rcadhfghugdXxMCOARJCw6wXkHoRkRWBq0Ni4yyND3OcgKcs4YSokcSE4wIAUwuk2QFnsPsZTwUnheG37FqTOXAEwa37dOzInwJDHLOYP+shrzDXkHhBkiMCRhA5saAxREPU4+IIIJwu4czqp7HwfNSrfLEgjyrWIJl55I6c8V8ccp6TOlkjrNumhHmeDDl283vBBnVF+vbd/qBHWkGMy9ksOlke6uu2Ts+V8hXKlsdWN9600riD64CUzfopcXn/OvUNo+2xBQA0WQPyEtA26kr9hxYWBYG3pv37LNKzLP1QYmK4sQGuKQftJpGNic+/7SVG6hDT2i2xBRaxBY4PkhZaookLbgi+WkbIw8lXLwU3B8OB4u1GTJ5YJbqpTjZT2YHwazZ8asCegHptw1kHaZ22CSCpe4ZZ3THD6VDpELkeZVE4A89
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(83380400001)(86362001)(66476007)(2906002)(5660300002)(52116002)(4326008)(41300700001)(38350700002)(8936002)(66556008)(66946007)(8676002)(6666004)(6506007)(107886003)(2616005)(316002)(6512007)(1076003)(186003)(26005)(6486002)(478600001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hDooA6fcGWeCZ7pKccdBi+pRonIXPfoD1zNgaJILL1gQ5odw0IFFgQIXVg2?=
 =?us-ascii?Q?SPUpHECN/62neauMk7gHbuSkxRm1biQc22yc6Z+7o3kp8z6aLNxcBK9pUFVk?=
 =?us-ascii?Q?+/XSz3hAR4tRjxBUmFXAuG/LUuqTozM8zw+5qhxF5bfXDKYOqV5XcZCIFCzf?=
 =?us-ascii?Q?qEN+ZkynHnK+8bJHpMG8OUXTNO/9Pi2h8I59c2QiJK+bLYugw1UhrKqjCYSK?=
 =?us-ascii?Q?uKSz/ev57GfQZtb880mAiiXu7COiN8CVy3tnZISBggd7EW8UXCs1HJrCrnPa?=
 =?us-ascii?Q?lhR88xeJOdYoaXbPTwi8SkU3eYoQ9Su40/12VJLBPT9tb1zgFklDCTgBZFHr?=
 =?us-ascii?Q?QkxK+u8nOaY31064FsvGwvCtlfDnk58NWme8jd1w/LHHqgimFRdlVipOW3if?=
 =?us-ascii?Q?M4sf2Dw2kiFLKKHIWMHK1wcX6ufjatvlKuPeYIQdT+yaBqtfQjLzFXysWcJY?=
 =?us-ascii?Q?+F0Te4CZHxHv7nI3AHFST2ADfBTytuehtPl1j3yufPduY6Bi5VuHAPui/h9Q?=
 =?us-ascii?Q?XXuBD+dCTadLzER3fpth7hh36oAIiOvogLdcuKUhyZpvylgeIVPPL44+Yg2r?=
 =?us-ascii?Q?d5WmfDa4+U/8vZ8AIm9DhET8C1Un+RG+5D9lnJY9C3OKu2kSs966j6tP8rEn?=
 =?us-ascii?Q?meNJqoeYF4L/b7TtoTOHVgJ1yF4F07ACxL8LtadYp/dokx4HL8V4NRT6dj6c?=
 =?us-ascii?Q?FEU3a2DEEt/Fxvzjg3LrgDripoSKClxws4jw8nvArnzk/5Uk7qD2CWp5YCZS?=
 =?us-ascii?Q?ACcsWxJoM4ZzroEQSK1lyEfZ2sbBTMQGHYlne/KYhsyWkB5kqYwu6DDEciUl?=
 =?us-ascii?Q?vTKjvdBJt2qMD9dQAODK0m7bPfAa5tvQZ+mvqdiZCAGnPBagSEFALWUUk5++?=
 =?us-ascii?Q?3qiuCUY8ZgnwkwvHi8HdFWLu0b8iy1ANUuKjigZSqY1MJ41S4yU9nd0iFXmO?=
 =?us-ascii?Q?M+t0nSru39IF6hLeOLNAZ/fl3/mak32rznt5Et+6nQ3OdD1I/6LH1sz3/tKm?=
 =?us-ascii?Q?0b6TjQ0OIjR797Nn+FrvGLzhgd+vev0wdu52tvg9LMRfKohrGyjCDJUP6gHe?=
 =?us-ascii?Q?q0spLa48Tu/7KTDxshGYEc+uOsK1fwVMMm3+J/l8aik3WAdx/dL2hguyaluE?=
 =?us-ascii?Q?+0ys9kNsKYEbVO2h5sg7joO6nj9XOp9z8cMGiX0A7S0uXpa7opfDZzif2xXD?=
 =?us-ascii?Q?X4l5RePcG5tD9icMZiVHp5C8ppNmTOVBfDfnW+H604YDFvnZy7tENVFLTtLI?=
 =?us-ascii?Q?R4N8hb7ArtJSdMw6mYdUJhcwdBtMI7CWx4zgOIWYpoxv4cEZwvg0PHghXzMb?=
 =?us-ascii?Q?SxwfT+ZrVzvaPKpYanwPzrK1pdT0mCE5q1+2/8yY4Ipch0dVrB2lLwV8oZGQ?=
 =?us-ascii?Q?yyay6lO5hEMPG+vpkzJRCg6BIsEeGURuuRhMFR7ByW6JiwgO+0k10bfBxDUm?=
 =?us-ascii?Q?G52+ucOmNvWi0d1gg0yBtMIEBkDB2il/R6KXD5o3DTrcDXxZB12DROcj4Yq/?=
 =?us-ascii?Q?sOmPSiVL9T+J2uGSEuv2ApsqwQf2sx1Sk+z4L8vm/BZN6674jQedJYKeIFI4?=
 =?us-ascii?Q?fhDjQWx1hASR5UGeB2veq5/+PJeXtEfswp2bxbLP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e644081d-45c1-4436-1b8e-08dac2fc115f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 09:15:10.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SG0nAmnmJE4QVhfWYTTtUNiRQ4CXxpjRhsrXcRMCdoZLBXbxgXDYKmIIsU8ubm5d/Dlke+xKSLI8qG8dHGaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor modifications to flush_merge and related parameters:

  1.The FLUSH_MERGE opt is set by default only in non-ro mode.
  2.When ro and merge are set at the same time, an error is reported.
  3.Display noflush_merge mount opt.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a43d8a46a6e5..89d6024748ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1353,6 +1353,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
+		test_opt(sbi, FLUSH_MERGE)) {
+		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
+		return -EINVAL;
+	}
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1941,8 +1947,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
-	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
+	if (test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
+	else
+		seq_puts(seq, ",noflush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
 	else
@@ -2073,7 +2081,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	set_opt(sbi, FLUSH_MERGE);
+	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
-- 
2.25.1

