Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B8653CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiLVITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:19:10 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F010067
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:19:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrwAjoEghr61A2tDSqwfA7UqbckD0n8Cm6Cjn+UjK2ZA2w0kTuJXZCHtMIgENNfSX1OEHVuHUK4LJnm/GMbt2VXbZC44QVK3VGbuNX07sozt3q5wfWIe89EzW7tbqVtUqbZb3rUtiwMNxG00/4s9ON5bL2TnrSfYWvGfCaPBPrI6frWGiDT0zpseG02h6GXMgA035ZtVrt2Pl+aQfbyo3E/gUyca10Ei1h4wdgq9fJr8GBnzoBbXhwylxvphSRK9UxTjwgZDo7+DwVkhD6xJO9XY/G47pZOAfQREMl38LRFwuhN2DvkRr8AUJdhFDyaX1CjdVCxuIaxTNudUe1wbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6rbzt6PNOYtXfIFChp7Ox5pFWGHtIuFwGv0WQS4m+g=;
 b=XDwqNPHzST6/2lhEHM6vH2vxRM4Sf9zSLG6H2KvBpY1hR4EcQuOb82x8PWpx+bEc+8BfblhVHMTc3Pzh20t/wg7xmw7Obz62NMSfc2ts0jwj/YLYg4w1UjpBPSArmwwSzpyhXVWvCDhAHwb8Aj4hHquDTwgDb43KgMw7pRmjT1P9xWpdv2FS1nQwyE3e0b5vy8n4KuzzHemeCO/LAi3RdrbSnuApJKQRhSys/ZHsR8m8xKrVmSRoJ7/dmAuEwFVu2BPcglqBAzgtXcFuz06vihu7qcoE5JScql7PvpuvfIDiwsjfIJ0qg+JOsiqii+YTqO/virItuqR68Lv6huOhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6rbzt6PNOYtXfIFChp7Ox5pFWGHtIuFwGv0WQS4m+g=;
 b=BkAfJ5X2jkSaCJOSZzjlRrSOzMFsHi9QddN5ICGFLvTID7A5WY09KIluwqdYkGHDFNnrRireSjT9dAze8LZ3ni0fXOfdMr3jt6UlvAaHpBd7k+z2h/+pulc5W/lqKgKFj/eV1fwK1jcE1TOaZCQ9LIylrWwG9sXbMQl+AFMzkgnBdfyjnW0h7raLT5IG1V5E+qX94IBjz335EZv0GS1/gUvBFWLo7vuyD4MEC6dkq4/pelgGxRa7OGRiQ6cp3kHRxChwPIV2Ns3QtvDKMQocw3kZJsUbdSyHnIcFsM6CXTNd/rzM25CmuoQuecq3xeu34uDd6pUGiHPqT3GVlIiEOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4280.apcprd06.prod.outlook.com (2603:1096:301:85::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Thu, 22 Dec
 2022 08:19:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 08:19:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: drop useless initializer and unneeded local variable
Date:   Thu, 22 Dec 2022 16:18:55 +0800
Message-Id: <20221222081855.81553-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1713597b-c6d9-42cc-b0b7-08dae3f5312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PoAQwXJjMqxGW1WulXD8DNNegTLcLqWYhA7ZsyZilheEqoCqBXGCkBKYDZOhisx9CutS0qgry/D5d07Bg8wzRwIF/+ro6xbdviaPXIgTFKAJyTvfvq4PCQC4PfF56PvwPMQETvtc7X2wAKiBApFcjHdEycK8YiNNguoZinnqtj6on7qhJdiCph2yDgtZ4GKYftr2YRIzpNFZGCcyfZjHll8lYiphAFTGnGowfwLtZAUnEO7CmQQV6nLf0/svdUHnXPGc6U4dRkIUpdm0IDKdkh0j16E+CvwVTSdXCCUo2lZF8YmZ42WYafmb06RkHjJzdmtj8w2U0f4Dm4Ro9fzgSM4yUsLmkQKo4dJduOfXGTjAt6LQ5bPYhVCZ0j9IEEroI2rtz75kl8uBUxBVJ1PZ26M2cE/ShoQyYKdQdG4s08dWAe5fOEHUBvDvTvRdWLT+j+xcdhEc62y60joH0v1dUTV6q2+bXa+/iTO0gY++cw0ihA2BYvMnYyX6Met50cKtTFiVueQOVnHEilFkvGg86Z8NCgUw6Y/fIfuIwMNakWb5eg64iN9SsI/nPAnzn9Xu28ttyih7W6Ad7JWsMWCdBrbtj6J0JXW7FjFkvxC0d0z5J2DyUxr9NmACoEAjTak3mhVEf+KZ5jEaUIKCfZTQ+zdDQNORqM3Uq2cB4iu5LxieRDgEulEfxurYTLpx0wPZMBtDdqxeZUqmjgpUjJitg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39850400004)(376002)(136003)(346002)(451199015)(36756003)(316002)(8676002)(4326008)(66556008)(41300700001)(66476007)(66946007)(83380400001)(38350700002)(38100700002)(86362001)(107886003)(478600001)(6666004)(8936002)(5660300002)(2906002)(6506007)(2616005)(1076003)(52116002)(6486002)(186003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cq0HoCfrIssMpwj4vOMmvPuRBe2Cs597OJ4ByWid+gDLmO0nmORxMpmfSutZ?=
 =?us-ascii?Q?Dfu0+Bw467T44LBUoPfTk6pmFUzmzwahCvmVRaAnvJc2Pd4K8On0/CYxEKMf?=
 =?us-ascii?Q?QTt8jecJVN5ffO6n5cbwElY0m2k4dL/U4GMXV4/wIqnXCzO2j9Xg9U4m5SXb?=
 =?us-ascii?Q?ifl2W2UUqv2IztCpWWZR21RP4vgEKyqCzlmVLmcphLUG0jjJFrKhXlkBFzBh?=
 =?us-ascii?Q?83cqnTwQwflyHq5qkujqheFLfilVVw+Fa5m8Mx+vsQPUXNHj37pRIRkvbykd?=
 =?us-ascii?Q?S4pQ7jIowZ5AJsLsrdU40greEnMqVFaU7YWl9ZfWG0v8HHkj0wR5sJ/8vgBJ?=
 =?us-ascii?Q?CyBgt7xmHYt0yQyXMzHfkZV9rZ5i+c9sxAfqWSdj6eNac9HukrkTrvOiAAl4?=
 =?us-ascii?Q?UGbL5MaIwxWHgU9+3vTH1gF6DZ8E/gZsYmNZR34oUbSBbGjFWzw2aCOd5B8/?=
 =?us-ascii?Q?aoDuvs3w4yJ+VA/UDQIG7L6Bd+wYqNPvYJ8Dj/mt9gSIq9dEIHkoWi3dAPeW?=
 =?us-ascii?Q?Mpu2UhKGuzMumJOQtSnu8lWV5h4mxGS+d1KjYjBr3fg1p6+PhH/Kmy3CLRJD?=
 =?us-ascii?Q?otFTY8RJrr3G2PtsKosHCuj8NsuPxDrUwx5Dz07NGWKlWGFoOEtVJRn6SoJb?=
 =?us-ascii?Q?VyvSe2izkbQI/5Z2bKb2Gh9cgdLX0eg5PtuiiVeXX8hN6REIQgQqpRGHBoc1?=
 =?us-ascii?Q?0yp+6PNVtsFhhg/5WbwprfRYnZPYiF0+XDoj21ibQtbBTXg/QAFoo/tuUQjF?=
 =?us-ascii?Q?b4BPw9mlb26qzAYtt+NIolIsjL+15n/VA5cR+1cAX2PLbwIOvXWrrIxIDic7?=
 =?us-ascii?Q?Xy5Kz72weZn8nuraARQm9f57T90Jtng5SG3pc2x87LDsIPN4n1wzfB6vCEMI?=
 =?us-ascii?Q?X+Zvy2LL49u9PUsCDDLtYoKrgXvyjY2W59cCBwQJw8Q7xyJ2YAUtU7EaCePX?=
 =?us-ascii?Q?e9oJDmRJ2Mz6x15UVzgzWQg8q4zxTKx/H7cwJwW0WM77XL/OtL5Tpi0g8hqs?=
 =?us-ascii?Q?dEJ9V6NWJi/EAa+so9CVQ+/AS8hGCDKjGIvw171OUDix7lsezwL/u6Ro2YRf?=
 =?us-ascii?Q?M07M3rVhek5QqsrXSB7WoVUHDNeG1nwW491f3VFSchAs8Spj8c26fnmowolA?=
 =?us-ascii?Q?PI3tL+K9EnsiUBLQS/t8nlF//GzLOiD5QtlNuQZRVWWR9UoWDtBFxCg94Xnu?=
 =?us-ascii?Q?Vfq2tjdWtjyGNwaG3c7ROCfnay4eORm8ky4FffR4EWM630trU2U9i7+Kfoee?=
 =?us-ascii?Q?ZBs1akkf3kzjdVNkDe9IuZ5OFaXTi510GlxBlOb1EP2L68PVwOuAXlM2C5gY?=
 =?us-ascii?Q?zD4PXPcPdwqspWwRQR1IYp7XwG5riGzfQC6hSlXDB4jJ3jt3kcpsv2gmauG4?=
 =?us-ascii?Q?IKLmxNrz0JR1mYBt2dB9ThbsgIY2zLGNwnwLI1WavAWhNaaPrX5nmenWjmWY?=
 =?us-ascii?Q?bSbrHh5KoEl1PexShxk7515KYHEu7LGm9ZaU9+2jrvxVbP5DjiQpnWKCxq5Q?=
 =?us-ascii?Q?JaTWGeXl/DTsEjvmTx/NmiLJagX/XT+2gQzP3l31X3Uh8bhmqaJw8W6Da55g?=
 =?us-ascii?Q?XX4toYZYa7BYYWXfVN9co6y14UN86phWQVlT819o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1713597b-c6d9-42cc-b0b7-08dae3f5312e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 08:19:06.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGzqahqgcY7IZZCpvp8O99IRD1AfBPEPqNRzafp2dIz+HP1VZ9Ggmfxfb8HdxJ6E/IUMvVUrf9RYCiSejzF/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to initialize idx twice. BTW, remove the unnecessary cnt variable.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/iostat.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3166a8939ed4..335b055ffe7d 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -97,8 +97,7 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 
 static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 {
-	int io, idx = 0;
-	unsigned int cnt;
+	int io, idx;
 	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	unsigned long flags;
@@ -106,12 +105,11 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
 		for (io = 0; io < NR_PAGE_TYPE; io++) {
-			cnt = io_lat->bio_cnt[idx][io];
 			iostat_lat[idx][io].peak_lat =
 			   jiffies_to_msecs(io_lat->peak_lat[idx][io]);
-			iostat_lat[idx][io].cnt = cnt;
-			iostat_lat[idx][io].avg_lat = cnt ?
-			   jiffies_to_msecs(io_lat->sum_lat[idx][io]) / cnt : 0;
+			iostat_lat[idx][io].cnt = io_lat->bio_cnt[idx][io];
+			iostat_lat[idx][io].avg_lat = iostat_lat[idx][io].cnt ?
+			   jiffies_to_msecs(io_lat->sum_lat[idx][io]) / iostat_lat[idx][io].cnt : 0;
 			io_lat->sum_lat[idx][io] = 0;
 			io_lat->peak_lat[idx][io] = 0;
 			io_lat->bio_cnt[idx][io] = 0;
-- 
2.25.1

