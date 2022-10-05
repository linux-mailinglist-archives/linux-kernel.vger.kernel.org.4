Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED35F5940
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJERoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiJERo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267177E03D;
        Wed,  5 Oct 2022 10:44:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay36so11252122wmb.0;
        Wed, 05 Oct 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s74OAcrnJmEwMIg5y8kD13FcfZI0oHtteoKyxHIc6vU=;
        b=DRMySqDqwjrbpH70gOwqe0WMGRTSDMFh8/yL8ljpndp7oyx4hSQIulbomwARRFYlE7
         WNzFT6jUCXwOwSNWqpb9EQYxTCF6mGPD2cGVkfcZx0tF/Pdm17wVwtivzwCayG9LUQFA
         x2ZOVQuVKBVcTRyfcDnXDlpkjFDCs7adnnmhKy7kinx3CXVjmr/q/PuN+BR4b5l2l4xU
         u86NoTByjk/y3+tFTM763rnbjP0jE/Bi13WWOP+SMhGRGYQEjl/w04YKZ8i3dbh7Vnlg
         VuAdpmFh4QzZV86dhCLi1/A6deyPOGN37M11+TcBA7Ic3RPIJ9+hbH6mIOohuJpxFiCK
         yBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s74OAcrnJmEwMIg5y8kD13FcfZI0oHtteoKyxHIc6vU=;
        b=adhtOieFN7qA2t0h+RRvgwDdp5k1mA7UARMoGagg/criNFZR5YVQIIMRSdENUwS58h
         AY1HLohE42q+7e4XxNFMvvkDcE1H+zkWZcJvEBQYFZGVshKsyL5JLJiC9OFYE6u68Qjh
         kgoPSlN0PWGNcTC0vd83/Tg7y4cm9pBT/RzJITBqPDC9QlKrdwMCQgagcYL53qz6WHkb
         xRsjkp4AXqnxsJI19PAF62Fp0d0UQdYKc9D0+xr2ftVyciOdytWMOOwwn3eZt103NzBd
         Mj66Tbw8numd8Ib/YHU8G/OOJvr23rbzks/DPDh+ULshKEFfEPaCwVWk6m7E1JqC+iqo
         RzIA==
X-Gm-Message-State: ACrzQf0qcH5tT31GD1FRC/QQc6tYl/wVCJOQKV9CQ0M1cQxnRXsIVKrh
        8BJAzfzNURPIfc0+NOHRrLQ=
X-Google-Smtp-Source: AMsMyM6GP+roXxlZWBu8IJ3eVceDIiaqoVBHkMfHPKC43E8xi3E9O/UHR1awiOndfRsF+i0omj7tOA==
X-Received: by 2002:a7b:c457:0:b0:3bf:f1eb:e943 with SMTP id l23-20020a7bc457000000b003bff1ebe943mr504773wmi.52.1664991860481;
        Wed, 05 Oct 2022 10:44:20 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:19 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Make gpio-ranges optional
Date:   Wed,  5 Oct 2022 20:43:36 +0300
Message-Id: <20221005174343.24240-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The pin controller can function without specifying gpio-ranges. Remove
it from required properties. Remove it for that reason and to prepare
for adding other pin controllers which currently don't have the
gpio-ranges property defined where they are used in DTS. This should
allow dtbs_check to pass on those device trees.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index c6290bcdded6..d45f0e75a698 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -67,7 +67,6 @@ required:
   - reg-names
   - gpio-controller
   - "#gpio-cells"
-  - gpio-ranges
   - interrupt-controller
   - interrupts
   - "#interrupt-cells"
-- 
2.38.0

