Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A06D3E46
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjDCHml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjDCHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:42:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD7CC1B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:42:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t4so23026849wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAqvm5zsozuKX98Wuo0u9Kq1oEhbjhsKVQ5yonQAyjM=;
        b=FP9x/tmhDk46p4CDKJ0YJ/jBwiTSwINc+JTp1WfWI4qFoQVV67S55Zrk2ZA70+5kCw
         qafzZoitSidQX3Ltjamyj5jCPNxJZCTvrmO2UvKiD2DuDj4kf8JARnCwZFrlLUM9eg71
         jmV0mVxcgLy7gv5tXH1IpsA8NhIYuY8a4xUk1ugnHwCv/vRVJfMkG57r+73Xwc48hbGd
         ovs713IvgGeOsjV2xGPm1+txak5cfvuHRtDZ/4yz3k+QnMoAnro7jVceOuzyYJKQbfte
         cTzg2lS4oc4V0SoAyTmd8JjVbC68Q9MWvMIFNDIlTsROMeM9nZd4c0YIvXT472IME14y
         ZM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAqvm5zsozuKX98Wuo0u9Kq1oEhbjhsKVQ5yonQAyjM=;
        b=xeRFC1SsCKFZJp8UZVCfcyyTt66yIIJw3T5uvk9QYkguLDB9M1FMs35WCUY8GkgFbC
         tdmXI05bB+zEJK85K+8Rza6fiqNHq+4/JojHRQzNzzMYbx35APVCwl7UagD0CEponryM
         9d+gN++aoKogrFWC1e582cKSQD8mqbP9XpDOGbLueSmYWv4PS3rYW4EkIob/ZCcuugzT
         u2LcR9XL5aHpqOZcYT6SlBRt0Tjkt4/7aGWfCmyt7vVHZJlWYF9QLfnLjqmQJMzRezGm
         uCAjb5KI+1Rvhwz8zKN8zEjzkN0XSLzNII+XjRiPM4yUJjv8OGxnBsPt142HTOmmF5AK
         4OXQ==
X-Gm-Message-State: AAQBX9eov0lnzmDpiuoSMPRa/rzgAUr32nvPGiGG8VDGgzlKrQc3zoh5
        /yjVV4KqsfrimJpuXVZ/mwP5Mw==
X-Google-Smtp-Source: AKy350Y5YpMGRudkwfYwF/b6z+JRM70k1GBG0D+lQ+p/MhL0fYtNJwcfD2+Kyjml1kg/BmHt12HCjg==
X-Received: by 2002:a5d:58fb:0:b0:2cf:f0d9:6227 with SMTP id f27-20020a5d58fb000000b002cff0d96227mr23697805wrd.0.1680507746968;
        Mon, 03 Apr 2023 00:42:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b002e62384d17dsm8180482wrr.21.2023.04.03.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:42:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 03 Apr 2023 09:42:21 +0200
Subject: [PATCH RFC v2 4/4] dt-bindings: arm: oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-4-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 SoC and boards bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/oxnas.txt | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)

-- 
2.34.1

