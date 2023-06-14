Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57D7307D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjFNTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjFNTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:09:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384D213F;
        Wed, 14 Jun 2023 12:09:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso4329611f8f.1;
        Wed, 14 Jun 2023 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686769743; x=1689361743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5u9vHxVGrzBlNg97U37WfCH1VZYMHPccfRdk0EIgi0Q=;
        b=CpgQ+Kp063bXwmLKcP1EEsFKM93bGnY15ULSzxfxUlpJLR6gAyb4oeXYPjqoQUm1Qh
         kHc+Ueb4SiOE+/bHeahP/YzEp4jLn6ikXcfMAlgRRiQV+sBkHYwFpjdNXjkOsMvCRpUi
         2Jb1+Go+ysqeLQxKvH0let+oPsNKRlCFj1nQL9S5ZsjhYwW+J7uflIfyuyXjNdTLvfzG
         0Q3jbptnO63W0s2Kp2zPcEmszKHZ4i4SAg6G7taC8/t7agm9MGmGOJWKsg0iNceDD1Yi
         xnjkmJNOjCwEz+99cd4NwBByCBeI0xLzscMFpyO9RUZzCr2+s4nj7LRAa3JSvCc/Aohl
         0Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769743; x=1689361743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u9vHxVGrzBlNg97U37WfCH1VZYMHPccfRdk0EIgi0Q=;
        b=hB8oMvaHCA/hFk8/wttd6jkFXrFhEZHC0Okhpo9R4bCPwxSAuD3DFkztGcbm5rVeM1
         Rl8bI8vU8VD5gJPmXc5QB37AVwEe5/iD2bVeMQJbjGMO9rWraA6p1HYanTuz7jEqWCRq
         teAsTy/coETMqpXFVaRB8aGh32AGgTpB2wtF4ToL8hrz5yXG3tvceIoMzuQHVkY9LAi5
         e6ZwXqx3V9s5M/Q1lgZebajL2/rc3qDqEuMWiCBWzQjSrCMoMgPT8S9XA8501io8R+4Q
         C6A1mxR8Fu6aQutk7kBFfVwPaBpu0TVlnBnuNnygDBBIjZCdC0gb0GX2xbAOpzCaD9BQ
         SjbA==
X-Gm-Message-State: AC+VfDxDadHYx/O98tUhhQXuw5zdYSWank2WpSHaOpqk9PzrlIQhjiD8
        iMRmB38AACg/e8IEv8WNXnE=
X-Google-Smtp-Source: ACHHUZ4WcZukf0p1Xe7srG7EpSfRIc8i1xLVw2rVsv9fLH+mSROtW2rbeQ6y/IwrGmrmgOtHgQBd0Q==
X-Received: by 2002:a5d:4009:0:b0:30d:673e:1547 with SMTP id n9-20020a5d4009000000b0030d673e1547mr12367726wrp.41.1686769743534;
        Wed, 14 Jun 2023 12:09:03 -0700 (PDT)
Received: from [127.0.1.1] (2001-4dd6-393b-ff-f59e-4402-63f8-7ff5.ipv6dyn.netcologne.de. [2001:4dd6:393b:ff:f59e:4402:63f8:7ff5])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b003110ab70a4fsm2341094wrv.83.2023.06.14.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:09:03 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
Date:   Wed, 14 Jun 2023 21:08:54 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: shift boost frequency for
 rk3566-pinenote backlight
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-lm3630a_boost_frequency-v1-3-076472036d1a@mweigand.net>
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
In-Reply-To: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686769738; l=833;
 i=mweigand@mweigand.net; s=20230601; h=from:subject:message-id;
 bh=68FCYhe2/70pszTO5OdRKpvXw9/fY4xli3NXD6/hP14=;
 b=S4CP5nzsXth0E8aD8pqpP1sl8cO7kQrQEa7HRD5BrzLuryOjSI3/PCNUZyOKG9OtVCheLd/e+
 i6pmW/zckRjBf6ve1+/wKCo4UP/YGxbpdycIp3O6ibe+0ai9w0SVaYb
X-Developer-Key: i=mweigand@mweigand.net; a=ed25519;
 pk=Tjuj6PXmCCxzGTRw+9suZuZ41q/etgDHrIbPdkAaTpM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

The PineNote exhibits visible flickering of its backlight for certain
brightness settings. Alleviate this by enabling a frequency shift from
500 kHz to 560 kHz for the boost converter of the led driver.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 8d61f824c12d..4e4b3bbaa157 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -453,6 +453,7 @@ led-controller@36 {
 		pinctrl-names = "default";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		ti,boost_frequency_shift;
 
 		led@0 {
 			reg = <0>;

-- 
2.39.2

