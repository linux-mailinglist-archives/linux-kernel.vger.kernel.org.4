Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AA622113
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKIA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKIA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:56:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BF627C9;
        Tue,  8 Nov 2022 16:56:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j15so23545134wrq.3;
        Tue, 08 Nov 2022 16:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb5gpABVn01LzpmtL4kWa1L/Tu5YX24/NkCX3qOrieg=;
        b=i9ZhUFUHgiBRSBtCiod+bre3frI5LjE8Nt+xlMbMGtA1IMGvfsBOfv5dIBJeaW3c+h
         i27DNMxKwxq7rSEZfbR9pAB8jLklAmnIQZOqzaANE8Plf5Dp6ALI4TYlgMjbNpA6ZGbO
         yRda1YqoQgd9BqH2bmJxCbhkC5ogAD9pFOwIhHW63hJOW5qbUHhf8vXLA1gY3eJB4VI+
         rOckQpTKZRGRNZCZ032yXXLP7i7pF6F2NcV6U+AbDTxPoE7wxOB9xJ9CTvgR3Tzc3Drh
         UL4KMaj1Q/WeukfWehBVawpheyQbUKzM8EJwwVdN6cMbew9x9mMGwIet9ZRX7Az0GQEA
         Zyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb5gpABVn01LzpmtL4kWa1L/Tu5YX24/NkCX3qOrieg=;
        b=ORwOGHgWrGVQQkuss8xJsQJS9m3rtxXmBY7fxt2bkmod+rcfIMjG4klK61XzH4wxtk
         fzHbBnzaZgd5/PPGE/1P+j5/8vc6rQo1Scevm6TYaClLRY8BTr/6C65Ozi4M88ikz1YY
         OcZZrsw+MbC+xGLRedQJckW3iRLgTQQNJTVMPnZwzPv/GKwCvbJpHzPJAEqf4RFfEH5X
         A4yeUG88ceErkloillY5plKA89HZ0qJAVZDIqaKk5ugmmpMitWQE1l/lgR5swNBpg/nK
         jwY8SHPLhfzShcn8+b0iZwaX93xHQpPtvlEZZjKs3Wm+FKbFlZAMjM+rq57AoiWrmcQ4
         IZ0Q==
X-Gm-Message-State: ANoB5pmyleoLTxVqbj5m1f6nfP3LKGuy2IzwWYJzwDLBhBAwB484p1xS
        WXa9ZOPlz7z1N+rniWyPhFU=
X-Google-Smtp-Source: AA0mqf4xBmbi68GzNNSOnmZniPp4snxp3vJ00b4b9jVqqUNSCWh7t3WtJ9Q4qhjd31lOhT3D412mBA==
X-Received: by 2002:a05:6000:50a:b0:240:5bfa:c71b with SMTP id a10-20020a056000050a00b002405bfac71bmr10341370wrf.513.1667955397443;
        Tue, 08 Nov 2022 16:56:37 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm14130285wrp.0.2022.11.08.16.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:56:37 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/5] clk: qcom: krait-cc: also enable secondary mux and div clk
Date:   Wed,  9 Nov 2022 01:56:28 +0100
Message-Id: <20221109005631.3189-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221109005631.3189-1-ansuelsmth@gmail.com>
References: <20221109005631.3189-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
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

clk-krait ignore any rate change if clk is not flagged as enabled.
Correctly enable the secondary mux and div clk to correctly change rate
instead of silently ignoring the request.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index c2a261cfeb6a..0e497e69e3e3 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -80,6 +80,7 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 	};
 	const char *p_names[1];
 	struct clk *clk;
+	int cpu;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -103,6 +104,17 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 	}
 
 	clk = devm_clk_register(dev, &div->hw);
+	if (IS_ERR(clk))
+		goto err;
+
+	/* clk-krait ignore any rate change if mux is not flagged as enabled */
+	if (id < 0)
+		for_each_online_cpu(cpu)
+			clk_prepare_enable(div->hw.clk);
+	else
+		clk_prepare_enable(div->hw.clk);
+
+err:
 	kfree(p_names[0]);
 	kfree(init.name);
 
@@ -113,7 +125,7 @@ static int
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
-	int ret;
+	int cpu, ret;
 	struct krait_mux_clk *mux;
 	static const char *sec_mux_list[] = {
 		"qsb",
@@ -165,6 +177,13 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	if (ret)
 		goto unique_aux;
 
+	/* clk-krait ignore any rate change if mux is not flagged as enabled */
+	if (id < 0)
+		for_each_online_cpu(cpu)
+			clk_prepare_enable(mux->hw.clk);
+	else
+		clk_prepare_enable(mux->hw.clk);
+
 unique_aux:
 	if (unique_aux)
 		kfree(sec_mux_list[0]);
-- 
2.37.2

