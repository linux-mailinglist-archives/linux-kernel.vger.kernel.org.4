Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6A60E16F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiJZNFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiJZNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:05:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BBE96237
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+hlB3fMs2GP0dcqm9qkDQqszSu1GXkor9edLeEriV02MmtIyBx2wRqzj8s5MOsaw2TMkmjlmSlrikYhqT6hEXh37stSMqWiqBQjBsDqAiuojbV2e9auv7Fp5sWTfNazbCGkmTpbEiIlERo7oqcXRPdKBS9y4JG9n7MWveL9S36fmP8kqLwvPuaDDCYbZOp0GRnoGN837VgeRBMwQ7qSIL+8kQtNJzxSNVJzStOhls5e4QxVnf1b7aANVAeuIxu1k4ITk6FXp60lHWnnQNFddnvwTlw7oJEnIItR1VcrtrzFcdHDv3Bfur8KxA4AwR9QxhRU6wc35NTYgPf0twpcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQj9zU6J9stVG65pDW/dUnRSzWKyXsTSHVv1kwMaw/M=;
 b=OJS7R5rI1cNKkHpmwuHz32ECfp2lwc9r92h0BrZ+8xQ6kpfNOossizZC0XBk/xdCdHfO3uhWiS/KROkKYWPceFcSGcLYsO9Pb9G+KtBRMs/kszt8wwWMMCbGm+O1br1Q4b5tnFPWO1x7lE3ZKxfqntrgyCFuxMruu8zkSIUxzjZBDRExTv961SHdNFioqwN5KuQVSYm+lDE+wE8dYEYoVnktXz6oo0HaVJHi9X8eHXoEUlxZUqAzR9dc9FEOj3/dvC3O50+6iHDLM7mvDawIx6t3nJPlx6Et5AruSELEX/r65IjFOeDJrlyzZhfQlgMVIu78L1cURaYpS8IuC8Qatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQj9zU6J9stVG65pDW/dUnRSzWKyXsTSHVv1kwMaw/M=;
 b=MRPiPJU6MlEL6+1OHXfXE+fEURz3FmP2MZgNjVbICi88Ueae/trx3OmE71WRHMl5512BOSWrgRRHXkwI6sVE2eC8B2iJo27eK4cndtQVSTtIGpESsYfUAh9qe90Jb6n8HgGOIf08zjxq51pUeCZ/Fx5qw6PifoECNYi/5+Qr07nos8IKBYJPioUvfjK3VTswzzjs19L/ny9l7KuoW94DJNIvp3wMKvjTg1tNznUt37u+kVlQY2gvViHPsPonsfdFJHqjwIIHWVoz6iUFX3X3EFsLtNtT4C6pSuvE4MESKgCtJti2iO8eHqr3cY6HavXcr59a5s78aF+fLeY+YglsYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4035.apcprd06.prod.outlook.com (2603:1096:820:25::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 13:05:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 13:05:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix to set flush_merge opt and show noflush_merge
Date:   Wed, 26 Oct 2022 21:05:04 +0800
Message-Id: <20221026130504.26312-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS3P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc83f7d-ce77-4818-f0f8-08dab752b869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQSpToXVzblXwPVBjR81cTvwVlVl6FJKuR+s+CfFro6d/cKdAUt1c1AWuaI99zFaMHoxKJNvOPf3HmPE+U0qNdYMADGIcLfKjMQdm40BHE4koAU1/vsMgjrFx6I11HVKwnBNelASlaWbnufNTMeggOuz3glxIoj2I/b0nVyezCpu/WMrd5V+kltgkby3j51Md5MnR6mqu6vQJ3xCrDEelISA6iM7Clb39f8s+iMWU1XOAjOmdOpuKbVeJMEEi1ourvgj7bV6maVWaXo2NlD662kcIR5fEuts8oqGY0mbpTK1uhgpaEb++KT0zW4zuQvtcqjWMKsX8iYvHfG7c9vMGsy4JVB0WNUPDyuqApN01P/FBKmc/V9Esq4oz9YQgVaAfDOmlkf8h4eFn9JCBZ3WMxW9j/Igbc/q/R3FLrDTi0YDN9xfM3GEzDlzqu3fk14pG6ZMrm22biIDnfkqXOfg2eIWpuHYNZF+2bEC1bDftupLAOZ/WPXic0KeAMm8PYgXhCGkodrqh6/u165HaMp4hOska5UTDfEIFO9HFz7btnm8gxgMBZZ+jChTOdOCiUOloRX5lGv0fMYAAvOsrMAgxoRZ8zxCkhML/xVuH3lwtiZHaPcg2x2C2Qi+RWQaA3fCukZupDXjy48bGFeiGYeC85eYb1QWPx3fnSy3s/45ueeegDJdZ8D08mCWo7vexjyzPWFlD4WfxLQ9xGZShAY5nOXckEbXTcFm5ix1q9LNWYv88OTvo8pmWItUK8EzwLisW2zC5wUE690zyCJQUWngaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(1076003)(186003)(2616005)(107886003)(86362001)(6506007)(41300700001)(66556008)(4326008)(66946007)(66476007)(8676002)(2906002)(36756003)(6666004)(26005)(6512007)(52116002)(38100700002)(83380400001)(38350700002)(316002)(5660300002)(6486002)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qz+MoOjhOcRsfcFf/lFMcYB+Mplkc6c95hCZ7kRKlIfG01lgUpqvT8lvWCT?=
 =?us-ascii?Q?pI+yM8a7GkmB354HvU4CWQ3fza0GGjQWHSBHbe5PQ6G4GHwNfR8VjyIeA/XX?=
 =?us-ascii?Q?HeUWdkvIFD2MFj4ojvrxsNshHRuRBF5CtCmEcENFWb+Dixu6BGSbTF51dMq0?=
 =?us-ascii?Q?FQDa5PPS007t5ksPP971CWhMhQg1c5c01NN4VsOjFujY3iUfp9OVViqK8qhO?=
 =?us-ascii?Q?euOk8u6D5CwCJhlaS335MKfy6cpLQz8VFf0NhI58FpiFT3QFHQAq9NnNG6iw?=
 =?us-ascii?Q?Ix/zjOswqse/57ukjJkQbKPGZoGQb9Xtmsu4v3THmyuxuCp+25xQI4R2z5L2?=
 =?us-ascii?Q?wCar3A8Rbwc9ZhlH8SJfn2PTzz3HGiMNQVyyItPWwI12j1Y6yBJs6cX8LV4R?=
 =?us-ascii?Q?BlpTObq3yeD5tyG5mAhHTpu2XBXLSJsp8SIE0ZVlZFDKIDwNl7Z4JVR04nxr?=
 =?us-ascii?Q?fI5d4Wz5RzPNokdlFid+a0q1elnEyw+vVhW1doJJiWigmWUvGFv3YyXMn49I?=
 =?us-ascii?Q?ooQ6VAWi56g1HH33z9T66NyeT4IFCaCsdv/3wKXDmB85WQFQW+F3ae9f+Vy7?=
 =?us-ascii?Q?COTn6SdS8ufh+fZeo7M5cX8pG1P08+y2hezfgGBuS1QHh0AGvDJM08ZXD7zb?=
 =?us-ascii?Q?PaJXM3caM01n/o5lPE9PT2NqDGO68oaib9vKTNecCsepZrJI0jz8LS3504M3?=
 =?us-ascii?Q?GqwAKy5+qlSNzgtS38mBKLR9d+iscWM8ANe1ztHSAc2oFi0dAn1tOuMaALlf?=
 =?us-ascii?Q?5aD8JlPdRjV9S8V42Js/rTuhlcAJfO2gU03wRddg934fu5sfnobBbp4gP4u+?=
 =?us-ascii?Q?B0ohLOxD9QpcPtXtyaCJwtdSFbb3lgpvP8u0+o6PHVH2ekGPPzvy6/no33Pu?=
 =?us-ascii?Q?JlyY23CPFfvqPA0Nx8SKCAwGOR6zOVf/7YmWwW90Fu8Ic2j6kREZcI5kJvLR?=
 =?us-ascii?Q?Zm26AWTtzAgTPo9/F2uJnOQvuJUaVOZA3E2oSYiTcHwPy65cyvPMnPn/l66Z?=
 =?us-ascii?Q?COcGrzGE8scbizMEg3B1qEYzw3HQLTfY7QetC3sND2fNRH1m7chyuL0DoWku?=
 =?us-ascii?Q?4gzxBPGKJpMXAAuRK5bt7NeNjy+SRzwKVnYs62pFlgkfY6mBFppumUFoNd90?=
 =?us-ascii?Q?KKAQt/NaWlbDDNkRMoRH2afHoTAjzN2Y0S60bAtro1+Unemk6rrzBhEng/XG?=
 =?us-ascii?Q?Sv+F5IXYSdiTA6S6v7DHU06IAvFIsyMR9knym5Um9ydUMOL9IUvLo4WU42jg?=
 =?us-ascii?Q?lFsICooiwhwQDRuoNa12uB0ub3e8HloQIS01+NvMXhsrLm64SOI6VdjsqvDn?=
 =?us-ascii?Q?SAKkZAP0P8YZnDilR1is8jW9fKlaF+vfEiLxxsdVtiDCHPbjTlY9HmiqMU4M?=
 =?us-ascii?Q?gN2Rx0izA8J120UZjMT/8Y3t3V4PP65Y8y3L91YCH6xH6bTp3eeK4cPDW3je?=
 =?us-ascii?Q?Bw2Izd5k5bbsPD3b3qOcZ2y+TgsbeJN+3cev8S2vn6g+JovXimJbzmFSSrZc?=
 =?us-ascii?Q?cTCg0dTbOU6IC0GOsT5tY8xzNMW7Zt6oQ6MlbCTI+3OhNHqpdgbOvF+Qq2l4?=
 =?us-ascii?Q?9439epXozYSv1yL2dJzo99PuzUSKFH3u3NsgPFUo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc83f7d-ce77-4818-f0f8-08dab752b869
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:05:13.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BroLWJ5lh+YZZPH8uOLMEi3qoPJurYIlsRH6Ezkro+ABcTEy6G1oMTCkR5aBfN3V4NKF1ky/KYLmPucR7htXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..475fa10c6007 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1347,6 +1347,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb))
+		 && test_opt(sbi, FLUSH_MERGE)) {
+		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
+		return -EINVAL;
+	}
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1935,8 +1941,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
 	if (test_opt(sbi, FASTBOOT))
@@ -2065,7 +2073,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	set_opt(sbi, FLUSH_MERGE);
+	if (!(f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)))
+		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
-- 
2.25.1

