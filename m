Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CA65430F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiLVOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiLVOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:30:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734AE218;
        Thu, 22 Dec 2022 06:30:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so5352782eju.1;
        Thu, 22 Dec 2022 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pQhvyxS2+lxPQqiIeyKdGOnYGr9Eh6AUJtIVNTuj+A=;
        b=pra17mBr3JgRZv93t/vpFNPmD0aO+J9on1u8LfSQlR0gvmVU7fCiy6aUFxsMq6vsTw
         88osDMCGg4w9sYCHIY2iGRaYDHMJmDFgtRBmnAhzbeuay1wknN9zrOnqyK/S+hYEfPJE
         ufGsRbb6TMoDnIzM1EiGs+P3rUo4keriGyIoxZtVPJ+FTT9wvk/BsASkl8ne0hLBtesG
         fx5ygMW4pFrPfjoxdWuc9HzeTQ7HdH0E4rYv9y0ysaJnaezO5OwUnf46GvaOLDPH+FEf
         ASEjvCOYvV2eIck3hnoJR3W8dOEXhA2eKeZuGPxcvX+6peAsNRCahyRvlqJf5WhFkyeJ
         eKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQhvyxS2+lxPQqiIeyKdGOnYGr9Eh6AUJtIVNTuj+A=;
        b=yUu12UipQrcgDoc6JTctbwSO2duHV2BoqOwkY2Gd1/yQpbUAevLsLCqjw+sA74+/Sl
         sjUlub+YHKuoFNkD1mQfkBehD4Gmhwt91Hzo0MesEznWzd0BIkbdqaMBmklNUxsXmz1w
         AyHONeSsU0irIP9HuXb5Pbg8nb6DgusikSZh4Y2p+J4k/co/oxbYxM/hzCnw4z5uXoJi
         vQQtd+YJIXv8VvKfbhedwRAF+/Sv3SZl5cXeYJmIyG5R+E+pq1YUn1HOOGaZW8qiy7qk
         4vgmnIR32JR0AWRbyyhlZFCVtfJd2yVtsAU3vHlroVHfCxlEWDIkQrU348KO5YLrkucM
         4C8g==
X-Gm-Message-State: AFqh2koSCH+0X0400v+Zoe96j8U305v6kPBZaRjgXeLu5PrGKRD7VXUl
        LWxgK/QiVHLzP15OUgnQsjQ=
X-Google-Smtp-Source: AMrXdXtmL49MyBKUjTsMoWtqCRlV2PHafs92EJpPC3lRCxLlFg44CyiVrl1MfAnIoLBEhLRJvzfKQA==
X-Received: by 2002:a17:906:71cc:b0:7c0:ff72:e877 with SMTP id i12-20020a17090671cc00b007c0ff72e877mr5058112ejk.63.1671719440099;
        Thu, 22 Dec 2022 06:30:40 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ku2-20020a170907788200b007c0e23b5615sm317771ejc.34.2022.12.22.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:30:39 -0800 (PST)
Message-ID: <0a423eb4-0ab6-7ecb-d450-d93639160dbc@gmail.com>
Date:   Thu, 22 Dec 2022 15:30:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 11/17] ARM: dts: rockchip: rk3288: fix dp node
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

With the conversion of rockchip,analogix-dp.yaml a port@1 node
is required, so add a node with label edp_out.
Also restyle.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9def3988e..4d1bc6784 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1203,19 +1203,26 @@
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
 			edp_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				edp_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_edp>;
 				};
+
 				edp_in_vopl: endpoint@1 {
 					reg = <1>;
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

