Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD36065AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJTQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJTQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:21:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4611BA1E3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so35482600wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ggl5GnJW5r8zpcno8Bg7VatgVa63OuBazQq9en4f4Q=;
        b=vLTlwUnpIWIwuvgi0iyBzDgogj1smwA6hhFgkNvK1JQ5gnNPG3XeP5FaxtLrguiiUI
         yuymHez2yeU703/Gjhglf/3/sijnGdCsN+WIyQt514KEm3HfrfDOnmUt2Evo0ez2pt3V
         BXp/ighRuejFCYjQiAT05SPZiV+7IrxKHh96ZFXjRzhohOAOcPpHi/scyWj0Iyp365+0
         jKxiPxuoFGS1Z/g0d9sCsq5M2fObmFAD+CFgiK2uJ0p+elwWT8P2+ECMzQxeclCPkuyd
         w8GDrWTdqzpFkBBguosfVea6TmJ8aNiuiG3WFo5fSAzdp/+EVdDo7GkaCYQRZ013tg7T
         1piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ggl5GnJW5r8zpcno8Bg7VatgVa63OuBazQq9en4f4Q=;
        b=neDf5sr4Y0pacpsmpOlAE5/QDQvek5t8fxeeyPQFvcZgxcV5jgXZZtB0I0djSPhJN/
         ETSNqDDS9ShEg5rGtyi79HZX5UCWjVMsKzQkxd2XyvXObHrhPkiz+t+fWSnCScX/emrP
         dvfN10bmop6zgr73Rw4vTcUKHmlFBCFHQ0CiZs3WEEfTAfNRDFbW5eo/kc9frKc8bayV
         Y2PhwHaFCmiwc2wKx9Rq8Ht+V0RmANi04V1cYviVnz8YsAgn181S/eRDIbmH4i49UoO8
         s3PqqO6SM00hhxW73SHPpDo6IISqAbAS3EolgMSXOYd1HrfpiHZlkOEFXM7NSHxAjZEE
         tmBQ==
X-Gm-Message-State: ACrzQf0b/LnLeefj6/3h4vBhd88fP4TXdW1EM6XFCMrKOsy6rVy+niZ6
        dcc7kw/q04qdOxeR6igabDSubg==
X-Google-Smtp-Source: AMsMyM4LQ/lxoEIrH4UMCDFt1jKZSgIbbOISLRtCxbzdlIaBowCjGyQBQrDj/m1gYIMGc+i23FCohw==
X-Received: by 2002:a5d:5084:0:b0:22e:2f15:b521 with SMTP id a4-20020a5d5084000000b0022e2f15b521mr9753215wrt.271.1666282871926;
        Thu, 20 Oct 2022 09:21:11 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c3b0e00b003b4fe03c881sm208028wms.48.2022.10.20.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:21:11 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 20 Oct 2022 18:20:46 +0200
Subject: [PATCH v3 2/5] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v3-2-7e0bd7c315b2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ZkZQij7/0Z3X4e9uF6B+oZckE7xcogOJfck3q8uBCAI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUXV0ZNXXgbhkdAz1a55MOKc3KBoIZOBnUZ+E6y1y
 JpYKd/SJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1F1dAAKCRArRkmdfjHURcv3EA
 CycWh0zpHUbo0QCMDsyag2SfUDfWm7eNlPNHiLaKRoRrhUeE+UqeevDHVNlTozvLo0kXuCbRjEP2hy
 ZUNh5+mCUEdLGEDOMprZ7XGAd/+K7t2bxtDY3FIWvGb8YH3AXaGl8G3/PFUf7iKKtQlcRoCCa91gmu
 bVHu0Wf5ldEGvH351G2QGfvAr3PDibh+11F1Vf8v9f8r1tpBAVQr+N3PhQ4oo73rL3Et1d4BIuhuv6
 qZXnNERdqshdBWa20jHiLrTwNWPcEp2cD4n+O3ThRJ0QBLkg0eUupn+RzwkoGJxABAvKQA/NdDQcG2
 VrM+CEUIvJDE6F8PdJ1T4nXVflxMVj7auEXljbGNmbIii2ZEFBIf8mV7OMJOdd3sW+MLyhMIk3jFI9
 HvEKE2gny3luDvml5/Xiku7YydL3dxMY9aYW33LQhsrXQi4E+kCIREhSp2V4P787KCshWfwOABQtRt
 D3ZXVgSpcv37zt6NUIFhrlF+rpjdmudKWkGmzQ/YoUoCj03FESVcllQIti11iAHW+z8TRJyEBRXL1N
 h0eBNbYo+C5SvCDFQJNp2MohOakK8eCFPM8SxJofKIoijZmr/UlicMkewYYERvs/CVbW/QSJLSdm5P
 9UWhvEfjmn/4m4G4nCOgJjHgjFB58R1kaG1iqdro4xI+6xN4jAoMXlmoxMvg==
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

Add binding documentation for the PMIC keys on MT6357.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 2f72ec418415..037c3ae9f1c3 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - mediatek,mt6323-keys
       - mediatek,mt6331-keys
+      - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 

-- 
b4 0.10.1
