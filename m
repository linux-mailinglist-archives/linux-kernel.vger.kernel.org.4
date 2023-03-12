Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C886B6A51
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCLSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCLSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:42:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A9B12BE8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:42:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j11so40301184edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646546;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=kqqtdyPDGtaPt8K0rF+Csmx1TUQ1qTB+VlYbeR4ANqwMykW4+WhXIIm0DxmR6v+ZOQ
         qtqJwqFweoBdZDj9ZhRNT6y3NVBBoDhPOr7s/0zGPu4vC3wQEYkD66oxSQCpnxt7EJ3W
         x+ADUqWBrrLTeavzrxOZa40kJJbHDUces6RX5hgzOJyiVtHcsECZ3pT3icK0TNwNHjIR
         04dTuC+KISMf4w7tmST98tdMsnnHW+GgBn6S/F61UJK2/n6qGtuhy+4urZrV2657lAEy
         pjCmR67x52eSBqL1F0dzj6NTTalir9TWCo2uC1TdVc5V3nnmlurJP3BxaeL/GOfLmOx9
         YY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646546;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=GVzXZKzHy+kY6Puds9NHkO3BrvmlhtwU44f+utFfuJi9sZeRvYhKM2IcQUhId3cgkZ
         oDAVm9GB5moUWOl3tefD0IztGWXieHeWLSOWRlxTxdve3eJufKpkAz11iDhkZ71KLJZO
         ZHWgcVkMQBSoc9fnBi9X5mnlsZ9O/lYgKxCVnse2TTyDzLH+u2Zs/y/N22O9VJd41Hko
         wUued4qiYWVuG5U9E3l/om+rCHe47aLAC8Y+ydiU6S8QVNnQXR8G+zM6Hr2en3lwuMAa
         vkTgyE/2E9y5CMyR8qVVw3f53RLfC+gunDwn21jl1iprXiMfADF/tlSNQc9Xo+OBs8vc
         5voA==
X-Gm-Message-State: AO0yUKUdQt3EpSN5eLZ/Pjtl4QKP9nyCgsYv4c7c8KlJU62CrpaSn1lJ
        PW7Bb30ec5SWpydlHZoSUeTA0wnmFhIYw9wk
X-Google-Smtp-Source: AK7set/9SmrJWTBgcgJjpZEUgBcf8Gd/AFl19dNxmvX3GR5CC3JkO531GArtCtNzNpIiCDNGWNb/SA==
X-Received: by 2002:ac2:434b:0:b0:4dd:840d:462 with SMTP id o11-20020ac2434b000000b004dd840d0462mr2550541lfl.21.1678644289038;
        Sun, 12 Mar 2023 11:04:49 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos7885-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q15-20020ac246ef000000b004b564e1a4e0sm707417lfo.76.2023.03.12.11.04.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:04:48 -0700 (PDT)
Message-ID: <640e1440.c20a0220.14dd.1a53@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.

Add two new compatible strings, "samsung,exynos7885-dw-mshc" and
"samsung,exynos7885-dw-mshc-smu" respectively, to denote exynos7885
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..3eebaed2c 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos7885-dw-mshc
+      - samsung,exynos7885-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
-- 
2.38.3


