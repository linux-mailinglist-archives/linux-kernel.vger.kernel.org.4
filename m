Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AE60E967
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiJZTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiJZTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A0A1162C8;
        Wed, 26 Oct 2022 12:43:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z14so14697245wrn.7;
        Wed, 26 Oct 2022 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enN+JfcsaDXa2cFHCiOAb6Z57pSU23621zQPBj32zvs=;
        b=LwdDy+tiu6RjxY0XYCCV76OkRNj/OrpUACc1xi+94nVr/cJouw4MpkEJJSth14qGI5
         K5+69ycQeSwc5M25pQhco3ToA0kU41N7oStJLaVDBx01z9RKXVCFIXX9FsFinRlvZr2w
         RVbtMSdIQ1MDwBvkdF/0lEUV6xU6Xh5AHxX1GvlMvC9BklcUVjEHHpAxZqHkBg0bIGrf
         neTgNrm/fV9+AiV4awcbJM432ocDcdXRo+TuFXc+xfR7kB0ZQtEzCBjup8jmSsur9Jnb
         g2n09hiCL6gMRkqnR5yzvx8YmIPs4teVZU6XQl5ThhffLQpKKtYPJOup3wzKXdgZCWOY
         QLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enN+JfcsaDXa2cFHCiOAb6Z57pSU23621zQPBj32zvs=;
        b=F4WGYfKDBI3moYC8/Y0evUJGW8p3fofTu0vMkj92d0X8sUT86+qMMht/t/fnWqu/Pz
         MBQk5c30LA4QpcJQYG25nCl5YIcpjaFgB9vL2Ul896hqvNGZOKFXtaoJObS051vOvFQQ
         raIfCbkwHXgCyB9yvMbmRtJvZPmHTtH8efobQYxZ1Ij5y9fPDVbqdAGkXLpxDk7gaFJ5
         f4wiUed+F1p7uFgCH4BsT8XlZBlSCEIc30SE/TqudheFzNOJ4Dlrmr08iKP3MpN8n07f
         BQ4YP8CRVvbd3nh9ljE5b6uv2ZBvlI7ARnAG6qyk71MnKKiXHsn2IIGebgSIjcv7dEwV
         1Gxw==
X-Gm-Message-State: ACrzQf03pDDoBDjPhsTgWQL9m8m9539PIXchi1s4eaWBUBXpMe9K6CUf
        AuZeN1wn03kieWsqt9f33vLOkfG5kAwOSA==
X-Google-Smtp-Source: AMsMyM516aAJwgNtqU3/pCYvkfn/fYPSmd7C8srf000Qhrl4j7kVJvIDhmnMog/UybLrgGJMrMQymg==
X-Received: by 2002:adf:e94a:0:b0:236:6f5a:e89b with SMTP id m10-20020adfe94a000000b002366f5ae89bmr12534700wrn.451.1666813436252;
        Wed, 26 Oct 2022 12:43:56 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b002366553eca7sm5658365wrb.83.2022.10.26.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:55 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/6] dt-bindings: ingenic,x1000-cgu: Add audio clocks
Date:   Wed, 26 Oct 2022 20:43:43 +0100
Message-Id: <20221026194345.243007-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for audio-related clocks on the Ingenic X1000 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/dt-bindings/clock/ingenic,x1000-cgu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/ingenic,x1000-cgu.h b/include/dt-bindings/clock/ingenic,x1000-cgu.h
index f187e0719fd3..78daf44b3514 100644
--- a/include/dt-bindings/clock/ingenic,x1000-cgu.h
+++ b/include/dt-bindings/clock/ingenic,x1000-cgu.h
@@ -50,5 +50,9 @@
 #define X1000_CLK_PDMA			35
 #define X1000_CLK_EXCLK_DIV512	36
 #define X1000_CLK_RTC			37
+#define X1000_CLK_AIC			38
+#define X1000_CLK_I2SPLLMUX		39
+#define X1000_CLK_I2SPLL		40
+#define X1000_CLK_I2S			41
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.38.1

