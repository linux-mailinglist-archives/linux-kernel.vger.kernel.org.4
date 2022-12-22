Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA1654320
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiLVOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLVOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:32:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3B2A53B;
        Thu, 22 Dec 2022 06:32:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jo4so5311361ejb.7;
        Thu, 22 Dec 2022 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRs/p77llC39s0EwuTCxcUjkyPLLZDJFzUsSm629Z0A=;
        b=Xl7qLiaS4H2MqrIAU1WtcuHZ0kD83PrmWdy2noxljwhNbTxBx2EmWiwDE0Uu6usFkZ
         zULq2JeBJQtg0kG6OkXkDrlLiCZErHvdtVOpxZeizVoHsAdfdfLIg86AhWfUCSzHWD+2
         guYt9bcEKM12W7iWyF02F7jpVM8125nm+VBIPrJB+dOPsrS1yYL1DP+wJFmlCnJr9l31
         wJHxoD2XRKndira/Ya/zup4aif45CJZgGHLoYFqHGPwneLRvpPCHx/0a6SHMD1ZZKYg9
         Hj+h0zkdXLr8lOmTdYNemhFM0jYs5FQsWDWIeYqNVlnKyphuwQ0zboqX7LbJcXAwj7kE
         IrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRs/p77llC39s0EwuTCxcUjkyPLLZDJFzUsSm629Z0A=;
        b=AJ0ww73bMCvl5n4luniPTTmtL3R7S8NSrPRIsC5QyMi7oFCMM+ULfJfvaps9MW+WUt
         DJnN3xkVjV/FfhrY/VRJCtNHVmQGxEoFOz9ZkDNpQDiELK3rlP1dcKhyr/uMxMmqScir
         gFrusxc+Wy6hRPy1JuWZwk+eGgvWHJnWlnjukDytQkxjGdsUQoB2uOivKl7FCAgmQ9Gn
         CgL2saQl5NrJWK35px6AWvDdxsGW1ftDtR0eTJMGC3EFB9nOTkxJ6TFx1XUSepkTHxfs
         eTZuDQSlQTPHcbRpt7OoRYW0066de/FeMkKqU4v+034g7kutgCIT65AEuEP+dtUIPJu9
         zJbg==
X-Gm-Message-State: AFqh2kq2YsPyn4cVS6q+9p7u3qmAc7kDxTERjV+45WQI8w9cAaoC4uzR
        yOnjT981+lDhn+56/ftnfDQ=
X-Google-Smtp-Source: AMrXdXsgv/n3jTfE7Jv0jiLSsvNygkcFwiea6D9Qjp8nzKtaD2AgVwCh95QdJ5axyGyCNMhswZ4CJA==
X-Received: by 2002:a17:907:a091:b0:7c1:23ef:4bb9 with SMTP id hu17-20020a170907a09100b007c123ef4bb9mr4258591ejc.13.1671719544480;
        Thu, 22 Dec 2022 06:32:24 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709067fc400b007bb32e2d6f5sm290577ejs.207.2022.12.22.06.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:32:24 -0800 (PST)
Message-ID: <1e019e9e-a8da-3d57-2770-f6b81bbbf591@gmail.com>
Date:   Thu, 22 Dec 2022 15:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 14/17] arm64: dts: rockchip: rk3399: fix dsi node
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

Use generic node name for rk3399.dtsi dsi node.
With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label mipi_out.
Also restyle.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6:
  Restyle
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 834d16acb..2250533cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1954,7 +1954,7 @@
 		};
 	};

-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff960000 0x0 0x8000>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1982,15 +1982,20 @@
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

-	mipi_dsi1: mipi@ff968000 {
+	mipi_dsi1: dsi@ff968000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff968000 0x0 0x8000>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2025,6 +2030,10 @@
 					remote-endpoint = <&vopl_out_mipi1>;
 				};
 			};
+
+			mipi1_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

