Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0967481E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGEKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGEKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:17:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D84180
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:17:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso10165027e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688552272; x=1691144272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=stWmPgSuOqCIUaBUu4h5wa5BRifUyWh8dDQQnrs9IiT/dO56Vpe+Q+QJiEXbWOrVFx
         mBEXwEkBs8ksWsmAhZHfSyvjlOpliXhLuYf/d2o9P2VthamAe8z9CrWBzXHw/q6kSRLK
         Dc8ZOxu2CIvyh52/WL1wNWhMkfHs6jHdH+ke9h3s8/auZt/SVn/A9fvAaYMurXNFtUwi
         y296J6An+ov8798503IcQ6R7R+pa4jkOAod0c1k8+AezVcUu16Rif4vsN3EByWEDz3s/
         z1R92nXMjiSfTRd79BRSyVUP9+9RIuztf1ZcipbvGdwvqr3VSYh82fRy+1sABykEkaV1
         sXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552272; x=1691144272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=UTr/QBGnvh7iSTE3Z49/7fDeUhJ28Q+HuSy2PmpfVtrGSykDreWhjsLjxhw0+JRvSJ
         On5kiEIGsnJmgZUeKNP1Ihws2OvadyQQ5RCpszHiW/dnWZsUkW+TYuWuSUBPorAUWGRM
         4CFeom9isU9ZJ5fCFwcD14Bcb8rD9aDdQThB9DHTF+GnrQq4zmUI9ceV0lJdEnuxGuyJ
         Vx14xiNzFPQHC00JVUBjwkF/5A/pq+cw5bjMKttZMhedsqrrRSTsO5Z3/QHN2Td6O46z
         1ExMQn6GGpkkYK8YJCoSMtb0M0XhraKMVj5tIJcfKrsU9fddaKsCTfBGwdWMMCGnkHKA
         skLg==
X-Gm-Message-State: ABy/qLbLgCvNhwETuNOYAbDs1R2F4G1mmWuTizFZEbGoZ6cP84WUoS4B
        +qNIn/P0Ylkx6iyUImKxZrHH2w==
X-Google-Smtp-Source: APBJJlEVb/vpbPfo93k0QjY4gCXf3tUE1lHuE6ScDAxCqz+Yml4ozxk8QWe9GXj2kqc1im9ENVsYDA==
X-Received: by 2002:a05:6512:3448:b0:4fb:780d:2a49 with SMTP id j8-20020a056512344800b004fb780d2a49mr9654749lfr.5.1688552272262;
        Wed, 05 Jul 2023 03:17:52 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004fb75943ab3sm4774418lfk.258.2023.07.05.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:17:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Jul 2023 12:17:47 +0200
Subject: [PATCH v2 2/2] ARM: dts: bcm5301x: Add SEAMA compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-seama-partitions-v2-2-9d349f0d5ab7@linaro.org>
References: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
In-Reply-To: <20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SEAMA compatibles to the firmware partition of these
two D-Link devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 555fbe41dd8f..cf3000b07eea 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -33,6 +33,7 @@ partitions {
 				#size-cells = <1>;
 
 				partition@0 {
+					compatible = "seama";
 					label = "firmware";
 					reg = <0x00000000 0x08000000>;
 				};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
index d945a20b06e0..3551f855ff20 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
@@ -149,6 +149,7 @@ partitions {
 		 * partitions: this device uses SEAMA.
 		 */
 		firmware@0 {
+			compatible = "seama";
 			label = "firmware";
 			reg = <0x00000000 0x08000000>;
 		};

-- 
2.34.1

