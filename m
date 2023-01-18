Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0C671CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjARMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjARMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E532534;
        Wed, 18 Jan 2023 04:14:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx13so24376541ejb.13;
        Wed, 18 Jan 2023 04:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wtk2BXPwNgByM5zuDKe4rCk59dgrkS/p4SHrhV34oT4=;
        b=dRbLYQYxGRZ9Qu14o1s800Vn/SHB+wdv54SmGe1yNc6KvREEPnXhkbtebRRmvk1H01
         sLNE3xiLyhr1qi4t3owWDec2qXeSfbaFyLSyKiuXv1066wfMg6cY4OrdgbJXX0+g/2QO
         V5G1W6BMQCdAL6+T6kdEyaXFs684e6roz1FX3O8VnY4iSiJMeX13W3Y39q4jnmyz7vj8
         g6frVN9d3Vzb7E/IQP6PM8gLuc9emKDFQg9dqix6PiXtyyMvarllngsiKid65dWz6mh3
         qhmXv/vtUUkcYMs0Dm0nOEhjb4pDkuu3XykFnZvryWJIsycHJixvjhNROFo6jws7q00Y
         mRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtk2BXPwNgByM5zuDKe4rCk59dgrkS/p4SHrhV34oT4=;
        b=2r1TT3UZX86Wv/koj5JYQONClex6Zj5tTPpnir/355UQYSSCJr+4nbTRgBnBqJbDde
         WbfOLWGNuvKmHNF1kLByIBXjxHXhIPsK5E1mX+MHQhAVVS+IS0JoXy8+XceGDqEnusDb
         7QtVkDfXThkdzWcxEm3VAHL5n9eGnZiP9Z8NMPn37leNblLxm47vH6eYyKaZB/rk/EkY
         TQfgV+9Sj6P2XKnClaqpZZeq5EfW7OyQ5CabCW53uLXM9WKg21CAQs1xXqX+9A/KD5vn
         5kJvGYOCA1z5Y2/xSEAIynknU0zMexdSuYcVmIsrXSvCKcbO34n13EfxnOWV6r9zEBNe
         Bs/Q==
X-Gm-Message-State: AFqh2kpfye49WpInKIz09lbfFi5GFeINNF+t+LULEciPGhiSMcOt6X4K
        01VJVeuZyUJTjqZo4c7Cpto=
X-Google-Smtp-Source: AMrXdXu3ryT88FGN3wUf7V2cIxHrNWhBqBVLCkTTIVRybrZmip9rTMuXztjMFNnmW2eoyyhhuHQ3xA==
X-Received: by 2002:a17:906:dc44:b0:86d:abca:3f55 with SMTP id yz4-20020a170906dc4400b0086dabca3f55mr14748187ejb.15.1674044089413;
        Wed, 18 Jan 2023 04:14:49 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007c16f120aacsm14448690ejn.121.2023.01.18.04.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:14:48 -0800 (PST)
Message-ID: <1510c02c-f640-9924-e42e-fa34e28a580f@gmail.com>
Date:   Wed, 18 Jan 2023 13:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/4] gpio: gpio-rockchip: add compatible string per SoC
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
Content-Language: en-US
In-Reply-To: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
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

Currently all Rockchip gpio nodes have the same compatible.
Replace all the compatibles in gpio nodes to be able to
give them a consistent ID independent from probe order or alias.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

For now only add new compatibles.
No changes to rockchip_gpio_probe() function yet.
---
 drivers/gpio/gpio-rockchip.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e5de15a2a..493207de1 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -790,7 +790,22 @@ static int rockchip_gpio_remove(struct platform_device *pdev)

 static const struct of_device_id rockchip_gpio_match[] = {
 	{ .compatible = "rockchip,gpio-bank", },
+	{ .compatible = "rockchip,px30-gpio-bank", },
+	{ .compatible = "rockchip,rk3036-gpio-bank", },
+	{ .compatible = "rockchip,rk3066a-gpio-bank", },
+	{ .compatible = "rockchip,rk3128-gpio-bank", },
+	{ .compatible = "rockchip,rk3188-gpio-bank", },
 	{ .compatible = "rockchip,rk3188-gpio-bank0" },
+	{ .compatible = "rockchip,rk3228-gpio-bank", },
+	{ .compatible = "rockchip,rk3288-gpio-bank", },
+	{ .compatible = "rockchip,rk3328-gpio-bank", },
+	{ .compatible = "rockchip,rk3308-gpio-bank", },
+	{ .compatible = "rockchip,rk3368-gpio-bank", },
+	{ .compatible = "rockchip,rk3399-gpio-bank", },
+	{ .compatible = "rockchip,rk3568-gpio-bank", },
+	{ .compatible = "rockchip,rk3588-gpio-bank", },
+	{ .compatible = "rockchip,rv1108-gpio-bank", },
+	{ .compatible = "rockchip,rv1126-gpio-bank", },
 	{ },
 };

--
2.20.1

