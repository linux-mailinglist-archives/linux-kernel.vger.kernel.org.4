Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A25654326
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiLVOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLVOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:32:56 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5C2A241;
        Thu, 22 Dec 2022 06:32:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so5298143ejm.8;
        Thu, 22 Dec 2022 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yrUavxSC0YydN0TKXWkrYFUw9v5M/WABkWirfDs3Xc=;
        b=RGUKyx4pjlE81gC/a8eQInZ7qvs0UWhPxxdmRGaK+mifofPPgpx0WGBmdJobxAYIQ/
         PLO7GXJm8O+8yrTMjYgOMMNxJqJBtqWig5wRtDIS7/Gqi+Xlt2YjmI3Nmc2vM8aM4VpN
         b557b6VzkA8hT5kh9QqYhSC753IFQitWiJAqz/EwafSjK16nRN2qkwR7HcK57eY1c7lh
         rfqxKk//PpVWOQQrzL1F05oUAWVWO9z+nOZ+9zZ5p94GX0OOiFSF0Gu848vCUNDoKcBx
         PtssmvKdqBb8C0pGGBFqtCazZKizoOQLlFdfSWPS9rpLQgkMPtinfdFpuYBP/4gXFqwY
         HENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yrUavxSC0YydN0TKXWkrYFUw9v5M/WABkWirfDs3Xc=;
        b=WVdK4wxtsIoRpNYpWqgaQpDFPUlQKnyqusWryDl51kbqUxFvSR7+mI9H1gOJXHqjd+
         gcmU9DeqCa0W4VoA7cR+HOcBq/cytkPkVhGAIG2NCtr8qJuFfIKpwymx41ezm5HQHyfZ
         r2v5zMkWz753uBASE9TSagUZcP3+RtAgOPZHmD3rqCLfHDHXYGB+jp2tzELDAK8RgPG5
         gfoVn/nNcTNcuq1uBL0eb0ZgX/SQLmmFbGFiS/lgIt1gJFU18LhKkGpBtoqKItehLdQg
         hDYQQ+dvn1Shkmmh453CebvQ0v9MzyVXCxUsfKwA7XN/uNEQlwtjbfB/2aFBPTfEAG2w
         3Qjw==
X-Gm-Message-State: AFqh2kryQfbxXCzObU/QbIYDtmz0q5HxmXodXTziU+/dnEMpgKNqgWg1
        9kwniPHbG+Zf3XIP0MpfhFY=
X-Google-Smtp-Source: AMrXdXtqZ8JJqmp8AaMY3noPII7c2qvGh6kRZJ79yXNnz5AOds68D7oxejOaYC7RFzTdVnkiwPRxLQ==
X-Received: by 2002:a17:906:c0ce:b0:7ad:d7a4:4346 with SMTP id bn14-20020a170906c0ce00b007add7a44346mr5969104ejb.66.1671719573988;
        Thu, 22 Dec 2022 06:32:53 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm313265ejc.36.2022.12.22.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:32:53 -0800 (PST)
Message-ID: <f6008819-db9b-0944-3f5b-5522b7cd8a8d@gmail.com>
Date:   Thu, 22 Dec 2022 15:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 15/17] arm64: dts: rockchip: rk3399: fix dp node
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

Use generic node name for rk3399.dtsi dp node.
With the conversion of rockchip,analogix-dp.yaml a port@1 node
is required, so add a node with label edp_out.
Also restyle.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2250533cf..e02483b72 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2037,7 +2037,7 @@
 		};
 	};

-	edp: edp@ff970000 {
+	edp: dp@ff970000 {
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2054,6 +2054,7 @@
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
 			edp_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
@@ -2069,6 +2070,10 @@
 					remote-endpoint = <&vopl_out_edp>;
 				};
 			};
+
+			edp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

