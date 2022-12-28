Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483426586A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiL1URm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 15:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiL1URg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 15:17:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484814D28;
        Wed, 28 Dec 2022 12:17:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so40668334ejb.7;
        Wed, 28 Dec 2022 12:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw2wDsJ+8m3AoVC2xWGg3UQxTLWSLHBuRafQhz5yuoY=;
        b=GPsLfiynTG606YaieJjxQ/cG9X3K6EIGPkkV0ZR/u+a3dIYLWEA3HPIN4PMUHLTo2G
         gXDRkxIPZzQ4rK8/NIOI7LPfu6sm7ndLWg4hyqrJmh163Uc3DcGXZt9pfyASPk5sOJUW
         CBlSzxVNPYPIi0W+ilcipBWpgZlqYW4rhCcxkFoUvSWkg76KdO0WywFzasnXA+cwS0nU
         ReklC54vqnSnMCUCGVQVGyxvmQ48lgUoDwEcBz+PzdkchAdzOCt9tHwJ0zLPdcbbl7VP
         ocnhjWMXAqxX8UyzoYEjflKHJgL0M/qU6HceCEPRJm/+nzSHgD+7pTyfzA69IHM4tuUN
         9KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nw2wDsJ+8m3AoVC2xWGg3UQxTLWSLHBuRafQhz5yuoY=;
        b=gcb+FmgDv0Ns21dT+ZoVW6AivLMDi6AQsm8nS5+1+id9aZy9IL3iyCwY+Sfez2St+G
         U7USRfSOSufMQbObiGHmuWtAcW5N3GNvXJTa2AOS0zcBCctcXRqd36amhWeip5lc6fD4
         Q0YjxyBejFkC3x7D90U3/uO3m81vG2RSNJ+dIkUnlKBOMAEV4+4QXjyNg8gn6EGhpoaJ
         b2HyopNTk0WeGWjHELoyO6+URrD5fXh6Choe0H2olXYF0fJttfSgSAl26EEHeycUmwEy
         i4Z4J6QpFYOF/DW4ryq29B3nh05zUP6lAtSD69VI5ykqHyZTja5wztQ/mbTanPdFuRAD
         z63w==
X-Gm-Message-State: AFqh2kqVvBdcrwMXPisJNQ6END9whm0Xd0H6XrCI/BaxuEC0FJH/tIFI
        +/CznLMDBKtLAdbUt33QdZIqzTx5Ta0=
X-Google-Smtp-Source: AMrXdXvw8ADwoIA/nMdHR76kcmwF4uUR4zEn0Pkfet1bjBNastuGkmVj5Xn+l1FWbA6k+McfmjZuZQ==
X-Received: by 2002:a17:907:a643:b0:83c:7308:b2ed with SMTP id vu3-20020a170907a64300b0083c7308b2edmr22521777ejc.17.1672258654001;
        Wed, 28 Dec 2022 12:17:34 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090670c700b0084c7574630csm2119984ejk.97.2022.12.28.12.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 12:17:33 -0800 (PST)
Message-ID: <dab85bfb-9f55-86a1-5cd5-7388c43e0ec5@gmail.com>
Date:   Wed, 28 Dec 2022 21:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3288: add power-domains property to
 dp node
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
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

The clocks in the Rockchip rk3288 DisplayPort node are
included in the power-domain@RK3288_PD_VIO logic, but the
power-domains property in the dp node is missing, so fix it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 487b0e03d..2ca76b69a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1181,6 +1181,7 @@
 		clock-names = "dp", "pclk";
 		phys = <&edp_phy>;
 		phy-names = "dp";
+		power-domains = <&power RK3288_PD_VIO>;
 		resets = <&cru SRST_EDP>;
 		reset-names = "dp";
 		rockchip,grf = <&grf>;
--
2.20.1

