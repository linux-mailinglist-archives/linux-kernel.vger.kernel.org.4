Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013B8653646
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiLUS0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiLUS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:26:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1A2654B;
        Wed, 21 Dec 2022 10:26:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so38718727ejb.13;
        Wed, 21 Dec 2022 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vxtaE1EEmdwnLeoknDdjbqn9RBDwfiNqk1bsNHc/eJw=;
        b=H4VxHHU+xeONEKkCpBNCFZS9t+9ooCkUgwbUw6St/ZhewwRXsL4AgLO6axA/Kytp0G
         zdftwx1ZiZIs6dEGmY1YRjhMvC4b45iT3SzwkvLE0y2gFJ/m4rBw/ZisHChvfknQDImo
         gjgJYMl3UUZzjK9VpEn3ubJiwUTuALdrN5En8KU7PXBKfaAqsdSgGkvkXc9TFKv71Eal
         HszyKsY6R5uWa3R+MvMCpMlyU3cw/TZSJg+Z/kssTXxi1JeAvy+58eK2wZFxy5x5VRju
         ukd+Q6VhjT3emgM0jJmwpoHFET6Aamflp0tH6yf51IeDdboTRlcaiKXVkJfh5lu2TDEA
         FT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxtaE1EEmdwnLeoknDdjbqn9RBDwfiNqk1bsNHc/eJw=;
        b=QFmnAdqk3vgRxpHWLmb2T2u1Ou24a/J9t8PAMIRvvO/NWidH9AcqOvQj0wrHAuH1w/
         0qqpKwEGhMuCrDx4o+Vt3UzNEn9x48x/AwHlkNjUa5kwr6QfTLa3dw/WLVd7s3nRrJw/
         ftsCfaekEl4LWgGj+brZRvkYBwr5nA60FzFEmoycsBjfrLPmzQhwsJOVKwF62WX5SFF5
         9Ojy+9oB9QW/e3AjHtFlhFsS0CxE/DH5PhqOlxUD0vv6F3IRHCgPF7rDeswTQkOos8xf
         WhQhLG5aW9BT0UUrDcQIFBxa8V5ciqw2FPPoLn9B3WdztwhqbmCKbn3uZxzsxUDgMXYh
         jJoQ==
X-Gm-Message-State: AFqh2kocAcKoOr9rwfDMUgBw+frIwVT97kmgqtKNyc9AW81VGN/UXBsL
        p2TTIoetDHb+uMFJFxuGv4g=
X-Google-Smtp-Source: AMrXdXuTjC9bvbIdq5RW0n49hi6uRuBosp9NyHqunZjTW2LMl2teBSgpdFGUefpiu55ZijE3DzCQ/g==
X-Received: by 2002:a17:906:a891:b0:7c1:4d35:a143 with SMTP id ha17-20020a170906a89100b007c14d35a143mr5486319ejb.3.1671647186041;
        Wed, 21 Dec 2022 10:26:26 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id mh11-20020a170906eb8b00b007ad69e9d34dsm7413700ejb.54.2022.12.21.10.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:26:25 -0800 (PST)
Message-ID: <fafc6e31-601d-8106-b281-f6788d2709a1@gmail.com>
Date:   Wed, 21 Dec 2022 19:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 10/12] arm64: dts: rockchip: rk3399: fix dsi node
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

Use generic node name for rk3399.dtsi dsi node.
With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label mipi_out.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 834d16acb..62047a5a0 100644
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
@@ -1987,10 +1987,14 @@
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
@@ -2025,6 +2029,10 @@
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

