Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C1653642
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiLUS0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiLUSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:25:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5C1A06D;
        Wed, 21 Dec 2022 10:25:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c17so23160374edj.13;
        Wed, 21 Dec 2022 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFvMuvMh7YEjHgfoyUurfQAp5Ldp3Bc2q4aAnoQCwkM=;
        b=l5lzKT0fdH5xMuiwJ9jOC+ldxvWofgM4nJqXUSh9Mn2iBc3NIAz25S/j6oWg5wYrVQ
         gvzeeWJyu5B6+vkCkhdelPxBTxp5hgJ8ta+Kgdj3md9R4uhu1d9BXGhAWyxlsypsgZ4F
         okIDxpGxkMAItqZ+zJHnCnzdS5wkaAoZ88r4mZofuH7H7Z+XSm0DJHCLDTxazfKvoE60
         IW2dauxNPsn1xODZUsqMFq6DeoGjZLY+Hs6LTjhpfoqEP9lnRohQY1sDr6ZlTlKh47fn
         MlO9z82lQbbSmbdjQZNJr6ArAlRqkjvPRoVbeyKPStliXXPcPomcrG5MFyKqJ8XDY71c
         uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFvMuvMh7YEjHgfoyUurfQAp5Ldp3Bc2q4aAnoQCwkM=;
        b=JFU09hpZfjdEbA2e+SaPd/uyYYFPsIKW/pMtVl9dFe4OA5ksjQ8sMSRkNnyGekwefk
         XYtGmFfSmR6WNGPiUSl33iJFxRm77Q4E6L9ChCj0pVqCDltIFz69DacsASlH6UKtAQRW
         921ek22+Yi0meQjdnQNirVYpvhYOWz30SR1OUYDi6tUkHl+OfqCHZyklHL8IIbbWQpnF
         wi2bIepQZyzOlVZb5E1pxliaWwIXSwrHtsnxv9fmbsvsA4d6qFPWu7h6pajzuLXqImsH
         3GDAV3izJaHJegu5Ms+Dr/+Hmk8YFlR/4VpY7FPFgI8D+U7kVQNr8kHEWtfnXQklTUN7
         p10g==
X-Gm-Message-State: AFqh2koAu8cBQu9EnHI9KnowPtRCizpuiX9bh0rg7MpmypL47SLai5nH
        vXF4tg1LvX9MBQ5YaKHViiI=
X-Google-Smtp-Source: AMrXdXtP9bzGWAfUkrd0SHR1XBaiEQah3omk51EpOFcUJ01rSPS2LZ2fESX9jvaXgwv0/ICAM8oH5w==
X-Received: by 2002:aa7:cf94:0:b0:47b:16f5:61dc with SMTP id z20-20020aa7cf94000000b0047b16f561dcmr2421265edx.37.1671647156160;
        Wed, 21 Dec 2022 10:25:56 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q20-20020a056402041400b0046c2eee21a2sm7278561edv.11.2022.12.21.10.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:25:55 -0800 (PST)
Message-ID: <50eb43e0-c39b-5512-edc5-78dcaa70b255@gmail.com>
Date:   Wed, 21 Dec 2022 19:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 09/12] arm64: dts: rockchip: px30: fix dsi node
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

With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label dsi_out.
Also add label dsi_in to port@0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index e34d81f29..272b01154 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1117,7 +1117,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;

-			port@0 {
+			dsi_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1132,6 +1132,10 @@
 					remote-endpoint = <&vopl_out_dsi>;
 				};
 			};
+
+			dsi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

