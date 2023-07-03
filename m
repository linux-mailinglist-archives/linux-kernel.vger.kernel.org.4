Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6F7460B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGCQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGCQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:25:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555DE42
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:25:19 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CB0203F851
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688401517;
        bh=ykDzESFnICwZIJMQN3uAcRHhxxnmPoYMfo+p0YP998E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=dC+o2qDOHigQlHZfBXDCMlVKQ/KYDgZ2p+iRjDmgCSVXV+sSvI5YKuuFZVG9aqyf2
         P7yfooE3z406qqJLfzH+GLEf/oWfVunZKd2mxFQGAWTKXw9V/hN6REW2yklOMZMShw
         MeyAg6/9Erz37OPTGcyuHMjdmIRH7V++GDuQKwIKA26UCV+RGy73+vS4NZ4pWdDErD
         rBF7K6jtM/hUeetTckiJcCi29R2jNfVx0z9hb8WcXGYvBEz6+LSNdZ9LV2tOb49/mT
         7STWVk2AqykndKMzcoQY3nJ9/7oSDAH5l5bodbgTx3+pRfh/+FRtndaQSzJ3/TXgBy
         kqBd8iqMbKC+A==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b7dd5bca25so51515585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688401513; x=1690993513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykDzESFnICwZIJMQN3uAcRHhxxnmPoYMfo+p0YP998E=;
        b=YtLAYbYNhfdBdesjjpRmEBxH22od6J5g8qAxg1npz+3/ZO4B5ExSkkq8Mqp9ko98ZB
         AZ8RpAS7Kfonv/Jm11K0JxZiStKOwiK4Sn2iK6UUyzxut2u9mZSWiMLQOhOYlnpfcSBx
         QGN1mp6Njz4wYyaH+5q7dZLZL6EzVbCrkdUh8vQl0xwHNuhKfNBnFeYVL2fzAIICMOPh
         HcPSXLn8chA/Wc2zHDQq9UeIfOGJOe0HNg56bFoWcXnyjDpr8+MOzRnWuqgVebFhLnOQ
         +s6shKTuJfoakDHGSrDAUlLy/LPR4JmrWBtptvUoNTMa3ugrxj2/RwGkKS34bJaIBNhF
         e6Nw==
X-Gm-Message-State: ABy/qLYSmXjYY4mW17vqWPtfv4ALeUY4P0EUakKVG5+MN+TKnPRNRfwt
        6nwteVPA84FZm3a+BPFP9gyMjEWuK59fzXFtTwUbanROte1PRI1FCBjyrZKl3nHIgMoI6vUWmNp
        gSh1T83EpPQlkQN2+PKbIRQ29IN66IH35VY68FDecIo/rOuTK2A==
X-Received: by 2002:a17:902:e54c:b0:1b8:8979:8088 with SMTP id n12-20020a170902e54c00b001b889798088mr7052709plf.18.1688401513088;
        Mon, 03 Jul 2023 09:25:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZdOUJQa/Ej88XepCZgZmtuutg08rcOpg5AbKBkOrsnjhDxkAm5qqtXRN9B37RmrqCdRseWg==
X-Received: by 2002:a17:902:e54c:b0:1b8:8979:8088 with SMTP id n12-20020a170902e54c00b001b889798088mr7052695plf.18.1688401512700;
        Mon, 03 Jul 2023 09:25:12 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001a072aedec7sm4863715plc.75.2023.07.03.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:25:12 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][V2] EDAC/i10nm: shift exponent is negative
Date:   Tue,  4 Jul 2023 00:25:09 +0800
Message-Id: <20230703162509.77828-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains this error
~~~
 UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
 shift exponent -66 is negative
 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x70
  dump_stack+0x10/0x20
  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
  skx_get_dimm_info.cold+0x91/0x175 [i10nm_edac]
  ? kvasprintf_const+0x2a/0xb0
  i10nm_get_dimm_config+0x23c/0x340 [i10nm_edac]
  skx_register_mci+0x139/0x1e0 [i10nm_edac]
  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
  i10nm_init+0x403/0xd10 [i10nm_edac]
  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
  do_one_initcall+0x5b/0x250
  do_init_module+0x68/0x260
  load_module+0xb45/0xcd0
  ? kernel_read_file+0x2a4/0x320
  __do_sys_finit_module+0xc4/0x140
  ? __do_sys_finit_module+0xc4/0x140
  __x64_sys_finit_module+0x18/0x30
  do_syscall_64+0x58/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? do_syscall_64+0x67/0x90
  ? __flush_smp_call_function_queue+0x122/0x1f0
  ? exit_to_user_mode_prepare+0x30/0xb0
  ? irqentry_exit_to_user_mode+0x9/0x20
  ? irqentry_exit+0x43/0x50
  ? sysvec_call_function+0x4b/0xd0
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
~~~

when get rows, cols and ranks, the returned error value doesn't be
handled.

check the return value is EINVAL, if yes, directly return 0.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
V2: make error-print explicitly
---
 drivers/edac/skx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2a00e0503f0d5..ac61db72d2e6b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -330,7 +330,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 	u32 val = GET_BITFIELD(reg, lobit, hibit);
 
 	if (val < minval || val > maxval) {
-		edac_dbg(2, "bad %s = %d (raw=0x%x)\n", name, val, reg);
+		skx_printk(KERN_ERR, "bad %s = %d (raw=0x%x)\n", name, val, reg);
 		return -EINVAL;
 	}
 	return val + add;
@@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
+	if (ranks == -EINVAL || rows == -EINVAL || cols == -EINVAL)
+		return 0;
 
 	if (imc->hbm_mc) {
 		banks = 32;
-- 
2.34.1

