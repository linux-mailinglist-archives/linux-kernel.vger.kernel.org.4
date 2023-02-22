Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24C69FB21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjBVSkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjBVSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8A3CE28;
        Wed, 22 Feb 2023 10:40:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so8349732wrb.3;
        Wed, 22 Feb 2023 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foDA/GXxUeG6qywVw7pPHlQfm+Orh3kvLzj/my6QoE8=;
        b=B9+WOGfkjvzGfunEXkLYy8KTjSrl99QhGvrJByDf0VqgZLm54rAB8+A9V8YhbSMxEv
         BBVeVV1Kk+uc/mDULVvKuDcXyq/JGZ14j1nhe6Fiqk4cjafKSUB3jOUazpz0YqspXaot
         o1vYvzu4/0RXvgATzshU0UETf2CZIIkkM2YOMMXZb/Y6z6pqxT5LKQYFNsfd3StDvWPI
         jIUEIwgzsmqfLOoEgnnRUMLE54hbtE/zjEspIUang04Lj4OZ+F+IwDpkUW6Xjxnzd/5k
         j8l4oMQcFZTAtrFtuzIXALV+kn6wQE+4Fi+ThhcG3XuAubClZdzey8Y7wEAnJJxKJdZx
         q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foDA/GXxUeG6qywVw7pPHlQfm+Orh3kvLzj/my6QoE8=;
        b=iZX5BryTfvDOinxdygNG7MffPa7cXFQbLToP8lnyCwsYiICByGyMGRNfI8DsIjaOZh
         yJmuO2k1gy4vCIuSBStZ2cyRCQwadumPXIjeIbobx5qHdYl2LUJEENaKuf+yoOaVqJk/
         6VnhW6FX/7f7rz4Ll+YaCqUQ7j4u54YyWojNKg5IAwHvkCCHr6PccvZv8RjrUaE64P9U
         3cntJnwj9JM3TYi4aq0V1/0DuFLKTjvMhZ/ghOoZeMU2d+ON2ZT241GJPQ29/OcCtMQs
         RcogyaHMGwKC+txQ+cLvW0pAC5x72lszK2zBYPtGvJw0lob/yTyjf3Pcls8VGduRXcRx
         5D5Q==
X-Gm-Message-State: AO0yUKXxmh6Mg4S8wtVwIH0yWsX2IOWlZ/q0GgDGXTKsnLSJZdrt0CAF
        hv/7H8BoZaahBQonT0D3o80=
X-Google-Smtp-Source: AK7set9VipcuXxYpnZ45Df1zEkwY+VzCevZIE9fa4nfCbZ7L/fI0ChM6/Zx2yWmI9RnPiMQlYfZ5Nw==
X-Received: by 2002:a5d:67cc:0:b0:2c5:6016:496 with SMTP id n12-20020a5d67cc000000b002c560160496mr8555585wrw.27.1677091199479;
        Wed, 22 Feb 2023 10:39:59 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:39:59 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 01/16] pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string
Date:   Wed, 22 Feb 2023 21:39:17 +0300
Message-Id: <20230222183932.33267-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There have been stable releases with the ralink,rt2880-pinmux compatible
string included. Having it removed breaks the ABI. Reintroduce it.

Fixes: e5981cd46183 ("pinctrl: ralink: add new compatible strings for each pinctrl subdriver")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt2880.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt3883.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 4e8d26bb3430..06b86c726839 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -372,6 +372,7 @@ static int mt7620_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt7620_pinctrl_match[] = {
 	{ .compatible = "ralink,mt7620-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7620_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index eddc0ba6d468..fb5824922e78 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -97,6 +97,7 @@ static int mt7621_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt7621_pinctrl_match[] = {
 	{ .compatible = "ralink,mt7621-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7621_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
index 3e2f1aaaf095..d7a65fcc7755 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -41,6 +41,7 @@ static int rt2880_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt2880_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt2880_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index bdaee5ce1ee0..f6092c64383e 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -118,6 +118,7 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt305x-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt305x_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/ralink/pinctrl-rt3883.c
index 392208662355..5f766d76bafa 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt3883.c
@@ -88,6 +88,7 @@ static int rt3883_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt3883_pinctrl_match[] = {
 	{ .compatible = "ralink,rt3883-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt3883_pinctrl_match);
-- 
2.37.2

