Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7FF6E412A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjDQHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjDQHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:36:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBF3C3B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:35:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so9393771fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716898; x=1684308898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdge6a4JDiruNd3imU9/L1NhlUICcC+6sBqY7kaO9So=;
        b=HX0MRrzXW5+rVaVp5wEvJKoBYQvR68Nxdvm6JOa1KPUy/RokGXGhIue8OrU4WeOEu2
         B2Zj57kf1qlkAkw2nvrZmIwICnRsl8wOnsD2K6qLkrIOLdRzfNtSLcClPS+hfTqP3UvK
         yccxgVGnFJEEk1lK+GNACHlGt+CidiHgTkuRPP1T/+BZ4Y6cyWNarWkHYqLRwgNYr1gI
         iKtMqIHQh483gwrmROQZn4whIXWvG0fJsRTi+zCE5NWAcwkbZbYuvJkhPZFZGDox/rYP
         nsYN/XXFFwXHZjt7NzcSTovNe+0FDmclYhZL3fxo0YSZjAsqu8aqXM6lip42HyJGd1F6
         aM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716898; x=1684308898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdge6a4JDiruNd3imU9/L1NhlUICcC+6sBqY7kaO9So=;
        b=ZAD78RaqSNiPcDdzSmtEYT/VdXebTH2XFFpEQZUtzojSW8x8ZIGpAHhbRQZbsF3CMq
         6Zicws6UTQhVlYSp1DXfZOyfiK2B9oRLjiXc1YIhlRdd3iD4qCDMpXM3RQNY5bn4g0C6
         uoUTTsN0Z/lhVd7KHNU5GA8HAbZ6fpV8iO9vIVhwVXrazFn2DhF8bgAHxCWN7QScXIpE
         miXo7kssxUTbkn7WLSuvfcRQqW5jmg4NjnegQghx3NzMqfsmVn1oSwGfJ8Dc1pnpWT6Y
         qBucyVid9qT3B3LlzdY1bTAPyJLon213uNAAklz3v36Qz5Nl5D79VNybw673k0eSCBWO
         0YGA==
X-Gm-Message-State: AAQBX9di4tW9GaPKcy0RSe/Pil6qk09K7kVnXiT4wqmpCVUUZx3i9X/+
        v+D2o+wEamVWERglOPsCKWT9Wg==
X-Google-Smtp-Source: AKy350Yv+d6lc4zRU2N5tGPWChtws4rli7B1vq16ITPhIt/caTCHY74r6hD5WZBFYQCnLv18PzBKwg==
X-Received: by 2002:ac2:4a89:0:b0:4dd:9a38:fcc with SMTP id l9-20020ac24a89000000b004dd9a380fccmr2015468lfp.63.1681716898793;
        Mon, 17 Apr 2023 00:34:58 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id w15-20020a056512098f00b004eb2f35045bsm1956275lft.269.2023.04.17.00.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:34:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:34:56 +0200
Subject: [PATCH 1/2] dt-bindings: sram: Add compatible for ST-Ericsson
 U8500 eSRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-sram-v1-1-5924988bb835@linaro.org>
References: <20230417-ux500-sram-v1-0-5924988bb835@linaro.org>
In-Reply-To: <20230417-ux500-sram-v1-0-5924988bb835@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SoC-specific binding for the banks of eSRAM
available in the ST-Ericsson U8500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 993430be355b..0922d1f71ba8 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -94,6 +94,7 @@ patternProperties:
             - samsung,exynos4210-sysram
             - samsung,exynos4210-sysram-ns
             - socionext,milbeaut-smp-sram
+            - stericsson,u8500-esram
 
       reg:
         description:

-- 
2.39.2

