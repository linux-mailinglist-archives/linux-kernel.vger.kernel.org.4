Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABEE65364D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiLUS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLUS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:27:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DC26132;
        Wed, 21 Dec 2022 10:27:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x22so38767820ejs.11;
        Wed, 21 Dec 2022 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tzm+8PkCoG+IFqQnJKv6s/WFlDz1S9hgijTugMX/bI=;
        b=Disu3h00/Wb54++iZFoLClUFEFhCaaORJptiOD20dHdG+Js0vtzqGz5PPZRgBJG74N
         0Ts2oau97PHUS1qu59WdqWqqreC6Di+3wG2H1jMMyeNH1wJKJljeEOkHLxdnPx9tqMEe
         BjHn25wnkBHiTN90cipWgk3aWnQEmbs0CeOtMuwsQWiXgOJbN08MBoDCmvi3dfGyLAk1
         AdIj/z/3v0UyAfRnu2Q2ezFjjk1DMEjO4QcwPYtC+SDq5dxiVorL1SZSU/m4RttcAh1i
         KG9VK4gmPYfmXZnMXYrA/MADD6aOhpzGnk3FcYpe4xXeH3qlwllKZByIi3scGJYhuYcE
         kn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tzm+8PkCoG+IFqQnJKv6s/WFlDz1S9hgijTugMX/bI=;
        b=zoWoI24XNvdbf8RrZ35DN9YEiyof5oy8GB35FeQ1ogNjHwKZ8aflCe7KMXeDoRglUT
         XRNPZJatGqqEMLKTjU60IFtoGPNvtodRgwJnp10HtlnOjCYVAFepuYT1swBiIBPCQUqH
         ag/JPyHENX7vLz/wrRZ/DV7RgZGKFbHRZXHojzQ93uFIgPfd6zgn+60oroLEXAsruaH8
         V/YXLtyQBZM6LjeGy7cYvdnEc9PdAwgd+rljxuZ8shDC0ta5K662HMCeg1L04eoJ22Yx
         TGbRRgGu0rNy9eZFWLSXa3+Iy9+3u9MLRztuOrTrOGcbsFihK2KR2u1pJIH02yFCSbLo
         /FYg==
X-Gm-Message-State: AFqh2krCRVaZ39qL2212vfrCqmGYLwiWDPC/CAMx4y6eQXJ/8WT+f2Jg
        FeWVAI4j5jo7yJUf1x5SE6M=
X-Google-Smtp-Source: AMrXdXt6ILaPZxXaZkt/4DH9vZSFIGy460+kqXNoi6CbgMozPJHOZ/xsGmRmC5XMPwiHIWeJDm0GKA==
X-Received: by 2002:a17:906:71c3:b0:7c0:dd80:e95e with SMTP id i3-20020a17090671c300b007c0dd80e95emr5789134ejk.51.1671647220873;
        Wed, 21 Dec 2022 10:27:00 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id la15-20020a170907780f00b007a8de84ce36sm7262965ejc.206.2022.12.21.10.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:27:00 -0800 (PST)
Message-ID: <6b4669ba-4731-d3e3-3293-f5fc69ccf6cf@gmail.com>
Date:   Wed, 21 Dec 2022 19:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 11/12] arm64: dts: rockchip: rename vbus-supply to
 phy-supply in rk3566-box-demo.dts
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
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

'vbus-supply' does not match any of the regexes in rk3566-box-demo.dts
in the usb2phy0_otg node, so rename vbus-supply to phy-supply.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index 4c7f9abd5..4dc9b7623 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -464,7 +464,7 @@
 };

 &usb2phy0_otg {
-	vbus-supply = <&vcc5v0_usb2_otg>;
+	phy-supply = <&vcc5v0_usb2_otg>;
 	status = "okay";
 };

--
2.20.1

