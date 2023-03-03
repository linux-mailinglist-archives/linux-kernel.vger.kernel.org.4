Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2666A8DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCCAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCCAaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:02 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653559431;
        Thu,  2 Mar 2023 16:30:00 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b10so813434ljr.0;
        Thu, 02 Mar 2023 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0V8gGwG4F8KBp545Lv3/ljJ2Ow7XQ9likzzC+tBuUA=;
        b=pUQwRRXlmWsUaWpHVdXbMAbgsJbT9jxb6RuCj4j6BBhw9kbRtS769Y18ye06N7/k4+
         apU+Tg9rAfRps+EO7ZLmdPLZutbl1uvSfL2DJcYnsiwsC4vKPs01GaB3BHcdPrWGavva
         RHfggMd0htpGunfcKvB5IJj9srQlEpWVstHSWINXogrUaTF2R3IVH+oOO34hUILOlr6I
         GQYNXkVBYkwQmsdOpV0+Lw0jtkTVSAdV1I9IGUYkOItdIF/GGt6bUxTqUBqtEJgqI9k6
         YLE+m9fya255BxiMxILyOlef+O8ENrMC0KGuRc014Q5288bpE3r22UGlGA/7ldZvVuUv
         j+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0V8gGwG4F8KBp545Lv3/ljJ2Ow7XQ9likzzC+tBuUA=;
        b=SAFAeDifNhS1Shewc0b8XhOzkYV7TaVyfGQUD+lNYuF1NmyANWZDyNkmjSlIvlsJZz
         s3bDFZS0cH60jEBpMQn0tQzuPRPFW+qjIhOXf/0KGeN45naqlmwJ20lpsvPrWDHMGq+d
         QsVTcfTt5WLbULP4NwwwsZ7Fw7q63u+291xiSLLevzi5OBo5SjDI6o+EVEa6aLYx1vhs
         uqq9IPheKtDy6OSOKmZXSbESa9/OKxtgiXWh/rh5nAiRfjylwabzC7j2zB+V96Tt+VPt
         4iY0vdfJpBB6b6O8C8jEj9nnybk2TdlKnnMFh+1BeCOpbnOov12bCJp2UMBdcIjLQ5t8
         kX8w==
X-Gm-Message-State: AO0yUKWukjTBI8Jd11hvlJL9PKuaH2Mr3HLBM5+LJVxXLooFR7MyjpqR
        u/WsQC7+GPF1QIeYwIKRRrM=
X-Google-Smtp-Source: AK7set+DZD+U7yW1QEwtAyid3F/XilrETaVv6RFqKTU9SJ2UOCysI6OFCwS5SucE8Rc3p9xbSDUM5w==
X-Received: by 2002:a2e:9108:0:b0:295:a96e:4f22 with SMTP id m8-20020a2e9108000000b00295a96e4f22mr3441868ljg.17.1677803398121;
        Thu, 02 Mar 2023 16:29:58 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:29:57 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: [PATCH 03/20] pinctrl: ralink: rt305x: add new compatible string for every SoC
Date:   Fri,  3 Mar 2023 03:28:32 +0300
Message-Id: <20230303002850.51858-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
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

Add new compatible strings to make every SoC, or SoCs that use the same
pinmux data have a unique compatible string. This ensures that the pin
muxing information of every SoC, or a set of SoCs that use the same pinmux
data can be properly documented.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index f6092c64383e..fa3743c7680f 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -118,6 +118,8 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt305x-pinctrl" },
+	{ .compatible = "ralink,rt3352-pinctrl" },
+	{ .compatible = "ralink,rt5350-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-- 
2.37.2

