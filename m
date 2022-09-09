Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF15B3BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIIPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIIPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:24:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328BBC4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:24:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q21so3035098edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date;
        bh=+tgCQNlrJBIJnFZktIjnzR8zOnXjEUkMb3MwFUQzmLI=;
        b=p1E9tA7OQG03ngYTlzq1WWfVaZKP9PgOYShijUuAPh+QnzbL2pNJMJg9njJI9BOXUF
         X+07IOzw9FbuCpu//xKKmWVBSlDEYVPWabXU5jrmS6O8gAVZFuhhnE/u7Uf3IH5ZbQ3W
         nNTMZUCT0BPwwXJTL9yViQ962feG2ImxKd6WzKhoIZMCv+yfqeKfJIme1VKG1kluW6+N
         GroPA2L1Kigxsvmg1DUZf3IhlyU5jsr2M/9d3TtU5Qvhxs1isvacqTHxe+zTFz6nWuhG
         s+YF+T2QlucYpH51BULRFELlfZvv+TG0NS1Rx4+p6w4lh/oWJLZwosvPFzsymGUcFRp1
         7PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+tgCQNlrJBIJnFZktIjnzR8zOnXjEUkMb3MwFUQzmLI=;
        b=BWGvtbIOhRORDC00+690nnHHd4aoGAq8nWCwwjz7w4hFFomD1Pyil5QCTmNNtPD1MZ
         hDd7BIAGZRNAWqYMnaH/PkE/OX5q6/inoqTYh+NKaU83eiqoHWm28OIKWxCJwKvQMsog
         lfMwxAT8Vr+uXWAWrMzXwD0bBN22gSyNPDAiNS1ErCWxLzQfwiuyHE4nUifd0Jt54JzJ
         EBArMo/S55694g/tS5cch8UlDasS6xZaTmtduOmiT8sFFXmGJ9NYtgi8m3/ck1e4Nulw
         Vx/FMd3isfr1/HyGlQPADMQ3/76vuRSvnNu+jc6HWYH1Qf9dcPTR4/nnGSgFSsgyfB56
         H0Rw==
X-Gm-Message-State: ACgBeo13GyvGLe57AAevMtQCr9wHetq2rXn0O5SQY8QXb9+YoUVVK1rX
        PflgbvhGlp2PHY74EbYkR98=
X-Google-Smtp-Source: AA6agR6Oijo4pfbEgVyRppnjnyJ8xgrFiu1v3J9OQxrDhAmJWrMZ51+gb5ZnHbFi3L70gLrWPzUweg==
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id q36-20020a05640224a400b004408c0c8d2bmr11671587eda.311.1662737065652;
        Fri, 09 Sep 2022 08:24:25 -0700 (PDT)
Received: from localhost ([89.40.126.93])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906051700b0073d53f4e053sm403536eja.104.2022.09.09.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:24:24 -0700 (PDT)
Message-ID: <631b5aa8.170a0220.9378b.124a@mx.google.com>
X-Google-Original-Message-ID: <YxuEzfVSEmBrsAR4@<DarkDistro>>
Date:   Fri, 9 Sep 2022 18:24:13 +0000
From:   Burak Ozdemir <bozdemir@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Fix string form declaration
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Burak Ozdemir <bozdemir@gmail.com>

Use correct string form declaration, prevent extra variable
declaration in final assembly output.

Signed-off-by: Burak Ozdemir <bozdemir@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index df02335fdbab..70b3709acbb2 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1105,7 +1105,7 @@ static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
 	struct pi433_device *dev;
 	u8 reg_data[114];
 	int i;
-	char *fmt = "0x%02x, 0x%02x\n";
+	static const char fmt[] = "0x%02x, 0x%02x\n";
 	int ret;
 
 	dev = m->private;
-- 
2.35.1

