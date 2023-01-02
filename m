Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965C65B512
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjABQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjABQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5EDF5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id co23so26699785wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=DYBB+eO5TJw810S2GfO4VDKyg09GvKexUGZ5EShT5lsQarhuAX5y810FMN6+PQKZtt
         f25CBQ33/Oe/HGJ8hluE4/26J3mk/wXhSVoGwBqoEcG49cBdtQQ1/X0v2o53RlCwNc0x
         fEo60GQDFHQ9YQi4XkAN1h85B+2XRqWJXUaqhocDl6l6uqWj4LBbD2MoZtzuNwI5Sy1m
         atbsUh47G8VXLb2m4O+FkIma1KraSz2xiwGz8kRXEqlwRusjyCod8oKG0QxX9SUu5/JH
         AnWRcouBMuTqjZUA1gNYiiIRhLA8Bz32TgO2if/FG829FULxFyi/hPXit5b1UhG/6pUF
         I7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=UBtMrXfGs7ocZqBb2/xH/8dPE0U+JPZZM8wkjGa0BtvmOm6kWjkwUhyfQJQJVgL3Yq
         HPCqpC46X5MYgelDiDrjjWNuvIfr1INv2xCZ5r29IDLf7zXXhowSgM/SQtG9LTIUtMPQ
         bUuU5Oda+yK9h2osrz8YDNBT+pHLz/L51Hp9eeQh3yWf3qVLi1fxLCseSug1r3Ll6Ijp
         +j121LlzU01f17n0H7toQ/fccWOsAxy/Ff+dhjyUBc8dpIQtuX2GaSS2IvDzUXJJe18X
         3pz9e+iNvQeAXXrxpKXvM0HRbp6bRj+ygfCQWmekkObrpDnyvuWIPyBuloVytyeKzNBS
         YSkA==
X-Gm-Message-State: AFqh2kq8UCdMqdKNpHBe745Q1uGFYHOlG7m9czuuxhNd6MoDAgAoBFND
        UrAlBgEWFKE0Z7C/O4W5JbDqcw==
X-Google-Smtp-Source: AMrXdXtpGdYxEH97hoopGDFiS2NRpY9XAurXyiQcxxBvFbsJM6oJ3LxD9eaF4TJFljPxdyl2RXIvCQ==
X-Received: by 2002:a05:6000:1f14:b0:242:5a34:fb7b with SMTP id bv20-20020a0560001f1400b002425a34fb7bmr25842859wrb.70.1672675584145;
        Mon, 02 Jan 2023 08:06:24 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm11868020wrs.33.2023.01.02.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:06:23 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 02 Jan 2023 17:06:02 +0100
Subject: [PATCH v8 1/6] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v8-1-560caaafee53@baylibre.com>
References: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v8-0-560caaafee53@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=acIU37N8P1oQiEeAFVfuuIgjK7XT7A/zFtqy1fGJDhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjswD8/dmSbDHXT0RPN/nBYhd5ARuFoEmUA2rEl4oh
 l6sU6ieJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY7MA/AAKCRArRkmdfjHURdB8D/
 4rcsQLX8aNJdUgxyojMErzvCfM9FymMgsIZSBiIjIM0Gf4DsAuCQDVLUpuhSA931Mkd7z9STLcyKxE
 t2D5p13JdGitxfTdFVvunXRokM3IxF+i3lP3yX1LT5+wNXjcdD6yh/H5BzAS6yncncuiyTXMW09Qh/
 s22ByxFif6nNybNM64cJTcg3TF1wRyODDN+Dyf/cNw+XPSzlhs42NY8VEzzRrTtc0XPlInSWm5veuP
 VyaezR067LxlNe5Er0io+4jeDKWLDz7FbQ2SV51GN6Jt8xwWa6KbhlS0S/8QREs13F1cIZKnQzbB+G
 fdqQXfippFvt3IVl6dht4j66HD3x3YSp8JbKsNEMjQSKLNAdT8rqvvJedaaiUICE3B9K9/sKAlYNy7
 FKyiZwI3YlPYi+fdICAJ/p7EQllFU1x4RHhJ7G6HKxcHSbb6wLQPvJ+mtNefVW/8V3m12cX0gEna5p
 KhYCy+mZLKoXUv0OjapoEZme06jfwGHXiWuViyhHApOn3T4f5n0qoCgSvE66bwoHH8AnIKFfjNUAmn
 mrRkeHWN+wzS2/NEqc1vUh8bRaWeRmGmzqWOri+wZ2rgpv6XOsnCYLaLToN6wLZAtnF4eQ0eQhdZph
 jd2+RYrLepsIOxD5PJ18bzzNOBL7DYEn+ZGbs/msNLR1VOYUeKYUUkrjOBvg==
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
