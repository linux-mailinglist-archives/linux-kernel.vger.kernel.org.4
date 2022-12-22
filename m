Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2507654304
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiLVO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLVO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:29:39 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA429341;
        Thu, 22 Dec 2022 06:29:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so5414512ejo.0;
        Thu, 22 Dec 2022 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pi/zW9ZbZ2y3Vmz+VhVdwqmrZ+im9awqcNyirOkOP0A=;
        b=SIHkzQDb8actKpbGFNrDzDtjv07ZcEvqgQsi91YYto7dlSqKtJuTWM9eWXhFfzEtOK
         /Djxnhewcztw3xbUu8706lQLpR+KeW/5T2OTy2TYZOFw8NNoJYKROaTfvjjfn8bR5esh
         tapj9l4G4mwL86/Km9gaZ7jvhhFMK22yEiMI7tmtilNAvldi6eyXMIvo3mOk9122bepd
         gil4Sroov5gNB1YHInWygahj8pu59nhfJ3lBkARjIiQB2qzdlY24SQfRC7Wyb+yr3Bw9
         4I9P8kX0ap0bEFCSUFK8zeEmCmxgPWHmaeqPoBEVXR4dv0sl6IQM08BNQ7NeleKnueML
         TO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi/zW9ZbZ2y3Vmz+VhVdwqmrZ+im9awqcNyirOkOP0A=;
        b=CostRoVmCxbF1HfPJ9lE7hMS1YvQy1oBY/DQ3H7n9ETQFuPuEtl0xD8RR0NgcjIpt2
         QOoB741ZUttyKLtlvEqoFxces475atBNb5E5YxUFBIdu4nemBnNi6A9PO0/UA0LDgHz4
         K+ZSUrTnek6UKsxrPGV3XY9bTq5iCyR0yjayJmsthh2z1WnrTiDzmdFZfjAsVUs88wv2
         TNpE1bc9Uk05uxIQfzPXs5PL8zAExaO9BplyQnOmoEBD/99Y3nNYX4hHn21hSDKSkL+X
         pPFQl1ScYaaJuxUNsMHzDBR+p4NLaHqfF5RNpdU1noRGb3JnpiUk9wDEP2K+risTHz+J
         YSHw==
X-Gm-Message-State: AFqh2koNnVgxBwgFaxg5hkHP6Ap4fHGSsO1QG0BTbhwVhVcOTXV+pWIK
        cUFlVwX7GFJskESEtCN5Bq4=
X-Google-Smtp-Source: AMrXdXuU4xfEXsY11FaCnzLlU/Z1jib1TkYCwj5+OE+uQ+v+/lDj62VkRFMRFO4PFzk3Iusi8H2E6A==
X-Received: by 2002:a17:906:7fc3:b0:7c1:10b8:e6a4 with SMTP id r3-20020a1709067fc300b007c110b8e6a4mr4310354ejs.19.1671719376736;
        Thu, 22 Dec 2022 06:29:36 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bx16-20020a0564020b5000b00477626e3e42sm420987edb.84.2022.12.22.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:29:36 -0800 (PST)
Message-ID: <f3edcbff-4aef-1d24-8d65-e519c9451cda@gmail.com>
Date:   Thu, 22 Dec 2022 15:29:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 09/17] ARM: dts: rockchip: rk3288: fix dsi node
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

Use generic node name for rk3288.dtsi dsi node.
With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label mipi_out.
Also restyle.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6:
  Restyle
---
 arch/arm/boot/dts/rk3288.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 487b0e03d..fbb174729 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1114,7 +1114,7 @@
 		status = "disabled";
 	};

-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff960000 0x0 0x4000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -1125,18 +1125,28 @@
 		status = "disabled";

 		ports {
-			mipi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				mipi_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_mipi>;
 				};
+
 				mipi_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_mipi>;
 				};
 			};
+
+			mipi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

