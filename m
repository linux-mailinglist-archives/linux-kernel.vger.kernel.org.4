Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EF5F97C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJJFe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJJFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:34:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29434F6B7;
        Sun,  9 Oct 2022 22:34:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h13so8440096pfr.7;
        Sun, 09 Oct 2022 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsknVx5+YHnDCstXCltTZLAG2wl7RGztZpW+itUt1UM=;
        b=pYkbYwh24ZepioWfLRiiCPruIDfH9Koi4rcnua+VLn6YDRAxZW4tw2ykO1ZCdxOLBp
         aA+yDATnR/psGrUExZ37OGoKxrhztQiyJRhJJfs5/D8DsKJxG/V6P0KL6n2h0keWLejG
         dfICOyEubrJk9rz4g74x9ECuFFC0LCYBFyo4I9ALoJ8a0QfBA8zG44tfVWnq31pcCWr7
         3d6nhjvMg1/wT5p4bsMHIDv8vS/BLOIxDFq8Z3pxThQZKwUr95iRyC/TvMXeH0cVHvSV
         vC8QsDT3ICLvNn+EzYXzO1t0rEVKyI4NLolAiy9IidAr7t4u6o0lfI6GQvWvlBf8oBSi
         HEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsknVx5+YHnDCstXCltTZLAG2wl7RGztZpW+itUt1UM=;
        b=eM3qkWg/Y8waQWHgnait9SZf0G0JDjJMo/yy50UOFClTX9BbBXy4f1ZRNOlhKDnOUQ
         CHX40EyRtqcgSDKqFcW3D1h02UaR1HBMj9tSKIGF6/AvLARPoK/PN3sPt3umpYJZF4UL
         u52xSy04IZGYIOB43wmosArYIICqwq8sDcVgp5vX20cCW+kqMNdQ3kRaJJ7eXGqGZPx9
         vxm0LMYvr05yn/0F29yYEg+F7FsjE5Ou3/rXTwrp8uamzEnOsjeIpAB9uGsiexgQXzQQ
         c3SLVuWwcfQuOzec//iNuMyB13dTIQFmhnuqXYsIj+1gxJSMFbQws2qWnYYJWtclbll4
         rQ7g==
X-Gm-Message-State: ACrzQf2tU5sEbv2tKH1Rn4jP9YYg5dhCzsHzBv9ddlPMHd7ci+vtmKMK
        3kdVC582UdG5dHOt8qVYN9s=
X-Google-Smtp-Source: AMsMyM6hjnsW3MlH/f1wnZ+AeJlqZopS3StbOFPAg0mK5sX7JZo12ct21lVoDZLj7WpKK499voeN+A==
X-Received: by 2002:a63:4c2:0:b0:460:869a:f5ba with SMTP id 185-20020a6304c2000000b00460869af5bamr8001444pge.362.1665380053368;
        Sun, 09 Oct 2022 22:34:13 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 126-20020a620584000000b00562519cad97sm5891920pff.19.2022.10.09.22.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:34:12 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/3] Convert Unisoc GPIO bindings to yaml and add support for UMS512
Date:   Mon, 10 Oct 2022 13:33:35 +0800
Message-Id: <20221010053338.22580-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

V3:
- Removed a example from sprd,gpio-eic.yaml;
- Added '|' at the beginning of description blocks;
- Added Reviewed-by tags from Krzysztof Kozlowski and Linus Walleij.

Changes on V2:
* Addressed review comments:
- Fixed typo;
- Added description for 'reg' property and modified its maxItems;
- Removed redundant examples;
- Rephrased commit message.

Chunyan Zhang (3):
  dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
  dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
  dt-bindings: gpio: Add compatible string for Unisoc UMS512

 .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
 .../devicetree/bindings/gpio/gpio-sprd.txt    |  28 ----
 .../bindings/gpio/sprd,gpio-eic.yaml          | 124 ++++++++++++++++++
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  75 +++++++++++
 4 files changed, 199 insertions(+), 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

-- 
2.25.1

