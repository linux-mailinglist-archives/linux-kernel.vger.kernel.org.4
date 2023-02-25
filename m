Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA46A28E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBYKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBYKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:17:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA822A09;
        Sat, 25 Feb 2023 02:17:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so7027262edb.1;
        Sat, 25 Feb 2023 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZlTyV5gXSWpUhRTyRZWDDfy9ZYKtV/X37QY0RZg8Qc=;
        b=lfNgoABENzvAU9vbrDDeIhipKTEOAzm+1ypKOJOfED6srDbCB+THw/3/nsmJfXTk+j
         9P6wrt3CNxTndnx7wHv4EdutmhyRy9bhOllkOpgCzTtmqKtTeLKYKNFTAO/lzDwr0rvV
         5fNGKbXpqTyeAT6OfF0478xebq52pK+D2jLjHaAYhrzOtfwr9KmAVEpQ6P6rLZLiTQ+v
         ujdYh5GrtEimemw1iBAfWwk4Uust9HsNXs7fPaGz3xFG7xwWV0u0x3nr7A0Zt5fuc/2Z
         HLa3y2auSiKZvwbHDAAm+EvVu1Q9dQiEsRx7hRcSmlgbiDVfCqG1faAQZaSpXs5nDp0J
         zWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZlTyV5gXSWpUhRTyRZWDDfy9ZYKtV/X37QY0RZg8Qc=;
        b=NTo8cb9S3Eplg2aWBTtgH8KPU0Bt2Az1lzItm2RP+grLmNJOBK/YrHRqI2912sPjHx
         c/FoM7OahudtumC1FQ7ZI89OYKISbhs81v++DVOVKuMH0zxAkGNp7JP4c1Zy+rHjRKnm
         8EEfxwQ+4n2qJECKYDeD8FqKBnwqNPYkX6PGQnqDRKHOoLiwqr4v1jHYJhVeZf7QK/lM
         WE6rqihZTfhlcJ9Lon/BO9rZJTJ/Q9gtooqdO8L3f2yVwkJSrM7ipY7lic1DbcPHylFL
         mP+EAkzaVeDtQcA62WVZyNOq77HhR8RU7bUJxyuxKnwXZCW4AyoyXFrvAwEGR2xDl0ll
         KyEQ==
X-Gm-Message-State: AO0yUKW6iIcxCqK7DC+3IDfv7k7NGEGX/ZOQWMz0EE9INYG/h3JC/XD3
        PAsIKMG5xapLQ7fbXR8pROY=
X-Google-Smtp-Source: AK7set+p80yxwive0vFrfuDaRCkLAO2YhJ0YF72bVGf3x/DXOphxfSCDrLe8RInslHnX6xHo8AlhOA==
X-Received: by 2002:a05:6402:845:b0:4a3:43c1:8431 with SMTP id b5-20020a056402084500b004a343c18431mr3099829edz.5.1677320232660;
        Sat, 25 Feb 2023 02:17:12 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004af6163f845sm677722edi.28.2023.02.25.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 02:17:12 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: soc: mediatek: scpsys: Document MT6735 SCPSYS compatible string
Date:   Sat, 25 Feb 2023 13:16:28 +0300
Message-Id: <20230225101629.264206-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225101629.264206-1-y.oudjana@protonmail.com>
References: <20230225101629.264206-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a compatible string for MT6735 SCPSYS.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 2bc367793aec..54ba2e06403a 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -10,6 +10,7 @@ domain control.
 The driver implements the Generic PM domain bindings described in
 power/power-domain.yaml. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
+- include/dt-bindings/power/mediatek,mt6735-scpsys.h
 - include/dt-bindings/power/mt6797-power.h
 - include/dt-bindings/power/mt6765-power.h
 - include/dt-bindings/power/mt2701-power.h
@@ -20,6 +21,7 @@ Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt2712-scpsys"
+	- "mediatek,mt6735-scpsys"
 	- "mediatek,mt6765-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
-- 
2.39.2

