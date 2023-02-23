Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482B26A10C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBWTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBWTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:46:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015864FAA8;
        Thu, 23 Feb 2023 11:46:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cq23so46069222edb.1;
        Thu, 23 Feb 2023 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ef/IxwVqWizxA0usa6LnkU7NUiiONXkz62uBg/LMdV0=;
        b=DHpjhYh63B43zvg0u2ye7FkhNr6DMcDzU0v8Dm1bTpckJKsmkMIGJv7V+rPcmepQBF
         udAz1vgLNTHQ1dYC5ct/f33z1N0ny5xl19DFfnNqaRrwms/gFmhzEr+C1G27iZh/G4bF
         mCboVX629DJzjaVurtnSsxSaY8E+bKxPVavDvzvSh6Fv5sll6lbR9bohhdYkuxpr2Uiu
         90HVob01i3LNMs8l0dC6hjfMEq0082vxUez3MpadcZSr6k+fKGoNis0jyHwSf6c0xCsO
         OBpsX8C23nhLDDSrXRnp2AUIlfOVF9f+q6U4vst7em1X9VtWmNl3BJOgfaX/4MVmFKw2
         gLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef/IxwVqWizxA0usa6LnkU7NUiiONXkz62uBg/LMdV0=;
        b=WJTSbZyFW47xtYcpH4U7i4db0gxq9fiG8GYzqaQZi2Pbgqm5jR5QAg4frSAEGmuDR3
         rX4E44Egwy9mJKW3CFzFXDrcjaf57xlYqdKKm0ZKOlAm93at58yEhZwyApmq6YkFTrXj
         GnnhsjJnBKL+YePpmGkr4RxvTxHfw/4WBqRsnBdsBE4ndzr4ADlHnPQy//1OZrikwHl3
         MCuOEyNf8Lpz2hlgzTkuHlMaXDFJyThzgcQG8k7JBqkZyIGXChezcMDTdQYF1yC+NdNS
         2SF8gYrq1fca8JWThftmf5FH1ieU7uxhUe0zRU5FqdLeYvFCXOho/MwZ5zsRG1lgieC+
         NhnA==
X-Gm-Message-State: AO0yUKWq9ZUp7hMpt+vWA8REB9NvJuqlo3rvy496ndgXOPu3PEZ7l6uV
        BFrzGHbDOS8kX1U84JGNB9xIerC+8Fk=
X-Google-Smtp-Source: AK7set/31K5DJ6qn1JJs6uRxQx06XyLdkNkcHNdxs6bHWakbmS54DnLSUgse5hWxoGh8etM4sdztuQ==
X-Received: by 2002:a17:906:d118:b0:8d9:383a:be39 with SMTP id b24-20020a170906d11800b008d9383abe39mr14476208ejz.41.1677181611487;
        Thu, 23 Feb 2023 11:46:51 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b008ee5356801dsm992464ejo.187.2023.02.23.11.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:46:49 -0800 (PST)
Message-ID: <4a18d6b6-a8a4-a2e6-6841-fa78951792e7@gmail.com>
Date:   Thu, 23 Feb 2023 20:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 3/7] gpio: gpio-rockchip: parse rockchip,gpio-controller
 property for bank id
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
Content-Language: en-US
In-Reply-To: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
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

Parse the rockchip,gpio-controller property in Rockchip gpio nodes to be
independent from aliases and probe order for our bank id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpio/gpio-rockchip.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e5de15a2a..47e45299f 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -702,24 +702,38 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
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
 		return -ENODEV;

+	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
+	if (!ret)
+		pctlnp = args.np;
+	else
+		pctlnp = of_get_parent(np);
+
+	if (!pctlnp)
+		return -ENODEV;
+
+	ret = of_property_read_u32(np, "rockchip,gpio-controller", &id);
+	if (ret)  {
+		id = of_alias_get_id(np, "gpio");
+		if (id < 0)
+			id = gpio++;
+	}
+
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

