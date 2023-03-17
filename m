Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8003D6BF3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCQVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCQVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A84D433;
        Fri, 17 Mar 2023 14:30:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so25344398edb.12;
        Fri, 17 Mar 2023 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPpFzY0H3ocypf25nzBsMZcz2jHpyh97I8lhoOmDtHQ=;
        b=Oa1shaEabrkzIwGb8LHYQAFL4Ho6oDqeN2TfX7YQ2U+J6nE9MJnwxk8BJXu/Yz7QrR
         7y4b/1bBpU9uhFTVwl4aWiA/sjp7Dng38gIR2xBRj6c36Tvu0R3RcnKdVQrivH/plen3
         fMVh5DVPROQHh7Q9m7pRrOTRKAGzZPVymRJ938lDQtpMLljFcx3OZrkhJgsosj2Qdkn/
         SUTuqYHb6E+DLx7D9cm13g3Sm4ywaP7+gaBnmweMm7BRPWstbU1Hwe6zxnmNn9hC9BQW
         smH1zpvxq5MnPxx1x0pe0W+V988tQMmRuvKrQ5d3RsrL7F4w9XPwhSkP/8tElKFliT6I
         DVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPpFzY0H3ocypf25nzBsMZcz2jHpyh97I8lhoOmDtHQ=;
        b=rW5ICduGZ7LRkzJ/53WE2Gu8EqvsfdOzmpYZaS/D0i1fw6Ha/HBxKnu8S6dm7HWTpv
         dOwtr/9jnTWvUhifYClONH4LLKEPoO2KhYUPcvEUhS6U7Rl2mgAn2EKHAI49NZ+/81CW
         tsG34mf5Oceql5t1uUa2Xky9FNE0tYHj8cnyD/o3dNnpciRJqVqJP/xXBwtL/VqxQaPq
         LMxUNqyhXhRtaqbbX+bYzdO52trbmeO0KU96kDKYCqCxgiTrkNNozjtjIez1cgde9x27
         wAYFhdT1lLDuc7pdAWexJiY6v6Hz9Rt11s4yGmbWY4ZHj8VF6MSIksnUoLB6KE2xv0Il
         V0vg==
X-Gm-Message-State: AO0yUKXrluuG1ip7U/ITQAtNeJdgTzebrnwhXUzJNi7RZNZvTkRYy1np
        ocVi0lNGUV7ShCyWIBwIydA5Q2hic93gxyz8
X-Google-Smtp-Source: AK7set+tHHmi6qkolpcnuJDFVW4c6/ogWFo+Kv7rhpvUnOMQvShD3seRfaKPclm53t3IOgVIbOkX8A==
X-Received: by 2002:aa7:cfc8:0:b0:4fc:73dc:5def with SMTP id r8-20020aa7cfc8000000b004fc73dc5defmr3832240edy.41.1679088621453;
        Fri, 17 Mar 2023 14:30:21 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:21 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 02/21] pinctrl: ralink: rt305x: add new compatible string for every SoC
Date:   Sat, 18 Mar 2023 00:29:52 +0300
Message-Id: <20230317213011.13656-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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

