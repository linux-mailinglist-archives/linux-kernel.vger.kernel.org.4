Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D635B5071
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIKR6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIKR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 13:58:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D51AD9A;
        Sun, 11 Sep 2022 10:58:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so9738957edj.3;
        Sun, 11 Sep 2022 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=HxRei77Xp8obrUM8ZKH0UQc8VS1BrZDO+yvP75r8n8Y=;
        b=LNVxR1Dl3mdJNHZ6NRC5n4+AdHrxMiNdTjYO0xPECVmNAbS2r4XUNLYwNFrBIVlefq
         ZLV4bnC8XkJYyNzaiSTk9bJzQRmfiZiSSSYjyg9fDyjdWHQElXmw2XsZGrieVJetsBDA
         kTk4x6hjbH63kSNKYf29uWIH0KnF5cqsvbTsaYF89AY5ZvIndt+KHViZbzXRt1mtweyu
         9X3mqEPaA2np+cAUqFmjAyk/aBXHZ9o9VIvaQ056C2pbQ0tjhozAQz2qsPBuETn8SjbH
         VsWX1V2boT/Wl+WxxndsmEX7giquAllWLg63ocX3JJEHTP5uInkvvQszSI7+jdEETzkE
         pg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=HxRei77Xp8obrUM8ZKH0UQc8VS1BrZDO+yvP75r8n8Y=;
        b=fPvIqzlbMMxLO79jZqY8jIF91ITqkGJu4xX2a/3TWMuK0hb5dHvvbU6HAcRw8DAo1U
         xYUUuZ0yVOE1t6pFWkD88PEqGsvwPnvMa7QJoT3X+lscQhkC7cP1r94DRVRkKSV4dQWj
         xSWHiLA/8S58hEws/qF+eGPbgKQwtz67qfVoYA55FKVIlM5vMmFcNLelCzZyW9W+enNP
         3kN0LbMQOzjGXBtITxGV7kw2fz7rHGeOTYqxtQK3Goh/FbTDpjD6aJd8ArCyK7FbsEtt
         SKPVlha6upyHdmDytqFF2ftKDz8+4zFgMNSVqmv5nENNN2FRVX0RQH5iBVXDqSPvbZT7
         RQKA==
X-Gm-Message-State: ACgBeo3C1Wlzt2iSu58vv7No3Ho7AhPL736bodTzmwmCBBSgmej6rMC2
        nTGeoRnENNyUlCMCFrV+GAY=
X-Google-Smtp-Source: AA6agR5Y2+l6SqfFS/nrVWrI/d8uzaeNYAGgi3ptnWeCv2FCpvhUWD9McTtnUfb599zcYZsKvTF1TA==
X-Received: by 2002:a05:6402:1f86:b0:447:8edd:1c4b with SMTP id c6-20020a0564021f8600b004478edd1c4bmr19078351edc.163.1662919121378;
        Sun, 11 Sep 2022 10:58:41 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b00730b61d8a5esm3243305eju.61.2022.09.11.10.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 10:58:40 -0700 (PDT)
Message-ID: <12af4fe6-4d35-cb4a-f5f6-06e3aba990cb@gmail.com>
Date:   Sun, 11 Sep 2022 19:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] dt-bindings: spi: rockchip: add power-domains property
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip rk3399 TRM mentions that pd_sdioaudio includes
sdio, spi, i2s and spdif. Add a power-domains property to
to match reality with spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changed V2:
  Fix comment
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 52768894b..66e49947b 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -82,6 +82,9 @@ properties:
       where the "sleep" configuration may describe the state
       the pins should be in during system suspend.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.20.1

