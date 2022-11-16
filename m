Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E062BDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiKPMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKPMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18062EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so29457027wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=N5Qau5w1q+ta61PU32aq1W73jjurOXJ7QB6mrINGYz8JGlm7YiHbNptMvdBvqyRHpX
         x2aQGDSwWKSmQfRP+1rZuZihXc+ctqJZjh7TRzPAuFMQUXGwBBHIZpXe+daPtxGGBQD7
         auWFcoNf2jUTB/SKk1melaNMZbVvhAFxmtq/3Y/uVeCUQ2t+HI/0LbrsRZPtmB4PcP82
         O95MxLH8nqchV2YlDgvWs0sHxoA3P+xTWRFvuLV5uZQbahhF1huH9GoOu3R/0szwDmu7
         l9fY17ZUursXayRKgsiRVc8NzZJzgfQ+NL+zXgPzv3c3zJ7cYeDn1Wt7TZ26AGyD7lyD
         7MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=L5pJKHZn1j8XkOmE8/R3iPxfylNa8yIz2n9BUU/dky/HrZjBg6FV0a2PueYGyRlqq9
         dczq6KE+o6wg0iM7RMM4PbuBJVs8t4+cGdB8obNk1tShhSMKeLgmYLq9hhQ94j3aAGUZ
         65Bven7BqQWwSEU8rhdYfKQHJHQmFFxDPGq2pBntah7bw00kDYqeqh4Wa03zqgC1LH0+
         vWuUtKfdSaNry5t3aHEfT4sNgl+7WlCxv0q2LIkVo8QJMBUJMneOOCqUJof06ykDM/KD
         iHxgkIcbOWOxqFp6+fH37xwhPQSEtEmh5sefuuMVl79TBTvE0lx52/W8yxH6WjIbl4cM
         atrg==
X-Gm-Message-State: ANoB5pmQLcuksF90olWvp8yEEOXQ2vHPq8/xrhIA6eIE7gFafEV+IZpJ
        ltWzGXjvYg2RoimEIUv+SLVtsA==
X-Google-Smtp-Source: AA0mqf6y5ltxqD503f540II09FLjpO4HvSCV9W2mYXH6FjVOTyPqmzQUiAKRkAHEnyXIdbgVMduGZA==
X-Received: by 2002:a5d:6885:0:b0:22e:3460:5e28 with SMTP id h5-20020a5d6885000000b0022e34605e28mr13894652wru.211.1668602017069;
        Wed, 16 Nov 2022 04:33:37 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:36 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:32:55 +0100
Subject: [PATCH v5 01/10] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-1-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=acIU37N8P1oQiEeAFVfuuIgjK7XT7A/zFtqy1fGJDhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNieji5otehDDxz/kRWwqw1b5mYJLkZ5CQYL7Two
 eWQWJrCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURXutD/
 0X4V7TScc9d20t+Fd8nUv2ogeANV+FtdcuYX3ygHTbNVDlJTe7pA+APbUcmqoNUrEkq82GPT5o3XsE
 9lAwSf/zWJv+7/Rb21k9ivYWGnwlIbvg53nx1ScopyptvXvNICPnjEwluUvQ524y7JPkfglAM85i5i
 yJZ2jg4sUW7wzXgLt+IoDRDaHHk8rI8BBZMg8xsTzsZbtkBrC10fP5rytGzX0YIDkl0mtwpZRvaozo
 3CN4Z6RnNgbcDQR9NY4wgG5hzAwx9DyDfci0Onyd9tpr+9racXGv0XwDnlUepG4yaoOfrJNJAfGs3U
 Qqnzc4gN9Tc1Dcis9kdovEunAT6Sx92AcuEbHa1R55+ZdaIPNk2P0qfRbSgCHldzjdq9DhHq+91E8A
 UfnNCdyFALC+4bbTYijjJmO2u8w8rLXu5F65ZPm0J2YCpvgOGnS6X+kYEcAjYsZ0x3TBajjW2nm1K4
 yVEA413D3P5++OsviP3XWL429+udy5OQJujDRs27/KMwzinzP16v85ALwRDWf4sryDFoD+/eiJuYsp
 ZhLU4xNvFgdUKk418lWwjbFq1gtehDgeCsh0fy7DIseVgqo2CVcWRvZ2Uafyd2U5evgT7s6Xv9c3zq
 yH/Faki6mlcheo9kDT3+GNZX2iA8qru0VdIiRxCf9Idy1wmL5ui1lKwYO9Jg==
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
