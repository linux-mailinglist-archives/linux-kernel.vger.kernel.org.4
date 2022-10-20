Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3152C6065A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJTQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJTQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:21:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1C1BB56E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l32so238585wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaS744uQPmWBXBI6ZqLder+xi41I4zdp+0x6pn9qEpI=;
        b=BiWAgX/Qr8Rtaa1n4HaNEsXokIi2t7akCjokMnnVo9izFmTT3d1OYSv7Wls0Jw0TVG
         wnHniUa/aJWLtVFhMN4C6h7OqT0SEHs/I+Qz/Nek5lUoSxieBitDj95Gs8p4//CxDAPM
         EFtIovz6/Bg77YsQPiSiA79FgW2uMp/5ohlF5p1VrVItPrkwOkQpSQyk+C2FBhrxPtpu
         WqHTyElGaawjZEW7CwY272Dm9Opr7cMu7GWpP8Gi3IC1zm1YeBT5C+6EaFZRp5B8iJVV
         XoU4pX9m689/ASxVf317uv+VaYvXCGtxT0p5pjOMgBO02+pg3ktPsiK5Q//EzxGOOZeA
         HReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaS744uQPmWBXBI6ZqLder+xi41I4zdp+0x6pn9qEpI=;
        b=LhfTTGjJy4+Nty7VR+/fFkruhmrI/qNLR4oGhly/SQULLJInWPKx0GGMgTPMYI7sxy
         bwpg+VamYI6tJ+CfB+hTrT470BCIMGDJYGxCfvMoBrz6FuKjIuFb5rgt44yAxaq/833C
         QB5NW5OLDdvKAN+iMGgBaqX9mJXAhw1X9CKbT15nw7U0xJBuDkyHcXjOqgZODbeCiupV
         yYzdAb+VP7a7J1MC+aPiXH6lmg+5unIVKwb4OuhdWArOiYVFIZR8KOIH/n5FPNRDEBZW
         tvvQkTUZqSonO5BcZPVm8JJMYP2e4ndKtb7qErKm1FpR5MXO93ChfLZZVoS7QNBZ9NYY
         1G1Q==
X-Gm-Message-State: ACrzQf1jtWh2xvTHeAauGB5H805nNIRe7apqwTfpda7gSPL6f2sCY4Zu
        FN5QVJklQGDTs2VBCHCTlUtTBg==
X-Google-Smtp-Source: AMsMyM4zHtUzyycG6m90vzzUecGOcjVx/uHTBFmgXqMhKmqeWtCLahlCPFtUo1o9TPVoTLPotl4Wkw==
X-Received: by 2002:a05:600c:502c:b0:3c6:f5ff:e089 with SMTP id n44-20020a05600c502c00b003c6f5ffe089mr9915804wmr.108.1666282870743;
        Thu, 20 Oct 2022 09:21:10 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm208028wms.48.2022.10.20.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:21:10 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 20 Oct 2022 18:20:45 +0200
Subject: [PATCH v3 1/5] dt-bindings: mfd: mt6397: add binding for MT6357
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v3-1-7e0bd7c315b2@baylibre.com>
References: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=uiI/lTRtppBO+0nDIciFuabIoTVXVizM4YxyzOA2AfE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUXV0FVtsiYSeZAnNVIPphZdWfF4LyDG6G1xUR+hY
 qezaStqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1F1dAAKCRArRkmdfjHURcbQD/
 9ZsaHlwgCKvcsyUDObkfQQjeMSZYlAX2q5PSCyCwS4vicU+djfUIZZZ4DYVVJLEeV/1jw8S8COwjtM
 /gQ+FT2Ud6no8KNQ9XvvXNS8/hES8mEFwnz+Ne25aHAw794Z+9oMYem49sSNY8rkVyfTfI8A2A3188
 TywOl73c/t1RNnLqrvQYq226VrdewLgd6AaHvOzejK+BHwUOI8OL71k7zIlkoW2fyPnZLYsqIS+66/
 KAp7FWzWXpfO+51hnaMIJRo6fGvXcn73LVUR+oExo3xIbwE9opKu8tv93irqLjzDjIE5+egOrBNIdf
 BWqI55Ib2NORmzfa05bH7l3MjErS7A0gRDAufHenjyV6xVQEc+xkzLx9a0X0QYq8PjGi5fOUKa9+ca
 jdFrhMs+jsCV3iyMbXa2xOXfqUtCVKor4TOPUO6o/lc4CYCIUfIfZRTysxAfyB2hp7mn6h5lab49RK
 pCeX/Tn1Mk1MvBRtd3TJR2UzE+/2hSaY8lh2Pi0Zxa2jzz1Q0P+pc0+QQAPNnB9ZZWDjZ0m51DgJ3X
 fkDmw8gqjpK+T6LiT/8GVLpdJ5PhHdDi+MfmlooHMayfI2t9Li85L9RDDKILZCR9aUO9t5RsxCVu8N
 HYmyzxXKz5+e7+YyEyWhJ03Xc1tLbKhpCIMTILDwPt5wFF+tNOifJI3+w83w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0088442efca1..518986c44880 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -21,6 +21,7 @@ Required properties:
 compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6331" for PMIC MT6331 and MT6332
+	"mediatek,mt6357" for PMIC MT6357
 	"mediatek,mt6358" for PMIC MT6358 and MT6366
 	"mediatek,mt6359" for PMIC MT6359
 	"mediatek,mt6397" for PMIC MT6397

-- 
b4 0.10.1
