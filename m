Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485465432B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiLVOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLVOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:33:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851592B26F;
        Thu, 22 Dec 2022 06:33:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so5344014ejc.4;
        Thu, 22 Dec 2022 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tzm+8PkCoG+IFqQnJKv6s/WFlDz1S9hgijTugMX/bI=;
        b=TzOXnr9K4kajX9bIK/WZB3FahhP1w6vqcHzSRLDI1wGi8vPRQotaTMBjFQ5acMX+Kn
         Wk07AvtQlG6j023kKCKliq4wIY4sbpLmTLDocADmSRQvP9EZqXgOOI8/BwcjFdWB2y7Q
         sbgCzDz4mJ47mzZq11IsTixO/Sk9UGdkjwz+Dy0EkV6rb+7po2/oOLbsRlk8kzMQ+Bev
         oDayfXtv7pIKMnlDlaulk/s0on6V7VZqu/EfalrF4copH2a2qXdLo4I0IbWnfne2uTe0
         Ht9dBlptgRTVZ+XraSWBxFmJrWrLSl0iibQLRyTXOZXxZrR/KarQY+T63ZWwO8BAZT5F
         qLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tzm+8PkCoG+IFqQnJKv6s/WFlDz1S9hgijTugMX/bI=;
        b=lUbCZKN0e3S7ehTsjaPh5br7QxRXW+Wp5nXlSPsFmPmyjIlNE+DoQviDN7tB3KsLtY
         rZq8Wz5OTWjBlUAPFAIcrMI1yhD2oEpvObFc4he6ZLVKe2K7c9XTuG5zfxPu9tA+33ZQ
         4zsR1RZ/XczDfA7yjw7PFHtUAbyUjRZIrLFD8br0hyc0ZUZwZdyV03qpIfCotv9hPboZ
         NdVz77C8KQYv8/4GyEdWJu56NqRpMrP/hmcRwzmESFmTpPCqYHioE/C68eyppLtd9MTb
         iMJtyjMBQBtXJdN5xcABiHIfBXJZdJvlr6mzQ3gPy6DJR/tB4OxHUuiBXLm70FAbNrKF
         wrrw==
X-Gm-Message-State: AFqh2kpDS3JIVMN/QEZ+48YIGUGzAe0OcCxMU/2w56NIvQ15K7SOhkpf
        fnHWo4OpmRJ+kD99zB64gBA=
X-Google-Smtp-Source: AMrXdXvRhRHj2vwrTPeoGMfOkoJbnMKxdSD94gT8jMnTAO4Eim3FH5O3xsHrF4NAry/VlNnLCTxHpg==
X-Received: by 2002:a17:906:191a:b0:837:c2fc:a97c with SMTP id a26-20020a170906191a00b00837c2fca97cmr4736411eje.64.1671719604154;
        Thu, 22 Dec 2022 06:33:24 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7dc0c000000b0046892e493dcsm429715edu.26.2022.12.22.06.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:33:23 -0800 (PST)
Message-ID: <1889d8ee-e119-4a52-33a1-b990a41a137c@gmail.com>
Date:   Thu, 22 Dec 2022 15:33:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 16/17] arm64: dts: rockchip: rename vbus-supply to
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
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

