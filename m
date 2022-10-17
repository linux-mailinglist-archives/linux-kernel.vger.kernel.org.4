Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4C46013E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJQQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJQQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:50:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AC5AC53
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:50:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y14so26255627ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drbnWG6FnPMKy+1KjZWfuBI6Wm/8lttgnizdA5I4wh0=;
        b=KuVlSmIb+mR5CV6eITXFG6u2+ges8sQgbxnm+3vT1lBOjzQyKbr7eP/m0ySlkX1gPv
         yqRF3Zo8/T7hNqNhLfcWvnEEoYlhY4e6I+bT2Mfh1zGb5qHdQs9PpcpjOrF/mLdw3YtZ
         4R153dfRrrKX3ZgPrqYnNF/NRVzUiyp09gv7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drbnWG6FnPMKy+1KjZWfuBI6Wm/8lttgnizdA5I4wh0=;
        b=eS+/L5CeoKPBoIIQeee1WUxHALwpNS1Ksbc1MXJ9lUXfLqAkKaZL8+o7VCCbWbqrek
         xUPLH0EW7Tkh8/jU/9A0Y5hpmyCCBua2ohaUfDo308u+VqwYaira3G3Q8VgCu1clET+Z
         nxPp+gzfLKQ9Y2nbBZbscCc2eW2Ho3rvB76bhhCllFZw3LNwIgpvi0PuMG5yZeZYc9mG
         L8knTkkHPqUxylb9wlB5+6JVsDEF/jRNLV9TDToUMMmZXRNT0TjknAZgNZH56gmbajFb
         rvDDqt8EAh+Zg1VCfw0dUvVOCLfm3KTudIT3oenY/uoFcU6YRkBtSQ+fal1P3T1rFBY6
         GlJw==
X-Gm-Message-State: ACrzQf1LbxHnsKiilXFMkNz4QLiNnbg6GXtIwR+AYWwzFn5SoFudgLtT
        NNtGG+x7lTcg9et9M3v+G4i40vczZmMGIA==
X-Google-Smtp-Source: AMsMyM4GZiprC1PluXKiH0yH3vdFd+AeS3g/ZUhBCEiazBbo/4ME6PSXDI3ILqtbg7C+DWfkoNbZRw==
X-Received: by 2002:a17:907:2d1e:b0:78e:2c3b:559f with SMTP id gs30-20020a1709072d1e00b0078e2c3b559fmr9375041ejc.435.1666025431720;
        Mon, 17 Oct 2022 09:50:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-101-110.retail.telecomitalia.it. [95.244.101.110])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906774700b0077086d2db8esm6473027ejn.140.2022.10.17.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:50:31 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] clk: ti: dra7-atl: don't allocate `parent_names' variable
Date:   Mon, 17 Oct 2022 18:50:28 +0200
Message-Id: <20221017165028.4194254-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `parent_names' variable was freed also in case of kzalloc() error.
Instead of modifying the code to perform a proper memory release, I
decided to fix the bug by not allocating memory.
Since only one parent name is referenced, it is not necessary to
allocate this variable at runtime and therefore you can avoid calling
the kzalloc() function. This simplifies the code (even calls to kfree
can be removed) and improves the performance of the routine.

Note: Although no operation is performed by kfree() on a NULL pointer,
it was however suboptimal and semantically wrong doing it.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/ti/clk-dra7-atl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index ff4d6a951681..ec2473069143 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -164,7 +164,6 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 {
 	struct dra7_atl_desc *clk_hw = NULL;
 	struct clk_init_data init = { NULL };
-	const char **parent_names = NULL;
 	const char *name;
 	struct clk *clk;
 
@@ -188,24 +187,15 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 		goto cleanup;
 	}
 
-	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
-
-	if (!parent_names)
-		goto cleanup;
-
-	parent_names[0] = of_clk_get_parent_name(node, 0);
-
-	init.parent_names = parent_names;
+	init.parent_names = of_clk_get_parent_name(node, 0);
 
 	clk = ti_clk_register(NULL, &clk_hw->hw, name);
-
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(parent_names);
 		return;
 	}
+
 cleanup:
-	kfree(parent_names);
 	kfree(clk_hw);
 }
 CLK_OF_DECLARE(dra7_atl_clock, "ti,dra7-atl-clock", of_dra7_atl_clock_setup);
-- 
2.32.0

