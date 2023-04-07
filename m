Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C926DAD06
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbjDGNAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjDGM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDE7AB8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so42248707wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872384; x=1683464384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QkkEgowsBjZnjX/gOtAy8+xgH7LTkosTkX/GzGdyGM=;
        b=Bdvy/suIOXko5XBR0JKtHYSCABSjQLM/1tUCg34Ut96SZt4sMW7nKVJVQ+GRqfYKDd
         Un09JL9jh/B30nUI69Wt0SuvJvd6kLiC8cczMoW1DOcjwGprXacidpUoOp9VVj3fxSTo
         sEgo+Z64qA13yRtGY8uZuiy1yYmpNxTG3qaEhPoeewq5D0duXHlylPQ4oeiXRgCIhut6
         H82s4KJscvvZES+Mun79usp3aRw/KUWJyvDFBtWE7gWpomtcTP1pQlrHc1mUQ1Fl9N/G
         jJ8OFpwphHSE8Xwu3aKMqYSwPAg+LidKsdQGqz9GWl3T/VUx9uWTV8q0y1ajjFZFDl6C
         u7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872384; x=1683464384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QkkEgowsBjZnjX/gOtAy8+xgH7LTkosTkX/GzGdyGM=;
        b=EN8rZwI2OgcADEnU2IltVNeaN1155+a+ZPdRDpataPpd42SzFmhw6juwF6eeZtLfUe
         T80+PYNAqh4BU2NeVf6PJ14i/LIkmCMmEbSjFMe/izNrGecXbi0YvbXALJRTq4d45hyX
         yFxUeVViJZm/Ha1Zfjm/OrLj7DpH8UtNmcUSRNLgv8GVTV3vyXtEQvqUPYMAmkVcWQbl
         j5c1/U2d+A+yVQm+gmMZ4irlOq2s+pO5nv3VyAj1gAEzCmuNmWG9lzS5CRB2ld2J96pD
         Y1Br34kakA+qIxpU040gvo97BsbonrowuGaWT9nv+c+zl7yX2BIpcpvJJVIdOaATpcXe
         kkWA==
X-Gm-Message-State: AAQBX9dvKeTzU+7StlGRL80u8sfK0w6W9KHOGRdrp2S2hRX5sj5SIY0x
        lmbDqldOKaOt8lWJyuJbdu6RKA==
X-Google-Smtp-Source: AKy350ZvO+9x3qEAYCwaeUCsOC2teddU6Rrcv2PND6+EBP8rSISG78UD6RwHKOKKL/0QBirN8m8b2w==
X-Received: by 2002:adf:eb4d:0:b0:2ef:b5a0:35e1 with SMTP id u13-20020adfeb4d000000b002efb5a035e1mr238129wrn.8.1680872384143;
        Fri, 07 Apr 2023 05:59:44 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:43 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:22 +0200
Subject: [PATCH v5 03/12] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=e/j+wpeA8gY8YWfUFggkrkBUqt/uFn1RH7+Bbqouv28=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6InolBLE5hgMS/ilZjfIXr7ubVwxfLfIr3ic7
 ugBTojeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURXdFD/
 sHzp7rInfWJnE03dVcquz1XCJOk+lLZHqrmmLKwT5NeqRLVwrwRuQXGlRlPGQ1j6OxdFqiQjG9Rwbe
 kNCW1JUau97hUjlVsWUNQ9TiqzETCBabQIcLKLDx5bKsqLR8b8CuxndfMRcwxnVpiXNZYDVtXpK3Rj
 lHd0iVlVe80rzfmYcjgAW6VVF9OqI/VdHPOl/Uwk5Di3LMOQQhen9kNWGjJlrqJaChXywiRelLUb//
 M1u+7uLG6lLEmAQCKMT5oitgHLv+qVc2DWAXXY9fbB4o5n+3Twi8uqYebZ+MUhdOsZ8E1gWr/tjTjV
 0Im5vfmGY2T9IJ8pfyvhnPFguOkVsbRkcFpXPYp0v28aATUvfdgPa9Y3nOwytKh5WbhLt3FLPq078J
 DerjdPnI2mjBx/GYaiuR2Icj+Jqv4YyR9OUXY9K+UyebFFLVPcJKKtRWON/tI++RghlvJaVvbF25tV
 zwnydim9nRXlvUjOmdIypRtZCpsudOkGakbEymPB+XFfkc7Mr29TbE6bQqK+eKGvkUxzuWKi+5rKSy
 Zu4VtO5mOfvrkRuX7Qw0a+U3hs+AtN1V+Z+iW0n5h9XDbe0BlngU+35pn0m3MmEvNNlnycYcFjvnbM
 nrRcj/HF/8IRrPxnOP6gX3+pkPok8sallrrkzLUcdQxKnxDYu/LcuoLeenuw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding description for mediatek,mt8365-wdt

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 55b34461df1b..66cacea8e47f 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
               - mediatek,mt8173-wdt
+              - mediatek,mt8365-wdt
               - mediatek,mt8516-wdt
           - const: mediatek,mt6589-wdt
 

-- 
2.25.1

