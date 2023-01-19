Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD8673AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjASOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:00:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F97497D;
        Thu, 19 Jan 2023 06:00:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vw16so5831968ejc.12;
        Thu, 19 Jan 2023 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nhXtkwWxCqczJgyl/G+oVIZHRqmQUVsu8qAe4yutDM=;
        b=qRn/j0NfPcUBhFkrjwPaRG0kfnyqomU5L8Uu0C0yP4/kno4f2gKw9fqzUnwuLa0u2d
         LpDpaY1Z11XegkqV+ezn5bg+YcrB748Biq2Lm2W0GKovSY7MfAgdMiNU0+OFgbM0KLnL
         T1si0aFYmOApa5wDuVDy4YpUuUHG8o2qwYhvmpjNINmyZUkbo1JxVUzKG+gsXK7e8/SP
         ShenOdA2tPFvW96PkVDjZirvLbw6x4eWLFSug8CUqGocAgmnGMQe2o0yEreu/gJCNNVA
         xV1pwTO51DTg2JbLQsmQyR///MwV9MkLie8263npBOnYvvU6VHu/6a/N7Bq3HMppRhK5
         Z7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5nhXtkwWxCqczJgyl/G+oVIZHRqmQUVsu8qAe4yutDM=;
        b=Sz+l4EJv2iyfxxatc59wdtRdVJLkjbx5EfWJaVm0fhIjNBKn7BLEvCUh/XVOjwAE3U
         FFLxPuu/PEzSwIFbQ7iVELoObJkGMH5aiLHPgOFqq2Y5VGFSYeFFAKuhalwIoz0wKyf+
         94ueqIOupouWM8MfUmerlJCL7uOBjmMsyTtnyA/jksLUQAHt0ye5tNFjyH/kHFpuA1Gj
         gtl2VBvl0dBLPUTuEnoSsrW9M24U9cOBVG9B8BJH5L9I62GvXXj2zdvF3Aof1G3UY31h
         ionmUJR0vV3y6J8XJOvA0N+Y6Vzoj36bMs+w+7Ri+KVHk0nXRYeQ3DAajm3XfGr08mFT
         u3hw==
X-Gm-Message-State: AFqh2kqegkcrM8+b61b1pnu4I201QVAJLfuZxKrYraC6sQTn3fu57hoh
        NTJN2g7redh4qR/uUtFwK4x6Pf/5nIQ=
X-Google-Smtp-Source: AMrXdXufIwdwaQ4Q6337XG0zwWnwHq5J4E6m2rvnrrrcYS8U7J9jbLgUuUFelGA26kq69th2z+hltQ==
X-Received: by 2002:a17:906:b806:b0:84d:430a:5e63 with SMTP id dv6-20020a170906b80600b0084d430a5e63mr11123910ejb.27.1674136827752;
        Thu, 19 Jan 2023 06:00:27 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id mj19-20020a170906af9300b008776e2fccfesm1105409ejb.72.2023.01.19.06.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:00:27 -0800 (PST)
Message-ID: <91a339b3-f233-d7f6-54d8-061b1cd6a6ba@gmail.com>
Date:   Thu, 19 Jan 2023 15:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 1/3] gpio: gpio-rockchip: parse gpio-ranges for bank id
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
Content-Language: en-US
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
 drivers/gpio/gpio-rockchip.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e5de15a2a..3eaa1a5de 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -706,6 +706,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	struct pinctrl_dev *pctldev = NULL;
 	struct rockchip_pin_bank *bank = NULL;
 	struct rockchip_pin_deferred *cfg;
+	struct of_phandle_args args;
 	static int gpio;
 	int id, ret;

@@ -716,9 +717,14 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	if (!pctldev)
 		return -EPROBE_DEFER;

-	id = of_alias_get_id(np, "gpio");
-	if (id < 0)
-		id = gpio++;
+	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
+	if (ret == 0) {
+		id = args.args[1] / 32;
+	} else {
+		id = of_alias_get_id(np, "gpio");
+		if (id < 0)
+			id = gpio++;
+	}

 	bank = rockchip_gpio_find_bank(pctldev, id);
 	if (!bank)
--
2.20.1

