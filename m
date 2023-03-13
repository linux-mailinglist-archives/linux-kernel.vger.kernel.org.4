Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CEB6B8364
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCMVAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCMVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97D28878;
        Mon, 13 Mar 2023 14:00:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so2406575edd.5;
        Mon, 13 Mar 2023 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB9wsR/QejWKnTpjqpalvhn0ClVxLzlxnCNLg5LJDYI=;
        b=afd4A4/xe/WkNG2sFgtHs1wJZxZIKKLvr1jIY8nlKLuaVg7jtyTD9svMdZf4XKMmVN
         /3V6+meDqA9/F2/mL+tJlrveUtlRyo+cTl3n7mgRj98vdXpoitOeOhnoc68UT9cg5UME
         Qx8NNtLMDUqwZPVmyKd+m/S3Gi5CcW5gci+sIXgTS4Ys0ijPVxFKwWL+5N2iJP52P9X/
         xiuNRPWe+M1Nu3oFR5KE939BJ0zJxixpNPPdeu11ErOB/FOPOh+0pqucvIf95zOVnJO2
         iNDTy3suVlVE/+noa5e7u0NPc4odnrxXgbAwWbKl95WQyzMQd6s+1z+OOXNbwhnVmy9Q
         xtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB9wsR/QejWKnTpjqpalvhn0ClVxLzlxnCNLg5LJDYI=;
        b=mnaV0jF7PIhrF78SqmYy+a2tr9JzdQBQcQBLTLOanvZjzHRyrT27wpXBy5mMUiC/vR
         Iqfe8NM1AVRdz61RwsT+Hs2su2KZdNYBqzFSy86Urcx5Gjdeu2V2/zCLxjUWc6Md5XMH
         Bz+S29xzXFFA6vpRY7f9LqcWT/qa093V6ot4eCUbxYx068JLOIXJemTbYmQD7qRezBhn
         UG71Pg2DfY5/s4WyeEnm1EY5k+SwYP7Xv2NqkQX1qD4dmAHn5062Z9VtrdAvmA9FNkep
         BjacbbpgUqhSX6l3H6wHaD3fhr9gI30+lE6B2YUb/vvqjlmFU3t1R8xmB/dYnlCGtl8M
         NvRg==
X-Gm-Message-State: AO0yUKWM+rEJ9h9KemQNIuLbrlkSxczcGIPH2uhPkQAtBvAc0ZMxVse9
        TM/ywTs+9jZXUBAvvYjmTzA=
X-Google-Smtp-Source: AK7set9YtEmB8iR180enMLgbiiGYN9pPMD6nTSjLxbpr8YHc+lGhtd1Zp7BuvrnYuwG7OxudpCqSKQ==
X-Received: by 2002:a17:906:3197:b0:8b1:3293:ead2 with SMTP id 23-20020a170906319700b008b13293ead2mr39965925ejy.25.1678741204635;
        Mon, 13 Mar 2023 14:00:04 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:00:04 -0700 (PDT)
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
Subject: [PATCH v2 05/21] pinctrl: mediatek: remove OF_GPIO as reverse dependency
Date:   Mon, 13 Mar 2023 23:59:05 +0300
Message-Id: <20230313205921.35342-6-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
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

The OF_GPIO option is enabled by default when GPIOLIB is enabled, and
cannot be disabled. Remove it as a reverse dependency where GPIOLIB is also
set as a reverse dependency.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index ba21a599953c..ee04b1af36dd 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,7 +17,6 @@ config PINCTRL_MTK
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 
 config PINCTRL_MTK_V2
 	tristate
@@ -35,7 +34,6 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
-	select OF_GPIO
 	select EINT_MTK
 	select PINCTRL_MTK_V2
 
@@ -46,7 +44,6 @@ config PINCTRL_MTK_PARIS
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 	select PINCTRL_MTK_V2
 
 # For MIPS SoCs
-- 
2.37.2

