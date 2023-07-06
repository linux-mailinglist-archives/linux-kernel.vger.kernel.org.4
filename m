Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124A7496AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjGFHme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGFHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:42:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A721982
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:42:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so420721e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688629349; x=1691221349;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x64cvNWMyAOtj53CxXFEsM1gwZXeKU5DF+oBaw1uYBk=;
        b=l98nfWhuhVHY1arWpHEptZVR8MKJuNCq2+n+IqELw4RqUbbSvdyGgMOyLO5gXlIied
         F9OkU7rJN2KD8rTRnWNhVrFj16DXTlXpw6FoelvKaN8kH/BEL+PTKLlP8oPhGI/mVCwO
         0TrwnX+iDsIGvZEe3BNK8hkVMIb1ffaPMztuPhdxfqhCPYhFfRSCure5vrspuxE26Ozv
         abPQKOT12cCkASDolij9Cvfb/oAw3INuY3+uyN52foJ3Q6SRFqtOkz1CeVEj2081Gs+m
         fmGwX1sk51NKrqz1g4lW/fmRZULAl6SZpsjmLe5QVEjjTT9sE7ti3/y1ZQ9PEdIpO5yM
         ypXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629349; x=1691221349;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x64cvNWMyAOtj53CxXFEsM1gwZXeKU5DF+oBaw1uYBk=;
        b=cAA95T9IKl+rr0QZNzjTH0IVYHqmc1azzw6XhVMGLEwKrEOW2DR7ltkR+qkj62o0RB
         RN2OrqbU635PLbBXeuKOS0PmzX6dMJZPUZsi61hfJOTYEA46pirVuPRKaE0dNWaaNg3Q
         vDp5VdZtXcoje//Tzq7kj9DnMrCNuQwTdImj7IkhoD8lAmhRTwHap/YEicw5maBb7FDo
         ISEBnTJhptSvMXj2Jc5lL8NQILGUoApgwLXs6R7BKdrpvJifeNK1f+AyGi5r0ROj5WIx
         xoSj3RjMkvKA9s26DiB4KVlHmW8t8EBbnzEfw2dWeL6sYLg0cJDBP/rs767E8hiohvWm
         OdlA==
X-Gm-Message-State: ABy/qLZrgPJbTV61VDXpVBAS+LK4l8JmwuHzqOFROgWJ9DDLDfSjbQrT
        TIqIkJ/rKO4y4bXMyzG81jTPTA==
X-Google-Smtp-Source: APBJJlFzH+9QB4KwLcBEovhsELMHthw5vcgjq1xRwpNlm8hQJeRp/qfClOu+sWh5w+TRejmmidUFRA==
X-Received: by 2002:a05:6512:3b2c:b0:4f8:bfb4:e4c4 with SMTP id f44-20020a0565123b2c00b004f8bfb4e4c4mr1116470lfv.19.1688629349480;
        Thu, 06 Jul 2023 00:42:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h5-20020adffd45000000b00313f07ccca4sm1076798wrs.117.2023.07.06.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:42:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 add missing properties
Date:   Thu, 06 Jul 2023 09:42:25 +0200
Message-Id: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFwpmQC/x2N0QrCMAxFf2Xk2UDtZBV/RXzoslgDW1raKsLYv
 xt8OhwO3LtD4yrc4DbsUPkjTbKanE8D0CtqYpTFHLzzowtuwp6LEMZtzcn4Lq1XjhsWUep1xad
 8cRZdRFND8nO40DSGa/Bgi6Wy9f/b/XEcP8NnwMp9AAAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ewyoXu4idxKpr7L4LgGX3vSs5fM7OWs2XAtnKUZOizc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpnBj03tLk4M3+6jnGHkhu4eGOQbxdHLb8qpQ4iJM
 94q2hOmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKZwYwAKCRB33NvayMhJ0ajZD/
 9QMTvozPgPzHzmdVRz7Ai1YY6Z8DA5hvCGMmI+2BvshNSIwLWhbduAsZCVzEuu3K0Us84NkhTJ5aVr
 8Cq743wYnW95EfT5j0iAosWrotAVMTb32CNTCz1ilrqO2/fi3FTEN/bnNaqibP4uPHTT6rEaRyM3Ty
 qfvsFUVkZBXCrxFJF5DUjiF+4WB3CF1FzBu0iKedQQUW+JDIIXH4mmH7QAJ+LAwNM9jCv/PkK/dMEQ
 Q0NJRGtRHE/ZD/zAO4DPTHF65WYCj4OkJNiRQvacXmaxJTuE+L3OahEnE03rgiI4BdzcNyBsqKpM6I
 zvqvUMVfkPQhc+XbhGXK/RGMu3iWv9k60EIA36lGOGkuoLq8GIVcjiginqSalJiRhkKni+46LkFkbF
 4owVFxWuWijnd7Y3nnOHsuQDi56Cq11a4sj980wpFzHuEkz4F5uEfZGbVkLhBtnzXAXrb6BcDdTR+P
 Dk3+hYkJxb+bOtWjWqAq6gYNeeFQja4S8hfTTbUDPQQnstobAQzzPLnTAkt4Ef/FPfSFRztm6gvf8I
 xdLUkv07582lxnqv+QYpTECsunRSMh3LH6XWcfHHtAUlEr/jAnazLtW/4ydy54syjcp2qQG7BVHBy4
 hXwZrvgSTZdMGRcIX4SNFOIDnGXmhb4wD07CH50/ySkd+MMROVGg3D8nGOQg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amlogic DT uses gpio-line-names and gpio-hog, add those
to the yaml converted pinctrl bindings.

This will fix the following dtschema check errors:
arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb: pinctrl@40: bank@40: Unevaluated properties are not allowed ('gpio-line-names', 'usb-hub-hog' were unexpected)
arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: pinctrl@4b0: bank@4b0: Unevaluated properties are not allowed ('gpio-line-names' was unexpected)
..

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      dt-bindings: pinctrl: amlogic,meson-pinctrl-common: allow gpio-line-names
      dt-bindings: pinctrl: amlogic,meson-pinctrl-common: allow gpio hogs

 .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)
---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230706-topic-amlogic-upstream-pinctrl-fix-bindings-c2b74c637872

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

