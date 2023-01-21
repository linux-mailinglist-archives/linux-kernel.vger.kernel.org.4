Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2481D6765DA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAULIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAULIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:08:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D8521E2;
        Sat, 21 Jan 2023 03:08:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vw16so19794090ejc.12;
        Sat, 21 Jan 2023 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3b7+rhgpzwNviPg8rPLBXq+7U8FJNnHoMKxitjzZvU=;
        b=lLQotlq9YYZaxdFooJZBoQlundnE/fFNTBIAufPgr/zxzvpq8RhkaAMbyjX8ENQCop
         tODPr0V5RMIZq/b5tIbV3IsWQRH6obQHk+BNmMuhdk5yAQ9btE29bAlUeR6HOtpgCuBC
         6eXGrsSfDpkHEnVPCFyumF++ZUi7v6uwIHKvnF2AhVAslIstX/Oqwir4n2aOqy1JKxkx
         EBy0n2A+hY6c8mLUaSQNtZRIZ2RSPYnCgkgS4PmDKxG5z1nDlraagUPFNHiHexp82r8d
         1rOTi8wtBlShKMGtZG9xUY/j7yOH546QcLdreQyhXrcTi1wTVwp2+6JvJrPz8S+HtGXZ
         pi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3b7+rhgpzwNviPg8rPLBXq+7U8FJNnHoMKxitjzZvU=;
        b=0s1qkXd4oz6UFER2Q5kLnL4cOHRCg3ctqYhhltIuFtE74JfOaZj6f/yVNWzBweX28A
         264GaNNhMjV//1k3iil3CfUwL4bf4DYuFS0EpwbIKO1OShRJzFeruOG37ht9rf/b7yHg
         cAapeGVkP7dGeO8yIMW19HT6QNAItZdo8Tf/SqtlvVRextShu9zd2fImYBifWQ9Ww0vz
         seqHZqXavXux95kBEqFCTXOX6lPTwfLY8ID9xLkNQib1a/JvScXxVElGliw264/oQSYj
         dsdn9XoEGVMoJaQdv02nHyZpNaVvNWkHmx5e42Yv6AXN2BCBccXKh8vogQiqJiGaoOMe
         kUeQ==
X-Gm-Message-State: AFqh2kq/sBrp3s3voGavCU8/aRKVkAu5cQKw9/hacxp7fUCBKQvBdMlr
        T1JagPR085AWsKzvheA2Thc=
X-Google-Smtp-Source: AMrXdXvnOIE3+iioq9IO2ZumHcM3PA+mj8N56wKlF2oayqC2u2XW5HIy0DBO2GVHGowlLY8GH4BASg==
X-Received: by 2002:a17:906:1605:b0:872:41a5:7c78 with SMTP id m5-20020a170906160500b0087241a57c78mr23807819ejd.3.1674299319795;
        Sat, 21 Jan 2023 03:08:39 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id vo13-20020a170907a80d00b0086a4bb74cf7sm11582476ejc.212.2023.01.21.03.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:08:39 -0800 (PST)
Message-ID: <890be9a0-8e82-a8f4-bc15-d5d1597343c2@gmail.com>
Date:   Sat, 21 Jan 2023 12:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/8] gpio: gpio-rockchip: parse gpio-ranges for bank id
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Language: en-US
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the gpio-ranges property in Rockchip gpio nodes to be
independent from aliases and probe order for our bank id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpio/gpio-rockchip.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e5de15a2a..df74b71aa 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -702,24 +702,36 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *pctlnp = of_get_parent(np);
+	struct device_node *pctlnp;
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
 	struct rockchip_pin_deferred *cfg;
+	struct of_phandle_args args;
 	static int gpio;
 	int id, ret;

-	if (!np || !pctlnp)
+	if (!np)
+		return -ENODEV;
+
+	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
+	if (ret == 0) {
+		pctlnp = args.np;
+		id = args.args[1] / 32;
+	} else {
+		pctlnp = of_get_parent(np);
+		id = of_alias_get_id(np, "gpio");
+		if (id < 0)
+			id = gpio++;
+	}
+
+	if (!pctlnp)
 		return -ENODEV;

 	pctldev = of_pinctrl_get(pctlnp);
+	of_node_put(pctlnp);
 	if (!pctldev)
 		return -EPROBE_DEFER;

-	id = of_alias_get_id(np, "gpio");
-	if (id < 0)
-		id = gpio++;
-
 	bank = rockchip_gpio_find_bank(pctldev, id);
 	if (!bank)
 		return -EINVAL;
--
2.20.1

