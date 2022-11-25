Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61D4638D27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKYPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKYPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70227CFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso5729687wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=0xyqcEpuVWgMhJdQBmHRgrTlIlTsFE2Q2Xx8JlNh56g/UJIDWGlzJJjRwuP3+kBqSb
         ZgJygCEEOXr3wQwh28ucV/JjIWdA63d95erRyvaSQFLbaWaE4zK81qtuaDz6v+Kr3J3A
         ul9Kpu1FSO076KzITtA019P/YedmI2jSTBr1g48wHivOwRw+K57V21OrSavoqVu6PYkx
         55KNqf8DCFCvSrrEmQVyILU4VqZZ5tXWPipkQc8RxKN1RGnLypHT2bSrh9MzKeRLHjHf
         jqIqgRRptD7nHiS+o8lQ37RRuHwzLbVo4VfjbQ/AATlG5HWUQ52Vzh4NoEcpz43tGc/K
         XccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=55g9zlwiS0WxRJo6tjOF4et4+72TB9w0647RTuukF4HhodhG0gRYYddcbFhWKxm5/v
         mnMFtx0kOle2mqMZT4L5mK46lrrXwJ/I+wiCdQEVVPObczEmnB4YDbRm0X6Jj+kzRKSA
         4yTcqwIw5EwgQ5pRK1OvR+wXbNJpbiRv3LIiZY15/CRKvS57UGRgsjFrJfzDGTXD3qA+
         LuTSgA7Guj3tomDcbrZQHrMaBld4TIbO0gl9vPBIa1rmWXv0yKy2GXjXxriO6gviJWE7
         2XuwIT3IedfwRTY1tcA+9GqiZ0WI6UarEi9u1FVabMpupfpIUqCHF6QypSZNavdu8T80
         wxCg==
X-Gm-Message-State: ANoB5pkPlyzPZ20rC9QQuc7h6Q37dB/1Bm05wTwtzPKdoC/ynChhpOpi
        9Me6qhgxp3qncfcwjOrfAnQqfw==
X-Google-Smtp-Source: AA0mqf7VRkDXdyTHraTIggF3hl4hRThRoQ1Cum5vs0jhbzwuZ51ODnL7kreNEEFypcUPiuCpJFGw0Q==
X-Received: by 2002:a05:600c:4e09:b0:3cf:55bd:4944 with SMTP id b9-20020a05600c4e0900b003cf55bd4944mr31272067wmq.64.1669389081810;
        Fri, 25 Nov 2022 07:11:21 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:21 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:12 +0100
Subject: [PATCH v6 01/10] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-1-4f589756befa@baylibre.com>
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=acIU37N8P1oQiEeAFVfuuIgjK7XT7A/zFtqy1fGJDhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsWWZDdwoLf/Rb2AU6TJp1j5Of+uaN7zUCgekqo
 ZCgL05SJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFgAKCRArRkmdfjHURa0oD/
 95wHQ5+U7hl58gSJwszReViGY6DKPWH/ihnDPhk6ryLI3o/2xnFnqVAVvNcZkKxIyXBRcnI2txdll8
 ynvVkvnt1idkQevWBMNV30PTAgH+GUjeczGTSZZLA2e0iAPomE9YoCZI2JQgYDZLmvx77dB1m+7ayz
 Qr5xRPrkEUyYJfKtFHxMN28AeMia8+0o8N/sklrrj+1kPzFYub/LdhWGegOlV6D6MjVsfrCOhDFxts
 xgVeutSlAD4YlRmGvdGYirXOgqow21qIxkZkHidLJl3aEDx/9AAgreME6ARMXq1qsUu/9hsvS5S4sP
 tsRirbSAOaffwLolt4/RxvBk8j6G3yZAHIVwZQ6YEWZqS6jJh7Lhyho2/Pnm/xbx+ZLUf91zuNj3qs
 uUObedBl1h3FzF3fi8LFkc9zOVjVFUmkut18bgX5swXkCD8AxqX7WuaBFlW/rmzAF3Sq3Ibx3Wo5W6
 ZGTMjv9e4smBWFkodhGM7Yg0pPgYF19EINb3CScsPvlWS6X01mq5aIQOS4QXtz4YeFh+2O7b2i/5O1
 IyOB+/I8l9ft1cnu77UiIBHPjupGODDILzv2nzNXJcwf4thOr2wGKl/y7T0K05IB9ez8mvX4pr6crr
 Ozd7qR/UGNVRgAqDqxTbsArppi3rLfWempLVRSwW4f8J7uMSHPpkob6GBVkw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
