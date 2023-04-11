Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B601A6DE3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDKScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:32:23 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 11:32:22 PDT
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55ABD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681237940;
        bh=mp0sQiFFTDUpNh6NxMv9OYuqBQq73chrKv/EDkfDVeA=;
        h=From:To:Cc:Subject:Date;
        b=GxaOKy/LD0w8FIvheQXjXS8Ey3/T7x6UysU7mHTCC1qVwDqaEychtuch6oNI6KK6/
         pY3umw3qyvpBKll8/A2vfOoCcubMYymoVuGmYm8wHcxwbzrre4LG2X6P5RtLvNZz/l
         9n/Iu2Bxo8uLH1o64O8lS+Z8o4EgXfU5zB3xgDnc=
Received: from wen-VirtualBox.lan ([106.92.97.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 632ACC6E; Wed, 12 Apr 2023 02:24:50 +0800
X-QQ-mid: xmsmtpt1681237490tazep2bw9
Message-ID: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
X-QQ-XMAILINFO: Nwte6vbuj0EqxKzjqFSWD9W9/wTGARFQ0IhiU5/jHK3ELV/l0jLhaDQ2FiELSd
         HOj/VAjLbJKgEb6Zq08bZ6Swkwkwre0YpLj01kZwffRan0IHjtuK8fhX28vCS6ztIRcxtJX6fSzU
         C6J7+U9fMQxdswrnF8Dxkf+0oSoCbyxFpxQJL929Rm9a7kT3wnFx6JXoOdiJ3oaYNNhWDIldNx62
         kUHRBUP1RkUL+YtJOqxALEVS4qr3qHyDlYzN4c9xhE/VdPyKH5iNbuhGEPZwqdef0OYyCkEJ80pf
         RCgATxRbKy5BW9bNNoAySXeAZESjSkqhAVCFCvw5o/Kzg6MJlnNKirwNmGuY7th/McCFVa2z5FgZ
         7G9ZPL3r5GmeMpuCmkjyLklM1wbSrqfXzn1jy9SXtzhmSYUsh9XrxhrWWBYgPmZGZqaLnU0JIO47
         HwR8+it3o8J/35kgXJ58gwBSEA8CLVyJuIkyHew2KapJ3bprH8PHjoiV13cKPrYLuhQM9Yijr/gw
         9Gq9Fotoyt5c4uwjjBGTRsKWFe7A/69gWRD0/bf2L8wnwGQCHS16Lq7nyfhL+COc7urPbUygAiEq
         r6RKUf7kvarIK9V41XID2B7Ncl/DW4lCAIFjFo2u9rKU7UW8nxcUZ/JYz8JIRT3m9zcVVNj3joAX
         FbXVAS2JK4hzIMZYoasVq2ZCVMAV4gX3PVQHFwkfNKBa2zRRrKY+f20OHup8ZdTevclsbLEBKAvJ
         RJ5lCUucufl5/FSwtjYNVuAj7/D6H3Qi1FKndNlHAsy1iYgn9AtCHFF/JJnfTIKdYpgnjWiGACdG
         8FVloaLV8sD8FcOv9im1cpKiIcA+VvlJL0W7i8aMyi3NdzM9GzIXyp1nUuJ6HduL5FE6YzJih5aL
         vTd4yZm58C3oByZxNCwwN63U1TvlUOEPaD74GewakHMm1jjkcFQmPXbxOL3S+J9F1L8BeYbCteXH
         Pos2U9TQUHljwhdKI59UD2u/95Z170MNdLKm8cO0pV/Wb49lIvh5nwWag0zhYeA/adaDAcfeEfF8
         ZiNilm5iqgr2mjnBCrxhrgZrlUtbSDqdMNeH8C6A==
From:   wenyang.linux@foxmail.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction: optimize compact_memory to comply with the admin-guide
Date:   Wed, 12 Apr 2023 02:24:26 +0800
X-OQ-MSGID: <20230411182426.972-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

For the /proc/sys/vm/compact_memory file, the admin-guide states:
When 1 is written to the file, all zones are compacted such that free
memory is available in contiguous blocks where possible. This can be
important for example in the allocation of huge pages although processes
will also directly compact memory as required

But it was not strictly followed, writing any value would cause all
zones to be compacted. In some critical scenarios, some applications
operating it, such as echo 0, have caused serious problems.

It has been slightly optimized to comply with the admin-guide.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: William Lam <william.lam@bytedance.com>
Cc: Fu Wei <wefu@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/compaction.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..3c4aa533d61c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2780,6 +2780,17 @@ static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int
 static int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
+	struct ctl_table t;
+	int compact;
+	int ret;
+
+	t = *table;
+	t.data = &compact;
+
+	ret = proc_dointvec_minmax(&t, write, buffer, length, ppos);
+	if (ret)
+		return ret;
+
 	if (write)
 		compact_nodes();
 
@@ -3099,6 +3110,8 @@ static struct ctl_table vm_compaction[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= sysctl_compaction_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "compaction_proactiveness",
-- 
2.37.2

