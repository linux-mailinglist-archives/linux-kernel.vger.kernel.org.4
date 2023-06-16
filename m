Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1373263C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjFPEhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPEh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:37:29 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974C2D54
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:37:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230616043724epoutp044f6e09c76f58240742ee899b1349718b~pCb1ZpLgu2454624546epoutp049
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230616043724epoutp044f6e09c76f58240742ee899b1349718b~pCb1ZpLgu2454624546epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686890244;
        bh=TzMoaf8vGyU8GATKSoffunm8vsRVuxtDYDCKWXxcjoM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=t5s68veHJRxeVnORsIARiDc6EwV0HlQVtpb5K+6Ul2//G7j5CyTf6JIZyOau63doP
         /WiPXKUAcFjJI9oD6fz+W3/WqpwZ2sZweGZxzCxmD+5yjRw08+r2olEjG3/4Ju/al5
         OlZ4OPaXOeSiT+0U/qMznfa9MynfGuv5kJtQQeDs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230616043723epcas2p29c8c2f82eba70fd792df2735fc3edace~pCb0xnmfw1438214382epcas2p2B;
        Fri, 16 Jun 2023 04:37:23 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Qj5wz0MD0z4x9Pw; Fri, 16 Jun
        2023 04:37:23 +0000 (GMT)
X-AuditID: b6c32a45-1dbff70000022cba-7e-648be7029a0a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.BD.11450.207EB846; Fri, 16 Jun 2023 13:37:22 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: including waf data in f2fs status information
Reply-To: beomsu7.kim@samsung.com
Sender: beomsu kim <beomsu7.kim@samsung.com>
From:   beomsu kim <beomsu7.kim@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yonggil Song <yonggil.song@samsung.com>,
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
Message-ID: <20230616043722epcms2p3073c77119d37f5f963b8a75801efb40f@epcms2p3>
Date:   Fri, 16 Jun 2023 13:37:22 +0900
X-CMS-MailID: 20230616043722epcms2p3073c77119d37f5f963b8a75801efb40f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmhS7T8+4UgyPXrSxOTz3LZLHqQbjF
        k/WzmC0uLXK3uLxrDpvF6x9yFqs65jJaTD1/hMmBw2PTqk42j90LPjN59G1ZxejxeZNcAEtU
        tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
        OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
        j/PPMBX85q1onniZsYFxPlcXIyeHhICJROej94xdjFwcQgI7GCXedZ1k62Lk4OAVEJT4u0MY
        pEZYwF3iwuWFzCC2kICiRF/zBrASYQEdiSVbjEHCbAJaEt3XzzCDjBEReMAoMeXGXjYQh1lg
        FaPE4tbLzBDLeCVmtD9lgbClJbYv38oIYWtI/FjWC1UjKnFz9Vt2GPv9sflQNSISrffOQtUI
        Sjz4uRsqLiHx+ifM/HyJ778/gj0jIdDCKLGzZw5UQl9i25/ZYIt5BXwltn7axw7yAYuAqsSk
        X/ogpoSAi8TmUyEgFcwC8hLb34J0cgDZmhLrd0FVKEscucUCUcEn0XH4LzvMUzvmPWGCKFGV
        6AYFDjvYfx0GEAUeEh8f3WABKRASCJS4fJtjAqPCLEQYz0KycxbCzgWMzKsYxVILinPTU4uN
        Cgzh0Zqcn7uJEZwQtVx3ME5++0HvECMTB+MhRgkOZiUR3mUnulKEeFMSK6tSi/Lji0pzUosP
        MZoC/TqRWUo0OR+YkvNK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBK
        NTBN2GU6uzN0S7eNhiFnrUTQ4o1Z3UwLKzTEsn4VRy/bevdmemydg3TfcTuj5tD/QdxGpv/j
        wza47YzMYXRMVjM+N3G98vkvOy+4nDW8+fms806BA97KV3d8dZ2XV3Jym85+Lv4pX5ikbs8q
        8JIXjHVV04vxPBbcpve3qNpq8q6meNPDd1Qfu01ceKm/1zm//dO5ArX6QMtF8gdqu4LCau+W
        C6ZfarXk2KwdvDHA0MA1VLtG9v6b/u/h0W1HFizcevHkxcD9ZvHvNbc8+sAffH1Bg9wTldnT
        Flq8Ftnz5v6XtglmNovM1sZKZrC2L7NyUTprOeGydntI7eQN10UtvFMNBPgt7z8x+c5YkPRu
        txJLcUaioRZzUXEiAAiX+VoRBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230602044830epcms2p141ec782e866c2adc5a3142516f051b87
References: <CGME20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When evaluating in f2fs, it takes much time to obtain waf data.
This patch helps to obtain waf data without calcluation.

Signed-off-by: Beomsu Kim <beomsu7.kim@samsung.com>
---
 fs/f2fs/iostat.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3d5bfb1ad585..59720639e8c0 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -34,10 +34,23 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 {
        struct super_block *sb = seq->private;
        struct f2fs_sb_info *sbi = F2FS_SB(sb);
+       int j;
+       unsigned long long waf = 0;
+       unsigned long long data_written_by_user;
+       unsigned long long data_written_to_storage;
 
        if (!sbi->iostat_enable)
                return 0;
 
+       data_written_by_user = sbi->iostat_bytes[FS_DATA_IO];
+
+       data_written_to_storage = data_written_by_user;
+       for (j = FS_NODE_IO; j <= FS_CP_META_IO; j++)
+               data_written_to_storage += sbi->iostat_bytes[j];
+
+       if (data_written_by_user > 0)
+               waf = data_written_to_storage * 100 / data_written_by_user;
+
        seq_printf(seq, "time:          %-16llu\n", ktime_get_real_seconds());
        seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
                                "io_bytes", "count", "avg_bytes");
@@ -81,6 +94,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
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
