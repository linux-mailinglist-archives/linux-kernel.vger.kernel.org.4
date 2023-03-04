Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F696AA972
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCDMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:33:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8003111174
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:33:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u9so20603240edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677933223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYT4jMLZ95Xys/g3bLJcTF972/TquYeElIQo4Dg5KU0=;
        b=bZTWOa8yyQo5Z2UWCnxUQmeHXHkvgKOOqNamXziKOJDztw4XOkOut9E10cKGdEYsz8
         ynjYXDNzHHwGOVxwbsvCHyUN8/ofein0TW7/+kT+Aw9GK7FPANJfWAk6DpKwFvGOPLqe
         2RvOrpn0KhPMtfDlWLVc2/tcj1r917CERBXHWeYIaDGv+Q9qqG7WhDHcMK5TC/8RZ9uz
         c991FPvdScqf0C+Y7nKRndd11BYkQRjIIHHnQRlXQtVLGWBkAdq3/R4x/lMwc47PyfYr
         J8NM+vNEp2VFnxcr2g53X/GlHKvc9mjg0xGxWUWMeFEXklG36VrdA0XSJjb8RLUzW2Pe
         mfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677933223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYT4jMLZ95Xys/g3bLJcTF972/TquYeElIQo4Dg5KU0=;
        b=BvVoSPQtGeaX++ELlkPdxSd0+Q4mmQONUKtoJltkQ9KO443AXNiTjOurG+djzQ0e4D
         JKq6X0tv0bIC27+vE882V0ne9OVgI+DivP24e0bYP/5dih543nxAaC/ImrYdLLqBdtr4
         Kbe27tSBN39n0EmArVX81LbMcvJQEiKL7mIlq2Yb9+4k77yl22OTLWrSSdSXwfIsJBGS
         CESiUfVCBSfS+kv2z927ZjVREaVS26ZhgaxkVFOsmUIaj3jQOTStTdIECdC8WEnkgYqC
         qN1k1exjyiLSx1P3vfbfLFqKfB0LWSdEaGcw8ZMZOPzWdFX2KSI+IhvwEUeVKCs882y4
         uE8A==
X-Gm-Message-State: AO0yUKV2Yom1GbE7KcxPpQxHdiFLNnFrR7oz0AimAKJXck8WZAqWPC5L
        RbY1GSjg94vM6ZK6lbYISoRU8g==
X-Google-Smtp-Source: AK7set/mmUaaPdp2AymtP7v78OSVFNIv0URgmBLmRE8WYZExXzQhdZGh0ReZ5YLQXDuczSJrkdbnhQ==
X-Received: by 2002:a17:907:9611:b0:8aa:1f89:122e with SMTP id gb17-20020a170907961100b008aa1f89122emr6242603ejc.39.1677933223133;
        Sat, 04 Mar 2023 04:33:43 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b008e6bd130b14sm2058342ejt.64.2023.03.04.04.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 04:33:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: mba6ulx: correct GPIO keys wakeup
Date:   Sat,  4 Mar 2023 13:33:41 +0100
Message-Id: <20230304123341.34223-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys,wakeup is a deprecated property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/mba6ulx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mba6ulx.dtsi b/arch/arm/boot/dts/mba6ulx.dtsi
index 5bf831b072d6..e25f8f209760 100644
--- a/arch/arm/boot/dts/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/mba6ulx.dtsi
@@ -57,7 +57,7 @@ power-button {
 			label = "POWER";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
-- 
2.34.1

