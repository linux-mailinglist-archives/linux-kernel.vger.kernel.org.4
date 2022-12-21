Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20310653629
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLUSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLUSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:24:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02C2654D;
        Wed, 21 Dec 2022 10:24:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so38798415eji.5;
        Wed, 21 Dec 2022 10:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lvcQjc1tSN+WqGFd2a+LQfMGe/jMGY/EiDX8AEMXwKA=;
        b=hsnKVAvJjTm/vH8ROKf0lkdPYG/7tVxNV4QRv9Wt419AAMTXG1RyIoWqpPrYlboYDL
         G+En2avRFUjXEw+mY9ehTVjyl/g3QE3P9/dyWPehv6jMxGQkyrCt6gsy9LCvm5cVnfeh
         yBB7k+nj787nK+wQ5P/muiBYTzsPTxv9UED0q2iTJH5walJPoVSSxAk+Gw1BdkJ9J7YQ
         OqMEEBmjhCzvcUq5dk59x4cVFiDM6UY5KuzdYxMswSmHmhiPfoCsqlRdlUEbBnzIDzVu
         0BSlC0Fg1WC9lZxoUlmZC9T5pWQoFYIi75t9NDwVKWUulP6jOcnx79Im+mkAmI0LjvdM
         cVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvcQjc1tSN+WqGFd2a+LQfMGe/jMGY/EiDX8AEMXwKA=;
        b=WDmegLhOvdpbO57fo7WY9/y5MXonu+3+nAuDcYLDA2n7LQAnkJO+Gx2+qAz1g0MGkm
         WcLr2CZYso+7N5lzi1qdAiNaBghA48jo9JRV2uh4UsdRloemNo8rkNMvXDHcGuKerUpB
         LN652n5denoKO19Ce2RTbXjXQOHnfd5rTL6YaQb2BnrT7o2Sbm/3j8VoWBtgkMuIsS52
         zBtol4veCoSjy/Z7omEDI+KolrWAe0NmkoIfpqv+cYkpNnKdGRgCcaDMO+Fcx6PGTIpK
         IxBXEXv2qyLbZqmW+sSM3jpDvGijq87SYvnWdyFRFZ0uABsHi36l/kTbUaEwWmwdsvgJ
         EXrA==
X-Gm-Message-State: AFqh2kpFLXBbby/dG7DmbKHl1TYPV77Hr8EMIwuFf1g4cPcVGGmQrUNi
        ljDT50raaAOAiI5t6v0OfIA=
X-Google-Smtp-Source: AMrXdXv1K172bwT5L/tl5YVDCw1ihZJT7aJ7HP+WwaYs4jknJoZSk8wkCqixuBvSgTEK+37mI9z2FQ==
X-Received: by 2002:a17:906:850c:b0:7c0:f4f8:582a with SMTP id i12-20020a170906850c00b007c0f4f8582amr2389986ejx.52.1671647056884;
        Wed, 21 Dec 2022 10:24:16 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bq15-20020a170906d0cf00b007933047f923sm7281632ejb.118.2022.12.21.10.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:24:16 -0800 (PST)
Message-ID: <b2c329bc-33fd-b65d-2e67-273eb0780e80@gmail.com>
Date:   Wed, 21 Dec 2022 19:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 06/12] ARM: dts: rockchip: rk3288: fix dsi node
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

Use generic node name for rk3288.dtsi dsi node.
With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label mipi_out.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 487b0e03d..c22f90e53 100644
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
@@ -1137,6 +1137,10 @@
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

