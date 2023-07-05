Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F5A747DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGEHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjGEHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:09:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C091720
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:09:48 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230705070945epoutp02081ec302a05cd6967db1d484d59940ac~u5xSLH95i1360513605epoutp02E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230705070945epoutp02081ec302a05cd6967db1d484d59940ac~u5xSLH95i1360513605epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688540985;
        bh=TzMoaf8vGyU8GATKSoffunm8vsRVuxtDYDCKWXxcjoM=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=VKwUqMyyyvV6HKNGU1YXfdoMuywJRpo2MyYld+2/tX51XjzULbRnSnvXO/KD6LN0U
         ktrwgbiUjqJOFJVfjb364vu/hFtntLQ/zi+qhof9SYFE+MvVT3fh/uu6Ue9CQnCX8j
         jJD80WLaa6VlBFkwBKg6mu4n7fkfb3RlSbqIGhw4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230705070945epcas2p25197107f3bf947b88b044b526a80a257~u5xRziteL0072300723epcas2p2B;
        Wed,  5 Jul 2023 07:09:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QwrQ05PVJz4x9QM; Wed,  5 Jul
        2023 07:09:44 +0000 (GMT)
X-AuditID: b6c32a46-d17dea8000009cc5-dd-64a51738a047
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.17.40133.83715A46; Wed,  5 Jul 2023 16:09:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: including waf data in f2fs status information
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
Message-ID: <20230705070944epcms2p19fc974208a2a1871e2c84df7d9d95761@epcms2p1>
Date:   Wed, 05 Jul 2023 16:09:44 +0900
X-CMS-MailID: 20230705070944epcms2p19fc974208a2a1871e2c84df7d9d95761
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmua6F+NIUg/atahanp55lslj1INzi
        yfpZzBaXFrlbXN41h83i9Q85i1Udcxktpp4/wuTA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        x/lnmAp+81Y0T7zM2MA4n6uLkZNDQsBEYsPa86xdjFwcQgI7GCUOXtjC3sXIwcErICjxd4cw
        SI2wgLvEhcsLmUFsIQFFib7mDWwgJcICOhJLthiDhNkEtCS6r59hBhkjIjCJWWJDxzcmiPm8
        EjPan7JA2NIS25dvZYSwNSR+LOtlhrBFJW6ufssOY78/Nh+qRkSi9d5ZqBpBiQc/d0PFJSUm
        /nwIZedLfP/9kRFksYRAC6PEzp45UA36Etv+zAZbzCvgK7Hy8RE2EJtFQFXi7veVUMe5SPxb
        /gKsnllAXmL7W5BeDiBbU2L9Ln0QU0JAWeLILRaICj6JjsN/2WHe2jHvCRNEiapENyhE2ME+
        7DCAKPCQaDl2mAWkQEggUGJdt/oERvlZiICdhWTnLISdCxiZVzGKpRYU56anFhsVGMHjMjk/
        dxMjOPVpue1gnPL2g94hRiYOxkOMEhzMSiK8K74vThHiTUmsrEotyo8vKs1JLT7EaAr07URm
        KdHkfGDyzSuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgUlevljs
        /3uNk0laF93fvZ5TOXfr+mcGVfOTVYT/HBQ75qZi9X0/wzWmr7Eqzx50XgteEL0m6eFcwSdJ
        ddtOBke3tvkk6H5crFS58OhfLaMWRW+HxpDiW6d3ulzYtexHSM3R0nliEk6f1Z8cLUhiiD7/
        3KpAZ85r25VnLt0q/6bR+Yzz2pwyo2bDbw8qP/punD696sgZLnHzr2Fnwv/L8q3cc+X+q8P6
        /7Jcthz6wLCn6faf2apVpuXs7t66ocs2FP/Sd1lovOdXT/y5Rzvlex+zbKmufr8xfMolFSXe
        r/dOiTnW3V2rOlvreW/D1pyDL3nKva68ehZhZVDjzj95cqMGy8Jd53//XpW1vHpRPb+kEktx
        RqKhFnNRcSIA+i9nEQYEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230705070944epcms2p19fc974208a2a1871e2c84df7d9d95761
References: <CGME20230705070944epcms2p19fc974208a2a1871e2c84df7d9d95761@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
