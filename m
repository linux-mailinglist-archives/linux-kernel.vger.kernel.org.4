Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133160F29E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiJ0IiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiJ0IiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:38:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47992F4C;
        Thu, 27 Oct 2022 01:37:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k2so2512211ejr.2;
        Thu, 27 Oct 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHHglLeoa0xl2Lso2Kv9u+moRM1p+bVCpjecaPrLp1s=;
        b=M5hzx7V4PkX3+liCaEQXoRKFUNXaQAYvslC8zW0Xuk6v2kwLNiAtBRORZwRHm1PoQF
         pazONDEJ5n0a/drlgtuhcMj6nMNTk/vnSC5PiRChuIcTqlvlgb2f4c1HlmMnXoJZhyDs
         k7xVqin+Dw0OK5JN14fmUEN9vW+4kt+bI/gL9Lj7gfGAXnsEzWgyXU/dK8IH2gWgm4RF
         pD30calUGp7fKFFNrq/9eDu57Wxtlffj9yzi5EROkArSUhqdhkgV/hG+v0kR9Vwc/GkA
         JXnGSwzF6TW0ixCk3hH6gnfV/r2Gf+pNrttmt3z57mbtswfYPkV6logT5Wi0wS/uzv0g
         OYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DHHglLeoa0xl2Lso2Kv9u+moRM1p+bVCpjecaPrLp1s=;
        b=MgWuBHMzmdGfi10h0uPE1B/Xyte9lC82vYjScMHjdek/d4TEUAy9i0O1aBwcVfTFLQ
         m/1XGxImSvmaTHsJfvQEXSswabWLYQw7f3NRKK7OjpDpwOMcOSDXs4Bjhsl3IHrCh+OA
         I9XebxiN7pAcmYPRzE1wPv4uy1AfEbWkxHfa+y+0zhuBNz1knggGqxR4ihxaGZwLq5cJ
         SWKG4UbQNWI5ZW2pPrW1CeZFRrAiVPoTPIe+EDt+k7QLqVakg/OaMeahM0mPOYG9bTAF
         WH0nFR1Sx8so4uuz+tSzbyDdwY/J9LgThkIrNNk2GGJgBHOiEZf58sNBJp4314ssztfV
         UXFA==
X-Gm-Message-State: ACrzQf0LCfhcNdOJzFp20AyHCrb5l9gG9Frrxal4Aki8ua256Sl05pwI
        Rdp0fiEue79dwlHvJrHlpsq4gY12Bdc=
X-Google-Smtp-Source: AMsMyM4yb3/eGOA49HXzZjlKZ2FDQA+V61xj9i/S6fr1C9izc5dEgHdl9cBQF2I7bHK9euhTuZT6cA==
X-Received: by 2002:a17:907:160c:b0:78d:b6f5:9f56 with SMTP id hb12-20020a170907160c00b0078db6f59f56mr51155ejc.325.1666859854253;
        Thu, 27 Oct 2022 01:37:34 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7c1ca000000b0045d74aa401fsm570590edp.60.2022.10.27.01.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:37:33 -0700 (PDT)
Message-ID: <7a0013b1-3a55-a344-e9ea-eacb4b49433c@gmail.com>
Date:   Thu, 27 Oct 2022 10:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] ARM: dts: rockchip: fix adc-keys sub node names
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

Fix adc-keys sub node names on Rockchip boards,
so that they match with regex: '^button-'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index cfa318a50..2db5ba706 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -32,7 +32,7 @@
 		keyup-threshold-microvolt = <2500000>;
 		poll-interval = <100>;

-		recovery {
+		button-recovery {
 			label = "recovery";
 			linux,code = <KEY_VENDOR>;
 			press-threshold-microvolt = <0>;
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 399d6b9c5..382d2839c 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -28,19 +28,19 @@
 			press-threshold-microvolt = <300000>;
 		};

-		menu {
+		button-menu {
 			label = "Menu";
 			linux,code = <KEY_MENU>;
 			press-threshold-microvolt = <640000>;
 		};

-		esc {
+		button-esc {
 			label = "Esc";
 			linux,code = <KEY_ESC>;
 			press-threshold-microvolt = <1000000>;
 		};

-		home  {
+		button-home  {
 			label = "Home";
 			linux,code = <KEY_HOME>;
 			press-threshold-microvolt = <1300000>;
--
2.20.1

