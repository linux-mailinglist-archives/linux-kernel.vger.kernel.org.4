Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0535EFDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiI2TNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiI2TNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:13:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79802DED46;
        Thu, 29 Sep 2022 12:13:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b23so2256182pfp.9;
        Thu, 29 Sep 2022 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=kZqs3bjJAVQBzZbYKXFkktUm9qLdAIeHDAPA6tDYdqk=;
        b=kqn8lNCfbbV31LBjEpwcTXRo0nu5z5qSww9RRNXQcVG7NuOvQqIaadijVRzLcTD5m2
         htN5P6spa3/adSvCeg1P7bMZ9qgM5yOE83oEQvJP9CL1QFec+YmUYDZs+Ar5C+8vyP9+
         cHQOGZfvfrwdQU8CbaXI4qIMcK6ON2YTWeMcDZCYoCQggQ7tQYWWcjAmW96eMDCgzmlh
         mXAISnF45irZ2Gu/a+mP5YO1e5AduT9yboXD/IGHcpbgXLDXC1p06u5iw2tHgSyh/5PY
         G96FkLr5TYEjx14rNXF0MQVlmJWL9BA0P5RxRTmwY9LsqyptZB5ztB7NGYYXKC49kZeb
         8FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kZqs3bjJAVQBzZbYKXFkktUm9qLdAIeHDAPA6tDYdqk=;
        b=QnXKOaB8Xm8+ABZ6XjzA0CDkzC0KKVE0b8CAUYBfn6yw/2b0dtvkXdct1MG6whZ9XJ
         0r89vtmCG6Zz7fM1xBgmt9Foj0W3cjKXt0T4NSdZTU+gtfzMNxlV3rWsG/lefbCnRGJU
         O16x9DhOy26b0v/mKJYpgSUoTrJl+oloGVeeTWSXV03qNyRtdcwHuTJbOhHfYpX7cBcH
         pxI1M7SEluo9zwsQ3S0hFlnzxHrg1I4AiCnv9HVD4EQT6kMlox0NIISaLS2S+So6HY73
         a28h9t4H/nFKqQXWL4r+c+u10r8ZHCwt2oVYJaHoLHR7IxSzGKOM0KLnHU3jhos5anKp
         UKtQ==
X-Gm-Message-State: ACrzQf2Uy7czGyQ8e+CelacgU9fleLwQO2dvFbmvJ4Yl7+CLrOb1bnxE
        wQnMzZMQ7JAMZq7jHJq3HRQ=
X-Google-Smtp-Source: AMsMyM5CQjLmzJaA/UM975H/Po5mlaSDe4OlkHONXzEkLDlDMVHduk44+EjxjkoljycBvV/r7/B1IA==
X-Received: by 2002:a05:6a00:2314:b0:546:ce91:89a3 with SMTP id h20-20020a056a00231400b00546ce9189a3mr4887389pfh.77.1664478807635;
        Thu, 29 Sep 2022 12:13:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a195e00b001ef8ab65052sm139574pjh.11.2022.09.29.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:13:26 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:13:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RM: dts: stihxxx-b2120: fix polarity of reset line of tsin0
 port
Message-ID: <YzXuU/60TI3tc6ii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to c8sectpfe driver code we first drive reset line low and
then high to reset the port, therefore the reset line is supposed to
be annotated as "active low". This will be important when we convert
the driver to gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 2aa94605d3d4..d52a7aaa1074 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -178,7 +178,7 @@ tsin0: port {
 				tsin-num = <0>;
 				serial-not-parallel;
 				i2c-bus = <&ssc2>;
-				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
 				dvb-card = <STV0367_TDA18212_NIMA_1>;
 			};
 		};
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
