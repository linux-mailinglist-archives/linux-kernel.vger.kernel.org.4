Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8175E6CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiIVUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiIVUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:02:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA350E5F81
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:02:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r125so13759269oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6GEnGDXKgf8y5MvWwFcSCEJi0TIRC8+QFeqPvewuV3s=;
        b=c4znf0HyHYIAVnFgJOwDYsL8l/ggxvuptGi78A1qZT7Tx9KLoXJqfIg0XZ3KMB0sRv
         jl+lXz9rr7JgZ18NJSBao8+TER4RE9jIW+j+8FoXRCGNZsa3jbAHcbh2OI5dBWYBn+ln
         ye5TtjRvbWisAdChgxtcnyfCm3hAwPgO+n/If3QEMdlUwKjjPH/cVr2rf+HTjMmaHO92
         aUiUoll7CzlsE4Njj2l4Enyknr4dnUzpKJrCS+SS4DuWBmGpPydcJbI6EqdLihDC6A2e
         zUaGvMJbQwjyvx0oR7PqMnZyxaOxc1rgMHdecAMVrgIvKgDKQAqBk4CMHj3uxHz2FsaX
         FTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6GEnGDXKgf8y5MvWwFcSCEJi0TIRC8+QFeqPvewuV3s=;
        b=SmQqDfuzqhBqv03doxNcr1dYmvMqHnbf3U2BklJBGeqJpQx370ev7puBBZLhe7LuHR
         YpH+x8QLtXQbOZGHT2QpIP4xoQgVrUi15xFqWXP9EJzOLBAwVMKYyHnox+rJ/5TU2GYv
         HGF4TXQLQkdmUnHjBJi12VfclweG0Aaem6/GZ4AlmolT/jh1afr787s1myjjFu24vrWO
         +PXRFa4BewJfgRkaCVv7JqQ30JRgVNBmaoWx3PgdIkwYjB1bX1v558xCspFlV1DBAKsb
         MD7jlLEEhY58u6U77UfdU2OWRSdsGHHkEMT0tf8shp0z/gwdQxyIeBGprIgjtA81Uy97
         a0Ww==
X-Gm-Message-State: ACrzQf35SjNF2XUk5mFvAd+HJWaMszbIXpC/oljOoz2yL9CzMTVVbPqg
        OnslNJ1UocL8X0i6QtOn3uw=
X-Google-Smtp-Source: AMsMyM4PsMgFjzEFdviyMBaSg7st+pFVGM0NSZeBaBhXV9JefdVpkZe1zY1bGd3AAKVSyeTgHIg/rw==
X-Received: by 2002:a54:4182:0:b0:34f:f1b4:5421 with SMTP id 2-20020a544182000000b0034ff1b45421mr7115657oiy.146.1663876946219;
        Thu, 22 Sep 2022 13:02:26 -0700 (PDT)
Received: from cat02.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q128-20020acad986000000b003458d346a60sm2809969oig.25.2022.09.22.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:02:25 -0700 (PDT)
From:   =?UTF-8?q?Luciano=20Le=C3=A3o?= <lucianorsleao@gmail.com>
To:     seanjc@google.com, bp@suse.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, n@nfraprado.net,
        mairacanal@riseup.net, isabbasso@riseup.net,
        andrealmeid@riseup.net,
        =?UTF-8?q?Luciano=20Le=C3=A3o?= <lucianorsleao@gmail.com>
Subject: [PATCH] x86/cpu: Include missing header
Date:   Thu, 22 Sep 2022 17:00:54 -0300
Message-Id: <20220922200053.1357470-1-lucianorsleao@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the header containing the prototype of a global function,
solving the following warning:

 arch/x86/kernel/cpu/feat_ctl.c:112:6: warning: no previous prototype for
 'init_ia32_feat_ctl'
 [-Wmissing-prototypes]

This warning appeared after commit 5d5103595e9e5 ("x86/cpu: Reinitialize
IA32_FEAT_CTL MSR on BSP during wakeup") had moved function
init_ia32_feat_ctl()'s prototype from arch/x86/kernel/cpu/cpu.h to
arch/x86/include/asm/cpu.h.

Note that, before the commit mentioned above, header "cpu.h"
(arch/x86/kernel/cpu/cpu.h) was added by commit 0e79ad863df43 ("x86/cpu:
Fix a -Wmissing-prototypes warning for init_ia32_feat_ctl()")
solely to fix init_ia32_feat_ctl()'s missing prototype. So, header
"cpu.h" is no longer necessary.

Fixes: 5d5103595e9e5 ("x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during wakeup")
Reviewed-by: Nícolas F. R. A. Prado <n@nfraprado.net>
Signed-off-by: Luciano Leão <lucianorsleao@gmail.com>
---
 arch/x86/kernel/cpu/feat_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 993697e71854..03851240c3e3 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/tboot.h>
 
+#include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
-#include "cpu.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
-- 
2.30.2

