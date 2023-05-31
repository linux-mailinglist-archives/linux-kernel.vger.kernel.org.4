Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9868D7179E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEaIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjEaIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:20:45 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7613E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:20:42 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230531082040epoutp0279eb6d839391642a617f37072a6404b6~kLKM7hJUB2990829908epoutp02K
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:20:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230531082040epoutp0279eb6d839391642a617f37072a6404b6~kLKM7hJUB2990829908epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685521240;
        bh=ebFaz6q3K4kRvSJEYLl/6SHwuQr/hdkSGQ9G1SAZCWU=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Qt+3jeFMeeiaBmGllKtJ/PUYnRgfQtej/t8aJi0AOT4x9oyJ+fqdDOf6HjRViS7hO
         hgusyaQ4NPC0Xax5n5jXNCPGsOPhN67u2kfY6MhKGB+HDR1JzzEmDb/6O58oS4uUJn
         HCfc8AmPnpTxOymdM6oOjONolRoB2w2/jS+qJJK0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230531082039epcas2p4cf7201fd5926c1529069eea90c44df4a~kLKMj4BS81066510665epcas2p4m;
        Wed, 31 May 2023 08:20:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QWMdz13rXz4x9Q9; Wed, 31 May
        2023 08:20:39 +0000 (GMT)
X-AuditID: b6c32a47-157fd70000001ce0-49-64770356fd80
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.53.07392.65307746; Wed, 31 May 2023 17:20:38 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: including waf data in f2fs status information
Reply-To: beomsu7.kim@samsung.com
Sender: beomsu kim <beomsu7.kim@samsung.com>
From:   beomsu kim <beomsu7.kim@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
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
Message-ID: <20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc@epcms2p2>
Date:   Wed, 31 May 2023 17:20:38 +0900
X-CMS-MailID: 20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmuW4Yc3mKwdcTUhanp55lslj1INzi
        yfpZzBaXFrlbXN41h83i9Q85i1Udcxktpp4/wuTA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        hZO3WQpO81ScORLTwLieq4uRg0NCwETi6l2TLkYuDiGBHYwSU7ZdYQOJ8woISvzdIdzFyMkh
        LOAi8WrDBUYQW0hAUaKveQNYibCAjsSSLcYgYTYBLYnu62eYQWwRgVeMEmdWi4KMZBZYxSix
        uPUyWEJCgFdiRvtTFghbWmL78q2MELaGxI9lvVA1ohI3V79lh7HfH5sPVSMi0XrvLFSNoMSD
        n7uh4hISr3/CzM+X+P77IyPIYgmBFkaJnT1zoBL6Etv+zAZbzCvgK/Fz210wm0VAVeLAntdQ
        NS4S11+/AhvKLCAvsf0tSC8HkK0psX6XPiSolCWO3GKBqOCT6Dj8lx3mrR3znjBBlKhKdINC
        hx3sww4DiAIPiZ6dndDwC5TY0PmebQKjwixEKM9CsnQWwtIFjMyrGMVSC4pz01OLjQqM4dGa
        nJ+7iRGcELXcdzDOePtB7xAjEwfjIUYJDmYlEV7bxOIUId6UxMqq1KL8+KLSnNTiQ4ymQO9O
        ZJYSTc4HpuS8knhDE0sDEzMzQ3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9TBycUg1MG9I2
        LZZq6D0qzBDPNbd/b7vDoYtcP8MFr/zw72b9bL2kZp1KuGWoduvjn446ui23+pVPnHu4J/v2
        2rjEXbOc37s9+Nk1o3hrWktgpI2xjL+sgV4h24WkSes13bXEFUQsxfq0kz11Hxze4iX0N3LG
        JqdHTnc2WahmzDGO/8HGlu/53XnXUa1pn2R89P7MPHVSaPGJgr4jM+8XRsnwXWJI+aCr82qC
        z6SZ7AKPoxeZTrr70OM7w/o7Sy4brLwZUu1Trp0asN338LfHC+b+b/Keu/G2mu+mkIg0aYHk
        PZ7mHVzJjH4y93zW1CnUXXg28eOVLZ5dP3jrdJfkq52IcJGxERUPmNPSrmbtoqa27LISS3FG
        oqEWc1FxIgChB4pIEQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc
References: <CGME20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc@epcms2p2>
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
index 3d5bfb1ad585..6ae9659d69e7 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -34,10 +34,22 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	int j;
+	unsigned long long waf = 0;
+	unsigned long long data_written_to_storage = 0, data_written_by_user = 0;
 
 	if (!sbi->iostat_enable)
 		return 0;
 
+	for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)
+		data_written_to_storage += si->sbi->iostat_bytes[j];
+	for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)
+		data_written_by_user += si->sbi->iostat_bytes[j];
+
+	if (data_written_by_user > 0)
+		waf = data_written_to_storage * 100 / data_written_by_user;
+
 	seq_printf(seq, "time:		%-16llu\n", ktime_get_real_seconds());
 	seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
 				"io_bytes", "count", "avg_bytes");
@@ -81,6 +93,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 	IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
 	IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
 
+	/* print waf */
+	seq_puts(seq, "[WAF]\n");
+	seq_printf(seq, "fs waf:		%llu.%02llu\n", waf / 100, waf % 100);
+
 	return 0;
 }
 
-- 
2.17.1
