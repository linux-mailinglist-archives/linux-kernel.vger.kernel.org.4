Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A971F970
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjFBEsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBEsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:48:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33327F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:48:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230602044832epoutp02b03dc516e46cb903013fa16e6e171fc6~kvjj9nfXE2432024320epoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:48:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230602044832epoutp02b03dc516e46cb903013fa16e6e171fc6~kvjj9nfXE2432024320epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685681312;
        bh=htKPHmhhT4AYe93UIPC4J12oR0fFRH08mmxQjpY33SI=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=uwsQDewjzjlRVs3ChEU5s3ZK8MiJdlS3LkkCsVcGR3Ens1fnsF5k+9yFiWY8eSuCW
         4gO+5AwepAqqK32UWPKotL/1SzHZhUtY3TbySElzgG7cw1BaiVF0flnK+vsbU+wRWQ
         NdTuy3jYv6V1TpmchEdlyPGNWbFy1AFxU79wal5A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230602044832epcas2p14f9e10385933a38e8703a8232a1d687f~kvjjiKcpR2861528615epcas2p1K;
        Fri,  2 Jun 2023 04:48:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QXVrH3MHwz4x9QB; Fri,  2 Jun
        2023 04:48:31 +0000 (GMT)
X-AuditID: b6c32a47-eedff70000001ce0-67-6479749f2ca6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C4.07392.F9479746; Fri,  2 Jun 2023 13:48:31 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: including waf data in f2fs status information
Reply-To: beomsu7.kim@samsung.com
Sender: beomsu kim <beomsu7.kim@samsung.com>
From:   beomsu kim <beomsu7.kim@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonggil Song <yonggil.song@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Seonghun Kim <seonghun-sui.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
Date:   Fri, 02 Jun 2023 13:48:30 +0900
X-CMS-MailID: 20230602044830epcms2p141ec782e866c2adc5a3142516f051b87
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmme78ksoUg1PfJS1OTz3LZLHqQbjF
        k/WzmC0uLXK3uLxrDpvF6x9yFqs65jJaTD1/hMmBw2PTqk42j90LPjN59G1ZxejxeZNcAEtU
        tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
        OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
        zSeNCn7zVsycvIytgXECVxcjJ4eEgInE5s1vWLoYuTiEBHYwSrScns7UxcjBwSsgKPF3hzBI
        jbCAi8SrDRcYQWwhAUWJvuYNbCAlwgI6Eku2GIOE2QS0JLqvn2EGGSMiMIlZYkPHNyaI+bwS
        M9qfskDY0hLbl29lhLA1JH4s62WGsEUlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93Q8UlJF7/
        vAwVz5f4/vsjI8hiCYEWRomdPXOgEvoS2/7MBlvMK+Ar0bp0G5jNIqAq8Xn/L6hBLhLLJ+4H
        s5kF5CW2vwXp5QCyNSXW79IHMSUElCWO3GKBqOCT6Dj8lx3mrR3znjBBlKhKdINChB3sww4D
        iAIPiY+PbrBAwixQovluJ/MERvlZiJCdhWTpLISlCxiZVzGKpRYU56anFhsVGMPjMjk/dxMj
        OPVpue9gnPH2g94hRiYOxkOMEhzMSiK8QmHlKUK8KYmVValF+fFFpTmpxYcYTYHencgsJZqc
        D0y+eSXxhiaWBiZmZobmRqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamKKYbH1eO31a
        tVh1yuzks8zX/z2fHTjFgDn/SI3Xge6NPLKitwptl+ydz/VGq139QPIUg4q5IZbnFB67Rhsc
        /+jE6zLF9nTz+YVrV5naXmWtbrO5cvzr9NsW+9QZvhkoXD9wOHMVw0uT5yJ70/MPJXN9Wqxq
        l6odvEr0w6W2KG32huXNxgdmythw+Rg1uDhPjLpnO/HExq4LLZeUpZQkNMt8NJRkfoWe+N7z
        920fz+s1h4xebH3sPGcPk8pzyZpPEXd75z2ZEXdRR1IyN/1B+NM3aT/uLDqtsNA8U3V6UlTK
        Cq7cnrS52YfNM0/q8uzwO/w0bWFQoG9E0LMU1apdAqmygYk7ouxu3jl2o53zlxJLcUaioRZz
        UXEiADn6nogGBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230602044830epcms2p141ec782e866c2adc5a3142516f051b87
References: <CGME20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When evaluating in f2fs, it takes much time to obtain waf data.
This patch helps to obtain waf data without calcluation.

Signed-off-by: Beomsu Kim <beomsu7.kim@samsung.com>
---
 fs/f2fs/iostat.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3d5bfb1ad585..6eab11b0610d 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -34,10 +34,22 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 {
        struct super_block *sb = seq->private;
        struct f2fs_sb_info *sbi = F2FS_SB(sb);
+       int j;
+       unsigned long long waf = 0;
+       unsigned long long data_written_to_storage = 0;
+       unsigned long long data_written_by_user = 0;
 
        if (!sbi->iostat_enable)
                return 0;
 
+       for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)
+               data_written_to_storage += sbi->iostat_bytes[j];
+       for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)
+               data_written_by_user += sbi->iostat_bytes[j];
+
+       if (data_written_by_user > 0)
+               waf = data_written_to_storage * 100 / data_written_by_user;
+
        seq_printf(seq, "time:          %-16llu\n", ktime_get_real_seconds());
        seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
                                "io_bytes", "count", "avg_bytes");
@@ -81,6 +93,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
        IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
        IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
 
+       /* print waf */
+       seq_puts(seq, "[WAF]\n");
+       seq_printf(seq, "fs waf:                %llu.%02llu\n", waf / 100, waf % 100);
+
        return 0;
 }
 
-- 
2.17.1
