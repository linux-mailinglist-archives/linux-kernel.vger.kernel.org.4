Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC26B60F305
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiJ0I6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiJ0I61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:58:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246D15F91D;
        Thu, 27 Oct 2022 01:58:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n12so2541658eja.11;
        Thu, 27 Oct 2022 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8OtRFPYPme7k+s/39Hja1ZlRUUoR2PXsGDstekJPv8=;
        b=l+uBUhNzV8OBaMbIzgLn9G1+R6Sj/KzPHa7jaby9JMJ2iW8eTMOTzmMuKowvCQTWld
         2rkt27euXuDqRuRDeEgGKv3ZoXdhEuiOMzJrWxDeK+6J65G+Sc/0jAxtEhXzwHf9VOJU
         JOHIjt6hmc0r9DJIDjHE10DSRZ93qROMVB4SfZXqhh7r0hqvSYFcBSR7PGCoLoPyxTmz
         zoEwM3BmPuBiHjtBssRDq3OpY1epwgQmBY2F8M+H1ZZk5yt7XuRXP/izJ+/etowbYZA5
         2yLAymILXmiVUwV9C6Wsah30KuyQk3wbTkk2XmtUjTWzA6k2kjUbRjWyK17FeWaPMPBa
         FJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c8OtRFPYPme7k+s/39Hja1ZlRUUoR2PXsGDstekJPv8=;
        b=P+R1pH5m52QFn7aH88WwjY6hIVH4sag+z+b97P7DsJYy/CpcgxTo8pailtMiJntKke
         eCbdy0DToI3ecHwHaW/1d+Seywt1BFGqjyT6mfP+QKrPRwKkUewpHjql/kVbw4kbM3K7
         0BKACJbkIVWPEXqIx1rzSL/wfcGCcMf80Uza51wQueIYxhDfGam+psRbdzwSdI/Yu+6i
         YEc0JtqG/IVPpxav4KFMM3cAR5vDzak7hOVsYANyk3ehS0ObGxTa78Q8uFrHj0ceDn9/
         xFoLv6ghK305HIWSqPulSmHCq8KnxUa2mz9c7umgVDgSZquqN09q0tlcrrUZoPrUUinE
         V11Q==
X-Gm-Message-State: ACrzQf15aBrzin58mn0FF+fr+LY+X3mW/nklPtH82i6e7RvW4/Dpa7Vv
        sxliIZ8+TtHG5kKjNhd1cDc=
X-Google-Smtp-Source: AMsMyM4OcN2IvHQzU2jce2QhHE1zfJ5CbDOUPl1IJOwRjNr3GA3EV9WKyQj60lqrj9ExwejhL6nsjQ==
X-Received: by 2002:a17:907:1629:b0:79d:aa05:3783 with SMTP id hb41-20020a170907162900b0079daa053783mr26888090ejc.637.1666861103843;
        Thu, 27 Oct 2022 01:58:23 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402158a00b00457618d3409sm597875edv.68.2022.10.27.01.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:58:23 -0700 (PDT)
Message-ID: <ea5af279-f44c-afea-023d-bb37f5a0d58d@gmail.com>
Date:   Thu, 27 Oct 2022 10:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] ARM: dts: rockchip: fix ir-receiver node names
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Language: en-US
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

Fix ir-receiver node names on Rockchip boards,
so that they match with regex: '^ir(-receiver)?(@[a-f0-9]+)?$'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index e7cf18823..118deacd3 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -71,7 +71,7 @@
 		#sound-dai-cells = <0>;
 	};

-	ir_recv: gpio-ir-receiver {
+	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
--
2.20.1

