Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5415654309
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiLVOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLVOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:30:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF32937D;
        Thu, 22 Dec 2022 06:30:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a1so3150401edf.5;
        Thu, 22 Dec 2022 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sr8iGvYv8Y+FUygmw8CozO+P35yD6ZFMgxS2kANtCbQ=;
        b=VaczJC3DYayhT39mpuYMMNQmAe6pOd8vIUqq19xXuzH+xCl2aEgwN3IsaSTR1hH9Uk
         uhePN9hjMzX2lQmaG5d/c05laMe4ShHPUzQGyeoa+ifSKElXnlrR7QVH1dHdGsEq4Dd7
         j+2E9Nv5SN8HhYJ/3tCDbTmsiDzyETXjVCKKQ4CliNHJvrDaZRuVM2E5oFHZjHBq7ll3
         rsTJIybJ3he9K3Hknr7Q3zVnh3000wSsLfVK4dAce7Eh+5sIc1uyQ1wXS2u08Cd+vcdM
         uE7H5gbSfx73XuMy3cHOBtr37+FwZSQr5cPPCCtXwG8592mjHRMdiKKJtAASJxH7GfEe
         HY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr8iGvYv8Y+FUygmw8CozO+P35yD6ZFMgxS2kANtCbQ=;
        b=QVuHuI1cGPlvMMhIZOI57sRuqoPANulasJfxchZGwmhdJ336AWMDt14DTWKgPFF1Iv
         h63hJ92UNGTBc2QLCYhYuwXwnWK6aPA1ZtsYGbeatleZ7PjSQnxQS651VLz0j/Ysq3eQ
         Ya+8QP3TV81WXLFNHDaLLmDmlh8oqdWmISGbqE47m6suBCCjSz7ESBTM/I1P8hBMjEx+
         mnYG2i+gdGxfsSza/PnNJRiA/WhrWndRvEGszZBAX7lNc12AiTOx0pLg1RBSCaNW11jY
         AUsNxhDjtzHAlOPOJkfRk5fammyj8osu2wLscaZerbSUGkjV4JnLOGNyPix+sVTqE/PK
         0i3g==
X-Gm-Message-State: AFqh2kofzx+58hUChh+sI4eN4Ok69si7PnOBSu3grv0PIEIaiTOR6obe
        lTV/P17bgLfCVDjKG8zAM/I=
X-Google-Smtp-Source: AMrXdXurqoOFkI2ZF/Yr2+mXCk6PmZYuuFqlaFxmwRRIisoHNe/8QJlN0NWxlPobXkNO6fFrIoIZpw==
X-Received: by 2002:a05:6402:33a:b0:47b:2524:5cf6 with SMTP id q26-20020a056402033a00b0047b25245cf6mr5189089edw.40.1671719408575;
        Thu, 22 Dec 2022 06:30:08 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b0046b00a9eeb5sm427095edh.49.2022.12.22.06.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:30:08 -0800 (PST)
Message-ID: <e7b78a73-0e89-d9e9-2ecc-a8a380635f64@gmail.com>
Date:   Thu, 22 Dec 2022 15:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 10/17] ARM: dts: rockchip: rk3288: fix lvds node
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

With the conversion of rockchip,lvds.yaml a port@1 node
is required, so add a node with label lvds_out.
Also restyle.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V6:
  Restyle

Changed V5:
  Rename title
---
 arch/arm/boot/dts/rk3288.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index fbb174729..9def3988e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1167,7 +1167,6 @@

 			lvds_in: port@0 {
 				reg = <0>;
-
 				#address-cells = <1>;
 				#size-cells = <0>;

@@ -1175,11 +1174,16 @@
 					reg = <0>;
 					remote-endpoint = <&vopb_out_lvds>;
 				};
+
 				lvds_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_lvds>;
 				};
 			};
+
+			lvds_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

