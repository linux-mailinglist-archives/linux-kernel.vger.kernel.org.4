Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC1679560
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjAXKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAXKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5240BDC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d2so13394357wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLmolkcXwsNYtpVGeeRXsVm3lLPGm7voeNMYUoB/fn0=;
        b=NZcYj4ufA+8bENflErXhpiYEvPluE9RpszFLOt6UuNxKzVb4T+3DkDFZTolSpSGVs3
         F48hdocgt2ELvuKov/Dhoz3P4SdYHkS4B2CObrmgMQh1S+Hjd6j/gzl7Xl0edAntG4l6
         ss+hteLlREfkR9hbf323dciHPE+eIBmbOgpZtnsoBuJ7QmqLWKBTqKJ1JWp/v+qHHAQh
         cV503Tioy2O6iLqY7Nh3j9cG4Yz6enuLEL7uIWDeKH8ImegXDasZAYO28jn/42X8BkHa
         RLgoNHCYJoAgXMpJ8QyuutIyvjh+CHUowATC+wX950j9re2J0zmSSBE4oYYFTxyaNFVl
         8icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLmolkcXwsNYtpVGeeRXsVm3lLPGm7voeNMYUoB/fn0=;
        b=h19ggtpn2QrQux+TX0+dRXjyzgXPhGQnfioS2EaPcE5iM2yY2NmNOZQRhQegA+/Hu5
         0ixIc9o6AYZLj1QCbjIN2PN+UG9W5F/Ntb0V6vqbZrqJTST9f7cU7qSr2U9Ui7behAgG
         4ZGvDAA4XD7Bw7wXb+8KmAZg3rHfwVl7B4Q53eHvl+E1TS2hKb6pDKkNzYr3AzfHvdZi
         Pyd5LLRQPGuGF4uG8RoBvv7ikbQKylCEwWOJbGgZwpeZ0E23ktAo4koTTortHWRaM4/u
         D2jeqWX+gFkR6T5POe7VPdP5yxW9xWAjgTchQpf6K8Hcz+B0GCtylHc9D83JB6pE83wZ
         RIKA==
X-Gm-Message-State: AFqh2kp2077BXIAydobNk/u7ppOiR6OsGw9bSVJh1ao0AyktKpUXF5ZG
        NoSGEbsGEDpW8r25intcNP40fQ==
X-Google-Smtp-Source: AMrXdXuspB8nkmiRDkUQo6gYiN/B7cXU/ORyyqjX7dYr3Zd8CROiQh/iiwJJRk8xJV2b+qhkGw3xUw==
X-Received: by 2002:a5d:4103:0:b0:2be:5408:5d6d with SMTP id l3-20020a5d4103000000b002be54085d6dmr14228835wrp.21.1674556471601;
        Tue, 24 Jan 2023 02:34:31 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:31 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:29 +0100
Subject: [PATCH 08/14] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx:
 fix invalid rtc node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-8-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
pcf8563@51: $nodename:0: 'pcf8563@51' does not match '^rtc(@.*|-[0-9a-f])*$'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
index 1916c007cba5..e1605a9b0a13 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
@@ -217,7 +217,7 @@ &i2c1 {
 	pinctrl-names = "default";
 
 	/* RTC */
-	pcf8563: pcf8563@51 {
+	pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 		status = "okay";

-- 
2.34.1

