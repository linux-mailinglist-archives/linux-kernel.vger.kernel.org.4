Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49241621EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKHV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKHV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:58:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472C1209E;
        Tue,  8 Nov 2022 13:58:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso67879wmo.1;
        Tue, 08 Nov 2022 13:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbmtzZutOKwlENbTWZlqhwmsnDeYsEDLq4PdapbJAAw=;
        b=nvTIwewH7mb2ir7sT1fwaZuAeSueQGU8ZeI9gcWcFu+D0SqtrGtESQzxqMCPtmsNKH
         yD1V8nIAlf8X1os1cdL4WGp7j4v4UvxzQCnME3BZHWOs+IRAj4aGau2Fa4k1GvUe1zEl
         9tAW0c/39/FTZzuEz4WKdRPEFIzJNrGB4PJCjZmiJ6/jIJABsWejtiKdLV1NyNvBOQW1
         0ZqH1erSaiAy7Lz1ruV97yCk57+giGbCDV76DTKZdMDNIQdLW59iMVA4Yg2arzSLK/Db
         5LG59wcNRhWWqOWVUOHGmUats6+CzVMkxzWtWiL3Qw0dC4HIPlIOHgFQDtuMlpm62ZTy
         r4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbmtzZutOKwlENbTWZlqhwmsnDeYsEDLq4PdapbJAAw=;
        b=6AjYDc3qAKIQBCQZtjvWyDBM5sMd6SyoEuoEDjszU/Z1ZMX3/d6YNplXmXSNadHR+F
         sL7R/PeHabOBGVaG5vHi3ZqVTymt9D6L8adUJGsS4KMEsw27NGTQPLkLLlZoLeeo6aGR
         40tRy6ZB9MXOVPXF8XBpcOXrNjNQ0wA6AM6PzIpDxZQcx/3h9Pkf9JR0aDZ1WQP2fbCw
         PQVshptFz2o71vRTZK6P3YsdXXXeVRVn6l2XM0UeUmHp7L293iMgFEENUMxlS0ofIRB1
         8sC6LBjesV27tV37Dao+uuetSQolg76Zn7k820EXyyN4DA+MeNZ6sd7HSSIR8yf7a7OA
         85QA==
X-Gm-Message-State: ACrzQf1FqAa2VmD/p0f74+ASRTtjhNYB+Cnt9xK7Y31sx6je/pOgiunS
        mwQLqDaCaqJRXR5B6wgmo/iHAOxnmBc=
X-Google-Smtp-Source: AMsMyM6c7KyrcM8fqO36Uo/SlhmIW004F1Awzeni7Y2GtGV/CRoDFY0/hPXX8V7F0gJKBfIZK5ASqw==
X-Received: by 2002:a05:600c:21d8:b0:3cf:69ec:9628 with SMTP id x24-20020a05600c21d800b003cf69ec9628mr816509wmj.79.1667944713140;
        Tue, 08 Nov 2022 13:58:33 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id bg20-20020a05600c3c9400b003b4ff30e566sm98761wmb.3.2022.11.08.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:58:32 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] clk: qcom: krait-cc: use devm variant for clk notifier register
Date:   Tue,  8 Nov 2022 22:58:27 +0100
Message-Id: <20221108215827.30475-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Use devm variant for clk notifier register and correctly handle free
resource on driver remove.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index e91275663973..33a78b7de0bd 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -64,7 +64,7 @@ static int krait_notifier_register(struct device *dev, struct clk *clk,
 	int ret = 0;
 
 	mux->clk_nb.notifier_call = krait_notifier_cb;
-	ret = clk_notifier_register(clk, &mux->clk_nb);
+	ret = devm_clk_notifier_register(dev, clk, &mux->clk_nb);
 	if (ret)
 		dev_err(dev, "failed to register clock notifier: %d\n", ret);
 
-- 
2.37.2

