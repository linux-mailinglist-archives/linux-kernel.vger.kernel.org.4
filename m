Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDD60F308
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiJ0I7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiJ0I7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:59:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9A15F92C;
        Thu, 27 Oct 2022 01:59:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i21so1528998edj.10;
        Thu, 27 Oct 2022 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w0IUbPjMCAB9XHK86X/OlsKfO5IDtTUMHXt/Hq4ivA4=;
        b=o0B61ERuf4hfAzCZx6I1fqmQcdEvElx1DFTbZTG2WwCVKN5GCfwIQw+2c1H1YFhb8S
         l0i0NyzWyJ9V6EuuQJ4rxjJJOxJbYLiA54MMRqqYOGnf97Ecbfzr6/r7u3ALMnvH8gZU
         95/AQk+fg26STzBaraQfnGpe5jLXteJ9oNGPDxoRfmISlSobdZTAoIrSP/xt8rfN383J
         HUz0rxyUmh0lAIhRytzv3VQXbQXCRV0TmL0Grt4zW0U1wLlI+RGRANIo59vlysMBtKdW
         N1jInSqzzJD/xbCfXAQMoT2befDCkf/6HwVNg21skF5J0k5jEKxi75M2pZIdNpjDfx3s
         S3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0IUbPjMCAB9XHK86X/OlsKfO5IDtTUMHXt/Hq4ivA4=;
        b=TY9zSv9AGsVCWCvvVK/3oGWJpAIj80OsKLoVYvu5HL+mY1ncndrZeui59Xm7ppNgpt
         ji1uJiRVtOdvu6jndedXFTeoQWB/YCV9nzHagfrlZF86VcevlBtz6F4iO0PEpyDSQ3H8
         FHJD++MQhFZnMz6iLakJUcb5xBA5HH8r3dJr/2Lm1X1iWWY0uR/GxoGHAncsZbsNDY96
         qKmOK/AnwtqnLa/YjLfif+Pjv3fq+UjLOcWXC66N3FA5JBI2uM1LsQL12P7XkWwvM9h6
         +I0X4rC4OuTPYrf75Kfu93IHL5eNwe7S70vDDKSDvgNkhrpglCDsBBlpZMK9vk5yNMmZ
         K8dw==
X-Gm-Message-State: ACrzQf2bSoEe3RBgCQ4Rixi2t7aPZ02dlFXky3GYP/svhXh38Ceu3xpN
        8AFlXdLWVCnla7LJ9hWLV3Y=
X-Google-Smtp-Source: AMsMyM4BMxqD5i3Nq+gejbtjgCLeW2p17a0i+1GyKoe/S0UBNMWJpCO0m4d2J8f0tJgtDJ1tx1L5ag==
X-Received: by 2002:aa7:c58a:0:b0:461:fc07:a821 with SMTP id g10-20020aa7c58a000000b00461fc07a821mr14744879edq.19.1666861152049;
        Thu, 27 Oct 2022 01:59:12 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v13-20020a50d08d000000b0046146c730easm607498edd.75.2022.10.27.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:59:11 -0700 (PDT)
Message-ID: <e9764253-8ce8-150b-4820-41f03f845469@gmail.com>
Date:   Thu, 27 Oct 2022 10:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: rockchip: fix ir-receiver node names
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <ea5af279-f44c-afea-023d-bb37f5a0d58d@gmail.com>
Content-Language: en-US
In-Reply-To: <ea5af279-f44c-afea-023d-bb37f5a0d58d@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index ea6820902..7ea481677 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -19,7 +19,7 @@
 		stdout-path = "serial2:1500000n8";
 	};

-	ir_rx {
+	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
--
2.20.1

