Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E055653634
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiLUSY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLUSYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:24:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCFB24F20;
        Wed, 21 Dec 2022 10:24:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so38872974ejc.2;
        Wed, 21 Dec 2022 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mj8JvHtlFXNgsizQJkT37AcYJIDfVlJOqhJ0wEsXlLA=;
        b=iJb3ola/qEjyOWpzkP8dM1EAuZT5yhuF3+T4qFfi646wXhG86WZsUz4jbRQp5aZ+0n
         nI4u+qMUvzQQeEbm0ptRpBvIMqu90KSqeVxsyNzG/hRZEOJ23kyiRroVkLSnG2STD6zr
         ivNck3b/aka/OOV+1aN3ljYfbmtVKu3P8olwsncCoTbnrwqevO5w4nCI0uI/FICcv592
         Byq2V8pwSTgBBUJBkjjTPRb2sQ6LXnE1U8y5Bj8v9+WcHWJuyDyizfVFEQ7rpILsx06o
         wc0L0RIGphT+VSR0wR5RyO88tPhwdwDqnFhhuwNwtPiJ2XzU24oRWB37v3o00DfjWBZu
         QnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj8JvHtlFXNgsizQJkT37AcYJIDfVlJOqhJ0wEsXlLA=;
        b=gqRy9XpQKJmnkzUkS8Uia6dsRi5ehwH+9yTGgDQGQkJfBowfNKjAYu2ZVpaxJibC3B
         F0q88VMHxhvbaA2KUCoCSGJSOuWDMhcl8aH2mstfyo9jQrYzaU7UExlElb6Sv5tR66KU
         GfodHFKZBLTgcJxhndwDnv44aStUSddOzrv910H+2yGNcdfKdYdrqwVFKk8XZuhMP4vN
         M2Tf08aDyGAl1AHy8Xz2/5zBaQulAr+4xXhLdWlzTSQfPRjV2w9Sr6lsPbWQd2eb8NOO
         CF0XshjtATL6tuVSHAoD7O3Q8NKplYHr1e3bGZPnSzlN79TLbCANJwVmlXO6PeQnp0Yt
         4LZw==
X-Gm-Message-State: AFqh2kpZUJydLWiJ18VYv7umAAaCQBQ3cH0jhrkoAif4jtNLq0m43BBz
        tsyU3gGuVdFxO1NhFZBjiTs=
X-Google-Smtp-Source: AMrXdXtM88dtxlfmxBgWts0v5ArGwbTEWnL/kV0EPA93J2FfNjRKV/Xs4K2kE/BXvkonB0Tr8/i+2A==
X-Received: by 2002:a17:906:700f:b0:7c0:d1cb:2165 with SMTP id n15-20020a170906700f00b007c0d1cb2165mr2028252ejj.56.1671647092517;
        Wed, 21 Dec 2022 10:24:52 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906769a00b0073d71792c8dsm7435482ejm.180.2022.12.21.10.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:24:52 -0800 (PST)
Message-ID: <4f0a828a-a933-24fa-c97e-ca29eac9c881@gmail.com>
Date:   Wed, 21 Dec 2022 19:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 07/12] ARM: dts: rockchip: rk3288: fix lvds node
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

With the conversion of rockchip,lvds.yaml a port@1 node
is required, so add a node with label lvds_out.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
  rename title
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index c22f90e53..cedaa633d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1174,6 +1174,10 @@
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

